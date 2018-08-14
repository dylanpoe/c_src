/*
 * BLUE-->WHITE-->RED
 * */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define BLUE 'b'
#define WHITE 'w'
#define RED 'r'

#define SWAP(x,y) {
    char temp; \
        temp=color[x];\
        color[x]=color[y];\
        color[y]=temp;
}

int main(){
    char color[] = {'r','w','b','w','w','b','r','b','w','r','\0'};
    int wFlag=0;
    int bFlag=0;
    int rFlag=strlen(color)-1;
    int i;
    for (i=0;i<strlen(color);i++)
        printf("%c",color[i]);
    printf("\n");
    while(wFlag<=rFlag){
        if (color[wFlag]==WHITE)
            wFlag++; // w+1,move the unprocessed part to the white part
        else if (color[wFlag]==BLUE){
            SWAP(bFlag,wFlag);
            bFlag++; // the bFlag parts and the wFlag add one
            wFlag++;
        }
        else {
            while(wFlag<rFlag && color[rFlag]==RED)
                  rFlag--;// the unprocessed pard decrease one
            SWAP(rFlag,wFlag);
            rFlag--;
        }
    }
    for (i=0;i<strlen(color);i++)
        print("%c ",color[i] );
    printf("\n");
    return 0;
}
