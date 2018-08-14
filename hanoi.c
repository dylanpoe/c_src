#include <stdio.h>

void hanoi(int n,char A,char B,char C){
    if (n==1){
        printf("Move sheet %d from %c to %c\n",n,A,C);//B is the temporary plate
    }else{
        hanoi(n-1,A,C,B);// A->B,C is temporary plate
        printf("Move sheet %d from %c to %c\n",n,A,C);
        hanoi(n-1,B,A,C);// B->C ,A is the temporary plate
    }
}
int main(){
    int n;
    printf("please input the  plate number :");
    scanf("%d",&n);
    hanoi(n,'A','B','C');
    return 0;
}

