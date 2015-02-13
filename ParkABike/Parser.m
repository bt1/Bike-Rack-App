//
//  Parser.m
//  ParkABike
//
//  Created by Benny Tan on 1/19/15.
//  Copyright (c) 2015 Squarevibe Inc. All rights reserved.
//

#import "Parser.h"

@interface Parser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableDictionary *item;
@property (nonatomic, strong) NSMutableString *elementValue;

@end

@implementation Parser

- (id)initWithContentsOfURL:(NSURL *)url
{
    self = [super initWithContentsOfURL:url];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (id)initWithData:(NSData *)data
{
    self = [super initWithData:data];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (id)initWithStream:(NSInputStream *)stream
{
    self = [super initWithStream:stream];
    if (self) {
        self = self.delegate;
    }
    return self;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.parseItems = [[NSMutableArray alloc] init];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:self.rowElementName]) {
        self.item  = [[NSMutableDictionary alloc] init];
        
        for (NSString *attributeName in self.attributeNames) {
            id attributeValue = [attributeDict valueForKey:attributeName];
            if (attributeValue) {
                [self.item setObject:attributeValue forKey:attributeName];
            }
        }
    }
    else if ([self.elementNames containsObject:elementName]){
        self.elementValue = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.elementValue) {
        [self.elementValue appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:self.rowElementName]) {
        [self.parseItems addObject:self.item];
        self.item = nil;
    }
    
    else if ([self.elementNames containsObject:elementName]){
        [self.item setValue:self.elementValue forKey:elementName];
        self.elementValue = nil;
    }
}





@end







