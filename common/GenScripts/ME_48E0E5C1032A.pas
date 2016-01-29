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
   {* ������ ��� ����������� ���������� }
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
   {* ����������� � ����� ���������. }
  procedure DoForceRepaint;
  function GetInClose: Boolean;
  function LimitWidth: TnevInch;
  function InfoCanvas: InevInfoCanvas;
   {* �������������� �������� ����������, ��� �������� ���� ������������� ���������. }
  function IsWebStyle: Boolean;
  function ShowDocumentParts: Boolean;
   {* ���������� �� ������� ��������� ���������? }
  function ShowSpecial: Boolean;
  function HiddenStyles: TnevStandardStyles;
  procedure InvalidateRect(const aRect: TnevRect);
   {* �������� �������� � ������������� ����������� ���������� ��������������, �����-������ � �������. }
  procedure SignalScroll(aDeltaY: Integer;
   aNeedVert: Boolean);
   {* �������� ��������, � ���, ��� ���������� ������� ���������. }
  function GetDelphiControl: TComponent;
  function CloseQuery: Boolean;
   {* ���������� �������, � ����������� �������� ����, �������� �� �����������. }
  function LP2DP(const aPoint: TnevPoint;
   toScreen: Boolean): TPoint;
  procedure CursorChanged;
  function CanScroll: Boolean;
  procedure SetFlag(aFlag: TevUpdateWindowFlag);
   {* ���������� ���� aFlag. }
  procedure UpdateCaretAndInvalidate;
   {* ��������� � ����������� ������� + �������������� }
  function Data: InevObject; overload;
  function Processor: InevProcessor;
   {* ��������� ��������. }
  function WindowExtent: TnevSPoint;
   {* ������� ���� � ������. }
  function Metrics: InevViewMetrics;
   {* ������� �����������. }
  function DrawCanvas: InevCanvas;
   {* ����� ��� ������. }
  function MousePos: TnevPoint;
   {* ������� ����. }
  function Selection: InevSelection;
   {* ���������. }
  function CommandProcessor: InevCommandProcessor;
  function LMargin: Integer;
  function AllowMultiSelect: Boolean;
  function ViewArea: InevViewArea;
  function View: InevInputView;
  function Extent: TnevPoint;
  procedure ParaChanged;
   {* ����������� � ����� �������� ���������. }
  function ActiveElement: InevActiveElement;
   {* �������� ������� (��� � ������� ��������� ����) }
  procedure DoStyleTableChanged;
  function ExcludeSuper: TevNormalSegLayerHandleSet;
   {* ����������� ��� ����������� ���� }
  function ForceDrawFocusRect: Boolean;
   {* ����������� �� ��������� ����� � �������� ��������� ��������� }
  function FormatCanvas: InevInfoCanvas;
   {* ����� ��� ��������������. [$157450362] }
  procedure ForceRepaint;
   {* �� ������� ������������ ���������� �������� (����� ������ �������� ��������������). ����� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=204113269 }
  function AllowRubberTables: TnevRubberTablesMode;
   {* ��������� �� ��������� ������� }
  function IsTagCollapsed(aTag: Tl3Variant): Boolean;
  function Data: InevObjectPrim; overload;
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
  function InClose: Boolean;
   {* �������� � �������� ��������. }
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
