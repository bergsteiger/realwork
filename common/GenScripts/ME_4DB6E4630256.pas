unit kwCompiledWordContainer;

interface

uses
 l3IntfUses
 , kwSourcePointWord
 , tfwScriptingInterfaces
;

type
 TkwCompiledWordContainer = class(TkwSourcePointWord)
  {* ��������� ��� ����������������� ����. }
  procedure Create(aCompiled: TtfwWord;
   const aCtx: TtfwContext);
 end;//TkwCompiledWordContainer
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
