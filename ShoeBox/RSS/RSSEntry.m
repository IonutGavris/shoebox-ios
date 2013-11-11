//
//  RSSEntry.m
//  RSSFun
//
//  Created by Ray Wenderlich on 1/24/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "RSSEntry.h"

@implementation RSSEntry
@synthesize blogTitle = _blogTitle;
@synthesize articleTitle = _articleTitle;
@synthesize articleUrl = _articleUrl;
@synthesize articleDate = _articleDate;
@synthesize articleDescription = _articleDescription;

- (id)initWithBlogTitle:(NSString*)blogTitle articleTitle:(NSString*)articleTitle articleUrl:(NSString*)articleUrl articleDescription:(NSString *)articleDescription  articleDate:(NSDate*)articleDate
{
    if ((self = [super init])) {
        _blogTitle = [blogTitle copy];
        _articleTitle = [articleTitle copy];
        _articleUrl = [articleUrl copy];
        _articleDate = [articleDate copy];
        _articleDescription = [articleDescription copy];
    }
    return self;
}

- (void)dealloc {
    _blogTitle = nil;
    _articleTitle = nil;
    _articleUrl = nil;
    _articleDate = nil;
    _articleDescription = nil;
}

@end