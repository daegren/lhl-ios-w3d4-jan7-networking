//
//  Representative.h
//  NetworkingDemo
//
//  Created by David Mills on 2019-01-24.
//  Copyright © 2019 David Mills. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface Representative : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) UIImage *image;

+ (Representative *)fromJsonDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
