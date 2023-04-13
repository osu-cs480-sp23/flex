%{
#include <stdio.h>

int num_lines = 0;
int num_words = 0;
int num_chars = 0;

/* num_lines++; */
%}

%option noyywrap

%%

\n  {
    num_lines++;
    num_chars++;
}

[^ \t\n]+   {
    num_words++;
    num_chars += yyleng;
}

.   {
    num_chars++;
}

%%

int main() {
    yylex();
    printf("\t%d\t%d\t%d\n", num_lines, num_words, num_chars);
    return 0;
}