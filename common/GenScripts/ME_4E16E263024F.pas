unit nevFormatInfoFactory;

interface

uses
 l3IntfUses
 , nevFormatInfo
 , nevBase
;

type
 TnevFormatInfoFactory = class
  function CreateFormatInfo(const aChild: InevObjectPrim;
   aParent: TnevFormatInfo;
   const aMetrics: InevViewMetrics): TnevFormatInfo;
 end;//TnevFormatInfoFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , TextPara_Const
 , CommentPara_Const
 , SBS_Const
 , SBSRow_Const
 , TableRow_Const
 , ReqRow_Const
 , SBSCell_Const
 , TableCell_Const
 , nevFacade
 , nevTableCellFormatInfo
 , evParaTools
 , l3MinMax
 , evSectionPara
 , nevListFormatInfo
 , nevRubberCellsRenderInfo
 , nevTableRowRenderInfo
 , nevTextParaRenderInfo
 , nevZoomedCellsRenderInfo
 , nevZoomedRubberCellsRenderInfo
 , nevLeafRenderInfo
 , Block_Const
 , Document_Const
 , nevDocumentPartFormatInfo
 , nevCommentFormatInfo
 , nevBitmapFormatInfo
 , nevControlFormatInfo
 , nevFormulaFormatInfo
 , Formula_Const
 , ControlPara_Const
 , BitmapPara_Const
 , nevControlsBlockFormatInfo
 , nevCloakFormatInfo
 , ControlsBlock_Const
 , Cloak_Const
 , nevSegmentFormatInfo
 , TextSegment_Const
 , nevObjectSegmentFormatInfo
 , ObjectSegment_Const
 , nevDocumentFormatInfo
 , k2Base
 , nevSBSCellFormatInfo
 , nevSBSRowFormatInfo
 , nevTableRowRenderInfoEx
 , nevReqRowFormatInfo
 , nevPageBreakFormatInfo
 , PageBreak_Const
 , nevNodeGroupFormatInfo
 , NodeGroup_Const
;

end.
