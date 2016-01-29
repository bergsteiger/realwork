unit nscStatusBarDelimiterDef;

interface

uses
 l3IntfUses
 , nscStatusBarItemDef
 , nscNewInterfaces
;

type
 TnscStatusBarDelimiterDef = class(TnscStatusBarItemDef, InscStatusBarDelimiterDef)
  procedure Create(aSeparatorVisible: Boolean;
   aSeparatorPos: TsbdSeparatorPos;
   aWidth: Integer);
  procedure Make(aSeparatorVisible: Boolean;
   aSeparatorPos: TsbdSeparatorPos;
   aWidth: Integer);
  function SeparatorPos: TsbdSeparatorPos;
  function IsSeparatorVisible: Boolean;
  function Width: integer;
 end;//TnscStatusBarDelimiterDef
 
implementation

uses
 l3ImplUses
;

end.
