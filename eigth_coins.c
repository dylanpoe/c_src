//
//  eigth_coins.c
//  
//
//  Created by dylan on 2018/7/12.
//

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void compare(int[],int,int,int);
void eigthcoins(int[]);

void eigthcoins(int coins[]){
    if (coins[0]+coins[1]+coins[2]==coins[3]+coins[4]+coins[5]){
        if (coins[6]>coins[7])
            compare(coins,6,7,0);
        else
            compare(coins,7,6,0);
    }
    else if (coins[0]+coins[1]+coins[2]>coins[3]+coins[4]+coins[5]){
        if (coins[0]+coins[3]==coins[1]+coins[4])
            compare(coins,2,5,0);
        else if (coins[0]+coins[3]>coins[1]+coins[4])
            compare(coins,0,4,1);
        if (coins[0]+coins[3]<coins[1]+coins[4])
            compare(coins,1,3,0);
        else if (coins[0]+coins[1]+coins[2]<coins[3]+coins[4]+coins[5]){
            if (coins[0]+coins[3]==coins[1]+coins[4])
                compare(coins,5,2,0);
            else if (coins[0]+coins[3]>coins[1]+coins[4])
                compare(coins,3,1,0);
            if (coins[0]+coins[3]<coins[1]+coins[4])
                compare(coins,4,0,1);
        }
    }
}/Users/dylanpoe/myown/c_src/life_game.c
/Users/dylanpoe/myown/c_src/life_game.c
void compare(int coins[],int i,int j,int k){
    if (coins[i]>coins[k])
        printf("\n fake coins %d is more weigher",i+1);
    else
        printf("\n fake coins %d is less weigher",j+1);
}




int main(void){
    int coins[8]={0};
    int i;
    srand(time(NULL));
    for(i=0;i<8;i++)
        coins[i]=10;
    printf("\n input the weight of false coins(less or bigger than 10)");
    scanf("%d",&i);
    coins[rand()%8]=i;
    eigthcoins(coins);
    printf("\nlist all coins:\n");
    for (i=0;i<8;i++)
        printf("%d ",coins[i]);
    printf("\n");
    return 0;
}

