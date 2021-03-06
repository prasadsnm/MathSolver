//
//  TriangleCalcViewController.m
//  TriangleCalc
//
//  Created by Niedermann Fabian on 09.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TriangleCalcViewController.h"
#include "math.h"

@interface TriangleCalcViewController ()

@property (nonatomic) BOOL angle;       // 0=deg / 1=rad
@property (weak, nonatomic) IBOutlet UITextField *fieldA;
@property (weak, nonatomic) IBOutlet UITextField *fieldB;
@property (weak, nonatomic) IBOutlet UITextField *fieldC;
@property (weak, nonatomic) IBOutlet UITextField *fieldAlpha;
@property (weak, nonatomic) IBOutlet UITextField *fieldBeta;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *angButton;

@end

@implementation TriangleCalcViewController

- (void)viewDidLoad {
    self.statusLabel.text = [NSString stringWithFormat:@"Type in two values"];
    [self.angButton setTitle:@"deg" forState:UIControlStateNormal];
    [self.angButton setTitle:@"rad" forState:UIControlStateSelected];
}

- (IBAction)angleMode:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    if (sender.isSelected) {
        self.angle = true;
        [sender setTitle:@"rad" forState:UIControlStateNormal];
        
    }
    else {
        self.angle = false;
        [sender setTitle:@"deg" forState:UIControlStateNormal];
    }
}

- (IBAction)solveClear:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    self.fieldA.enabled = !self.fieldA.isEnabled;
    self.fieldB.enabled = !self.fieldB.isEnabled;
    self.fieldC.enabled = !self.fieldC.isEnabled;
    self.fieldAlpha.enabled = !self.fieldAlpha.isEnabled;
    self.angButton.enabled = !self.angButton.isEnabled;
    
    if (!sender.isSelected) {
        self.fieldA.text = [NSString string];
        self.fieldB.text = [NSString string];
        self.fieldC.text = [NSString string];
        self.fieldAlpha.text = [NSString string];
        self.fieldBeta.text = [NSString string];
        self.statusLabel.text = [NSString stringWithFormat:@"Type in two values"];
    } else {
        
        double a = [self.fieldA.text doubleValue];
        double b = [self.fieldB.text doubleValue];
        double c = [self.fieldC.text doubleValue];
        double alpha = [self.fieldAlpha.text doubleValue];
        double beta;
        double ang;
        
        if (self.angle) {
            ang = 1.0;            
        } else {
            ang = 2*M_PI/360;
        }
        
        if (alpha != 0.0) {
            beta = M_PI/(2*ang) - alpha;
            if (c != 0.0) {
                a = c*sin(ang*alpha);
                b = c*cos(ang*alpha);
            } else if (b != 0.0) {
                c = b/(cos(ang*alpha));
                a = c*sin(ang*alpha);
            } else if (a != 0.0) {
                c = a/(sin(ang*alpha));
                b = c*cos(ang*alpha);
            }
        } else {
            if (a == 0.0) {
                a = sqrt(c*c-b*b);
                alpha = acos(b/c)/ang;
                beta = M_PI/(2*ang) - alpha;
            } else if (b == 0.0) {
                b = sqrt(c*c-a*a);
                alpha = acos(b/c)/ang;
                beta = M_PI/(2*ang) - alpha;
            } else {
                c = sqrt(a*a+b*b);
                alpha = acos(b/c)/ang;
                beta = M_PI/(2*ang) - alpha;
            }
        }
                
        self.fieldA.text = [NSString stringWithFormat:@"a = %g", a];
        self.fieldB.text = [NSString stringWithFormat:@"b = %g", b];
        self.fieldC.text = [NSString stringWithFormat:@"c = %g", c];
        self.fieldAlpha.text = [NSString stringWithFormat:@"al = %g", alpha];
        self.fieldBeta.text = [NSString stringWithFormat:@"be = %g", beta];
        self.statusLabel.text = [NSString stringWithFormat:@"Result: "];        
    }
    
}
@end
