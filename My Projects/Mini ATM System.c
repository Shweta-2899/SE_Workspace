#include<stdio.h>

struct Account
{
    char name[50];
    int pin;
    float balance;
};

int main()
{
    struct Account account = {"Siya", 2808, 3000.00};
    
    int enteredpin;
    int choice;
    float amount;
    
    printf("====Mini ATM====\n");
    
    printf("Enter your pin: ");
    scanf("%d",&enteredpin);
    
    if (enteredpin == account.pin)
    {
        do
        {
            printf("\n====ATM MENU====\n");
            printf("1.Check Blance\n");
            printf("2.Deposit Money\n");
            printf("3.Withdraw Money\n");
            printf("4.Account Details\n");
            printf("5.Exit\n");
            
            printf("Enter Your Choice: ");
            scanf("%d",&choice);
            
            if (choice == 1)
            {
                printf("Your balance is:%.2f\n",account.balance);
            }
            else if (choice == 2)
            {
                printf("Enter deposit amount: ");
                scanf("%f",&amount);
                
                if (amount > 0)
                {
                    account.balance += amount;
                    
                    printf("Money deposited successfully\n");
                    printf("New balance: %.2f\n",account.balance);
                }
                else
                {
                    printf("Invalid amount\n");
                }
            }
            else if (choice == 3)
            {
                printf("Enter withdrawal amount: ");
                scanf("%f",&amount);
                
                if (amount <= 0)
                {
                    printf("Invalid amount\n");
                }
                else if (amount > account.balance)
                {
                    printf("Insufficient Balance\n");
                }
                else
                {
                    account.balance -= amount;
                    
                    printf("Please collect your cash\n");
                    printf("Remaining balance :%.2f\n",account.balance);
                }
            }
            else if (choice == 4)
            {
                printf("Account name: %s\n",account.name);
                printf("Account balance: %.2f\n",account.balance);
            }
            else if (choice == 5)
            {
                printf("Thank you for using the ATM\n");
            }
            else
            {
                printf("Invalid choice.Please try again\n");
            }
        }while (choice != 5);
    }
    else
    {
        printf("Incorrect Pin\n");
        printf("Access denied\n");
    }
    return 0;
    
    
}