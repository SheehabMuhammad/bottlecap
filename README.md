# BottleCap
BottleCap - Programming Language Interpreter Design

## Grammar for the Language
```
program
      : statement '\n' 
      | program statement '\n'
      ;
      
statement
      : expression 
      | PRINT statement 
      | ADD statement WITH statement 
      | SUBSTRACT statement FROM statement 
      | MULTIPLY statement BY statement 
      | DIVIDE statement BY statement 
      | ASSIGN identifier TO statement  
      ;
      
expression
      : term
      | expression term '*'
      | expression term '/'
      | expression term '+'
      | expression term '-'
      ;
term
      : number
      | identifier
      ;
```

## RegEx of the Interpreter      
```
"Print"         PRINT
"Add"           ADD
"with"          WITH
"Substract"     SUBSTRACT
"from"          FROM
"Multiply"      MULTIPLY
"Divide"        DIVIDE
"by"            BY
"Assign"        ASSIGN
"to"            TO
[a-zA-Z]        identifier
[0-9]+          number
[ \r\t]         whitespace
[-+\*/\n]       -, +, *, /, \n
```


## Instructions to Compile the Interpreter:

### Windows CMD Commands:
```
bison -d parser.y  
flex lexer.l  
gcc lex.yy.c parser.tab.c
```
Command "bison -d parser.y" will generate two files "parser.tab.h" and "parser.tab.c". 
Command "flex lexer.l" will require the "parser.tab.h" file beacuse it is included in the "lexer.l" file.
The command "bison -d parser.y" may export files with diiferent name in linux machine. 
Therefore, the file name in lexer.l also should be changed before running "flex lexer.l".
If everything is good then the 3rd command should create an executable file which can be invoked to the COMMAND PROPMT or Terminal as BottleCap Interpreter
Since there was no strict specification about the variable_name charecter length, I implented the code as it can only handle one charecter per variable_name. So, from a-z and A-Z, there are 52 possible variables.

### Example/Tested Statements:
```
:Add 5 with 5 
:Add 9 with 5 
:Print 5 
:5 
:Add 5 with Add 4 with Multiply 8 by 9 
:Print Add 5 with Add 4 with Multiply 8 by 9 
:81 
:Print Add 5 with Add 4 4 *  with Multiply 8 2 / by 9 3 + 
:69 
:Print Add 2 3 + with 2 5 * 
:15 
:Print Add Add 2 with 3 with Multiply 3 by 2 
:1
```
