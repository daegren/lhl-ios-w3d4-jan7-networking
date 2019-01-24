//
//  Representative.m
//  NetworkingDemo
//
//  Created by David Mills on 2019-01-24.
//  Copyright © 2019 David Mills. All rights reserved.
//

#import "Representative.h"

@implementation Representative

+ (Representative *)fromJsonDictionary:(NSDictionary *)dictionary {
  Representative *rep = [[Representative alloc] init];
  rep.name = dictionary[@"name"];
  rep.email = dictionary[@"email"];

  NSURL *imageUrl = [NSURL URLWithString:dictionary[@"photo_url"]];
//   Blocks processing on the thread this runs on (VERY SLOW)
//  NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
//  rep.image = [UIImage imageWithData:imageData];

  NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
  NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    UIImage *image = [UIImage imageWithData:data];

    rep.image = image;
  }];
  [task resume];

  return rep;
}

@end
