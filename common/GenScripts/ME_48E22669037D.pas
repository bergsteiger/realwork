unit evQueryCardEditor;

// Модуль: "w:\common\components\gui\Garant\Everest\evQueryCardEditor.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TevQueryCardEditor" MUID: (48E22669037D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evEditor
 , evQueryCardInt
 , l3Interfaces
 , afwCustomCaretType
 , nevTools
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , nevBase
 , evEditorWithOperations
 , evCustomEditorWindow
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
 , l3Core
 //#UC START# *48E22669037Dintf_uses*
 //#UC END# *48E22669037Dintf_uses*
;

type
 TTabState = (
  tsNone
  , tsTab
  , tsShiftTab
 );//TTabState

 //#UC START# *48E22669037Dci*
 //#UC END# *48E22669037Dci*
 //#UC START# *48E22669037Dcit*
 //#UC END# *48E22669037Dcit*
 TevQueryCardEditor = class(TevEditor, IevQueryCardEditor, Il3GetMessageListener)
  private
   f_WasTab: Boolean;
    {* Был переход к новому параграфу по табуляции }
   f_QueryDocumentContainer: Pointer;
    {* InevQueryDocumentContainer }
   f_DroppingData: Boolean;
   f_DisableUnselectAfterDrop: Boolean;
   f_WasMouseButtonDown: Boolean;
   {$If NOT Defined(DesignTimeLibrary)}
   f_SavedCaretShape: TafwCaretShape;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   f_TabState: TTabState;
  private
   procedure WMKeyDown(var Msg: TWMKeyDown); message CN_KEYDOWN;
   procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
   procedure WMChar(var Msg: TWMChar); message WM_CHAR;
   procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
   procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
   procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
   procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
  protected
   function GetQueryDocumentContainer: InevQueryDocumentContainer;
   procedure DoEditorChangeState(CanSetFocus: Boolean);
   function SetCusrot2BoundaryPara(aStart: Boolean): Boolean;
    {* Установить курсора на самый верхний или самый нижний параграфы }
   procedure SendMsgChangePara(const aPara: InevPara);
    {* Послать сообщение о смене параграфа }
   function GotoNextControl(var aUseFieldOnly: Boolean): Boolean;
    {* Перейти к следующему контролу }
   function GotoPrevControl(var aUseFieldOnly: Boolean): Boolean;
    {* Перейти к предыдущему контролу }
   function GetLine: Integer;
   procedure SetCursorToPara(const aPara: InevPara;
    bAtEnd: Boolean;
    aNeedClear: Boolean);
    {* Установить курсор в позицию параграфа }
   procedure NotifyEmptySpace;
    {* Нотификация о попадании в пустое место в редакторе }
   function GetCurrPara: Tl3Variant;
   procedure ClearCardCache;
   function DroppingData: Boolean;
   procedure SignalDisableUnselectAfterDrop;
   procedure GetMessageListenerNotify(Code: Integer;
    aWParam: WPARAM;
    Msg: PMsg;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ParaChange; override;
    {* текущий параграф изменился. }
   procedure DoScrollEvent; override;
   procedure MakeCursor; override;
   function AllowDrawDocumentEdge: Boolean; override;
   procedure DoBeforeRMouseClick; override;
   function WantEnter: Boolean; override;
   function WantTab(aKeyPressed: Boolean = False): Boolean; override;
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
    {* Какие операции публикуются компонентом. }
   function DoDoDrop(aFormat: Tl3ClipboardFormat;
    const aMedium: Tl3StoragePlace;
    var dwEffect: Integer): Boolean; override;
   function DoCloseQuery: Boolean; override;
   function GetAllowMultiSelect: Boolean; override;
   function GetCanScroll: Boolean; override;
   function ProcessCommandEx(Cmd: Integer;
    aForce: Boolean;
    aSubCmd: Cardinal;
    aCount: Integer): Boolean; override;
    {* process the specified command, return true if processed }
   function SelectionClass: RevSelection; override;
   {$If NOT Defined(NoVCM)}
   procedure opSelectAll(const aParams: IvcmExecuteParamsPrim); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure testSelectAll(const aParams: IvcmTestParamsPrim); override;
   {$IfEnd} // NOT Defined(NoVCM)
   function HotSpotClass: RevEditorWindowHotSpot; override;
   {$If NOT Defined(NoVCL)}
   procedure DoContextPopup(MousePos: TPoint;
    var Handled: Boolean); override;
    {* OnContextPopup event dispatcher }
   {$IfEnd} // NOT Defined(NoVCL)
   function SelectWhenUnfocused: Boolean; override;
   procedure DoUnselectAfterInsertData; override;
   procedure ClearUpper; override;
    {* Очистить информацию о попадании мыши в HotSpot }
  public
   function GetControl: IevCustomEditorControl;
   constructor Create(AOwner: TComponent); override;
   function Tabulate: Boolean; override;
    {* эквивалетно нажатию Tab. }
   function Untabulate: Boolean; override;
    {* эквивалетно нажатию Shift-Tab. }
   function Paste: Boolean; override;
    {* вставить из буфера обмена. }
 //#UC START# *48E22669037Dpubl*
 published
   // published properties
    property WebStyle
     default true;
      {-}
    property PlainText
     default true;
      {-}
    property OnAfterFirstPaint;
      {-}
 //#UC END# *48E22669037Dpubl*
 end;//TevQueryCardEditor

implementation

uses
 l3ImplUses
 , evQueryCardEditorHotSpot
 , k2Tags
 , evdTypes
 , evOp
 , SysUtils
 , evMsgCode
 , l3Base
 , evQueryCardSelection
 {$If Defined(k2ForEditor)}
 , evTextParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evControlParaConst
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , nevNavigation
 , Windows
 , evTypes
 , ControlPara_Const
 , nevGUIInterfaces
 , ParaList_Const
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ListenersManager
 {$If NOT Defined(NoScripts)}
 , QueryCardProcessingPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *48E22669037Dimpl_uses*
 //#UC END# *48E22669037Dimpl_uses*
;

procedure TevQueryCardEditor.WMKeyDown(var Msg: TWMKeyDown);
//#UC START# *48E2270A01C3_48E22669037D_var*
var
 l_QueryCardContainer : InevQueryDocumentContainer;
 l_NeedKey            : Word;
//#UC END# *48E2270A01C3_48E22669037D_var*
begin
//#UC START# *48E2270A01C3_48E22669037D_impl*
 l_QueryCardContainer := GetQueryDocumentContainer;
 if Assigned(l_QueryCardContainer) and (l_QueryCardContainer.ModelNotify <> nil) then
 begin
  if l_QueryCardContainer.ModelNotify.KeyDown(View, Msg, CurPara) then Exit;
  l_NeedKey := Msg.CharCode;
  if l_QueryCardContainer.ModelNotify.NeedKey(CurPara, l_NeedKey) then
   Msg.CharCode := l_NeedKey;
 end;
 inherited;
//#UC END# *48E2270A01C3_48E22669037D_impl*
end;//TevQueryCardEditor.WMKeyDown

procedure TevQueryCardEditor.WMKillFocus(var Msg: TWMKillFocus);
//#UC START# *48E2272502D3_48E22669037D_var*
//#UC END# *48E2272502D3_48E22669037D_var*
begin
//#UC START# *48E2272502D3_48E22669037D_impl*
 DoEditorChangeState(False);
 inherited;
//#UC END# *48E2272502D3_48E22669037D_impl*
end;//TevQueryCardEditor.WMKillFocus

procedure TevQueryCardEditor.WMChar(var Msg: TWMChar);
//#UC START# *48E22736003D_48E22669037D_var*
var
 l_WasSel : Boolean;
 l_Point  : InevBasePoint;
//#UC END# *48E22736003D_48E22669037D_var*
begin
//#UC START# *48E22736003D_48E22669037D_impl*
 l_WasSel := HasSelection;
 inherited; 
 if l_WasSel then 
 begin 
  l_Point := Selection.Cursor.MostInner;
  if (l_Point.AsObject.TagType.IsKindOf(k2_typControlPara)) and 
    (TevControlType(l_Point.Obj.AsObject.IntA[k2_tiType]) = ev_ctCalEdit) then
  begin
   if l_Point.AtStart then
    ProcessCommand(ev_ocCharRight, False, 1);
   if l_Point.AtEnd(View) then
   begin  
    l_Point.SetAtStart(View, True);
    ProcessCommand(ev_ocCharRight, False, 1);
   end; 
  end;
 end; 
//#UC END# *48E22736003D_48E22669037D_impl*
end;//TevQueryCardEditor.WMChar

procedure TevQueryCardEditor.WMSetFocus(var Msg: TWMSetFocus);
//#UC START# *48E2274902B9_48E22669037D_var*
var
 l_PrevFocusedControl: TControl;
//#UC END# *48E2274902B9_48E22669037D_var*
begin
//#UC START# *48E2274902B9_48E22669037D_impl*
 if csDesigning in ComponentState then Exit;
 if f_TabState <> tsNone then
 begin
  if (Msg.FocusedWnd <> 0) then
  begin
   l_PrevFocusedControl := FindControl(Msg.FocusedWnd);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=287211712
   if (not f_WasMouseButtonDown) OR (l_PrevFocusedControl = Self) then
   begin
    SetCusrot2BoundaryPara(f_TabState = tsTab);
    f_TabState := tsNone; //Обработали и сбросили, чтобы отличить переход
    //по клавиатуре от перехода с помощью мыши.
   end;
  end;
 end;
 SetFlag(ev_uwfWasScroll);
 inherited;
 f_WasMouseButtonDown := False;
//#UC END# *48E2274902B9_48E22669037D_impl*
end;//TevQueryCardEditor.WMSetFocus

procedure TevQueryCardEditor.CMCancelMode(var Msg: TCMCancelMode);
//#UC START# *48E227590187_48E22669037D_var*

 function lp_IsOwnControl(aControl: TControl): Boolean;
 var
  l_Control: TControl;
 begin
  Result := False;
  if aControl = nil then Exit;
  l_Control := aControl;
  repeat
   Result := l_Control = Self;
   l_Control := l_Control.Parent;
  until Result or (l_Control = nil);
 end;

//#UC END# *48E227590187_48E22669037D_var*
begin
//#UC START# *48E227590187_48E22669037D_impl*
 if not lp_IsOwnControl(Msg.Sender) then
  DoEditorChangeState(False);
 inherited;
//#UC END# *48E227590187_48E22669037D_impl*
end;//TevQueryCardEditor.CMCancelMode

function TevQueryCardEditor.GetQueryDocumentContainer: InevQueryDocumentContainer;
//#UC START# *48E243B002EB_48E22669037D_var*
var
 l_QueryCardContainer : InevQueryDocumentContainer;
//#UC END# *48E243B002EB_48E22669037D_var*
begin
//#UC START# *48E243B002EB_48E22669037D_impl*
 if f_QueryDocumentContainer = nil then
  if (TextSource <> nil) and Supports(TextSource.DocumentContainer,
     InevQueryDocumentContainer, l_QueryCardContainer) then
   f_QueryDocumentContainer := Pointer(l_QueryCardContainer)
  else
   f_QueryDocumentContainer := nil;
 Result := InevQueryDocumentContainer(f_QueryDocumentContainer)
//#UC END# *48E243B002EB_48E22669037D_impl*
end;//TevQueryCardEditor.GetQueryDocumentContainer

procedure TevQueryCardEditor.DoEditorChangeState(CanSetFocus: Boolean);
//#UC START# *48E243C502E8_48E22669037D_var*
var
 l_QueryCardContainer: InevQueryDocumentContainer; 
//#UC END# *48E243C502E8_48E22669037D_var*
begin
//#UC START# *48E243C502E8_48E22669037D_impl*
 l_QueryCardContainer := GetQueryDocumentContainer;
 if Assigned(l_QueryCardContainer) and (l_QueryCardContainer.ModelNotify <> nil) then      
  l_QueryCardContainer.ModelNotify.HideDroppedControl(CanSetFocus); 
//#UC END# *48E243C502E8_48E22669037D_impl*
end;//TevQueryCardEditor.DoEditorChangeState

function TevQueryCardEditor.SetCusrot2BoundaryPara(aStart: Boolean): Boolean;
 {* Установить курсора на самый верхний или самый нижний параграфы }
//#UC START# *48E244650257_48E22669037D_var*
var
 l_Para               : InevPara;
 l_QueryCardContainer : InevQueryDocumentContainer;
//#UC END# *48E244650257_48E22669037D_var*
begin
//#UC START# *48E244650257_48E22669037D_impl*
 Result := False;
 l_QueryCardContainer := GetQueryDocumentContainer;
 if Assigned(l_QueryCardContainer) and (l_QueryCardContainer.ModelNotify <> nil) then
  if aStart then
   l_Para := l_QueryCardContainer.ModelNotify.GetFirstPara(False)
  else
   l_Para := l_QueryCardContainer.ModelNotify.GetLastPara(False);
 if l_Para <> nil then
 begin
  InevSelection(Selection).Unselect;
  //ScrollToPara(l_Para.AnchorID); // http://mdp.garant.ru/pages/viewpage.action?pageId=96483902
  //                               // без принудительного крокручивания КЗ шли глюки с отрисовкой
  // больше не нужно в связи с http://mdp.garant.ru/pages/viewpage.action?pageId=338461566
  SetCursorToPara(l_Para, False, False);
  SetFlag(ev_uwfWasScroll);
  Result := True;
 end;
//#UC END# *48E244650257_48E22669037D_impl*
end;//TevQueryCardEditor.SetCusrot2BoundaryPara

procedure TevQueryCardEditor.SendMsgChangePara(const aPara: InevPara);
 {* Послать сообщение о смене параграфа }
//#UC START# *48E2459800D8_48E22669037D_var*
var
 l_QueryCardContainer: InevQueryDocumentContainer;
//#UC END# *48E2459800D8_48E22669037D_var*
begin
//#UC START# *48E2459800D8_48E22669037D_impl*
 {$IfNDef DesignTimeLibrary}
 if (Selection <> nil) AND (Selection.Cursor <> nil) then
 begin
  with Selection.Caret do
   with Selection.Cursor.MostInner.Obj^ do
    if AsObject.IsKindOf(k2_typControlPara) AND (AsObject.IntA[k2_tiType] = Ord(ev_ctCalEdit)) then
    begin
     if (OvrCaretType.Shape <> InsCaretType.Shape) then
     begin
      f_SavedCaretShape := InsCaretType.Shape;
      InsCaretType.Shape := OvrCaretType.Shape;
     end;//OvrCaretType.Shape <> InsCaretType.Shape
    end//IsKindOf(k2_typControlPara) AND (IntA[k2_tiType] = Ord(ev_ctCalEdit))
    else
     InsCaretType.Shape := f_SavedCaretShape;
 end;//Selection <> nil
 {$EndIf  DesignTimeLibrary}
 l_QueryCardContainer := GetQueryDocumentContainer;
 if Assigned(l_QueryCardContainer) and (l_QueryCardContainer.ModelNotify <> nil) then      
  l_QueryCardContainer.ModelNotify.ChangePara(aPara);     
//#UC END# *48E2459800D8_48E22669037D_impl*
end;//TevQueryCardEditor.SendMsgChangePara

function TevQueryCardEditor.GotoNextControl(var aUseFieldOnly: Boolean): Boolean;
 {* Перейти к следующему контролу }
//#UC START# *48E2460A034D_48E22669037D_var*
var
 l_CtrlNav   : IevControlIterator;
 l_Control   : IevCustomEditorControl;
 l_VisCtrl   : IevCustomEditorControl;
 l_LineCount : Integer;
//#UC END# *48E2460A034D_48E22669037D_var*
begin
//#UC START# *48E2460A034D_48E22669037D_impl*
 Result := False;
 if Selection <> nil then
 begin
  l_Control := GetControl;
  if l_Control <> nil then
  begin
   l_CtrlNav := l_Control.GetControlIterator;
   if (l_Control.ControlType <> ev_ctCollapsedPanel) then
    l_LineCount := evTextParaLineCount(View.FormatInfoByPoint(Selection.Cursor.MostInner))
   else
    l_LineCount := 0;
   if ((l_Control.ControlType in evEditControls) and
      (GetLine < l_LineCount) and aUseFieldOnly) then
     aUseFieldOnly := False
   else
    try
     InevSelection(Selection).Unselect;
     l_VisCtrl := l_CtrlNav.GetNextVisible(aUseFieldOnly);
     try
      if l_VisCtrl <> nil then
      begin
       SetCursorToPara(l_VisCtrl.Para, False, False);
       if l_Control.ControlType = ev_ctCollapsedPanel then
       begin
        SetFlag(ev_uwfBlock);
        Update;
       end;
       Result := True;
      end //if l_VisCtrl <> nil then
      else
       if not l_Control.IsMultiline then
       begin
        SetCursorToPara(l_Control.Para, False, False);//Чтобы курсор не терялся
        Result := True;
       end; //if not l_Control.IsMultiline then
     finally//try..finally
      l_VisCtrl := nil;
     end;
    finally//try..finally
     l_Control := nil;
    end//try..finally
  end; //if l_Control <> nil then
 end; //if Selection <> nil then
//#UC END# *48E2460A034D_48E22669037D_impl*
end;//TevQueryCardEditor.GotoNextControl

function TevQueryCardEditor.GotoPrevControl(var aUseFieldOnly: Boolean): Boolean;
 {* Перейти к предыдущему контролу }
//#UC START# *48E2461A01E7_48E22669037D_var*
var
 l_CtrlNav   : IevControlIterator;
 l_Control   : IevCustomEditorControl;
 l_VisCtrl   : IevCustomEditorControl;
 l_LineNumber : Integer;
//#UC END# *48E2461A01E7_48E22669037D_var*
begin
//#UC START# *48E2461A01E7_48E22669037D_impl*
 Result := False;
 if Selection <> nil then
 begin
  l_Control := GetControl;
  if (l_Control <> nil) then
  begin
   l_LineNumber := GetLine;
   if not (l_Control.ControlType in evEditControls) or (l_LineNumber = 1) or
      not aUseFieldOnly then
    try
     InevSelection(Selection).Unselect;
     l_CtrlNav := l_Control.GetControlIterator;
     l_VisCtrl := l_CtrlNav.GetPrevVisible(aUseFieldOnly);
     try
      if l_VisCtrl <> nil then
      begin
       SetCursorToPara(l_VisCtrl.Para, False, False);
       if not l_Control.IsMultiline then
       begin
        SetFlag(ev_uwfCursor);
        Update;
       end;
       Result:= True;
      end
      else
       if not l_Control.IsMultiline then
       begin
        SetCursorToPara(l_Control.Para, False, False);
        Result:= True;
       end;
     finally
      l_VisCtrl := nil;
     end;
    finally
     l_Control := nil;
    end
   else
    if (l_Control.ControlType in evEditControls) and (l_LineNumber > 1) then
    begin
     if aUseFieldOnly then
      aUseFieldOnly := False
     else
      Result := True;
    end;
  end; //if (l_Control <> nil) then
 end; //if Selection <> nil then
//#UC END# *48E2461A01E7_48E22669037D_impl*
end;//TevQueryCardEditor.GotoPrevControl

function TevQueryCardEditor.GetControl: IevCustomEditorControl;
//#UC START# *48E2488202D5_48E22669037D_var*
//#UC END# *48E2488202D5_48E22669037D_var*
begin
//#UC START# *48E2488202D5_48E22669037D_impl*
 Selection.Cursor.MostInner.Obj.AsObject.QT(IevCustomEditorControl, Result);
//#UC END# *48E2488202D5_48E22669037D_impl*
end;//TevQueryCardEditor.GetControl

function TevQueryCardEditor.GetLine: Integer;
//#UC START# *48E24904033E_48E22669037D_var*
var
 l_TagLine : IevTagLine;
 l_Pt      : InevBasePoint;
//#UC END# *48E24904033E_48E22669037D_var*
begin
//#UC START# *48E24904033E_48E22669037D_impl*
 l_Pt := Selection.Cursor.MostInner;
 if Supports(l_Pt, IevTagLine, l_TagLine) then
  Result := l_TagLine.GetLine(View.FormatInfoByPoint(l_Pt))
 else 
  Result := -1; 
//#UC END# *48E24904033E_48E22669037D_impl*
end;//TevQueryCardEditor.GetLine

procedure TevQueryCardEditor.WMLButtonDown(var Msg: TWMLButtonDown);
//#UC START# *5270B15102AB_48E22669037D_var*
//#UC END# *5270B15102AB_48E22669037D_var*
begin
//#UC START# *5270B15102AB_48E22669037D_impl*
 f_WasMouseButtonDown := True;
 inherited;
//#UC END# *5270B15102AB_48E22669037D_impl*
end;//TevQueryCardEditor.WMLButtonDown

procedure TevQueryCardEditor.WMRButtonDown(var Msg: TWMRButtonDown);
//#UC START# *5270B18C017C_48E22669037D_var*
//#UC END# *5270B18C017C_48E22669037D_var*
begin
//#UC START# *5270B18C017C_48E22669037D_impl*
 f_WasMouseButtonDown := True;
 inherited;
//#UC END# *5270B18C017C_48E22669037D_impl*
end;//TevQueryCardEditor.WMRButtonDown

procedure TevQueryCardEditor.SetCursorToPara(const aPara: InevPara;
 bAtEnd: Boolean;
 aNeedClear: Boolean);
 {* Установить курсор в позицию параграфа }
//#UC START# *48D3B965002C_48E22669037D_var*
var
 l_Point: InevPoint; 
//#UC END# *48D3B965002C_48E22669037D_var*
begin
//#UC START# *48D3B965002C_48E22669037D_impl*
 if Selection <> nil then
 begin
  if bAtEnd then
  begin
   l_Point := aPara.MakePoint;
   l_Point.SetAtEnd(View, True);
   InevSelection(Selection).SelectPoint(l_Point, False);
  end
  else
   InevSelection(Selection).SelectPoint(aPara.MakePoint, False);
  SendMsgChangePara(Selection.Cursor.MostInner.Obj.AsPara);
  if aNeedClear then
   SetFlag(ev_uwfBlock)
  else
   Update;    
 end;  
//#UC END# *48D3B965002C_48E22669037D_impl*
end;//TevQueryCardEditor.SetCursorToPara

procedure TevQueryCardEditor.NotifyEmptySpace;
 {* Нотификация о попадании в пустое место в редакторе }
//#UC START# *48D3B97F01A9_48E22669037D_var*
//#UC END# *48D3B97F01A9_48E22669037D_var*
begin
//#UC START# *48D3B97F01A9_48E22669037D_impl*
 DoEditorChangeState(True);
//#UC END# *48D3B97F01A9_48E22669037D_impl*
end;//TevQueryCardEditor.NotifyEmptySpace

function TevQueryCardEditor.GetCurrPara: Tl3Variant;
//#UC START# *48D3B9900141_48E22669037D_var*
//#UC END# *48D3B9900141_48E22669037D_var*
begin
//#UC START# *48D3B9900141_48E22669037D_impl*
 Result := CurPara;
//#UC END# *48D3B9900141_48E22669037D_impl*
end;//TevQueryCardEditor.GetCurrPara

procedure TevQueryCardEditor.ClearCardCache;
//#UC START# *48D3B99B0241_48E22669037D_var*
//#UC END# *48D3B99B0241_48E22669037D_var*
begin
//#UC START# *48D3B99B0241_48E22669037D_impl*
 f_QueryDocumentContainer := nil;
 if (Selection <> nil) then
  Selection.Document := nil;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=300033256
  // А то видите ли в этом коде:
  (*
   TenQueryCard.TextSourceDocumentChanged
   ...
   if (f_MgrSearch <> nil) then
   begin
    f_MgrSearch.CreateTree(f_QueryCard);
    f_MgrSearch.ReadSettings;
   end;
  *)
  // В CreateTree лезут к Selection (в частности к Collapsed), а MakeCursor - ещё не случился
  // ну и случается "любимый" Assert в TnevParaPrim.Range, т.к. курсоры старые,
  // а документ уже новый.
//#UC END# *48D3B99B0241_48E22669037D_impl*
end;//TevQueryCardEditor.ClearCardCache

function TevQueryCardEditor.DroppingData: Boolean;
//#UC START# *48D3B9A701AF_48E22669037D_var*
//#UC END# *48D3B9A701AF_48E22669037D_var*
begin
//#UC START# *48D3B9A701AF_48E22669037D_impl*
 Result := f_DroppingData;
//#UC END# *48D3B9A701AF_48E22669037D_impl*
end;//TevQueryCardEditor.DroppingData

procedure TevQueryCardEditor.SignalDisableUnselectAfterDrop;
//#UC START# *48D3B9B403E5_48E22669037D_var*
//#UC END# *48D3B9B403E5_48E22669037D_var*
begin
//#UC START# *48D3B9B403E5_48E22669037D_impl*
 if DroppingData then
  f_DisableUnselectAfterDrop := True;
//#UC END# *48D3B9B403E5_48E22669037D_impl*
end;//TevQueryCardEditor.SignalDisableUnselectAfterDrop

procedure TevQueryCardEditor.GetMessageListenerNotify(Code: Integer;
 aWParam: WPARAM;
 Msg: PMsg;
 var theResult: Tl3HookProcResult);
//#UC START# *4F62032D0058_48E22669037D_var*
//#UC END# *4F62032D0058_48E22669037D_var*
begin
//#UC START# *4F62032D0058_48E22669037D_impl*
 if Msg.Message = WM_KEYDOWN then
  if (Msg.wParam = VK_TAB) then
   if (KeyDataToShiftState(Msg.lParam) = [ssShift])
    then f_TabState := tsShiftTab
    else f_TabState := tsTab
  else
   f_TabState := tsNone;
//#UC END# *4F62032D0058_48E22669037D_impl*
end;//TevQueryCardEditor.GetMessageListenerNotify

procedure TevQueryCardEditor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48E22669037D_var*
//#UC END# *479731C50290_48E22669037D_var*
begin
//#UC START# *479731C50290_48E22669037D_impl*
 f_QueryDocumentContainer := nil;
 Tl3ListenersManager.RemoveGetMessageListener(Self);
 inherited;
//#UC END# *479731C50290_48E22669037D_impl*
end;//TevQueryCardEditor.Cleanup

constructor TevQueryCardEditor.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_48E22669037D_var*
//#UC END# *47D1602000C6_48E22669037D_var*
begin
//#UC START# *47D1602000C6_48E22669037D_impl*
 inherited;
 WebStyle := True;
 PlainText := True;
 {$IfNDef DesignTimeLibrary}
 f_SavedCaretShape := Selection.Caret.InsCaretType.Shape;
 {$EndIf  DesignTimeLibrary}
 Tl3ListenersManager.AddGetMessageListener(Self);
//#UC END# *47D1602000C6_48E22669037D_impl*
end;//TevQueryCardEditor.Create

procedure TevQueryCardEditor.ParaChange;
 {* текущий параграф изменился. }
//#UC START# *482BFA340236_48E22669037D_var*
//#UC END# *482BFA340236_48E22669037D_var*
begin
//#UC START# *482BFA340236_48E22669037D_impl*
 SendMsgChangePara(Selection.Cursor.MostInner.Obj.AsPara);
 inherited;
//#UC END# *482BFA340236_48E22669037D_impl*
end;//TevQueryCardEditor.ParaChange

procedure TevQueryCardEditor.DoScrollEvent;
//#UC START# *482BFA79031D_48E22669037D_var*
//#UC END# *482BFA79031D_48E22669037D_var*
begin
//#UC START# *482BFA79031D_48E22669037D_impl*
 DoEditorChangeState(False);
 inherited;
//#UC END# *482BFA79031D_48E22669037D_impl*
end;//TevQueryCardEditor.DoScrollEvent

procedure TevQueryCardEditor.MakeCursor;
//#UC START# *482BFA9401ED_48E22669037D_var*
var
 l_QueryCardContainer : InevQueryDocumentContainer;
//#UC END# *482BFA9401ED_48E22669037D_var*
begin
//#UC START# *482BFA9401ED_48E22669037D_impl*
 // Документ поменялся - сбросим кыш
 f_QueryDocumentContainer := nil;
 inherited;
 l_QueryCardContainer := GetQueryDocumentContainer;
 if Assigned(l_QueryCardContainer) and (l_QueryCardContainer.ModelNotify <> nil) then      
  l_QueryCardContainer.ModelNotify.CursorCreate;   
//#UC END# *482BFA9401ED_48E22669037D_impl*
end;//TevQueryCardEditor.MakeCursor

function TevQueryCardEditor.AllowDrawDocumentEdge: Boolean;
//#UC START# *482BFBEE00D5_48E22669037D_var*
//#UC END# *482BFBEE00D5_48E22669037D_var*
begin
//#UC START# *482BFBEE00D5_48E22669037D_impl*
 Result := False;
//#UC END# *482BFBEE00D5_48E22669037D_impl*
end;//TevQueryCardEditor.AllowDrawDocumentEdge

procedure TevQueryCardEditor.DoBeforeRMouseClick;
//#UC START# *482BFC8100F4_48E22669037D_var*
var
 l_QueryCardContainer : InevQueryDocumentContainer;
//#UC END# *482BFC8100F4_48E22669037D_var*
begin
//#UC START# *482BFC8100F4_48E22669037D_impl*
 inherited;
 l_QueryCardContainer := GetQueryDocumentContainer;
 if Assigned(l_QueryCardContainer) and (l_QueryCardContainer.ModelNotify <> nil) then
  l_QueryCardContainer.ModelNotify.BeforeRMouseClick;
//#UC END# *482BFC8100F4_48E22669037D_impl*
end;//TevQueryCardEditor.DoBeforeRMouseClick

function TevQueryCardEditor.WantEnter: Boolean;
//#UC START# *482BFCA000E4_48E22669037D_var*
//#UC END# *482BFCA000E4_48E22669037D_var*
begin
//#UC START# *482BFCA000E4_48E22669037D_impl*
 Result := False; //У нас своя обработка Enter
//#UC END# *482BFCA000E4_48E22669037D_impl*
end;//TevQueryCardEditor.WantEnter

function TevQueryCardEditor.WantTab(aKeyPressed: Boolean = False): Boolean;
//#UC START# *482BFCAE0072_48E22669037D_var*

 function CheckWantTab: Boolean;
 var
  l_QueryCardContainer : InevQueryDocumentContainer;
 begin
  l_QueryCardContainer := GetQueryDocumentContainer;
  if Assigned(l_QueryCardContainer) and (l_QueryCardContainer.ModelNotify <> nil) then  
   if l3System.Keyboard.Key[vk_Shift].Down then
    Result := not l_QueryCardContainer.ModelNotify.IsFirstField(CurPara)
   else   
    Result := not l_QueryCardContainer.ModelNotify.IsLastField(CurPara)
  else 
   Result := True     
 end;
 
//#UC END# *482BFCAE0072_48E22669037D_var*
begin
//#UC START# *482BFCAE0072_48E22669037D_impl*
 if aKeyPressed then 
 begin
  f_WasTab := CheckWantTab;
  Result := True;   
 end
 else 
 if f_WasTab then
 begin
  f_WasTab := False;
  Result := True;
 end
 else
  Result := CheckWantTab;
//#UC END# *482BFCAE0072_48E22669037D_impl*
end;//TevQueryCardEditor.WantTab

function TevQueryCardEditor.Tabulate: Boolean;
 {* эквивалетно нажатию Tab. }
//#UC START# *482BFD1802D3_48E22669037D_var*
var
 l_UseFieldOnly : Boolean;
 l_Op           : InevOp;
//#UC END# *482BFD1802D3_48E22669037D_var*
begin
//#UC START# *482BFD1802D3_48E22669037D_impl*
 Result := True;
 l_UseFieldOnly := False;
 l_Op := StartOp(ev_msgMove);
 try
  GotoNextControl(l_UseFieldOnly);
  if not Selection.Cursor.MostInner.Obj.AsObject.IsKindOf(k2_typParaList) then
   Selection.Cursor.MostInner.Move(View, ev_ocTopLeft, l_Op);
  // http://mdp.garant.ru/pages/viewpage.action?pageId=242845846
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *482BFD1802D3_48E22669037D_impl*
end;//TevQueryCardEditor.Tabulate

function TevQueryCardEditor.Untabulate: Boolean;
 {* эквивалетно нажатию Shift-Tab. }
//#UC START# *482BFD2C0107_48E22669037D_var*
var
 l_UseFieldOnly : Boolean;
//#UC END# *482BFD2C0107_48E22669037D_var*
begin
//#UC START# *482BFD2C0107_48E22669037D_impl*
 Result := True;
 l_UseFieldOnly := False;
 GotoPrevControl(l_UseFieldOnly);
//#UC END# *482BFD2C0107_48E22669037D_impl*
end;//TevQueryCardEditor.Untabulate

function TevQueryCardEditor.DefineProvideOperations: TevEditorProvideOperationTypes;
 {* Какие операции публикуются компонентом. }
//#UC START# *48735C4A03C3_48E22669037D_var*
//#UC END# *48735C4A03C3_48E22669037D_var*
begin
//#UC START# *48735C4A03C3_48E22669037D_impl*
 Result := [potEdit];
//#UC END# *48735C4A03C3_48E22669037D_impl*
end;//TevQueryCardEditor.DefineProvideOperations

function TevQueryCardEditor.DoDoDrop(aFormat: Tl3ClipboardFormat;
 const aMedium: Tl3StoragePlace;
 var dwEffect: Integer): Boolean;
//#UC START# *48BFB6D800B3_48E22669037D_var*
//#UC END# *48BFB6D800B3_48E22669037D_var*
begin
//#UC START# *48BFB6D800B3_48E22669037D_impl*
 f_DroppingData := True;
 try
  Result := inherited DoDoDrop(aFormat, aMedium, dwEffect);
 finally
  f_DroppingData := False;
 end;
//#UC END# *48BFB6D800B3_48E22669037D_impl*
end;//TevQueryCardEditor.DoDoDrop

function TevQueryCardEditor.Paste: Boolean;
 {* вставить из буфера обмена. }
//#UC START# *48C7C1A2010C_48E22669037D_var*
var
 l_ControlListener: InevControlListener;
 l_QueryCardContainer: InevQueryDocumentContainer;
//#UC END# *48C7C1A2010C_48E22669037D_var*
begin
//#UC START# *48C7C1A2010C_48E22669037D_impl*
 l_QueryCardContainer := GetQueryDocumentContainer;
 if Assigned(l_QueryCardContainer) then
  l_ControlListener := l_QueryCardContainer.ModelNotify
 else
  l_ControlListener := nil;
 if l_ControlListener <> nil then  
  l_ControlListener.StartPaste;   
 try
  Result := inherited Paste;
 finally
  if l_ControlListener <> nil then  
   l_ControlListener.FinishPaste;   
 end; 
//#UC END# *48C7C1A2010C_48E22669037D_impl*
end;//TevQueryCardEditor.Paste

function TevQueryCardEditor.DoCloseQuery: Boolean;
//#UC START# *48E1F18502D8_48E22669037D_var*
//#UC END# *48E1F18502D8_48E22669037D_var*
begin
//#UC START# *48E1F18502D8_48E22669037D_impl*
 Result := inherited DoCloseQuery;
 DoEditorChangeState(True);
//#UC END# *48E1F18502D8_48E22669037D_impl*
end;//TevQueryCardEditor.DoCloseQuery

function TevQueryCardEditor.GetAllowMultiSelect: Boolean;
//#UC START# *48E1F321030C_48E22669037D_var*
//#UC END# *48E1F321030C_48E22669037D_var*
begin
//#UC START# *48E1F321030C_48E22669037D_impl*
 Result := False;
//#UC END# *48E1F321030C_48E22669037D_impl*
end;//TevQueryCardEditor.GetAllowMultiSelect

function TevQueryCardEditor.GetCanScroll: Boolean;
//#UC START# *48E1F5F20015_48E22669037D_var*
//#UC END# *48E1F5F20015_48E22669037D_var*
begin
//#UC START# *48E1F5F20015_48E22669037D_impl*
 Result := False;
//#UC END# *48E1F5F20015_48E22669037D_impl*
end;//TevQueryCardEditor.GetCanScroll

function TevQueryCardEditor.ProcessCommandEx(Cmd: Integer;
 aForce: Boolean;
 aSubCmd: Cardinal;
 aCount: Integer): Boolean;
 {* process the specified command, return true if processed }
//#UC START# *48E227FA00E0_48E22669037D_var*
var
 l_UseFieldOnly: Boolean;
//#UC END# *48E227FA00E0_48E22669037D_var*
begin
//#UC START# *48E227FA00E0_48E22669037D_impl*
 f_TabState := tsNone;
 if (Cmd = ev_ocPageDown) or (Cmd = ev_ocPageUp) or
 (Cmd = ev_ocExtPageDown) or (Cmd = ev_ocExtPageUp) or
 (Cmd in [ev_ocSetMarker0..ev_ocSetMarker9]) or
 (Cmd in [ev_ocGotoMarker0..ev_ocGotoMarker9]) then
  Result := True
 else
  if Cmd = ev_ocExtTop then
   Result := inherited ProcessCommandEx(ev_ocExtParaHome, aForce, aSubCmd, aCount)
  else
   if Cmd = ev_ocExtBottom then
    Result := inherited ProcessCommandEx(ev_ocExtParaEnd, aForce, aSubCmd, aCount)
   else
    if (Cmd = ev_ocTopLeft) or (Cmd = ev_ocBottomRight) then
     Result := SetCusrot2BoundaryPara(Cmd = ev_ocTopLeft)
    else
     if (Cmd = ev_ocBottomRight) then
      Result := inherited ProcessCommandEx(ev_msgMove, aForce, ev_ocParaEnd, aCount)
     else
      if (Cmd = ev_ocLineDown) or (Cmd = ev_ocColumnRight) or (Cmd = ev_ocListEnd) then 
      begin
       l_UseFieldOnly := Cmd = ev_ocLineDown;
       Result := GotoNextControl(l_UseFieldOnly);
       if l_UseFieldOnly then 
        Result := True
       else
        if not Result then 
         Result := inherited ProcessCommandEx(Cmd, aForce, aSubCmd, aCount);
      end 
      else
       if (Cmd = ev_ocColumnLeft) or (Cmd = ev_ocListHome) or (Cmd = ev_ocLineUp) then
       begin
        l_UseFieldOnly := Cmd = ev_ocLineUp;
        Result := GotoPrevControl(l_UseFieldOnly);
        if l_UseFieldOnly then 
         Result := True
        else
         if not Result then 
          Result := inherited ProcessCommandEx(Cmd, aForce, aSubCmd, aCount)    
       end
      else 
       Result := inherited ProcessCommandEx(Cmd, aForce, aSubCmd, aCount);
//#UC END# *48E227FA00E0_48E22669037D_impl*
end;//TevQueryCardEditor.ProcessCommandEx

function TevQueryCardEditor.SelectionClass: RevSelection;
//#UC START# *48E22866033A_48E22669037D_var*
//#UC END# *48E22866033A_48E22669037D_var*
begin
//#UC START# *48E22866033A_48E22669037D_impl*
 Result := TevQueryCardSelection;
//#UC END# *48E22866033A_48E22669037D_impl*
end;//TevQueryCardEditor.SelectionClass

{$If NOT Defined(NoVCM)}
procedure TevQueryCardEditor.opSelectAll(const aParams: IvcmExecuteParamsPrim);
//#UC START# *48E228CC0396_48E22669037D_var*
//#UC END# *48E228CC0396_48E22669037D_var*
begin
//#UC START# *48E228CC0396_48E22669037D_impl*
 Select(ev_stPara);
//#UC END# *48E228CC0396_48E22669037D_impl*
end;//TevQueryCardEditor.opSelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TevQueryCardEditor.testSelectAll(const aParams: IvcmTestParamsPrim);
//#UC START# *48E228DB0194_48E22669037D_var*
var
 l_Point : InevBasePoint;
//#UC END# *48E228DB0194_48E22669037D_var*
begin
//#UC START# *48E228DB0194_48E22669037D_impl*
 inherited;
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  aParams.Op.Flag[vcm_ofEnabled] := InPara(k2_typControlPara, l_Point) and
                                   not l_Point.ReadOnly and
                                   evHasText(l_Point.Obj^.AsObject);
 end;//aParams.Op.Flag[vcm_ofEnabled]
//#UC END# *48E228DB0194_48E22669037D_impl*
end;//TevQueryCardEditor.testSelectAll
{$IfEnd} // NOT Defined(NoVCM)

function TevQueryCardEditor.HotSpotClass: RevEditorWindowHotSpot;
//#UC START# *48E2297000D3_48E22669037D_var*
//#UC END# *48E2297000D3_48E22669037D_var*
begin
//#UC START# *48E2297000D3_48E22669037D_impl*
 if AllowMultiSelect then 
  Result := inherited HotSpotClass
 else 
  Result := TevQueryCardEditorHotSpot;
//#UC END# *48E2297000D3_48E22669037D_impl*
end;//TevQueryCardEditor.HotSpotClass

{$If NOT Defined(NoVCL)}
procedure TevQueryCardEditor.DoContextPopup(MousePos: TPoint;
 var Handled: Boolean);
 {* OnContextPopup event dispatcher }
//#UC START# *48E22A6B00BE_48E22669037D_var*
//#UC END# *48E22A6B00BE_48E22669037D_var*
begin
//#UC START# *48E22A6B00BE_48E22669037D_impl*
 DoEditorChangeState(True);
 inherited;
//#UC END# *48E22A6B00BE_48E22669037D_impl*
end;//TevQueryCardEditor.DoContextPopup
{$IfEnd} // NOT Defined(NoVCL)

function TevQueryCardEditor.SelectWhenUnfocused: Boolean;
//#UC START# *48E22AD302CE_48E22669037D_var*
//#UC END# *48E22AD302CE_48E22669037D_var*
begin
//#UC START# *48E22AD302CE_48E22669037D_impl*
 Result := true;
//#UC END# *48E22AD302CE_48E22669037D_impl*
end;//TevQueryCardEditor.SelectWhenUnfocused

procedure TevQueryCardEditor.DoUnselectAfterInsertData;
//#UC START# *48E22B8B00CE_48E22669037D_var*
//#UC END# *48E22B8B00CE_48E22669037D_var*
begin
//#UC START# *48E22B8B00CE_48E22669037D_impl*
 if not f_DisableUnselectAfterDrop then
  inherited;
 f_DisableUnselectAfterDrop := False;
//#UC END# *48E22B8B00CE_48E22669037D_impl*
end;//TevQueryCardEditor.DoUnselectAfterInsertData

procedure TevQueryCardEditor.ClearUpper;
 {* Очистить информацию о попадании мыши в HotSpot }
//#UC START# *4A265562032B_48E22669037D_var*
var
 l_QueryCardContainer : InevQueryDocumentContainer;
//#UC END# *4A265562032B_48E22669037D_var*
begin
//#UC START# *4A265562032B_48E22669037D_impl*
 inherited;
 l_QueryCardContainer := GetQueryDocumentContainer;
 if Assigned(l_QueryCardContainer) and
    (l_QueryCardContainer.ModelNotify <> nil) then
  l_QueryCardContainer.ModelNotify.ClearUpper;
//#UC END# *4A265562032B_48E22669037D_impl*
end;//TevQueryCardEditor.ClearUpper

//#UC START# *48E22669037Dimpl*
//#UC END# *48E22669037Dimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevQueryCardEditor);
 {* Регистрация TevQueryCardEditor }
{$IfEnd} // NOT Defined(NoScripts)

end.
