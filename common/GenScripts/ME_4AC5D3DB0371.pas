unit eeMemo;

interface

uses
 l3IntfUses
 , evCustomMemo
 , Classes
 , Controls
;

type
 TeeCustomMemo = class(TevCustomMemo)
 end;//TeeCustomMemo
 
 TBevelKind = Controls.TBevelKind;
 
 TeeMemo = class(TeeCustomMemo)
 end;//TeeMemo
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
