%{
#include <stdio.h>

void foo();
%}

%option yylineno
%option noyywrap

%%

c   {
    printf("c\n");
}

cat { /* cat */ }

cat|dog {
    /* "cat" or "dog" */
    printf("literal string recognized: %s\n", yytext);
    printf("length of string recognized: %d\n", yyleng);
    printf("line number of string recognized: %d\n", yylineno);
    ECHO;
}

ca*t    { /* "ct" or "cat" or "caat" or "caaaaaaaat" */ }

ca+t    { /* "cat" or "caat" or "caaaaaaaat" */ }

ca?t    { /* "ct" or "cat" */ }

c.t    { /* "cat" or "cbt" or "cct" etc. */ }

\n      { /* newline */}
\t      { /* tab */}

[abc]   { /* "a" or "b" or "c" */ }
[a-z]   { /* "a" or "b" or "c" or "d" or ... */ }
[0-9]
[a-zA-Z]

[^ \t\n] { /* any character except space, tab, newline */ }

^cat    { /* "cat" at the start of a line */ }
cat$    { /* "cat" at the end of a line */ }

\.  { /* "." */ }
"."  { /* "." */ }

<<EOF>> {
    /* end of source file */
    yyterminate();
}

. {
    printf("Unrecognized character: %s\n", yytext);
}

%%

void foo() {
    printf("foo()!\n");
}

int main() {
    return yylex();
}
