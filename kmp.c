
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void table(char*); // 建立前进表
int search(int, char*, char*); // 搜寻关键字
void substring(char*, char*, int, int); // 取出子字串
int skip[256];
int main(void) {
    char str_input[80];
    char str_key[80];
    char tmp[80] = {'\0'};
    int m, n, p;
    printf("请输入字串：");
    gets(str_input);
    printf("请输入搜寻关键字：");
    gets(str_key);
    m = strlen(str_input); // 计算字串长度
    n = strlen(str_key);
    table(str_key);
    p = search(n-1, str_input, str_key);
    while(p != -1) {
        substring(str_input, tmp, p, m);
        printf("%s\n", tmp);
        p = search(p+n+1, str_input, str_key);
    }
    printf("\n");
    return 0;
}
void table(char *key) {
    int k, n;
    n = strlen(key);
    for(k = 0; k <= 255; k++)
    skip[k] = n;
    for(k = 0; k < n - 1; k++)
    skip[key[k]] = n - k - 1;
}
int search(int p, char* input, char* key) {
    int i, m, n;
    char tmp[80] = {'\0'};
    m = strlen(input);
    n = strlen(key);
    while(p < m) {
        substring(input, tmp, p-n+1, p);
        if(!strcmp(tmp, key)) // 比较两字串是否相同
        return p-n+1;
        p += skip[input[p]];
    }
    return -1;
}
void substring(char *text, char* tmp, int s, int e) {
    int i, j;
    for(i = s, j = 0; i <= e; i++, j++)
    tmp[j] = text[i];
    tmp[j] = '\0';
}
