//
//  ViewController.m
//  xxyy
//
//  Created by Mykyta Brazhynskyy on 13/04/2021.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSString *login;
@property (nonatomic,strong) NSString *password;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.login=[[NSString alloc]initWithString:@"siema"];
    self.password=[[NSString alloc]initWithString:@"siema"];
    [self.login stringByAppendingString:@"Bob"];
    [self.password stringByAppendingString:@"secure"];
    NSLog(@"%@",self.login);
}
- (void ) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
