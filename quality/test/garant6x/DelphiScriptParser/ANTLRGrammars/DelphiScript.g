grammar DelphiScript;

options {
//	backtrack = true;
//	memoize = true;
	output=AST;
	ASTLabelType = CommonTree; 
}


tokens {
	FORMAL_PARAMETER;
	ACTUAL_PARAMETER;	
	METHOD_DECL;
	METHOD_DEF;
	BLOCK;
	QUALIFIED_IDENT;
	METHOD_CALL;
	INDEX;
	QUALIFIED_ACCESS;
	
	IMPL_DECL;
	CASE_SELECTOR;
	CONST_ARRAY;
}

@parser::header {
	package dsparser.antlr.generated;
}

@lexer::header {
	package dsparser.antlr.generated;
}


goal
	: 	sdUnit
	;
	
sdUnit
	:	usesClause?	
		implementationDecl*
		-> ^(UNIT usesClause? ^(IMPL_DECL implementationDecl*))
	;


implementationDecl
	: 	labelDeclSection
	|	constSection
	|	varSection
	|	methodImplOrForwardDecl
	;

methodImplOrForwardDecl
	:	methodHeading 
		(
			fancyBlock -> ^(METHOD_DEF methodHeading fancyBlock)// impl
			| FORWARD  -> ^(METHOD_DECL methodHeading)// forward decl
		)
		SEMI
	;
	
fancyBlock
	:	implementationDecl* block	-> ^(IMPL_DECL implementationDecl*) block
	;

block
	:	BEGIN (statementList|SEMI)? END -> ^(BLOCK statementList?)  // MY: not like SEMI
	;

statementList
	:	(statement SEMI!)+ // MY
	;


statement
	:	labelId COLON^
	|	(labelId COLON^)? simpleStatement
	;

simpleStatement
	:	expressionOrAssignment
	|	gotoStatement
	|	block
	|	caseStatement
	|	repeatStatement
	|	whileStatement
	|	forStatement
	|	withStatement
	|	tryStatement
	|	raiseStatement
	|	ifStatement
	|	BREAK
	;

raiseStatement
	:	RAISE^ (expression)?
	;

tryStatement
	:	TRY 
			tb=statementList?
		(fe=FINALLY | fe=EXCEPT)
			feb=statementList?
		END	
		-> ^(TRY ^(BLOCK $tb?) ^($fe $feb?))
	;	

withStatement
	:	WITH expression //expressionList  // MY ???
		DO statement?
		-> ^(WITH expression statement?)
	;

forStatement
	:	FOR ident ASSIGN from=expression (t_or_d=TO|t_or_d=DOWNTO) to=expression DO statement
		-> ^(FOR ident $from $t_or_d $to statement)
	;

whileStatement
	:	WHILE expression DO statement?
		-> ^(WHILE expression statement?)
	;

repeatStatement
	:	REPEAT statementList? UNTIL expression
		-> ^(REPEAT ^(BLOCK statementList?) expression)
	;

caseStatement
	:	CASE expression OF
			caseSelector+
		(ELSE statement? SEMI)?
		END
		-> ^(CASE expression caseSelector+ ^(ELSE statement?)? )
	;

caseSelector
	:	expressionOrRange (COMMA expressionOrRange)* COLON statement? SEMI
		-> ^(CASE_SELECTOR expressionOrRange+ ^(BLOCK statement?))
	;


ifStatement
	:	IF expression THEN ts=statement?  
		(ELSE es=statement?)?		
		-> ^(IF expression ^(THEN $ts?) ^(ELSE $es?)?)		
	;

gotoStatement
	:	GOTO^ labelId
	;

expressionOrAssignment
	:	expression (ASSIGN^ expression)?
	;

varSection
	: VAR! varDecl+
	;

varDecl
	:	r=identList (COLON idents+=type)? SEMI	
		{$idents=$r.list;}
		-> ^(VAR $idents type?)+
	;

labelDeclSection
	:	LABEL (labelId COMMA?)+ SEMI
		-> ^(LABEL labelId+)
	;

labelId
	:	INT
	|	ident
	;

usesClause
	:	USES (usedUnit COMMA?)+ SEMI  -> ^(USES usedUnit+)
	;

usedUnit
	:	ident
	;

addOp
	:	PLUS
	|	MINUS
	|	OR
	|	XOR
	;

simpleExpression
	:	term (addOp^ term)*
	;

term
	:	factor (mulOp^ factor)*
	;
	
mulOp
	:	STAR
	|	SLASH
	|	DIV
	|	MOD
	|	AND
	|	SHL
	|	SHR
	;
	
factor
	:	atom
	| 	unaryOperator^ atom //factor // MY
	;

atom
	:	(atom2 -> atom2) (DOT r=atom2 -> ^(QUALIFIED_ACCESS $atom $r)
		)*
	;
	
atom2
	: 	(particle -> particle)
		(		( LSQBR expressionList RSQBR	 -> ^(INDEX particle expressionList) )*
			|	LPAREN (p+=parameterExpression (COMMA p+=parameterExpression)*)? RPAREN  -> ^(METHOD_CALL particle $p*)	
		)
	;
	

parameterExpression
	:	expression
	;

particle
	:	STRING_LITERAL
	|	NIL
	|	FALSE
	|	TRUE	
	|	RESULT // doljno li eto byt' zdes'?
	|	EXCEPTIONMESSAGE
	|	number
	| 	ident			
	|	parentesizedExpression
	|	constArray
	;

constArray
	: LSQBR expressionList RSQBR	-> ^(CONST_ARRAY expressionList)
	;

	
number
	:	INT
	|	FLOAT
	|	HEX			
	;

expressionOrRangeList
	:	expressionOrRange (COMMA! expressionOrRange)*
	;

parentesizedExpression
	:	LPAREN expression RPAREN	
		-> expression
	;

unaryOperator
	:	NOT
	|	MINUS
	;
	
arrayType
	:	ARRAY (LSQBR e+=expressionOrRange (COMMA e+=expressionOrRange)* RSQBR)? OF type
		-> ^(ARRAY $e* type)
	;
	
type
	:	arrayType
	|	fileType
	|	stringType
	|	ident
	;


stringType
	:	STRING (LSQBR expression RSQBR)?
	;

expressionList
	:	expression (COMMA! expression)*
	;


constSection
	:	CONST constandDecl+	
		-> ^(CONST constandDecl)+
	;

constandDecl
	:	ident EQUAL typedConstant SEMI 
		-> ident typedConstant
	;

typedConstant
	:	expression
	;

	
methodOrProperty
	:	methodHeading
	;


methodHeading
	:	(m=PROCEDURE | m=FUNCTION)
		name=qualifiedIdent
		(LPAREN (p+=parameter (SEMI p+=parameter)*)? RPAREN)?
		(COLON methodReturnType)?
		SEMI
		-> ^($m $name $p* methodReturnType?)
	;


methodReturnType
	:	qualifiedIdent
	|	STRING
	;

parameter
	:	(VAR | CONST | OUT)?
		r=identList (COLON idents+=type)? 
		(EQUAL typedConstant)? {$idents=$r.list;}
		-> ^(FORMAL_PARAMETER $idents type? typedConstant?)+ 
	;

parameterType
	:	qualifiedIdent
	|	STRING
	|	FILE
	;

identList returns [List list]
	:	(i+=ident COMMA?)+ {$list=$i;} 
	;

fileType
	:	FILE
	|	FILE OF qualifiedIdent
	;

qualifiedIdent
	:	ident//ident (DOT ident)*	-> ^(QUALIFIED_IDENT ident+)
	;

	
ident // TODO: keyword needed
	:	ID
	|	keywordAsIdent
	;
	
keywordAsIdent
	: {(input.LT(-1).getType() == DOT)}?
		FILE
	 -> ID[$keywordAsIdent.start]
	;
	
expression
	:	simpleExpression (relOp^ simpleExpression)*
	;
	
relOp
	:	EQUAL
	|	NOT_EQUAL
	|	LT
	|	LE
	|	GE
	|	GT
	|	IN
	;
	
expressionOrRange
	:	simpleExpression (DOTDOT^ simpleExpression)?
	;
	


// Keywords
DIV			:	D I V				;
MOD			:	M O D				;
AND			:	A N D				;
OR			:	O R					;
XOR			:	X O R				;
SHL			:	S H L				;
SHR			: 	S H R				;
NOT			:	N O T				;
ARRAY		:	A R R A Y			;
OF			: 	O F					;
IN			:	I N					;
SET			:	S E T				;
FILE		:	F I L E				;
FOR			:	F O R				;
BEGIN		:	B E G I N			;
END			:	E N D				;
VAR			:	V A R				;
PROCEDURE 	:	P R O C E D U R E	;
FUNCTION	:	F U N C T I O N		;
CONST		: 	C O N S T			;
OUT			: 	O U T				;
FORWARD		:	F O R W A R D		;
STRING		:	S T R I N G			;
NIL			:	N I L				;
USES  		:	U S E S				;
LABEL 		:	L A B E L			;	 
GOTO		:	G O T O				;
IF			:	I F					;
THEN 		:	T H E N				;
ELSE		:	E L S E				;
CASE 		:	C A S E				;
REPEAT		:	R E P E A T			;
UNTIL		:	U N T I L			;
WHILE 		:	W H I L E			;
DO			:	D O					;
TO 			:	T O					;
DOWNTO		:	D O W N T O			;
WITH		:	W I T H				;
TRY			:	T R Y				;
FINALLY		:	F I N A L L Y		;
EXCEPT		:	E X C E P T			;
RAISE		:	R A I S E			;
UNIT		:	U N I T 			;
RESULT		:	R E S U L T			;
EXCEPTIONMESSAGE	: E X C E P T I O N M E S S A G E;
FALSE		:	F A L S E;
TRUE		:	T R U E;
BREAK		:	B R E A K;
	
	
// Operators
PLUS		:	'+'	;
MINUS		:	'-'	;
STAR		:	'*'	;
SLASH		:	'/'	;
AT			: 	'@'	;
LSQBR  		:	'['	;
RSQBR		:	']'	;
LPAREN		:	'('	;
RPAREN		:	')'	;
COMMA		:	','	;
SEMI		:	';'	;
COLON		:	':'	;
EQUAL		:	'='	;
NOT_EQUAL	:	'<>';
LT			:	'<' ;
LE			:	'<=';
GE			:	'>=';
GT			:	'>' ;
ASSIGN		:	':=';
AMPERSAND	:	'&'	;
DOTDOT		:	'..';
DOT			:	'.'	;
POINTER		:	'^'	;


// for case-insensitiveness
fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');
	


//
ID  
	:	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;

fragment
INT 
	:	('0'..'9')+ 
    ;

fragment 
FLOAT
    :   ('0'..'9')+ DOT ('0'..'9')+ EXPONENT?
    |   ('0'..'9')+ EXPONENT
    ;
    
RANGE_OR_INT 
	: (INT DOTDOT) 	=> INT 	 {$type = INT;}
	| (INT DOT INT) => FLOAT {$type = FLOAT;}
	| INT {$type = INT;}
	;
	

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    |   '{' ( options {greedy=false;} : . )* '}' {$channel=HIDDEN;}
    ;

WS  
	:   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;

fragment
CHAR_LITERAL
	:  ( '#' ('0'..'9') (('0'..'9')? ('0'..'9'))? )+
	;
    
STRING_LITERAL
    :	CHAR_LITERAL* '\'' ( '\'\'' | ~('\'') )+ '\'' CHAR_LITERAL*
    |	'\'\'' // empty string. because of interpreter bug(?) TODO: remove
    |	CHAR_LITERAL+
    ;

HEX	
	:	'$' HEX_DIGIT+
	;

fragment
EXPONENT : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;

fragment
HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;

