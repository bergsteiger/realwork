unit kwCFEVERESTBIN;

interface

uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFEVERESTBIN = class(TtfwClipboardFormatWord)
  function GetFormat: TevFormat;
 end;//TkwCFEVERESTBIN
 
implementation

uses
 l3ImplUses
;

end.
