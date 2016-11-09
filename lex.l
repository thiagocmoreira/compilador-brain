%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #define YYSTYPE char*
    int lineCounter = 1;
%}

all_reserved (union)

digit [0-9]
integer {digit}+
real {integer}("."{integer})

letter_min [a-z]
letter_mai [A-Z]
letter ({letter_min}|{letter_mai})

variable {letter}({integer}|{letter}|"_")*

comparators ("="|"<"|">"|"<="|">="|"<>")

%%
all_reserved                        {return RESERVEDS_WORDS;}
and                                 {return AND;}
begin                               {return BEGIN_STATEMENT;}
case                                {return CASE;}
const                               {return CONST;}
div                                 {return DIV;}
do                                  {return DO;}
else                                {return ELSE;}
end                                 {return END;}
false                               {return FALSE;}
for                                 {return FOR;}
function                            {return FUNCTION;}
if                                  {return IF;}
interface                           {return INTERFACE;}
not                                 {return NOT;}
or                                  {return OR;}
procedure                           {return PROCEDURE;}
program                             {return PROGRAM;}
read                                {return READ;}
readln                              {return READLN;}
repeat                              {return REPEAT;}
then                                {return THEN;}
to                                  {return TO;}
type                                {return TYPE;}
true                                {return TRUE;}
until                               {return UNTIL;}
var                                 {return VAR;}
while                               {return WHILE;}
write                               {return WRITE;}
writeln                             {return WRITELN;}

"char"                              { yylval.strval = strdup(yytext); return(CHAR_TYPE); }
"integer"                           { yylval.strval = "int"; return(INTEGER_TYPE); }
"real"                              { yylval.strval = "float"; return(REAL_TYPE); }


[\n]                                {lineCounter++;}

[ \t]+                              {/*nothing to do */}

[a-zA-Z]                            {return SIMPLE_WORD;}
{letter}({integer}|{letter}|"_")*   {printf("identifier: %s\n", yytext);yylval.strval = strdup(yytext);return IDENTIFIER;}
"'"([^'])*"'"                       {
                                      yytext = yytext + 1;
                                      yytext[strlen(yytext)-1] = 0;
                                      yylval.strval = strdup(yytext);
                                      return STRING;
                                    }

[0-9]+                              {yylval.strval = strdup(yytext); return NATURAL_NUMBER;}
[0-9]+\.[0-9]+("E"[0-9]+)?          {yylval.strval = strdup(yytext); return REAL_NUMBER;}

"."                                 {return POINT;}
","                                 {return VIRGULA;}
"^"                                 {return POWER;}
";"                                 {return SEMICOLON;}
"("                                 {return LEFT_PARENTHESIS;}
")"                                 {return RIGHT_PARENTHESIS;}
":"                                 {return COLON;}
":="                                {return ASSIGNMENT;}
"+"                                 { yylval.strval = strdup(yytext); return PLUS; }
"-"                                 { yylval.strval = strdup(yytext); return MINUS; }
"*"                                 { yylval.strval = strdup(yytext); return TIMES; }
"/"                                 { yylval.strval = strdup(yytext); return DIVIDE; }
"\n"                                { return EOL; }

{variable}                          { yylval.strval = strdup(yytext); return(NAME_VARIABLE); }
{comparators}                       { yylval.strval = strdup(yytext); return(COMPARATORS); }

%%
