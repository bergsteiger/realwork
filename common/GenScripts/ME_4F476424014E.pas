unit IncludesAndUsesPack;

interface

uses
 l3IntfUses
 , tfwIncludeLike
 , tfwScriptingInterfaces
 , kwUsesLike
 , kwIncluded
;

type
 TkwInclude = class(TtfwIncludeLike)
  {* ����������������� �����: INCLUDE
������:
[code]
 INCLUDE 'Included.script'
[code] }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwInclude
 
 TkwUses = class(TkwUsesLike)
  {* ���������� ������� ������� � ������:
������:
[code]
USES
 DocumentNumbers.script
;
[code] }
 end;//TkwUses
 
 TkwINCLUDES = class(TkwUsesLike)
  {* ��� USES, �� ��������� �������� ����� �� ���������� ������� - ������ ����� ���� ������� }
 end;//TkwINCLUDES
 
 TkwIncludesInChildren = class(TkwUsesLike)
  {* ��� USES, �� ��������� �������� ����� �� ���������� ������� - � ������� ����� (%C) - ������ ����� ���� ������� }
 end;//TkwIncludesInChildren
 
implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , l3String
 , kwInnerIncluded
 , kwInnerIncludedInChildren
 , kwCompiledProcedure
 , kwCompiledWord
 , kwCompiledWordPrim
 , SysUtils
;

end.
