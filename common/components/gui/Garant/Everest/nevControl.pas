unit nevControl;

// Модуль: "w:\common\components\gui\Garant\Everest\nevControl.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnevControl" MUID: (48E0E5C1032A)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 , afwInterfaces
;

type
 _evStyleTableListener_Parent_ = TafwControl;
 {$Include w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas}
 TnevControl = class(_evStyleTableListener_, InevViewMetrics, InevControl)
  private
   f_WebStyle: Boolean;
   f_RMargin: Integer;
    {* правый отступ от окна до текста }
   f_AllowRubberTables: TnevRubberTablesMode;
   f_AACLike: TnevAACLikeMode;
  protected
   f_InPaint: Integer;
   f_ShowDocumentParts: Boolean;
   f_HiddenStyles: TevStandardStyles;
   f_ExcludeSuper: TevNormalSegLayerHandleSet;
  protected
   procedure pm_SetWebStyle(aValue: Boolean);
   procedure pm_SetRMargin(aValue: Integer);
   procedure pm_SetAllowRubberTables(aValue: TnevRubberTablesMode);
   procedure pm_SetAACLike(aValue: TnevAACLikeMode);
   function pm_GetActiveElementPrim: InevActiveElement; virtual;
   function pm_GetForceDrawFocusRectPrim: Boolean; virtual;
   function GetInfoCanvas: InevInfoCanvas; virtual;
   function GetLimitWidth: Integer; virtual; abstract;
   procedure DoChanged(aPlace: TnevChangePlace); virtual;
    {* Данные для отображения изменились }
   procedure DoSignalScroll(aDeltaY: Integer;
    aNeedVert: Boolean); virtual;
   function DoCloseQuery: Boolean; virtual;
   procedure DoCursorChanged; virtual;
   procedure DoSetFlag(aFlag: TevUpdateWindowFlag); virtual;
   function GetData: InevObject; virtual;
   function GetProcessor: InevProcessor; virtual;
   function GetSelection: InevSelection; virtual;
   function GetAllowMultiSelect: Boolean; virtual;
   function GetViewArea: InevViewArea; virtual;
   function GetLMargin: Integer; virtual;
   function GetView: InevInputView; virtual;
   function GetCanScroll: Boolean; virtual;
   function GetMousePos(var aPt: Tl3SPoint): Tl3Point;
   function DP2LP(const aPoint: TPoint;
    fromScreen: Boolean = False): Tl3Point;
   procedure WebStyleChanged; virtual;
   procedure DoParaChange; virtual;
    {* Нотификация о смене параграфа. }
   procedure DoForceRepaint; virtual;
   function GetInClose: Boolean; virtual;
   function pm_GetLimitWidth: TnevInch;
   function pm_GetInfoCanvas: InevInfoCanvas;
   function pm_GetIsWebStyle: Boolean;
   function pm_GetShowDocumentParts: Boolean;
   function pm_GetShowSpecial: Boolean;
   function pm_GetHiddenStyles: TnevStandardStyles;
   procedure InvalidateRect(const aRect: TnevRect);
    {* сообщает контролу о необходимости перерисовки указанного прямоугольника, когда-нибудь в будущем. }
   procedure SignalScroll(aDeltaY: Integer;
    aNeedVert: Boolean);
    {* сообщает контролу, о том, что изменилась позиция скроллера. }
   function GetDelphiControl: TComponent;
   function CloseQuery: Boolean;
    {* спрашивает контрол, о возможности закрытия окна, которому он принадлежит. }
   function LP2DP(const aPoint: TnevPoint;
    toScreen: Boolean = False): TPoint;
   procedure CursorChanged;
   function CanScroll: Boolean;
   procedure SetFlag(aFlag: TevUpdateWindowFlag);
    {* установить флаг aFlag. }
   procedure UpdateCaretAndInvalidate;
    {* Проверить и переставить каретку + перерисоваться }
   function pm_GetData: InevObject;
   function Get_Processor: InevProcessor;
   function pm_GetWindowExtent: TnevSPoint;
   function pm_GetMetrics: InevViewMetrics;
   function pm_GetDrawCanvas: InevCanvas;
   function pm_GetMousePos: TnevPoint;
   function pm_GetSelection: InevSelection;
   function pm_GetCommandProcessor: InevCommandProcessor;
   function pm_GetLMargin: Integer;
   function pm_GetAllowMultiSelect: Boolean;
   function pm_GetViewArea: InevViewArea;
   function pm_GetView: InevInputView;
   function pm_GetExtent: TnevPoint;
   procedure ParaChanged;
    {* Нотификация о смене текущего параграфа. }
   function Get_ActiveElement: InevActiveElement;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure DoStyleTableChanged; override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function Get_ExcludeSuper: TevNormalSegLayerHandleSet;
   function Get_ForceDrawFocusRect: Boolean;
   function Get_FormatCanvas: InevInfoCanvas;
   procedure ForceRepaint;
    {* По жёсткому перерисовать сожержимое контрола (прямо внутри операции редактирования). Нужно для http://mdp.garant.ru/pages/viewpage.action?pageId=204113269 }
   function Get_AllowRubberTables: TnevRubberTablesMode;
   function IsTagCollapsed(aTag: Tl3Variant): Boolean;
   function Get_Data: InevObjectPrim;
   function InClose: Boolean;
    {* Редактор в процессе закрытия. }
   function Get_AACLike: TnevAACLikeMode;
   function NeedTotalRecalc: Boolean;
  public
   function AllowsThisDecor(aFI: TnevFormatInfoPrim;
    aType: TnevDecorType): Boolean;
    {* Разрешает ли контейтер документа применять указанное декорирование }
  protected
   property ActiveElementPrim: InevActiveElement
    read pm_GetActiveElementPrim;
   property ForceDrawFocusRectPrim: Boolean
    read pm_GetForceDrawFocusRectPrim;
  public
   property WebStyle: Boolean
    read f_WebStyle
    write pm_SetWebStyle
    default False;
   property RMargin: Integer
    read f_RMargin
    write pm_SetRMargin
    default 0;
    {* правый отступ от окна до текста }
   property AllowRubberTables: TnevRubberTablesMode
    read f_AllowRubberTables
    write pm_SetAllowRubberTables
    default nevBase.nev_rtmNone;
   property AACLike: TnevAACLikeMode
    read f_AACLike
    write pm_SetAACLike;
 end;//TnevControl

implementation

uses
 l3ImplUses
 , nevFacade
 , k2Tags
 , k2Base
 , l3MinMax
 , Messages
 , TextPara_Const
 , l3Defaults
 , l3InternalInterfaces
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$Include w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas}

procedure TnevControl.pm_SetWebStyle(aValue: Boolean);
//#UC START# *48E0EDB700C0_48E0E5C1032Aset_var*
//#UC END# *48E0EDB700C0_48E0E5C1032Aset_var*
begin
//#UC START# *48E0EDB700C0_48E0E5C1032Aset_impl*
 if (f_WebStyle <> aValue) then
 begin
  f_WebStyle := aValue;
  DoChanged(nev_cpView);
  Invalidate;
  WebStyleChanged;
 end;//f_WebStyle <> aValue
//#UC END# *48E0EDB700C0_48E0E5C1032Aset_impl*
end;//TnevControl.pm_SetWebStyle

procedure TnevControl.pm_SetRMargin(aValue: Integer);
//#UC START# *48E1F7EA014E_48E0E5C1032Aset_var*
//#UC END# *48E1F7EA014E_48E0E5C1032Aset_var*
begin
//#UC START# *48E1F7EA014E_48E0E5C1032Aset_impl*
 if (f_RMargin <> aValue) then
 begin
  f_RMargin := aValue;
  Invalidate;
 end;//f_RMargin <> aValue
//#UC END# *48E1F7EA014E_48E0E5C1032Aset_impl*
end;//TnevControl.pm_SetRMargin

procedure TnevControl.pm_SetAllowRubberTables(aValue: TnevRubberTablesMode);
//#UC START# *4BED74E4005A_48E0E5C1032Aset_var*
//#UC END# *4BED74E4005A_48E0E5C1032Aset_var*
begin
//#UC START# *4BED74E4005A_48E0E5C1032Aset_impl*
 if (f_AllowRubberTables <> aValue) then
 begin
  f_AllowRubberTables := aValue;
  DoChanged(nev_cpView);
  Invalidate;
 end;//f_AllowRubberTables <> aValue
//#UC END# *4BED74E4005A_48E0E5C1032Aset_impl*
end;//TnevControl.pm_SetAllowRubberTables

procedure TnevControl.pm_SetAACLike(aValue: TnevAACLikeMode);
//#UC START# *501F9F66008F_48E0E5C1032Aset_var*
//#UC END# *501F9F66008F_48E0E5C1032Aset_var*
begin
//#UC START# *501F9F66008F_48E0E5C1032Aset_impl*
 f_AACLike := aValue;
//#UC END# *501F9F66008F_48E0E5C1032Aset_impl*
end;//TnevControl.pm_SetAACLike

function TnevControl.pm_GetActiveElementPrim: InevActiveElement;
//#UC START# *4A27CF530106_48E0E5C1032Aget_var*
//#UC END# *4A27CF530106_48E0E5C1032Aget_var*
begin
//#UC START# *4A27CF530106_48E0E5C1032Aget_impl*
 Result := nil;
//#UC END# *4A27CF530106_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetActiveElementPrim

function TnevControl.pm_GetForceDrawFocusRectPrim: Boolean;
//#UC START# *4B59AA4700E5_48E0E5C1032Aget_var*
//#UC END# *4B59AA4700E5_48E0E5C1032Aget_var*
begin
//#UC START# *4B59AA4700E5_48E0E5C1032Aget_impl*
 Result := false;
//#UC END# *4B59AA4700E5_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetForceDrawFocusRectPrim

function TnevControl.GetInfoCanvas: InevInfoCanvas;
//#UC START# *48E0EC2C0286_48E0E5C1032A_var*
//#UC END# *48E0EC2C0286_48E0E5C1032A_var*
begin
//#UC START# *48E0EC2C0286_48E0E5C1032A_impl*
 if (f_InPaint > 0) then
  Result := Canvas
 else
 begin
  Result := nev.CrtIC;
  Result.PasswordChar := #0;
  //Result.LineSpacing := def_LineSpacing;
 end;//f_InPaint > 0
//#UC END# *48E0EC2C0286_48E0E5C1032A_impl*
end;//TnevControl.GetInfoCanvas

procedure TnevControl.DoChanged(aPlace: TnevChangePlace);
 {* Данные для отображения изменились }
//#UC START# *48E1F0CB0136_48E0E5C1032A_var*
//#UC END# *48E1F0CB0136_48E0E5C1032A_var*
begin
//#UC START# *48E1F0CB0136_48E0E5C1032A_impl*
//#UC END# *48E1F0CB0136_48E0E5C1032A_impl*
end;//TnevControl.DoChanged

procedure TnevControl.DoSignalScroll(aDeltaY: Integer;
 aNeedVert: Boolean);
//#UC START# *48E1F13202FB_48E0E5C1032A_var*
//#UC END# *48E1F13202FB_48E0E5C1032A_var*
begin
//#UC START# *48E1F13202FB_48E0E5C1032A_impl*
//#UC END# *48E1F13202FB_48E0E5C1032A_impl*
end;//TnevControl.DoSignalScroll

function TnevControl.DoCloseQuery: Boolean;
//#UC START# *48E1F18502D8_48E0E5C1032A_var*
//#UC END# *48E1F18502D8_48E0E5C1032A_var*
begin
//#UC START# *48E1F18502D8_48E0E5C1032A_impl*
 Result := true;
//#UC END# *48E1F18502D8_48E0E5C1032A_impl*
end;//TnevControl.DoCloseQuery

procedure TnevControl.DoCursorChanged;
//#UC START# *48E1F1B1033C_48E0E5C1032A_var*
//#UC END# *48E1F1B1033C_48E0E5C1032A_var*
begin
//#UC START# *48E1F1B1033C_48E0E5C1032A_impl*
//#UC END# *48E1F1B1033C_48E0E5C1032A_impl*
end;//TnevControl.DoCursorChanged

procedure TnevControl.DoSetFlag(aFlag: TevUpdateWindowFlag);
//#UC START# *48E1F1F30170_48E0E5C1032A_var*
//#UC END# *48E1F1F30170_48E0E5C1032A_var*
begin
//#UC START# *48E1F1F30170_48E0E5C1032A_impl*
//#UC END# *48E1F1F30170_48E0E5C1032A_impl*
end;//TnevControl.DoSetFlag

function TnevControl.GetData: InevObject;
//#UC START# *48E1F2190158_48E0E5C1032A_var*
//#UC END# *48E1F2190158_48E0E5C1032A_var*
begin
//#UC START# *48E1F2190158_48E0E5C1032A_impl*
 Result := nil;
//#UC END# *48E1F2190158_48E0E5C1032A_impl*
end;//TnevControl.GetData

function TnevControl.GetProcessor: InevProcessor;
//#UC START# *48E1F2980113_48E0E5C1032A_var*
//#UC END# *48E1F2980113_48E0E5C1032A_var*
begin
//#UC START# *48E1F2980113_48E0E5C1032A_impl*
 Result := nil;
//#UC END# *48E1F2980113_48E0E5C1032A_impl*
end;//TnevControl.GetProcessor

function TnevControl.GetSelection: InevSelection;
//#UC START# *48E1F2ED0121_48E0E5C1032A_var*
//#UC END# *48E1F2ED0121_48E0E5C1032A_var*
begin
//#UC START# *48E1F2ED0121_48E0E5C1032A_impl*
 Result := nil;
//#UC END# *48E1F2ED0121_48E0E5C1032A_impl*
end;//TnevControl.GetSelection

function TnevControl.GetAllowMultiSelect: Boolean;
//#UC START# *48E1F321030C_48E0E5C1032A_var*
//#UC END# *48E1F321030C_48E0E5C1032A_var*
begin
//#UC START# *48E1F321030C_48E0E5C1032A_impl*
 Result := false;
//#UC END# *48E1F321030C_48E0E5C1032A_impl*
end;//TnevControl.GetAllowMultiSelect

function TnevControl.GetViewArea: InevViewArea;
//#UC START# *48E1F3580003_48E0E5C1032A_var*
//#UC END# *48E1F3580003_48E0E5C1032A_var*
begin
//#UC START# *48E1F3580003_48E0E5C1032A_impl*
 Result := nil;
//#UC END# *48E1F3580003_48E0E5C1032A_impl*
end;//TnevControl.GetViewArea

function TnevControl.GetLMargin: Integer;
//#UC START# *48E1F3A903BF_48E0E5C1032A_var*
//#UC END# *48E1F3A903BF_48E0E5C1032A_var*
begin
//#UC START# *48E1F3A903BF_48E0E5C1032A_impl*
 Result := 0;
//#UC END# *48E1F3A903BF_48E0E5C1032A_impl*
end;//TnevControl.GetLMargin

function TnevControl.GetView: InevInputView;
//#UC START# *48E1F3E30366_48E0E5C1032A_var*
//#UC END# *48E1F3E30366_48E0E5C1032A_var*
begin
//#UC START# *48E1F3E30366_48E0E5C1032A_impl*
 Result := nil;
//#UC END# *48E1F3E30366_48E0E5C1032A_impl*
end;//TnevControl.GetView

function TnevControl.GetCanScroll: Boolean;
//#UC START# *48E1F5F20015_48E0E5C1032A_var*
//#UC END# *48E1F5F20015_48E0E5C1032A_var*
begin
//#UC START# *48E1F5F20015_48E0E5C1032A_impl*
 Result := true;
//#UC END# *48E1F5F20015_48E0E5C1032A_impl*
end;//TnevControl.GetCanScroll

function TnevControl.GetMousePos(var aPt: Tl3SPoint): Tl3Point;
//#UC START# *48E1F78F024B_48E0E5C1032A_var*
//#UC END# *48E1F78F024B_48E0E5C1032A_var*
begin
//#UC START# *48E1F78F024B_48E0E5C1032A_impl*
 aPt.GetCursorPos;
 aPt.Convert(ScreenToClient);
 Result := DP2LP(TPoint(aPt));
//#UC END# *48E1F78F024B_48E0E5C1032A_impl*
end;//TnevControl.GetMousePos

function TnevControl.DP2LP(const aPoint: TPoint;
 fromScreen: Boolean = False): Tl3Point;
//#UC START# *48E1F7A9003B_48E0E5C1032A_var*
var
 l_Pt: TPoint;
//#UC END# *48E1F7A9003B_48E0E5C1032A_var*
begin
//#UC START# *48E1F7A9003B_48E0E5C1032A_impl*
 if fromScreen then
  l_Pt := ScreenToClient(aPoint)
 else
  l_Pt := aPoint;
 Result := GetInfoCanvas.DP2LP(l3SPoint(evPixelDezoom(Canvas.Zoom, l_Pt.X){-LMargin},
                                        evPixelDezoom(Canvas.Zoom, l_Pt.Y)));

 Result := Result.Sub(Il3Canvas(Canvas).{InitialDCOffset}InitialDCOffsetStored);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=509115846
//#UC END# *48E1F7A9003B_48E0E5C1032A_impl*
end;//TnevControl.DP2LP

procedure TnevControl.WebStyleChanged;
//#UC START# *48E238D80225_48E0E5C1032A_var*
//#UC END# *48E238D80225_48E0E5C1032A_var*
begin
//#UC START# *48E238D80225_48E0E5C1032A_impl*
//#UC END# *48E238D80225_48E0E5C1032A_impl*
end;//TnevControl.WebStyleChanged

procedure TnevControl.DoParaChange;
 {* Нотификация о смене параграфа. }
//#UC START# *48E3674B0230_48E0E5C1032A_var*
//#UC END# *48E3674B0230_48E0E5C1032A_var*
begin
//#UC START# *48E3674B0230_48E0E5C1032A_impl*
//#UC END# *48E3674B0230_48E0E5C1032A_impl*
end;//TnevControl.DoParaChange

procedure TnevControl.DoForceRepaint;
//#UC START# *4BCC315901D3_48E0E5C1032A_var*
//#UC END# *4BCC315901D3_48E0E5C1032A_var*
begin
//#UC START# *4BCC315901D3_48E0E5C1032A_impl*
 Invalidate;
 inherited Update;
//#UC END# *4BCC315901D3_48E0E5C1032A_impl*
end;//TnevControl.DoForceRepaint

function TnevControl.GetInClose: Boolean;
//#UC START# *4F3CE6EF01D8_48E0E5C1032A_var*
//#UC END# *4F3CE6EF01D8_48E0E5C1032A_var*
begin
//#UC START# *4F3CE6EF01D8_48E0E5C1032A_impl*
 Result := False;
//#UC END# *4F3CE6EF01D8_48E0E5C1032A_impl*
end;//TnevControl.GetInClose

function TnevControl.pm_GetLimitWidth: TnevInch;
//#UC START# *476BFB3C007A_48E0E5C1032Aget_var*
//#UC END# *476BFB3C007A_48E0E5C1032Aget_var*
begin
//#UC START# *476BFB3C007A_48E0E5C1032Aget_impl*
 Result := GetLimitWidth;
//#UC END# *476BFB3C007A_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetLimitWidth

function TnevControl.pm_GetInfoCanvas: InevInfoCanvas;
//#UC START# *476BFBE10164_48E0E5C1032Aget_var*
//#UC END# *476BFBE10164_48E0E5C1032Aget_var*
begin
//#UC START# *476BFBE10164_48E0E5C1032Aget_impl*
 Result := GetInfoCanvas;
//#UC END# *476BFBE10164_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetInfoCanvas

function TnevControl.pm_GetIsWebStyle: Boolean;
//#UC START# *476BFC120188_48E0E5C1032Aget_var*
//#UC END# *476BFC120188_48E0E5C1032Aget_var*
begin
//#UC START# *476BFC120188_48E0E5C1032Aget_impl*
 Result := WebStyle;
//#UC END# *476BFC120188_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetIsWebStyle

function TnevControl.pm_GetShowDocumentParts: Boolean;
//#UC START# *476BFC2101FB_48E0E5C1032Aget_var*
//#UC END# *476BFC2101FB_48E0E5C1032Aget_var*
begin
//#UC START# *476BFC2101FB_48E0E5C1032Aget_impl*
 Result := f_ShowDocumentParts;
//#UC END# *476BFC2101FB_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetShowDocumentParts

function TnevControl.pm_GetShowSpecial: Boolean;
//#UC START# *476BFC34010B_48E0E5C1032Aget_var*
//#UC END# *476BFC34010B_48E0E5C1032Aget_var*
begin
//#UC START# *476BFC34010B_48E0E5C1032Aget_impl*
 Result := Canvas.DrawSpecial;
//#UC END# *476BFC34010B_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetShowSpecial

function TnevControl.pm_GetHiddenStyles: TnevStandardStyles;
//#UC START# *476BFC420000_48E0E5C1032Aget_var*
//#UC END# *476BFC420000_48E0E5C1032Aget_var*
begin
//#UC START# *476BFC420000_48E0E5C1032Aget_impl*
 Result := f_HiddenStyles;
//#UC END# *476BFC420000_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetHiddenStyles

procedure TnevControl.InvalidateRect(const aRect: TnevRect);
 {* сообщает контролу о необходимости перерисовки указанного прямоугольника, когда-нибудь в будущем. }
//#UC START# *47C5BD960201_48E0E5C1032A_var*
var
 WE   : TafwPoint;
 R    : Tl3Rect;
 l_R  : Tl3SRect;
//#UC END# *47C5BD960201_48E0E5C1032A_var*
begin
//#UC START# *47C5BD960201_48E0E5C1032A_impl*
 if HandleAllocated then
 begin
  WE := pm_GetExtent;
  R := Tl3Rect(aRect);
  with Canvas do
  begin
   R.R.Left   := evPixelZoom(Zoom, Max(R.R.Left, 0));
   R.R.Right  := evPixelZoom(Zoom, Min(R.R.Right, WE.P.X + DP2LP(PointX(pm_GetLMargin)).X));
   R.R.Top    := evPixelZoom(Zoom, Max(R.R.Top, 0));
   R.R.Bottom := evPixelZoom(Zoom, Min(R.R.Bottom, WE.P.Y));
  end;//with Canvas
  l_R := GetInfoCanvas.LR2DR(R);
  l_R.Invalidate(Handle, false);
 end;//HandleAllocated
//#UC END# *47C5BD960201_48E0E5C1032A_impl*
end;//TnevControl.InvalidateRect

procedure TnevControl.SignalScroll(aDeltaY: Integer;
 aNeedVert: Boolean);
 {* сообщает контролу, о том, что изменилась позиция скроллера. }
//#UC START# *47C5BDB9011B_48E0E5C1032A_var*
//#UC END# *47C5BDB9011B_48E0E5C1032A_var*
begin
//#UC START# *47C5BDB9011B_48E0E5C1032A_impl*
 DoSignalScroll(aDeltaY, aNeedVert);
//#UC END# *47C5BDB9011B_48E0E5C1032A_impl*
end;//TnevControl.SignalScroll

function TnevControl.GetDelphiControl: TComponent;
//#UC START# *47C5BDCD016E_48E0E5C1032A_var*
//#UC END# *47C5BDCD016E_48E0E5C1032A_var*
begin
//#UC START# *47C5BDCD016E_48E0E5C1032A_impl*
 Result := Self;
//#UC END# *47C5BDCD016E_48E0E5C1032A_impl*
end;//TnevControl.GetDelphiControl

function TnevControl.CloseQuery: Boolean;
 {* спрашивает контрол, о возможности закрытия окна, которому он принадлежит. }
//#UC START# *47C5BDD701CB_48E0E5C1032A_var*
//#UC END# *47C5BDD701CB_48E0E5C1032A_var*
begin
//#UC START# *47C5BDD701CB_48E0E5C1032A_impl*
 Result := DoCloseQuery;
//#UC END# *47C5BDD701CB_48E0E5C1032A_impl*
end;//TnevControl.CloseQuery

function TnevControl.LP2DP(const aPoint: TnevPoint;
 toScreen: Boolean = False): TPoint;
//#UC START# *47C5BFFB02EC_48E0E5C1032A_var*
var
 l_l3P: Tl3Point;
 l_l3Canv: Il3Canvas;
//#UC END# *47C5BFFB02EC_48E0E5C1032A_var*
begin
//#UC START# *47C5BFFB02EC_48E0E5C1032A_impl*

// Tl3SPoint(Result) := GetInfoCanvas.LP2DP(Tl3Point(aPoint)).Add(PointX(pm_GetLMargin)).Zoom(Canvas.Zoom);
 l_l3P := Tl3Point(aPoint);
 l_l3Canv := Il3Canvas(Canvas);

 Tl3SPoint(Result) := GetInfoCanvas.LP2DP(l_l3P.Add(l_l3Canv.InitialDCOffsetStored)).Zoom(Canvas.Zoom);

 if toScreen then                 
  Result := ClientToScreen(Result);
//#UC END# *47C5BFFB02EC_48E0E5C1032A_impl*
end;//TnevControl.LP2DP

procedure TnevControl.CursorChanged;
//#UC START# *47C5C00E0398_48E0E5C1032A_var*
//#UC END# *47C5C00E0398_48E0E5C1032A_var*
begin
//#UC START# *47C5C00E0398_48E0E5C1032A_impl*
 DoCursorChanged;
//#UC END# *47C5C00E0398_48E0E5C1032A_impl*
end;//TnevControl.CursorChanged

function TnevControl.CanScroll: Boolean;
//#UC START# *47C5C0190391_48E0E5C1032A_var*
//#UC END# *47C5C0190391_48E0E5C1032A_var*
begin
//#UC START# *47C5C0190391_48E0E5C1032A_impl*
 Result := (f_InPaint <= 0) AND GetCanScroll;
//#UC END# *47C5C0190391_48E0E5C1032A_impl*
end;//TnevControl.CanScroll

procedure TnevControl.SetFlag(aFlag: TevUpdateWindowFlag);
 {* установить флаг aFlag. }
//#UC START# *47C5C0260203_48E0E5C1032A_var*
//#UC END# *47C5C0260203_48E0E5C1032A_var*
begin
//#UC START# *47C5C0260203_48E0E5C1032A_impl*
 DoSetFlag(aFlag);
//#UC END# *47C5C0260203_48E0E5C1032A_impl*
end;//TnevControl.SetFlag

procedure TnevControl.UpdateCaretAndInvalidate;
 {* Проверить и переставить каретку + перерисоваться }
//#UC START# *47C5C0380010_48E0E5C1032A_var*
//#UC END# *47C5C0380010_48E0E5C1032A_var*
begin
//#UC START# *47C5C0380010_48E0E5C1032A_impl*
 // Жесткая заточка для обхода такой проблемы
 //ТБ с морфологией, дебагный КС
 //1. Отрыть конституцию
 //2. Встать кареткой в начало документа
 //3. Поикать контекст "народ россии"
 //4. Вернуться по Back в ОМ
 //5. Открыть снова конституцию
 //6. Поикать контекст "народ россии"
 //
 // При установке _FoundBlock получим, что в нелист ShapesPainted пытаемся записать
 // InevMap и падаем по Assert в nevShapesPainted.TnevShape.wMap
 // Пока вкрутил зачистку отрисованных. Как вернеться Шура надо будет поглядеть
 // более системно
 //ClearPaintedShapes;
 // причины возврата искать здесь - http://mdp.garant.ru/pages/viewpage.action?pageId=86479075&focusedCommentId=86479242#comment-86479242
 //
 Perform(EM_ScrollCaret, 0, 0);
 Invalidate;
 Update;
//#UC END# *47C5C0380010_48E0E5C1032A_impl*
end;//TnevControl.UpdateCaretAndInvalidate

function TnevControl.pm_GetData: InevObject;
//#UC START# *47C5C04801EB_48E0E5C1032Aget_var*
//#UC END# *47C5C04801EB_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C04801EB_48E0E5C1032Aget_impl*
 Result := GetData;
//#UC END# *47C5C04801EB_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetData

function TnevControl.Get_Processor: InevProcessor;
//#UC START# *47C5C0590083_48E0E5C1032Aget_var*
//#UC END# *47C5C0590083_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C0590083_48E0E5C1032Aget_impl*
 Result := GetProcessor;
//#UC END# *47C5C0590083_48E0E5C1032Aget_impl*
end;//TnevControl.Get_Processor

function TnevControl.pm_GetWindowExtent: TnevSPoint;
//#UC START# *47C5C0950329_48E0E5C1032Aget_var*
//#UC END# *47C5C0950329_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C0950329_48E0E5C1032Aget_impl*
 if HandleAllocated then
 begin
  with ClientRect do
   Result := l3SPoint(Right - Left - pm_GetLMargin - RMargin, Bottom - Top);
 end//HandleAllocated
 else
  Result := l3SPoint(Width - pm_GetLMargin - RMargin, Height);
 if (f_Canvas <> nil) then
  Tl3SPoint(Result).MakeDezoom(Canvas.Zoom);
//#UC END# *47C5C0950329_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetWindowExtent

function TnevControl.pm_GetMetrics: InevViewMetrics;
//#UC START# *47C5C11801AF_48E0E5C1032Aget_var*
//#UC END# *47C5C11801AF_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C11801AF_48E0E5C1032Aget_impl*
 Result := Self;
//#UC END# *47C5C11801AF_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetMetrics

function TnevControl.pm_GetDrawCanvas: InevCanvas;
//#UC START# *47C5C1270314_48E0E5C1032Aget_var*
//#UC END# *47C5C1270314_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C1270314_48E0E5C1032Aget_impl*
 if (f_InPaint > 0) then
  Result := Canvas
 else
  Result := nil;
//#UC END# *47C5C1270314_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetDrawCanvas

function TnevControl.pm_GetMousePos: TnevPoint;
//#UC START# *47C5C13E0215_48E0E5C1032Aget_var*
var
 l_Pt : Tl3SPoint;
//#UC END# *47C5C13E0215_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C13E0215_48E0E5C1032Aget_impl*
 Result := GetMousePos(l_Pt);
//#UC END# *47C5C13E0215_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetMousePos

function TnevControl.pm_GetSelection: InevSelection;
//#UC START# *47C5C15B00FC_48E0E5C1032Aget_var*
//#UC END# *47C5C15B00FC_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C15B00FC_48E0E5C1032Aget_impl*
 Result := GetSelection;
//#UC END# *47C5C15B00FC_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetSelection

function TnevControl.pm_GetCommandProcessor: InevCommandProcessor;
//#UC START# *47C5C1710096_48E0E5C1032Aget_var*
//#UC END# *47C5C1710096_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C1710096_48E0E5C1032Aget_impl*
 Result := Controller.EntryCommands;
//#UC END# *47C5C1710096_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetCommandProcessor

function TnevControl.pm_GetLMargin: Integer;
//#UC START# *47C5C17E0206_48E0E5C1032Aget_var*
//#UC END# *47C5C17E0206_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C17E0206_48E0E5C1032Aget_impl*
 Result := GetLMargin;
//#UC END# *47C5C17E0206_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetLMargin

function TnevControl.pm_GetAllowMultiSelect: Boolean;
//#UC START# *47C5C18B00B2_48E0E5C1032Aget_var*
//#UC END# *47C5C18B00B2_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C18B00B2_48E0E5C1032Aget_impl*
 Result := GetAllowMultiSelect;
//#UC END# *47C5C18B00B2_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetAllowMultiSelect

function TnevControl.pm_GetViewArea: InevViewArea;
//#UC START# *47C5C19602BF_48E0E5C1032Aget_var*
//#UC END# *47C5C19602BF_48E0E5C1032Aget_var*
begin
//#UC START# *47C5C19602BF_48E0E5C1032Aget_impl*
 Result := GetViewArea;
//#UC END# *47C5C19602BF_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetViewArea

function TnevControl.pm_GetView: InevInputView;
//#UC START# *47FC82400383_48E0E5C1032Aget_var*
//#UC END# *47FC82400383_48E0E5C1032Aget_var*
begin
//#UC START# *47FC82400383_48E0E5C1032Aget_impl*
 Result := GetView;
//#UC END# *47FC82400383_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetView

function TnevControl.pm_GetExtent: TnevPoint;
//#UC START# *486D2C6702FA_48E0E5C1032Aget_var*
//#UC END# *486D2C6702FA_48E0E5C1032Aget_var*
begin
//#UC START# *486D2C6702FA_48E0E5C1032Aget_impl*
 Result := GetInfoCanvas.DP2LP(pm_GetWindowExtent);
//#UC END# *486D2C6702FA_48E0E5C1032Aget_impl*
end;//TnevControl.pm_GetExtent

procedure TnevControl.ParaChanged;
 {* Нотификация о смене текущего параграфа. }
//#UC START# *48E3672A03B2_48E0E5C1032A_var*
//#UC END# *48E3672A03B2_48E0E5C1032A_var*
begin
//#UC START# *48E3672A03B2_48E0E5C1032A_impl*
 DoParaChange;
//#UC END# *48E3672A03B2_48E0E5C1032A_impl*
end;//TnevControl.ParaChanged

function TnevControl.Get_ActiveElement: InevActiveElement;
//#UC START# *4A27CEB10364_48E0E5C1032Aget_var*
//#UC END# *4A27CEB10364_48E0E5C1032Aget_var*
begin
//#UC START# *4A27CEB10364_48E0E5C1032Aget_impl*
 Result := ActiveElementPrim;
//#UC END# *4A27CEB10364_48E0E5C1032Aget_impl*
end;//TnevControl.Get_ActiveElement

{$If NOT Defined(DesignTimeLibrary)}
procedure TnevControl.DoStyleTableChanged;
//#UC START# *4A485B710126_48E0E5C1032A_var*
//#UC END# *4A485B710126_48E0E5C1032A_var*
begin
//#UC START# *4A485B710126_48E0E5C1032A_impl*
//#UC END# *4A485B710126_48E0E5C1032A_impl*
end;//TnevControl.DoStyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TnevControl.Get_ExcludeSuper: TevNormalSegLayerHandleSet;
//#UC START# *4AEAE49B024D_48E0E5C1032Aget_var*
//#UC END# *4AEAE49B024D_48E0E5C1032Aget_var*
begin
//#UC START# *4AEAE49B024D_48E0E5C1032Aget_impl*
 Result := f_ExcludeSuper;
//#UC END# *4AEAE49B024D_48E0E5C1032Aget_impl*
end;//TnevControl.Get_ExcludeSuper

function TnevControl.Get_ForceDrawFocusRect: Boolean;
//#UC START# *4B59A96702D9_48E0E5C1032Aget_var*
//#UC END# *4B59A96702D9_48E0E5C1032Aget_var*
begin
//#UC START# *4B59A96702D9_48E0E5C1032Aget_impl*
 Result := ForceDrawFocusRectPrim;
//#UC END# *4B59A96702D9_48E0E5C1032Aget_impl*
end;//TnevControl.Get_ForceDrawFocusRect

function TnevControl.Get_FormatCanvas: InevInfoCanvas;
//#UC START# *4B7E744702C0_48E0E5C1032Aget_var*
//#UC END# *4B7E744702C0_48E0E5C1032Aget_var*
begin
//#UC START# *4B7E744702C0_48E0E5C1032Aget_impl*
 Assert(false);
 Result := GetInfoCanvas;
//#UC END# *4B7E744702C0_48E0E5C1032Aget_impl*
end;//TnevControl.Get_FormatCanvas

procedure TnevControl.ForceRepaint;
 {* По жёсткому перерисовать сожержимое контрола (прямо внутри операции редактирования). Нужно для http://mdp.garant.ru/pages/viewpage.action?pageId=204113269 }
//#UC START# *4BCC30EC0284_48E0E5C1032A_var*
//#UC END# *4BCC30EC0284_48E0E5C1032A_var*
begin
//#UC START# *4BCC30EC0284_48E0E5C1032A_impl*
 DoForceRepaint;
//#UC END# *4BCC30EC0284_48E0E5C1032A_impl*
end;//TnevControl.ForceRepaint

function TnevControl.Get_AllowRubberTables: TnevRubberTablesMode;
//#UC START# *4BED6E9300FD_48E0E5C1032Aget_var*
//#UC END# *4BED6E9300FD_48E0E5C1032Aget_var*
begin
//#UC START# *4BED6E9300FD_48E0E5C1032Aget_impl*
 Result := AllowRubberTables;
//#UC END# *4BED6E9300FD_48E0E5C1032Aget_impl*
end;//TnevControl.Get_AllowRubberTables

function TnevControl.IsTagCollapsed(aTag: Tl3Variant): Boolean;
//#UC START# *4D5A80DC029D_48E0E5C1032A_var*
//#UC END# *4D5A80DC029D_48E0E5C1032A_var*
begin
//#UC START# *4D5A80DC029D_48E0E5C1032A_impl*
 if (GetView = nil) then
  Result := false
 else
  Result := GetView.Metrics.IsTagCollapsed(aTag);
//#UC END# *4D5A80DC029D_48E0E5C1032A_impl*
end;//TnevControl.IsTagCollapsed

function TnevControl.Get_Data: InevObjectPrim;
//#UC START# *4E5E285C0166_48E0E5C1032Aget_var*
//#UC END# *4E5E285C0166_48E0E5C1032Aget_var*
begin
//#UC START# *4E5E285C0166_48E0E5C1032Aget_impl*
 Result := GetData;
//#UC END# *4E5E285C0166_48E0E5C1032Aget_impl*
end;//TnevControl.Get_Data

function TnevControl.AllowsThisDecor(aFI: TnevFormatInfoPrim;
 aType: TnevDecorType): Boolean;
 {* Разрешает ли контейтер документа применять указанное декорирование }
//#UC START# *4F33E2A30116_48E0E5C1032A_var*
//#UC END# *4F33E2A30116_48E0E5C1032A_var*
begin
//#UC START# *4F33E2A30116_48E0E5C1032A_impl*
 Result := true;
//#UC END# *4F33E2A30116_48E0E5C1032A_impl*
end;//TnevControl.AllowsThisDecor

function TnevControl.InClose: Boolean;
 {* Редактор в процессе закрытия. }
//#UC START# *4F3CE6140329_48E0E5C1032A_var*
//#UC END# *4F3CE6140329_48E0E5C1032A_var*
begin
//#UC START# *4F3CE6140329_48E0E5C1032A_impl*
 Result := GetInClose;
//#UC END# *4F3CE6140329_48E0E5C1032A_impl*
end;//TnevControl.InClose

function TnevControl.Get_AACLike: TnevAACLikeMode;
//#UC START# *501F96A80050_48E0E5C1032Aget_var*
//#UC END# *501F96A80050_48E0E5C1032Aget_var*
begin
//#UC START# *501F96A80050_48E0E5C1032Aget_impl*
 Result := f_AACLike{nev_aacLeft};
//#UC END# *501F96A80050_48E0E5C1032Aget_impl*
end;//TnevControl.Get_AACLike

function TnevControl.NeedTotalRecalc: Boolean;
//#UC START# *565F03C80029_48E0E5C1032A_var*
//#UC END# *565F03C80029_48E0E5C1032A_var*
begin
//#UC START# *565F03C80029_48E0E5C1032A_impl*
 Result := false;
//#UC END# *565F03C80029_48E0E5C1032A_impl*
end;//TnevControl.NeedTotalRecalc

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnevControl);
 {* Регистрация TnevControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
