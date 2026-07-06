
#include <stdio.h>
#include <conio.h>
void main(){
    int num1=6;
    int num2=2;
    char choice='*';
    
  
        switch(choice){
        
        case '+':
        printf("Addition of two numbers is :- %d",num1+num2);
        break;
        
        case '-':
        printf("Subtraction of two numbers is :- %d",num1-num2);
        break;
        
        case '*':
        printf("Multiplication of two numbers is :- %d",num1*num2);
        break;
        
        case '/':
        printf("Divison of two number is :- %d",num1/num2);
        break;
        
        default:
        printf("Invalid choice");
        
    }
    getch();
}