unit nevSBSRowFormatInfo;

interface

uses
 l3IntfUses
 , nevRubberCellsRenderInfo
 , nevBase
;

type
 TnevSBSRowFormatInfo = class(TnevRubberCellsRenderInfo)
  function CalcNewWidth(aParentWidth: Integer;
   aValue: Integer): Integer;
  function ParentWidth: Integer;
   {* Ўирина дл€ вычислений. }
 end;//TnevSBSRowFormatInfo
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Math
 , l3MinMax
 , nevTools
 , evSectionPara
 , evConst
;

end.
