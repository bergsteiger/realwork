unit evEdit;

interface

uses
 l3IntfUses
 , evCustomEdit
;

type
 TevEdit = class(TevCustomEdit)
  {* Строка ввода. (C published свойствами). }
 end;//TevEdit
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
