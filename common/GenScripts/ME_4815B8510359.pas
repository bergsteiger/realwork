unit nevListFormatInfo;

interface

uses
 l3IntfUses
 , nevParaFormatInfo
 , nevFormatInfoArray
 , nevTools
 , nevFormatInfo
 , nevBase
;

type
 TnevListFormatInfo = class(_nevChildSpy_)
  function AllowTotalRecalc: Boolean;
  procedure RecalcImpl;
  procedure FormatChild(const anAtom: InevPara;
   var theMap: TnevFormatInfo);
  procedure HRecalcChild(const aChild: InevPara;
   var sPW: Integer;
   var sPH: Integer);
  procedure CellChanged;
  function NearestInfoForChild(const aChild: InevObject): TnevListFormatInfo;
  function ChildWidth(aChild: TnevFormatInfo): Integer;
  procedure ChildrenChanged;
   {* Нотификация о смене состава детей. }
  procedure ChildAdded(const aList: InevParaList;
   const aChild: InevPara);
  procedure ChildDeleted(const aList: InevParaList;
   const aChild: InevPara);
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//TnevListFormatInfo
 
implementation

uses
 l3ImplUses
 , SysUtils
 , nevLeafRenderInfo
 , nevTextParaRenderInfo
 , nevRubberCellsRenderInfo
 , nevTableRowRenderInfo
 , k2Tags
 , evParaTools
 , nevTableCellFormatInfo
 , l3MinMax
 , TableRow_Const
 , CommentPara_Const
 , SBS_Const
 , SBSRow_Const
 , ReqRow_Const
 , TableCell_Const
 , SBSCell_Const
 , TextPara_Const
 , nevZoomedCellsRenderInfo
 , nevFacade
 , nevZoomedRubberCellsRenderInfo
 , evSectionPara
 , nevFormatInfoFactory
 , k2Base
 , Table_Const
;

end.
