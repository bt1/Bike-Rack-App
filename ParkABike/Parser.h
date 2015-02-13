//
//  Parser.h
//  ParkABike
//
//  Created by Benny Tan on 1/19/15.
//  Copyright (c) 2015 Squarevibe Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSXMLParser

@property (nonatomic, strong) NSString *rowElementName;
@property (nonatomic, strong) NSArray *attributeNames;
@property (nonatomic, strong) NSArray *elementNames;
@property (nonatomic, strong) NSMutableArray *parseItems;

@end
