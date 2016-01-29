{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$I ..\ElPack.inc}

unit ElStyleManProp;

interface

uses

  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
{$IFDEF VCL_6_USED}
  DesignIntf,
  DesignEditors,
  DesignWindows,
  DsnConst,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  Typinfo,
  ExtCtrls,
  StdCtrls,
  ComCtrls,
  {$ifdef VCL_4_USED}
  ImgList,
  {$endif}
  ElIni,
  ElStrUtils,
  ElFrmPers,
  ElXPThemedControl,
  ElEdits,
{$IFDEF ELPACK_UNICODE}
  ElUnicodeStrings,
{$ENDIF}
  frmStyleImageSelect,
  ElTools,
  ElHeader,
  ElInputDlg,
  ElClrCmb,
  ElTreeStdEditors,
  ElPromptDlg,
  ElStyleMan,
  Buttons,
  ElVCLUtils,
  ElTree,
  ElTreeGrids,
  ElPopBtn,
  ElToolBar,
  ElPanel,
  ElCombos,
  ElBtnCtl,
  ElCLabel,
  ElLabel,
  ElSplit,
  ElTreeComboBox,
  ElTreeDTPickEdit,
  ElTreeMemoEdit,
  ElTreeSpinEdit,
  ElTreeBtnEdit,
  ElTreeColorCombo,
  ElTreeTreeComboEdit;

type

  TElPropListItem = class;

  TStyleManEditDialog = class(TForm)
    Panel1: TElPanel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ElToolBar1: TElToolBar;
    btnLoadFromFile: TElToolButton;
    OkButton: TElPopupButton;
    CancelButton: TElPopupButton;
    btnSaveToFile: TElToolButton;
    ElToolButton3: TElToolButton;
    btnAddStyle: TElToolButton;
    btnAddProp: TElToolButton;
    btnDelete: TElToolButton;
    ElToolButton7: TElToolButton;
    LeftPanel: TElPanel;
    ElSplitter1: TElSplitter;
    gridProps: TElTreeStringGrid;
    ElPanel2: TElPanel;
    gridStyles: TElTreeStringGrid;
    ElLabel1: TElLabel;
    ElLabel2: TElLabel;
    inpComboEnum: TElTreeInplaceComboBox;
    inpComboBoolean: TElTreeInplaceComboBox;
    inpEditText: TElTreeInplaceEdit;
    inpEditInt: TElTreeInplaceSpinEdit;
    inpEditFloat: TElTreeInplaceFloatSpinEdit;
    inpComboColor: TElTreeInplaceColorCombo;
    inpComboSet: TElTreeInplaceTreeComboEdit;
    ElFormPersist1: TElFormPersist;
    ElIniFile1: TElIniFile;
    inpEditImage: TElTreeInplaceButtonEdit;
    inpDTPick: TElTreeInplaceDateTimePicker;
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure gridPropsItemFocused(Sender: TObject);
    procedure gridStylesItemFocused(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure gridPropsDblClick(Sender: TObject);
    procedure btnAddPropClick(Sender: TObject);
    procedure gridStylesInplaceEditorNeeded(Sender: TObject;
      Item: TElTreeItem; SectionIndex: Integer;
      SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
    procedure btnDeleteClick(Sender: TObject);
    procedure inpComboBooleanBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpComboBooleanAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpComboColorAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpComboColorBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpDTPickAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpDTPickBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditFloatBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditFloatAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpEditIntBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditIntAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpEditTextBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditTextAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpComboEnumAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpComboEnumBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpComboSetBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpComboSetAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure btnAddStyleClick(Sender: TObject);
    procedure inpEditImageBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditImageAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure ImageButtonClick(Sender: TObject);
    procedure gridStylesCompareItems(Sender: TObject; Item1,
      Item2: TElTreeItem; var res: Integer);
  private
    FStyleManager: TElStyleManager;
    SL: TStringList;
    RootStyleItem: TElTreeItem;
    ImageStream: TMemoryStream;
  protected

    procedure AddProperty;
    function GetDisplayValue(StyleName: string; Item: TElPropListItem): string;
    procedure inpComboSetItemChecked(Sender: TObject; Item: TElTreeItem);
    procedure UpdateButtons;
  public
    procedure SetData(StyleManager: TElStyleManager);
    procedure GetData(StyleManager: TElStyleManager);
    procedure SetDataFromStyles;
  end;

  TElStyleManEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TElPropListItem = class(TCollectionItem)
  protected
    FPropertyName: string;
    FTypeKind: TTypeKind;
    FTypeName: string;
    FAClassName: string;
  public
    property PropertyName: string read FPropertyName write FPropertyName;
    property TypeKind: TTypeKind read FTypeKind write FTypeKind;
    property TypeName: string read FTypeName write FTypeName;
    property AClassName: string read FAClassName write FAClassName;
  end;

  TElPropListCollection = class(TCollection)
  private
    FExclusions: TStringList;
  protected
    function GetItems(Index: Integer): TElPropListItem;
    procedure SetItems(Index: Integer; Value: TElPropListItem);
    function PropertyExcluded(PropName: string): Boolean;
  public
    function Add: TElPropListItem;
    constructor Create;
    function FindItemByName(const Name: string): TElPropListItem;
    destructor Destroy; override;
    procedure ExcludeProperty(PropName: string);
    property Items[Index: Integer]: TElPropListItem read GetItems write
      SetItems;
    default;
  end;

var
  PropList: TElPropListCollection;

procedure RegisterStyleMgrClass(AnObject: TPersistentClass; Prefix: string);

implementation

uses ElScrollbar,
  ElCheckCtl,
  ElDTPick,
  ElCalendar,
  ElCalendDlg,
  ElCalc,
  ElCalculatorEdit,
  ElGroupBox,
  ElCheckItemGrp,
  ElStatBar,
  ElSideBar,
  ElBiProgr,
  ElSpinBtn,
  ElBtnEdit,
  ElSpin,
  ElMaskEdit,
  ElCurrEdit,
  ElIPEdit,
  ElNameEdits,
  ElHotKey,
  ElListBox,
  ElDriveCombo,
  ElImgCombo,
  ElTreeCombo,
  ElMemoCombo,
  ElFontCombo,
  ElPgCtl,
  ElTrackBar,
  ElURLLabel,
  ElClock,
  ElScrollBox,
  ElExpBar,
  ElCaption,
  ElFlatCtl,
  ElAdvPanel,
  ElHTMLLbl,
  ElHTMLPanel,
  HTMLLbx,
  ElHTMLView,
  // dbugintf,
  ElFolderDlg,
  ElDailyTip;

{$R *.DFM}

const
  StyleMgrClassesRegistered: boolean = false;

type
  THackManager = class(TElStyleManager);

procedure SendDebug(const S : string);
begin
  // dbugintf.SendDebug(s);
end;

procedure RegisterStyleMgrClass(AnObject: TPersistentClass; Prefix: string);
var
  i: integer;
  PropCount: Integer;
  Props: PPropList;
  PropName: string;
  Item: TElPropListItem;
  pTD: PTypeData;
begin
  {$ifdef VCL_6_USED}
  ActivateClassGroup(Controls.TControl);
  {$endif}
  if GetClass(AnObject.ClassName) = nil then
  begin
    SendDebug('Class not found ' + AnObject.ClassName);
    RegisterClass(AnObject);
    if GetClass(AnObject.ClassName) = nil then
    SendDebug('Failed to register ' + AnObject.ClassName);
  end
  else
    SendDebug('Class found ' + AnObject.ClassName);
  if PropList <> nil then
  begin
    PropCount := GetPropList(AnObject.ClassInfo, [tkInteger, tkEnumeration,
      tkFloat, tkString, tkWString, tkLString, tkClass, tkChar, tkSet], nil);
    if PropCount > 0 then
    begin
      GetMem(Props, PropCount * sizeof(pointer));
      try
        GetPropList(AnObject.ClassInfo, [tkInteger, tkEnumeration, tkFloat,
          tkString, tkWString, tkLString, tkClass, tkChar, tkSet], Props);
        for i := 0 to PropCount - 1 do
        begin
          PropName := Props[i]^.Name;

          if Props[i]^.PropType^.Kind = tkClass then
          begin
            pTD := GetTypeData(Props[i]^.PropType^);

            if (not pTD^.ClassType.InheritsFrom(TStrings)) and
{$IFDEF ELPACK_UNICODE}
            (not pTD^.ClassType.InheritsFrom(TElWideStrings)) and
{$ENDIF}
            (not pTD^.ClassType.InheritsFrom(TBitmap)) and
              (not pTD^.ClassType.InheritsFrom(TIcon)) and
               // (not pTD^.ClassType.InheritsFrom(TCustomImageList)) and
            (pTD^.ClassType.InheritsFrom(TComponent) or (Prefix <> '')) then
              Continue;

            if (not pTD^.ClassType.InheritsFrom(TStrings)) and
{$IFDEF ELPACK_UNICODE}
            (not pTD^.ClassType.InheritsFrom(TElWideStrings)) and
{$ENDIF}
            (not (pTD^.ClassType = TBitmap)) and
              (not (pTD^.ClassType = TIcon)) and
               // (not pTD^.ClassType.InheritsFrom(TCustomImageList)) and
            pTD^.ClassType.InheritsFrom(TPersistent) then
            begin
              RegisterStyleMgrClass(TPersistentClass(pTD^.ClassType), PropName +
                '.');
              Continue;
            end;

            // Continue;
          end;

          if PropList.PropertyExcluded(PropName) then
            PropName := PropName + '|' + Props[i]^.PropType^.Name;

          Item := PropList.FindItemByName(Prefix + PropName);
          if Item <> nil then
          begin
            if (Item.TypeKind <> Props[i]^.PropType^.Kind) or
              (Item.TypeName <> Props[i]^.PropType^.Name) then
            try
              if (Item.TypeKind <> Props[i]^.PropType^.Kind) then
              begin
                raise
                  Exception.CreateFmt('Class %s declares property %s as %s, but it''s already declared as %s', [AnObject.ClassName, PropName, GetEnumName(System.TypeInfo(TypInfo.TTypeKind),
                  Ord(Props[i]^.PropType^.Kind)),
                  GetEnumName(System.TypeInfo(TypInfo.TTypeKind),
                  Ord(Item.TypeKind))]);
              end;
              if Item.TypeName <> Props[i]^.PropType^.Name then
              begin
                raise
                  Exception.CreateFmt('Class %s declares property %s as %s, but it''s already declared as %s', [AnObject.ClassName, PropName, Props[i]^.PropType^.Name, Item.TypeName]);
              end;
            except
              on E: Exception do
              begin
                Application.ShowException(E);
                Continue;
              end;
            end;
          end
          else
            with PropList.Add do
            begin
              AClassName := AnObject.ClassName;
              PropertyName := Prefix + PropName;
              TypeKind := Props[i]^.PropType^.Kind;
              TypeName := Props[i]^.PropType^.Name;
            end;
        end;
      finally
        FreeMem(Props);
      end;
    end;
  end;
end;

function TElPropListCollection.Add: TElPropListItem;
begin
  result := TElPropListItem(inherited Add);
end;

constructor TElPropListCollection.Create;
begin
  inherited Create(TElPropListItem);
  FExclusions := TStringList.Create;
  FExclusions.Duplicates := dupIgnore;
  FExclusions.Sorted := true;
end;

function TElPropListCollection.GetItems(Index: Integer): TElPropListItem;
begin
  Result := TElPropListItem(inherited Items[Index]);
end;

procedure TElPropListCollection.SetItems(Index: Integer; Value:
  TElPropListItem);
begin
  inherited Items[index] := Value;
end;

function TElPropListCollection.FindItemByName(const Name: string):
TElPropListItem;
var
  i: integer;
  s: string;
begin
  Result := nil;
  s := lowercase(Name);
  for i := 0 to Count - 1 do
  begin
    if lowercase(Items[i].PropertyName) = S then
    begin
      result := Items[i];
      exit;
    end;
  end;
end;

function TElPropListCollection.PropertyExcluded(PropName: string): Boolean;
begin
  Result := FExclusions.IndexOf(Uppercase(PropName)) <> -1;
end;

destructor TElPropListCollection.Destroy;
begin
  FreeAndNil(FExclusions);
  inherited;
end;

procedure TElPropListCollection.ExcludeProperty(PropName: string);
begin
  FExclusions.Add(Uppercase(PropName));
end;

procedure TElStyleManEditor.ExecuteVerb(Index: Integer);
begin
  {.$ifndef VCL_7_USED}
  if not StyleMgrClassesRegistered then
  {.$endif}
  begin
    StyleMgrClassesRegistered := true;

    PropList.ExcludeProperty('Orientation');
    PropList.ExcludeProperty('Layout');
    PropList.ExcludeProperty('Increment');
    PropList.ExcludeProperty('LargeIncrement');
    PropList.ExcludeProperty('MaxValue');
    PropList.ExcludeProperty('MinValue');
    PropList.ExcludeProperty('Value');
    PropList.ExcludeProperty('CharCase');
    PropList.ExcludeProperty('PasswordChar');
    PropList.ExcludeProperty('Text');
    PropList.ExcludeProperty('ButtonCaption');
    PropList.ExcludeProperty('Options');
    PropList.ExcludeProperty('Style');
    PropList.ExcludeProperty('TabWidth');
    PropList.ExcludeProperty('Position');
    PropList.ExcludeProperty('Prompt');

    RegisterStyleMgrClass(TElScrollbar, '');
    RegisterStyleMgrClass(TElTree, '');
    RegisterStyleMgrClass(TElHeader, '');
    RegisterStyleMgrClass(TElCheckBox, '');
    RegisterStyleMgrClass(TElRadioButton, '');

    RegisterStyleMgrClass(TElDateTimePicker, '');

    RegisterStyleMgrClass(TElPanel, '');
    RegisterStyleMgrClass(TElCalendar, '');
    RegisterStyleMgrClass(TElGroupBox, '');
    RegisterStyleMgrClass(TElCheckGroup, '');
    RegisterStyleMgrClass(TElRadioGroup, '');
    RegisterStyleMgrClass(TElToolBar, '');
    RegisterStyleMgrClass(TElStatusBar, '');
    RegisterStyleMgrClass(TElSideBar, '');
    RegisterStyleMgrClass(TElBiProgressBar, '');

    RegisterStyleMgrClass(TElSpinButton, '');
    RegisterStyleMgrClass(TElPopupButton, '');
    RegisterStyleMgrClass(TElGraphicButton, '');
    //RegisterStyleMgrClass(TElGauge, '');
    //RegisterStyleMgrClass(TElHistogram, '');
    //RegisterStyleMgrClass(TElGraph, '');

{$IFNDEF CLX_USED}

    //RegisterStyleMgrClass(TElAdvancedEdit, '');
    //RegisterStyleMgrClass(TElAdvancedMemo, '');
    RegisterStyleMgrClass(TElEdit, '');
    RegisterStyleMgrClass(TElButtonEdit, '');

    RegisterStyleMgrClass(TElSpinEdit, '');
    RegisterStyleMgrClass(TElFloatSpinEdit, '');
    RegisterStyleMgrClass(TElMaskEdit, '');
    RegisterStyleMgrClass(TElCurrencyEdit, '');
    RegisterStyleMgrClass(TElIPEdit, '');
    RegisterStyleMgrClass(TElFileNameEdit, '');
    RegisterStyleMgrClass(TElFolderNameEdit, '');
    RegisterStyleMgrClass(TElHotKey, '');

    RegisterStyleMgrClass(TElCalculatorEdit, '');

    RegisterStyleMgrClass(TElColorCombo, '');
    RegisterStyleMgrClass(TElListBox, '');
    RegisterStyleMgrClass(TElComboBox, '');
    RegisterStyleMgrClass(TElDriveComboBox, '');
    //RegisterStyleMgrClass(TElAdvancedComboBox, '');
    //RegisterStyleMgrClass(TElAdvancedListBox, '');
    RegisterStyleMgrClass(TElImageComboBox, '');
    RegisterStyleMgrClass(TElTreeCombo, '');
    RegisterStyleMgrClass(TElMemoCombo, '');
    RegisterStyleMgrClass(TElFontComboBox, '');
    RegisterStyleMgrClass(TElPageControl, '');
    RegisterStyleMgrClass(TElTrackBar, '');
    RegisterStyleMgrClass(TElSplitter, '');
    RegisterStyleMgrClass(TElURLLabel, '');
    RegisterStyleMgrClass(TElClock, '');
    RegisterStyleMgrClass(TElLabel, '');
    RegisterStyleMgrClass(TElScrollBox, '');
    RegisterStyleMgrClass(TElExplorerBar, '');
    RegisterStyleMgrClass(TElFormCaption, '');
    RegisterStyleMgrClass(TElFlatController, '');
    RegisterStyleMgrClass(TElFlatMultiController, '');

    RegisterStyleMgrClass(TElAdvancedPanel, '');
    RegisterStyleMgrClass(TElHTMLLabel, '');
    RegisterStyleMgrClass(TElHTMLListBox, '');
    RegisterStyleMgrClass(TElHTMLComboBox, '');
    RegisterStyleMgrClass(TElHTMLView, '');
    RegisterStyleMgrClass(TElHTMLPanel, '');
    RegisterStyleMgrClass(TElPromptDialog, '');
    RegisterStyleMgrClass(TElFolderDialog, '');
    RegisterStyleMgrClass(TElDailyTipDialog, '');
    RegisterStyleMgrClass(TElCalendarDialog, '');
    RegisterStyleMgrClass(TElInputDialog, '');
    RegisterStyleMgrClass(TElCalculatorDialog, '');
{$ENDIF}
  end;

  with TStyleManEditDialog.Create(Application) do
  try
    SetData(Component as TElStyleManager);

    if ShowModal = mrOk then
    begin
      GetData(Component as TElStyleManager);
    end;
  finally
    Free;
  end
end;

function TElStyleManEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Style Designer...';
  end;
end;

function TElStyleManEditor.GetVerbCount: Integer;
begin
  Result := 1
end;

procedure TStyleManEditDialog.LoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    try
      FStyleManager.LoadFromFile(OpenDialog.FileName);
      SetDataFromStyles;
    except
      on E: Exception do
      begin
        ElMessageDlg(E.Message, mtError, [mbOk], 0);
        FStyleManager.Clear;
        SetDataFromStyles;
      end;
    end;
  end;
end;

procedure TStyleManEditDialog.SaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    FStyleManager.SaveToFile(SaveDialog.FileName);
end;

procedure TStyleManEditDialog.SetData(StyleManager: TElStyleManager);
var
  i: integer;
  Item: TElPropListItem;
  TreeItem: TElTreeItem;
begin
  gridProps.Items.BeginUpdate;
  try
    for i := 0 to PropList.Count - 1 do
    begin
      Item := PropList[i];
      TreeItem := gridProps.Items.AddItem(nil);
      TreeItem.Text := Item.PropertyName;
      TreeItem.ColumnText.Add(Item.TypeName);
      TreeItem.AnObject := Item;
    end;
  finally
    gridProps.Items.EndUpdate;
  end;
  FStyleManager.Assign(StyleManager);
  SetDataFromStyles;
end;

procedure TStyleManEditDialog.GetData(StyleManager: TElStyleManager);
begin
  StyleManager.Assign(FStyleManager);
end;

procedure TStyleManEditDialog.gridPropsItemFocused(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TStyleManEditDialog.gridStylesItemFocused(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TStyleManEditDialog.FormCreate(Sender: TObject);
begin
  FStyleManager := TElStyleManager.Create(nil);
end;

procedure TStyleManEditDialog.FormDestroy(Sender: TObject);
begin
  FStyleManager.Free;
end;

procedure TStyleManEditDialog.gridPropsDblClick(Sender: TObject);
begin
  if (gridProps.ItemFocused <> nil) and (gridStyles.ItemFocused <> nil) then
    AddProperty;
end;

procedure TStyleManEditDialog.btnAddPropClick(Sender: TObject);
begin
  if (gridProps.ItemFocused <> nil) and (gridStyles.ItemFocused <> nil) then
    AddProperty;
end;

procedure TStyleManEditDialog.AddProperty;
var
  ParentStyle,
    NewStyle: TElTreeItem;
  PropName,
    StyleName: string;
  p: Pointer;
begin
  //NewStyle := nil;
  if gridStyles.ItemFocused.AnObject <> nil then
    ParentStyle := gridStyles.ItemFocused.Parent
  else
    ParentStyle := gridStyles.ItemFocused;

  PropName := TElPropListItem(gridProps.ItemFocused.AnObject).PropertyName;
  if gridStyles.Items.LookForItem(ParentStyle, PropName, nil, -1, false, false,
    true, false, true) <> nil then
  begin
    ElMessageDlg(Format('Property %s already defined in style %s.', [PropName,
      ParentStyle.Text]), mtError, [mbOk], 0);
    exit;
  end;
  StyleName := '\' + ParentStyle.Text;

  gridStyles.Items.BeginUpdate;
  try
    NewStyle := gridStyles.Items.AddChild(ParentStyle, PropName);
    NewStyle.AnObject := gridProps.ItemFocused.AnObject;
    case TElPropListItem(gridProps.ItemFocused.AnObject).TypeKind of
      tkSet:
        THackManager(FStyleManager).FStyles.WriteString(StyleName, PropName,
          '');
      tkEnumeration:
        THackManager(FStyleManager).FStyles.WriteInteger(StyleName, PropName,
          0);
      tkInteger:
        begin
          if TElPropListItem(gridProps.ItemFocused.AnObject).FTypeName = 'TColor'
            then
            THackManager(FStyleManager).FStyles.WriteColor(StyleName, PropName,
              clNone)
          else
            THackManager(FStyleManager).FStyles.WriteInteger(StyleName,
              PropName, 0);
        end;
      tkFloat:
        begin
          THackManager(FStyleManager).FStyles.WriteDouble(StyleName, PropName,
            0);
        end;
      tkChar,
        tkString,
        tkWString,
        tkLString:
        begin
          THackManager(FStyleManager).FStyles.WriteString(StyleName, PropName,
            '');
        end;
      tkClass:
        begin
          THackManager(FStyleManager).FStyles.WriteBinary(StyleName, PropName,
            p, 0);
        end;
    end;
    NewStyle.Parent.Expanded := true;
    NewStyle.Focused := true;

    NewStyle.ColumnText.Add(GetDisplayValue(ParentStyle.Text,
      TElPropListItem(gridProps.ItemFocused.AnObject)));
  finally
    gridStyles.Items.EndUpdate;
  end;
  if NewStyle <> nil then
    gridStyles.EnsureVisibleBottom(NewStyle);
end;

procedure TStyleManEditDialog.SetDataFromStyles;
var
  i, j: integer;
  Item: TElPropListItem;
  DefItem,
    AncItem,
    TreeItem: TElTreeItem;
  SL: TStringList;
  s: string;
begin
  RootStyleItem := nil;
  gridStyles.Items.Clear;
  gridStyles.Items.BeginUpdate;
  try
    SL := TStringList.Create;
    try
      FStyleManager.GetStyleNames(SL);
      // add all styles
      for i := 0 to SL.Count - 1 do
      begin
        TreeItem := gridStyles.Items.AddItem(nil);
        TreeItem.Text := SL[i];
      end;
      // find default style
      TreeItem := gridStyles.Items.LookForItem(nil, sDefaultStyleName, nil, -1,
        false, true, false, false, true);
      if treeItem = nil then
        raise Exception.Create('Failed to find root item');
      DefItem := TreeItem;
      DefItem.AllowEdit := false;
      RootStyleItem := DefItem;

      // group style items in the tree
      for i := 0 to SL.Count - 1 do
      begin
        s := FStyleManager.GetAncestorStyle(SL[i]);
        TreeItem := gridStyles.Items.LookForItem(nil, SL[i], nil, -1, false,
          true, false, false, true);
        AncItem := gridStyles.Items.LookForItem(nil, s, nil, -1, false, true,
          false, false, true);
        if (AncItem <> nil) and (not (AncItem.IsUnder(TreeItem))) then
        begin
          TreeItem.MoveTo(AncItem);
          TreeItem.ColumnText.Add(s);
        end
        else
        begin
          TreeItem.MoveTo(DefItem);
          if TreeItem <> DefItem then
            TreeItem.ColumnText.Add(sDefaultStyleName)
          else
            TreeItem.ColumnText.Add('');
        end;
      end;

      // enumerate styles
      i := 0;
      while i < gridStyles.Items.Count do
      begin
        TreeItem := gridStyles.Items.Item[i];
        if TreeItem.AnObject = nil then
        begin
          s := TreeItem.Text;
          SL.Clear;
          FStyleManager.GetProperties(S, SL);

          // add properties of the style
          for j := 0 to SL.Count - 1 do
          begin
            Item := PropList.FindItemByName(SL[j]);
            if Item <> nil then
            begin
              TreeItem.Expanded := true;
              AncItem := gridStyles.Items.AddItem(TreeItem);
              AncItem.AnObject := Item;
              AncItem.Text := Item.PropertyName;
              AncItem.ColumnText.Add(GetDisplayValue(S, Item));
            end;
          end;
        end;
        inc(i);
      end;
    finally
      SL.Free;
    end;
  finally
    gridStyles.Items.EndUpdate;
  end;
end;

function TStyleManEditDialog.GetDisplayValue(StyleName: string; Item:
  TElPropListItem): string;
var
  p: pointer;
  d: double;
  i: integer;
  c: TColor;
  AClass: TClass;
  TypeInfo: PTypeInfo;
  TypeData: PTypeData;
  PropInfo: PPropInfo;
  PropName: string;
  PropType: string;

  function QueryComponentClass(Info : PTypeInfo) : boolean;
  var p : PTypeData;
  begin
    p := GetTypeData(Info);
    result := (p^.ClassType.InheritsFrom(TComponent));
  end;

begin
  PropName := Item.PropertyName;
  PropType := '';
  AClass := GetClass(Item.AClassName);

  if Pos('.', PropName) > 0 then
  begin
    {$ifndef VCL_5_USED}
    result := '';
    exit;
    {$else}
    PropName := Copy(PropName, Pos('.', PropName) + 1, Length(PropName));
    AClass := GetClass(Item.AClassName);
    {$endif}
  end;

  if Pos('|', PropName) > 0 then
  begin
    PropType := Copy(PropName, Pos('|', PropName) + 1, Length(PropName));
    PropName := Copy(PropName, 1, Pos('|', PropName) - 1);
  end;
  case Item.TypeKind of
    tkEnumeration:
      begin
        result := '(Invalid value)';
        THackManager(FStyleManager).FStyles.ReadInteger('\' + StyleName,
          Item.PropertyName, 0, i);

        if AClass = nil then
        begin
          Result := result + #32 + Item.AClassName;
          exit;
        end;

        PropInfo := GetPropInfo(AClass.ClassInfo, PropName{$ifdef VCL_5_USED}, tkAny{$endif});
        if PropInfo <> nil then
        begin
          TypeInfo := PropInfo^.PropType^;

          if TypeInfo <> nil then
          begin
            TypeData := GetTypeData(TypeInfo);
            if (TypeData <> nil) and InRange(TypeData.MinValue,
              TypeData.MaxValue, i) then
              result := GetEnumName(PropInfo.PropType^, i);
          end;
        end;
      end;
    tkInteger:
      begin
        if Item.FTypeName = 'TColor' then
        begin
          THackManager(FStyleManager).FStyles.ReadColor('\' + StyleName,
            Item.PropertyName, clNone, c);
          result := ColorToString(c);
        end
        else
        begin
          THackManager(FStyleManager).FStyles.ReadInteger('\' + StyleName,
            Item.PropertyName, 0, i);
          result := IntToStr(i);
        end;
      end;
    tkFloat:
      begin
        THackManager(FStyleManager).FStyles.ReadDouble('\' + StyleName,
          Item.PropertyName, 0, d);
        if Item.FTypeName = 'TDateTime' then
          result := DateTimeToStr(d)
        else
          result := FloatToStr(d);
      end;
    tkChar,
      tkString,
      tkWString,
      tkLString:
      begin
        THackManager(FStyleManager).FStyles.ReadString('\' + StyleName,
          Item.PropertyName, '', result);
      end;
    tkClass:
      begin
        i := -1;
        THackManager(FStyleManager).FStyles.ReadBinary('\' + StyleName,
          Item.PropertyName, p, i);
        if i > 0 then
          result := '(' + Item.TypeName + ')'
        else
          result := '(none)';
      end;
    tkSet:
      begin
        THackManager(FStyleManager).FStyles.ReadString('\' + StyleName,
          Item.PropertyName, '', result);
      end;
  end;
end;

procedure TStyleManEditDialog.gridStylesInplaceEditorNeeded(
  Sender: TObject; Item: TElTreeItem; SectionIndex: Integer;
  SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
begin
  if (Item.Level = 0) then
    Editor := nil
  else
  begin
    case TElPropListItem(Item.AnObject).TypeKind of
      tkEnumeration:
        begin
          if TElPropListItem(Item.AnObject).TypeName = 'Boolean' then
            Editor := inpComboBoolean
          else
            Editor := inpComboEnum;
        end;
      tkInteger:
        begin
          if TElPropListItem(Item.AnObject).TypeName = 'TColor' then
            Editor := inpComboColor
          else
            Editor := inpEditInt;
        end;
      tkFloat:
        begin
          if TElPropListItem(Item.AnObject).TypeName = 'TDateTime' then
            Editor := inpDTPick
          else
            Editor := inpEditFloat;
        end;
      tkChar,
        tkString,
        tkWString,
        tkLString:
        begin
          Editor := inpEditText;
        end;
      tkClass:
        begin
          Editor := inpEditImage;
        end;
      tkSet:
        begin
          Editor := inpComboSet;
        end;
    end;
  end;
end;

procedure TStyleManEditDialog.btnDeleteClick(Sender: TObject);
begin
  if gridStyles.ItemFocused <> nil then
  begin
    if (gridStyles.ItemFocused.AnObject = nil) and (gridStyles.ItemFocused <>
      Self.RootStyleItem) then
    begin
      if ElMessageDlg('Do you want to delete selected style?', mtWarning,
        [mbYes, mbNo], 0) = mrYes then
      begin
        THackManager(FStyleManager).FStyles.Delete('\' +
          gridStyles.ItemFocused.Text, '');
        gridStyles.Items.DeleteItem(gridStyles.ItemFocused);
      end;
    end
    else
      if (gridStyles.ItemFocused.AnObject <> nil) then
    begin
      if ElMessageDlg('Do you want to delete selected property?', mtWarning,
        [mbYes, mbNo], 0) = mrYes then
      begin
        THackManager(FStyleManager).FStyles.Delete('\' +
          gridStyles.ItemFocused.Parent.Text, gridStyles.ItemFocused.Text);
        gridStyles.Items.DeleteItem(gridStyles.ItemFocused);
      end;
    end;
  end;
end;

procedure TStyleManEditDialog.inpComboBooleanBeforeOperation(
  Sender: TObject; var DefaultConversion: Boolean);
var
  b: boolean;
begin
  with inpComboBoolean.Editor do
  begin
    Items.Clear;
    Items.Add('False');
    Items.Add('True');
  end;
  THackManager(FStyleManager).FStyles.ReadBool('\' +
    inpComboBoolean.Item.Parent.Text, inpComboBoolean.Item.Text, false, b);
  if b then
    inpComboBoolean.Editor.ItemIndex := 1
  else
    inpComboBoolean.Editor.ItemIndex := 0;
end;

procedure TStyleManEditDialog.inpComboBooleanAfterOperation(
  Sender: TObject; var Accepted, DefaultConversion: Boolean);
var
  b: boolean;
begin
  if Accepted then
  begin
    DefaultConversion := false;
    b := inpComboBoolean.Editor.ItemIndex = 1;
    THackManager(FStyleManager).FStyles.WriteBool('\' +
      inpComboBoolean.Item.Parent.Text, inpComboBoolean.Item.Text, b);
    inpComboBoolean.ValueAsText :=
      GetDisplayValue(inpComboBoolean.Item.Parent.Text,
      TElPropListItem(inpComboBoolean.Item.AnObject));
  end;
end;

procedure TStyleManEditDialog.inpComboColorAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    THackManager(FStyleManager).FStyles.WriteColor('\' +
      inpComboColor.Item.Parent.Text, inpComboColor.Item.Text,
      inpComboColor.Editor.SelectedColor);
    inpComboColor.ValueAsText := GetDisplayValue(inpComboColor.Item.Parent.Text,
      TElPropListItem(inpComboColor.Item.AnObject));
  end;
end;

procedure TStyleManEditDialog.inpComboColorBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  c: TColor;
begin
  inpComboColor.Editor.Options := [ccoNoColor, cco4BitColors, ccoSystemColors,
    ccoCustomChoice, ccoShowNames];
  THackManager(FStyleManager).FStyles.ReadColor('\' +
    inpComboColor.Item.Parent.Text, inpComboColor.Item.Text, clNone, c);
  inpComboColor.Editor.SelectedColor := c;
end;

procedure TStyleManEditDialog.inpDTPickAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    THackManager(FStyleManager).FStyles.WriteDouble('\' +
      inpDTPick.Item.Parent.Text, inpDTPick.Item.Text, inpDTPick.Editor.DateTime);
    inpDTPick.ValueAsText := GetDisplayValue(inpDTPick.Item.Parent.Text,
      TElPropListItem(inpDTPick.Item.AnObject));
  end;
end;

procedure TStyleManEditDialog.inpDTPickBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  d: double;
begin
  inpDTPick.Editor.ShowPopupCalendar := true;
  THackManager(FStyleManager).FStyles.ReadDouble('\' +
    inpDTPick.Item.Parent.Text, inpDTPick.Item.Text, Now, d);
  inpDTPick.Editor.DateTime := d;
end;

procedure TStyleManEditDialog.inpEditFloatBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  d: double;
begin
  THackManager(FStyleManager).FStyles.ReadDouble('\' +
    inpEditFloat.Item.Parent.Text, inpEditFloat.Item.Text, 0, d);
  inpEditFloat.Editor.Value := d;
end;

procedure TStyleManEditDialog.inpEditFloatAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    THackManager(FStyleManager).FStyles.WriteDouble('\' +
      inpEditFloat.Item.Parent.Text, inpEditFloat.Item.Text,
      inpEditFloat.Editor.Value);
    inpEditFloat.ValueAsText := GetDisplayValue(inpEditFloat.Item.Parent.Text,
      TElPropListItem(inpEditFloat.Item.AnObject));
  end;
end;

procedure TStyleManEditDialog.inpEditIntBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  i: integer;
begin
  THackManager(FStyleManager).FStyles.ReadInteger('\' +
    inpEditInt.Item.Parent.Text, inpEditInt.Item.Text, 0, i);
  inpEditInt.Editor.Value := i;
end;

procedure TStyleManEditDialog.inpEditIntAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    THackManager(FStyleManager).FStyles.WriteInteger('\' +
      inpEditInt.Item.Parent.Text, inpEditInt.Item.Text, inpEditInt.Editor.Value);
    inpEditInt.ValueAsText := GetDisplayValue(inpEditInt.Item.Parent.Text,
      TElPropListItem(inpEditInt.Item.AnObject));
  end;
end;

procedure TStyleManEditDialog.inpEditTextBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  s: string;
begin
  THackManager(FStyleManager).FStyles.ReadString('\' +
    inpEditText.Item.Parent.Text, inpEditText.Item.Text, '', s);
  inpEditText.Editor.Text := s;
end;

procedure TStyleManEditDialog.inpEditTextAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    THackManager(FStyleManager).FStyles.WriteString('\' +
      inpEditText.Item.Parent.Text, inpEditText.Item.Text,
      inpEditText.Editor.Text);
    inpEditText.ValueAsText := GetDisplayValue(inpEditText.Item.Parent.Text,
      TElPropListItem(inpEditText.Item.AnObject));
  end;
end;

procedure TStyleManEditDialog.inpComboEnumAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    THackManager(FStyleManager).FStyles.WriteInteger('\' +
      inpComboEnum.Item.Parent.Text, inpComboEnum.Item.Text,
      inpComboEnum.Editor.ItemIndex);
    inpComboEnum.ValueAsText := GetDisplayValue(inpComboEnum.Item.Parent.Text,
      TElPropListItem(inpComboEnum.Item.AnObject));
  end;
end;

procedure TStyleManEditDialog.inpComboEnumBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  TypeInfo: PTypeInfo;
  TypeData: PTypeData;
  AClass: TClass;
  i: integer;
  AName: string;
begin
  with inpComboEnum.Editor do
  begin
    Items.Clear;
    AClass := FindClass(TElPropListItem(inpComboEnum.Item.AnObject).AClassName);
    if AClass = nil then exit;
    AName := TElPropListItem(inpComboEnum.Item.AnObject).PropertyName;
    if Pos('.', AName) > 0 then
      Delete(AName, 1, Pos('.', AName));
    if Pos('|', AName) > 0 then
      Delete(AName, Pos('|', AName), Length(AName));

    TypeInfo := GetPropInfo(AClass.ClassInfo, AName{$ifdef VCL_5_USED}, [tkEnumeration]{$endif})^.PropType^;
    if TypeInfo = nil then exit;
    TypeData := GetTypeData(TypeInfo);
    for i := TypeData.MinValue to TypeData.MaxValue do
      Items.Add(GetEnumName(TypeInfo, i));

    THackManager(FStyleManager).FStyles.ReadInteger('\' +
      inpComboEnum.Item.Parent.Text, inpComboEnum.Item.Text, 0, i);
    if InRange(TypeData.MinValue, TypeData.MaxValue, i) then
      ItemIndex := i
    else
      ItemIndex := 0;
  end;
end;

procedure TStyleManEditDialog.inpComboSetBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  TypeInfo,
    TypeInfo2: PTypeInfo;
  TypeData: PTypeData;
  AClass: TClass;
  i, j: integer;
  b: boolean;
  AName,
    s,
    value: string;
  TreeItem: TElTreeItem;
begin
  SL := TStringList.Create; // this one will be used later, don't dispose of it
  with inpComboSet.Editor do
  begin

    AutoProcessSelection := false;
    ShowCheckBoxes := true;
    ShowRoot := false;
    ShowButtons := false;
    ShowImages := false;
    OnItemChecked := inpComboSetItemChecked;
    Items.Clear;
    AClass := FindClass(TElPropListItem(inpComboSet.Item.AnObject).AClassName);
    if AClass = nil then exit;
    AName := TElPropListItem(inpComboSet.Item.AnObject).PropertyName;
    if Pos('.', AName) > 0 then
      Delete(AName, 1, Pos('.', AName));
    if Pos('|', AName) > 0 then
      Delete(AName, Pos('|', AName), Length(AName));
    TypeInfo := GetPropInfo(AClass.ClassInfo, AName{$ifdef VCL_5_USED}, [tkSet]{$endif})^.PropType^;
    if TypeInfo = nil then exit;
    TypeData := GetTypeData(TypeInfo);
    TypeInfo2 := TypeData.CompType^;
    TypeData := GetTypeData(TypeInfo2);

    THackManager(FStyleManager).FStyles.ReadString('\' +
      inpComboSet.Item.Parent.Text, inpComboSet.Item.Text, '', value);
    SL.CommaText := Value;

    for i := TypeData.MinValue to TypeData.MaxValue do
    begin
      s := GetEnumName(TypeInfo2, i);
      TreeItem := Items.Add(nil, s);
      s := uppercase(s);
      TreeItem.ShowCheckBox := true;
      b := false;
      for j := 0 to SL.Count - 1 do
      begin
        if Uppercase(SL[j]) = s then
        begin
          b := true;
          break;
        end;
      end;
      TreeItem.Checked := b;
    end;
    i := 0;
    while i < SL.Count do
    begin
      if Items.LookForItem(nil, SL[i], nil, -1, false, true, false, false, true)
        = nil then
        SL.Delete(i)
      else
        inc(i);
    end;
  end;
end;

procedure TStyleManEditDialog.inpComboSetItemChecked(Sender: TObject; Item:
  TElTreeItem);
begin
  if Item.Checked then
    SL.Add(Item.Text)
  else
    if SL.IndexOf(Item.Text) <> -1 then
    SL.Delete(SL.IndexOf(Item.Text));
  inpComboSet.Editor.Text := SL.CommaText;
end;

procedure TStyleManEditDialog.inpComboSetAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    THackManager(FStyleManager).FStyles.WriteString('\' +
      inpComboSet.Item.Parent.Text, inpComboSet.Item.Text, SL.CommaText);
    inpComboSet.ValueAsText := GetDisplayValue(inpComboSet.Item.Parent.Text,
      TElPropListItem(inpComboSet.Item.AnObject));
  end;
  FreeAndNil(SL);
end;

procedure TStyleManEditDialog.btnAddStyleClick(Sender: TObject);
var
  ParentStyle,
    NewStyle: TElTreeItem;
  s: TElFString;
  LookItem: TElTreeItem;
begin
  if gridStyles.ItemFocused <> nil then
  begin
    if gridStyles.ItemFocused.AnObject <> nil then
      ParentStyle := gridStyles.ItemFocused.Parent
    else
      ParentStyle := gridStyles.ItemFocused;
  end
  else
    ParentStyle := RootStyleItem;
  s := '';
  while true do
    if ElInputDlg.InputQuery('Style name', 'Please enter style name', S, false)
      then
    begin
      LookItem := nil;
      while (LookItem = nil) or (LookItem.AnObject <> nil) do
      begin
        LookItem := gridStyles.Items.LookForItem(LookItem, S, nil, -1, false,
          false, false, false, true);
        if LookItem = nil then break;
      end;
      if (LookItem = nil) then
        break
      else
      begin
        if ElMessageDlg('Style name should be unique. Re-enter?', mtError,
          [mbYes, mbNo], 0) = mrNo then exit;
      end;
    end
    else
      exit;
  if THackManager(FStyleManager).FStyles.OpenKey({'\' + ParentStyle.Text + }'\' +
    S, true) then
  begin
    THackManager(FStyleManager).FStyles.WriteString('', 'InheritsFrom',
      ParentStyle.Text);
    NewStyle := gridStyles.Items.AddChild(ParentStyle, S);
    NewStyle.ColumnText.Add('');
    NewStyle.Expanded := true;
    NewStyle.Focused := true;
    gridStyles.EnsureVisibleBottom(NewStyle);
  end
  else
  begin
    ElMessageDlg('Failed to add new style. Please try another name or contact ElPack support.', mtError, [mbOk], 0);
  end;
end;

procedure TStyleManEditDialog.UpdateButtons;
begin
  btnAddProp.Enabled := (gridProps.ItemFocused <> nil) and
    (gridStyles.ItemFocused <> nil);
  btnDelete.Enabled := gridStyles.ItemFocused <> nil;
end;

procedure TStyleManEditDialog.inpEditImageBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  P: Pointer;
  i: integer;
begin
  inpEditImage.Editor.ButtonVisible := true;
  inpEditImage.Editor.AltButtonVisible := false;
  inpEditImage.Editor.ReadOnly := true;
  ImageStream := TMemoryStream.Create;

  i := -1;
  THackManager(FStyleManager).FStyles.ReadBinary('\' +
    inpEditImage.Item.Parent.Text, inpEditImage.Item.Text, p, i);
  if i > 0 then
  begin
    GetMem(P, i);
    THackManager(FStyleManager).FStyles.ReadBinary('\' +
      inpEditImage.Item.Parent.Text, inpEditImage.Item.Text, PChar(p)^, i);
    if i > 0 then
      ImageStream.WriteBuffer(pchar(p)^, i);
    ImageStream.Position := 0;
    FreeMem(p);
  end;
end;

procedure TStyleManEditDialog.ImageButtonClick(Sender: TObject);
var
  AClass: TClass;
  IT: TImageType;
begin
  AClass := FindClass(TElPropListItem(inpEditImage.Item.AnObject).AClassName);
  if AClass = TIcon then
    it := itIcon
  else
    it := itBitmap;

  with TStyleImageSelectForm.Create(nil) do
  try
    if ImageStream.Size > 0 then
    begin
      ImageStream.Position := 0;
      LoadFromStream(ImageStream, IT);
    end;

    if ShowModal = mrOk then
    begin
      ImageStream.Size := 0;
      SaveToStream(ImageStream, IT);
      if ImageStream.Size > 0 then
        inpEditImage.Editor.Text := '(' +
          TElPropListItem(inpEditImage.Item.AnObject).TypeName + ')'
      else
        inpEditImage.Editor.Text := '(none)';
    end;
  finally
    Free;
  end;
end;

procedure TStyleManEditDialog.inpEditImageAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
var
  P: Pointer;
  i: integer;
begin
  if Accepted then
  begin
    DefaultConversion := false;

    p := ImageStream.Memory;
    i := ImageStream.Size;
    THackManager(FStyleManager).FStyles.WriteBinary('\' +
      inpEditImage.Item.Parent.Text, inpEditImage.Item.Text, PChar(p)^, i);
    inpEditImage.ValueAsText := GetDisplayValue(inpEditImage.Item.Parent.Text,
      TElPropListItem(inpEditImage.Item.AnObject));
  end;
end;

procedure TStyleManEditDialog.gridStylesCompareItems(Sender: TObject;
  Item1, Item2: TElTreeItem; var res: Integer);
begin
  if (Item1.AnObject <> nil) = (Item2.AnObject <> nil) then
  begin
    res := AnsiCompareText(Item1.Text, Item2.Text);
  end
  else
  if Item1.AnObject = nil then
    res := -1
  else
  if Item2.AnObject = nil then
    res := 1;
end;

initialization

  PropList := TElPropListCollection.Create;

finalization

  FreeAndNil(PropList);

end.
