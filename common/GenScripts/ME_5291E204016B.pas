unit kwCFRTF;

interface

uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFRTF = class(TtfwClipboardFormatWord)
  function GetFormat: TevFormat;
 end;//TkwCFRTF
 
implementation

uses
 l3ImplUses
;

end.
