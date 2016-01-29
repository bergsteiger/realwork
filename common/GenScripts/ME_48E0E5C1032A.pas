unit nevControl;

interface

uses
 l3IntfUses
 , afwControl
 , nevBase
 , nevTools
 , evdStyles
 , l3Units
 , Types
 , l3Core
 , l3Interfaces
 , l3Variant
;

type
 TnevControl = class(TafwControl, InevViewMetrics, InevControl)
  function GetInfoCanvas: InevInfoCanvas;
  function GetLimitWidth: Integer;
  procedure DoChanged(aPlace: TnevChangePlace);
   {* Данные для отображения изменились }
  procedure DoSignalScroll(aDeltaY: Integer;
   aNeedVert: Boolean);
  function DoCloseQuery: Boolean;
  procedure DoCursorChanged;
  procedure DoSetFlag(aFlag: TevUpdateWindowFlag);
  function GetData: InevObject;
  function GetProcessor: InevProcessor;
  function GetSelection: InevSelection;
  function GetAllowMultiSelect: Boolean;
  function GetViewArea: InevViewArea;
  function GetLMargin: Integer;
  function GetView: InevInputView;
  function GetCanScroll: Boolean;
  function GetMousePos(var aPt: Tl3SPoint): Tl3Point;
  function DP2LP(const aPoint: TPoint;
   fromScreen: Boolean): Tl3Point;
  procedure WebStyleChanged;
  procedure DoParaChange;
   {* Нотификация о смене параграфа. }
  procedure DoForceRepaint;
  function GetInClose: Boolean;
  function LimitWidth: TnevInch;
  function InfoCanvas: InevInfoCanvas;
   {* информационный контекст устройства, для которого надо форматировать параграфы. }
  function IsWebStyle: Boolean;
  function ShowDocumentParts: Boolean;
   {* показывать ли блочную структуру документа? }
  function ShowSpecial: Boolean;
  function HiddenStyles: TnevStandardStyles;
  procedure InvalidateRect(const aRect: TnevRect);
   {* сообщает контролу о необходимости перерисовки указанного прямоугольника, когда-нибудь в будущем. }
  procedure SignalScroll(aDeltaY: Integer;
   aNeedVert: Boolean);
   {* сообщает контролу, о том, что изменилась позиция скроллера. }
  function GetDelphiControl: TComponent;
  function CloseQuery: Boolean;
   {* спрашивает контрол, о возможности закрытия окна, которому он принадлежит. }
  function LP2DP(const aPoint: TnevPoint;
   toScreen: Boolean): TPoint;
  procedure CursorChanged;
  function CanScroll: Boolean;
  procedure SetFlag(aFlag: TevUpdateWindowFlag);
   {* установить флаг aFlag. }
  procedure UpdateCaretAndInvalidate;
   {* Проверить и переставить каретку + перерисоваться }
  function Data: InevObject; overload;
  function Processor: InevProcessor;
   {* процессор операций. }
  function WindowExtent: TnevSPoint;
   {* размеры окна в точках. }
  function Metrics: InevViewMetrics;
   {* метрики отображения. }
  function DrawCanvas: InevCanvas;
   {* канва для вывода. }
  function MousePos: TnevPoint;
   {* позиция мыши. }
  function Selection: InevSelection;
   {* выделение. }
  function CommandProcessor: InevCommandProcessor;
  function LMargin: Integer;
  function AllowMultiSelect: Boolean;
  function ViewArea: InevViewArea;
  function View: InevInputView;
  function Extent: TnevPoint;
  procedure ParaChanged;
   {* Нотификация о смене текущего параграфа. }
  function ActiveElement: InevActiveElement;
   {* Активный элемент (тот в котором находится мышь) }
  procedure DoStyleTableChanged;
  function ExcludeSuper: TevNormalSegLayerHandleSet;
   {* Отключаемые при отображении слои }
  function ForceDrawFocusRect: Boolean;
   {* Форсировать ли рисование рамки у текущего параграфа редактора }
  function FormatCanvas: InevInfoCanvas;
   {* Канва для форматирования. [$157450362] }
  procedure ForceRepaint;
   {* По жёсткому перерисовать сожержимое контрола (прямо внутри операции редактирования). Нужно для http://mdp.garant.ru/pages/viewpage.action?pageId=204113269 }
  function AllowRubberTables: TnevRubberTablesMode;
   {* Разрешены ли резиновые таблицы }
  function IsTagCollapsed(aTag: Tl3Variant): Boolean;
  function Data: InevObjectPrim; overload;
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* Разрешает ли контейтер документа применять указанное декорирование }
  function InClose: Boolean;
   {* Редактор в процессе закрытия. }
  function AACLike: TnevAACLikeMode;
  function NeedTotalRecalc: Boolean;
 end;//TnevControl
 
implementation

uses
 l3ImplUses
 , afwInterfaces
 , nevFacade
 , k2Tags
 , k2Base
 , l3MinMax
 , Messages
 , TextPara_Const
 , l3Defaults
 , l3InternalInterfaces
 , TtfwClassRef_Proxy
 , evStyleTableSpy
;

end.
