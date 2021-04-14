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
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.login=@"siema";
    self.password=@"siema";
    self.passwordField.secureTextEntry=YES;
    self.notificationLabel.text=@"";
}
- (IBAction)buttonAction:(id)sender {
    BOOL valLogin=[self.login isEqualToString:[self.loginField text]];
    BOOL valPass=[self.password isEqualToString:[self.passwordField text]];
    if (valLogin &&valPass){
        self.notificationLabel.textColor=UIColor.greenColor;
        self.notificationLabel.text=@"Success";
    }
    else{
        self.notificationLabel.textColor=UIColor.redColor;
        self.notificationLabel.text=@"Wrong login/password";
    }
}

- (void ) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
