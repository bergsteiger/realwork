unit ddTableConvTypes;

interface

uses
 l3IntfUses
;

type
 TddCellSeparator = (
  csGraphic
  , csParagraph
  , csTab
  , csSemicolon
  , csSpace
  , csOther
 );//TddCellSeparator
 
 TddAutoFitBehavior = (
  afEqual
  , afContent
 );//TddAutoFitBehavior
 
implementation

uses
 l3ImplUses
;

end.
