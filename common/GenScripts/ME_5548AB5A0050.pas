unit kwCFPDF;

interface

uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFPDF = class(TtfwClipboardFormatWord)
  function GetFormat: TevFormat;
 end;//TkwCFPDF
 
implementation

uses
 l3ImplUses
;

end.
