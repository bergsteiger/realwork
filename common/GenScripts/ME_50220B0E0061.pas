unit vtScrollBar;

// Модуль: "w:\common\components\gui\Garant\VT\vtScrollBar.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
;

type
 TvtScrollBarAlign = (
  sbalNone
  , sbalTop
  , sbalRight
  , sbalBottom
  , sbalLeft
 );//TvtScrollBarAlign

 TvtScrollBar = class(TWinControl)
  private
   f_SmallChange: TScrollBarInc;
    {* Поле для свойства SmallChange }
   f_LargeChange: TScrollBarInc;
    {* Поле для свойства LargeChange }
   f_Min: integer;
    {* Поле для свойства Min }
   f_Max: integer;
    {* Поле для свойства Max }
   f_Position: integer;
    {* Поле для свойства Position }
   f_PageSize: integer;
    {* Поле для свойства PageSize }
   f_OnChange: TNotifyEvent;
    {* Поле для свойства OnChange }
   f_OnScroll: TScrollEvent;
    {* Поле для свойства OnScroll }
  private
   procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
   procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
  protected
   function Get_ScrollBarKind: TScrollBarKind;
   procedure Set_ScrollBarKind(aValue: TScrollBarKind);
   function Get_Align: TvtScrollBarAlign;
   procedure Set_Align(aValue: TvtScrollBarAlign);
   procedure Set_Min(aValue: integer);
   procedure Set_Max(aValue: integer);
   procedure Set_Position(aValue: integer);
   procedure Set_PageSize(aValue: integer);
   procedure DoScroll(ScrollCode: TScrollCode;
    var ScrollPos: Integer);
   procedure DoChange;
   procedure DoWMScroll(var Msg: TWMScroll);
   function InUpdating: Boolean; virtual;
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure RequestAlign; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure SetParams(APosition: Integer;
    AMin: Integer;
    AMax: Integer);
   constructor Create(AOwner: TComponent); override;
  public
   property ScrollBarKind: TScrollBarKind
    read Get_ScrollBarKind
    write Set_ScrollBarKind;
   property SmallChange: TScrollBarInc
    read f_SmallChange
    write f_SmallChange;
   property LargeChange: TScrollBarInc
    read f_LargeChange
    write f_LargeChange;
   property Align: TvtScrollBarAlign
    read Get_Align
    write Set_Align;
   property Min: integer
    read f_Min
    write Set_Min;
   property Max: integer
    read f_Max
    write Set_Max;
   property Position: integer
    read f_Position
    write Set_Position;
   property PageSize: integer
    read f_PageSize
    write Set_PageSize;
   property OnChange: TNotifyEvent
    read f_OnChange
    write f_OnChange;
   property OnScroll: TScrollEvent
    read f_OnScroll
    write f_OnScroll;
 end;//TvtScrollBar

implementation

uses
 l3ImplUses
 , Consts
 , Windows
 , afwFacade
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCL)}
function TvtScrollBar.Get_ScrollBarKind: TScrollBarKind;
//#UC START# *50220C6501B2_50220B0E0061get_var*
//#UC END# *50220C6501B2_50220B0E0061get_var*
begin
//#UC START# *50220C6501B2_50220B0E0061get_impl*
 case Align of
  sbalTop, sbalBottom: Result := sbHorizontal;
 else
  //sbalRight, sbalLeft:
  Result := sbVertical;
 end;
//#UC END# *50220C6501B2_50220B0E0061get_impl*
end;//TvtScrollBar.Get_ScrollBarKind

procedure TvtScrollBar.Set_ScrollBarKind(aValue: TScrollBarKind);
//#UC START# *50220C6501B2_50220B0E0061set_var*
//#UC END# *50220C6501B2_50220B0E0061set_var*
begin
//#UC START# *50220C6501B2_50220B0E0061set_impl*
 if ScrollBarKind <> aValue then
  if aValue = sbHorizontal
   then Align := sbalBottom
   else Align := sbalRight;
//#UC END# *50220C6501B2_50220B0E0061set_impl*
end;//TvtScrollBar.Set_ScrollBarKind

function TvtScrollBar.Get_Align: TvtScrollBarAlign;
//#UC START# *50220D98014D_50220B0E0061get_var*
//#UC END# *50220D98014D_50220B0E0061get_var*
begin
//#UC START# *50220D98014D_50220B0E0061get_impl*
 case inherited Align of
  alTop: Result := sbalTop;
  alRight: Result := sbalRight;
  alBottom: Result := sbalBottom;
  alLeft: Result := sbalLeft;
 else
  Result := sbalNone;
 end;
//#UC END# *50220D98014D_50220B0E0061get_impl*
end;//TvtScrollBar.Get_Align

procedure TvtScrollBar.Set_Align(aValue: TvtScrollBarAlign);
//#UC START# *50220D98014D_50220B0E0061set_var*
//#UC END# *50220D98014D_50220B0E0061set_var*
begin
//#UC START# *50220D98014D_50220B0E0061set_impl*
 if Align <> aValue then
 begin
  case aValue of
   sbalTop: inherited Align := alTop;
   sbalLeft: inherited Align := alLeft;
   sbalBottom: inherited Align := alBottom;
  else
   //sbalRight:
   inherited Align := alRight;
  end;
  RecreateWnd;
 end;
//#UC END# *50220D98014D_50220B0E0061set_impl*
end;//TvtScrollBar.Set_Align

procedure TvtScrollBar.Set_Min(aValue: integer);
//#UC START# *50220DCD01C1_50220B0E0061set_var*
//#UC END# *50220DCD01C1_50220B0E0061set_var*
begin
//#UC START# *50220DCD01C1_50220B0E0061set_impl*
 SetParams(f_Position, aValue, f_Max);
//#UC END# *50220DCD01C1_50220B0E0061set_impl*
end;//TvtScrollBar.Set_Min

procedure TvtScrollBar.Set_Max(aValue: integer);
//#UC START# *50220DD70207_50220B0E0061set_var*
//#UC END# *50220DD70207_50220B0E0061set_var*
begin
//#UC START# *50220DD70207_50220B0E0061set_impl*
 SetParams(f_Position, f_Min, aValue);
//#UC END# *50220DD70207_50220B0E0061set_impl*
end;//TvtScrollBar.Set_Max

procedure TvtScrollBar.Set_Position(aValue: integer);
//#UC START# *50220DE00328_50220B0E0061set_var*
//#UC END# *50220DE00328_50220B0E0061set_var*
begin
//#UC START# *50220DE00328_50220B0E0061set_impl*
 SetParams(aValue, f_Min, f_Max);
//#UC END# *50220DE00328_50220B0E0061set_impl*
end;//TvtScrollBar.Set_Position

procedure TvtScrollBar.Set_PageSize(aValue: integer);
//#UC START# *50220DF801D8_50220B0E0061set_var*
var
 l_ScrollInfo: TScrollInfo;
 l_SB: Integer;
//#UC END# *50220DF801D8_50220B0E0061set_var*
begin
//#UC START# *50220DF801D8_50220B0E0061set_impl*
 f_PageSize := aValue;
 if HandleAllocated then
 begin
  if ScrollBarKind = sbVertical
   then l_SB := SB_VERT
   else l_SB := SB_HORZ;
  l_ScrollInfo.cbSize := SizeOf(l_ScrollInfo);
  l_ScrollInfo.nPage := f_PageSize;
  l_ScrollInfo.fMask := SIF_PAGE;
  SetScrollInfo(Handle, l_SB, l_ScrollInfo, False);
 end;
//#UC END# *50220DF801D8_50220B0E0061set_impl*
end;//TvtScrollBar.Set_PageSize

procedure TvtScrollBar.DoScroll(ScrollCode: TScrollCode;
 var ScrollPos: Integer);
//#UC START# *502210E20375_50220B0E0061_var*
//#UC END# *502210E20375_50220B0E0061_var*
begin
//#UC START# *502210E20375_50220B0E0061_impl*
 if Assigned(f_OnScroll) then
  f_OnScroll(Self, ScrollCode, ScrollPos);
//#UC END# *502210E20375_50220B0E0061_impl*
end;//TvtScrollBar.DoScroll

procedure TvtScrollBar.DoChange;
//#UC START# *50221120038F_50220B0E0061_var*
//#UC END# *50221120038F_50220B0E0061_var*
begin
//#UC START# *50221120038F_50220B0E0061_impl*
 if Assigned(f_OnChange) then
  f_OnChange(Self);
//#UC END# *50221120038F_50220B0E0061_impl*
end;//TvtScrollBar.DoChange

procedure TvtScrollBar.SetParams(APosition: Integer;
 AMin: Integer;
 AMax: Integer);
//#UC START# *502211340371_50220B0E0061_var*
var
 l_ScrollInfo: TScrollInfo;
 l_SB: Integer;
//#UC END# *502211340371_50220B0E0061_var*
begin
//#UC START# *502211340371_50220B0E0061_impl*
 if ScrollBarKind = sbVertical
  then l_SB := SB_VERT
  else l_SB := SB_HORZ;
 if (AMax < AMin) or (AMax < f_PageSize) then
   raise EInvalidOperation.Create(SScrollBarRange);
 if APosition < AMin then
  APosition := AMin;
 if APosition > AMax then
  APosition := AMax;
 f_Min := AMin;
 f_Max := AMax;
 if HandleAllocated then
  SetScrollRange(Handle, l_SB, AMin, AMax, f_Position = APosition);
 f_Position := APosition;
 if HandleAllocated then
  SetScrollPos(Handle, l_SB, f_Position, True);
 Enabled := True;
 DoChange;
//#UC END# *502211340371_50220B0E0061_impl*
end;//TvtScrollBar.SetParams

procedure TvtScrollBar.DoWMScroll(var Msg: TWMScroll);
//#UC START# *5022115C02AE_50220B0E0061_var*
var
 l_ScrollInfo: TScrollInfo;
 l_Pos: Integer;
//#UC END# *5022115C02AE_50220B0E0061_var*
begin
//#UC START# *5022115C02AE_50220B0E0061_impl*
 l_Pos := Position;
 case TScrollCode(Msg.ScrollCode) of
  scLineUp: Dec(l_Pos, f_SmallChange);
  scLineDown: Inc(l_Pos, f_SmallChange);
  scPageUp: Dec(l_Pos, f_LargeChange);
  scPageDown: Inc(l_Pos, f_LargeChange);
  scPosition, scTrack:
    with l_ScrollInfo do
    begin
      cbSize := SizeOf(TScrollInfo);
      fMask := SIF_ALL;
      if ScrollBarKind = sbVertical
       then GetScrollInfo(Handle, SB_VERT, l_ScrollInfo)
       else GetScrollInfo(Handle, SB_HORZ, l_ScrollInfo);
      l_Pos := nTrackPos;
    end;
  scTop: l_Pos := f_Min;
  scBottom: l_Pos := f_Max;
 end;
 if l_Pos < f_Min then
  l_Pos := f_Min;
 if l_Pos > f_Max then
  l_Pos := f_Max;
 DoScroll(TScrollCode(Msg.ScrollCode), l_Pos);
 Position := l_Pos;
//#UC END# *5022115C02AE_50220B0E0061_impl*
end;//TvtScrollBar.DoWMScroll

function TvtScrollBar.InUpdating: Boolean;
//#UC START# *505894EC0371_50220B0E0061_var*
//#UC END# *505894EC0371_50220B0E0061_var*
begin
//#UC START# *505894EC0371_50220B0E0061_impl*
 Result := HandleAllocated AND Visible AND afw.IsObjectLocked(Self);
 // без проверки на видимость, WM_PAINT'ы приходят невидимым контролам, в результате
 // имеем прогрузку дерева при ненужной отрисовке, например.
//#UC END# *505894EC0371_50220B0E0061_impl*
end;//TvtScrollBar.InUpdating

procedure TvtScrollBar.WMHScroll(var Msg: TWMHScroll);
//#UC START# *502228CB009D_50220B0E0061_var*
//#UC END# *502228CB009D_50220B0E0061_var*
begin
//#UC START# *502228CB009D_50220B0E0061_impl*
 if ScrollBarKind = sbHorizontal then
  DoWMScroll(Msg);
//#UC END# *502228CB009D_50220B0E0061_impl*
end;//TvtScrollBar.WMHScroll

procedure TvtScrollBar.WMVScroll(var Msg: TWMVScroll);
//#UC START# *502228F70076_50220B0E0061_var*
//#UC END# *502228F70076_50220B0E0061_var*
begin
//#UC START# *502228F70076_50220B0E0061_impl*
 if ScrollBarKind = sbVertical then
  DoWMScroll(Msg);
//#UC END# *502228F70076_50220B0E0061_impl*
end;//TvtScrollBar.WMVScroll

constructor TvtScrollBar.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_50220B0E0061_var*
//#UC END# *47D1602000C6_50220B0E0061_var*
begin
//#UC START# *47D1602000C6_50220B0E0061_impl*
 inherited;
 Align := sbalRight;
 f_Max := 0;
 f_Min := 0;
 f_SmallChange := 1;
 f_LargeChange := 1;
 f_Position := 0;
 PageSize := f_Max;
 SetParams(f_Position, f_Min, f_Max);
//#UC END# *47D1602000C6_50220B0E0061_impl*
end;//TvtScrollBar.Create

procedure TvtScrollBar.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_50220B0E0061_var*
var
 PS: TPaintStruct;
//#UC END# *47E136A80191_50220B0E0061_var*
begin
//#UC START# *47E136A80191_50220B0E0061_impl*
 // Два case тут для удобства отладки
 case Message.Msg of
  WM_ERASEBKGND,
  WM_NCPAINT,
  WM_PAINT:
  begin
   case Message.Msg of
    WM_ERASEBKGND:
     if InUpdating then
     begin
      Message.Result := 1;  {don't erase background}
      Exit;
     end;//InUpdating
    WM_NCPAINT:
     if InUpdating then
      Exit;
    WM_PAINT:
     if InUpdating then
     begin
      BeginPaint(Handle, PS);
      EndPaint(Handle, PS);
      Exit;
     end;//InUpdating
   end;//case Message.Msg
   inherited;
  end;//WM_ERASEBKGND
  else
   inherited;
 end;//case Message.Msg
//#UC END# *47E136A80191_50220B0E0061_impl*
end;//TvtScrollBar.WndProc

procedure TvtScrollBar.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_50220B0E0061_var*
//#UC END# *48C7925A02E5_50220B0E0061_var*
begin
//#UC START# *48C7925A02E5_50220B0E0061_impl*
 inherited CreateParams(Params);
 if ScrollBarKind = sbVertical
  then Params.Style := Params.Style or WS_VSCROLL
  else Params.Style := Params.Style or WS_HSCROLL;
//#UC END# *48C7925A02E5_50220B0E0061_impl*
end;//TvtScrollBar.CreateParams

procedure TvtScrollBar.SetParent(AParent: TWinControl);
//#UC START# *4A97E78202FC_50220B0E0061_var*
//#UC END# *4A97E78202FC_50220B0E0061_var*
begin
//#UC START# *4A97E78202FC_50220B0E0061_impl*
 inherited;
 PageSize := f_PageSize;
//#UC END# *4A97E78202FC_50220B0E0061_impl*
end;//TvtScrollBar.SetParent

procedure TvtScrollBar.CreateWnd;
//#UC START# *4CC8414403B8_50220B0E0061_var*
var
 l_ScrollInfo: TScrollInfo;
 l_SB: Integer;
//#UC END# *4CC8414403B8_50220B0E0061_var*
begin
//#UC START# *4CC8414403B8_50220B0E0061_impl*
 inherited CreateWnd;
 if ScrollBarKind = sbVertical
  then l_SB := SB_VERT
  else l_SB := SB_HORZ;
 l_ScrollInfo.cbSize := SizeOf(l_ScrollInfo);
 l_ScrollInfo.nPage := f_PageSize;
 l_ScrollInfo.nPos := f_Position;
 l_ScrollInfo.nMin := f_Min;
 l_ScrollInfo.nMax := f_Max;
 l_ScrollInfo.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
 SetScrollInfo(Handle, l_SB, l_ScrollInfo, False);
//#UC END# *4CC8414403B8_50220B0E0061_impl*
end;//TvtScrollBar.CreateWnd

procedure TvtScrollBar.SetBounds(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer);
//#UC START# *4F2A599E0283_50220B0E0061_var*
//#UC END# *4F2A599E0283_50220B0E0061_var*
begin
//#UC START# *4F2A599E0283_50220B0E0061_impl*
 if ScrollBarKind = sbVertical
  then aWidth := GetSystemMetrics(SM_CYVSCROLL)
  else aHeight := GetSystemMetrics(SM_CXHSCROLL) + 1;
 inherited SetBounds(aLeft, aTop, aWidth, aHeight);
//#UC END# *4F2A599E0283_50220B0E0061_impl*
end;//TvtScrollBar.SetBounds

procedure TvtScrollBar.RequestAlign;
//#UC START# *5022104B03A6_50220B0E0061_var*
//#UC END# *5022104B03A6_50220B0E0061_var*
begin
//#UC START# *5022104B03A6_50220B0E0061_impl*
 if not (inherited Align in [alTop, alRight, alBottom, alLeft])
  then inherited Align := alRight
  else inherited;
//#UC END# *5022104B03A6_50220B0E0061_impl*
end;//TvtScrollBar.RequestAlign

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtScrollBar);
 {* Регистрация TvtScrollBar }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
