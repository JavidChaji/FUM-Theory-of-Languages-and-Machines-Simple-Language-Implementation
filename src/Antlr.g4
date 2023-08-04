grammar Antlr;

start :             program EOF;

// program

program :           lib* class+ ;

// lib

lib :               ID '=' REQUIRE ID ';'| ID '=' FROM ID REQUIRE ID ';';

// class

class : classModifier? 'class' ID extends? implement? classBody ;

classBody : '{' classBodyDeclaration* '}' ;

extends :           'extends' ID ;
implement :         'implements' ID | 'implements' ID exteraimplement ;
exteraimplement :  ',' ID | ',' ID exteraimplement ;

classBodyDeclaration : ';' | STATIC? block
                           | memberDeclaration ;

memberDeclaration
    : methodDeclaration
    | fieldDeclaration
    | constructorDeclaration
    ;


constructorDeclaration : ID formalParameters (THROWS qualifiedNameList)? constructorBody=block ;

fieldDeclaration :  typeType variableDeclarators ';' ;

methodDeclaration : methodDeclaration1 | methodDeclaration2;

methodDeclaration1 : typeTypeOrVoid ID formalParameters
                     (THROWS qualifiedNameList)?
                     methodBody ;

methodDeclaration2 : ID '=' formalParameters '=>' methodBody ;

methodBody : block | ';' ;

block : '{' blockStatement* '}' ;

blockStatement : localVariableDeclaration ';'
                 | statement;

localVariableDeclaration : typeType variableDeclarators ;

classModifier : PUBLIC
                | PROTECTED
                | PRIVATE
                | STATIC
                | ABSTRACT;

qualifiedNameList : qualifiedName (',' qualifiedName)* ;

typeTypeOrVoid : typeType | VOID ;

typeType : (classType | primitiveType) ('[' ']')* ;

primitiveType : ('let' | 'const' ) (BOOLEAN | INT | FLOAT) ;

classType : ID typeArguments? ('.' ID typeArguments?)* ;

typeArguments : '<' typeType (',' typeType)* '>' ;

variableDeclarators : variableDeclarator (',' variableDeclarator)* ;

variableDeclarator : variableDeclaratorId ('=' variableInitializer)*;


variableInitializer : arrayInitializer | expression ;

arrayInitializer : '{' (variableInitializer (',' variableInitializer)* (',')? )? '}' ;

expression : primary
             | expression bop='.'
               ( ID
               | methodCall
               | THIS
               | SUPER superSuffix
               )
             | expression '[' expression ']'
             | expression '[' variableRang ']'
             | methodCall
             | NEW creator
             | '(' typeType ')' expression
             | expression '**' expression
             | prefix='~' expression
             | expression postfix=('++' | '--')
             | prefix=('+'|'-'|'++'|'--') expression
             | expression bop=('*'|'/'|'%'|'//') expression
             | expression bop=('+'|'-') expression
             | expression '###' expression
             | expression ('<' '<' | '>' '>') expression
             | expression bop=('&'|'^'|'|') expression
             | expression bop=('==' | '!=' | '<>') expression
             | expression bop=('<=' | '>=' | '>' | '<') expression
             | <assoc=right> expression bop='?' expression ':' expression
             | <assoc=right> expression
                bop=('=' | '+=' | '-=' | '*=' | '/=' | '**=' | '%=' | '//=')
                expression
             | expression bop=('or'|'and') expression
             | 'not' expression;

variableRang : INTEGER_LITERAL ':' INTEGER_LITERAL ;

methodCall :  ID '(' expressionList? ')'
              | THIS '(' expressionList? ')'
              | SUPER '(' expressionList? ')' ;

creator : createdName arguments
          | createdName (arrayCreatorRest | arguments) ;

arrayCreatorRest : '[' (']' ('[' ']')* arrayInitializer | expression ']' ('[' expression ']')* ('[' ']')*) ;


createdName : ID ('.' ID )*
              | primitiveType ;


primary: '(' expression ')'
         | literal
         | ID
         | THIS
         | SUPER
         | typeTypeOrVoid '.' CLASS
         | (explicitGenericInvocationSuffix | THIS arguments) ;


explicitGenericInvocationSuffix : SUPER superSuffix
                                  | ID arguments ;

superSuffix
    : arguments
    | '.' ID arguments?
    ;


arguments : '(' expressionList? ')' ;

expressionList : expression (',' expression)*;


formalParameters : '(' formalParameterList? ')' ;

formalParameterList : formalParameter (',' formalParameter)* (',' lastFormalParameter)?
                      | lastFormalParameter ;

lastFormalParameter : typeType '...' variableDeclaratorId ;

formalParameter : typeType variableDeclaratorId ;

variableDeclaratorId : ID ('[' ']')* ;

qualifiedName : ID ('.' ID)* ;

literal
    : INTEGER_LITERAL
    | FLOAT_LITERAL
    | BOOL_LITERAL
    | NULL_LITERAL
    ;

INTEGER_LITERAL : ('0' | [1-9] (Digits? | '_'+ Digits));

FLOAT_LITERAL : (Digits '.' Digits? | '.' Digits) ExponentPart?
                | Digits ExponentPart ;

fragment Digits: [0-9] ([0-9_]* [0-9])? ;

fragment ExponentPart : [eE] [+-]? Digits ;

statement :
      blockLabel=block
    | IF parExpression statement (ELSE statement)?
    | FOR '(' forControl ')' statement
    | WHILE parExpression statement
    | DO statement WHILE parExpression ';'
    | SWITCH parExpression '{' switchBlockStatementGroup* switchLabel* '}'
    | RETURN expression? ';'
    | BREAK ID? ';'
    | CONTINUE ID? ';'
    | SEMI
    | statementExpression=expression ';'
    | 'const' '(' (ID '=' IOTA)+ ID* ')';


parExpression : '(' expression ')';

forControl : ID 'in' variableRang 'step' INTEGER_LITERAL
             | 'auto' ID 'in' ID;

switchBlockStatementGroup : switchLabel+ blockStatement+ ;

switchLabel : CASE (constantExpression=expression
              | enumConstantName=ID) ':'
              | DEFAULT ':' ;

BOOL_LITERAL : 'true'|'false' ;

IOTA :              'iota';
ABSTRACT:           'abstract';
BOOLEAN:            'boolean';
BREAK:              'break';
CASE:               'case';
CLASS:              'class';
CONST:              'const';
CONTINUE:           'continue';
DEFAULT:            'default';
DO:                 'do';
ELSE:               'else';
EXTENDS:            'extends';
FINAL:              'final';
FLOAT:              'float';
FOR:                'for';
IF:                 'if';
IMPLEMENTS:         'implements';
INT:                'int';
NEW:                'new';
PRIVATE:            'private';
PROTECTED:          'protected';
PUBLIC:             'public';
RETURN:             'return';
STATIC:             'static';
SWITCH:             'switch';
THIS:               'this';
VOID:               'void';
WHILE:              'while';
THROWS:             'throws';
SUPER:              'super';

NULL_LITERAL:       'null';

//Separators

LPAREN :            '(' ;
RPAREN :            ')' ;
LBRACE :            '{' ;
RBRACE :            '}' ;
LBRACK :            '[' ;
RBRACK :            ']' ;
SEMI :              ';' ;
COMMA :             ',' ;
DOT :               '.' ;

// Operators

ASSIGN :            '=' ;
GT :                '>' ;
LT :                '<' ;
BANG :              '!' ;
TILDE :             '~' ;
QUESTION :          '?' ;
COLON :             ':' ;
EQUAL :             '==' ;
LE :                '<=' ;
GE :                '>=' ;
NOTEQUAL :          '!=' ;
NONEQUAL :          '<>' ;
ADD :               '+' ;
SUB :               '-' ;
MUL :               '*' ;
DIV :               '/' ;
BITAND :            '&' ;
BITOR :             '|' ;
CARET :             '^' ;
MOD :               '%' ;
SINGLEOPRATION :    '###' ;

ADD_ASSIGN :        '+=' ;
SUB_ASSIGN :        '-=' ;
MUL_ASSIGN :        '*=' ;
DIV_ASSIGN :        '/=' ;
C_DIV_ASSIGN :      '//=' ;
POW_ASSIGN :        '**=' ;
MOD_ASSIGN :        '%=' ;
C_DIV :             '//' ;
AND :               'and' ;
OR :                'or' ;
NOT:                'not' ;

REQUIRE :           'require' ;
FROM :              'from' ;

ID :                [A-Za-z$_][A-Za-z0-9$_]+ ;
COMMENT :           '/*' .*? '*/' -> skip ;
LINE_COMMENT :      '@@' ~[\r\n]* -> skip ;
WS:                 [ \t\r\n\u000C]+ -> channel(HIDDEN);
//skip