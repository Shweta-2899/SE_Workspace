#include <stdio.h>
#include <string.h>

#define SUBJECTS 3
#define DAYS 7

struct StudyLog 
{
    char subject[40];
    float hours[7];
};

void displayWeeklyReport(struct StudyLog logs[], int count) 
{
    int i, j;
    float total, average;

    printf("\n========== WEEKLY REPORT ==========\n");

    for (i = 0; i < count; i++) 
    {
        total = 0;

        for (j = 0; j < DAYS; j++) 
        {
            total += logs[i].hours[j];
        }

        average = total / DAYS;

        printf("\nSubject: %s\n", logs[i].subject);
        printf("Weekly Total: %.2f hours\n", total);
        printf("Daily Average: %.2f hours\n", average);

        printf("Progress Chart:\n");

        for (j = 0; j < DAYS; j++) 
        {
            int dots = (int)logs[i].hours[j];

            printf("Day %d: ", j + 1);

            for (int k = 0; k < dots; k++) 
            {
                printf("•");
            }

            printf(" (%.2f hours)\n", logs[i].hours[j]);
        }
    }

    printf("\n===================================\n");
}

void logToday(struct StudyLog logs[], int day, int count) 
{
    int i;
    float hours;

    printf("\n========== LOG TODAY ==========\n");

    for (i = 0; i < count; i++) 
    {
        printf("Enter study hours for %s: ", logs[i].subject);
        scanf("%f", &hours);

        if (hours < 0) 
        {
            printf("Hours cannot be negative. Setting to 0.\n");
            hours = 0;
        }

        logs[i].hours[day] = hours;
    }

    printf("Today's study hours have been recorded.\n");
}

void saveToFile(struct StudyLog logs[], int count) 
{
    FILE *file;
    int i, j;

    file = fopen("productivity_log.txt", "w");

    if (file == NULL) 
    {
        printf("Error: Could not open file for saving.\n");
        return;
    }

    for (i = 0; i < count; i++) 
    {
        fprintf(file, "%s", logs[i].subject);

        for (j = 0; j < DAYS; j++) 
        {
            fprintf(file, ",%.2f", logs[i].hours[j]);
        }

        fprintf(file, "\n");
    }

    fclose(file);

    printf("\nRecords saved successfully to productivity_log.txt\n");
}

int main() 
{
    struct StudyLog logs[SUBJECTS] = 
    {
        {"Physics", {0, 0, 0, 0, 0, 0, 0}},
        {"Chemistry", {0, 0, 0, 0, 0, 0, 0}},
        {"Maths", {0, 0, 0, 0, 0, 0, 0}}
    };

    int choice;
    int currentDay = 0;

    printf("=====================================\n");
    printf("   STUDENT PRODUCTIVITY TRACKER\n");
    printf("=====================================\n");

    while (1) 
    {
        printf("\nMenu:\n");
        printf("1. Log Today's Study Hours\n");
        printf("2. View Weekly Report\n");
        printf("3. Save & Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) 
        {
            case 1:
                if (currentDay < DAYS) 
                {
                    logToday(logs, currentDay, SUBJECTS);
                    currentDay++;
                } else 
                {
                    printf("\nAll 7 days have already been logged.\n");
                }
                break;

            case 2:
                displayWeeklyReport(logs, SUBJECTS);
                break;

            case 3:
                saveToFile(logs, SUBJECTS);
                printf("Thank you for using the Student Productivity Tracker!\n");
                return 0;

            default:
                printf("Invalid choice. Please select 1, 2, or 3.\n");
        }
    }

    return 0;
}