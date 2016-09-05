unit evCustomEditorWindowModelPart;
 {* Часть TevCustomEditorWindow, перенесённая на модель }

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomEditorWindowModelPart.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TevCustomEditorWindowModelPart" MUID: (4A26509001EA)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomEditorWindow
 , nevTools
 , Messages
 , Classes
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , l3ControlFontService
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TevCustomEditorWindowModelPartFontInfo = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3ControlFontService
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   {$If NOT Defined(NoVCL)}
   function GetFont(aControl: TControl): Il3FontInfo;
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TevCustomEditorWindowModelPartFontInfo;
    {* Метод получения экземпляра синглетона TevCustomEditorWindowModelPartFontInfo }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TevCustomEditorWindowModelPartFontInfo

 TevCustomEditorWindowModelPart = class(TevCustomEditorWindow)
  {* Часть TevCustomEditorWindow, перенесённая на модель }
  private
   f_ActiveElement: InevActiveElement;
   f_ForceDrawFocusRect: Boolean;
    {* Рисовать ли рамку вокруг активного параграфа }
   f_PersistentSelection: Boolean;
    {* "Постоянное" выделение }
  private
   procedure WMNCMouseLeave(var Msg: TMessage); message WM_NCMouseLeave;
   procedure WMNCMouseMove(var Msg: TWMNCMouseMove); message WM_NCMouseMove;
  protected
   procedure pm_SetActiveElement(const aValue: InevActiveElement);
   function pm_GetForceDrawFocusRect: Boolean; virtual;
   procedure pm_SetForceDrawFocusRect(aValue: Boolean); virtual;
   function pm_GetPersistentSelection: Boolean;
   procedure pm_SetPersistentSelection(aValue: Boolean);
   procedure ClearUpper; virtual;
    {* Очистить информацию о попадании мыши в HotSpot }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure MakeCursor; override;
   {$If NOT Defined(NoVCL)}
   procedure MouseMove(Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   function pm_GetActiveElementPrim: InevActiveElement; override;
   function pm_GetForceDrawFocusRectPrim: Boolean; override;
   procedure ClearFields; override;
  public
   property ActiveElement: InevActiveElement
    read f_ActiveElement
    write pm_SetActiveElement;
   property ForceDrawFocusRect: Boolean
    read pm_GetForceDrawFocusRect
    write pm_SetForceDrawFocusRect;
    {* Рисовать ли рамку вокруг активного параграфа }
   property PersistentSelection: Boolean
    read pm_GetPersistentSelection
    write pm_SetPersistentSelection;
    {* "Постоянное" выделение }
 end;//TevCustomEditorWindowModelPart

implementation

uses
 l3ImplUses
 , nevGUIInterfaces
 , SysUtils
 , l3Base
 , Windows
 , l3MinMax
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4A26509001EAimpl_uses*
 //#UC END# *4A26509001EAimpl_uses*
;

var g_TevCustomEditorWindowModelPartFontInfo: TevCustomEditorWindowModelPartFontInfo = nil;
 {* Экземпляр синглетона TevCustomEditorWindowModelPartFontInfo }

const
 TME_NONCLIENT = $00000010;

procedure TevCustomEditorWindowModelPartFontInfoFree;
 {* Метод освобождения экземпляра синглетона TevCustomEditorWindowModelPartFontInfo }
begin
 l3Free(g_TevCustomEditorWindowModelPartFontInfo);
end;//TevCustomEditorWindowModelPartFontInfoFree

{$If NOT Defined(NoVCL)}
function TevCustomEditorWindowModelPartFontInfo.GetFont(aControl: TControl): Il3FontInfo;
//#UC START# *B31F486B3A13_556F262E022F_var*
//#UC END# *B31F486B3A13_556F262E022F_var*
begin
//#UC START# *B31F486B3A13_556F262E022F_impl*
 {$IfNDef DesignTimeLibrary}
  if (aControl Is TevCustomEditorWindow) then
  Result := TevCustomEditorWindow(aControl).TextPara.font
 else
 {$EndIf}
  Result := nil; 
//#UC END# *B31F486B3A13_556F262E022F_impl*
end;//TevCustomEditorWindowModelPartFontInfo.GetFont
{$IfEnd} // NOT Defined(NoVCL)

class function TevCustomEditorWindowModelPartFontInfo.Instance: TevCustomEditorWindowModelPartFontInfo;
 {* Метод получения экземпляра синглетона TevCustomEditorWindowModelPartFontInfo }
begin
 if (g_TevCustomEditorWindowModelPartFontInfo = nil) then
 begin
  l3System.AddExitProc(TevCustomEditorWindowModelPartFontInfoFree);
  g_TevCustomEditorWindowModelPartFontInfo := Create;
 end;
 Result := g_TevCustomEditorWindowModelPartFontInfo;
end;//TevCustomEditorWindowModelPartFontInfo.Instance

class function TevCustomEditorWindowModelPartFontInfo.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TevCustomEditorWindowModelPartFontInfo <> nil;
end;//TevCustomEditorWindowModelPartFontInfo.Exists

procedure TevCustomEditorWindowModelPart.pm_SetActiveElement(const aValue: InevActiveElement);
//#UC START# *4A27C6400137_4A26509001EAset_var*
var
 l_ActiveElementPara,
 l_ActiveElementParaNew: InevActiveElement{InevPara};
//#UC END# *4A27C6400137_4A26509001EAset_var*
begin
//#UC START# *4A27C6400137_4A26509001EAset_impl*
 if (f_ActiveElement <> aValue) then
 begin
  if (f_ActiveElement = nil) OR not f_ActiveElement.IsSame(aValue) then
  begin
   if (f_ActiveElement <> nil)
    then l_ActiveElementPara := f_ActiveElement{.Para}
    else l_ActiveElementPara := nil;

   f_ActiveElement := aValue;

   if (f_ActiveElement <> nil)
    then l_ActiveElementParaNew := f_ActiveElement{.Para}
    else l_ActiveElementParaNew := nil;

   if Assigned(l_ActiveElementPara) then
    l_ActiveElementPara.Invalidate{([])};

   if Assigned(l_ActiveElementParaNew) then
    if not l_ActiveElementParaNew.IsSame(l_ActiveElementPara) then
     l_ActiveElementParaNew.Invalidate{([])};

   Update;
  end//f_ActiveElement = nil
  else
   f_ActiveElement := aValue;
 end;//f_ActiveElement <> aValue
//#UC END# *4A27C6400137_4A26509001EAset_impl*
end;//TevCustomEditorWindowModelPart.pm_SetActiveElement

function TevCustomEditorWindowModelPart.pm_GetForceDrawFocusRect: Boolean;
//#UC START# *4B59AB0F0338_4A26509001EAget_var*
//#UC END# *4B59AB0F0338_4A26509001EAget_var*
begin
//#UC START# *4B59AB0F0338_4A26509001EAget_impl*
 if fl_Capture then
  Result := false
 else
  Result := f_ForceDrawFocusRect;
//#UC END# *4B59AB0F0338_4A26509001EAget_impl*
end;//TevCustomEditorWindowModelPart.pm_GetForceDrawFocusRect

procedure TevCustomEditorWindowModelPart.pm_SetForceDrawFocusRect(aValue: Boolean);
//#UC START# *4B59AB0F0338_4A26509001EAset_var*
//#UC END# *4B59AB0F0338_4A26509001EAset_var*
begin
//#UC START# *4B59AB0F0338_4A26509001EAset_impl*
 if (f_ForceDrawFocusRect <> aValue) OR aValue then
 begin
  f_ForceDrawFocusRect := aValue;
  Invalidate;
  Update;
 end;//f_ForceDrawFocusRect <> aValue
//#UC END# *4B59AB0F0338_4A26509001EAset_impl*
end;//TevCustomEditorWindowModelPart.pm_SetForceDrawFocusRect

function TevCustomEditorWindowModelPart.pm_GetPersistentSelection: Boolean;
//#UC START# *4BDAAF0A0285_4A26509001EAget_var*
//#UC END# *4BDAAF0A0285_4A26509001EAget_var*
begin
//#UC START# *4BDAAF0A0285_4A26509001EAget_impl*
 if (Selection = nil) then
  Result := f_PersistentSelection
 else
  Result := Selection.Persistent;
//#UC END# *4BDAAF0A0285_4A26509001EAget_impl*
end;//TevCustomEditorWindowModelPart.pm_GetPersistentSelection

procedure TevCustomEditorWindowModelPart.pm_SetPersistentSelection(aValue: Boolean);
//#UC START# *4BDAAF0A0285_4A26509001EAset_var*
//#UC END# *4BDAAF0A0285_4A26509001EAset_var*
begin
//#UC START# *4BDAAF0A0285_4A26509001EAset_impl*
 f_PersistentSelection := aValue;
 if (Selection <> nil) then
  Selection.Persistent := aValue;
//#UC END# *4BDAAF0A0285_4A26509001EAset_impl*
end;//TevCustomEditorWindowModelPart.pm_SetPersistentSelection

procedure TevCustomEditorWindowModelPart.ClearUpper;
 {* Очистить информацию о попадании мыши в HotSpot }
//#UC START# *4A265562032B_4A26509001EA_var*
//#UC END# *4A265562032B_4A26509001EA_var*
begin
//#UC START# *4A265562032B_4A26509001EA_impl*
 ActiveElement := nil;
//#UC END# *4A265562032B_4A26509001EA_impl*
end;//TevCustomEditorWindowModelPart.ClearUpper

procedure TevCustomEditorWindowModelPart.WMNCMouseLeave(var Msg: TMessage);
//#UC START# *4C0CBB3B028A_4A26509001EA_var*
var
 l_Event: TTrackMouseEvent;
//#UC END# *4C0CBB3B028A_4A26509001EA_var*
begin
//#UC START# *4C0CBB3B028A_4A26509001EA_impl*
 inherited;
 CancelHint;
 l_Event.cbSize := SizeOf(l_Event);
 l_Event.dwFlags := TME_NONCLIENT or TME_CANCEL;
 l_Event.hwndTrack := Handle;
 l_Event.dwHoverTime := HOVER_DEFAULT;
 TrackMouseEvent(l_Event);
//#UC END# *4C0CBB3B028A_4A26509001EA_impl*
end;//TevCustomEditorWindowModelPart.WMNCMouseLeave

procedure TevCustomEditorWindowModelPart.WMNCMouseMove(var Msg: TWMNCMouseMove);
//#UC START# *4C0CC2FC0272_4A26509001EA_var*
var
 l_Info: TScrollBarInfo;
 l_Point: Integer;
 l_Event: TTrackMouseEvent;
//#UC END# *4C0CC2FC0272_4A26509001EA_var*
begin
//#UC START# *4C0CC2FC0272_4A26509001EA_impl*
 inherited;
 if (not (csDesigning in ComponentState)) and
   (Msg.HitTest = HTVSCROLL) then
 begin
  l_Info.cbSize := SizeOf(l_Info);
  GetScrollBarInfo(Handle, Longint(OBJID_VSCROLL), l_Info);
  l_Point := Msg.YCursor - l_Info.rcScrollBar.Top;
  l_Event.cbSize := SizeOf(l_Event);
  l_Event.dwFlags := TME_NONCLIENT;
  l_Event.hwndTrack := Handle;
  l_Event.dwHoverTime := HOVER_DEFAULT;
  l_Info.xyThumbBottom := Max(l_Info.dxyLineButton + l_Info.xyThumbTop, l_Info.xyThumbBottom);
  if (l_Point >= l_Info.xyThumbTop) and
     (l_Point <= l_Info.xyThumbBottom) then
  begin
   ShowHint := False;
   if (View <> nil) AND (View.TopAnchor <> nil) then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=290267544
   begin
    Hint := GetVScrollerHint(View.TopAnchor.ClonePoint(View));
    ActivateHint;
    TrackMouseEvent(l_Event);
   end//View <> nil
   else
   begin
    l_Event.dwFlags := l_Event.dwFlags or TME_CANCEL;
    TrackMouseEvent(l_Event);
    CancelHint;
   end;//View <> nil..
  end//l_Point >= l_Info.xyThumbTop..
  else
  begin
   l_Event.dwFlags := l_Event.dwFlags or TME_CANCEL;
   TrackMouseEvent(l_Event);
   CancelHint;
  end;//l_Point >= l_Info.xyThumbTop
 end;
//#UC END# *4C0CC2FC0272_4A26509001EA_impl*
end;//TevCustomEditorWindowModelPart.WMNCMouseMove

procedure TevCustomEditorWindowModelPart.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A26509001EA_var*
//#UC END# *479731C50290_4A26509001EA_var*
begin
//#UC START# *479731C50290_4A26509001EA_impl*
 f_ActiveElement := nil;
 inherited;
//#UC END# *479731C50290_4A26509001EA_impl*
end;//TevCustomEditorWindowModelPart.Cleanup

procedure TevCustomEditorWindowModelPart.MakeCursor;
//#UC START# *482BFA9401ED_4A26509001EA_var*
//#UC END# *482BFA9401ED_4A26509001EA_var*
begin
//#UC START# *482BFA9401ED_4A26509001EA_impl*
 inherited;
 if (Selection <> nil) then
  Selection.Persistent := f_PersistentSelection;
//#UC END# *482BFA9401ED_4A26509001EA_impl*
end;//TevCustomEditorWindowModelPart.MakeCursor

{$If NOT Defined(NoVCL)}
procedure TevCustomEditorWindowModelPart.MouseMove(Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *48E22B250241_4A26509001EA_var*
var
 l_HotSpot   : IevHotSpot;
 l_Control   : IevMouseMoveHandler;
 l_Translate : Boolean;
 l_Keys      : TevMouseState;
 l_ActiveElement : InevActiveElement;
//#UC END# *48E22B250241_4A26509001EA_var*
begin
//#UC START# *48E22B250241_4A26509001EA_impl*
 inherited;
 l_Translate := False;
 if GetHotspotOnPoint(Point(X, Y), l_HotSpot, false) then
  try
   if Supports(l_HotSpot, IevMouseMoveHandler, l_Control) then
   try
    if (Shift = []) then
    begin
     l3FillChar(l_Keys, SizeOf(l_Keys), 0);
     l_Keys.rInitialPoint := MousePos;
     l_Keys.rPoint := l_Keys.rInitialPoint;
     l_Keys.rKeys := Shift;
     if l_Control.TransMouseMove(View, l_Keys, l_ActiveElement) then
      ActiveElement := l_ActiveElement
     else
      ActiveElement := nil;
     l_Translate := True;
    end;//Shift = []
   finally
    l_Control := nil;
   end;
  finally
   l_HotSpot := nil;
  end;
 if not l_Translate then
  ClearUpper;
//#UC END# *48E22B250241_4A26509001EA_impl*
end;//TevCustomEditorWindowModelPart.MouseMove
{$IfEnd} // NOT Defined(NoVCL)

function TevCustomEditorWindowModelPart.pm_GetActiveElementPrim: InevActiveElement;
//#UC START# *4A27CF530106_4A26509001EAget_var*
//#UC END# *4A27CF530106_4A26509001EAget_var*
begin
//#UC START# *4A27CF530106_4A26509001EAget_impl*
 Result := ActiveElement;
//#UC END# *4A27CF530106_4A26509001EAget_impl*
end;//TevCustomEditorWindowModelPart.pm_GetActiveElementPrim

function TevCustomEditorWindowModelPart.pm_GetForceDrawFocusRectPrim: Boolean;
//#UC START# *4B59AA4700E5_4A26509001EAget_var*
//#UC END# *4B59AA4700E5_4A26509001EAget_var*
begin
//#UC START# *4B59AA4700E5_4A26509001EAget_impl*
 Result := ForceDrawFocusRect;
//#UC END# *4B59AA4700E5_4A26509001EAget_impl*
end;//TevCustomEditorWindowModelPart.pm_GetForceDrawFocusRectPrim

procedure TevCustomEditorWindowModelPart.ClearFields;
begin
 ActiveElement := nil;
 inherited;
end;//TevCustomEditorWindowModelPart.ClearFields

initialization
{$If NOT Defined(NoVCL)}
 Tl3ControlFontService.Instance.Alien := TevCustomEditorWindowModelPartFontInfo.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* Регистрация TevCustomEditorWindowModelPartFontInfo }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomEditorWindowModelPart);
 {* Регистрация TevCustomEditorWindowModelPart }
{$IfEnd} // NOT Defined(NoScripts)

end.
