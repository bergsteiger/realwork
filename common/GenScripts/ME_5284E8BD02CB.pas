unit CodeBranchingPack;

interface

uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwRULES = class(TtfwBeginLikeWord)
  {* ������ CASE � ��������������� � MDP. ���� ������� �����������, �� ����������� ��������� �� ��� �������� � �������������� ����� }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwRULES
 
implementation

uses
 l3ImplUses
 , kwIfElse
 , kwElse
 , kwCASE
 , kwDEFAULT
 , kwRAISE
 , kwBracketBegin
 , kwBEGIN
 , tfwScriptingTypes
 , kwCompiledRules
 , kwStandardProcedureCloseBracket
;

end.
