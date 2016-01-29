unit kwCFEVEREST;

interface

uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFEVEREST = class(TtfwClipboardFormatWord)
  function GetFormat: TevFormat;
 end;//TkwCFEVEREST
 
implementation

uses
 l3ImplUses
;

end.
