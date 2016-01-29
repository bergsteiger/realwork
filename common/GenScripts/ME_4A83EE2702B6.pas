unit vtComboBoxQS;

interface

uses
 l3IntfUses
 , vtComboTree
 , Classes
;

type
 TCustomComboTree = class(TvtComboTree)
  procedure EndTextPrint;
 end;//TCustomComboTree
 
 TvtComboBoxQS = class(TCustomComboTree)
 end;//TvtComboBoxQS
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
