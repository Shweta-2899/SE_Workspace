#include<stdio.h>
#include<conio.h>

int main() {
    
    float percentage;
    
    printf("Enter student's percentage; ");
    scanf("%f",&percentage);
    
     if (percentage < 0 || percentage > 100) {
        printf("Invalid percentage. Please enter a value between 0 and 100.\n");
        return 0;
    }
    
    if(percentage>=90)
    {
        printf("Grade A-Excellent work, Keep it up!\n");
    }
    else if(percentage>=75)
    {
        printf("Grade B- Good work! Keep pushing!\n");
    }
    else if(percentage>=60)
    {
        printf("Grade C- Good Efforts! Keep improving!\n");
    }
    else if(percentage>=45)
    {
        printf("Grade D- You passed! Keep working harder!\n");
        
    }
    else
    {
        printf("Grade F- Don't give up! Keep trying and improve!\n");
    }
    return 0;
}