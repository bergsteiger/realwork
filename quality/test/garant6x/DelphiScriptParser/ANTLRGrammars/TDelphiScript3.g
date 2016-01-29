tree grammar TDelphiScript3;

options {
	tokenVocab=DelphiScript;
	ASTLabelType=CommonTree;
}

scope SIdCheckControl {
	EnumSet<IdType> id_type;
}

scope SMethod {
	MethodContext context;
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
	MethodContext method_context;
	boolean is_dont_check_next_ident;
	boolean is_dont_check_ident;
	
	public TDelphiScript3(Unit unit)
	{
		this(unit.ast);
		this.unit_context = unit.context;
		is_dont_check_next_ident = false;
		is_dont_check_ident = false;
	}
}



tGoal
scope SIdCheckControl;
@init {
	$SIdCheckControl::id_type = EnumSet.of(IdType.CONST, IdType.VAR, IdType.METHOD, IdType.UNIT);
}
	:	^(UNIT tUses? ^(IMPL_DECL tImplementationDecl*) )
	;

tUses
	:	^(USES 
			(tIdent {
				unit_context.UnitUsed(
					$tIdent.text,	
					$tIdent.start.getLine(),
					$tIdent.start.getCharPositionInLine()
				);}
			)+
		 )
	;

tImplementationDecl	
	:	^(CONST tConstantDecl)
	|	tMethodDef
	|	^(METHOD_DECL .*) //tMethodHeading)	
	|	^(VAR tVarDecl)
	|	^(LABEL .*)
	;

tMethodDef
scope SMethod;
	:	^(METHOD_DEF tMethodHeading tFancyBlock)
	;

tFancyBlock
	:	^(IMPL_DECL tImplementationDecl*) tBlock
	;

tBlock
	:	^(BLOCK tStatement*)
	;

tStatement
	:	(^(COLON tLabelId))? (
			tExpression
		|	tAssign
		|	^(GOTO tLabelId)
		|	tBlock
		|	^(CASE tExpression tCaseSelector+ (^(ELSE tStatement?))? )
		|	^(REPEAT ^(BLOCK tStatement*) tExpression)
		|	^(WHILE tExpression tStatement?)
		|	^(FOR tIdent tExpression (TO|DOWNTO) tExpression tStatement)
		|	tWithStatement
		|	^(TRY ^(BLOCK tStatement*) ^((FINALLY|EXCEPT) tStatement*) )
		|	^(RAISE tExpression?)
		|	^(IF tExpression ^(THEN tStatement?) (^(ELSE tStatement?))?)
		|	BREAK
	)
	;

tWithStatement
scope SIdCheckControl;
	:	^(WITH 
			{
				$SIdCheckControl::id_type = EnumSet.of(IdType.VAR, IdType.CONST, IdType.METHOD, IdType.UNIT);
			}
			tExpression 
			
			{
				is_dont_check_ident = true;
			}
			tStatement?
			{
				is_dont_check_ident = false;
			}			
		)
	;

tAssign
scope SIdCheckControl;
	:	^(ASSIGN 
			{
				$SIdCheckControl::id_type = EnumSet.of(IdType.VAR);	
			}
				tExpression 
			{
				$SIdCheckControl::id_type = EnumSet.of(IdType.VAR, IdType.CONST, IdType.METHOD);	
			}
				tExpression
		)
	;

tCaseSelector
	:	^(CASE_SELECTOR tExpressionOrRange+ ^(BLOCK tStatement?))
	;

tLabelId
	:	INT
	|	tIdent
	;

tMethodHeading
	:	^((PROCEDURE|FUNCTION) name=tIdent 
			{
				if ($SMethod.size() > 0)
					$SMethod::context = unit_context.MethodDefined(
						$name.text,
						$name.start.getLine(),
						$name.start.getCharPositionInLine()
				);
			}
		tFormalParameter* ret_type=tType?)
	;

tFormalParameter
	:	^(FORMAL_PARAMETER id=tIdent tType? tTypedConstant?)
		{
			$SMethod::context.VarDeclared(
				$id.text,
				$id.start.getLine(),
				$id.start.getCharPositionInLine()
			);
		}
	;

tVarDecl
	:	id=tIdent type=tType?
		{
			if ($SMethod.size() > 0) 
				$SMethod::context.VarDeclared(
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
	:	tExpression
	|	^(DOTDOT tExpression tExpression)
	;

tConstSection
	:	^(CONST tConstantDecl)
	;

tConstantDecl
scope SIdCheckControl; 
	:	id=tIdent 
		{
			if ($SMethod.size() > 0) 
				$SMethod::context.ConstDeclared(
					$id.text,
					$id.start.getLine(),
					$id.start.getCharPositionInLine()
				);
		}
		
		{
			$SIdCheckControl::id_type = EnumSet.of(IdType.CONST);
		}
		tc=tTypedConstant
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
	|	tQualifiedAccess
	|	tMethodCall
	|	^(INDEX tAtom tExpression+)
	|	^(CONST_ARRAY tExpression+) 
	;
	
tAtom
	:	tIdent 
		{
			if (!is_dont_check_next_ident)
			{
				if (!is_dont_check_ident && ($SMethod.size() > 0)) 
					$SMethod::context.IdUsed(
						$tIdent.text.replaceAll("\\(\\s*(.*?)\\s*\\)", "$1").replaceAll("(.*?);", "$1"),
						$tIdent.start.getLine(),
						$tIdent.start.getCharPositionInLine(),
						$SIdCheckControl::id_type
				);
			}
			else
				is_dont_check_next_ident = false;
							
		}
	|	tNumber
	| 	NIL
	|	TRUE
	|	FALSE
	|	EXCEPTIONMESSAGE
	|	RESULT
	|	STRING_LITERAL			
	;

tMethodCall
scope SIdCheckControl;
	:	^(METHOD_CALL 
			{	
				$SIdCheckControl::id_type = EnumSet.of(IdType.METHOD);
			} 
				tAtom 
			{	
				$SIdCheckControl::id_type = EnumSet.of(IdType.METHOD, IdType.VAR, IdType.CONST, IdType.UNIT);
			}	
			tExpression*)
	;

tQualifiedAccess
scope SIdCheckControl; 
	:	^(QUALIFIED_ACCESS 
			{
				$SIdCheckControl::id_type = EnumSet.of(IdType.VAR, IdType.METHOD, IdType.UNIT);
			}
				tExpression
			{	
				is_dont_check_next_ident = true;
			}	
				tExpression
		)
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
	


	
