/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

(\s)*(["'])(?:\\\1|.)*?\2(\s)* return 'STRING'
"and"                 return 'and'
"or"                  return 'or'
(\s)*([a-zA-Z])([_a-zA-Z.0-9]*)(\s)*  return 'VARIABLE'
([ ]*[(])             return '('
([)][ ]*)             return ')'
[0-9 ]+("."[0-9]+)?   return 'NUMBER'
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"="                   return '='
"<="                  return '<='
">="                  return '>='
"<"                   return '<'
">"                   return '>'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%left 'and' 'or'
%left '<=' '>='
%left '<' '>'
%left '^'
%left '='
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : e EOF
        {return $1;}
    ;

e
    : e '+' e
        {$$ = $1+$3;}
    | e 'and' e
        {$$ = $1&&$3;}
    | e 'or' e
        {$$ = $1||$3;}
    | e '=' e
        {$$ = $1==$3;}
    | e '<=' e
        {$$ = $1<=$3;}
    | e '>=' e
        {$$ = $1>=$3;}
    | e '<' e
        {$$ = $1<$3;}
    | e '>' e
        {$$ = $1>$3;}
    | e '-' e
        {$$ = $1-$3;}                        
    | e '*' e
        {$$ = $1*$3;}
    | e '/' e
        {$$ = $1/$3;}
    | e '^' e
        {$$ = Math.pow($1, $3);}
    | '-' e %prec UMINUS
        {$$ = -$2;}
    | '(' e ')'
        {$$ = $2;}
    | STRING
        {$$ = String(yytext).trim().replace(/(^["']|["']$)/g, '');}
    | VARIABLE
        {$$ = 1;}
    | NUMBER
        {$$ = Number(yytext);}
    ;
