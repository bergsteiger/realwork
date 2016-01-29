unit evColumnBorderMarker;

interface

uses
 l3IntfUses
 , evMarker
 , evInternalInterfaces
 , nevTools
 , l3Variant
 , l3Interfaces
 , nevBase
 , k2ToolPrim
;

type
 RevColumnMarkerClass = class of TevColumnBorderMarker;
 
 TevColumnBorderMarker = class(TevMarker, IevColumnBorderMarker)
  procedure Create(const aView: InevView;
   aPara: Tl3Variant;
   aColumnID: Integer;
   const aHint: Il3CString);
  function ColumnID: Integer;
   {* Номер ячейки для которой построен данный маркер (начиная с 1) }
 end;//TevColumnBorderMarker
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , nevFacade
 , k2Tags
 , SysUtils
;

end.
