unit evMemo;

interface

uses
 l3IntfUses
 , evCustomMemo
;

type
 TevMemo = class(TevCustomMemo)
  {* Мемо-поле. (С published свойствами) }
 end;//TevMemo
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
