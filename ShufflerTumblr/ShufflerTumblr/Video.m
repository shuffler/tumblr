//
//  Video.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Video.h"

@implementation Video

@synthesize posts;
@synthesize response;
@synthesize blog;
@synthesize caption;
@synthesize date;
@synthesize ID;
@synthesize playerEmbed;
@synthesize playURL;
@synthesize thumbnailHeight;
@synthesize thumbnailURL;
@synthesize thumbnailWidth;
@synthesize type;
@synthesize latestPostNr;
@synthesize postTimestamp;

-(id) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.response = [dictionary objectForKey:@"response"];
        self.posts = [dictionary objectForKey:@"post"];
        self.blog = [self.response objectForKey:@"blog"];
        self.playURL = [dictionary objectForKey:@"permalink_url"];
        self.playerEmbed = [dictionary objectForKey:@"player"];
        self.ID = [dictionary objectForKey:@"id"];
        self.date = [self.posts objectForKey:@"date"];
        self.sourceTitle = [dictionary objectForKey: @"source_title"];
        self.caption = [dictionary objectForKey:@"caption"];
        self.caption = [[NSString alloc] initWithFormat: @"%@%@%@", @"<html><body style='font-family:Lucida Sans Unicode;'>",self.caption , @"</body></html>"];
        self.thumbnailURL = [self.posts objectForKey:@"thumbnail_url"];
        self.thumbnailWidth = [self.posts objectForKey:@"thumbnail_width"];
        self.thumbnailHeight =  [self.posts objectForKey:@"thumbnail_height"];
        self.type = VIDEO;
        self.latestPostNr = [[response objectForKey:@"total_posts"] intValue] - 1;
        self.postTimestamp = [dictionary objectForKey:@"timestamp"];
    };
    return self;
}

-(NSString *)getName {
    NSString *name = [NSString stringWithFormat:@"Video - %@", self.ID];

    return name;
}

-(id)getPostId {
    return self.ID;
}

-(NSString*)getListName {
    return [NSString stringWithFormat:@"Video - %@", self.sourceTitle];
}

-(id)initWithCoder:(NSCoder*) coder {
	self = [super init];
	if(self) {
		self.type = VIDEO;
		self.posts = [coder decodeObjectForKey:@"post"];
		self.blog = [coder decodeObjectForKey:@"blog"];
		self.playURL = [coder decodeObjectForKey:@"playurl"];
		self.playerEmbed = [coder decodeObjectForKey:@"playerembed"];
		self.ID = [coder decodeObjectForKey:@"id"];
		self.date = [coder decodeObjectForKey:@"date"];
        self.sourceTitle = [coder decodeObjectForKey:@"sourcetitle"];
		self.caption = [coder decodeObjectForKey:@"caption"];
        self.thumbnailURL = [coder decodeObjectForKey:@"thumbnailurl"];
        self.thumbnailWidth = [coder decodeObjectForKey:@"thumbnailwidth"];
        self.thumbnailHeight = [coder decodeObjectForKey:@"thumbnailheight"];
        self.latestPostNr = [[coder decodeObjectForKey:@"latestPostNr"] intValue];
        self.postTimestamp = [coder decodeObjectForKey:@"timestamp"];
	}
	return self;
}

-(void)encodeWithCoder:(NSCoder*) coder {
	[coder encodeObject:self.posts forKey:@"post"];
	[coder encodeObject:self.blog forKey:@"blog"];
	[coder encodeObject:self.playURL forKey:@"playurl"];
	[coder encodeObject:self.playerEmbed forKey:@"playerembed"];
	[coder encodeObject:self.ID forKey:@"id"];
	[coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.sourceTitle forKey:@"sourcetitle"];
	[coder encodeObject:self.caption forKey:@"caption"];
    [coder encodeObject:self.thumbnailURL forKey:@"thumbnailurl"];
    [coder encodeObject:self.thumbnailWidth forKey:@"thumbnailwidth"];
    [coder encodeObject:self.thumbnailHeight forKey:@"thumbnailheight"];
    NSNumber *tmp = [[NSNumber alloc] initWithInt: self.latestPostNr];
    [coder encodeObject:tmp forKey:@"latestPostNr"];
    [coder encodeObject: self.postTimestamp forKey:@"timestamp"];
}

@end
