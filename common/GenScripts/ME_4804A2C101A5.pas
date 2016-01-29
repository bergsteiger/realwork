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
  {* ������� ���������� ����������� ��� ��������� ���������. }
  function NeedsHackK235870994: Boolean;
  function ControlInfo: TnevControlInfo;
  procedure FillUnfilled(const aRect: Tl3Rect);
   {* �������� ������� ���������, ������� �� ���� ������ }
  procedure DrawBlockSub;
  procedure DrawDecorObject(aDecorObj: Tl3Variant;
   aCollapsed: Boolean;
   aDecorType: TnevDecorType); overload;
   {* ������ ������������ ������� ��������� }
  procedure DrawDecorObject(aCollapsed: Boolean;
   aTop: Boolean); overload;
  function HackMargin: Integer;
   {* ������, ������� �� ���� �������� ����� �������� }
  procedure CheckFormatInfo;
  function GetBackColor: TnevColor;
  function Make(aTag: Tl3Variant): IevPainter;
  function BeginDraw: Boolean;
  procedure EndDraw;
  procedure Push;
  procedure Pop;
  procedure DoInitAlignObjects;
   {* ������������� ������������ �������. }
  procedure DoFinisAlignObjects;
   {* ������������� ������������ �����. }
  procedure PushWO;
  procedure PopWO;
  procedure PushFC;
  procedure PopFC;
  procedure PushBC;
  procedure PopBC;
  function TopBC: TnevColor;
  procedure DrawFrame;
   {* ��������� ��������� ������� ����� ������ ���������. }
  procedure DrawFramePrim;
   {* ���������� �����. }
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
   {* ���������� ��������� ��������� ���������. ��� ���������� � ��������. }
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
   {* ������ ����� �����. }
  function Draw(const anArea: TnevShapeArea;
   const aPoints: TnevShapePoints;
   out theInfo: TnevShapeInfo): Boolean;
  function ParentPainter: IevPainter;
   {* ���������� ��� ��������� ������� ����� �������� ������. }
  function CurrentBlock: InevRange;
  function DrawingTopmostChild: Boolean;
   {* �������� ����� ������� �������? }
  function DrawingLastChild: Boolean;
   {* �������� ����� ��������� �������? }
  function ParaMarkStyle: TevParaMarkStyle;
   {* ����� ��������� ����� ���������. }
  function PaintersHolder: InevPaintersHolder;
  function TablePainter: IevTablePainter;
  function TableRowPainter: IevTableRowPainter;
   {* ���������� ��� ��������� ������ ������� (�������� ������ ��� ��������� ������). }
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
