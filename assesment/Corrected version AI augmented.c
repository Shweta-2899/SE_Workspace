#include <stdio.h>

#define SIZE 10

int main() {
    int arr[SIZE];
    int i, j, temp;
    int min, max;
    int sum = 0;
    float mean;
    float distanceFromMin, distanceFromMax;

    // Input exactly 10 integers
    printf("Enter exactly 10 integers:\n");

    for (i = 0; i < SIZE; i++) {
        printf("Enter integer %d: ", i + 1);
        scanf("%d", &arr[i]);
    }

    // Initialize minimum and maximum
    min = arr[0];
    max = arr[0];

    // Find minimum, maximum and sum
    for (i = 0; i < SIZE; i++) {
        if (arr[i] < min) {
            min = arr[i];
        }

        if (arr[i] > max) {
            max = arr[i];
        }

        sum += arr[i];
    }

    // Calculate arithmetic mean
    mean = (float)sum / SIZE;

    // Sort the array in ascending order using Bubble Sort
    for (i = 0; i < SIZE - 1; i++) {
        for (j = 0; j < SIZE - 1 - i; j++) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    // Display minimum, maximum and mean
    printf("\nMinimum value: %d\n", min);
    printf("Maximum value: %d\n", max);
    printf("Arithmetic mean: %.2f\n", mean);

    // Display sorted array
    printf("Sorted array in ascending order: ");

    for (i = 0; i < SIZE; i++) {
        printf("%d ", arr[i]);
    }

    printf("\n");

    // Check whether all values are the same
    if (min == max) {
        printf("All values are equal, so the mean is equal to both the minimum and maximum.\n");
    }
    else {
        // Calculate distances from minimum and maximum
        distanceFromMin = mean - min;
        distanceFromMax = max - mean;

        if (distanceFromMin < distanceFromMax) {
            printf("The mean is closer to the minimum value.\n");
        }
        else if (distanceFromMin > distanceFromMax) {
            printf("The mean is closer to the maximum value.\n");
        }
        else {
            printf("The mean is exactly midway between the minimum and maximum values.\n");
        }
    }

    return 0;
}