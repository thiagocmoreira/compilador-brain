%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #define YYSTYPE char*
    int lineCounter = 1;
%}

all_reserved (union)


%%
all_reserved                        {return RESERVEDS_WORDS;}
and                                 {return AND;}
begin                               {return BEGIN_STATEMENT;}
case                                {return CASE;}
char                                {return CHAR;}
const                               {return CONST;}
div                                 {return DIV;}
do                                  {return DO;}
else                                {return ELSE;}
end                                 {return END;}
false                               {return FALSE;}
for                                 {return FOR;}
function                            {return FUNCTION;}
if                                  {return IF;}
integer                             {return INTEGER;}
interface                           {return INTERFACE;}
not                                 {return NOT;}
or                                  {return OR;}
procedure                           {return PROCEDURE;}
program                             {return PROGRAM;}
string                              {return STRING_RESERVED;}
then                                {return THEN;}
to                                  {return TO;}
type                                {return TYPE;}
true                                {return TRUE;}
until                               {return UNTIL;}
var                                 {return VAR;}
while                               {return WHILE;}
boolean                             {return BOOLEAN;}
real                                {return REAL;}

[\n]                                {lineCounter++;}

[ \t]+                                {/*nothing to do */}

[a-zA-Z]                            {return SIMPLE_WORD;}
[a-zA-Z][a-zA-Z0-9]*                {yylval.strval = strdup(yytext);return IDENTIFIER;}
"'"([^'])*"'"                       {return STRING;}

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

%%
