#include <stdio.h>

int main() {
    // Presetting the number to 4
    int day = 7; 

    printf("Day number: %d\n", day);

    // Using switch to check the number
    switch(day) {
        case 1:
            printf("Monday\n");
            break;
        case 2:
            printf("Tuesday\n");
            break;
        case 3:
            printf("Wednesday\n");
            break;
        case 4:
            printf("Thursday\n");
            break;
        case 5:
            printf("Friday\n");
            break;
        case 6:
            printf("Saturday\n");
            break;
        case 7:
            printf("Sunday\n");
            break;
        default:
            printf("❌ Invalid input! Please use a number between 1 and 7.\n");
    }

    return 0;
}