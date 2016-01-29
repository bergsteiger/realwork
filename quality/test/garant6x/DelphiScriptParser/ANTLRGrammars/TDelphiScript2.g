tree grammar TDelphiScript2;

options {
	tokenVocab=DelphiScript;
	ASTLabelType=CommonTree;
}

scope SIdCheckControl {
	boolean is_skip;
	EnumSet<IdType> id_type;
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
	
	public TDelphiScript2(Unit unit)
	{
		this(unit.ast);
		this.unit_context = unit.context;
	}
}



tGoal
scope SIdCheckControl;
@init {
	$SIdCheckControl::is_skip = false;
	$SIdCheckControl::id_type = EnumSet.of(IdType.CONST);
}
	:	^(UNIT .* ^(IMPL_DECL tImplementationDecl*) )
	;

tImplementationDecl	
	:	^(CONST tConstantDecl)
	|	^(METHOD_DEF tMethodHeading[false] .*)
	|	^(METHOD_DECL tMethodHeading[true])	
	|	^(VAR tVarDecl)
	|	^(LABEL .*)
	;

tMethodHeading [Boolean is_decl]
	:	^((PROCEDURE|FUNCTION) name=tIdent tFormalParameter* ret_type=tType?)
		{
			if ($is_decl)
				unit_context.MethodDeclared(
					$name.text,
					$name.start.getLine(),
					$name.start.getCharPositionInLine()
				);
			else
				unit_context.MethodDefined(
					$name.text,
					$name.start.getLine(),
					$name.start.getCharPositionInLine()
				);
			
		}
	;

tFormalParameter
	:	^(FORMAL_PARAMETER tIdent tType? tTypedConstant?)
	;

tVarDecl
	:	id=tIdent type=tType?
		{
			unit_context.VarDeclared(
				$id.text,
				$id.start.getLine(),
				$id.start.getCharPositionInLine()
			);
		}
	;

tType
	:	tIdent
	|	^(ARRAY tExpressionOrRange* tType)
	|	(FILE| FILE OF tIdent)
	|	STRING
	;

tExpressionOrRange
	:	^(DOTDOT tExpression tExpression)
	;

tConstSection
	:	^(CONST tConstantDecl)
	;

tConstantDecl
scope SIdCheckControl; 
	:	id=tIdent {$SIdCheckControl::is_skip = true;}tc=tTypedConstant
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
			if (!$SIdCheckControl::is_skip)
				unit_context.IdUsed(
					$tIdent.text,
					$tIdent.start.getLine(),
					$tIdent.start.getCharPositionInLine(),
					$SIdCheckControl::id_type
				);
		}
	|	tNumber
	| 	NIL
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
	


	
