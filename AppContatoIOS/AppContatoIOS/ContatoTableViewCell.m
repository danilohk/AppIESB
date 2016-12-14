//
//  ContatoTableViewCell.m
//  AppContatoIOS
//
//  Created by macbook on 15/11/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import "ContatoTableViewCell.h"

@implementation ContatoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.frame = _fotoPerfil.bounds;
    
    CGFloat width = 80;
    CGFloat height = 80;
    CGFloat hPadding = width * 1 / 8 / 2;
    
    UIGraphicsBeginImageContext(_fotoPerfil.frame.size);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width/2, 0)];
    [path addLineToPoint:CGPointMake(width - hPadding, height / 4)];
    [path addLineToPoint:CGPointMake(width - hPadding, height * 3 / 4)];
    [path addLineToPoint:CGPointMake(width / 2, height)];
    [path addLineToPoint:CGPointMake(hPadding, height * 3 / 4)];
    [path addLineToPoint:CGPointMake(hPadding, height / 4)];
    [path closePath];
    [path closePath];
    
    /*UIColor *vermelho = [UIColor redColor];
    
    [vermelho setStroke];
    [path setLineWidth:3.0];*/
    
    [path stroke];
    [path fill];
    
    maskLayer.path = path.CGPath;
    UIGraphicsEndImageContext();
    
    _fotoPerfil.layer.mask = maskLayer;
    _fotoPerfil.image=[UIImage imageNamed:@"perfilSemFoto"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
