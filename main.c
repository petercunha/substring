#include <stdio.h>
#include <stdlib.h>

#define MAX_INPUT_LENGTH 100

extern char *sub_string(char *, int, int);

int main()
{
    int start_index, end_index;
    char *in_string = (char *)malloc(MAX_INPUT_LENGTH * sizeof(char));
    char *out_string;

    scanf("%s\n%d\n%d", in_string, &start_index, &end_index);

    out_string = (char *)sub_string(in_string, start_index, end_index);
    printf("%s", out_string);
    return 0;
}