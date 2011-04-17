//
//  Product.m
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "Product.h"
#import "ProductCache.h"


@interface Product (Private)

- (void) deleteAllFromDatabase;

+ (NSString *) newStringInBase64FromData: (NSData *)data;
+ (NSData *)decodeBase64WithString:(NSString *)strBase64;

@end


@implementation Product


#pragma mark - Synthesized properties
@synthesize idProduct = _idProduct;
@synthesize name = _name;
@synthesize price = _price;
@synthesize image = _image;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize address = _address;

@synthesize delegate = _delegate;


#pragma mark - Init object
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}


#pragma mark - Memory management
- (void)dealloc
{
    self.name = nil;
    self.image = nil;
    self.address = nil;
    
    [super dealloc];
}


#pragma mark - Private class variables
static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short _base64DecodingTable[256] = {
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
	-2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
	-2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};


#pragma mark - Public methods
- (void)saveRemoteToServer:(ServerData *)server {
#warning 'postPath' could be asynchronous
    if (!self.name) {
        NSLog(@"saveRemote :: Error :: No name");
    }
    else
    {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        NSString *imageBase64 = @"";
        if (self.image) {
            if (server.allowPhotos) {
                NSLog(@"Convert image to Base64");
                NSData *imageData = UIImageJPEGRepresentation(self.image, 0.0);
                imageBase64 = [Product newStringInBase64FromData:imageData];
            }
            else {
                NSLog(@"Server %@ not allow photos", server.name);
            }
        }
        else {
            NSLog(@"No image to convert to Base64");
        }
        
        NSLog(@"Prepare options");
        NSDictionary *params_product =
            [NSDictionary dictionaryWithObjectsAndKeys:
             self.name, @"name",
             [NSNumber numberWithUnsignedInteger:self.price], @"price",
             imageBase64, @"imageAsStr",
             [NSNumber numberWithDouble:self.latitude], @"latitude",
             [NSNumber numberWithDouble:self.longitude], @"longitude",
             nil];
        NSDictionary *params = [NSDictionary dictionaryWithObject:params_product forKey:@"product"];
        NSDictionary *options = [NSDictionary dictionaryWithObject:[params JSONRepresentation] forKey:@"body"];
        
        NSLog(@"Uploading ...");
        [HRRestModel setBaseURL:[NSURL URLWithString:server.address]];
        [HRRestModel postPath:@"/products.json" withOptions: options object:nil];
        NSLog(@"Ended");
        
        [pool release];
    }
}

- (void)deleteRemoteFromServer:(ServerData *)server {
    NSLog(@"Sending DELETE request");
    [HRRestModel setBaseURL:[NSURL URLWithString:server.address]];
    NSString *path = [NSString stringWithFormat:@"/products/%i", self.idProduct];
	[HRRestModel deletePath:path withOptions:nil object:nil];
}

- (void)refreshFromSerer:(ServerData *)server {
    NSLog(@"Deleting all products in database");
    [self deleteAllFromDatabase];
    
	NSLog(@"Sendig GET request");
	[HRRestModel setDelegate:self];
    [HRRestModel setBaseURL:[NSURL URLWithString:server.address]];
	[HRRestModel getPath:@"/products.json" withOptions:nil object:nil];
}

#pragma mark - HRResponseDelegate methods
- (void)restConnection:(NSURLConnection *)connection didFailWithError:(NSError *)error object:(id)object {
    NSLog(@"Failure to connect to the server");
    [self.delegate useProductsList];
    [HRRestModel setDelegate:nil];
}

- (void)restConnection:(NSURLConnection *)connection didReceiveError:(NSError *)error response:(NSHTTPURLResponse *)response object:(id)object {
    NSLog(@"Invalid response");
    [self.delegate useProductsList];
    [HRRestModel setDelegate:nil];
}

- (void)restConnection:(NSURLConnection *)connection didReceiveParseError:(NSError *)error responseBody:(NSString *)string {
    NSLog(@"Can't parse the data returned");
    [self.delegate useProductsList];
    [HRRestModel setDelegate:nil];
}

- (void)restConnection:(NSURLConnection *)connection didReturnResource:(id)resource object:(id)object {
	NSDictionary *dicProduct = nil;
	ProductCache *cacheProduct = nil;
	
    NSString *oneProductId = nil;
	NSString *oneProductName = nil;
	NSString *oneProductPrice = nil;
    NSString *oneProductImage = nil;
    NSString *oneProductLatitude = nil;
    NSString *oneProductLongitude = nil;
    NSString *oneProductAddress = nil;
    
	NSLog(@"Request received");
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	if (self.delegate != nil) {
        
		for(id jsonNote in resource) {
            
			if (![jsonNote respondsToSelector:@selector(objectForKey:)]) {
				NSLog(@"Object <%@> doesn't respond to 'objectForKey:'", jsonNote);
			}
			else {
                
				dicProduct = [jsonNote objectForKey:@"product"];
				if (!dicProduct) {
					NSLog(@"Unknown object received <%@>", dicProduct);
				}
				else {
                    
                    NSLog(@"Product received");
                    
                    /*
                     Create a new instance of the Event entity.
                     */
                    cacheProduct = (ProductCache *)[NSEntityDescription insertNewObjectForEntityForName:@"ProductCache"
                                                                                 inManagedObjectContext:self.delegate.managedObjectContext];
                    
                    
                    oneProductId = [dicProduct objectForKey:@"id"];
                    if (oneProductId) {
                        cacheProduct.idProduct = [NSNumber numberWithInteger:oneProductId.integerValue];
                    }
                    
					oneProductName = [dicProduct objectForKey:@"name"];
					if (oneProductName) {
						cacheProduct.name = oneProductName;
					}
                    
                    oneProductPrice = [dicProduct objectForKey:@"price"];
                    if (oneProductPrice) {
                        cacheProduct.price = [NSNumber numberWithInteger:oneProductPrice.integerValue];
                    }
                    
                    oneProductImage = [dicProduct objectForKey:@"imageAsStr"];
                    if (oneProductImage && [oneProductImage length] > 0) {
                        cacheProduct.image = [Product decodeBase64WithString:oneProductImage];
                    }
                    
                    oneProductLatitude = [dicProduct objectForKey:@"latitude"];
                    if (oneProductLatitude) {
                        cacheProduct.latitude = [NSNumber numberWithDouble:oneProductLatitude.doubleValue];
                    }
                    
                    oneProductLongitude = [dicProduct objectForKey:@"longitude"];
                    if (oneProductLongitude) {
                        cacheProduct.longitude = [NSNumber numberWithDouble:oneProductLongitude.doubleValue];
                    }
                    
                    oneProductAddress = [dicProduct objectForKey:@"address"];
                    if (oneProductAddress && (oneProductAddress != (NSString *)[NSNull null])) {
                        cacheProduct.address = oneProductAddress;
                    }
                    
				}
                
			}
            
		}

        NSError *error;
        if (![self.delegate.managedObjectContext save:&error]) {
            NSLog(@"Error saving data downloaded from server <%@>", error);
        }
        
        [self.delegate useProductsList];
	}
    [pool release];
    
    [HRRestModel setDelegate:nil];
}


#pragma mark - Private methods
- (void) deleteAllFromDatabase {
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *productDescription = [NSEntityDescription entityForName:@"ProductCache"
                                                          inManagedObjectContext:self.delegate.managedObjectContext];
	[request setEntity:productDescription];
    
	NSArray *fetchResults = [self.delegate.managedObjectContext executeFetchRequest:request error:nil];
	
    for (ProductCache *cacheProduct in fetchResults) {
        [self.delegate.managedObjectContext deleteObject:cacheProduct];
    }
    
    NSError *error;
    if (![self.delegate.managedObjectContext save:&error]) {
        NSLog(@"Error deleting all products from database <%@>", error);
    }
}


#pragma mark - Private class methods
+ (NSString *)newStringInBase64FromData: (NSData *)data {
	NSMutableString *dest = [[NSMutableString alloc] initWithString:@""];
	unsigned char *working = (unsigned char *)[data bytes];
	int srcLen = [data length];
	
	// tackle the source in 3's as conveniently 4 Base64 nibbles fit into 3 bytes
	for (int i=0; i<srcLen; i += 3)
	{
		// for each output nibble
		for (int nib=0; nib<4; nib++)
		{
			// nibble:nib from char:byt
			int byt = (nib == 0)?0:nib-1;
			int ix = (nib+1)*2;
			
			if (i+byt >= srcLen) break;
			
			// extract the top bits of the nibble, if valid
			unsigned char curr = ((working[i+byt] << (8-ix)) & 0x3F);
			
			// extract the bottom bits of the nibble, if valid
			if (i+nib < srcLen) curr |= ((working[i+nib] >> ix) & 0x3F);
			
			[dest appendFormat:@"%c", base64[curr]];
		}
	}
	
	return [dest autorelease];
}

+ (NSData *)decodeBase64WithString:(NSString *)strBase64 {
	const char * objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
	int intLength = strlen(objPointer);
	int intCurrent;
	int i = 0, j = 0, k;
	
	unsigned char * objResult;
	objResult = calloc(intLength, sizeof(char));
	
	// Run through the whole string, converting as we go
	while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
		if (intCurrent == '=') {
			if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
				// the padding character is invalid at this point -- so this entire string is invalid
				free(objResult);
				return nil;
			}
			continue;
		}
		
		intCurrent = _base64DecodingTable[intCurrent];
		if (intCurrent == -1) {
			// we're at a whitespace -- simply skip over
			continue;
		} else if (intCurrent == -2) {
			// we're at an invalid character
			free(objResult);
			return nil;
		}
		
		switch (i % 4) {
			case 0:
				objResult[j] = intCurrent << 2;
				break;
				
			case 1:
				objResult[j++] |= intCurrent >> 4;
				objResult[j] = (intCurrent & 0x0f) << 4;
				break;
				
			case 2:
				objResult[j++] |= intCurrent >>2;
				objResult[j] = (intCurrent & 0x03) << 6;
				break;
				
			case 3:
				objResult[j++] |= intCurrent;
				break;
		}
		i++;
	}
	
	// mop things up if we ended on a boundary
	k = j;
	if (intCurrent == '=') {
		switch (i % 4) {
			case 1:
				// Invalid state
				free(objResult);
				return nil;
				
			case 2:
				k++;
				// flow through
			case 3:
				objResult[k] = 0;
		}
	}
	
	// Cleanup and setup the return NSData
	NSData * objData = [[[NSData alloc] initWithBytes:objResult length:j] autorelease];
	free(objResult);
	return objData;
}


@end
