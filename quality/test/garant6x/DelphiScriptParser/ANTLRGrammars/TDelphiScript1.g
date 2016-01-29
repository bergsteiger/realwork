tree grammar TDelphiScript1;

options {
	tokenVocab=DelphiScript;
	ASTLabelType=CommonTree;
}

@header {
	package dsparser.antlr.generated;
	
	import dsparser.worker.*;	
	import dsparser.worker.AllUnits.Unit;	
	import dsparser.worker.BaseContext.IdType;
	import java.util.EnumSet;
}

@members {
	UnitContext unit_context;
	
	public TDelphiScript1(Unit unit)
	{
		this(unit.ast);
		this.unit_context = unit.context;
	}
}



tGoal
	:	^(UNIT .* ^(IMPL_DECL tImplementationDecl*) )
	;

tImplementationDecl	
	:	^(CONST tConstantDecl)
	|	^(METHOD_DEF .*)
	|	^(METHOD_DECL .*)	
	|	^(VAR .*)
	|	^(LABEL .*)
	;

tConstSection
	:	^(CONST tConstantDecl)
	;

tConstantDecl 
	:	id=tIdent tc=tTypedConstant 
		{
			unit_context.ConstDeclared(
				$id.text,
				$id.start.getLine(),
				$id.start.getCharPositionInLine()
			);
		}
	;

tTypedConstant
	:	tExpression
	;
	

tExpression
options {
	backtrack = true;
	memoize  = true;
}
	:	tAtom
	|	^(tRelOp tExpression tExpression)
	|	^(tMulOp tExpression tExpression)
	|	^(tAddOp tExpression tExpression)
	|	^(tUnaryOperator tExpression)
	;
	
tAtom
	:	tIdent 
		{
			unit_context.IdUsed(
				$tIdent.text,
				$tIdent.start.getLine(),
				$tIdent.start.getCharPositionInLine(),
				EnumSet.of(IdType.CONST)
			);
		}
	|	tNumber
	|	NIL
	|	TRUE
	|	FALSE
	|	STRING_LITERAL			
	;
	
tNumber
	:	INT
	|	FLOAT
	|	HEX			
	;	

tUnaryOperator
	:	NOT
	|	MINUS
	;

tAddOp
	:	PLUS
	|	MINUS
	|	OR
	|	XOR
	;

tMulOp
	:	STAR
	|	SLASH
	|	DIV
	|	MOD
	|	AND
	|	SHL
	|	SHR
	;
	
tRelOp
	:	EQUAL
	|	NOT_EQUAL
	|	LT
	|	LE
	|	GE
	|	GT
	|	IN
	;	

tIdent
	:	ID
	;
	


	
