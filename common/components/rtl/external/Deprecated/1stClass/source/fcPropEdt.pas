unit fcPropEdt;
{
//
// Components : TfcPropEdt
//
// Copyright (c) 1999 by Woll2Woll Software
//
// Changes:
// 4/14/99 - PYW - Causes controls in OutlookBar not to be painted when a button is selected.
}

{$i fcIfDef.pas}

interface

uses Windows, Messages, Classes, SysUtils, Graphics,
  {$ifdef fcDelphi6Up}
  DesignIntf,
  DesignEditors,
  VCLEditors,
  {$else  fcDelphi6Up}
  dsgnintf,
  {$endif fcDelphi6Up}
  fcPicEdt, fcButton, fcImgBtn,
  fcShapeBtn, fcLabel, fcLinesEditor, fcButtonGroup, fcCollectionEditor,
  fcTreeView_ItemsEditor, fcTreeCombo, fcStatusBar, fcImager, Controls,
  fcCommon, Dialogs, fcOutlookBar, fcImageForm, fcBitmap, fcOutlookList,
  fcTreeView, fcColorCombo,stdctrls, fcCollection, forms, clipbrd;

{$i fcIfDef.pas}

const
  FC_BTN_SETSHADECOLORS = 0;
  FC_BTN_RESIZE = 1;
  FC_IMGBTN_SPLIT = 2;
  FC_CG_COUNT = 1;
  FC_CG_NEWBUTTON = 0;
  FC_OTLKPNL_ADDOUTLOOKLIST = 0;
  FC_OTLKPNL_PASTE = 1;

type
  {$ifdef fcDelphi4Up}
    TFormDesigner = IDesigner;
  {$else  fcDelphi4Up}
    {$ifdef fcDelphi4Up}
    TFormDesigner = IFormDesigner;
    {$endif}
  {$endif fcDelphi4Up}

  TfcComponentEditor = class(TDefaultEditor)
  private
    procedure ShowAboutBox;
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TfcCustomOutlookListEditor = class(TfcComponentEditor)
  public
    procedure Edit; override;
  end;

  TfcLabelCaptionEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure Edit; override;
  end;

  TfcButtonCaptionEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure Edit; override;
  end;

  TfcCustomBtnEditor = class(TfcComponentEditor)
  public
    constructor Create(AComponent: TComponent; ADesigner: TFormDesigner); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TfcImgBtnEditor = class(TfcCustomBtnEditor)
  protected
    ClickedPoint: TPoint;
  public
    constructor Create(AComponent: TComponent; ADesigner: TFormDesigner); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TfcImageBtnImageEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  TfcButtonGroupEditor = class(TfcComponentEditor)
  protected
   {$ifdef fcDelphi6Up}
    Editor: IComponentEditor;
   {$else  fcDelphi6Up}
    Editor: TComponentEditor;
   {$endif fcDelphi6Up}
    ExecutionPoint: TPoint;
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure GetObscuredEditor;
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TfcButtonGroupItemsEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  TfcButtonGroupControlClassEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TfcTreeComboEditor = class(TfcComponentEditor)
  public
    procedure Edit; override;
  end;

  TfcTreeComboItemsProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  TfcStatusBarEditor = class(TfcComponentEditor)
  public
    procedure Edit; override;
  end;

  TfcStatusBarPanelsEditor = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TfcImagerEditor = class(TfcComponentEditor)
    procedure Edit; override;
  end;

  TfcOutlookPanelEditor = class(TfcComponentEditor)
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TfcImageFormEditor = class(TfcComponentEditor)
    procedure Edit; override;
  end;

  TfcBitmapEditor = class(TPropertyEditor)
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  TfcButtonGroupSelectedEditor = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TfcTreeViewItemsProperty = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TfcTreeViewEditor = class(TfcComponentEditor)
  public
    procedure Edit; override;
  end;

  TfcColorComboSelectedColorEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TfcImageBtnTranColorEditor = class(TColorProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TfcComponentProperty = class(TComponentProperty)
  private
    FStrings: TStringList;
  protected
    function ValidComponent(AComponent: TComponent): Boolean; virtual;
    procedure GetBaseValues(const s: string); virtual;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TfcImageBtnExtImageEditor = class(TfcComponentProperty)
  protected
    function ValidComponent(AComponent: TComponent): Boolean; override;
  end;

  TfcOutlookBarActivePageEditor = class(TfcComponentProperty)
  protected
    function ValidComponent(AComponent: TComponent): Boolean; override;
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

  TfcCollectionEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

implementation

uses fcabout, registry;

constructor TfcCustomBtnEditor.Create(AComponent: TComponent; ADesigner: TFormDesigner);
begin
  inherited;
//  if Selections.Equals(Selection) then
//  if GetKeyState(VK_RBUTTON) >= 0 then
    with Component as TfcCustomBitBtn do
      if (Parent <> nil) and (Parent is TfcCustomButtonGroup) then
  begin
    if Parent is TfcCustomOutlookBar then
      with Parent as TfcCustomButtonGroup do
        Selected := ButtonItems.FindButton(Component as TfcCustomBitBtn);
      //4/14/99 - PYW - Causes controls in OutlookBar not to be painted when a button is selected.
      //Parent.Invalidate;
  end;
end;

function TfcCustomBtnEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    FC_BTN_SETSHADECOLORS: result := '&Set Shade Colors';
    FC_BTN_RESIZE: result := '&Size to Default';
  else
    result := inherited GetVerb(Index);
  end;
end;

function TfcCustomBtnEditor.GetVerbCount: Integer;
begin
  result := inherited GetVerbCount + 2;
end;

procedure TfcCustomBtnEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    FC_BTN_SETSHADECOLORS: begin
      (Component as TfcCustomBitBtn).UpdateShadeColors((Component as TfcCustomBitBtn).Color);
      Designer.Modified;
    end;
    FC_BTN_RESIZE: begin
      (Component as TfcCustomBitBtn).SizeToDefault;
      Designer.Modified;
    end;
  else
    inherited;
  end;
end;

// TfcImgBtnEditor - ComponentEditor for TfcImageBtn

constructor TfcImgBtnEditor.Create(AComponent: TComponent; ADesigner: TFormDesigner);
begin
  inherited;
  with AComponent as TfcImageBtn do
    if (Parent <> nil) and (Parent is TfcCustomButtonGroup) and
       (Parent as TfcCustomButtonGroup).Transparent then
      (Parent as TfcCustomButtonGroup).LastButtonRect := BoundsRect;
end;

procedure TfcImgBtnEditor.Edit;
begin
  if (Component is TfcImageBtn) and not (Component is TfcCustomShapeBtn) and (Component as TfcCustomImageBtn).Image.Empty then
  begin
    fcExecutePictureEditor((Component as TfcCustomImageBtn).Image, (Component as TfcCustomImageBtn).Image);
    Designer.Modified;
  end else inherited;

end;

function TfcImgBtnEditor.GetVerb(Index: Integer): string;
begin
  ClickedPoint := (Component as TfcImageBtn).ScreenToClient(fcGetCursorPos);
{  case Index of
    FC_IMGBTN_SPLIT: result := '&Split Highlighted Image';
  else}
    result := inherited GetVerb(Index);
//  end;
end;

function TfcImgBtnEditor.GetVerbCount: Integer;
begin
  result := inherited GetVerbCount// + 1;
end;

procedure TfcImgBtnEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    FC_BTN_SETSHADECOLORS:
      if (Component as TfcImageBtn).Color = clNone then
        (Component as TfcImageBtn).UpdateShadeColors((Component as TfcImageBtn).ColorAtPoint(ClickedPoint))
      else inherited ExecuteVerb(Index);
//    FC_IMGBTN_SPLIT: if Component is TfcCustomImageBtn then (Component as TfcCustomImageBtn).SplitImage;
  else
    inherited ExecuteVerb(Index);
  end;
end;

// TfcImageBtnImageEditor - PropertyEditor for the
//   Image property of TfcImageBtn

function TfcImageBtnImageEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog, paMultiSelect];
end;

function TfcImageBtnImageEditor.GetValue: string;
begin
  if TBitmap(Pointer(GetOrdValue)).Empty then
    result := '(None)'
  else result := '(TBitmap)';
end;

procedure TfcImageBtnImageEditor.Edit;
begin
  fcExecutePictureEditor(TfcBitmap(Pointer(GetOrdValue)), Pointer(GetOrdValue));
  Designer.Modified;
end;

// TfcLabelCaptionEditor - PropertyEditor for the
//   Caption property of TfcLabel

function TfcLabelCaptionEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog, paAutoUpdate];
end;

function TfcLabelCaptionEditor.GetValue: string;
begin
  result := (GetComponent(0) as TfcLabel).Caption;
  if pos(#13#10, result) <> 0 then result := Copy(result, 1, Pos(#13#10, result) - 1);
end;

procedure TfcLabelCaptionEditor.SetValue(const Value: string);
begin
  (GetComponent(0) as TfcLabel).Caption := Value;
  Designer.Modified;
end;

procedure TfcLabelCaptionEditor.Edit;
begin
  fcExecuteTextEditor(GetComponent(0), 'Caption', (GetComponent(0) as TComponent).Name + '.Caption');
  Designer.Modified;
end;

// TfcButtonCaptionEditor - PropertyEditor for
//   Caption property of TfcCustomBitBtn

function TfcButtonCaptionEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog, paAutoUpdate];
end;

function TfcButtonCaptionEditor.GetValue: string;
begin
  result := (GetComponent(0) as TfcCustomBitBtn).Caption;
  if pos(#13#10, result) <> 0 then result := Copy(result, 1, Pos(#13#10, result) - 1);
end;

procedure TfcButtonCaptionEditor.SetValue(const Value: string);
begin
  (GetComponent(0) as TfcCustomBitBtn).Caption := Value;
  Designer.Modified;
end;

procedure TfcButtonCaptionEditor.Edit;
begin
  fcExecuteTextEditor(GetComponent(0), 'Caption', (GetComponent(0) as TComponent).Name + '.Caption');
  Designer.Modified;
end;

// TfcButtonGroupEditor - ComponentEditor for
//   TfcCustomButtonGroup.

procedure TfcButtonGroupEditor.GetObscuredEditor;
var Control: TControl;
  function ControlUnderMouse: TControl;
  var i: Integer;
      p: TPoint;
  begin
    result := nil;
    with TfcCustomButtonGroup(Component) do
    begin
      p := ScreenToClient(ExecutionPoint);
      for i := 0 to ControlCount - 1 do
      begin
        if PtInRect(Controls[i].BoundsRect, p) and not (Controls[i] is TfcCustomImager) then
        begin
          result := Controls[i];
          Break;
        end;
      end;
    end;
  end;
begin
  Editor := nil;
  with TfcCustomButtonGroup(Component) do
  begin
    Control := ControlUnderMouse;
    if Control <> nil then Editor := GetComponentEditor(Control, Designer);
  end;
end;

function TfcButtonGroupEditor.GetVerb(Index: Integer): string;
begin
  result := '';
  case Index of
    FC_CG_NEWBUTTON: result := '&New Button';
  else
    result := inherited GetVerb(Index);
  end;
  ExecutionPoint := fcGetCursorPos;
  GetObscuredEditor;
  if (Index >= FC_CG_COUNT) and (Index <> GetVerbCount - 1) and (Editor <> nil) then with Editor do
    result := Component.ClassName + ' - ' + GetVerb(Index - FC_CG_COUNT);
{  Editor.Free;
  Editor := nil;}
end;

function TfcButtonGroupEditor.GetVerbCount: Integer;
var CreatedEditor: Boolean;
begin
  ExecutionPoint := fcGetCursorPos;
  result := inherited GetVerbCount + FC_CG_COUNT;
  CreatedEditor := Editor = nil;
  if CreatedEditor then GetObscuredEditor;
  if Editor <> nil then inc(result, Editor.GetVerbCount - 1);
  if CreatedEditor then
  begin
   {$ifndef fcDelphi6Up}
    Editor.Free;
   {$endif  fcDelphi6Up}
    Editor := nil;
  end;
end;

procedure TfcButtonGroupEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    FC_CG_NEWBUTTON: (Component as TfcCustomButtonGroup).ButtonItems.AddItem;
  else
    inherited;
  end;
  if (Index >= FC_CG_COUNT) and (Index <> GetVerbCount - 1) then
  begin
//    GetObscuredEditor;
    if (Editor <> nil) then Editor.ExecuteVerb(Index - FC_CG_COUNT);
  end;
  {$ifndef fcDelphi6Up}
  Editor.Free;
  {$endif  fcDelphi6Up}
  Editor := nil;
end;

procedure TfcButtonGroupEditor.Edit;
begin
  fcExecuteCollectionEditor(Component.Name + '.Buttons',
     TFormDesigner(Designer), 'ButtonItems', TfcButtonGroup(Component).ButtonItems, nil);
end;

// TfcButtonGroupItemsEditor - PropertyEditor for the
//   Items property of TfcCustomButtonGroup.

function TfcButtonGroupItemsEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog];
end;

function TfcButtonGroupItemsEditor.GetValue: string;
begin
  result := '(TfcButtonGroupItems)';
end;

procedure TfcButtonGroupItemsEditor.Edit;
begin
  fcExecuteCollectionEditor(TComponent(GetComponent(0)).Name + '.Buttons',
    TFormDesigner(Designer), 'ButtonItems', TfcButtonGroup(GetComponent(0)).ButtonItems, nil);
end;

// TfcButtonGroupControlClassEditor - PropertyEditor
//   for the ControlClass property of TfcCustomButtonGroup.

function TfcButtonGroupControlClassEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList];
end;

function TfcButtonGroupControlClassEditor.GetValue: string;
begin
  result := TfcButtonGroup(GetComponent(0)).ButtonClassName;
end;

procedure TfcButtonGroupControlClassEditor.GetValues(Proc: TGetStrProc);
begin
  Proc('TfcShapeBtn');
  Proc('TfcImageBtn');
end;

procedure TfcButtonGroupControlClassEditor.SetValue(const Value: string);
begin
  TfcButtonGroup(GetComponent(0)).ButtonClassName := Value;
end;

// TfcTreeComboEditor - ComponentEditor for TfcTreeCombo

procedure TfcTreeComboEditor.Edit;
begin
  ExecuteTreeNodesEditor(Designer, (Component as TfcCustomTreeCombo).TreeView);
end;

// TfcTreeComboItemsProperty - PropertyEditor for
//   the Items property of TfcTreeCombo.

procedure TfcTreeComboItemsProperty.Edit;
begin
  ExecuteTreeNodesEditor(Designer, (GetComponent(0) as TfcCustomTreeCombo).TreeView);
end;

function TfcTreeComboItemsProperty.GetAttributes: TPropertyAttributes;
begin
   Result:= [paDialog, paReadOnly];
end;

function TfcTreeComboItemsProperty.GetValue: string;
begin
   result:= '(TfcTreeNodes)'
end;

// TfcStatusBarEditor - ComponentEditor for TfcStatusBar

procedure TfcStatusBarEditor.Edit;
begin
  fcExecuteCollectionEditor(Component.Name + '.Panels', Designer as TFormDesigner, 'Panels',
    TfcCustomStatusBar(Component).Panels, nil);
end;

// TfcStatusBarPanelsEditor - PropertyEditor for the
//   Panels property of TfcStatusBar.

procedure TfcStatusBarPanelsEditor.Edit;
begin
  fcExecuteCollectionEditor(TComponent(GetComponent(0)).Name + '.Panels', Designer as TFormDesigner, 'Panels',
    TfcCustomStatusBar(GetComponent(0)).Panels, nil);
end;

function TfcStatusBarPanelsEditor.GetValue: string;
begin
  result := '(TfcStatusPanels)';
end;

function TfcStatusBarPanelsEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog, paReadOnly];
end;

procedure TfcImagerEditor.Edit;
begin
  fcExecutePictureEditor((Component as TfcCustomImager).Picture.Graphic, (Component as TfcCustomImager).Picture);
  Designer.Modified;
end;

function TfcOutlookPanelEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    FC_OTLKPNL_ADDOUTLOOKLIST: result := '&Create OutlookList';
    {$ifdef fcdelphi4up} { Delphi 3 does not support paste properly }
    FC_OTLKPNL_PASTE: result := '&Paste';
    {$endif}
  else
    result := inherited GetVerb(Index);
  end;
end;

function TfcOutlookPanelEditor.GetVerbCount: Integer;
begin
  {$ifdef fcdelphi4up} { Delphi 3 does not support paste properly }
  result := 2;
  {$else}
  result := 1;
  {$endif}
  inc(result, inherited GetVerbCount);
end;

procedure TfcOutlookPanelEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    FC_OTLKPNL_ADDOUTLOOKLIST: with (Component as TfcOutlookPanel) do
      TfcOutlookPage(OutlookPage).CreateOutlookList;

    {$ifdef fcdelphi4up} { Delphi 3 does not support paste properly }
    FC_OTLKPNL_PASTE: begin
          if not (Component is TfcOutlookPanel) then exit;

//          try
            if (Designer<>nil) then Designer.SelectComponent(Component);
//            for i:= 1 to 10000 do Application.ProcessMessages;
//            (TfcOutlookPanel(Component).parent as TfcOutlookBar).InPaste:= True;
            keybd_event(VK_CONTROL, 0, 0, 0); { Key down }
            keybd_event(ORD('V'), 0, 0, 0); { Key down }
            keybd_event(ORD('V'), 0, KEYEVENTF_KEYUP, 0);
            keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);
//            for i:= 1 to 100000 do Application.ProcessMessages;
//          except
//            if (Designer<>nil) then Designer.SelectComponent(TWinControl(Component).parent);
//          end;
//            (TfcOutlookPanel(Component).parent as TfcOutlookBar).InPaste:= False;
//
//          except
//            NoSel := TComponentList.Create;
//            Designer.SetSelections(NoSel);
//            NoSel.Free;
//          end;

//          PostMessage(TfcOutlookPanel(Component).Handle, WM_FC_DOCTRLV, 0, 0);
//          TfcOutlookPanel(Component).DesignPasteFromClipboard;
     end;
     {$endif}
    else inherited;
  end;
end;

procedure TfcImageFormEditor.Edit;
var ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  if fcExecutePictureEditor((Component as TfcCustomImageForm).Picture.Graphic, ABitmap) then
    (Component as TfcCustomImageForm).Picture.Graphic := ABitmap;
  ABitmap.Free;
  Designer.Modified;
end;

procedure TfcBitmapEditor.Edit;
var ABitmap: TfcBitmap;
    i: Integer;
begin
  ABitmap := TfcBitmap.Create;
  if fcExecutePictureEditor(TfcBitmap(GetOrdValue), ABitmap) then
    for i := 0 to PropCount - 1 do SetOrdValue(Integer(ABitmap));
  ABitmap.Free;
  Designer.Modified;
end;

function TfcBitmapEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog, paMultiSelect];
end;

function TfcBitmapEditor.GetValue: string;
begin
  if TfcBitmap(GetOrdValueAt(0)).Empty then result := '(None)' else result := '(TfcBitmap)';
end;

function TfcButtonGroupSelectedEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList];
end;

function TfcButtonGroupSelectedEditor.GetValue: string;
begin
  result := '(No Item Selected)';
  with GetComponent(0) as TfcCustomButtonGroup do
    if Selected <> nil then result := Selected.Button.Name;
end;

procedure TfcButtonGroupSelectedEditor.SetValue(const Value: string);
begin
  with GetComponent(0) as TfcCustomButtonGroup do
    Selected := ButtonItems.FindButton(Buttons[Value]);
end;

procedure TfcButtonGroupSelectedEditor.GetValues(Proc: TGetStrProc);
var i: Integer;
begin
  with GetComponent(0) as TfcCustomButtonGroup do
    for i := 0 to ButtonItems.Count - 1 do
      Proc(ButtonItems[i].Button.Name);
end;

procedure TfcCustomOutlookListEditor.Edit;
begin
  fcExecuteCollectionEditor(Component.Name + '.Items', TFormDesigner(Designer), 'Items', TfcCustomOutlookList(Component).Items, nil);
end;

procedure TfcTreeViewItemsProperty.Edit;
begin
  ExecuteTreeNodesEditor(Designer, GetComponent(0) as TfcTreeView);
end;

function TfcTreeViewItemsProperty.GetAttributes: TPropertyAttributes;
begin
   Result:= [paDialog];
end;

function TfcTreeViewItemsProperty.GetValue: string;
begin
   result:= '<TfcTreeNodes>'
end;

procedure TfcTreeViewEditor.Edit;
begin
  ExecuteTreeNodesEditor(Designer, TfcTreeView(Component));
end;

function TfcColorComboSelectedColorEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList, paDialog];
end;

function TfcColorComboSelectedColorEditor.GetValue: string;
begin
  with GetComponent(0) as TfcCustomColorCombo do
    result := SelectedColorString;
end;

procedure TfcColorComboSelectedColorEditor.Edit;
begin
  with GetComponent(0) as TfcCustomColorCombo do
    SelectedColor := fcExecuteColorDialog(SelectedColor);
end;

procedure TfcColorComboSelectedColorEditor.SetValue(const Value: string);
var i: Integer;
begin
  for i := 0 to PropCount - 1 do
    with GetComponent(i) as TfcCustomColorCombo do
      SelectedColorString := Value;
end;

procedure TfcColorComboSelectedColorEditor.GetValues(Proc: TGetStrProc);
var i: Integer;
begin
  with GetComponent(0) as TfcCustomColorCombo do
  begin
    TListbox(ListBox).Sorted := True;
    ListBox.InitColorList;
    for i := 0 to ListBox.AllColors.Count - 1 do
      Proc(ColorString(ListBox.AllColors.Names[i]));
  end;
end;

function TfcImageBtnTranColorEditor.GetValue: string;
begin
  if GetOrdValue = clNullColor then result := 'clNullColor' else result := inherited GetValue;
end;

procedure TfcImageBtnTranColorEditor.SetValue(const Value: string);
begin
  if Value = 'clNullColor' then SetOrdValue(clNullColor)
  else inherited;
end;

procedure TfcImageBtnTranColorEditor.GetValues(Proc: TGetStrProc);
begin
  Proc('clNullColor');
  inherited;
end;

function TfcComponentProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList, paRevertable];
end;

function TfcComponentProperty.ValidComponent(AComponent: TComponent): Boolean;
begin
  result := True;
end;

procedure TfcComponentProperty.GetBaseValues(const s: string);
begin
  FStrings.Add(s);
end;

procedure TfcComponentProperty.SetValue(const Value: string);
var CurComponent: TComponent;
begin
  if Value = '' then inherited
  else begin
   {$ifdef fcDelphi6Up}
    CurComponent := Designer.Root.FindComponent(Value);
   {$else  fcDelphi6Up}
    CurComponent := Designer.Form.FindComponent(Value);
   {$endif fcDelphi6Up}
    if ValidComponent(CurComponent) then inherited;
  end;
end;

procedure TfcComponentProperty.GetValues(Proc: TGetStrProc);
var i: Integer;
begin
  FStrings := TStringList.Create;
  FStrings.Clear;
  inherited GetValues(GetBaseValues);
  for i := 0 to FStrings.Count - 1 do
   {$ifdef fcDelphi6Up}
    if ValidComponent(Designer.Root.FindComponent(FStrings[i])) then
   {$else  fcDelphi6Up}
    if ValidComponent(Designer.Form.FindComponent(FStrings[i])) then
   {$endif fcDelphi6Up}
      Proc(FStrings[i]);
  FStrings.Free;
end;

function TfcImageBtnExtImageEditor.ValidComponent(AComponent: TComponent): Boolean;
var i: Integer;
begin
  result := False;
  for i := 0 to PropCount - 1 do if (AComponent = GetComponent(i)) then Exit;
  result := ((AComponent is TfcCustomImager) or (AComponent is TfcImageBtn));
end;

function TfcOutlookBarActivePageEditor.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes - [paMultiSelect];
end;

function TfcOutlookBarActivePageEditor.ValidComponent(AComponent: TComponent): Boolean;
begin
  result := (AComponent is TfcCustomBitBtn) and
            ((GetComponent(0) as TfcCustomOutlookBar).OutlookItems.FindButton(AComponent as TfcCustomBitBtn) <> nil)
end;

function TfcCollectionEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog];
end;

function TfcCollectionEditor.GetValue: string;
begin
  result := '(' + GetPropInfo.Name + ')';
end;

procedure TfcCollectionEditor.Edit;
begin
  fcExecuteCollectionEditor(TComponent(GetComponent(0)).Name + GetPropInfo.PropType^.Name, Designer,
    GetPropInfo.PropType^.Name, TfcCollection(GetOrdValue), nil);
end;

function TfcComponentEditor.GetVerbCount: Integer;
begin
  result := 1;
end;

function TfcComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index = GetVerbCount - 1 then result := '&About 1stClass';
end;

procedure TfcComponentEditor.ShowAboutBox;
var fcReg: TRegIniFile;
    ARegNumber: string;
begin
  fcreg := TRegIniFile.create('');
  ARegNumber := fcreg.ReadString('\Software\Woll2Woll\1stClass', 'Reg. No.', '');
  fcreg.Free;
  with TfcAbout1stForm.create(Application) do begin
     AVersion:= fcVersion1stClass;
     ARegistration:= 'Reg. No.: ' + ARegNumber;
     ShowModal;
     Free;
  end
end;

procedure TfcComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index = GetVerbCount - 1 then ShowAboutBox;
end;

end.
