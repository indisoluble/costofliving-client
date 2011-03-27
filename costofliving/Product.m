//
//  Product.m
//  costofliving
//
//  Created by Enrique de la Torre on 27/03/11.
//  Copyright 2011 Enrique de la Torre. All rights reserved.
//

#import "Product.h"


@implementation Product


#pragma mark - Synthesized properties
@synthesize name = _name;
@synthesize price = _price;

@synthesize delegate = _delegate;


#pragma mark - Public methods
- (void) saveRemote
{
#warning 'postPath' could be asynchronous
    if (!self.name) {
        NSLog(@"saveRemote :: Error :: No name");
    }
    else
    {
        NSLog(@"Prepare options");
        NSDictionary *params_product = [NSDictionary dictionaryWithObjectsAndKeys:self.name, @"name", [NSNumber numberWithUnsignedInteger:self.price], @"price", nil];
        NSDictionary *params = [NSDictionary dictionaryWithObject:params_product forKey:@"product"];
        NSDictionary *options = [NSDictionary dictionaryWithObject:[params JSONRepresentation] forKey:@"body"];
        
        NSLog(@"Uploading ...");
        [HRRestModel setBaseURL:[NSURL URLWithString:@"http://stormy-rain-800.heroku.com"]];
        [HRRestModel postPath:@"/products.json" withOptions: options object:nil];
        NSLog(@"Ended");
    }
}

- (void)refresh
{
	NSLog(@"Sendig request");
	[HRRestModel setDelegate:self];
	[HRRestModel setBaseURL:[NSURL URLWithString:@"http://stormy-rain-800.heroku.com"]];
	[HRRestModel getPath:@"/products.json" withOptions:nil object:nil];
}

#pragma mark - HRResponseDelegate methods
- (void)restConnection:(NSURLConnection *)connection didReturnResource:(id)resource object:(id)object {
	NSDictionary *dicProduct = nil;
	Product *oneProduct = nil;
	
	NSString *oneProductName = nil;
	NSString *oneProductPrice = nil;
	
	NSLog(@"Request received <%@>", resource);
	if (self.delegate != nil) {
		NSMutableArray *list = [[[NSMutableArray alloc] init] autorelease];
		
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
					NSLog(@"Product received: <%@>", dicProduct);
                    
					oneProduct = [[[Product alloc] init] autorelease];
                    
					oneProductName = [dicProduct objectForKey:@"name"];
					if (oneProductName) {
						oneProduct.name = oneProductName;
					}
                    
                    oneProductPrice = [dicProduct objectForKey:@"price"];
                    if (oneProductPrice) {
                        oneProduct.price = oneProductPrice.integerValue;
                    }
                    
					[list addObject:oneProduct];
				}
			}
		}
		
        if (self.delegate) {
            [self.delegate useProductsList:list];
        }
	}
}


@end
