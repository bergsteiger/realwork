unit nscCustomTreeComboWithHistory;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistory.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscCustomTreeComboWithHistory" MUID: (4B97EDFB0057)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , DropDownTree
 , l3VCLStrings
 , l3TreeInterfaces
 , Graphics
 , l3ControlsTypes
 , l3Interfaces
 , Classes
 , afwFont
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , evEditorWithOperations
 , ctTypes
 , Types
 , Windows
 , l3InternalInterfaces
 , l3Region
 , vtLister
;

type
 _RegionableControl_Parent_ = TSubTree;
 {$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
 TnscSubTree = class(_RegionableControl_)
  private
   f_CloseSize: TSize;
   f_CloseRect: TRect;
   f_MouseTrackItemIndex: Integer;
   f_UseCloseHyperlink: Boolean;
   f_HotTrackColor: TColor;
   f_YandexLikeBehaviour: Boolean;
  private
   procedure SetMouseTrackItemIndex(aIndex: Integer);
   procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
   procedure WMNCLButtonUp(var Message: TWMNCLButtonUp); message WM_NCLBUTTONUP;
   procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
   procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
   procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
   procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
   procedure DrawCloseButton(aDC: hDC;
    const DrawRect: TRect);
   procedure InitFields; override;
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure TuneRegion(aRegion: Tl3Region); override;
   procedure DoOnGetItemStyle(aItemIndex: Integer;
    const aFont: Il3Font;
    var aTextBackColor: TColor;
    var aItemBackColor: TColor;
    var aVJustify: TvtVJustify;
    var aFocused: Boolean;
    var theImageVertOffset: Integer); override;
   function CanScrollWindow: Boolean; override;
   function NeedChangeCurrentOnMouseTrack: Boolean; override;
   function NeedDrawArrowSelection(aItemIndex: Integer): Boolean; override;
   function IsShowGripper: Boolean; override;
   procedure NCDraw(aDC: hDC); override;
  public
   {$If NOT Defined(NoVCL)}
   procedure MouseWheelHandler(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   function ExcludeRect: TRect; override;
  public
   property UseCloseHyperlink: Boolean
    read f_UseCloseHyperlink
    write f_UseCloseHyperlink;
   property HotTrackColor: TColor
    read f_HotTrackColor
    write f_HotTrackColor;
   property YandexLikeBehaviour: Boolean
    read f_YandexLikeBehaviour
    write f_YandexLikeBehaviour;
 end;//TnscSubTree

 TnscOnPastingString = procedure(Sender: TObject;
  var aText: Il3CString) of object;

 TnscCustomTreeComboWithHistory = class(TDropDownTree)
  private
   f_ShowHistory: Boolean;
   f_HistoryRoot: Il3SimpleRootNode;
   f_LockShowPrompts: Integer;
   f_ListIsHistory: Boolean;
   f_SavedText: Il3CString;
   f_LockSaveText: Boolean;
   f_Pasting: Boolean;
   f_Filtering: Boolean;
   f_CloseFont: TafwFont;
   f_ChangeTimer: TTimer;
   f_ChangeTime: Cardinal;
   f_OnPastingString: TnscOnPastingString;
   f_HistoryItems: Tl3Strings;
   f_PromptTree: Il3SimpleTree;
   {$If NOT Defined(DesignTimeLibrary)}
   f_RootNode: Il3SimpleNode;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   f_DropDownCount: Integer;
   f_PromptColor: TColor;
   f_PromptStyle: TFontStyles;
   f_PromptBackColor: TColor;
   f_PromptViewOptions: TvtViewOptions;
   f_OnSelect: TNotifyEvent;
   f_PropmtTreeUsed: Boolean;
   f_CloseHyperLinkColor: TColor;
  private
   procedure MakeNodesFromItems;
   procedure FilterNewTree;
   procedure ChangeDropTree(ForHistory: Boolean;
    ForceChange: Boolean = False);
   procedure TreeCurrentChanged(Sender: TObject;
    aNewCurrent: LongInt;
    aOldCurrent: LongInt);
   procedure DoSetContextText(const aText: Il3CString;
    SetToEnd: Boolean);
   function CloseFont: TFont;
   procedure ChangeTimerTick(Sender: TObject);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure SetRoot(const aRoot: Il3SimpleNode);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   function GetFullPath(const aNode: Il3SimpleNode): Il3CString;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
   procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
   procedure WMSysKeyDown(var Message: TWMSysKeyDown); message WM_SYSKEYDOWN;
  protected
   procedure pm_SetHistoryItems(aValue: Tl3Strings);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure pm_SetRootNode(const aValue: Il3SimpleNode);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure pm_SetDropDownCount(aValue: Integer);
   procedure pm_SetCloseHyperLinkColor(aValue: TColor);
   {$If NOT Defined(DesignTimeLibrary)}
   function CurrentIsLink: Boolean;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   function GetNodeText(const aNode: Il3SimpleNode): Il3CString;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure CloseDropDownByHyperlink;
   procedure DoSelect;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Change; override;
   procedure Validate; override;
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
    {* Какие операции публикуются компонентом. }
   function DoProcessCommand(Cmd: Tl3OperationCode;
    aForce: Boolean;
    aCount: Integer): Boolean; override;
   function DoDoDrop(aFormat: Tl3ClipboardFormat;
    const aMedium: Tl3StoragePlace;
    var dwEffect: Integer): Boolean; override;
   procedure pm_SetDropped(aValue: Boolean); override;
   procedure ButtonClick(Sender: TObject); override;
   function TranslateHomeEndToDropDown: Boolean; override;
   procedure RecreateTreeIfNeeded(aValue: TComboStyle); override;
   function CreateSubTree: TSubTree; override;
   function EstimateTreeHeight(aMinSize: Integer;
    aMaxSize: Integer): Integer; override;
   function EstimateTreeWidth(aMaxSizeX: Integer;
    aSizeY: Integer): Integer; override;
   procedure ProcessTreeSelect(ChooseFromTree: Boolean;
    aTriggerSelect: Boolean); override;
   procedure ClearFields; override;
  public
   procedure ResetPropmtTreeUsage;
   constructor Create(AOwner: TComponent); override;
   function NeedAlignMarksOnSingleClick: Boolean; override;
  protected
   property OnPastingString: TnscOnPastingString
    read f_OnPastingString
    write f_OnPastingString;
   {$If NOT Defined(DesignTimeLibrary)}
   property RootNode: Il3SimpleNode
    read f_RootNode
    write pm_SetRootNode;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   property DropDownCount: Integer
    read f_DropDownCount
    write pm_SetDropDownCount;
   property PromptColor: TColor
    read f_PromptColor
    write f_PromptColor;
   property PromptStyle: TFontStyles
    read f_PromptStyle
    write f_PromptStyle;
   property PromptBackColor: TColor
    read f_PromptBackColor
    write f_PromptBackColor;
   property PromptViewOptions: TvtViewOptions
    read f_PromptViewOptions
    write f_PromptViewOptions;
   property OnSelect: TNotifyEvent
    read f_OnSelect
    write f_OnSelect;
   property CloseHyperLinkColor: TColor
    read f_CloseHyperLinkColor
    write pm_SetCloseHyperLinkColor;
  public
   property HistoryItems: Tl3Strings
    read f_HistoryItems
    write pm_SetHistoryItems;
   property PromptTree: Il3SimpleTree
    read f_PromptTree
    write f_PromptTree;
   property PropmtTreeUsed: Boolean
    read f_PropmtTreeUsed;
 end;//TnscCustomTreeComboWithHistory
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscCustomTreeComboWithHistoryRes
 , SysUtils
 , l3Defaults
 , l3String
 , l3Base
 , evOp
 , nscNewInterfaces
 , l3Drawer
 , l3Units
 , l3MinMax
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nscConst
 , afwFacade
 , OvcCmd
 , OvcConst
 , ComboBoxStrings
 , nevBase
 , l3SimpleTree
 , l3Nodes
 , evMsgCode
 {$If NOT Defined(NoVCL)}
 , l3GetComponentBoundsHelper
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCL)}
 , Themes
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 cHalfChangeInterval = 125;
 cMouseTrackItemIndexNone = -1;
 cFrameWidth = 3;
 cRad = 26;
 cButtonHeight = 22;
 op_local_Paste = ev_msgLast + 1;

{$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}

procedure TnscSubTree.SetMouseTrackItemIndex(aIndex: Integer);
//#UC START# *53FDAD2F00B9_53FDAB5501EB_var*
var
 l_PrevMouseTrackItemIndex: Integer;
//#UC END# *53FDAD2F00B9_53FDAB5501EB_var*
begin
//#UC START# *53FDAD2F00B9_53FDAB5501EB_impl*
 //http://mdp.garant.ru/pages/viewpage.action?pageId=361399733
 if (aIndex <> f_MouseTrackItemIndex) then
 begin
  l_PrevMouseTrackItemIndex := f_MouseTrackItemIndex;
  f_MouseTrackItemIndex := aIndex;
  InvalidateItem(l_PrevMouseTrackItemIndex);
  if (f_MouseTrackItemIndex <> cMouseTrackItemIndexNone) then
   InvalidateItem(f_MouseTrackItemIndex);
 end;
//#UC END# *53FDAD2F00B9_53FDAB5501EB_impl*
end;//TnscSubTree.SetMouseTrackItemIndex

procedure TnscSubTree.DrawCloseButton(aDC: hDC;
 const DrawRect: TRect);
//#UC START# *53FDBA020245_53FDAB5501EB_var*
var
 l_BkMode: Cardinal;
 l_Font: HFont;
 l_Height: Integer;
 l_Color: TColorRef;
 l_Message: Tl3WString;
 l_Rgn: hRGN;
 l_R: Tl3Region;
 l_Rad: Integer;
 l_RgnRect: TRect;
 l_D: Tl3Drawer;
 l_FW: Integer;
//#UC END# *53FDBA020245_53FDAB5501EB_var*
begin
//#UC START# *53FDBA020245_53FDAB5501EB_impl*
 if UseCloseHyperlink then
 begin       
  {$If defined(Nemesis)}
  l_Message := str_nsc_CloseHyperlinkText.AsCStr.AsWStr;
  {$IfEnd}

  l_Height := DrawRect.Bottom - DrawRect.Top;

  with TnscCustomTreeComboWithHistory(f_SubOwner).CloseFont do
  begin
   Style := (Style - [fsUnderline]) + [fsItalic];
   Size := 10;
  end;//with TnscCustomTreeComboWithHistory(f_SubOwner).CloseFont
  l_Font := SelectObject(aDC, TnscCustomTreeComboWithHistory(f_SubOwner).CloseFont.Handle);
  try
   if (f_CloseSize.CY = 0) then
   begin
    if l_Message.SCodePage = CP_UNICODE then
     GetTextExtentPoint32W(aDC, PWideChar(l_Message.S), l_Message.SLen, f_CloseSize)
    else
     GetTextExtentPoint32A(aDC, l_Message.S, l_Message.SLen, f_CloseSize)
   end;//f_CloseSize.CY = 0
   f_CloseRect := DrawRect;
   f_CloseRect.Right := f_CloseRect.Right - l_Height div 3;
   f_CloseRect.Left := f_CloseRect.Right - f_CloseSize.CX;
   f_CloseRect.Top := f_CloseRect.Top + (l_Height - f_CloseSize.CY) div 2;
   f_CloseRect.Bottom := f_CloseRect.Top + f_CloseSize.CY;

   if f_CloseRect.Left < l_Height then
    f_CloseRect.Left := l_Height;

   l_D := Tl3Drawer.Create(aDC);
   try
    l_R := Tl3Region.Create;
    try
     l_Rad := l_Height div 2 + 1;
     l_RgnRect := Rect(f_CloseRect.Left - l_Height div 3,
                       DrawRect.Top,
                       DrawRect.Right,
                       DrawRect.Bottom + 1);
     l_R.Rgn := CreateRoundRectRgn(l_RgnRect.Left,
                                   l_RgnRect.Top,
                                   l_RgnRect.Right,
                                   l_RgnRect.Bottom,
                                   l_Rad,
                                   l_Rad);
     l_R.CombineRect(l3SRect(l_RgnRect.Left + l_Rad,
                             l_RgnRect.Top,
                             l_RgnRect.Right,
                             l_RgnRect.Bottom), RGN_OR);
     l_R.CombineRect(l3SRect(l_RgnRect.Left,
                             l_RgnRect.Top + l_Rad,
                             l_RgnRect.Right,
                             l_RgnRect.Bottom), RGN_OR);
     l_D.FillRegion(l_R.Rgn, cGarant2011SelectionColor);
     l_FW := 2;
     Dec(l_Rad);
     l_D.DrawArc(l_RgnRect.Left + l_FW - 1,
                 l_RgnRect.Top + 1{ + l_Rad - l_FW{ + 1},
                 l_Rad, l_Rad, 180, 90, l_FW + 1, cGarant2011SelectionColor);
    finally
     FreeAndNil(l_R);
    end;//try..finally
    l_BkMode := SetBkMode(aDC, TRANSPARENT);
    try
     SelectObject(aDC, TnscCustomTreeComboWithHistory(f_SubOwner).CloseFont.Handle);
     SetBkColor(aDC, cGarant2011SelectionColor);
     l_Color := SetTextColor(aDC, clWhite{ColorToRGB(TnscCustomTreeComboWithHistory(f_SubOwner).CloseFont.Color)});
     try
      if l_Message.SCodePage = CP_UNICODE then
       DrawTextW(aDC, PWideChar(l_Message.S), l_Message.SLen, f_CloseRect, DT_END_ELLIPSIS)
      else
       DrawTextA(aDC, l_Message.S, l_Message.SLen, f_CloseRect, DT_END_ELLIPSIS);
     finally
      SetTextColor(aDC, l_Color);
     end;//try..finally
    finally
     SetBkMode(aDC, l_BkMode);
    end;//try..finally
    f_CloseRect.Left := l_RgnRect.Left;
   finally
    FreeAndNil(l_D);
   end;//try..finally
  finally
   SelectObject(aDC, l_Font);
  end;//try..finally
 end;//UseCloseHyperlink
//#UC END# *53FDBA020245_53FDAB5501EB_impl*
end;//TnscSubTree.DrawCloseButton

procedure TnscSubTree.WMNCLButtonDown(var Message: TWMNCLButtonDown);
//#UC START# *53FDD0000071_53FDAB5501EB_var*
//#UC END# *53FDD0000071_53FDAB5501EB_var*
begin
//#UC START# *53FDD0000071_53FDAB5501EB_impl*
 if Message.HitTest <> HTCLOSE then
  inherited;
//#UC END# *53FDD0000071_53FDAB5501EB_impl*
end;//TnscSubTree.WMNCLButtonDown

procedure TnscSubTree.WMNCLButtonUp(var Message: TWMNCLButtonUp);
//#UC START# *53FDD0520087_53FDAB5501EB_var*
//#UC END# *53FDD0520087_53FDAB5501EB_var*
begin
//#UC START# *53FDD0520087_53FDAB5501EB_impl*
 inherited;
 if Message.HitTest = HTCLOSE then
  TnscCustomTreeComboWithHistory(f_SubOwner).CloseDropDownByHyperlink;
//#UC END# *53FDD0520087_53FDAB5501EB_impl*
end;//TnscSubTree.WMNCLButtonUp

procedure TnscSubTree.WMNCHitTest(var Message: TWMNCHitTest);
//#UC START# *53FDD092018E_53FDAB5501EB_var*
//#UC END# *53FDD092018E_53FDAB5501EB_var*
begin
//#UC START# *53FDD092018E_53FDAB5501EB_impl*
 inherited;
 if UseCloseHyperlink and ptInRect(f_CloseRect, ScreenToClient(SmallPointToPoint(Message.Pos))) then
  Message.Result := HTCLOSE;
//#UC END# *53FDD092018E_53FDAB5501EB_impl*
end;//TnscSubTree.WMNCHitTest

procedure TnscSubTree.WMSetCursor(var Message: TWMSetCursor);
//#UC START# *53FDD0A10364_53FDAB5501EB_var*
//#UC END# *53FDD0A10364_53FDAB5501EB_var*
begin
//#UC START# *53FDD0A10364_53FDAB5501EB_impl*
 if UseCloseHyperlink and (Message.HitTest = HTCLOSE) then
 begin
  Windows.SetCursor(Screen.Cursors[crHandPoint]);
  Message.Result := 1;
 end//UseCloseHyperlink and (Message.HitTest = HTCLOSE)
 else
  inherited;
//#UC END# *53FDD0A10364_53FDAB5501EB_impl*
end;//TnscSubTree.WMSetCursor

procedure TnscSubTree.WMNCCalcSize(var Message: TWMNCCalcSize);
//#UC START# *53FDD0B201C8_53FDAB5501EB_var*
//#UC END# *53FDD0B201C8_53FDAB5501EB_var*
begin
//#UC START# *53FDD0B201C8_53FDAB5501EB_impl*
 inherited;
 Inc(Message.CalcSize_Params.rgrc[0].Top, cFrameWidth);
 Dec(Message.CalcSize_Params.rgrc[0].Bottom, cFrameWidth + 2);
 Inc(Message.CalcSize_Params.rgrc[0].Left, cFrameWidth + 2);
 Dec(Message.CalcSize_Params.rgrc[0].Right, cFrameWidth);
//#UC END# *53FDD0B201C8_53FDAB5501EB_impl*
end;//TnscSubTree.WMNCCalcSize

procedure TnscSubTree.WMMouseMove(var Message: TWMMouseMove);
//#UC START# *53FDD0C30163_53FDAB5501EB_var*
var
 l_CurrentMousePos: TPoint;
//#UC END# *53FDD0C30163_53FDAB5501EB_var*
begin
//#UC START# *53FDD0C30163_53FDAB5501EB_impl*
 inherited;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=361399733
 if f_YandexLikeBehaviour then
 begin
  l_CurrentMousePos := Point(Message.xPos, Message.yPos);
  if IsMouseMoved(l_CurrentMousePos) then
   SetMouseTrackItemIndex(ItemAtPos(l_CurrentMousePos, False));
 end;
//#UC END# *53FDD0C30163_53FDAB5501EB_impl*
end;//TnscSubTree.WMMouseMove

procedure TnscSubTree.CMMouseLeave(var Message: TMessage);
//#UC START# *53FDD0D7005E_53FDAB5501EB_var*
//#UC END# *53FDD0D7005E_53FDAB5501EB_var*
begin
//#UC START# *53FDD0D7005E_53FDAB5501EB_impl*
 inherited;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=361399733
 if f_YandexLikeBehaviour then
  SetMouseTrackItemIndex(cMouseTrackItemIndexNone);
//#UC END# *53FDD0D7005E_53FDAB5501EB_impl*
end;//TnscSubTree.CMMouseLeave

procedure TnscSubTree.InitFields;
//#UC START# *47A042E100E2_53FDAB5501EB_var*
//#UC END# *47A042E100E2_53FDAB5501EB_var*
begin
//#UC START# *47A042E100E2_53FDAB5501EB_impl*
 inherited;
 f_MouseTrackItemIndex := cMouseTrackItemIndexNone;
//#UC END# *47A042E100E2_53FDAB5501EB_impl*
end;//TnscSubTree.InitFields

procedure TnscSubTree.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_53FDAB5501EB_var*
//#UC END# *48C6C044025E_53FDAB5501EB_var*
begin
//#UC START# *48C6C044025E_53FDAB5501EB_impl*
 inherited;
 with Self.ClientRect do
  DrawCloseButton(CN.DC, Rect(Left, Bottom - cButtonHeight + 1, Right, Bottom + 1));
//#UC END# *48C6C044025E_53FDAB5501EB_impl*
end;//TnscSubTree.Paint

{$If NOT Defined(NoVCL)}
procedure TnscSubTree.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_53FDAB5501EB_var*
//#UC END# *48C7925A02E5_53FDAB5501EB_var*
begin
//#UC START# *48C7925A02E5_53FDAB5501EB_impl*
 inherited;

 // http://mdp.garant.ru/pages/viewpage.action?pageId=263291236
 Params.Style := Params.Style and (not WS_BORDER);
//#UC END# *48C7925A02E5_53FDAB5501EB_impl*
end;//TnscSubTree.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

procedure TnscSubTree.TuneRegion(aRegion: Tl3Region);
//#UC START# *4CC847800383_53FDAB5501EB_var*
var
 l_R: Tl3Region;
//#UC END# *4CC847800383_53FDAB5501EB_var*
begin
//#UC START# *4CC847800383_53FDAB5501EB_impl*
 //if Regionable then
 begin
  l_R := Tl3Region.Create;
  try
   l_R.Rgn := CreateRoundRectRgn(0, 0, Width + 1, Height + 1, cRad, cRad);
   aRegion.Combine(l_R, RGN_OR);
   aRegion.CombineRect(l3SRect(Width - cRad, 0, Width, Height), RGN_OR);
   aRegion.CombineRect(l3SRect(0, 0, Width, cRad), RGN_OR);
  finally
   FreeAndNil(l_R);
  end;//try..fianlly
 end;//Regionable
//#UC END# *4CC847800383_53FDAB5501EB_impl*
end;//TnscSubTree.TuneRegion

procedure TnscSubTree.DoOnGetItemStyle(aItemIndex: Integer;
 const aFont: Il3Font;
 var aTextBackColor: TColor;
 var aItemBackColor: TColor;
 var aVJustify: TvtVJustify;
 var aFocused: Boolean;
 var theImageVertOffset: Integer);
//#UC START# *508F825303E4_53FDAB5501EB_var*
//#UC END# *508F825303E4_53FDAB5501EB_var*
begin
//#UC START# *508F825303E4_53FDAB5501EB_impl*
 inherited;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=361399733
 if f_YandexLikeBehaviour and (aItemIndex = f_MouseTrackItemIndex) then
 begin
  aTextBackColor := HotTrackColor;
  aItemBackColor := HotTrackColor;
 end;
//#UC END# *508F825303E4_53FDAB5501EB_impl*
end;//TnscSubTree.DoOnGetItemStyle

function TnscSubTree.CanScrollWindow: Boolean;
//#UC START# *5152BAA303BA_53FDAB5501EB_var*
//#UC END# *5152BAA303BA_53FDAB5501EB_var*
begin
//#UC START# *5152BAA303BA_53FDAB5501EB_impl*
 Result := False;
//#UC END# *5152BAA303BA_53FDAB5501EB_impl*
end;//TnscSubTree.CanScrollWindow

{$If NOT Defined(NoVCL)}
procedure TnscSubTree.MouseWheelHandler(var Message: TMessage);
//#UC START# *515317860183_53FDAB5501EB_var*
//#UC END# *515317860183_53FDAB5501EB_var*
begin
//#UC START# *515317860183_53FDAB5501EB_impl*
 inherited;
 Invalidate;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=252512754&focusedCommentId=252514373#comment-252514373
 // - если этого не сделать, то можем видеть мусор от кнопки "Закрыть".
//#UC END# *515317860183_53FDAB5501EB_impl*
end;//TnscSubTree.MouseWheelHandler
{$IfEnd} // NOT Defined(NoVCL)

function TnscSubTree.ExcludeRect: TRect;
//#UC START# *515586DF00E9_53FDAB5501EB_var*
//#UC END# *515586DF00E9_53FDAB5501EB_var*
begin
//#UC START# *515586DF00E9_53FDAB5501EB_impl*
 if UseCloseHyperlink then
  Result := f_CloseRect
 else
  Result := inherited ExcludeRect;
//#UC END# *515586DF00E9_53FDAB5501EB_impl*
end;//TnscSubTree.ExcludeRect

function TnscSubTree.NeedChangeCurrentOnMouseTrack: Boolean;
//#UC START# *5266249D00E3_53FDAB5501EB_var*
//#UC END# *5266249D00E3_53FDAB5501EB_var*
begin
//#UC START# *5266249D00E3_53FDAB5501EB_impl*
 //http://mdp.garant.ru/pages/viewpage.action?pageId=361399733
 Result := (not f_YandexLikeBehaviour) and inherited NeedChangeCurrentOnMouseTrack;
//#UC END# *5266249D00E3_53FDAB5501EB_impl*
end;//TnscSubTree.NeedChangeCurrentOnMouseTrack

function TnscSubTree.NeedDrawArrowSelection(aItemIndex: Integer): Boolean;
//#UC START# *5266253D035D_53FDAB5501EB_var*
//#UC END# *5266253D035D_53FDAB5501EB_var*
begin
//#UC START# *5266253D035D_53FDAB5501EB_impl*
 //http://mdp.garant.ru/pages/viewpage.action?pageId=361399733
 Result := inherited NeedDrawArrowSelection(aItemIndex) or
  (f_YandexLikeBehaviour and (aItemIndex = f_MouseTrackItemIndex)); 
//#UC END# *5266253D035D_53FDAB5501EB_impl*
end;//TnscSubTree.NeedDrawArrowSelection

function TnscSubTree.IsShowGripper: Boolean;
//#UC START# *5298BF130022_53FDAB5501EB_var*
//#UC END# *5298BF130022_53FDAB5501EB_var*
begin
//#UC START# *5298BF130022_53FDAB5501EB_impl*
 Result := False;
//#UC END# *5298BF130022_53FDAB5501EB_impl*
end;//TnscSubTree.IsShowGripper

procedure TnscSubTree.NCDraw(aDC: hDC);
//#UC START# *5298C02D03B3_53FDAB5501EB_var*
var
 l_D: Tl3Drawer;
 l_Rgn: hRgn;
 l_FW: Integer;
//#UC END# *5298C02D03B3_53FDAB5501EB_var*
begin
//#UC START# *5298C02D03B3_53FDAB5501EB_impl*
 inherited;
 l_Rgn := CreateRectRgn(0,0,0,0);
 try
  GetWindowRgn(Self.Handle, l_Rgn);
  l_D := Tl3Drawer.Create(aDC);
  try
   l_FW := cFrameWidth + 3;
   l_D.FrameRegion(l_Rgn, l_FW, Self.Color);
   l_D.DrawArc(0 + l_FW - 1, Height - cRad - l_FW{ + 1}, cRad, cRad, 90, 90, l_FW + 1, Self.Color);
   l_FW := cFrameWidth - 1;
   l_D.FrameRegion(l_Rgn, l_FW, cGarant2011GradientStartColor);
   l_D.DrawArc(0 + l_FW - 1, Height - cRad - l_FW{ + 1}, cRad, cRad, 90, 90, l_FW + 1, cGarant2011GradientStartColor);
  finally
   FreeAndNil(l_D);
  end;//try..finally
 finally
  DeleteObject(l_Rgn);
 end;//try..finally
 with Self.ClientRect do
  DrawCloseButton(aDC, Rect(Left + cFrameWidth + 3,
                            Bottom + cFrameWidth - cButtonHeight + 2,
                            Right + cFrameWidth + 3,
                            Bottom + cFrameWidth + 2));
//#UC END# *5298C02D03B3_53FDAB5501EB_impl*
end;//TnscSubTree.NCDraw

procedure TnscCustomTreeComboWithHistory.pm_SetHistoryItems(aValue: Tl3Strings);
//#UC START# *53FDC57C0274_4B97EDFB0057set_var*
//#UC END# *53FDC57C0274_4B97EDFB0057set_var*
begin
//#UC START# *53FDC57C0274_4B97EDFB0057set_impl*
 f_HistoryItems.Assign(aValue);
//#UC END# *53FDC57C0274_4B97EDFB0057set_impl*
end;//TnscCustomTreeComboWithHistory.pm_SetHistoryItems

{$If NOT Defined(DesignTimeLibrary)}
procedure TnscCustomTreeComboWithHistory.pm_SetRootNode(const aValue: Il3SimpleNode);
//#UC START# *53FDC68D0081_4B97EDFB0057set_var*
//#UC END# *53FDC68D0081_4B97EDFB0057set_var*
begin
//#UC START# *53FDC68D0081_4B97EDFB0057set_impl*
 if (aValue <> f_RootNode) or (Assigned(aValue) and not aValue.IsSame(f_RootNode)) then
 begin
  f_RootNode := aValue;
  SetRoot(aValue);

  {$If Defined(Nemesis) AND Defined(Shell)}
  if (DropWidth = 0) then
   DropWidth := Width;
  if (ExtButton <> nil) then
  begin
   DropWidth := Max(DropWidth, Tl3GetComponentBoundsHelper.Instance.GetBounds(ExtButton).Right
                               - Self.ClientToScreen(Point(0, 0)).X);
  end;//ExtButton <> nil
  {$Else}
   DropWidth := Width;
  {$IfEnd}
  Tree.Width := DropWidth;
  DropHeight := EstimateTreeHeight(Tree.GetMinSizeY, Tree.GetMaxSizeY);
  DropHeight := DropHeight + Tree.getBorderSize;
  Tree.Height := Dropheight;

  Dropped := False;
 end;//if not aValue.IsSame(f_RootNode)
//#UC END# *53FDC68D0081_4B97EDFB0057set_impl*
end;//TnscCustomTreeComboWithHistory.pm_SetRootNode
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TnscCustomTreeComboWithHistory.pm_SetDropDownCount(aValue: Integer);
//#UC START# *53FDC6D4010B_4B97EDFB0057set_var*
//#UC END# *53FDC6D4010B_4B97EDFB0057set_var*
begin
//#UC START# *53FDC6D4010B_4B97EDFB0057set_impl*
 if (aValue < 0) or (aValue > 120) then
 begin
  Assert(False);
  Exit;
 end;
 f_DropDownCount := aValue;
//#UC END# *53FDC6D4010B_4B97EDFB0057set_impl*
end;//TnscCustomTreeComboWithHistory.pm_SetDropDownCount

procedure TnscCustomTreeComboWithHistory.pm_SetCloseHyperLinkColor(aValue: TColor);
//#UC START# *53FDCB0D03A4_4B97EDFB0057set_var*
//#UC END# *53FDCB0D03A4_4B97EDFB0057set_var*
begin
//#UC START# *53FDCB0D03A4_4B97EDFB0057set_impl*
 if f_CloseHyperLinkColor <> aValue then
 begin
  f_CloseHyperLinkColor := aValue;
  Invalidate;
 end;
//#UC END# *53FDCB0D03A4_4B97EDFB0057set_impl*
end;//TnscCustomTreeComboWithHistory.pm_SetCloseHyperLinkColor

procedure TnscCustomTreeComboWithHistory.MakeNodesFromItems;
//#UC START# *53FDCC2C033C_4B97EDFB0057_var*
{$IfNDef DesignTimeLibrary}
var
 l_Node: Il3SimpleRootNode;
{$EndIf DesignTimeLibrary}
//#UC END# *53FDCC2C033C_4B97EDFB0057_var*
begin
//#UC START# *53FDCC2C033C_4B97EDFB0057_impl*
 {$IfNDef DesignTimeLibrary}
 if (f_HistoryItems.Count > 0) then
 begin
  if Supports(f_HistoryItems, Il3SimpleRootNode, l_Node) then
   try
    f_HistoryRoot := l_Node;
   finally
    l_Node := nil;
   end;//try..finally
 end;//FItems.Count > 0
 {$EndIf DesignTimeLibrary}
//#UC END# *53FDCC2C033C_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.MakeNodesFromItems

procedure TnscCustomTreeComboWithHistory.FilterNewTree;
//#UC START# *53FDCC3E02F8_4B97EDFB0057_var*
{$IfNDef DesignTimeLibrary}
var
 l_FilterableTree: Il3FilterableTree;
 l_SyncIndex: Integer;
{$EndIf DesignTimeLibrary}
//#UC END# *53FDCC3E02F8_4B97EDFB0057_var*
begin
//#UC START# *53FDCC3E02F8_4B97EDFB0057_impl*
 {$IfNDef DesignTimeLibrary}
 f_Filtering := True;
 try
  if Supports(f_PromptTree, Il3FilterableTree, l_FilterableTree) then
  begin
   f_PromptTree := l_FilterableTree.MakeFiltered(l_FilterableTree.CloneFilters.SetContext(Text),
                                                 nil,
                                                 l_SyncIndex);
   ChangeDropTree(False, True);
   if Assigned(f_PromptTree) then
   begin
    RootNode := f_PromptTree.RootNode;
    Tree.Current := -1;
   end
   else
    RootNode := nil;
  end//if Supports(f_PromptTree, Il3FilterableTree, l_FilterableTree)
 finally
  f_Filtering := False;
 end;
 {$EndIf DesignTimeLibrary}
//#UC END# *53FDCC3E02F8_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.FilterNewTree

procedure TnscCustomTreeComboWithHistory.ChangeDropTree(ForHistory: Boolean;
 ForceChange: Boolean = False);
//#UC START# *53FDCC4E025A_4B97EDFB0057_var*
//#UC END# *53FDCC4E025A_4B97EDFB0057_var*
begin
//#UC START# *53FDCC4E025A_4B97EDFB0057_impl*
 Tree.SelectColor.TextColor := clWhite;
 Tree.SelectColor.BackColor := cGarant2011SelectionColor;
 Tree.SelectNonFocusColor.TextColor := clWhite;
 Tree.SelectNonFocusColor.BackColor := cGarant2011SelectionColor;
 if ForHistory then
 begin
  if not f_ListIsHistory or ForceChange then
  begin
   f_ListIsHistory := True;
   Tree.SetSimpleTree(nil);
   Tree.Font := Self.Font;
   Tree.Color := Color;
   Tree.AllowWithoutCurrent := False;
   TnscSubTree(Tree).UseCloseHyperLink := False;
   Tree.ViewOptions := PromptViewOptions;
   Tree.MultiStrokeItem := True;
  end;//not f_ListIsHistory or ForceChange
 end//ForHistory
 else
 begin
  if f_ListIsHistory or ForceChange then
  begin
   f_ListIsHistory := False;
   Tree.SetSimpleTree(f_PromptTree);
   Tree.Font := Self.Font;
   Tree.Font.Style := PromptStyle;
   Tree.Font.Color := PromptColor;
   Tree.Color := PromptBackColor;
   Tree.AllowWithoutCurrent := True;
   Tree.Current := -1;
   //TnscSubTree(Tree).UseCloseHyperLink := True;
   TnscSubTree(Tree).UseCloseHyperLink := False;
   Tree.ViewOptions := PromptViewOptions;
   Tree.MultiStrokeItem := True;
  end;//f_ListIsHistory or ForceChange
 end;//ForHistory
//#UC END# *53FDCC4E025A_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.ChangeDropTree

procedure TnscCustomTreeComboWithHistory.TreeCurrentChanged(Sender: TObject;
 aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *53FDCCF6009E_4B97EDFB0057_var*
//#UC END# *53FDCCF6009E_4B97EDFB0057_var*
begin
//#UC START# *53FDCCF6009E_4B97EDFB0057_impl*
{$IfNDef DesignTimeLibrary}
 if not f_ListIsHistory and (f_Filtering or Dropped) then
 begin
  if Dropped and not f_Filtering then
   f_PropmtTreeUsed := True;

  f_LockSaveText := True;
  Inc(FRestrictOnTextChange); // http://mdp.garant.ru/pages/viewpage.action?pageId=314216049
  try
   if (aNewCurrent = -1) or CurrentIsLink then
    DoSetContextText(f_SavedText, Dropped and not f_Filtering)
   else
    DoSetContextText(GetNodeText(Tree.GetCurrentNode), Dropped and not f_Filtering);
  finally
   f_LockSaveText := False;
   Dec(FRestrictOnTextChange);
  end;
 end;
{$EndIf DesignTimeLibrary}
//#UC END# *53FDCCF6009E_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.TreeCurrentChanged

procedure TnscCustomTreeComboWithHistory.DoSetContextText(const aText: Il3CString;
 SetToEnd: Boolean);
//#UC START# *53FDCD1500B3_4B97EDFB0057_var*
//#UC END# *53FDCD1500B3_4B97EDFB0057_var*
begin
//#UC START# *53FDCD1500B3_4B97EDFB0057_impl*
 if not l3Same(Text, aText) then
  Paras.ParagraphStrings[0] := aText;
 if SetToEnd then
  ProcessCommand(ev_ocLineEnd, False, 1);
//#UC END# *53FDCD1500B3_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.DoSetContextText

function TnscCustomTreeComboWithHistory.CloseFont: TFont;
//#UC START# *53FDCDAC02AE_4B97EDFB0057_var*
//#UC END# *53FDCDAC02AE_4B97EDFB0057_var*
begin
//#UC START# *53FDCDAC02AE_4B97EDFB0057_impl*
 if f_CloseFont = nil then
 begin
  f_CloseFont := TafwFont.Create;
  f_CloseFont.Assign(Font);
  f_CloseFont.Size := f_CloseFont.Size - 2;
  f_CloseFont.Style := f_CloseFont.Style + [fsUnderline];
  f_CloseFont.Color := CloseHyperLinkColor;
  // Открытый вопрос с CharSet. Сейчас берется от Self.Font, но возможно
  // надо вычислять от Il3CString.AsWStr.SCodePage..
 end;
 Result := f_CloseFont;
//#UC END# *53FDCDAC02AE_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.CloseFont

procedure TnscCustomTreeComboWithHistory.ChangeTimerTick(Sender: TObject);
//#UC START# *53FDCDD50329_4B97EDFB0057_var*
//#UC END# *53FDCDD50329_4B97EDFB0057_var*
begin
//#UC START# *53FDCDD50329_4B97EDFB0057_impl*
 if f_ChangeTimer.Enabled and ((GetTickCount - f_ChangeTime) > cHalfChangeInterval) then
 begin
  f_SavedText := Text;
  if Assigned(f_PromptTree) and (TextLen > 0) and (f_LockShowPrompts = 0) then
  begin
   FilterNewTree;
   if Assigned(f_PromptTree) and (f_PromptTree.CountView > 0) then
   begin
    if Dropped and f_ShowHistory then
     Dropped := False;
    f_ShowHistory := False;
    Dropped := True;
   end
   else
    Dropped := False;
  end;
  if (TextLen = 0) and not f_ShowHistory then
   Dropped := False;
  f_ChangeTimer.Enabled := False;
 end;
//#UC END# *53FDCDD50329_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.ChangeTimerTick

{$If NOT Defined(DesignTimeLibrary)}
procedure TnscCustomTreeComboWithHistory.SetRoot(const aRoot: Il3SimpleNode);
//#UC START# *53FDCDF8015C_4B97EDFB0057_var*
//#UC END# *53FDCDF8015C_4B97EDFB0057_var*
begin
//#UC START# *53FDCDF8015C_4B97EDFB0057_impl*
 if not Tree.TreeStruct.RootNode.IsSame(aRoot) then
 begin
  DropSessionSettings;
  Tree.SetTreeRoot(aRoot);
 end;//not Tree.TreeStruct.RootNode.IsSame(aRoot)
//#UC END# *53FDCDF8015C_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.SetRoot
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
function TnscCustomTreeComboWithHistory.GetFullPath(const aNode: Il3SimpleNode): Il3CString;
//#UC START# *53FDCE26002B_4B97EDFB0057_var*
 function GetPath(const aNode: Il3SimpleNode): Il3CString;
 begin//GetPath
  Result := nil;
  if (aNode.Parent <> nil) and not aNode.IsSame(RootNode) then
  begin
   Result := GetPath(aNode.Parent);
   if not l3IsNil(Result) then
    Result := l3Cat(Result, '\');
   Result := l3Cat([Result, l3CStr(aNode)]);
  end;
 end;//GetPath
//#UC END# *53FDCE26002B_4B97EDFB0057_var*
begin
//#UC START# *53FDCE26002B_4B97EDFB0057_impl*
 if (aNode = nil) then
  Result := nil
 else
 { если передают рутовую ноду - показываем иначе строим путь без рутовой ноды (СКР в Немезисе) }
 if (Tree.ShowRoot) and (aNode.Parent = nil) then
  Result := l3CStr(aNode)
 else
  Result := GetPath(aNode);
//#UC END# *53FDCE26002B_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.GetFullPath
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
function TnscCustomTreeComboWithHistory.CurrentIsLink: Boolean;
//#UC START# *53FDCECE0069_4B97EDFB0057_var*
var
 l_Node: InscBaseSearchPromptNode;
//#UC END# *53FDCECE0069_4B97EDFB0057_var*
begin
//#UC START# *53FDCECE0069_4B97EDFB0057_impl*
 Result := Supports(Tree.GetCurrentNode, InscBaseSearchPromptNode, l_Node) and
  l_Node.IsLinkOnDocument; 
//#UC END# *53FDCECE0069_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.CurrentIsLink
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
function TnscCustomTreeComboWithHistory.GetNodeText(const aNode: Il3SimpleNode): Il3CString;
//#UC START# *53FDCF2E037D_4B97EDFB0057_var*
//#UC END# *53FDCF2E037D_4B97EDFB0057_var*
begin
//#UC START# *53FDCF2E037D_4B97EDFB0057_impl*
 Result := GetFullPath(aNode);
//#UC END# *53FDCF2E037D_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.GetNodeText
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TnscCustomTreeComboWithHistory.CloseDropDownByHyperlink;
//#UC START# *53FDCF7E0267_4B97EDFB0057_var*
//#UC END# *53FDCF7E0267_4B97EDFB0057_var*
begin
//#UC START# *53FDCF7E0267_4B97EDFB0057_impl*
 ButtonClick(Button);
//#UC END# *53FDCF7E0267_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.CloseDropDownByHyperlink

procedure TnscCustomTreeComboWithHistory.ResetPropmtTreeUsage;
//#UC START# *53FDCF9202E9_4B97EDFB0057_var*
//#UC END# *53FDCF9202E9_4B97EDFB0057_var*
begin
//#UC START# *53FDCF9202E9_4B97EDFB0057_impl*
 f_PropmtTreeUsed := False;
//#UC END# *53FDCF9202E9_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.ResetPropmtTreeUsage

procedure TnscCustomTreeComboWithHistory.DoSelect;
//#UC START# *53FDD1FC00F6_4B97EDFB0057_var*
//#UC END# *53FDD1FC00F6_4B97EDFB0057_var*
begin
//#UC START# *53FDD1FC00F6_4B97EDFB0057_impl*
 if Assigned(f_OnSelect) then
  f_OnSelect(Self);
//#UC END# *53FDD1FC00F6_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.DoSelect

procedure TnscCustomTreeComboWithHistory.CNKeyDown(var Message: TWMKeyDown);
//#UC START# *53FDD305025F_4B97EDFB0057_var*
//#UC END# *53FDD305025F_4B97EDFB0057_var*
begin
//#UC START# *53FDD305025F_4B97EDFB0057_impl*
 if (Message.CharCode = VK_SUBTRACT) and (KeyDataToShiftState(Message.KeyData) = []) then
  Message.CharCode := cMinusKeyCode;
 if (Message.CharCode = VK_ADD) and (KeyDataToShiftState(Message.KeyData) = []) then
  Message.CharCode := cPlusKeyCode;
 afw.BeginOp;
 try
  {$IfNDef DesignTimeLibrary}
  if (Message.CharCode = VK_RETURN) then
  begin
   if Dropped then
   begin
    Dropped := False;
    ProcessTreeSelect(True, True);
   end//Dropped
   else
   begin
    ProcessTreeSelect(False, True);
    // - здесь обрабатываем ShortCut'ы.
    inherited;
    Exit;
   end;//Dropped

   Message.CharCode := 0;
   Message.Result := 1;
   Exit;
  end;//ComboboxStyle <> cbEdit..
  {$EndIf DesignTimeLibrary}
  inherited;
 finally
  afw.EndOp;
 end;
//#UC END# *53FDD305025F_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.CNKeyDown

procedure TnscCustomTreeComboWithHistory.CMFontChanged(var Message: TMessage);
//#UC START# *53FDD31A0098_4B97EDFB0057_var*
//#UC END# *53FDD31A0098_4B97EDFB0057_var*
begin
//#UC START# *53FDD31A0098_4B97EDFB0057_impl*
 inherited;
 l3Free(f_CloseFont);
//#UC END# *53FDD31A0098_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.CMFontChanged

procedure TnscCustomTreeComboWithHistory.WMSysKeyDown(var Message: TWMSysKeyDown);
//#UC START# *53FDD328037C_4B97EDFB0057_var*
//#UC END# *53FDD328037C_4B97EDFB0057_var*
begin
//#UC START# *53FDD328037C_4B97EDFB0057_impl*
 afw.BeginOp;
 try
  if (Controller.EntryCommands.TranslateUsing([OvcCmd.scDefaultTableName], TMessage(Message), GetTickCount) <> ccShortcut) then
   inherited;
 finally
  afw.EndOp;
 end;//try..finally
//#UC END# *53FDD328037C_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.WMSysKeyDown

procedure TnscCustomTreeComboWithHistory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B97EDFB0057_var*
//#UC END# *479731C50290_4B97EDFB0057_var*
begin
//#UC START# *479731C50290_4B97EDFB0057_impl*
 {$IfNDef DesignTimeLibrary}
 f_RootNode := nil;
 {$EndIf  DesignTimeLibrary}
 f_HistoryRoot := nil;
 f_PromptTree := nil;
 f_SavedText := nil;
 l3Free(f_HistoryItems);
 l3Free(f_CloseFont);
 f_ChangeTimer.Enabled := False;
 l3Free(f_ChangeTimer);
 inherited;
//#UC END# *479731C50290_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.Cleanup

constructor TnscCustomTreeComboWithHistory.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4B97EDFB0057_var*
//#UC END# *47D1602000C6_4B97EDFB0057_var*
begin
//#UC START# *47D1602000C6_4B97EDFB0057_impl*
 inherited;
 EmptyHintColor := cDefaultContextEmptyColor;
 f_HistoryItems := TComboBoxStrings.Create;
 f_DropDownCount := 7;
 f_PromptColor := clWindowText;
 f_PromptStyle := [];
 f_ListIsHistory := True;
 f_PromptBackColor := $02BDF9FF;
 f_CloseHyperLinkColor := clBlue;
 f_ChangeTimer := TTimer.Create(nil);
 f_ChangeTimer.Interval := cHalfChangeInterval * 2;
 f_ChangeTimer.Enabled := False;
 f_ChangeTimer.OnTimer := ChangeTimerTick;
//#UC END# *47D1602000C6_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.Create

procedure TnscCustomTreeComboWithHistory.Change;
//#UC START# *482AE42802AE_4B97EDFB0057_var*
//#UC END# *482AE42802AE_4B97EDFB0057_var*
begin
//#UC START# *482AE42802AE_4B97EDFB0057_impl*
 if not f_LockSaveText then
 begin
  if not l3Same(f_SavedText, Text) then
  begin
   f_SavedText := Text;
   if Assigned(f_PromptTree) and (TextLen > 0) and (f_LockShowPrompts = 0) then
   begin
    f_ChangeTimer.Enabled := True;
    f_ChangeTime := GetTickCount;
   end;
  end;
  if (not f_ShowHistory)
     and (TextLen = 0) // http://mdp.garant.ru/pages/viewpage.action?pageId=263291165
  then
   Dropped := False;
 end;
 inherited;
//#UC END# *482AE42802AE_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.Change

procedure TnscCustomTreeComboWithHistory.Validate;
//#UC START# *4860F5DF026F_4B97EDFB0057_var*
var
 l_Text: Il3CString;
 l_Prev: Il3CString;
 l_X: Integer;
//#UC END# *4860F5DF026F_4B97EDFB0057_var*
begin
//#UC START# *4860F5DF026F_4B97EDFB0057_impl*
 inherited;
 if f_Pasting then
  if Assigned(f_OnPastingString) then
  begin
   l_Text := Text;
   l_Prev := l_Text;
   f_OnPastingString(Self, l_Text);
   if not l3Same(l_Prev, l_Text) then
   begin
    l_X := CaretX;
    try
     f_Pasting := False;
     try
      Paras.ParagraphStrings[0] := l_Text;
     finally
      f_Pasting := True;
     end;//try..finally
    finally
     CaretX := l_X;
    end;//try..finally
   end;//not l3Same
  end;//Assigned(f_OnPastingString)
//#UC END# *4860F5DF026F_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.Validate

function TnscCustomTreeComboWithHistory.DefineProvideOperations: TevEditorProvideOperationTypes;
 {* Какие операции публикуются компонентом. }
//#UC START# *48735C4A03C3_4B97EDFB0057_var*
//#UC END# *48735C4A03C3_4B97EDFB0057_var*
begin
//#UC START# *48735C4A03C3_4B97EDFB0057_impl*
 Result := inherited DefineProvideOperations - [potText];
//#UC END# *48735C4A03C3_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.DefineProvideOperations

function TnscCustomTreeComboWithHistory.DoProcessCommand(Cmd: Tl3OperationCode;
 aForce: Boolean;
 aCount: Integer): Boolean;
//#UC START# *48BD22E601F2_4B97EDFB0057_var*
//#UC END# *48BD22E601F2_4B97EDFB0057_var*
begin
//#UC START# *48BD22E601F2_4B97EDFB0057_impl*
 if Cmd = ev_ocBreakPara then
  Result := False
 else
  Result := inherited DoProcessCommand(Cmd, aForce, aCount);
//#UC END# *48BD22E601F2_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.DoProcessCommand

function TnscCustomTreeComboWithHistory.DoDoDrop(aFormat: Tl3ClipboardFormat;
 const aMedium: Tl3StoragePlace;
 var dwEffect: Integer): Boolean;
//#UC START# *48BFB6D800B3_4B97EDFB0057_var*
var
 l_Op: InevOp;
//#UC END# *48BFB6D800B3_4B97EDFB0057_var*
begin
//#UC START# *48BFB6D800B3_4B97EDFB0057_impl*
 Assert(not f_Pasting);
 f_Pasting := True;
 try
  l_Op := StartOp(op_local_Paste);
  try
   Result := inherited DoDoDrop(aFormat, aMedium, dwEffect);
  finally
   l_Op := nil;
  end;//try..finally
 finally
  f_Pasting := False;
 end;//try..finally
//#UC END# *48BFB6D800B3_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.DoDoDrop

function TnscCustomTreeComboWithHistory.NeedAlignMarksOnSingleClick: Boolean;
//#UC START# *4D6D427D023A_4B97EDFB0057_var*
//#UC END# *4D6D427D023A_4B97EDFB0057_var*
begin
//#UC START# *4D6D427D023A_4B97EDFB0057_impl*
 Result := False;
//#UC END# *4D6D427D023A_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.NeedAlignMarksOnSingleClick

procedure TnscCustomTreeComboWithHistory.pm_SetDropped(aValue: Boolean);
//#UC START# *53ECD12B0045_4B97EDFB0057set_var*
 function FindCurrent(const aTree: Il3SimpleTree;
                      const aText: Il3CString): Il3SimpleNode;
  function FindCurr(const aIterNode: Il3SimpleNode): boolean;
  begin
   Result := l3Same(aIterNode.Text, aText, true);
  end;
 begin
  Result := aTree.SimpleIterateF(l3L2SNA(@FindCurr), imCheckResult);
 end;
var
 l_Node: Il3SimpleNode;
//#UC END# *53ECD12B0045_4B97EDFB0057set_var*
begin
//#UC START# *53ECD12B0045_4B97EDFB0057set_impl*
 if (aValue <> Dropped) then
 begin
  if aValue then
  begin
   if (Windows.GetFocus <> Self.Handle) then
     Windows.SetFocus(Self.Handle);
   if cmButtonClick in CurrentMode then
    f_ShowHistory := True;
   if f_ShowHistory then
   begin
    MakeNodesFromItems;
    ChangeDropTree(True);
    if (f_HistoryRoot <> nil) then
    begin
     {$IfNDef DesignTimeLibrary}
     if not f_HistoryRoot.IsSame(f_RootNode) then
     begin
      f_RootNode := f_HistoryRoot;
      Tree.TreeStruct := Tl3SimpleTree.Make(f_HistoryRoot);
     end;//not f_HistoryRoot.IsSame(f_RootNode)
     {$EndIf DesignTimeLibrary}
    end;//f_HistoryRoot <> nil
    l_Node := FindCurrent(Tree.TreeStruct, Text);
    if (l_Node <> nil) then
     Tree.GotoOnNode(l_Node);
   end//f_ShowHistory
   else
   begin
    ChangeDropTree(False);
    {$IfNDef DesignTimeLibrary}
    if Assigned(f_PromptTree) and (f_PromptTree.CountView > 0) then
     RootNode := f_PromptTree.RootNode
    else
     RootNode := nil;
    {$EndIf  DesignTimeLibrary} 
   end;//f_ShowHistory
   CalcDropDimensions;
  end//aValue
  else
  begin
   if not f_ShowHistory then
   begin
    Inc(f_LockShowPrompts);
    try
     DoSetContextText(f_SavedText, False);
    finally
     Dec(f_LockShowPrompts);
    end;
   end;
  end;//aValue
  inherited;
 end;//aValue <> Dropped
//#UC END# *53ECD12B0045_4B97EDFB0057set_impl*
end;//TnscCustomTreeComboWithHistory.pm_SetDropped

procedure TnscCustomTreeComboWithHistory.ButtonClick(Sender: TObject);
//#UC START# *53ECD28200BF_4B97EDFB0057_var*
//#UC END# *53ECD28200BF_4B97EDFB0057_var*
begin
//#UC START# *53ECD28200BF_4B97EDFB0057_impl*
 if not Dropped then
  f_ShowHistory := True;
 inherited;
//#UC END# *53ECD28200BF_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.ButtonClick

function TnscCustomTreeComboWithHistory.TranslateHomeEndToDropDown: Boolean;
//#UC START# *53ECD4060099_4B97EDFB0057_var*
//#UC END# *53ECD4060099_4B97EDFB0057_var*
begin
//#UC START# *53ECD4060099_4B97EDFB0057_impl*
 Result := False;
//#UC END# *53ECD4060099_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.TranslateHomeEndToDropDown

procedure TnscCustomTreeComboWithHistory.RecreateTreeIfNeeded(aValue: TComboStyle);
//#UC START# *53EE012C0211_4B97EDFB0057_var*
//#UC END# *53EE012C0211_4B97EDFB0057_var*
begin
//#UC START# *53EE012C0211_4B97EDFB0057_impl*
 inherited;
{$IfNDef DesignTimeLibrary}
 with Tree do
 begin
  ControlStyle := ControlStyle - [csCaptureMouse];
  Visible := False;
  BorderStyle := bsSingle;
  Align := alNone;
  OnActionElement := ActionElementHandler;
  Font := Self.Font;
  ActionElementMode := l3_amSingleClick;
  OnGetItemImage := GetItemImageHandler;
  isShowLines := True;
  Tree.OnCurrentChanged := TreeCurrentChanged;
  ViewOptions := PromptViewOptions;
  MultiStrokeItem := True;
  SelfDrawNodes := True;
 end;//with Tree
 ShowIcons := False;
{$EndIf DesignTimeLibrary}
//#UC END# *53EE012C0211_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.RecreateTreeIfNeeded

function TnscCustomTreeComboWithHistory.CreateSubTree: TSubTree;
//#UC START# *53EE01540251_4B97EDFB0057_var*
//#UC END# *53EE01540251_4B97EDFB0057_var*
begin
//#UC START# *53EE01540251_4B97EDFB0057_impl*
 Result := TnscSubTree.Create(Self);
//#UC END# *53EE01540251_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.CreateSubTree

function TnscCustomTreeComboWithHistory.EstimateTreeHeight(aMinSize: Integer;
 aMaxSize: Integer): Integer;
//#UC START# *53EE09AA0268_4B97EDFB0057_var*
//#UC END# *53EE09AA0268_4B97EDFB0057_var*
begin
//#UC START# *53EE09AA0268_4B97EDFB0057_impl*
 Result := (Tree.RowHeight + Tree.InterRowIndent + 1) * DropDownCount +
           cFrameWidth * 2 +
           Tree.InterRowIndent;
//#UC END# *53EE09AA0268_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.EstimateTreeHeight

function TnscCustomTreeComboWithHistory.EstimateTreeWidth(aMaxSizeX: Integer;
 aSizeY: Integer): Integer;
//#UC START# *53EE09D70249_4B97EDFB0057_var*
//#UC END# *53EE09D70249_4B97EDFB0057_var*
begin
//#UC START# *53EE09D70249_4B97EDFB0057_impl*
 Result := inherited EstimateTreeWidth(aMaxSizeX, aSizeY);
 {$If Defined(Nemesis) AND Defined(Shell)}
 if (ExtButton <> nil) then
 begin
  Result := Max(Result, Tl3GetComponentBoundsHelper.Instance.GetBounds(ExtButton).Right
                        - Self.ClientToScreen(Point(0, 0)).X);
 end;//ExtButton <> nil
 {$IfEnd}
//#UC END# *53EE09D70249_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.EstimateTreeWidth

procedure TnscCustomTreeComboWithHistory.ProcessTreeSelect(ChooseFromTree: Boolean;
 aTriggerSelect: Boolean);
//#UC START# *53EE0A730393_4B97EDFB0057_var*
{$IfNDef DesignTimeLibrary}
var
 l_Node: InscBaseSearchPromptNode;
 //l_Doc, l_Sub: Integer;
{$EndIf DesignTimeLibrary}
//#UC END# *53EE0A730393_4B97EDFB0057_var*
begin
//#UC START# *53EE0A730393_4B97EDFB0057_impl*
 inherited;
{$IfNDef DesignTimeLibrary} //morozov
 if ChooseFromTree then
 begin
  Inc(f_LockShowPrompts);
  try
   if Supports(Tree.GetCurrentNode, InscBaseSearchPromptNode, l_Node) then
    if l_Node.IsLinkOnDocument then
    begin
     l_Node.OpenDocument;
     Exit;
    end;
   if (Tree.Current <> -1) then
    Paras.ParagraphStrings[0] := GetNodeText(Tree.GetCurrentNode);
   DoSelect;
  finally
   Dec(f_LockShowPrompts);
  end;//try..finally
 end;//ChooseFromTree
{$EndIf DesignTimeLibrary} //morozov
//#UC END# *53EE0A730393_4B97EDFB0057_impl*
end;//TnscCustomTreeComboWithHistory.ProcessTreeSelect

procedure TnscCustomTreeComboWithHistory.ClearFields;
begin
 PromptTree := nil;
 {$If NOT Defined(DesignTimeLibrary)}
 RootNode := nil;
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 inherited;
end;//TnscCustomTreeComboWithHistory.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscSubTree);
 {* Регистрация TnscSubTree }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscCustomTreeComboWithHistory);
 {* Регистрация TnscCustomTreeComboWithHistory }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
