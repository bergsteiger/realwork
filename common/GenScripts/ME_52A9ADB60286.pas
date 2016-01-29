unit Mask;

interface

uses
 l3IntfUses
 , StdCtrls
;

type
 TCustomMaskEdit = class(TCustomEdit)
  function TextFromClipboard: AnsiString;
 end;//TCustomMaskEdit
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
