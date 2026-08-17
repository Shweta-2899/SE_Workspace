#include <stdio.h>

int main() {
    float hours[7];
    float total = 0.0, average;
    int maxDay = 0;

    for (int i = 0; i < 7; i++) 
    {
        do 
        {
            printf("Enter study hours for Day %d (0-24): ", i + 1);
            scanf("%f", &hours[i]);

            if (hours[i] < 0 || hours[i] > 24) 
            {
                printf("Invalid entry! Please enter a value between 0 and 24.\n");
            }
        } while (hours[i] < 0 || hours[i] > 24);
    }

    for (int i = 0; i < 7; i++) 
    {
        total += hours[i];

        if (hours[i] > hours[maxDay]) 
        {
            maxDay = i;
        }
    }

    average = total / 7;

    printf(" Weekly Performance Summary\n");
    printf("Weekly Total: %.2f hours\n", total);
    printf("Daily Average: %.2f hours\n", average);
    printf("Highest Study Hours: Day %d (%.2f hours)\n",
           maxDay + 1, hours[maxDay]);

    printf("\nStudy Hours Chart:\n");

    for (int i = 0; i < 7; i++) 
    {
        printf("Day %d: ", i + 1);

        for (int j = 0; j < (int)hours[i]; j++) 
        {
            printf("*");
        }

        printf("\n");
    }

    return 0;
}