unit kwCFHTML;

interface

uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFHTML = class(TtfwClipboardFormatWord)
  function GetFormat: TevFormat;
 end;//TkwCFHTML
 
implementation

uses
 l3ImplUses
;

end.
