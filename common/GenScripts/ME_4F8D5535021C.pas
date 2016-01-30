unit AbsSubTree;

// Модуль: "w:\common\components\gui\Garant\VT\ComboTree\AbsSubTree.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , vtOutlinerWithQuickSearch
 , afwInterfaces
 , Messages
 , Windows
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 //#UC START# *4F8D5535021Cci*
 //#UC END# *4F8D5535021Cci*
 //#UC START# *4F8D5535021Ccit*
 //#UC END# *4F8D5535021Ccit*
 TAbsSubTree = class(TvtOutlinerWithQuickSearch, IafwDropDownWindow)
  private
   f_CustomMinSizeX: Integer;
    {* Поле для свойства CustomMinSizeX }
  private
   procedure WMNCPaint(var Message: TMessage);
   procedure WMMouseActivate(var Msg: TMessage);
   procedure WMNChitTest(var Msg: TWMNCHitTest);
   procedure WMNCCalcSize(var Message: TWMNCCalcSize);
   procedure WMSize(var Message: TWMSize);
   procedure WMGetMinMaxInfo(var Message: TMessage);
  protected
   function IsSizeableTree: Boolean; virtual; abstract;
   function IsShowGripper: Boolean; virtual; abstract;
   function IsList: Boolean; virtual; abstract;
   function IsInvert: Boolean; virtual; abstract;
   function IsOwnerAssigned: Boolean; virtual; abstract;
   function GetWidth: Integer; virtual; abstract;
   procedure NCDraw(aDC: hDC); virtual;
   function GetMinVisibleDropCount: Integer; virtual;
   function GetMaxVisibleDropCount: Integer; virtual;
   procedure InitFields; override;
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure RecreateTree;
   function GetMinSizeY: Integer;
   function GetMaxSizeY: Integer;
   function GetMinSizeX: Integer;
   function GetBorderSize: Integer;
   function GetTreeY: Integer;
   procedure SetTreeRoot(const aRoot: Il3SimpleNode);
   procedure SetSimpleTree(const aTree: Il3SimpleTree);
   {$If NOT Defined(NoVCL)}
   function CanFocus: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property CustomMinSizeX: Integer
    read f_CustomMinSizeX
    write f_CustomMinSizeX;
    {* Минимально возможная ширина выпадающего списка. Задается вручную. }
 //#UC START# *4F8D5535021Cpubl*
    property IsShowLines;
    property Font;
 //#UC END# *4F8D5535021Cpubl*
 end;//TAbsSubTree

implementation

uses
 l3ImplUses
 , ctTypes
 , SysUtils
 , l3MinMax
 , l3ControlsTypes
 , l3Tree_TLB
 , Types
 , Graphics
 , l3Defaults
 , ElVclUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TAbsSubTree.NCDraw(aDC: hDC);
//#UC START# *5298C02D03B3_4F8D5535021C_var*
//#UC END# *5298C02D03B3_4F8D5535021C_var*
begin
//#UC START# *5298C02D03B3_4F8D5535021C_impl*
// Do nothing;
//#UC END# *5298C02D03B3_4F8D5535021C_impl*
end;//TAbsSubTree.NCDraw

function TAbsSubTree.GetMinVisibleDropCount: Integer;
//#UC START# *5298C0580167_4F8D5535021C_var*
//#UC END# *5298C0580167_4F8D5535021C_var*
begin
//#UC START# *5298C0580167_4F8D5535021C_impl*
 Result := 0;
//#UC END# *5298C0580167_4F8D5535021C_impl*
end;//TAbsSubTree.GetMinVisibleDropCount

function TAbsSubTree.GetMaxVisibleDropCount: Integer;
//#UC START# *5298C0CD00F1_4F8D5535021C_var*
//#UC END# *5298C0CD00F1_4F8D5535021C_var*
begin
//#UC START# *5298C0CD00F1_4F8D5535021C_impl*
 Result := 0;
//#UC END# *5298C0CD00F1_4F8D5535021C_impl*
end;//TAbsSubTree.GetMaxVisibleDropCount

procedure TAbsSubTree.RecreateTree;
//#UC START# *5298C1690127_4F8D5535021C_var*
//#UC END# *5298C1690127_4F8D5535021C_var*
begin
//#UC START# *5298C1690127_4F8D5535021C_impl*
 RecreateWnd;
//#UC END# *5298C1690127_4F8D5535021C_impl*
end;//TAbsSubTree.RecreateTree

function TAbsSubTree.GetMinSizeY: Integer;
//#UC START# *5298C1960107_4F8D5535021C_var*
//#UC END# *5298C1960107_4F8D5535021C_var*
begin
//#UC START# *5298C1960107_4F8D5535021C_impl*
 // почему-то в дереве RowHeight стал выставляться поздно
 if (RowHeight > 0) then
  if GetMinVisibleDropCount > 0 then
   Result := RowHeight * GetMinVisibleDropCount
  else
   Result := RowHeight * (COMBO_MIN_SIZE_Y div RowHeight)
 else
  Result := COMBO_MIN_SIZE_Y;
//#UC END# *5298C1960107_4F8D5535021C_impl*
end;//TAbsSubTree.GetMinSizeY

function TAbsSubTree.GetMaxSizeY: Integer;
//#UC START# *5298C1B501E0_4F8D5535021C_var*
//#UC END# *5298C1B501E0_4F8D5535021C_var*
begin
//#UC START# *5298C1B501E0_4F8D5535021C_impl*
 // почему-то в дереве RowHeight стал выставляться поздно
 if (RowHeight > 0) then
  if GetMaxVisibleDropCount > 0 then
   Result := RowHeight * GetMaxVisibleDropCount
  else
   Result := RowHeight * (COMBO_MAX_SIZE_Y div RowHeight)
 else
  Result := COMBO_MAX_SIZE_Y;
//#UC END# *5298C1B501E0_4F8D5535021C_impl*
end;//TAbsSubTree.GetMaxSizeY

function TAbsSubTree.GetMinSizeX: Integer;
//#UC START# *5298C1E9000D_4F8D5535021C_var*
//#UC END# *5298C1E9000D_4F8D5535021C_var*
begin
//#UC START# *5298C1E9000D_4F8D5535021C_impl*
 Result := Max(COMBO_MIN_SIZE_X, f_CustomMinSizeX);
//#UC END# *5298C1E9000D_4F8D5535021C_impl*
end;//TAbsSubTree.GetMinSizeX

function TAbsSubTree.GetBorderSize: Integer;
//#UC START# *5298C22802DC_4F8D5535021C_var*
//#UC END# *5298C22802DC_4F8D5535021C_var*
begin
//#UC START# *5298C22802DC_4F8D5535021C_impl*
 Result := 0;
 if IsShowGripper then
  Inc(Result, GetSystemMetrics(SM_CYHSCROLL));
 Inc(Result, GetSystemMetrics(SM_CYBORDER) * 2);
//#UC END# *5298C22802DC_4F8D5535021C_impl*
end;//TAbsSubTree.GetBorderSize

function TAbsSubTree.GetTreeY: Integer;
//#UC START# *5298C24D03B7_4F8D5535021C_var*
var
 l_Count: Integer;
//#UC END# *5298C24D03B7_4F8D5535021C_var*
begin
//#UC START# *5298C24D03B7_4F8D5535021C_impl*
 l_Count := TreeStruct.CountView;
 if (voShowRoot in ViewOptions) then
  Inc(l_Count);
 Result := l_Count * RowHeight;
 if (Result < GetMinSizeY) then
  Result := GetMinSizeY;
//#UC END# *5298C24D03B7_4F8D5535021C_impl*
end;//TAbsSubTree.GetTreeY

procedure TAbsSubTree.SetTreeRoot(const aRoot: Il3SimpleNode);
//#UC START# *5298C26700E7_4F8D5535021C_var*
var
 l_Tree: Il3Tree;
 l_Root: Il3RootNode;
//#UC END# *5298C26700E7_4F8D5535021C_var*
begin
//#UC START# *5298C26700E7_4F8D5535021C_impl*
 if Supports(TreeStruct, Il3Tree, l_Tree) then
 begin
  if Supports(aRoot, Il3RootNode, l_Root) then
  begin
   l_Tree.SetRootAndCountView(l_Root, l3_DelayedCountView);
   Exit;
  end;//Supports(aRoot, Il3RootNode, l_Root)
 end;//Supports(TreeStruct, Il3Tree, l_Tree)
 TreeStruct.RootNode := aRoot as Il3SimpleRootNode;
//#UC END# *5298C26700E7_4F8D5535021C_impl*
end;//TAbsSubTree.SetTreeRoot

procedure TAbsSubTree.SetSimpleTree(const aTree: Il3SimpleTree);
//#UC START# *5298C28400D7_4F8D5535021C_var*
//#UC END# *5298C28400D7_4F8D5535021C_var*
begin
//#UC START# *5298C28400D7_4F8D5535021C_impl*
 TreeStruct := aTree;
//#UC END# *5298C28400D7_4F8D5535021C_impl*
end;//TAbsSubTree.SetSimpleTree

procedure TAbsSubTree.WMNCPaint(var Message: TMessage);
//#UC START# *5298B8B00132_4F8D5535021C_var*
var
 R: TRect;
 DC: HDC;
 l_Bitmap: HBITMAP;
 l_CacheDC: HDC;
 l_Width, l_Height: Integer;
//#UC END# *5298B8B00132_4F8D5535021C_var*
begin
//#UC START# *5298B8B00132_4F8D5535021C_impl*
 DC := GetWindowDC(Handle);
 try
  if IsSizeableTree and IsShowGripper then
  begin
   GetWindowRect(Handle, R);
   OffsetRect(R, -R.Left, -R.Top);
   if not IsInvert then
   begin
    InflateRect(R, -1, 0);
    Dec(R.Bottom, 1);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
   end//not IsInvert
   else
   begin
    InflateRect(R, -1, 0);
    Inc(R.Top, 1);
    R.Bottom := R.Top + GetSystemMetrics(SM_CYHSCROLL);
   end;//not IsInvert
   l_Width := R.Right - R.Left;
   l_Height := R.Bottom - R.Top;
   l_CacheDC := CreateCompatibleDC(DC);
   l_Bitmap := CreateCompatibleBitmap(DC, l_Width, l_Height);
   SelectObject(l_CacheDC, l_Bitmap);
   DrawFrameControl(l_CacheDC, Rect(0, 0, l_Width, l_Height), DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
   if IsInvert then
    StretchBlt(DC, R.Left, R.Top + l_Height - 1, l_Width, -l_Height, l_CacheDC, 0, 0, l_Width, l_Height, SRCCOPY)
   else
    StretchBlt(DC, R.Left, R.Top, l_Width, l_Height, l_CacheDC, 0, 0, l_Width, l_Height, SRCCOPY);
   DeleteObject(l_Bitmap);
   DeleteDC(l_CacheDC);
  end;//IsSizeableTree
  NCDraw(DC);
 finally
  ReleaseDC(Handle, DC);
 end;//try..finally
 inherited; // перенесли в конец - http://mdp.garant.ru/pages/viewpage.action?pageId=263291236 
//#UC END# *5298B8B00132_4F8D5535021C_impl*
end;//TAbsSubTree.WMNCPaint

procedure TAbsSubTree.WMMouseActivate(var Msg: TMessage);
//#UC START# *5298B8ED0300_4F8D5535021C_var*
//#UC END# *5298B8ED0300_4F8D5535021C_var*
begin
//#UC START# *5298B8ED0300_4F8D5535021C_impl*
 Msg.Result := MA_NOACTIVATE;
//#UC END# *5298B8ED0300_4F8D5535021C_impl*
end;//TAbsSubTree.WMMouseActivate

procedure TAbsSubTree.WMNChitTest(var Msg: TWMNCHitTest);
//#UC START# *5298B92600A9_4F8D5535021C_var*
var
 R: TRect;
//#UC END# *5298B92600A9_4F8D5535021C_var*
begin
//#UC START# *5298B92600A9_4F8D5535021C_impl*
 R := BoundsRect;
 OffsetRect(R, -Left, -Top);
 if IsSizeableTree then
 begin
  Msg.Result := ElVclUtils.HitTest(R, ScreenToClient(SmallPointToPoint(Msg.Pos)), (R.Bottom - R.Top) div 4, GetSystemMetrics(SM_CYEDGE));
  if ((Msg.Result = HTBOTTOMLEFT) or
     (Msg.Result = HTLEFT) or
     (Msg.Result = HTTOPLEFT)) then
   Msg.Result := Windows.HTNOWHERE
  else
  //if IsShowGripper then
  // лучше всегда вызывать обработчик, а то скроллбар может не нажиматься
  // http://mdp.garant.ru/pages/viewpage.action?pageId=268347283
   inherited;
  InflateRect(R, -1, 0);
  if not IsInvert then
  begin
   R.Top := R.Bottom - (GetSystemMetrics(SM_CYHSCROLL) div 2);
   R.Left := R.Right - (GetSystemMetrics(SM_CXVSCROLL) div 2);
   Dec(R.Bottom, GetSystemMetrics(SM_CYEDGE));
   if PtInRect(R, ScreenToClient(SmallPointToPoint(Msg.Pos))) then
    Msg.Result := HTBOTTOMRIGHT;
  end//not IsInvert
  else
  begin
   R.Top:=-GetSystemMetrics(SM_CYHSCROLL);
   R.Bottom:= R.Top + (GetSystemMetrics(SM_CYHSCROLL) div 2);
   R.Left := R.Right - (GetSystemMetrics(SM_CXVSCROLL) div 2);
   Inc(R.Top, GetSystemMetrics(SM_CYEDGE));
   if PtInRect(R, ScreenToClient(SmallPointToPoint(Msg.Pos))) then
    Msg.Result := HTTOPRIGHT;
  end;//not IsInvert
 end//IsSizeableTree
 else
  inherited;
//#UC END# *5298B92600A9_4F8D5535021C_impl*
end;//TAbsSubTree.WMNChitTest

procedure TAbsSubTree.WMNCCalcSize(var Message: TWMNCCalcSize);
//#UC START# *5298B9480378_4F8D5535021C_var*
//#UC END# *5298B9480378_4F8D5535021C_var*
begin
//#UC START# *5298B9480378_4F8D5535021C_impl*
 inherited;
 if IsSizeableTree and IsShowGripper then
 begin
  if not IsInvert then
   Dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CYHSCROLL))
  else
   Inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CYHSCROLL));
 end;//IsSizeableTree..
//#UC END# *5298B9480378_4F8D5535021C_impl*
end;//TAbsSubTree.WMNCCalcSize

procedure TAbsSubTree.WMSize(var Message: TWMSize);
//#UC START# *5298B97B01A5_4F8D5535021C_var*
//#UC END# *5298B97B01A5_4F8D5535021C_var*
begin
//#UC START# *5298B97B01A5_4F8D5535021C_impl*
 inherited;
 if (Message.Width > Width) then
 begin
  Width := Message.Width;
  Message.Result := 1;
 end;//Message.Width > Width
//#UC END# *5298B97B01A5_4F8D5535021C_impl*
end;//TAbsSubTree.WMSize

procedure TAbsSubTree.WMGetMinMaxInfo(var Message: TMessage);
//#UC START# *5298B99E029B_4F8D5535021C_var*
var
 l_MMI : PMinMaxInfo;
//#UC END# *5298B99E029B_4F8D5535021C_var*
begin
//#UC START# *5298B99E029B_4F8D5535021C_impl*
 inherited;
 l_MMI := PMinMaxInfo(Message.LParam);
 if GetWidth < GetMinSizeX then
  l_MMI.ptMinTrackSize.x := GetMinSizeX
 else
  l_MMI.ptMinTrackSize.x := GetWidth;
 l_MMI.ptMinTrackSize.y := GetMinSizeY;
 if IsList then
  l_MMI.ptMaxTrackSize.Y := GetTreeY;

 Inc(l_MMI.ptMinTrackSize.y, GetBorderSize);
 Inc(l_MMI.ptMaxTrackSize.y, GetBorderSize);
 Inc(l_MMI.ptMaxTrackSize.Y, 4);
 Message.Result := 1;
//#UC END# *5298B99E029B_4F8D5535021C_impl*
end;//TAbsSubTree.WMGetMinMaxInfo

procedure TAbsSubTree.InitFields;
//#UC START# *47A042E100E2_4F8D5535021C_var*
//#UC END# *47A042E100E2_4F8D5535021C_var*
begin
//#UC START# *47A042E100E2_4F8D5535021C_impl*
 inherited;
 SelectColor.TextColor := clWhite;
 SelectColor.BackColor := cGarant2011SelectionColor;
 SelectNonFocusColor.TextColor := clWhite;
 SelectNonFocusColor.BackColor := cGarant2011SelectionColor;
 Options := Options + [vlMouseTrack];
//#UC END# *47A042E100E2_4F8D5535021C_impl*
end;//TAbsSubTree.InitFields

{$If NOT Defined(NoVCL)}
procedure TAbsSubTree.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4F8D5535021C_var*
//#UC END# *48C7925A02E5_4F8D5535021C_var*
begin
//#UC START# *48C7925A02E5_4F8D5535021C_impl*
 inherited;
 Self.DoubleBuffered := true;
 Params.Style := (Params.Style and not WS_CHILD) or WS_POPUP or WS_BORDER;
 Params.ExStyle := WS_EX_TOOLWINDOW;
 Params.WndParent := GetDesktopWindow;
//#UC END# *48C7925A02E5_4F8D5535021C_impl*
end;//TAbsSubTree.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
function TAbsSubTree.CanFocus: Boolean;
//#UC START# *4E1350DE0094_4F8D5535021C_var*
//#UC END# *4E1350DE0094_4F8D5535021C_var*
begin
//#UC START# *4E1350DE0094_4F8D5535021C_impl*
 Result := False;
//#UC END# *4E1350DE0094_4F8D5535021C_impl*
end;//TAbsSubTree.CanFocus
{$IfEnd} // NOT Defined(NoVCL)

//#UC START# *4F8D5535021Cimpl*
//#UC END# *4F8D5535021Cimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAbsSubTree);
 {* Регистрация TAbsSubTree }
{$IfEnd} // NOT Defined(NoScripts)

end.
