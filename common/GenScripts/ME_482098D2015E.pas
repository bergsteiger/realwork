unit nevRubberCellsRenderInfo;

interface

uses
 l3IntfUses
 , nevTableRowRenderInfo
 , l3LongintList
 , nevFormatInfo
;

type
 TnevRubberCellsRenderInfo = class(TnevTableRowRenderInfo)
  function WasChanged: Boolean;
  procedure ClearChangedFlag;
  procedure ValidateNewChildWidth(anOldWidth: Integer;
   var theNewWidth: Integer);
 end;//TnevRubberCellsRenderInfo
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Math
 , l3MinMax
 , evConst
;

end.
