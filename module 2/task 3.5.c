#include <stdio.h>
#include <conio.h>
void main(){
    float base=3,height=5;
    float length=8,width=6;
    float radius=9;
    float area;
    
    int choice=2;
    
    printf(" \n Choices of Menu");
    printf("\n 1 For  Area of Triangle");
    printf("\n 2 For  Area of Rectangle");
    printf("\n 3 For  Area of  Circle");
    
        
       if(choice==1)
       {
        area=0.5*base*height;
        printf("\n Area of Triangle is :- %f",area);
       }
        
        else if(choice==2)
        {
        area=length*width;
        printf("\n Area of Rectangle is :- %f",area);
        }
        
        else if(choice==3)
        {
        area=3.14*radius*radius;
        printf("\n Area of Circle is :- %f",area);
        }
        
        else{
        printf("\n Invalid choice");
         }
    getch();
}
