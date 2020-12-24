#import <Foundation/Foundation.h>

int main(int argc, char** argv)
{
    for(int i = 1; i <= 100; ++i) {
        NSString *output = @"";
        
        if (i % 3 == 0)
            output = [output stringByAppendingString:@"Fizz"];
        
        if (i % 5 == 0)
            output = [output stringByAppendingString:@"Buzz"];
        
        if ([output length] == 0)
            output = [NSString stringWithFormat:@"%d", i];
        
        NSLog(@"%@", output);
    }
}