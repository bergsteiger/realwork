unit evParaListPainter.imp;

interface

uses
 l3IntfUses
 , nevRealTools
 , nevTools
;

type
 _evParaListPainter_ = class(_evParaPainter_)
  {* Рисователь списка параграфов }
  procedure AfterDrawChild(const aChild: InevPara;
   const aChildPainter: IevPainter;
   const aChildInfo: TnevShapeInfo);
  procedure MakeBottomAnchorInnerAfterEnd(const anInner: InevBasePoint);
   {* Метод сделан, чтобы не тащить связь от Cursors в ParaListPainters }
  procedure CheckNeedLaterFilling(const aPainterHolder: InevPaintersHolder;
   const aChildMap: InevMap);
  function BeforeDrawChild(const ChildPainter: IevPainter): Boolean;
   {* Вызывается перед рисованием каждого дочернего параграфа. }
  function ChildInSelection(const aPara: InevPara): Boolean;
  function NeedCheckTopAnchor: Boolean;
  function CheckCompleate: Boolean;
   {* [$114950787] }
  procedure CheckChild(const aPara: InevPara);
  function Check4Printing(aHeight: Integer): Boolean;
  function UseSelRange(const aSelRange: InevRange): Boolean;
  procedure InitInnerBottom(const aChildInfo: TnevShapeInfo);
  function NeedPrintingChild(const aChild: InevPara): Boolean;
 end;//_evParaListPainter_
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3InternalInterfaces
 , l3VirtualCanvas
 , nevVirtualDrawView
 , l3Units
 , evParaDrawTools
 , nevAfterEndPoint
 , l3MinMax
 , nevFacade
 , l3Const
 , Graphics
 , l3SmartCanvas
 , l3Base
 , l3Tree
 , evParaTools
 , evdTypes
 , TableCell_Const
 , DocumentSub_Const
 , Mark_Const
 , LeafPara_Const
 , CommentPara_Const
 , Block_Const
 , TextPara_Const
 , k2Base
 , SysUtils
 , Table_Const
 , Windows
;

end.
