/*
 *BLUE-->WHITE-->RED
 * */
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 

char color[] = {'r', 'w', 'b', 'w', 'w',                 'b', 'r', 'b', 'w', 'r', '\0'}; 
#define BLUE 'b' 
#define WHITE 'w' 
#define RED 'r' 
int main() {
    int wFlag = 0;
    int bFlag = 0;
    int rFlag = strlen(color) - 1;
    int i; 
    for(i = 0; i < strlen(color); i++) 
        printf("%c ", color[i]); 
    printf("\n"); 
    char temp; 
    while(wFlag <= rFlag) {
        if(color[wFlag] == WHITE)
            wFlag++;
        else if(color[wFlag] == BLUE) {
            temp = color[bFlag]; 
            color[bFlag] = color[wFlag];
            color[wFlag] = temp; 
            bFlag++; wFlag++;
        } 
        else { 
            while(wFlag < rFlag && color[rFlag] == RED)
              rFlag--;
            temp = color[rFlag]; 
            color[rFlag] = color[wFlag];
            color[wFlag] = temp; 
            rFlag--;
        } 
    } 
    for(i = 0; i < strlen(color); i++) 
        printf("%c ", color[i]); 
    printf("\n"); 
    return 0; 
} 


