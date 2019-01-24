//
//  MPTableViewCell.h
//  NetworkingDemo
//
//  Created by David Mills on 2019-01-24.
//  Copyright © 2019 David Mills. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Representative.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPTableViewCell : UITableViewCell

@property(weak, nonatomic) Representative *rep;

@end

NS_ASSUME_NONNULL_END
