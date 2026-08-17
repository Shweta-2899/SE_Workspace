#include <stdio.h>

struct Student 
{
    char name[50];
    int rollno;
    float marks;
    char grade;
};

void assignGrade(struct Student *s) 
{
    if (s->marks >= 90)
        s->grade = 'A';
    else if (s->marks >= 80)
        s->grade = 'B';
    else if (s->marks >= 70)
        s->grade = 'C';
    else if (s->marks >= 60)
        s->grade = 'D';
    else
        s->grade = 'F';
}

void printTopper(struct Student s[], int n) 
{
    int top = 0;

    for (int i = 1; i < n; i++) 
    {
        if (s[i].marks > s[top].marks) 
        {
            top = i;
        }
    }

    printf("\nTop Performer:\n");
    printf("Name: %s\n", s[top].name);
    printf("Marks: %.2f\n", s[top].marks);
}

int main() 
{
    struct Student students[3];

    for (int i = 0; i < 3; i++) 
    {
        printf("\nEnter details for Student %d:\n", i + 1);

        printf("Name: ");
        scanf(" %[^\n]", students[i].name);

        printf("Roll No: ");
        scanf("%d", &students[i].rollno);

        printf("Marks: ");
        scanf("%f", &students[i].marks);

        assignGrade(&students[i]);
    }

    printf("\n\nStudent Records\n");
    printf("--------------------------------------------------------\n");
    printf("%-20s %-10s %-10s %-10s\n",
           "Name", "Roll No", "Marks", "Grade");
    printf("--------------------------------------------------------\n");

    for (int i = 0; i < 3; i++) 
    {
        printf("%-20s %-10d %-10.2f %-10c\n",
               students[i].name,
               students[i].rollno,
               students[i].marks,
               students[i].grade);
    }

    printf("--------------------------------------------------------\n");

    printTopper(students, 3);

    return 0;
}