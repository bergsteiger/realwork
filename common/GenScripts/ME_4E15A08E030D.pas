unit nscStatusBar;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscStatusBar.pas"
// Стереотип: "GuiControl"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , TB97Tlbr
 {$IfEnd} // NOT Defined(NoTB97)
 , afwInterfaces
 , nscNewInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ProtoObjectRefList
 , Messages
 , Classes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ProtoObject
 {$If NOT Defined(NoTB97)}
 , TB97
 {$IfEnd} // NOT Defined(NoTB97)
;

type
 TnscStatusBarDock = class(TDock97, IafwAlwaysOnTopControl)
 end;//TnscStatusBarDock

 TnscStatusBar = class(TCustomToolbar97, IafwStatusBar, InscStatusBarItemsVisualizer)
  private
   f_Dock: TnscStatusBarDock;
   f_Strings: TafwStatusInfo;
   f_Visible: Boolean;
   f_Timer: TTimer;
   f_OperationsList: Tl3ProtoObjectRefList;
   f_Form: Pointer;
    {* IafwMainForm }
   f_InAdjustSizeForPanels: Boolean;
   f_UpdateStringsTimer: TTimer;
   f_GroupIndex: Integer;
  private
   function AllVisiblePanelsText: AnsiString;
   procedure WMGetText(var Msg: TWMGetText);
   procedure WMGetTextLength(var Msg: TWMGetTextLength);
  protected
   procedure SetLink;
   procedure ReleaseLink;
   procedure DoUpdateStrings(const aStrings: TafwStatusInfo;
    aCheckActions: Boolean;
    aDelayed: Boolean);
   procedure TimerProc(Sender: TObject);
   procedure FireUpUpdateStringsTimer;
   procedure UpdateStringsTimerProc(Sender: TObject);
   procedure UpdateStrings(const aStrings: TafwStatusInfo);
   procedure RegisterProvider(const aProvider: InscStatusBarItemsProvider);
   procedure UnregisterProvider(const aProvider: InscStatusBarItemsProvider);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoTB97)}
   function IsGToolbarSizeNeeded: Boolean; override;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure AdjustSizeForPanels; override;
   {$IfEnd} // NOT Defined(NoTB97)
  public
   constructor Create(AOwner: TComponent); override;
 end;//TnscStatusBar
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , afwFacade
 {$If NOT Defined(NoTB97)}
 , tb97GraphicControl
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoVCM)}
 , vcmBaseMenuManager
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MinMax
 , l3Base
 , l3InterfacesMisc
 , l3String
 , nscSizeGripPanel
 , nscStatusBarButton
 , nscStatusBarPanel
 , nscStatusBarSep
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
 , StatusBarUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StatusBarWords
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TOperationInternalDef = class(Tl3ProtoObject)
  private
   f_Provider: Pointer;
    {* InscStatusBarItemsProvider }
   f_Def: InscStatusBarItemDef;
    {* Поле для свойства Def }
  protected
   function pm_GetProvider: InscStatusBarItemsProvider;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aDef: InscStatusBarItemDef;
    const aProvider: InscStatusBarItemsProvider); reintroduce;
  public
   property Def: InscStatusBarItemDef
    read f_Def;
   property Provider: InscStatusBarItemsProvider
    read pm_GetProvider;
 end;//TOperationInternalDef

function TOperationInternalDef.pm_GetProvider: InscStatusBarItemsProvider;
//#UC START# *503DEC5200A9_503DEB310216get_var*
//#UC END# *503DEC5200A9_503DEB310216get_var*
begin
//#UC START# *503DEC5200A9_503DEB310216get_impl*
 Result := InscStatusBarItemsProvider(f_Provider);
//#UC END# *503DEC5200A9_503DEB310216get_impl*
end;//TOperationInternalDef.pm_GetProvider

constructor TOperationInternalDef.Create(const aDef: InscStatusBarItemDef;
 const aProvider: InscStatusBarItemsProvider);
//#UC START# *503DFE350045_503DEB310216_var*
//#UC END# *503DFE350045_503DEB310216_var*
begin
//#UC START# *503DFE350045_503DEB310216_impl*
 inherited Create;
 f_Def := aDef;
 f_Provider := Pointer(aProvider);
//#UC END# *503DFE350045_503DEB310216_impl*
end;//TOperationInternalDef.Create

procedure TOperationInternalDef.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_503DEB310216_var*
//#UC END# *479731C50290_503DEB310216_var*
begin
//#UC START# *479731C50290_503DEB310216_impl*
 f_Def := nil;
 f_Provider := nil;
 inherited;
//#UC END# *479731C50290_503DEB310216_impl*
end;//TOperationInternalDef.Cleanup

procedure TOperationInternalDef.ClearFields;
begin
 f_Def := nil;
 inherited;
end;//TOperationInternalDef.ClearFields

procedure TnscStatusBar.SetLink;
//#UC START# *503DE99801D3_4E15A08E030D_var*
var
 l_Form: IafwMainForm;
//#UC END# *503DE99801D3_4E15A08E030D_var*
begin
//#UC START# *503DE99801D3_4E15A08E030D_impl*
 if Supports(afw.GetMainForm(Self), IafwMainForm, l_Form)
  then l_Form.StatusBar := Self
  else l_Form := nil;
 f_Form := Pointer(l_Form);
//#UC END# *503DE99801D3_4E15A08E030D_impl*
end;//TnscStatusBar.SetLink

procedure TnscStatusBar.ReleaseLink;
//#UC START# *503DE9AA03AD_4E15A08E030D_var*
//#UC END# *503DE9AA03AD_4E15A08E030D_var*
begin
//#UC START# *503DE9AA03AD_4E15A08E030D_impl*
 if Assigned(f_Form) then
 begin
  IafwMainForm(f_Form).StatusBar := nil;
  f_Form := nil;
 end;
//#UC END# *503DE9AA03AD_4E15A08E030D_impl*
end;//TnscStatusBar.ReleaseLink

procedure TnscStatusBar.DoUpdateStrings(const aStrings: TafwStatusInfo;
 aCheckActions: Boolean;
 aDelayed: Boolean);
//#UC START# *503DE9C60211_4E15A08E030D_var*
type
 TnscStatusBarItemClass = class of Ttb97CustomGraphicControl;

 function MakeItem(aClass: TnscStatusBarItemClass; aCurrentIndex: Integer): Ttb97CustomGraphicControl;
 var
  I: Integer;
 begin
  if OrderedControls[aCurrentIndex] is aClass then
  begin
   Result := OrderedControls[aCurrentIndex] as aClass;
   Result.Visible := True;
   Exit;
  end;
  for I := 0 to ControlCount - 1 do
   if not (Controls[I] is Ttb97MoreButton) then
    if (Controls[I] is aClass) and not Controls[I].Visible then
    begin
     Result := Controls[I] as aClass;
     Result.Visible := True;
     Exit;
    end;
  Result := aClass.Create(Self);
  Result.Parent := Self;
 end;

 function CreateButton(aCurrentIndex: Integer): TnscStatusBarButton;
 begin
  Result := MakeItem(TnscStatusBarButton, aCurrentIndex) as TnscStatusBarButton;
  Result.GlyphSize := gs16;
  Result.AllowAllUp := True;
  Result.Ellipsis := False;
  Result.Margin := 1;
  Result.NoBorder := False;
 end;

 function CreatePanel(aCurrentIndex: Integer): TnscStatusBarPanel;
 begin
  Result := MakeItem(TnscStatusBarPanel, aCurrentIndex) as TnscStatusBarPanel;
  Result.Alignment := taLeftJustify;
  Result.Margin := 1;
  Result.Ellipsis := False;
  Result.Stretch := False;
  Result.AutoSize := False;
  Result.DisplayMode := dmTextOnly;
 end;

 function CreateSeparator(aCurrentIndex: Integer): TnscStatusbarSep;
 begin
  Result := MakeItem(TnscStatusbarSep, aCurrentIndex) as TnscStatusbarSep;
  Result.Height := cStatusbarItemSize;
 end;

 function CreateSizeGrip(aCurrentIndex: Integer): TnscSizeGripPanel;
 begin
  Result := MakeItem(TnscSizeGripPanel, aCurrentIndex) as TnscSizeGripPanel;
  Result.GripVisible := True;
  Result.Height := cStatusbarItemSize;
 end;

 {$IfNDef NoVCM}
 function CreateItem(aDef: TOperationInternalDef; var aCurrentIndex: Integer): Ttb97GraphicControl;
 var
  l_IOpDef: InscStatusBarOperationDef;
  l_IDelimDef: InscStatusBarDelimiterDef;
  l_IItemDef: InscStatusBarItemDef;
  l_Button: TnscStatusBarButton absolute Result;
  l_Panel: TnscStatusBarPanel absolute Result;
  l_Separator: TnscStatusbarSep absolute Result;
 begin
  if Supports(aDef.Def, InscStatusBarOperationDef, l_IOpDef) then
  begin
   if f_GroupIndex = MaxInt
    then f_GroupIndex := 1
    else Inc(f_GroupIndex);
   l_Button := CreateButton(aCurrentIndex);
   OrderIndex[l_Button] := aCurrentIndex;
   l_Button.Action := g_MenuManager.BuildAction(l_IOpDef.Operation);
   (l_Button.Action as TCustomAction).GroupIndex := f_GroupIndex;
   (l_Button.Action as TCustomAction).Visible := True;
   l_Button.GroupIndex := f_GroupIndex;
   l_Button.Images := TCustomAction(l_Button.Action).ActionList.Images;
   l_Button.Action.Update;
   if l_IOpDef.ShowCaption
    then l_Button.DisplayMode := dmBoth
    else l_Button.DisplayMode := dmGlyphOnly;
   l_Button.AutoSize := True;
   l_Button.ItemDef := l_IOpDef;
   if not l3IsNil(l_IOpDef.Caption) then
    l_Button.CCaption := l_IOpDef.Caption;
   Assert(l_Button.Action <> nil);
  end else
  if Supports(aDef.Def, InscStatusBarDelimiterDef, l_IDelimDef) then
  begin
   l_Separator := CreateSeparator(aCurrentIndex);
   OrderIndex[l_Separator] := aCurrentIndex;
   l_Separator.ItemDef := l_IDelimDef;
  end else
  if Supports(aDef.Def, InscStatusBarItemDef, l_IItemDef) then
  begin
   l_Panel := CreatePanel(aCurrentIndex);
   OrderIndex[l_Panel] := aCurrentIndex;
   l_Panel.CCaption := l_IItemDef.Caption;
   l_Panel.AutoSize := True;
   l_Panel.ItemDef := l_IItemDef;
  end else
   Assert(False);

  Inc(aCurrentIndex);
 end;
 {$EndIf  NoVCM}

 procedure CheckSubscription;
 var
  I, J, K: Integer;
  l_Item, l_ItemSrv: InscStatusBarItem;
 begin
  for I := 0 to OrderedControlsCount - 1 do
   if Supports(OrderedControls[I], InscStatusBarItem, l_Item) then
    if Assigned(l_Item.ItemDef) and Assigned(l_Item.ItemDef.SubscribedList) then
     for J := 0 to l_Item.ItemDef.SubscribedList.Count - 1 do
     for K := 0 to OrderedControlsCount - 1 do
      if Supports(OrderedControls[K], InscStatusBarItem, l_ItemSrv) then
       if Assigned(l_ItemSrv.ItemDef) then
        if l_Item.ItemDef.SubscribedList.Items[J] = l_ItemSrv.ItemDef then
         l_ItemSrv.Subscribe(l_Item);
 end;
 
var
 l_Index: Integer;
 l_CurrentIndex: Integer;
 l_Width: Integer;
 l_Count: Integer;
 l_NativeCount: Integer;
 l_Items: InscStatusBarItemDefsList;
 l_NeedEmptyPanel: Boolean;
 l_Panel: TnscStatusBarPanel;
 l_NeedCreateSizeGrip: Boolean;
//#UC END# *503DE9C60211_4E15A08E030D_var*
begin
//#UC START# *503DE9C60211_4E15A08E030D_impl*
 if aDelayed or afw.IsObjectLocked(Self) then
 begin
  if not (Assigned(f_UpdateStringsTimer) and f_UpdateStringsTimer.Enabled) then
   FireUpUpdateStringsTimer;
  Exit;
 end;

 LockResize;
 try
  {$IfNDef NoVCM}
  vcmDispatcher.FormDispatcher.Lock;
  try
  {$EndIf  NoVCM}
   afw.BeginOp;
   try
    //f_GroupIndex := 0;
    l_CurrentIndex := 0;
  
    for l_Index := Low(aStrings.rStrings) to Max(0, High(aStrings.rStrings)) do
    begin
     l_Panel := CreatePanel(l_CurrentIndex);
     OrderIndex[l_Panel] := l_CurrentIndex;
     Inc(l_CurrentIndex);
     with l_Panel do
     begin
      if aStrings.rNeedProgress and (l_Index = Max(0, High(aStrings.rStrings)))
       then ProgressIndicator := True
       else ProgressIndicator := False;
      if l_Index <= High(aStrings.rStrings)
       then CCaption := aStrings.rStrings[l_Index]
       else CCaption := nil;   
      Stretch := True;
     end;
    end;

    {$IfNDef NoVCM}
    //if aCheckActions then
     for l_Index := 0 to f_OperationsList.Count - 1 do
      CreateItem(TOperationInternalDef(f_OperationsList.Items[l_Index]), l_CurrentIndex);
    {$EndIf  NoVCM}  

    l_NeedCreateSizeGrip := True;
    for l_Index := ControlCount - 1 downto 0 do
     if (OrderIndex[Controls[l_Index]] >= l_CurrentIndex) and
        not (Controls[l_Index] is Ttb97MoreButton) then
      if l_NeedCreateSizeGrip and (Controls[l_Index] is TnscSizeGripPanel) then
      begin
       OrderIndex[Controls[l_Index]] := MaxInt;
       l_NeedCreateSizeGrip := False;
      end else
      begin
       if Controls[l_Index] is TnscStatusBarButton then
        TnscStatusBarButton(Controls[l_Index]).Action := nil;
       Controls[l_Index].Visible := False;
      end;
    if l_NeedCreateSizeGrip then
     CreateSizeGrip(l_CurrentIndex);
    AdjustSizeForPanels;

    CheckSubscription;
   finally
    afw.EndOp;
   end;
  {$IfNDef NoVCM}
  finally
   vcmDispatcher.FormDispatcher.Unlock;
  end;
  {$EndIf  NoVCM}
 finally
  UnlockResize;
 end;
//#UC END# *503DE9C60211_4E15A08E030D_impl*
end;//TnscStatusBar.DoUpdateStrings

procedure TnscStatusBar.TimerProc(Sender: TObject);
//#UC START# *503DEA120182_4E15A08E030D_var*
//#UC END# *503DEA120182_4E15A08E030D_var*
begin
//#UC START# *503DEA120182_4E15A08E030D_impl*
 if not (csDestroying in ComponentState) then
 begin
  DoUpdateStrings(f_Strings, True, False);
  if Assigned(f_Timer) then
   f_Timer.Enabled := false;
 end;
//#UC END# *503DEA120182_4E15A08E030D_impl*
end;//TnscStatusBar.TimerProc

procedure TnscStatusBar.FireUpUpdateStringsTimer;
//#UC START# *5049B3BE0205_4E15A08E030D_var*
//#UC END# *5049B3BE0205_4E15A08E030D_var*
begin
//#UC START# *5049B3BE0205_4E15A08E030D_impl*
 if not Assigned(f_UpdateStringsTimer) then
  f_UpdateStringsTimer := TTimer.Create(nil);
 f_UpdateStringsTimer.Interval := 100;
 f_UpdateStringsTimer.Enabled := False;
 f_UpdateStringsTimer.Enabled := True;
 f_UpdateStringsTimer.OnTimer := UpdateStringsTimerProc;
//#UC END# *5049B3BE0205_4E15A08E030D_impl*
end;//TnscStatusBar.FireUpUpdateStringsTimer

procedure TnscStatusBar.UpdateStringsTimerProc(Sender: TObject);
//#UC START# *5049B3DB0227_4E15A08E030D_var*
//#UC END# *5049B3DB0227_4E15A08E030D_var*
begin
//#UC START# *5049B3DB0227_4E15A08E030D_impl*
 f_UpdateStringsTimer.Enabled := False;
 DoUpdateStrings(f_Strings, False, False);
//#UC END# *5049B3DB0227_4E15A08E030D_impl*
end;//TnscStatusBar.UpdateStringsTimerProc

function TnscStatusBar.AllVisiblePanelsText: AnsiString;
//#UC START# *504F30D900F7_4E15A08E030D_var*
var
 I: Integer;
 l_Btn: TCustomToolbarButton97;
//#UC END# *504F30D900F7_4E15A08E030D_var*
begin
//#UC START# *504F30D900F7_4E15A08E030D_impl*
 Result := '';
 for I := 0 to ControlCount - 1 do
  if Controls[I] is TCustomToolbarButton97 then
  begin
   l_Btn := TCustomToolbarButton97(OrderedControls[I]);
   if l_Btn.Visible then
    if l_Btn.DisplayMode in [dmBoth, dmTextOnly] then
     if not l3IsNil(l_Btn.CCaption) then
     begin
      if Length(Result) > 0 then
       Result := Result + '|';
      Result := Result + l3Str(l_Btn.CCaption);
     end;
  end;
//#UC END# *504F30D900F7_4E15A08E030D_impl*
end;//TnscStatusBar.AllVisiblePanelsText

procedure TnscStatusBar.WMGetText(var Msg: TWMGetText);
//#UC START# *504F1A870252_4E15A08E030D_var*
//#UC END# *504F1A870252_4E15A08E030D_var*
begin
//#UC START# *504F1A870252_4E15A08E030D_impl*
 Msg.Result := StrLen(StrPLCopy(Msg.Text, AllVisiblePanelsText, Msg.TextMax - 1));
//#UC END# *504F1A870252_4E15A08E030D_impl*
end;//TnscStatusBar.WMGetText

procedure TnscStatusBar.WMGetTextLength(var Msg: TWMGetTextLength);
//#UC START# *504F1E0F03AE_4E15A08E030D_var*
//#UC END# *504F1E0F03AE_4E15A08E030D_var*
begin
//#UC START# *504F1E0F03AE_4E15A08E030D_impl*
 Msg.Result := Length(AllVisiblePanelsText);
//#UC END# *504F1E0F03AE_4E15A08E030D_impl*
end;//TnscStatusBar.WMGetTextLength

procedure TnscStatusBar.UpdateStrings(const aStrings: TafwStatusInfo);
//#UC START# *473D95CA02B5_4E15A08E030D_var*
var
 l_Strings : TafwStatusInfo;
 l_Visible : Boolean;
//#UC END# *473D95CA02B5_4E15A08E030D_var*
begin
//#UC START# *473D95CA02B5_4E15A08E030D_impl*
 l_Strings := aStrings;
 if l3CStringArrayEmpty(l_Strings.rStrings) then
  l_Strings.rStrings := nil;
 if not l3CStringArrayEQ(l_Strings.rStrings, f_Strings.rStrings) or
    (l_Strings.rNeedProgress <> f_Strings.rNeedProgress) then
 begin
  f_Strings := l_Strings;
  l_Visible := (Length(f_Strings.rStrings) > 0) or f_Strings.rNeedProgress;
  if (f_Visible <> l_Visible) then
  begin
   f_Visible := l_Visible;
   if f_Visible then
   begin
    if (f_Timer <> nil) then
     f_Timer.Enabled := false;
   end//f_Visible
   else
   begin
    // - надо подождать прежде, чем прятаться
    if (f_Timer = nil) then
    begin
     f_Timer := TTimer.Create(nil);
     f_Timer.Interval := 300;
     f_Timer.OnTimer := TimerProc;
    end;//f_Timer = nil
    try
     f_Timer.Enabled := true;
     Exit;
    except
     on EOutOfResources do ;
      // - не удалось установить таймер - выключаемся сразу
    end;//try..except
   end;//f_Visible
  end;//f_Visible <> l_Visible
  DoUpdateStrings(f_Strings, False, True);
 end;//not l3StringArrayEQ(l_Strings, f_Strings)
//#UC END# *473D95CA02B5_4E15A08E030D_impl*
end;//TnscStatusBar.UpdateStrings

procedure TnscStatusBar.RegisterProvider(const aProvider: InscStatusBarItemsProvider);
//#UC START# *498036D4036F_4E15A08E030D_var*
var
 l_Idx: Integer;
 l_OpDef: TOperationInternalDef;
//#UC END# *498036D4036F_4E15A08E030D_var*
begin
//#UC START# *498036D4036F_4E15A08E030D_impl*
 for l_IDX := aProvider.Items.Count - 1 downto 0 do
 begin
  l_OpDef := TOperationInternalDef.Create(aProvider.Items.Items[l_IDX], aProvider);
  try
   f_OperationsList.Insert(0, l_OpDef);
  finally
   l3Free(l_OpDef);
  end;
 end;
 DoUpdateStrings(f_Strings, True, False);
//#UC END# *498036D4036F_4E15A08E030D_impl*
end;//TnscStatusBar.RegisterProvider

procedure TnscStatusBar.UnregisterProvider(const aProvider: InscStatusBarItemsProvider);
//#UC START# *498036E00030_4E15A08E030D_var*
var
 l_Idx: Integer;
 l_OpDef: TOperationInternalDef;
//#UC END# *498036E00030_4E15A08E030D_var*
begin
//#UC START# *498036E00030_4E15A08E030D_impl*
 for l_IDX := f_OperationsList.Count - 1 downto 0 do
 begin
  l_OpDef := TOperationInternalDef(f_OperationsList.Items[l_IDX].Use);
  try
   if l3IEQ(l_OpDef.Provider, aProvider) then
   begin
    f_OperationsList.Remove(l_OpDef);
   end;
  finally
   l3Free(l_OpDef);
  end;
 end;
 if not (csDestroying in ComponentState) then
  DoUpdateStrings(f_Strings, True, True);
//#UC END# *498036E00030_4E15A08E030D_impl*
end;//TnscStatusBar.UnregisterProvider

procedure TnscStatusBar.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E15A08E030D_var*
//#UC END# *479731C50290_4E15A08E030D_var*
begin
//#UC START# *479731C50290_4E15A08E030D_impl*
 l3Free(f_OperationsList);
 l3Free(f_Timer);
 l3Free(f_UpdateStringsTimer);
 //l3Free(f_Dock);
 f_Strings.rStrings := nil;
 f_Strings.rNeedProgress := False;
 //ReleaseLink;
 inherited;
//#UC END# *479731C50290_4E15A08E030D_impl*
end;//TnscStatusBar.Cleanup

constructor TnscStatusBar.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4E15A08E030D_var*
//#UC END# *47D1602000C6_4E15A08E030D_var*
begin
//#UC START# *47D1602000C6_4E15A08E030D_impl*
 inherited;
 f_OperationsList := Tl3ProtoObjectRefList.Make;
 f_GroupIndex := 0;
 FullSize := True;
 SetLink;
//#UC END# *47D1602000C6_4E15A08E030D_impl*
end;//TnscStatusBar.Create

{$If NOT Defined(NoVCL)}
procedure TnscStatusBar.SetParent(AParent: TWinControl);
//#UC START# *4A97E78202FC_4E15A08E030D_var*
const
 cName = 'nscDock_for_nscStatusbar';
var
 I: Integer;
//#UC END# *4A97E78202FC_4E15A08E030D_var*
begin
//#UC START# *4A97E78202FC_4E15A08E030D_impl*
 ReleaseLink;
 if AParent <> nil then
 begin
  f_Dock := nil;
  for I := 0 to AParent.ControlCount - 1 do
   if (AParent.Controls[I] is TnscStatusBarDock) and
    SameText(AParent.Controls[I].Name, cName) then
   begin
    f_Dock := TnscStatusBarDock(AParent.Controls[I]);
    Break;
   end;

  if not Assigned(f_Dock) then
  begin
   f_Dock := TnscStatusBarDock.Create(AParent);
   f_Dock.Name := cName;
   f_Dock.Parent := AParent;
   f_Dock.Position := dpBottom;
   f_Dock.AllowDrag := False;
   f_Dock.BoundLines := [blTop];
   f_Dock.BevelWidth := 1;
   f_Dock.SmartAlign := True;
  end;
  inherited SetParent(f_Dock);
  SetLink;
 end;
//#UC END# *4A97E78202FC_4E15A08E030D_impl*
end;//TnscStatusBar.SetParent
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnscStatusBar.SetBounds(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer);
//#UC START# *4F2A599E0283_4E15A08E030D_var*
//#UC END# *4F2A599E0283_4E15A08E030D_var*
begin
//#UC START# *4F2A599E0283_4E15A08E030D_impl*
 // Если будут косяки с размерами статусбара, надо будет переопределить
 // св-ва Left, Top, Width и Height класса TCustomToolbar97 и в них возвращать
 // f_Bounds.Left и т.д. для случая, когда f_ResizeLockedCount > 0
 if (Left <> aLeft) or (Top <> 1) or (Width <> aWidth) or (Height <> aHeight) then
  inherited SetBounds(aLeft, 1, aWidth, aHeight);
//#UC END# *4F2A599E0283_4E15A08E030D_impl*
end;//TnscStatusBar.SetBounds
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoTB97)}
function TnscStatusBar.IsGToolbarSizeNeeded: Boolean;
//#UC START# *503DE79F02BA_4E15A08E030D_var*
//#UC END# *503DE79F02BA_4E15A08E030D_var*
begin
//#UC START# *503DE79F02BA_4E15A08E030D_impl*
 Result := False;
//#UC END# *503DE79F02BA_4E15A08E030D_impl*
end;//TnscStatusBar.IsGToolbarSizeNeeded
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
procedure TnscStatusBar.AdjustSizeForPanels;
//#UC START# *5058B29A007C_4E15A08E030D_var*
var
 l_Index: Integer;
//#UC END# *5058B29A007C_4E15A08E030D_var*
begin
//#UC START# *5058B29A007C_4E15A08E030D_impl*
 for l_Index := ControlCount - 1 downto 0 do
  if (Controls[l_Index] is TnscStatusBarPanel) then
   (Controls[l_Index] as TnscStatusBarPanel).AdjustSize;
//#UC END# *5058B29A007C_4E15A08E030D_impl*
end;//TnscStatusBar.AdjustSizeForPanels
{$IfEnd} // NOT Defined(NoTB97)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscStatusBarDock);
 {* Регистрация TnscStatusBarDock }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscStatusBar);
 {* Регистрация TnscStatusBar }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
