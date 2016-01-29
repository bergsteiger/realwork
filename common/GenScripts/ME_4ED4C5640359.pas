unit evTableRowCursor;

interface

uses
 l3IntfUses
 , evParaListCursor
 , evColumnBorderMarker
 , nevTools
 , nevBase
;

type
 TevTableRowCursor = class(TevParaListCursor)
  function GetColumnMarkerClass: RevColumnMarkerClass;
 end;//TevTableRowCursor
 
implementation

uses
 l3ImplUses
 , nevInterfaces
 , l3Base
 , evdTypes
 , k2Tags
 , l3Variant
;

end.
