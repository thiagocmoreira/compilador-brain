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
then                                {return THEN;}
to                                  {return TO;}
type                                {return TYPE;}
true                                {return TRUE;}
until                               {return UNTIL;}
var                                 {return VAR;}
while                               {return WHILE;}
write                               {return WRITE;}
writeln                             {return WRITELN;}

[\n]                                {lineCounter++;}

[ \t]+                              {/*nothing to do */}

[a-zA-Z]                            {return SIMPLE_WORD;}
[a-zA-Z][a-zA-Z0-9]*                {yylval.strval = strdup(yytext);return IDENTIFIER;}
"'"([^'])*"'"                       {
                                      yytext = yytext + 1;
                                      yytext[strlen(yytext)-1] = 0;
                                      yylval.strval = strdup(yytext);
                                      return STRING;
                                    }

[0-9]+                              {return NATURAL_NUMBER;}
[0-9]+\.[0-9]+("E"[0-9]+)?          {return REAL_NUMBER;}

"."                                 {return POINT;}
"^"                                 {return POWER;}
";"                                 {return SEMICOLON;}
"("                                 {return LEFT_PARENTHESIS;}
")"                                 {return RIGHT_PARENTHESIS;}
":"                                 {return COLON;}
":="                                {return ASSIGNMENT;}
"+"                                 {return PLUS;}
"-"                                 {return MINUS;}
"*"                                 {return TIMES;}
"/"                                 {return DIVIDE;}
"="                                 {return EQUAL;}
"#"                                 {return DIFFERENT;}
"<"                                 {return SMALLER;}
"<="                                {return SMALLER_EQUAL;}
">"                                 {return BIGGER;}
">="                                {return BIGGER_EQUAL;}
"\n"                                {return EOL;}

{variable}                          { yylval.strval = strdup(yytext); return(NAME_VARIABLE); }

;"boolean"                          {return BOOLEAN_TYPE;}
"char"                              { yylval.strval = strdup(yytext); return(CHAR_TYPE); }
"integer"                           { yylval.ival = atoi(yytext); return(INTEGER_TYPE); }
"real"                              { yylval.dval = atoi(yytext); return(REAL_TYPE); }
"string"                            { yylval.strval = strdup(yytext);	return(STRING_TYPE);}

%%
