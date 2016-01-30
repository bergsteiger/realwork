{$IfNDef vcmScrollableFormWithWheelSupport_imp}

// ћодуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmScrollableFormWithWheelSupport.imp.pas"
// —тереотип: "Impurity"

{$Define vcmScrollableFormWithWheelSupport_imp}

{$If NOT Defined(NoVCM)}
 _vcmScrollableFormWithWheelSupport_ = class(_vcmScrollableFormWithWheelSupport_Parent_)
  {* ќбеспечивает возможность скроллировани€ колесом мыши как самой формы. так и вложенных контролов, имеющих скроллбары }
  public
   {$If NOT Defined(NoVCL)}
   procedure MouseWheelHandler(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//_vcmScrollableFormWithWheelSupport_

{$Else NOT Defined(NoVCM)}

_vcmScrollableFormWithWheelSupport_ = _vcmScrollableFormWithWheelSupport_Parent_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmScrollableFormWithWheelSupport_imp}

{$IfNDef vcmScrollableFormWithWheelSupport_imp_impl}

{$Define vcmScrollableFormWithWheelSupport_imp_impl}

{$If NOT Defined(NoVCM)}
{$If NOT Defined(NoVCL)}
procedure _vcmScrollableFormWithWheelSupport_.MouseWheelHandler(var Message: TMessage);
//#UC START# *515317860183_528468A00346_var*

 function lp_IsScrollableControlAtPoint(const aPoint: TPoint): Boolean;
 var
  l_WndAtPointHandle: HWND;
  l_SbI: TScrollbarInfo;
  l_SbState: DWORD;
 begin
  Result := False;
  l_WndAtPointHandle := WindowFromPoint(aPoint);
  if (l_WndAtPointHandle <> 0) then
  begin
   l3FillChar(l_SbI, SizeOf(l_SbI), 0);
   l_SbI.cbSize := SizeOf(l_SbI);
   GetScrollBarInfo(l_WndAtPointHandle, OBJID_VSCROLL, l_SbI);
   l_SbState := l_SbI.rgState[0];
   Result := ((l_SbState and STATE_SYSTEM_INVISIBLE) = 0) AND
    ((l_SbState and STATE_SYSTEM_UNAVAILABLE) = 0) AND
    ((l_SbState and STATE_SYSTEM_OFFSCREEN) = 0);
  end;
 end;//lp_IsScrollableControlAtPoint

var
 l_Zone: Cardinal;
 l_ScrollMsg: TWMVScroll;
 l_Msg: TWMMouseWheel;
 l_Pt: TPoint;
//#UC END# *515317860183_528468A00346_var*
begin
//#UC START# *515317860183_528468A00346_impl*
 // —кроллить форму колесом мыши будем если есть вертикальный скроллбар у формы
 // а в точке под курсором мыши нет контрола со скроллабарами
 // или там зона вертикального скроллбара самой формы
 // http://mdp.garant.ru/pages/viewpage.action?pageId=499496187
 if VertScrollBar.IsScrollBarVisible then
 begin
  l_Msg := TWMMouseWheel(Message);

  l_Pt.X := l_Msg.Pos.X;
  l_Pt.Y := l_Msg.Pos.Y;

  l_Zone := Cardinal(SendMessage(Handle,  WM_NCHITTEST, WPARAM(0),
   MakeLParam(Word(l_Pt.X), Word(l_Pt.Y))));

  if (l_Zone = HTVSCROLL) OR
   ((l_Zone = HTCLIENT) and (not lp_IsScrollableControlAtPoint(l_Pt))) then
  begin
   l3FillChar(l_ScrollMsg, SizeOf(l_ScrollMsg), 0);
   l_ScrollMsg.Msg := WM_VSCROLL;
   if (l_Msg.WheelDelta < 0) then
    l_ScrollMsg.ScrollCode := SB_LINEDOWN
   else
    l_ScrollMsg.ScrollCode := SB_LINEUP;

   Dispatch(l_ScrollMsg);
   Message.Result := 1;
  end;//if (l_Zone = HTVSCROLL)
 end;
 if (Message.Result = 0) then
  inherited;
//#UC END# *515317860183_528468A00346_impl*
end;//_vcmScrollableFormWithWheelSupport_.MouseWheelHandler
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(NoVCM)
{$EndIf vcmScrollableFormWithWheelSupport_imp_impl}

{$EndIf vcmScrollableFormWithWheelSupport_imp}

