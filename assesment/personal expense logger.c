#include <stdio.h>

#define MAX_EXPENSES 10


struct Expense 
{
    char category[30];
    float amount;
};

int main() 
{
    struct Expense expenses[MAX_EXPENSES];
    int count = 0;
    int choice;
    float total;

    do 
    {
        printf("\n===== Daily Expense Tracker =====\n");
        printf("1. Add Expense\n");
        printf("2. View All Expenses\n");
        printf("3. Save & Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) 
        {

            case 1:
                if (count >= MAX_EXPENSES) 
                {
                    printf("You have reached the maximum of 10 expenses.\n");
                } else 
                {
                    printf("Enter expense category: ");
                    scanf(" %29[^\n]", expenses[count].category);

                    printf("Enter amount: ");
                    scanf("%f", &expenses[count].amount);

                    count++;
                    printf("Expense added successfully!\n");
                }
                break;

            case 2:
                if (count == 0) 
                {
                    printf("\nNo expenses have been logged yet.\n");
                } else 
                {
                    total = 0;

                    printf("\n===== All Expenses =====\n");
                    printf("%-5s %-30s %10s\n", "No.", "Category", "Amount");
                    printf("-----------------------------------------------\n");

                    for (int i = 0; i < count; i++) 
                    {
                        printf("%-5d %-30s %10.2f\n",
                               i + 1,
                               expenses[i].category,
                               expenses[i].amount);

                        total += expenses[i].amount;
                    }

                    printf("-----------------------------------------------\n");
                    printf("%-36s %10.2f\n", "Running Total:", total);
                }
                break;

            case 3: 
            {
                FILE *file = fopen("expenses.txt", "w");

                if (file == NULL) 
                {
                    printf("Error: Could not open expenses.txt for writing.\n");
                } 
                else 
                {
                    for (int i = 0; i < count; i++) 
                    {
                        fprintf(file, "%s,%.2f\n",
                                expenses[i].category,
                                expenses[i].amount);
                    }

                    fclose(file);
                    printf("\nExpenses saved to expenses.txt\n");
                    printf("Goodbye!\n");
                }
                break;
            }

            default:
                printf("Invalid choice. Please enter 1, 2, or 3.\n");
        }

    } while (choice != 3);

    return 0;
}