unit nevBaseDrawView;

interface

uses
 l3IntfUses
 , nevBaseView
 , nevTools
 , nevBase
 , nevObjectList
 , l3Variant
;

type
 TnevBaseDrawView = class(TnevBaseView, InevScrollListener, InevControlView, InevDrawView, InevViewMetrics)
  function CorrectFoundPoint(const aPoint: InevBasePoint;
   aMode: TnevPointByPtMode): InevBasePoint;
  function MoveCursor(const aPoint: InevBasePoint;
   var aLine: Integer;
   aMode: TnevPointByPtMode): InevBasePoint;
  function NeedScrollShapes: Boolean;
  procedure DoSignalScroll(aTopDiff: Integer;
   aDeltaY: Integer);
  function PointByPtPrim(const aPt: TnevPoint;
   aMode: TnevPointByPtMode): InevBasePoint;
   {* возвращает курсор указывающий на данную точку, в системе координат View. }
  function DiffToLine(const aPt: TnevPoint): Integer;
  function GetCanvas(const anExtent: TnevPoint): InevCanvas;
  function LMargin: Integer;
  function CaretCursor: InevBasePoint;
  function DoDraw(const aBlock: InevRange;
   var theMap: InevMap): Boolean;
  procedure LinkControl(const aControl: InevControl);
  procedure DoUnlinkControl(const aControl: InevControl);
  procedure Signal;
   {* ѕозици€ скроллера изменилась. }
  function LimitWidth: TnevInch;
  function InfoCanvas: InevInfoCanvas;
   {* информационный контекст устройства, дл€ которого надо форматировать параграфы. }
  function IsWebStyle: Boolean;
  function ShowDocumentParts: Boolean;
   {* показывать ли блочную структуру документа? }
  function ShowSpecial: Boolean;
  function HiddenStyles: TnevStandardStyles;
  function Control: InevControl;
   {* контрол, в котором отображаютс€ данные. }
  procedure UnlinkControl(const aControl: InevControl);
   {* отсоедин€ет контрол от области вывода. }
  function IsDocumentTailVisible: Boolean;
  function Draw(const aBlock: InevRange;
   var theMap: InevMap): Boolean;
  function TopAnchor: InevAnchor;
  function PointByPt(const aPt: TnevPoint;
   aForSetCursor: Boolean): InevBasePoint;
   {* ¬озвращает курсор указывающий на данную точку, в системе координат View. }
  function Extent: TnevPoint;
  function ExcludeSuper: TevNormalSegLayerHandleSet;
   {* ќтключаемые при отображении слои }
  function FormatCanvas: InevInfoCanvas;
   {*  анва дл€ форматировани€. [$157450362] }
  function AllowRubberTables: TnevRubberTablesMode;
   {* –азрешены ли резиновые таблицы }
  function IsTagCollapsed(aTag: Tl3Variant): Boolean;
  function Data: InevObjectPrim;
  function BottomAnchor(aSimple: Boolean): InevAnchor;
  function AACLike: TnevAACLikeMode;
  function NeedTotalRecalc: Boolean;
 end;//TnevBaseDrawView
 
implementation

uses
 l3ImplUses
 , l3Const
 , nevFacade
 , SysUtils
 , l3Units
 , l3PrinterIC
 , nevRealTools
 , k2Tags
 , evdStyles
 , evParaTools
;

end.
