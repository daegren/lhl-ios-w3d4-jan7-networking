//
//  MPTableViewCell.m
//  NetworkingDemo
//
//  Created by David Mills on 2019-01-24.
//  Copyright © 2019 David Mills. All rights reserved.
//

#import "MPTableViewCell.h"

@interface MPTableViewCell ()

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *emailLabel;
@property(weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation MPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

  [self addObserver:self forKeyPath:@"self.rep.image" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
  [self removeObserver:self forKeyPath:@"self.rep.image"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  if ([keyPath isEqualToString:@"self.rep.image"]) {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      self.photoImageView.image = self.rep.image;
    }];
  }
}

- (void)setRep:(Representative *)rep {
  _rep = rep;

  self.nameLabel.text = rep.name;
  self.emailLabel.text = rep.email;
  self.photoImageView.image = rep.image;
}

@end
