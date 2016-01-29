unit TtfwClassRef_Proxy;

interface

uses
 l3IntfUses
 //#UC START# *561F9F9400BCintf_uses*
 {$IfNDef NoScripts}
 ,
 tfwClassRef
 {$EndIf  NoScripts}
 //#UC END# *561F9F9400BCintf_uses*
;

//#UC START# *561F9F9400BCintf_code*

{$IfNDef NoScripts}
type
 TtfwClassRef = tfwClassRef.TtfwClassRef;
{$EndIf  NoScripts}

//#UC END# *561F9F9400BCintf_code*

implementation

uses
 l3ImplUses
 //#UC START# *561F9F9400BCimpl_uses*
 //#UC END# *561F9F9400BCimpl_uses*
;

//#UC START# *561F9F9400BCimpl_code*
//#UC END# *561F9F9400BCimpl_code*

end.