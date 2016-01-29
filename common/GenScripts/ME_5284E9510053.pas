unit kwCompiledIfElse;

interface

uses
 l3IntfUses
 , kwCompiledIF
 , tfwScriptingInterfaces
;

type
 TkwCompiledIfElse = class(TkwCompiledIF)
  procedure Create(aCondition: TtfwWord;
   anIf: TtfwWord;
   anElse: TtfwWord;
   const aCtx: TtfwContext);
  procedure SetElse(anElse: TtfwWord);
 end;//TkwCompiledIfElse
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
