#include<stdio.h>
#include<stdlib.h>
#define N 8
int column[N+1];// 1 means has the queen
int rup[2*N+1];// right-up ro left-down
int lup[2*N+1];// left-up tp rigth-down
int queen[N+1]={0};

int num;

void backtrack(int);

void show_answer(){
    int x,y;
    printf("\nsolutions %d\n",++num);
    for(y=1;y<=N;y++){
        for(x=1;x<=N;x++){
            if (queen[y]==x){
                printf("Q");
            }else{
                printf(".");
            }
        }
        printf("\n");
    }
}
void backtrack(int i){
    int j;
    if (i>N){
        show_answer();
    }else{
        for(j=1;j<=N;j++){
            if (column[j]==1&& rup[i+j]==1&&lup[i-j+N]==1){
                queen[i]=j;
                column[j]=rup[i+j]=lup[i-j+N]=0;
                backtrack(i+1);
                column[j]=rup[i+j]=lup[i-j+N]=1;
            }
        }
    }
}

int main(void){
    int i;
    num=0;
    for(i=0;i<=N;i++)
        column[i]=1;
    for(i=1;i<=2*N;i++)
        rup[i]=lup[i]=1;
    backtrack(1);
    return 0;
}
