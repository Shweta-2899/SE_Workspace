#include <stdio.h>

int main() {
    // Presetting the year to 2024
    int year = 2026; 
    
    printf("Checking the year: %d\n", year);

    // Leap year logic
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        printf(" %d is a leap year.\n", year);
    } else {
        printf(" %d is not a leap year.\n", year);
    }

    return 0;
}