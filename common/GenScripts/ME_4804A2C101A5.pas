unit evParaPainter.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , nevRealTools
 , nevTools
 , l3InternalInterfaces
 , nevBase
 , l3Variant
 , l3Units
;

type
 _evParaPainter_ = class(_nevTinyParaXTool_, Il3FrameTextPainter, InevDrawingShape, IevPainter, InevK235870994Hacker)
  {* Базовая реализация инструмента для рисования параграфа. }
  function NeedsHackK235870994: Boolean;
  function ControlInfo: TnevControlInfo;
  procedure FillUnfilled(const aRect: Tl3Rect);
   {* Заливает область параграфа, которая не была залита }
  procedure DrawBlockSub;
  procedure DrawDecorObject(aDecorObj: Tl3Variant;
   aCollapsed: Boolean;
   aDecorType: TnevDecorType); overload;
   {* Рисует декроативный элемент параграфа }
  procedure DrawDecorObject(aCollapsed: Boolean;
   aTop: Boolean); overload;
  function HackMargin: Integer;
   {* Отступ, который не надо заливать цетом родителя }
  procedure CheckFormatInfo;
  function GetBackColor: TnevColor;
  function Make(aTag: Tl3Variant): IevPainter;
  function BeginDraw: Boolean;
  procedure EndDraw;
  procedure Push;
  procedure Pop;
  procedure DoInitAlignObjects;
   {* Инициализация выравнивания объекта. }
  procedure DoFinisAlignObjects;
   {* Окончательное выравнивание рамок. }
  procedure PushWO;
  procedure PopWO;
  procedure PushFC;
  procedure PopFC;
  procedure PushBC;
  procedure PopBC;
  function TopBC: TnevColor;
  procedure DrawFrame;
   {* Процедура рисования видимой рамки вокруг параграфа. }
  procedure DrawFramePrim;
   {* Нарисовать рамку. }
  function InfiniteFrame: Boolean;
  procedure DoFillSelection;
  procedure CheckAlignment(var aFrame: Tl3Frame);
  procedure SetDrawnBottom;
  procedure DoDrawLines;
  procedure GetFramePart(aFrame: Tl3Variant;
   anIndex: Tl3FramePartIndex;
   var thePart: TnevFramePart);
  procedure GetFramePartPrim(aFrame: Tl3Variant;
   anIndex: Tl3FramePartIndex;
   var thePart: TnevFramePart);
  function DoDraw: Boolean;
   {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
  procedure DrawSubs;
  procedure evDrawSub(aLayerID: Integer;
   aSub: Tl3Variant;
   const aPara: InevPara);
  procedure InitBottom(var theBottom: InevBasePoint;
   var theCellBottom: InevBasePoint);
  procedure FocusRect(const aRect: Tl3SRect);
  procedure DoDrawFrameText(aTop: Boolean);
  procedure DoDrawFramePrim(const aFrame: Tl3Frame);
  function GetPaintersHolder: InevPaintersHolder;
  function GetTablePainter: IevTablePainter;
  function GetTableRowPainter: IevTableRowPainter;
  function IsTopAnchorAtStart: Boolean;
  procedure DrawFrameText(aTop: Boolean);
   {* Рисует текст рамки. }
  function Draw(const anArea: TnevShapeArea;
   const aPoints: TnevShapePoints;
   out theInfo: TnevShapeInfo): Boolean;
  function ParentPainter: IevPainter;
   {* инструмент для рисования объекта более верхнего уровня. }
  function CurrentBlock: InevRange;
  function DrawingTopmostChild: Boolean;
   {* рисуется самый верхний ребенок? }
  function DrawingLastChild: Boolean;
   {* рисуется самый последний ребенок? }
  function ParaMarkStyle: TevParaMarkStyle;
   {* Стиль рисования конца параграфа. }
  function PaintersHolder: InevPaintersHolder;
  function TablePainter: IevTablePainter;
  function TableRowPainter: IevTableRowPainter;
   {* Инструмент для рисования строки таблицы (доступен только при отрисовке строки). }
  function HackK235870994(const aMap: InevMap): Boolean;
  function Obj: InevObjectPrim;
  function IsSelectedOneWholePara(const aPara: InevPara): Boolean;
 end;//_evParaPainter_
 
implementation

uses
 l3ImplUses
 , Graphics
 , l3SmartCanvas
 , k2Tags
 , l3MinMax
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
