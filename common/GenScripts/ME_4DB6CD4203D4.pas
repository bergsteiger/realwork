unit kwString;

interface

uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , l3Interfaces
 , tfwScriptingInterfaces
 , TypInfo
;

type
 TkwString = class(TtfwRegisterableWordPrim)
  {* ѕомещает значение в стек как строковое. }
  procedure Create(const aValue: Il3CString);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwString
 
implementation

uses
 l3ImplUses
 , tfwScriptingTypes
;

end.
