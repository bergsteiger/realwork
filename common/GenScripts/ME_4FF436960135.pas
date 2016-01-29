unit kwCFXML;

interface

uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFXML = class(TtfwClipboardFormatWord)
  function GetFormat: TevFormat;
 end;//TkwCFXML
 
implementation

uses
 l3ImplUses
;

end.
