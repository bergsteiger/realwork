unit kwModifier;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwTypeInfo
 , tfwScriptingInterfaces
;

type
 TkwModifier = class(TtfwRegisterableWord)
  {* Поддержка модификаторов. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwModifier
 
implementation

uses
 l3ImplUses
;

end.
