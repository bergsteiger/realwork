unit kwDualCompiledWordContainer;

interface

uses
 l3IntfUses
 , kwCompiledWordContainer
 , tfwScriptingInterfaces
;

type
 TkwDualCompiledWordContainer = class(TkwCompiledWordContainer)
  {* ��������� ��� �������� ������ ���������������� ���� (begin end) }
  procedure Create(aIf: TtfwWord;
   aElse: TtfwWord;
   const aCtx: TtfwContext);
 end;//TkwDualCompiledWordContainer
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , tfwClassRef
;

end.
