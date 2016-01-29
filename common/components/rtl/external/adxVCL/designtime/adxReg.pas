{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit adxReg;

{$I adxDefs.inc}

interface

uses Windows, SysUtils, Classes, Menus, ComCtrls, ActnList,
  Forms, Controls, ExtCtrls, StdCtrls, Grids, Registry, ToolsAPI,
  {$IFNDEF ADX_VCL14} ExptIntf, {$ENDIF}
  {$IFDEF ADX_VCL5}
  DsgnIntf, MaskProp,
  {$ELSE}
  Variants,
  DesignIntf,
  DesignEditors,
  {$ENDIF}
  adxAddIn, adxRTDServ, adxSmartTag, adxMSFormsControls, adxHostAppEvents, ColnEdit, Dialogs;

type
  TRTDTopicStringsDialog = class(TForm)
    panDesktop: TPanel;
    panButtons: TPanel;
    sgTopics: TStringGrid;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgTopicsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FList: TStringList;
    FRegKey: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitForm;
  end;

  TadxTopicsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TadxControlsEditor = class(TCollectionEditor)
  private
    FPopupMenu: TPopupMenu;
    FAddedItemIDList: TList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure DoNothing(Sender: TObject);
    procedure DoAddControl(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
  end;

  TadxCollectionProperty = class(TCollectionProperty)
  public
    //function GetEditorClass: TCollectionEditorClass; override;
    // version 3.6
    procedure Edit; override;
  end;

  // version 3.6
  TadxCollectionDummyProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

  TadxCommandBarEditor = class(TDefaultEditor)
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TadxModuleEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TadxSmartTagsEditor = class(TDefaultEditor)
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TadxLocaleProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetList(Source: TPersistent; const PropName: string): TStringList;
  end;

  TadxMSFormsControlNameProperty = class(TStringProperty)
  public
    function AutoFill: boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TadxFileNameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TadxPropertyIDProperty = class(TStringProperty)
  private
    FList: TStrings;
  public
    {$IFDEF ADX_VCL5}
    constructor Create(const ADesigner: IFormDesigner; APropCount: Integer); override;
    {$ELSE}
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    {$ENDIF}
    destructor Destroy; override;
    function AutoFill: boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TadxPropertyValueProperty = class(TStringProperty)
  public
    procedure SetValue(const Value: string); override;
  end;

  TadxWorkSheetProperty = class(TStringProperty)
  public
    function AutoFill: boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TadxShortCutProperty = class(TStringProperty)
  public
    function AutoFill: boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TadxRibbonTabEditor = class(TDefaultEditor)
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TadxRibbonGroupControlsEditor = class(TCollectionEditor)
  private
    FPopupMenu: TPopupMenu;
    FAddedItemIDList: TList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure DoNothing(Sender: TObject);
    procedure DoAddControl(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
  end;

  TadxRibbonGroupControlsProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxRibbonButtonGroupControlsEditor = class(TadxRibbonGroupControlsEditor)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TadxRibbonButtonGroupControlsProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxRibbonMenuControlsEditor = class(TadxRibbonGroupControlsEditor)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TadxRibbonMenuControlsProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxRibbonSplitButtonControlsProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
    function GetColOptions: TColOptions; override;
  end;

  TadxRibbonOfficeMenuControlsEditor = class(TadxRibbonGroupControlsEditor)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TadxRibbonOfficeMenuControlsProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxRibbonBoxControlsEditor = class(TadxRibbonGroupControlsEditor)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TadxRibbonBoxControlsProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxRibbonControlsProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

  TadxRibbonDummyControlsProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

  TadxRibbonTabContextProperty = class(TStringProperty)
  public
    function AutoFill: boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TadxCTPProgIDProperty = class(TStringProperty)
  public
    function AutoFill: boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TadxMainMenuNameProperty = class(TStringProperty)
  public
    function AutoFill: boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TadxContextMenuNameProperty = class(TStringProperty)
  public
    function AutoFill: boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TadxOLSolutionModuleEditor = class(TDefaultEditor)
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TadxOLSolutionFoldersProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

  TadxRibbonContextMenuContextMenuNamesProperty = class(TClassProperty)
  private
    function GetContextMenuNames(): TStringList;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TadxBackstageEditor = class(TDefaultEditor)
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TadxBackstageControlsProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

  TadxBackstageDummyControlsProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

procedure Register;

implementation

{$R *.dfm}

{$IFDEF DELPHI_9_UP}
{$R adxReg2006.res}
{$ELSE}
{$R adxReg.res}
{$ENDIF}

uses adxAbout, adxLocaleEdit, ActiveX, Office2000, Excel2000, Word2000, MSPpt2000,
  adxRibbonEdit, adxCommandBarEdit, adxContextMenuEdit, adxSolutionModuleEdit,
  adxRibbonContextMenuNamesEdit, adxBackstageEdit;

var
  SetFromList: boolean = False;

{ TRTDTopicStrings }

constructor TRTDTopicStringsDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList := TStringList.Create;
end;

destructor TRTDTopicStringsDialog.Destroy;
begin
  FreeAndNil(FList);
  inherited Destroy;
end;

procedure TRTDTopicStringsDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with TRegIniFile.Create(FRegKey) do
  try
    EraseSection(Self.ClassName);
    WriteInteger(Self.ClassName, 'Width', Width);
    WriteInteger(Self.ClassName, 'Height', Height);
    WriteInteger(Self.ClassName, 'Left', Left);
    WriteInteger(Self.ClassName, 'Top', Top);
    WriteInteger(Self.ClassName, 'Column0', sgTopics.ColWidths[0]);
    WriteInteger(Self.ClassName, 'Column1', sgTopics.ColWidths[1]);
  finally
    Free;
  end;
end;

procedure TRTDTopicStringsDialog.InitForm;
var
  i: Integer;
begin
  sgTopics.Cells[0, 0] := '  Name';
  sgTopics.Cells[1, 0] := 'Value';
  for i := 1 to 28 do sgTopics.Cells[0, i] := '  Topic ' + IntToStr(i);
  for i := 0 to FList.Count - 1 do sgTopics.Cells[1, i + 1] := FList[i];
  with TRegIniFile.Create(FRegKey) do
  try
    Width := ReadInteger(Self.ClassName, 'Width', Width);
    Height := ReadInteger(Self.ClassName, 'Height', Height);
    Left := ReadInteger(Self.ClassName, 'Left', Left);
    Top := ReadInteger(Self.ClassName, 'Top', Top);
    sgTopics.ColWidths[0] := ReadInteger(Self.ClassName, 'Column0', 95);
    sgTopics.ColWidths[1] := ReadInteger(Self.ClassName, 'Column1', 200);
  finally
    Free;
  end;
end;

procedure TRTDTopicStringsDialog.sgTopicsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Shift = []) and sgTopics.Focused then
    sgTopics.Cells[1, sgTopics.Row] := '';
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then btnOK.Click;
end;

procedure TRTDTopicStringsDialog.btnOKClick(Sender: TObject);
var
  i: Integer;
begin
  FList.Clear;
  for i := 1 to 28 do
    if sgTopics.Cells[1, i] <> '' then FList.Add(sgTopics.Cells[1, i]);
end;

{ TadxTopicsProperty }

function TadxTopicsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

procedure TadxTopicsProperty.Edit;
begin

  with TRTDTopicStringsDialog.Create(Application) do
  try
    if Assigned(GetComponent(0)) then
      Caption := GetComponent(0).GetNamePath + '.';
    Caption := Caption + GetName;
    FList.Assign(TStringList(GetOrdValue));
    {$IFDEF ADX_VCL5}
    FRegKey := '\Software\Borland\Delphi\5.0' + '\Property Editors\Collection Editor';
    {$ELSE}
    FRegKey := Self.Designer.GetBaseRegKey + '\Property Editors\Collection Editor';
    {$ENDIF}
    InitForm;
    if ShowModal = mrOk then SetOrdValue(Longint(FList));
  finally
    Free;
  end;
end;

{ TadxControlsEditor }

constructor TadxControlsEditor.Create(AOwner: TComponent);
const
  MenuCaption: array [TadxControlType] of string = ('Button', 'Edit',
    'DropdownList', 'ComboBox', 'Popup', 'Control', 'Advanced Control');
var
  i: TadxControlType;
  Item: TMenuItem;
begin
  inherited Create(AOwner);
  // add button
  FPopupMenu := TPopupMenu.Create(Self);
  FPopupMenu.Images := Self.ImageList1;
  for i := Low(TadxControlType) to High(TadxControlType) do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(i);
    Item.OnClick := DoAddControl;
    if i = adxButton then Item.Default := True;
    FPopupMenu.Items.Add(Item);
  end;
  ToolButton1.DropdownMenu := FPopupMenu;
  ToolButton1.Style := tbsDropDown;

  // Popup menu
  for i := Low(TadxControlType) to High(TadxControlType) do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(i);
    Item.OnClick := DoAddControl;
    if i = adxButton then Item.Default := True;
    PopupMenu1.Items[0].Add(Item);
  end;
  {$IFNDEF ADX_VCL7}
  PopupMenu1.Items[0].OnClick := nil;
  PopupMenu1.Items[0].Action := nil;
  {$ENDIF}
end;

destructor TadxControlsEditor.Destroy;
begin
  FPopupMenu.Free;
  if FAddedItemIDList <> nil then FreeAndNil(FAddedItemIDList);
  inherited Destroy;
end;

procedure TadxControlsEditor.Loaded;
begin
  inherited Loaded;
  // disable standard Add action
  AddCmd.ShortCut := 0;
  AddCmd.OnExecute := DoNothing;
  DeleteCmd.OnExecute := DeleteClick;
end;

procedure TadxControlsEditor.DoNothing(Sender: TObject);
begin
  // emulate default item
  if Sender is TAction then DoAddControl(FPopupMenu.Items[0]);
end;

procedure TadxControlsEditor.DoAddControl(Sender: TObject);
var
  Item: TListItem;
  PrevCount: Integer;
begin
  SelectNone(False);
  Collection.BeginUpdate;
  try
    PrevCount := Collection.Count + 1;
    TadxCommandBarControls(Collection).Add(TadxControlType((Sender as TComponent).Tag));
    if PrevCount <> Collection.Count then
      UpdateListBox
    else
      ListView1.Selected := ListView1.Items.Add;
  finally
    Collection.EndUpdate;
  end;
  SetSelection;
  if csAncestor in Component.ComponentState then
  begin
    if FAddedItemIDList = nil then
      FAddedItemIDList := TList.Create;
    FAddedItemIDList.Add(Pointer(Collection.Items[Collection.Count - 1].ID));
  end;
  Designer.Modified;
  Item := ListView1.Items[ListView1.Items.Count-1];
  Item.Focused := True;
  Item.MakeVisible(False);
end;

procedure TadxControlsEditor.DeleteClick(Sender: TObject);
const
  SCantDeleteAncestor = 'Selection contains a component introduced in an ancestor form which cannot be deleted';
var
  I, J, K: Integer;
  Item: TCollectionItem;
  Found: Boolean;
begin
  Collection.BeginUpdate;
  try
    Designer.SetSelections(nil);
    if ListView1.Selected <> nil then
      J := ListView1.Selected.Index
    else J := -1;
    if (ListView1.SelCount = Collection.Count) and ((csAncestor in Component.ComponentState) = False) then
      Collection.Clear
    else if ListView1.SelCount > 0 then
      for I := ListView1.Items.Count - 1 downto 0 do
        if ListView1.Items[I].Selected then
        begin
          Found := False;
          if (FAddedItemIDList <> nil) and (FAddedItemIDList.Count > 0) then
          for K := 0 to FAddedItemIDList.Count -1 do
          begin
            Item := Collection.FindItemID(Integer(FAddedItemIDList[K]));
            if Item = Collection.Items[i] then
            begin
              FAddedItemIDList.Delete(K);
              Found := True;
              Break;
            end
            else Found := False;
          end;
          if (not Found) and (csAncestor in Component.ComponentState) then
            raise Exception.Create(SCantDeleteAncestor)
          else
            Collection.Items[I].Free;
        end;
  finally
    Collection.EndUpdate;
  end;
  UpdateListbox;
  if J >= ListView1.Items.Count then
    J := ListView1.Items.Count - 1;
  if (J > -1) and (J < ListView1.Items.Count) then
    ListView1.Selected := ListView1.Items[J];
  SetSelection;
  Designer.Modified;
end;

type
  TCollectionAccess = class(TCollection);
  TOwnedCollectionAccess = class(TOwnedCollection);
  TPersistentAccess = class(TPersistent);

{ TadxCollectionProperty }
{
function TadxCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxControlsEditor;
end;
}
procedure TadxCollectionProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := TPersistentAccess(Obj).GetOwner;
  if Obj is TadxContextMenu then
    ShowContextMenuEditor(Designer, TComponent(Obj), TOwnedCollection(GetOrdValue), GetName)
  else
    ShowCommandBarEditor(Designer, TComponent(Obj), TOwnedCollection(GetOrdValue), GetName);
end;

{ TadxCollectionDummyProperty }

type
  TadxCustomCommandBarAccess = class(TadxCustomCommandBar);

procedure TadxCollectionDummyProperty.Edit;
var
  Obj: TPersistent;
  AOwner: TPersistent;
begin
  Obj := GetComponent(0);
  if Obj is TadxCommandBarPopup then begin
    AOwner := TCollectionAccess(TadxCommandBarPopup(Obj).Collection).GetOwner;
    (*
    while (AOwner <> nil) and not (AOwner is TadxCommandBar) do
    *)
    while (AOwner <> nil) and not (AOwner is TadxCustomCommandBar) do
      AOwner := TCollectionAccess(TadxCommandBarPopup(AOwner).Collection).GetOwner;
    if AOwner <> nil then
      (*
      if AOwner is TadxCommandBar then
        ShowCommandBarEditor(Designer, TadxCommandBar(AOwner), TadxCommandBar(AOwner).Controls, 'Controls');
      *)
      if AOwner is TadxCustomCommandBar then
        ShowCommandBarEditor(Designer, TadxCustomCommandBar(AOwner), TadxCustomCommandBarAccess(AOwner).Controls, 'Controls');
  end;
end;

{ TadxCommandBarEditor }

{$IFDEF ADX_VCL5}
procedure TadxCommandBarEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxCommandBarEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'CONTROLS') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;

procedure TadxCommandBarEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

function TadxCommandBarEditor.GetVerb(Index: Integer): string;
begin
  Result := '&Controls...';
end;

function TadxCommandBarEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TadxModuleEditor }

procedure TadxModuleEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then begin
    frmAbout := TfrmAbout.Create(nil);
    try
      frmAbout.ShowModal;
    finally
      FreeAndNil(frmAbout);
    end;
  end;
end;

function TadxModuleEditor.GetVerb(Index: Integer): string;
begin
  Result := 'About...';
end;

function TadxModuleEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TadxSmartTagsEditor }

{$IFDEF ADX_VCL5}
procedure TadxSmartTagsEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxSmartTagsEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'ACTIONS') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;

procedure TadxSmartTagsEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

function TadxSmartTagsEditor.GetVerb(Index: Integer): string;
begin
  Result := '&Smart Tag Actions...';
end;

function TadxSmartTagsEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TadxLocaleProperty }

procedure TadxLocaleProperty.Edit;
var
  PropName: string;
begin
  PropName := GetName;
  adxLocaleEditor := TadxLocaleEditor.Create(GetList(GetComponent(0), PropName));
  try
    if PropName = 'SmartTagName' then
      adxLocaleEditor.Caption := Format(adxLocaleEditor.Caption, ['Smart Tag Name'])
    else
      if PropName = 'SmartTagDesc' then
        adxLocaleEditor.Caption := Format(adxLocaleEditor.Caption, ['Smart Tag Description'])
      else
        adxLocaleEditor.Caption := Format(adxLocaleEditor.Caption, ['Caption']);
    if adxLocaleEditor.ShowModal = mrOK then Designer.Modified;
  finally
    adxLocaleEditor.Free;
  end;
end;

function TadxLocaleProperty.GetList(Source: TPersistent; const PropName: string): TStringList;
begin
  Result := GetStrings(Source, PropName);
end;

function TadxLocaleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ COM routine }

function GetActiveOleObject2(const ClassName: string): IDispatch;
var
  ClassID: TCLSID;
  IUnk: IUnknown;
begin
  CLSIDFromProgID(PWideChar(WideString(ClassName)), ClassID);
  GetActiveObject(ClassID, nil, IUnk);
  if Assigned(IUnk) then
    IUnk.QueryInterface(IDispatch, Result);
end;

function CreateOleObject2(const ClassName: string): IDispatch;
var
  ClassID: TCLSID;
begin
  CLSIDFromProgID(PWideChar(WideString(ClassName)), ClassID);
  CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER, IDispatch, Result);
end;

{ Scan }

procedure ScanExcelSheet(Proc: TGetStrProc; const DocumentName, WorkSheet, CtrlProgID: string);
var
  i, j: Integer;
  NeedClose: boolean;
  IExcel: Excel2000._Application;
  IWorkbook: ExcelWorkbook;
  ISheet: ExcelWorksheet;
begin
  if (DocumentName <> '') and (WorkSheet <> '') and FileExists(DocumentName) then begin
    NeedClose := False;
    IExcel := GetActiveOleObject2('Excel.Application') as Excel2000._Application;
    if not Assigned(IExcel) then begin
      IExcel := CreateOleObject2('Excel.Application') as Excel2000._Application;
      NeedClose := True;
    end;
    if Assigned(IExcel) then
      try
        if not NeedClose then
          try
            for i := 1 to IExcel.Workbooks.Count do
              if LowerCase(IExcel.Workbooks.Item[i].FullName[adxLCID]) = LowerCase(DocumentName) then begin
                IWorkbook := IExcel.Workbooks.Item[i];
                Break;
              end;
          except
            IWorkbook := nil;
          end;
        if IWorkbook = nil then
          IWorkbook := IExcel.Workbooks.Open(DocumentName, EmptyParam, EmptyParam,
            EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
            EmptyParam, EmptyParam, EmptyParam, EmptyParam, adxLCID);
        if Assigned(IWorkbook) then
          try
            for i := 1 to IWorkbook.Worksheets.Count do begin
              IWorkbook.Worksheets.Item[i].QueryInterface(IID__Worksheet, ISheet);
              if Assigned(ISheet) then
                try
                  if ISheet.Name = WorkSheet then begin
                    for j := 1 to ISheet.Shapes.Count do
                      {$IFDEF UNICODE}
                      if Pos(WideString(CtrlProgID), ISheet.Shapes.Item(j).OLEFormat.ProgId) > 0 then
                        Proc(OleVariant(ISheet.Shapes.Item(j).OLEFormat.Object_).Name);
                      {$ELSE}
                      if Pos(CtrlProgID, ISheet.Shapes.Item(j).OLEFormat.ProgId) > 0 then
                        Proc(OleVariant(ISheet.Shapes.Item(j).OLEFormat.Object_).Name);
                      {$ENDIF}
                    Break;
                  end;
                finally
                  ISheet := nil;
                end;
            end;
          finally
            IWorkbook := nil;
          end;
      finally
        if NeedClose then IExcel.Quit;
        IExcel := nil;
      end;
  end;
end;

procedure ScanWordDocument(Proc: TGetStrProc; const DocumentName, CtrlProgID: string);
var
  i: Integer;
  Index: OleVariant;
  NeedClose: boolean;
  IWord: Word2000._Application;
  IDocument: WordDocument;
  IShape: InlineShape;
begin
  if (DocumentName <> '') and FileExists(DocumentName) then begin
    NeedClose := False;
    IWord := GetActiveOleObject2('Word.Application') as Word2000._Application;
    if not Assigned(IWord) then begin
      IWord := CreateOleObject2('Word.Application') as Word2000._Application;
      NeedClose := True;
    end;
    if Assigned(IWord) then
      try
        if not NeedClose then
          try
            for i := 1 to IWord.Documents.Count do begin
              Index := i;
              if LowerCase(IWord.Documents.Item(Index).FullName) = LowerCase(DocumentName) then begin
                IDocument := IWord.Documents.Item(Index);
                Break;
              end;
            end;
          except
            IDocument := nil;
          end;
        if IDocument = nil then begin
          Index := DocumentName;
          IDocument := IWord.Documents.Open(Index, EmptyParam,
            EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
            EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
        end;
        if Assigned(IDocument) then
          try
            for i := 1 to IDocument.InlineShapes.Count do begin
              IShape := IDocument.InlineShapes.Item(i);
              try
                if Assigned(IShape.OLEFormat) then
                  {$IFDEF UNICODE}
                  if Pos(WideString(CtrlProgID), IShape.OLEFormat.ProgId) > 0 then
                    Proc(OleVariant(IShape.OLEFormat.Object_).Name);
                  {$ELSE}
                  if Pos(CtrlProgID, IShape.OLEFormat.ProgId) > 0 then
                    Proc(OleVariant(IShape.OLEFormat.Object_).Name);
                  {$ENDIF}
              finally
                IShape := nil;
              end;
            end;
          finally
            IDocument := nil;
          end;
      finally
        if NeedClose then IWord.Quit(EmptyParam, EmptyParam, EmptyParam);
        IWord := nil;
      end;
  end;
end;

procedure ScanPowerPointDocument(Proc: TGetStrProc; const DocumentName, CtrlProgID: string);
begin
  // TODO
end;

procedure CommonScanProperties(const IDsp: IDispatch; Proc: TGetStrProc;
  Values: TStrings);
var
  i, Count: Integer;
  IProps: OleVariant;
begin
  if Assigned(IDsp) then
    try
      IProps := IDsp;
      Count := IProps.Count;
      for i := 1 to Count do
        if IProps.Item[i].Type = msoPropertyTypeString then begin
          Proc(IProps.Item[i].Name);
          Values.Add(IProps.Item[i].Name + '=' + IProps.Item[i].Value);
        end;
    finally
      IProps := Unassigned;
    end;
end;

procedure ScanExcelProperties(const DocumentName: string; Proc: TGetStrProc;
  Values: TStrings);
var
  i: Integer;
  NeedClose: boolean;
  IExcel: Excel2000._Application;
  IWorkbook: ExcelWorkbook;
begin
  NeedClose := False;
  IExcel := GetActiveOleObject2('Excel.Application') as Excel2000._Application;
  if not Assigned(IExcel) then begin
    IExcel := CreateOleObject2('Excel.Application') as Excel2000._Application;
    NeedClose := True;
  end;
  if Assigned(IExcel) then
    try
      if not NeedClose then
        try
          for i := 1 to IExcel.Workbooks.Count do
            if LowerCase(IExcel.Workbooks.Item[i].FullName[adxLCID]) = LowerCase(DocumentName) then begin
              IWorkbook := IExcel.Workbooks.Item[i];
              Break;
            end;
        except
          IWorkbook := nil;
        end;
      if IWorkbook = nil then
        IWorkbook := IExcel.Workbooks.Open(DocumentName, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, adxLCID);
      if Assigned(IWorkbook) then
        try
          CommonScanProperties(IWorkbook.CustomDocumentProperties, Proc, Values);
        finally
          IWorkbook := nil;
        end;
    finally
      if NeedClose then IExcel.Quit;
      IExcel := nil;
    end;
end;

procedure ScanWordProperties(const DocumentName: string; Proc: TGetStrProc;
  Values: TStrings);
var
  i: Integer;
  Index: OleVariant;
  NeedClose: boolean;
  IWord: Word2000._Application;
  IDocument: WordDocument;
begin
  NeedClose := False;
  IWord := GetActiveOleObject2('Word.Application') as Word2000._Application;
  if not Assigned(IWord) then begin
    IWord := CreateOleObject2('Word.Application') as Word2000._Application;
    NeedClose := True;
  end;
  if Assigned(IWord) then
    try
      if not NeedClose then
        try
          for i := 1 to IWord.Documents.Count do begin
            Index := i;
            if LowerCase(IWord.Documents.Item(Index).FullName) = LowerCase(DocumentName) then begin
              IDocument := IWord.Documents.Item(Index);
              Break;
            end;
          end;
        except
          IDocument := nil;
        end;
      if IDocument = nil then begin
        Index := DocumentName;
        IDocument := IWord.Documents.Open(Index, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
      end;
      if Assigned(IDocument) then
        try
          CommonScanProperties(IDocument.CustomDocumentProperties, Proc, Values);
        finally
          IDocument := nil;
        end;
    finally
      if NeedClose then IWord.Quit(EmptyParam, EmptyParam, EmptyParam);
      IWord := nil;
    end;
end;

procedure ScanPowerPointProperties(const DocumentName: string; Proc: TGetStrProc;
  Values: TStrings);
begin
  // TODO
end;

procedure CommonSetPropertyName(const IDsp: IDispatch; const OldPropertyName, NewName: string);
var
  i, Count: Integer;
  IProps: OleVariant;
  Found: boolean;
begin
  if Assigned(IDsp) then
    try
      Found := False;
      IProps := IDsp;
      if OldPropertyName = '' then
        IProps.Add(NewName, False, msoPropertyTypeString, '')
      else begin
        Count := IProps.Count;
        for i := 1 to Count do
          if IProps.Item[i].Name = OldPropertyName then begin
            Found := True;
            if NewName = '' then IProps.Item[i].Delete
            else IProps.Item[i].Name := NewName;
            Break;
          end;
        if not Found then
          IProps.Add(NewName, False, msoPropertyTypeString, '');
      end;
    finally
      IProps := Unassigned;
    end;
end;

procedure SetExcelPropertyName(const DocumentName, OldPropertyName, NewName: string);
var
  i: Integer;
  NeedClose: boolean;
  IExcel: Excel2000._Application;
  IWorkbook: ExcelWorkbook;
begin
  NeedClose := False;
  IExcel := GetActiveOleObject2('Excel.Application') as Excel2000._Application;
  if not Assigned(IExcel) then begin
    IExcel := CreateOleObject2('Excel.Application') as Excel2000._Application;
    NeedClose := True;
  end;
  if Assigned(IExcel) then
    try
      if not NeedClose then
        try
          for i := 1 to IExcel.Workbooks.Count do
            if LowerCase(IExcel.Workbooks.Item[i].FullName[adxLCID]) = LowerCase(DocumentName) then begin
              IWorkbook := IExcel.Workbooks.Item[i];
              Break;
            end;
        except
          IWorkbook := nil;
        end;
      if IWorkbook = nil then
        IWorkbook := IExcel.Workbooks.Open(DocumentName, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, adxLCID);
      if Assigned(IWorkbook) then
        try
          CommonSetPropertyName(IWorkbook.CustomDocumentProperties, OldPropertyName, NewName);
          IWorkbook.Save(adxLCID);
        finally
          IWorkbook := nil;
        end;
    finally
      if NeedClose then IExcel.Quit;
      IExcel := nil;
    end;
end;

procedure SetWordPropertyName(const DocumentName, OldPropertyName, NewName: string);
var
  i: Integer;
  Index: OleVariant;
  NeedClose: boolean;
  IWord: Word2000._Application;
  IDocument: WordDocument;
begin
  NeedClose := False;
  IWord := GetActiveOleObject2('Word.Application') as Word2000._Application;
  if not Assigned(IWord) then begin
    IWord := CreateOleObject2('Word.Application') as Word2000._Application;
    NeedClose := True;
  end;
  if Assigned(IWord) then
    try
      if not NeedClose then
        try
          for i := 1 to IWord.Documents.Count do begin
            Index := i;
            if LowerCase(IWord.Documents.Item(Index).FullName) = LowerCase(DocumentName) then begin
              IDocument := IWord.Documents.Item(Index);
              Break;
            end;
          end;
        except
          IDocument := nil;
        end;
      if IDocument = nil then begin
        Index := DocumentName;
        IDocument := IWord.Documents.Open(Index, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
      end;
      if Assigned(IDocument) then
        try
          CommonSetPropertyName(IDocument.CustomDocumentProperties, OldPropertyName, NewName);
          IDocument.Saved := False;
          IDocument.Save;
        finally
          IDocument := nil;
        end;
    finally
      if NeedClose then IWord.Quit(EmptyParam, EmptyParam, EmptyParam);
      IWord := nil;
    end;
end;

procedure SetPowerPointPropertyName(const DocumentName, OldPropertyName, NewName: string);
begin
  // TODO
end;

procedure CommonSetPropertyValue(const IDsp: IDispatch; const PropertyName, Value: string);
var
  i, Count: Integer;
  IProps: OleVariant;
  Found: boolean;
begin
  if Assigned(IDsp) then
    try
      Found := False;
      IProps := IDsp;
      Count := IProps.Count;
      for i := 1 to Count do
        if IProps.Item[i].Name = PropertyName then begin
          Found := True;
          IProps.Item[i].Value := Value;
          Break;
        end;
      if not Found then
        IProps.Add(PropertyName, False, msoPropertyTypeString, Value);
    finally
      IProps := Unassigned;
    end;
end;

procedure SetExcelPropertyValue(const DocumentName, PropertyName, Value: string);
var
  i: Integer;
  NeedClose: boolean;
  IExcel: Excel2000._Application;
  IWorkbook: ExcelWorkbook;
begin
  NeedClose := False;
  IExcel := GetActiveOleObject2('Excel.Application') as Excel2000._Application;
  if not Assigned(IExcel) then begin
    IExcel := CreateOleObject2('Excel.Application') as Excel2000._Application;
    NeedClose := True;
  end;
  if Assigned(IExcel) then
    try
      if not NeedClose then
        try
          for i := 1 to IExcel.Workbooks.Count do
            if LowerCase(IExcel.Workbooks.Item[i].FullName[adxLCID]) = LowerCase(DocumentName) then begin
              IWorkbook := IExcel.Workbooks.Item[i];
              Break;
            end;
        except
          IWorkbook := nil;
        end;
      if IWorkbook = nil then
        IWorkbook := IExcel.Workbooks.Open(DocumentName, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, adxLCID);
      if Assigned(IWorkbook) then
        try
          CommonSetPropertyValue(IWorkbook.CustomDocumentProperties, PropertyName, Value);
          IWorkbook.Save(adxLCID);
        finally
          IWorkbook := nil;
        end;
    finally
      if NeedClose then IExcel.Quit;
      IExcel := nil;
    end;
end;

procedure SetWordPropertyValue(const DocumentName, PropertyName, Value: string);
var
  i: Integer;
  Index: OleVariant;
  NeedClose: boolean;
  IWord: Word2000._Application;
  IDocument: WordDocument;
begin
  NeedClose := False;
  IWord := GetActiveOleObject2('Word.Application') as Word2000._Application;
  if not Assigned(IWord) then begin
    IWord := CreateOleObject2('Word.Application') as Word2000._Application;
    NeedClose := True;
  end;
  if Assigned(IWord) then
    try
      if not NeedClose then
        try
          for i := 1 to IWord.Documents.Count do begin
            Index := i;
            if LowerCase(IWord.Documents.Item(Index).FullName) = LowerCase(DocumentName) then begin
              IDocument := IWord.Documents.Item(Index);
              Break;
            end;
          end;
        except
          IDocument := nil;
        end;
      if IDocument = nil then begin
        Index := DocumentName;
        IDocument := IWord.Documents.Open(Index, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
          EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
      end;
      if Assigned(IDocument) then
        try
          CommonSetPropertyValue(IDocument.CustomDocumentProperties, PropertyName, Value);
          IDocument.Saved := False;
          IDocument.Save;
        finally
          IDocument := nil;
        end;
    finally
      if NeedClose then IWord.Quit(EmptyParam, EmptyParam, EmptyParam);
      IWord := nil;
    end;
end;

procedure SetPowerPointPropertyValue(const DocumentName, PropertyName, Value: string);
begin
  // TODO
end;

{ TadxMSFormsControlNameProperty }

function TadxMSFormsControlNameProperty.AutoFill: boolean;
begin
  Result := False;
end;

type
  TadxMSFormsControlAccess = class(TadxMSFormsControl);

procedure TadxMSFormsControlNameProperty.GetValues(Proc: TGetStrProc);
var
  Control: TadxMSFormsControl;
  DocumentName, PropertyID, PropertyValue, WorkSheet, CtrlProgID: string;
begin
  Control := TadxMSFormsControl(GetComponent(0));
  CtrlProgID := TadxMSFormsControlAccess(Control).GetVersionIndependentProgID;
  DocumentName := TadxCustomDocumentModule(Control.Owner).Document;
  if ExtractFileDir(DocumentName) = '' then
    DocumentName :=
      {$IFDEF DELPHI_9_UP}
      ExtractFileDir((BorlandIDEServices as IOTAProject).FileName)
      {$ELSE}
      ExtractFileDir(ToolServices.GetProjectName)
      {$ENDIF} + '\' + DocumentName;
  PropertyID := TadxCustomDocumentModule(Control.Owner).PropertyID;
  PropertyValue := TadxCustomDocumentModule(Control.Owner).PropertyValue;
  if Control.Owner is TadxExcelSheetModule then begin
    WorkSheet := TadxExcelSheetModule(Control.Owner).WorkSheet;
    ScanExcelSheet(Proc, DocumentName, WorkSheet, CtrlProgID);
  end
  else
    if Control.Owner is TadxWordDocumentModule then
      ScanWordDocument(Proc, DocumentName, CtrlProgID)
    else
      ScanPowerPointDocument(Proc, DocumentName, CtrlProgID);
end;

function TadxMSFormsControlNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{ TadxFileNameProperty }

procedure TadxFileNameProperty.Edit;
begin
  with TOpenDialog.Create(nil) do
  try
    Title := 'Open';
    if GetComponent(0) is TadxExcelSheetModule then begin
      DefaultExt := 'xls';
      Filter := 'Microsoft Excel files (*.xls)|*.XLS;*.XLT';
    end
    else if GetComponent(0) is TadxWordDocumentModule then begin
      DefaultExt := 'doc';
      Filter := 'Microsoft Word files (*.doc)|*.DOC;*.DOT';
    end
    ;
    {else if GetComponent(0) is TadxPowerPointPresentationModule then begin
      DefaultExt := 'ppt';
      Filter := 'Microsoft PowerPoint files (*.ppt)|*.PPT';
    end;
    }
    if Execute then SetValue(FileName);
  finally
    Free;
  end;
end;

function TadxFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ TadxPropertyIDProperty }

{$IFDEF ADX_VCL5}
constructor TadxPropertyIDProperty.Create(const ADesigner: IFormDesigner; APropCount: Integer);
{$ELSE}
constructor TadxPropertyIDProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
{$ENDIF}
begin
  inherited Create(ADesigner, APropCount);
  FList := TStringList.Create;
end;

destructor TadxPropertyIDProperty.Destroy;
begin
  if Assigned(FList) then FreeAndNil(FList);
  inherited Destroy;
end;

function TadxPropertyIDProperty.AutoFill: boolean;
begin
  Result := False;
end;

procedure TadxPropertyIDProperty.GetValues(Proc: TGetStrProc);
var
  DocumentName: string;
begin
  FList.Clear;
  DocumentName := TadxCustomDocumentModule(GetComponent(0)).Document;
  if ExtractFileDir(DocumentName) = '' then
    DocumentName :=
      {$IFDEF DELPHI_9_UP}
      ExtractFileDir((BorlandIDEServices as IOTAProject).FileName)
      {$ELSE}
      ExtractFileDir(ToolServices.GetProjectName)
      {$ENDIF} + '\' + DocumentName;
  if (DocumentName <> '') and FileExists(DocumentName) then begin
    if GetComponent(0) is TadxExcelSheetModule then
      ScanExcelProperties(DocumentName, Proc, FList)
    else
      if GetComponent(0) is TadxWordDocumentModule then
        ScanWordProperties(DocumentName, Proc, FList)
      else
        ScanPowerPointProperties(DocumentName, Proc, FList);
  end;
end;

procedure TadxPropertyIDProperty.SetValue(const Value: string);
var
  Index: Integer;
  DocumentName: string;
  OldPropertyIDValue: string;
  PropertyValueFromList: string;
begin
  DocumentName := TadxCustomDocumentModule(GetComponent(0)).Document;
  if ExtractFileDir(DocumentName) = '' then
    DocumentName :=
      {$IFDEF DELPHI_9_UP}
      ExtractFileDir((BorlandIDEServices as IOTAProject).FileName)
      {$ELSE}
      ExtractFileDir(ToolServices.GetProjectName)
      {$ENDIF} + '\' + DocumentName;
  if (DocumentName = '') or not FileExists(DocumentName) then Exit;
  OldPropertyIDValue := Self.GetValue;
  inherited SetValue(Value);
  PropertyValueFromList := '';
  if FList.Count > 0 then begin
    Index := FList.IndexOfName(Value);
    if Index >= 0 then
      PropertyValueFromList := FList.Values[Value];
  end;
  FList.Clear;
  if PropertyValueFromList <> '' then begin
    SetFromList := True;
    try
      TadxCustomDocumentModule(GetComponent(0)).PropertyValue := PropertyValueFromList;
    finally
      SetFromList := False;
    end;
  end
  else begin
    if GetComponent(0) is TadxExcelSheetModule then
      SetExcelPropertyName(DocumentName, OldPropertyIDValue, Value)
    else
      if GetComponent(0) is TadxWordDocumentModule then
        SetWordPropertyName(DocumentName, OldPropertyIDValue, Value)
      else
        SetPowerPointPropertyName(DocumentName, OldPropertyIDValue, Value);
    if Value = '' then begin
      SetFromList := True;
      try
        TadxCustomDocumentModule(GetComponent(0)).PropertyValue := '';
      finally
        SetFromList := False;
      end;
    end;
  end;
end;

function TadxPropertyIDProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{ TadxPropertyValueProperty }

procedure TadxPropertyValueProperty.SetValue(const Value: string);
var
  DocumentName: string;
  PropertyName: string;
begin
  PropertyName := TadxCustomDocumentModule(GetComponent(0)).PropertyID;
  DocumentName := TadxCustomDocumentModule(GetComponent(0)).Document;
  if ExtractFileDir(DocumentName) = '' then
    DocumentName :=
      {$IFDEF DELPHI_9_UP}
      ExtractFileDir((BorlandIDEServices as IOTAProject).FileName)
      {$ELSE}
      ExtractFileDir(ToolServices.GetProjectName)
      {$ENDIF} + '\' + DocumentName;
  if (PropertyName = '') or (DocumentName = '') or not FileExists(DocumentName) then Exit;
  inherited SetValue(Value);
  if not SetFromList then begin
    if GetComponent(0) is TadxExcelSheetModule then
      SetExcelPropertyValue(DocumentName, PropertyName, Value)
    else
      if GetComponent(0) is TadxWordDocumentModule then
        SetWordPropertyValue(DocumentName, PropertyName, Value)
      else
        SetPowerPointPropertyValue(DocumentName, PropertyName, Value);
  end;
end;

{ TadxWorkSheetProperty }

function TadxWorkSheetProperty.AutoFill: boolean;
begin
  Result := False;
end;

procedure TadxWorkSheetProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  FileName: string;
  NeedClose: boolean;
  IExcel: Excel2000._Application;
  IWorkbook: ExcelWorkbook;
  ISheet: ExcelWorksheet;
begin
  FileName := TadxCustomDocumentModule(GetComponent(0)).Document;
  if ExtractFileDir(FileName) = '' then
    FileName :=
      {$IFDEF DELPHI_9_UP}
      ExtractFileDir((BorlandIDEServices as IOTAProject).FileName)
      {$ELSE}
      ExtractFileDir(ToolServices.GetProjectName)
      {$ENDIF} + '\' + FileName;
  if (FileName <> '') and FileExists(FileName) then begin
    NeedClose := False;
    IExcel := GetActiveOleObject2('Excel.Application') as Excel2000._Application;
    if not Assigned(IExcel) then begin
      IExcel := CreateOleObject2('Excel.Application') as Excel2000._Application;
      NeedClose := True;
    end;
    if Assigned(IExcel) then
      try
        if not NeedClose then
          try
            for i := 1 to IExcel.Workbooks.Count do
              if IExcel.Workbooks.Item[i].FullName[adxLCID] = FileName then begin
                IWorkbook := IExcel.Workbooks.Item[i];
                Break;
              end;
          except
            IWorkbook := nil;
          end;
        if IWorkbook = nil then
          IWorkbook := IExcel.Workbooks.Open(FileName, EmptyParam, EmptyParam,
            EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
            EmptyParam, EmptyParam, EmptyParam, EmptyParam, adxLCID);
        if Assigned(IWorkbook) then
          try
            for i := 1 to IWorkbook.Worksheets.Count do begin
              IWorkbook.Worksheets.Item[i].QueryInterface(IID__Worksheet, ISheet);
              if Assigned(ISheet) then
                try
                  Proc(ISheet.Name);
                finally
                  ISheet := nil;
                end;
            end;
          finally
            IWorkbook := nil;
          end;
      finally
        if NeedClose then IExcel.Quit;
        IExcel := nil;
      end;
  end;
end;

function TadxWorkSheetProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{ TadxShortCutProperty }

function TadxShortCutProperty.AutoFill: boolean;
begin
  Result := True;
end;

function TadxShortCutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TadxShortCutProperty.GetValues(Proc: TGetStrProc);
const
  ShortCuts: array[0..87] of string = (
    'Ctrl+A', 'Ctrl+B', 'Ctrl+C', 'Ctrl+D', 'Ctrl+E', 'Ctrl+F', 'Ctrl+G', 'Ctrl+H', 'Ctrl+I', 'Ctrl+J', 'Ctrl+K', 'Ctrl+L', 'Ctrl+M',
    'Ctrl+N', 'Ctrl+O', 'Ctrl+P', 'Ctrl+Q', 'Ctrl+R', 'Ctrl+S', 'Ctrl+T', 'Ctrl+U', 'Ctrl+V', 'Ctrl+W', 'Ctrl+X', 'Ctrl+Y', 'Ctrl+Z',
    'Ctrl+Shift+A', 'Ctrl+Shift+B', 'Ctrl+Shift+C', 'Ctrl+Shift+D', 'Ctrl+Shift+E', 'Ctrl+Shift+F', 'Ctrl+Shift+G', 'Ctrl+Shift+H', 'Ctrl+Shift+I', 'Ctrl+Shift+J', 'Ctrl+Shift+K', 'Ctrl+Shift+L', 'Ctrl+Shift+M',
    'Ctrl+Shift+N', 'Ctrl+Shift+O', 'Ctrl+Shift+P', 'Ctrl+Shift+Q', 'Ctrl+Shift+R', 'Ctrl+Shift+S', 'Ctrl+Shift+T', 'Ctrl+Shift+U', 'Ctrl+Shift+V', 'Ctrl+Shift+W', 'Ctrl+Shift+X', 'Ctrl+Shift+Y', 'Ctrl+Shift+Z',
    'Ctrl+F1', 'Ctrl+F2', 'Ctrl+F3', 'Ctrl+F4', 'Ctrl+F5', 'Ctrl+F6', 'Ctrl+F7', 'Ctrl+F8', 'Ctrl+F9', 'Ctrl+F10', 'Ctrl+F11', 'Ctrl+F12',
    'Shift+F1', 'Shift+F2', 'Shift+F3', 'Shift+F4', 'Shift+F5', 'Shift+F6', 'Shift+F7', 'Shift+F8', 'Shift+F9', 'Shift+F10', 'Shift+F11', 'Shift+F12',
    'Ctrl+Shift+F1', 'Ctrl+Shift+F2', 'Ctrl+Shift+F3', 'Ctrl+Shift+F4', 'Ctrl+Shift+F5', 'Ctrl+Shift+F6', 'Ctrl+Shift+F7', 'Ctrl+Shift+F8', 'Ctrl+Shift+F9', 'Ctrl+Shift+F10', 'Ctrl+Shift+F11', 'Ctrl+Shift+F12');
var
  i: Integer;
begin
  for i := 0 to High(ShortCuts) do Proc(ShortCuts[i]);
end;

{ TadxRibbonTabEditor }

{$IFDEF ADX_VCL5}
procedure TadxRibbonTabEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxRibbonTabEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'CONTROLS') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;

procedure TadxRibbonTabEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

function TadxRibbonTabEditor.GetVerb(Index: Integer): string;
begin
  Result := '&Controls...';
end;

function TadxRibbonTabEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TadxRibbonGroupControlsEditor }

constructor TadxRibbonGroupControlsEditor.Create(AOwner: TComponent);
const
  Count = 12;
  MenuCaption: array [0..Count] of string = (
    'Button', 'CheckBox', 'Label', 'Separator',
    'EditBox', 'ComboBox', 'DropDown', 'Gallery', 'Menu',
    'SplitButton', 'Box', 'ButtonGroup', 'DialogBoxLauncher');
  ItemTypes: array [0..Count] of TadxRibbonControlType = (
    rctButton, rctCheckBox, rctLabel, rctSeparator,
    rctEditBox, rctComboBox, rctDropDown, rctGallery, rctMenu,
    rctSplitButton, rctBox, rctButtonGroup, rctDialogBoxLauncher);
var
  i: Integer;
  Item: TMenuItem;
begin
  inherited Create(AOwner);
  // add button
  FPopupMenu := TPopupMenu.Create(Self);
  FPopupMenu.Images := Self.ImageList1;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    FPopupMenu.Items.Add(Item);
  end;
  ToolButton1.DropdownMenu := FPopupMenu;
  ToolButton1.Style := tbsDropDown;

  // Popup menu
  PopupMenu1.Items[0].Clear;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    PopupMenu1.Items[0].Add(Item);
  end;
  {$IFNDEF ADX_VCL7}
  PopupMenu1.Items[0].OnClick := nil;
  PopupMenu1.Items[0].Action := nil;
  {$ENDIF}
end;

destructor TadxRibbonGroupControlsEditor.Destroy;
begin
  FPopupMenu.Free;
  if FAddedItemIDList <> nil then FreeAndNil(FAddedItemIDList);
  inherited Destroy;
end;

procedure TadxRibbonGroupControlsEditor.Loaded;
begin
  inherited Loaded;
  // disable standard Add action
  AddCmd.ShortCut := 0;
  AddCmd.OnExecute := DoNothing;
  DeleteCmd.OnExecute := DeleteClick;
end;

procedure TadxRibbonGroupControlsEditor.DoNothing(Sender: TObject);
begin
  // emulate default item
  if Sender is TAction then DoAddControl(FPopupMenu.Items[0]);
end;

procedure TadxRibbonGroupControlsEditor.DoAddControl(Sender: TObject);
var
  Item: TListItem;
  PrevCount: Integer;
  RItem: TadxRibbonCustomControl;
begin
  SelectNone(False);
  Collection.BeginUpdate;
  try
    PrevCount := Collection.Count + 1;
    RItem := nil;
    try
      RItem := TadxRibbonControls(Collection).Add(TadxRibbonControlType((Sender as TComponent).Tag));
    except
      on E: Exception do begin
        if Assigned(RItem) then RItem.Free;
        MessageDlg(E.Message, mtError, [mbOK], 0);
        Exit;
      end;
    end;
    if PrevCount <> Collection.Count then
      UpdateListBox
    else
      ListView1.Selected := ListView1.Items.Add;
  finally
    Collection.EndUpdate;
  end;
  SetSelection;
  if csAncestor in Component.ComponentState then
  begin
    if FAddedItemIDList = nil then
      FAddedItemIDList := TList.Create;
    FAddedItemIDList.Add(Pointer(Collection.Items[Collection.Count - 1].ID));
  end;
  Designer.Modified;
  Item := ListView1.Items[ListView1.Items.Count-1];
  Item.Focused := True;
  Item.MakeVisible(False);
end;

procedure TadxRibbonGroupControlsEditor.DeleteClick(Sender: TObject);
const
  SCantDeleteAncestor = 'Selection contains a component introduced in an ancestor form which cannot be deleted';
var
  I, J, K: Integer;
  Item: TCollectionItem;
  Found: Boolean;
begin
  Collection.BeginUpdate;
  try
    Designer.SetSelections(nil);
    if ListView1.Selected <> nil then
      J := ListView1.Selected.Index
    else J := -1;
    if (ListView1.SelCount = Collection.Count) and ((csAncestor in Component.ComponentState) = False) then
      Collection.Clear
    else if ListView1.SelCount > 0 then
      for I := ListView1.Items.Count - 1 downto 0 do
        if ListView1.Items[I].Selected then
        begin
          Found := False;
          if (FAddedItemIDList <> nil) and (FAddedItemIDList.Count > 0) then
          for K := 0 to FAddedItemIDList.Count -1 do
          begin
            Item := Collection.FindItemID(Integer(FAddedItemIDList[K]));
            if Item = Collection.Items[i] then
            begin
              FAddedItemIDList.Delete(K);
              Found := True;
              Break;
            end
            else Found := False;
          end;
          if (not Found) and (csAncestor in Component.ComponentState) then
            raise Exception.Create(SCantDeleteAncestor)
          else
            Collection.Items[I].Free;
        end;
  finally
    Collection.EndUpdate;
  end;
  UpdateListbox;
  if J >= ListView1.Items.Count then
    J := ListView1.Items.Count - 1;
  if (J > -1) and (J < ListView1.Items.Count) then
    ListView1.Selected := ListView1.Items[J];
  SetSelection;
  Designer.Modified;
end;

{ TadxRibbonGroupControlsProperty }

function TadxRibbonGroupControlsProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxRibbonGroupControlsEditor;
end;

{ TadxRibbonButtonGroupControlsEditor }

constructor TadxRibbonButtonGroupControlsEditor.Create(AOwner: TComponent);
const
  Count = 3;
  MenuCaption: array [0..Count] of string = (
    'Button', 'Gallery', 'Menu', 'SplitButton');
  ItemTypes: array [0..Count] of TadxRibbonControlType = (
    rctButton, rctGallery, rctMenu, rctSplitButton);
var
  i: Integer;
  Item: TMenuItem;
begin
  inherited Create(AOwner);
  // add button
  FPopupMenu := TPopupMenu.Create(Self);
  FPopupMenu.Images := Self.ImageList1;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    FPopupMenu.Items.Add(Item);
  end;
  ToolButton1.DropdownMenu := FPopupMenu;
  ToolButton1.Style := tbsDropDown;

  // Popup menu
  PopupMenu1.Items[0].Clear;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    PopupMenu1.Items[0].Add(Item);
  end;
  {$IFNDEF ADX_VCL7}
  PopupMenu1.Items[0].OnClick := nil;
  PopupMenu1.Items[0].Action := nil;
  {$ENDIF}
end;

{ TadxRibbonButtonGroupControlsProperty }

function TadxRibbonButtonGroupControlsProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxRibbonButtonGroupControlsEditor;
end;

{ TadxRibbonMenuControlsEditor }

constructor TadxRibbonMenuControlsEditor.Create(AOwner: TComponent);
const
  Count = 5;
  MenuCaption: array [0..Count] of string = (
    'Button', 'CheckBox', 'Gallery', 'Menu', 'SplitButton', 'MenuSeparator');
  ItemTypes: array [0..Count] of TadxRibbonControlType = (
    rctButton, rctCheckBox, rctGallery, rctMenu, rctSplitButton, rctMenuSeparator);
var
  i: Integer;
  Item: TMenuItem;
begin
  inherited Create(AOwner);
  // add button
  FPopupMenu := TPopupMenu.Create(Self);
  FPopupMenu.Images := Self.ImageList1;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    FPopupMenu.Items.Add(Item);
  end;
  ToolButton1.DropdownMenu := FPopupMenu;
  ToolButton1.Style := tbsDropDown;

  // Popup menu
  PopupMenu1.Items[0].Clear;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    PopupMenu1.Items[0].Add(Item);
  end;
  {$IFNDEF ADX_VCL7}
  PopupMenu1.Items[0].OnClick := nil;
  PopupMenu1.Items[0].Action := nil;
  {$ENDIF}
end;

{ TadxRibbonMenuControlsProperty }

function TadxRibbonMenuControlsProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxRibbonMenuControlsEditor;
end;

{ TadxRibbonSplitButtonControlsProperty }

function TadxRibbonSplitButtonControlsProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TCollectionEditor;
end;

function TadxRibbonSplitButtonControlsProperty.GetColOptions: TColOptions;
begin
  Result := [];
end;

{ TadxRibbonOfficeMenuControlsEditor }

constructor TadxRibbonOfficeMenuControlsEditor.Create(AOwner: TComponent);
const
  Count = 5;
  MenuCaption: array [0..Count] of string = (
    'Button', 'CheckBox', 'Gallery', 'MenuSeparator', 'SplitButton', 'Menu');
  ItemTypes: array [0..Count] of TadxRibbonControlType = (
    rctButton, rctCheckBox, rctGallery, rctMenuSeparator, rctSplitButton, rctMenu);
var
  i: Integer;
  Item{, SItem}: TMenuItem;
begin
  inherited Create(AOwner);
  // add button
  FPopupMenu := TPopupMenu.Create(Self);
  FPopupMenu.Images := Self.ImageList1;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    FPopupMenu.Items.Add(Item);
  end;
  ToolButton1.DropdownMenu := FPopupMenu;
  ToolButton1.Style := tbsDropDown;

  // Popup menu
  PopupMenu1.Items[0].Clear;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    PopupMenu1.Items[0].Add(Item);
  end;
  {$IFNDEF ADX_VCL7}
  PopupMenu1.Items[0].OnClick := nil;
  PopupMenu1.Items[0].Action := nil;
  {$ENDIF}
end;

{ TadxRibbonOfficeMenuControlsProperty }

function TadxRibbonOfficeMenuControlsProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxRibbonOfficeMenuControlsEditor;
end;

{ TadxRibbonBoxControlsEditor }

constructor TadxRibbonBoxControlsEditor.Create(AOwner: TComponent);
const
  Count = 10;
  MenuCaption: array [0..Count] of string = (
    'Button', 'CheckBox', 'Label',
    'EditBox', 'ComboBox', 'DropDown', 'Gallery', 'Menu',
    'SplitButton', 'Box', 'ButtonGroup');
  ItemTypes: array [0..Count] of TadxRibbonControlType = (
    rctButton, rctCheckBox, rctLabel,
    rctEditBox, rctComboBox, rctDropDown, rctGallery, rctMenu,
    rctSplitButton, rctBox, rctButtonGroup);
var
  i: Integer;
  Item: TMenuItem;
begin
  inherited Create(AOwner);
  // add button
  FPopupMenu := TPopupMenu.Create(Self);
  FPopupMenu.Images := Self.ImageList1;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    FPopupMenu.Items.Add(Item);
  end;
  ToolButton1.DropdownMenu := FPopupMenu;
  ToolButton1.Style := tbsDropDown;

  // Popup menu
  PopupMenu1.Items[0].Clear;
  for i := 0 to Count do begin
    Item := TMenuItem.Create(Self);
    Item.Caption := MenuCaption[i];
    Item.Tag := Integer(ItemTypes[i]);
    Item.OnClick := DoAddControl;
    if i = 0 then Item.Default := True;
    PopupMenu1.Items[0].Add(Item);
  end;
  {$IFNDEF ADX_VCL7}
  PopupMenu1.Items[0].OnClick := nil;
  PopupMenu1.Items[0].Action := nil;
  {$ENDIF}
end;

{ TadxRibbonBoxControlsProperty }

function TadxRibbonBoxControlsProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxRibbonBoxControlsEditor;
end;

{ TadxRibbonControlsProperty }

procedure TadxRibbonControlsProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := TPersistentAccess(Obj).GetOwner;
  ShowRibbonEditor(Designer, TComponent(Obj), TOwnedCollection(GetOrdValue), GetName);
end;

{ TadxRibbonDummyControlsProperty }

procedure TadxRibbonDummyControlsProperty.Edit;
var
  Obj: TPersistent;
  AOwner: TPersistent;
begin
  Obj := GetComponent(0);
  if Obj is TadxRibbonCustomControl then begin
    AOwner := TCollectionAccess(TadxRibbonCustomControl(Obj).Collection).GetOwner;
    while (AOwner <> nil) and
      not (AOwner is TadxRibbonTab) and
      not (AOwner is TadxRibbonOfficeMenu) and
      not (AOwner is TadxRibbonQAT) and
      not (AOwner is TadxRibbonContextMenu) do
      AOwner := TCollectionAccess(TadxRibbonCustomControl(AOwner).Collection).GetOwner;

    if AOwner <> nil then begin
      if AOwner is TadxRibbonTab then
        ShowRibbonEditor(Designer, TadxRibbonTab(AOwner), TadxRibbonTab(AOwner).Controls, 'Controls')
      else
        if AOwner is TadxRibbonOfficeMenu then
          ShowRibbonEditor(Designer, TadxRibbonOfficeMenu(AOwner), TadxRibbonOfficeMenu(AOwner).Controls, 'Controls')
        else
        if AOwner is TadxRibbonQAT then
          ShowRibbonEditor(Designer, TadxRibbonQAT(AOwner), TadxRibbonQAT(AOwner).Controls, 'Controls')
        else
          if AOwner is TadxRibbonContextMenu then
            ShowRibbonEditor(Designer, TadxRibbonContextMenu(AOwner), TadxRibbonContextMenu(AOwner).Controls, 'Controls');
    end;
  end;
end;

{ TadxRibbonTabContextProperty }

function TadxRibbonTabContextProperty.AutoFill: boolean;
begin
  Result := True;
end;

function TadxRibbonTabContextProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TadxRibbonTabContextProperty.GetValues(Proc: TGetStrProc);
const
  Contexts: array[0..58 + 46 - 3] of string = (
    // Access 2007 Release (ok)
    'Access.TabSetFormToolsLayout',
    'Access.TabSetFormTools',
    'Access.TabSetReportToolsLayout',
    'Access.TabSetReportTools',
    'Access.TabSetRelationshipTools',
    'Access.TabSetQueryTools',
    'Access.TabSetMacroTools',
    'Access.TabSetPivotTableAccess',
    'Access.TabSetPivotChartAccess',
    'Access.TabSetTableToolsDatasheet',
    'Access.TabSetTableToolsDesign',
    'Access.TabSetAdpFunctionAndViewTools',
    'Access.TabSetAdpStoredProcedure',
    'Access.TabSetAdpSqlStatement',
    'Access.TabSetAdpDiagram',
    'Access.TabSetFormReportExtensibility',
    // Access 2010 Release (ok)
    'Access.TabSetFormDatasheet',

    // Excel 2007 Release (ok)
    'Excel.TabSetSmartArtTools',
    'Excel.TabSetChartTools',
    'Excel.TabSetDrawingTools',
    'Excel.TabSetPictureTools',
    'Excel.TabSetPivotTableTools',
    'Excel.TabSetHeaderAndFooterTools',
    'Excel.TabSetTableToolsExcel',
    'Excel.TabSetPivotChartTools',
    'Excel.TabSetInkTools',
    // Excel 2010 Release (ok)
    'Excel.TabSetSparkline',
    'Excel.TabSetSlicerTools',
    'Excel.TabSetEquationTools',

    // Outlook 2007 Release (ok)
    'OutlookItem.TabSetSmartArtTools',
    'OutlookItem.TabSetChartTools',
    'OutlookItem.TabSetPictureTools',
    'OutlookItem.TabSetDrawingToolsClassic',
    'OutlookItem.TabSetWordArtTools',
    'OutlookItem.TabSetDiagramTools',
    'OutlookItem.TabSetOrganizationChartTools',
    'OutlookItem.TabSetTextBoxTools',
    'OutlookItem.TabSetTableTools',
    'OutlookItem.TabSetEquationTools',
    'OutlookItem.TabSetPictureToolsClassic',
    'OutlookItem.TabSetInkTools',
    // Outlook 2010 Items Release (ok)
    'OutlookItem.TabSetDrawingTools',
    'OutlookItem.TabSetAttachments', // MailRead
    // Outlook 2010 Explorer Release (ok)
    'Outlook.TabSetAppointment',
    'Outlook.TabSetReccurringAppointment',
    'Outlook.TabSetToDoBar',
    'Outlook.TabSetDailyTaskList',
    'Outlook.TabSetSearch',
    'Outlook.TabSetAttachments',

    // PowerPoint 2007 Release (ok)
    'PowerPoint.TabSetSmartArtTools',
    'PowerPoint.TabSetChartTools',
    'PowerPoint.TabSetDrawingTools',
    'PowerPoint.TabSetPictureTools',
    'PowerPoint.TabSetTableTools',
    'PowerPoint.TabSetSoundTools',
    'PowerPoint.TabSetMovieTools',
    'PowerPoint.TabSetCDAudioTools',
    'PowerPoint.TabSetInkTools',
    // PowerPoint 2010 Release (ok)
    'PowerPoint.TabSetAudioTools',
    'PowerPoint.TabSetVideoTools',
    'PowerPoint.TabSetEquationTools',

    // Word 2007 Release (ok)
    'Word.TabSetSmartArtTools',
    'Word.TabSetChartTools',
    'Word.TabSetPictureTools',
    'Word.TabSetDrawingToolsClassic',
    'Word.TabSetWordArtTools',
    'Word.TabSetDiagramTools',
    'Word.TabSetOrganizationChartTools',
    'Word.TabSetTextBoxTools',
    'Word.TabSetTableTools',
    'Word.TabSetHeaderAndFooterTools',
    'Word.TabSetEquationTools',
    'Word.TabSetPictureToolsClassic',
    'Word.TabSetInkTools',
    // Word 2010 Release (ok)
    'Word.TabSetDrawingTools',

    // InfoPath 2010 (Designer) Release (ok)
    'InfoPathDesigner.TabSetControlTools',
    'InfoPathDesigner.TabSetTableTools',
    'InfoPathDesigner.TabSetPictureTools',

    // InfoPath 2010 (Filler) Release (ok)
    'InfoPathFiller.TabSetTableTools',
    'InfoPathFiller.TabSetPictureTools',
(*
    // OneNote 2010
    'OneNote.TabSetAudioAndVideoRecording',
    'OneNote.TabSetTableTools',
    'OneNote.TabSetEquationTools',
*)
    // Project 2010 Release (ok)
    'Project.TabSetGanttChart',
    'Project.TabSetCalendar',
    'Project.TabSetNetworkDiagram',
    'Project.TabSetTaskUsageView',
    'Project.TabSetResourceUsageView',
    'Project.TabSetResourceSheetview',
    'Project.TabSetTaskSheetView',
    'Project.TabSetResourceGraph',
    'Project.TabSetTaskFormView',
    'Project.TabSetResourceFormView',
    'Project.TabSetTeamPlanner',
    'Project.TabSetTimelineView',

    // Publisher 2010 Release (ok)
    'Publisher.TabSetCatalogMerge',
    'Publisher.TabSetDrawingToolsClassic',
    'Publisher.TabSetTextBoxTools',
    'Publisher.TabSetWordArtTools',
    'Publisher.TabSetPictureToolsClassic',
    'Publisher.TabSetTableTools',

    // Visio 2010 Release (ok)
    'Visio.TabSetPictureTools',
    'Visio.TabSetInkTools',
    'Visio.TabSetShapeSheetTools',
    'Visio.TabSetContainerTools'
    );

var
  i: Integer;
begin
  for i := 0 to High(Contexts) do Proc(Contexts[i]);
end;

{ TadxCTPProgIDProperty }

function TadxCTPProgIDProperty.AutoFill: boolean;
begin
  Result := False;
end;

function TadxCTPProgIDProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TadxCTPProgIDProperty.GetValues(Proc: TGetStrProc);
var
  tlbFile: string;
  i, Count: Integer;
  ILib: ITypeLib;
  IType: ITypeInfo;
  TypeAttr: PTypeAttr;
  tk: ActiveX.TTypeKind;
  PropName: WideString;
  HelpContext: Longint;
  LibName: string;
begin
  {$IFDEF DELPHI_9_UP}
  tlbFile := ChangeFileExt((BorlandIDEServices as IOTAModuleServices).GetActiveProject.FileName, '.tlb');
  {$ELSE}
  tlbFile := ChangeFileExt(ToolServices.GetProjectName, '.tlb');
  {$ENDIF}
  if not FileExists(tlbFile) then
    raise Exception.Create(Format('Cannot find the "%s" file!', [ExtractFileName(tlbFile)]));
  SetLength(PropName, 1024);
  try
    if (LoadTypeLibEx(PWideChar(WideString(tlbFile)), REGKIND_NONE, ILib) = S_OK) and Assigned(ILib) then
      try
        Count := ILib.GetTypeInfoCount;
        ILib.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
        LibName := PropName;
        for i := 0 to Count - 1 do begin
          ILib.GetTypeInfoType(i, tk);
          if tk = TKIND_COCLASS then begin
            ILib.GetTypeInfo(i, IType);
            try
              IType.GetTypeAttr(TypeAttr);
              try
                //if TypeAttr^.wTypeFlags = 34 then // Control & CanCreate
                if ((TypeAttr^.wTypeFlags and TYPEFLAG_FCONTROL) = TYPEFLAG_FCONTROL) and
                  ((TypeAttr^.wTypeFlags and TYPEFLAG_FCANCREATE) = TYPEFLAG_FCANCREATE) then
                begin
                  IType.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
                  Proc(LibName + '.' + PropName);
                end;
              finally
                IType.ReleaseTypeAttr(TypeAttr);
              end;
            finally
              IType := nil;
            end;
          end;
        end;
      finally
        ILib := nil;
      end;
  finally
    SetLength(PropName, 0);
  end;
end;

{ TadxMainMenuNameProperty }

function TadxMainMenuNameProperty.AutoFill: boolean;
begin
  Result := False;
end;

function TadxMainMenuNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TadxMainMenuNameProperty.GetValues(Proc: TGetStrProc);
begin
  case TadxMainMenu(GetComponent(0)).SupportedApp of
    ohaExcel:
      begin
        Proc('Worksheet Menu Bar');
        Proc('Chart Menu Bar');
      end;
    ohaPowerPoint:
      begin
        Proc('Menu Bar');
        Proc('Menu Bar (Slide Show)');
      end;
    ohaVisio:
      begin
        Proc('Menu Bar');
        Proc('Stencil Menu Bar');
        Proc('ShapeSheet Menu Bar');
        Proc('Icon Editor Menu Bar');
        Proc('Print Preview Menu Bar');
      end
    else
      Proc('Menu Bar');
  end;
end;

{ TadxContextMenuNameProperty }

function TadxContextMenuNameProperty.AutoFill: boolean;
begin
  Result := True;
end;

function TadxContextMenuNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TadxContextMenuNameProperty.GetValues(Proc: TGetStrProc);
const
  ExcelNames: array [0..56] of string = (
    'ActiveX Control', 'Add Command', 'Auto Sum', 'AutoCalculate', 'AutoFill',
    'Built-in Menus', 'Button', 'Canvas Popup', 'Cell', 'Chart', 'Column',
    'Connector', 'Curve', 'Curve Node', 'Curve Segment', 'Desktop',
    'Diagram', 'Dialog', 'Document', 'Excel Control', 'Find Format', 'Floor and Walls',
    'Format Axis', 'Format Data Series', 'Format Legend Entry', 'Formula Bar',
    'Inactive Chart', 'Layout', 'List Range Layout Popup', 'List Range Popup',
    'Nondefault Drag and Drop', 'Object/Plot', 'OLE Object', 'Organization Chart Popup',
    'Paste Special Dropdown', 'Phonetic Information', 'Pictures Context Menu',
    'Pivot Chart Popup', 'PivotChart Menu', 'PivotTable Context Menu', 'Plot Area',
    'Ply', 'Query', 'Query Layout', 'Replace Format', 'Rotate Mode', 'Row',
    'Script Anchor Popup', 'Select', 'Series', 'Shapes', 'Title Bar (Charting)',
    'Trendline', 'WordArt Context Menu', 'Workbook tabs', 'XLM Cell', 'XML Range Popup');
  WordNames: array [0..62] of string = (
    'ActiveX Control', 'Address Block Popup', 'AutoSignature Popup',
    'Background Proofing Status Bar', 'Canvas Popup', 'Chinese Translation',
    'Comment', 'Connector', 'Curve', 'Curve Node', 'Curve Segment', 'Diagram',
    'Display Fields', 'Document Map', 'Drop Caps', 'Endnotes', 'Field AutoText',
    'Field Display List Numbers', 'Fields', 'Floating Picture', 'Font Paragraph',
    'Font Popup', 'Footnotes', 'Form Fields', 'Format consistency',
    'Format Inspector Popup in Compare Mode', 'Format Inspector Popup in Normal Mode',
    'Frame Properties', 'Frames', 'Grammar', 'Grammar (2)', 'Greeting Line Popup',
    'Headings', 'Horizontal Line Popup', 'Hyperlink Context Menu', 'Ink Comment',
    'Inline ActiveX Control', 'Inline Canvas', 'Inline Picture', 'Linked Headings',
    'Linked Table', 'Linked Text', 'Lists', 'OLE Object', 'Organization Chart Popup',
    'Rotate Mode', 'Script Anchor Popup', 'Shapes', 'Spelling', 'System', 'Table Cells',
    'Table Headings', 'Table Lists', 'Table Pictures', 'Table Text', 'Tables', 'Text',
    'Track Changes', 'Track Changes Indicator', 'Whole Table', 'WordArt Context Menu',
    'XML Error Options', 'XML Structure Node Popup');
  OutlookNames: array [0..5] of string = (
    'AttachmentContextMenu', 'ViewContextMenu', 'ItemContextMenu',
    'FolderContextMenu', 'StoreContextMenu', 'ShortcutContextMenu');
  PowerPointNames: array [0..33] of string = (
    'ActiveX Control', 'Canvas Popup', 'Comment Popup', 'Connector', 'Curve',
    'Curve Node', 'Curve Segment', 'Diagram', 'Frames', 'Hyperlinked Object',
    'Nondefault Drag and Drop', 'Notes Pane', 'Notes View Slide', 'OLE Object',
    'Organization Chart Popup', 'OrgChart Text Edit PopUp', 'Outliner', 'Pictures Context Menu',
    'Revision Marker Popup', 'Rotate Mode', 'Script Anchor Popup', 'Shapes',
    'Slide Gap', 'Slide Show', 'Slide Show Browse', 'Slide Show Short Popup',
    'Slide View Ink Annotation Popup', 'Slider Sorter', 'Spelling', 'System',
    'Table Cells', 'Tables', 'Thumbnails', 'WordArt Context Menu');
   AccessNames: array [0..126] of string = (
    'Actions', 'Add to Page', 'Connection', 'Control Selection Popup',
    'Database Background', 'Database Custom Group Popup', 'Database Diagram',
    'Database Form', 'Database Macro', 'Database Module', 'Database Page Popup',
    'Database Report', 'Database Shortcut Popup', 'Database Stored Procedure',
    'Database Table/Query', 'Database TitleBar', 'Database View', 'Diagram Design Label Popup',
    'Diagram Design Popup', 'Diagram Popup', 'Document Selection Popup',
    'Expando Selection Popup', 'Field Node', 'Filter Field', 'Filter FilterByForm',
    'Filter General Context Menu', 'Form Datasheet', 'Form Datasheet Cell',
    'Form Datasheet Column', 'Form Datasheet Row', 'Form Datasheet Subcolumn',
    'Form Design Control', 'Form Design Control OLE', 'Form Design Form',
    'Form Design Section', 'Form DesignTitleBar', 'Form PivotChart Popup',
    'Form PivotTable Popup', 'Form View Control', 'Form View Popup', 'Form View Record',
    'Form View Subform', 'Form View Subform Control', 'Form/Report Properties',
    'Function Datasheet Popup', 'Function Design', 'Function Pivot Chart Popup',
    'Function Pivot Table Popup', 'Global', 'Group Level Properties', 'Index Lower Pane',
    'Index Properties', 'Index TitleBar', 'Index Upper Pane', 'Join Line Popup',
    'Macro Argument', 'Macro Condition', 'Macro TitleBar', 'Macro UpperPane',
    'Module Immediate', 'Module LocalsPane', 'Module Watch', 'ModuleCompiled',
    'ModuleUncompiled', 'Navigation Control Popup', 'Object Browser', 'OLE Shared',
    'Page Popup', 'Page Selection Popup', 'PivotChart Popup', 'PivotList Popup',
    'PivotTable Popup', 'Print Preview Popup', 'Query', 'Query Design Datasheet',
    'Query Design Datasheet Cell', 'Query Design Datasheet Column',
    'Query Design Datasheet Row', 'Query Design Join', 'Query Design Properties',
    'Query DesignFieldList', 'Query DesignGrid', 'Query PivotChart Popup',
    'Query PivotTable Popup', 'Query SQLText', 'Query SQLTitleBar', 'Relationship',
    'Relationship Join', 'Relationship QueryFieldList', 'Relationship TableFieldList',
    'Report Design Control', 'Report Design Section', 'Report DesignReport',
    'Report DesignTitleBar', 'Section Selection Popup', 'Stored Procedure Design Datasheet',
    'Stored Procedure Design Popup', 'Stored Procedure PivotChart Popup', 'Stored Procedure PivotTable Popup',
    'System', 'Tab Control', 'Tab Control on Report Design', 'Table Design Datasheet',
    'Table Design Datasheet Cell', 'Table Design Datasheet Column',
    'Table Design Datasheet Row', 'Table Design Lower Pane', 'Table Design Properties',
    'Table Design Upper Pane', 'Table DesignTitleBar', 'Table PivotChart Popup',
    'Table PivotTable Popup', 'Trigger Design Popup', 'View Design Background Popup',
    'View Design Datasheet', 'View Design Diagram Pane Popup', 'View Design Field Popup',
    'View Design Grid Pane Popup', 'View Design Join Line Popup',
    'View Design Multiple Select Popup', 'View Design SQL Pane Popup',
    'View PivotChart Popup', 'View PivotTable Popup', 'View Show Panes Submenu',
    'View Table Design Popup', 'View Table View Mode Submenu', 'Web Page Layout');
  ProjectNames: array [0..0] of string = ('System');
  FrontPageNames: array [0..43] of string = (
    '3-D Lighting', '3-D Surface Material', 'All Files File Context Menu',
    'All Files Report Context Menu', 'Canvas Popup', 'Change Shape',
    'Connection Speed Context Menu', 'Context Menu for Right Folder Pane', 'Curve',
    'Curve Node', 'Curve Segment', 'Draw', 'Editor to Editor Drag and Drop',
    'Explorer to Editor Drag and Drop', 'External to Explorer Drag and Drop', 'Extrusion Depth',
    'Extrusion Direction', 'Floating Picture', 'Folder Tree Context Menu',
    'Folder Tree Context Menu for Nav View', 'Folder Tree View Context Menu',
    'Folders View Context Menu', 'Html Page View Context Menu', 'Hyperlinks Context Menu',
    'Hyperlinks Hyperlink Context Menu', 'Hyperlinks Report Context Menu',
    'Hyperlinks View Context Menu', 'Image Control', 'Navigation Context Menu',
    'Navigation Tree No Page Context Menu', 'Navigation Tree Page Context Menu',
    'Navigation View Context Menu', 'Normal Page View Context Menu', 'Publish Context Menu',
    'Rotate Mode', 'Shapes', 'Snap To', 'System', 'Task Context Menu', 'Tasks View Context Menu',
    'View Bar Context Menu', 'WordArt Alignment', 'WordArt Context Menu', 'WordArt Tracking');
  VisioNames: array [0..40] of string = (
    '&Float Window', 'Add Command', 'Anchor Bar Base', 'Anchor Bar Custom Properties',
    'Anchor Bar Shapes Window', 'Anchor Bar Size & Position', 'Auto&Hide', 'Comment',
    'Connection Point', 'Connector Tool Palette', 'Debug', 'Drawing Explorer Document',
    'Drawing Explorer Layer', 'Drawing Explorer Layers', 'Drawing Explorer Master',
    'Drawing Explorer Masters', 'Drawing Explorer Page', 'Drawing Explorer Pages',
    'Drawing Explorer Patterns', 'Drawing Explorer Shape', 'Drawing Explorer Shapes',
    'Drawing Explorer Style', 'Drawing Explorer Styles', 'Drawing Object Selected',
    'Edit Master', 'Edit Stencil', 'Full Screen', 'Hyperlink', 'Line Jump Code',
    'Line Jump Style', 'Master Explorer Document', 'Master Explorer Masters',
    'OLE Object Selected', 'Page Tab', 'ShapeSheet', 'System', 'Text Edit',
    'Text Tool Palette', 'Toolbar Hosting In Place', 'Toolbar In Place', 'Toolbars');
  PublisherNames: array [0..0] of string = ('System');
  InfoPathNames: array [0..0] of string = ('System');

var
  i: Integer;  
begin
  case TadxContextMenu(GetComponent(0)).SupportedApp of
    ohaMapPoint:;
    ohaExcel: for i := 0 to High(ExcelNames) do Proc(ExcelNames[i]);
    ohaWord: for i := 0 to High(WordNames) do Proc(WordNames[i]);
    ohaOutlook: for i := 0 to High(OutlookNames) do Proc(OutlookNames[i]);
    ohaPowerPoint: for i := 0 to High(PowerPointNames) do Proc(PowerPointNames[i]);
    ohaAccess: for i := 0 to High(AccessNames) do Proc(AccessNames[i]);
    ohaFrontPage: for i := 0 to High(FrontPageNames) do Proc(FrontPageNames[i]);
    ohaVisio: for i := 0 to High(VisioNames) do Proc(VisioNames[i]);
    //ohaProject, ohaPublisher, ohaInfoPath:
    else
      Proc('System');
  end;
end;

{ TadxOLSolutionModuleEditor }

{$IFDEF ADX_VCL5}
procedure TadxOLSolutionModuleEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxOLSolutionModuleEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'FOLDERS') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;

procedure TadxOLSolutionModuleEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

function TadxOLSolutionModuleEditor.GetVerb(Index: Integer): string;
begin
  Result := '&Folders...';
end;

function TadxOLSolutionModuleEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TadxOLSolutionFoldersProperty }

procedure TadxOLSolutionFoldersProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := TPersistentAccess(Obj).GetOwner;
  ShowSolutionModuleEditor(Designer, TComponent(Obj), TOwnedCollection(GetOrdValue), GetName);
end;

{ TadxRibbonContextMenuContextMenuNamesProperty }

function TadxRibbonContextMenuContextMenuNamesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TadxRibbonContextMenuContextMenuNamesProperty.Edit;
var
  RegKey: string;
begin
  {$IFDEF ADX_VCL5}
  RegKey := '\Software\Borland\Delphi\5.0' + '\Property Editors\Collection Editor';
  {$ELSE}
  RegKey := Self.Designer.GetBaseRegKey + '\Property Editors\Collection Editor';
  {$ENDIF}
  adxRibbonContextMenuNamesEditor := TadxRibbonContextMenuNamesEditor.Create(TStringList(GetOrdValue), GetContextMenuNames(), RegKey);
  try
    adxRibbonContextMenuNamesEditor.Caption := Format(adxRibbonContextMenuNamesEditor.Caption, ['Context Menu Names']);
    if adxRibbonContextMenuNamesEditor.ShowModal = mrOK then Designer.Modified;
  finally
    adxRibbonContextMenuNamesEditor.Free;
  end;
end;

function TadxRibbonContextMenuContextMenuNamesProperty.GetContextMenuNames(): TStringList;
const
  Contexts: array[0..0 + 77 + 6 + 7 + (*28 +*) 41 + 15 + 70 + 32 + 31 + 43 + 114] of string = (
    // Access 2010 (0) Release (0)

    // Excel 2010 (79) Release (78!)
    'Excel.ContextMenuWorkbook',
    'Excel.ContextMenuWorkbookPly',
    'Excel.ContextMenuFormulaBar',
    'Excel.ContextMenuDesktop',
    'Excel.ContextMenuTitleBar',
    'Excel.ContextMenuPreviewer',
    'Excel.ContextMenuCellLayout',
    'Excel.ContextMenuCell',
    'Excel.ContextMenuRowLayout',
    'Excel.ContextMenuRow',
    'Excel.ContextMenuColumnLayout',
    'Excel.ContextMenuColumn',
    'Excel.ContextMenuDialogPly',
    'Excel.ContextMenuMacroCell',
    'Excel.ContextMenuXmlRangeLayout',
    'Excel.ContextMenuXmlRange',
    'Excel.ContextMenuListRangeLayout',
    'Excel.ContextMenuListRange',
    'Excel.ContextMenuPivotTable',
    'Excel.ContextMenuDrawnObject',
    'Excel.ContextMenuActiveXControl',
    'Excel.ContextMenuFormControl',
    'Excel.ContextMenuOleObject',
    'Excel.ContextMenuCurve',
    'Excel.ContextMenuCurveNode',
    'Excel.ContextMenuCurveSegment',
    'Excel.ContextMenuConnectorClassic',
    'Excel.ContextMenuQueryLayout',
    'Excel.ContextMenuQuery',
    'Excel.ContextMenuAutoFill',
    'Excel.ContextMenuRightDragDrop',
    'Excel.ContextMenuPhoneticEdit',
    'Excel.ContextMenuPictureClassic',
    'Excel.ContextMenuPicture',
    'Excel.ContextMenuShape',
    'Excel.ContextMenuInk',
    'Excel.ContextMenuObjectsGroup',
    'Excel.ContextMenuObjectEditPoint',
    'Excel.ContextMenuObjectEditSegment',
    'Excel.ContextMenuTextEdit',
    'Excel.ContextMenuShapeConnector',
    'Excel.ContextMenuShapeFreeform',
    'Excel.ContextMenuChartArea',
    'Excel.ContextMenuChartAxis',
    'Excel.ContextMenuChartAxisLabel',
    'Excel.ContextMenuChartAxisTitle',
    'Excel.ContextMenuChartBackWall',
    'Excel.ContextMenuChartTitle',
    'Excel.ContextMenuChartDataLabel',
    'Excel.ContextMenuChartDataLabels',
    'Excel.ContextMenuChartDataPoint',
    'Excel.ContextMenuChartDataSeries',
    'Excel.ContextMenuChartDataTable',
    'Excel.ContextMenuChartDisplayUnit',
    'Excel.ContextMenuChartDownBars',
    'Excel.ContextMenuChartDropLines',
    'Excel.ContextMenuChartErrorBars',
    'Excel.ContextMenuChartFloor',
    'Excel.ContextMenuChartGridlines',
    'Excel.ContextMenuChartHighLowLine',
    'Excel.ContextMenuChartLeaderLines',
    'Excel.ContextMenuChartLegend',
    'Excel.ContextMenuChartLegendEntry',
    'Excel.ContextMenuChartPlotArea',
    'Excel.ContextMenuChartSeriesLine',
    'Excel.ContextMenuChartSideWall',
    'Excel.ContextMenuChartTrendline',
    'Excel.ContextMenuChartTrendlineLabel',
    'Excel.ContextMenuChartUpBars',
    'Excel.ContextMenuChartWalls',
    //'Excel.ContextMenuChartSketchMode',
    'Excel.ContextMenuGraphicsCompatibility',
    'Excel.ContextMenuSmartArtContentPane',
    'Excel.ContextMenuSmartArtBackground',
    'Excel.ContextMenuSmartArtEditSmartArt',
    'Excel.ContextMenuSmartArtEdit1DShape',
    'Excel.ContextMenuSmartArtEditText',
    'Excel.ContextMenuSmartArtEdit1DShapeText',
    'Excel.ContextMenuSlicer',

    // InfoPath Designer 2010 (6) Release (6)
    'InfoPath.Designer.ContextMenuDesktop',
    'InfoPath.Designer.ContextMenuTableWhole',
    'InfoPath.Designer.ContextMenuSpell',
    'InfoPath.Designer.ContextMenuHyperlink',
    'InfoPath.Designer.ContextMenuFormControl',
    'InfoPath.Designer.ContextMenuPicture',

    // InfoPath Filler 2010 (7) Release (7)
    'InfoPath.Filler.ContextMenuDesktop',
    'InfoPath.Filler.ContextMenuTableWhole',
    'InfoPath.Filler.ContextMenuSpell',
    'InfoPath.Filler.ContextMenuHyperlink',
    'InfoPath.Filler.ContextMenuComment',
    'InfoPath.Filler.ContextMenuText',
    'InfoPath.Filler.ContextMenuPicture',

(*
    // OneNote 2010 (28) Release (28)
    'OneNote.ContextMenuOutlineHandle',
    'OneNote.ContextMenuOutlineElementHandle',
    'OneNote.ContextMenuText',
    'OneNote.ContextMenuBullets',
    'OneNote.ContextMenuNumbering',
    'OneNote.ContextMenuInkDrawing',
    'OneNote.ContextMenuLassoSelection',
    'OneNote.ContextMenuPicture',
    'OneNote.ContextMenuFileAttachment',
    'OneNote.ContextMenuTag',
    'OneNote.ContextMenuOutlookTask',
    'OneNote.ContextMenuNotebook',
    'OneNote.ContextMenuSectionGroup',
    'OneNote.ContextMenuSection',
    'OneNote.ContextMenuPage',
    'OneNote.ContextMenuConflictPage',
    'OneNote.ContextMenuVersionPage',
    'OneNote.ContextMenuPageArea',
    'OneNote.ContextMenuSectionArea',
    'OneNote.ContextMenuNotebookArea',
    'OneNote.ContextMenuConvertVersion',
    'OneNote.ContextMenuNewPageTab',
    'OneNote.ContextMenuLegacySection',
    'OneNote.ContextMenuAuthenticationFailure',
    'OneNote.ContextMenuOutOfSpace',
    'OneNote.ContextMenuEquation',
    'OneNote.ContextMenuPageIndicator',
    'OneNote.ContextMenuLinkedNotes',
*)
    // Outlook 2010 Explorer (41) Release (41)
    'Outlook.Explorer.ContextMenuMailMoreActions',
    'Outlook.Explorer.ContextMenuCalendarMoreActions',
    'Outlook.Explorer.ContextMenuContactsMoreActions',
    'Outlook.Explorer.ContextMenuTasksMoreActions',
    'Outlook.Explorer.ContextMenuNotesMoreActions',
    'Outlook.Explorer.ContextMenuJournalMoreActions',
    'Outlook.Explorer.ContextMenuAttachMoreActions',
    'Outlook.Explorer.MenuMailNewItem',
    'Outlook.Explorer.MenuCalendarNewItem',
    'Outlook.Explorer.MenuContactsNewItem',
    'Outlook.Explorer.MenuTasksNewItem',
    'Outlook.Explorer.MenuNotesNewItem',
    'Outlook.Explorer.MenuJournalNewItem',
    'Outlook.Explorer.ContextMenuMailItem',
    'Outlook.Explorer.ContextMenuMultipleItems',
    'Outlook.Explorer.ContextMenuGroupHeader',
    'Outlook.Explorer.ContextMenuCalendarItem',
    'Outlook.Explorer.ContextMenuTaskItem',
    'Outlook.Explorer.ContextMenuFlaggedMailItem',
    'Outlook.Explorer.ContextMenuFlaggedContactItem',
    'Outlook.Explorer.ContextMenuContactItem',
    'Outlook.Explorer.ContextMenuNoteItem',
    'Outlook.Explorer.ContextMenuJournalItem',
    'Outlook.Explorer.ContextMenuCalendarView',
    'Outlook.Explorer.ContextMenuCalendarViewTimeBar',
    'Outlook.Explorer.ContextMenuCalendarViewFreeBusyBar',
    'Outlook.Explorer.ContextMenuTableView',
    'Outlook.Explorer.ContextMenuTimelineView',
    'Outlook.Explorer.ContextMenuCardView',
    'Outlook.Explorer.ContextMenuFolder',
    'Outlook.Explorer.ContextMenuShortcut',
    'Outlook.Explorer.ContextMenuStore',
    'Outlook.Explorer.ContextMenuSearchRoot',
    'Outlook.Explorer.ContextMenuTableArrangeBy',
    'Outlook.Explorer.ContextMenuTableViewColumn',
    'Outlook.Explorer.ContextMenuQuickFlags',
    'Outlook.Explorer.ContextMenuCategories',
    'Outlook.Explorer.ContextMenuIconView',
    'Outlook.Explorer.ContextMenuAttachments',
    'Outlook.Explorer.ContextMenuRemoteDocument',
    'Outlook.Explorer.ContextMenuNoteSystemMenu',

    // Outlook 2010 Inspector (15) Release (15) 
    'Outlook.Appointment.ContextMenuCalendarMoreActions',
    'Outlook.Contact.ContextMenuContactsMoreActions',
    'Outlook.Mail.Read.ContextMenuAttachMoreActions',
    'Outlook.Mail.Read.ContextMenuMailMoreActions',
    'Outlook.Mail.Read.ContextMenuAttachments',
    'Outlook.MeetingRequest.Read.ContextMenuMailMoreActions',
    'Outlook.MeetingResponse.Propose.ContextMenuMailMoreActions',
    'Outlook.MeetingResponse.Read.ContextMenuMailMoreActions',
    'Outlook.MultimediaMessage.Read.ContextMenuAttachments',
    'Outlook.Post.Read.ContextMenuMailMoreActions',
    'Outlook.Post.Read.ContextMenuAttachments',
    'Outlook.Report.ContextMenuMailMoreActions',
    'Outlook.RSS.ContextMenuMailMoreActions',
    'Outlook.RSS.ContextMenuAttachments',
    'Outlook.Task.ContextMenuTasksMoreActions',

    // PowerPoint 2010 (71) Release (70!)
    'PowerPoint.ContextMenuCommentMarker',
    'PowerPoint.ContextMenuCurve',
    'PowerPoint.ContextMenuDrawnObject',
    'PowerPoint.ContextMenuFrame',
    'PowerPoint.ContextMenuMotionPath',
    'PowerPoint.ContextMenuPathPoint',
    'PowerPoint.ContextMenuPathSegment',
    'PowerPoint.ContextMenuActiveXControl',
    'PowerPoint.ContextMenuOfficePreviewHandlerPowerPoint',
    'PowerPoint.ContextMenuRevision',
    'PowerPoint.ContextMenuRightDragDrop',
    'PowerPoint.ContextMenuSlideGap',
    'PowerPoint.ContextMenuLabelSection',
    'PowerPoint.ContextMenuSlideShow',
    'PowerPoint.ContextMenuShowBrowse',
    'PowerPoint.ContextMenuShowHyperlink',
    'PowerPoint.ContextMenuShowPointerOptions',
    'PowerPoint.ContextMenuEndShow',
    'PowerPoint.ContextMenuSlideSorter',
    'PowerPoint.ContextMenuSlideSync',
    'PowerPoint.ContextMenuSpell',
    'PowerPoint.ContextMenuThumbnail',
    'PowerPoint.ContextMenuPicture',
    'PowerPoint.ContextMenuShape',
    'PowerPoint.ContextMenuInk',
    'PowerPoint.ContextMenuObjectsGroup',
    'PowerPoint.ContextMenuObjectEditPoint',
    'PowerPoint.ContextMenuObjectEditSegment',
    'PowerPoint.ContextMenuTextEdit',
    'PowerPoint.ContextMenuShapeConnector',
    'PowerPoint.ContextMenuShapeFreeform',
    'PowerPoint.ContextMenuChartArea',
    'PowerPoint.ContextMenuChartAxis',
    'PowerPoint.ContextMenuChartAxisTitle',
    'PowerPoint.ContextMenuChartBackWall',
    'PowerPoint.ContextMenuChartTitle',
    'PowerPoint.ContextMenuChartDataLabel',
    'PowerPoint.ContextMenuChartDataLabels',
    'PowerPoint.ContextMenuChartDataPoint',
    'PowerPoint.ContextMenuChartDataSeries',
    'PowerPoint.ContextMenuChartDataTable',
    'PowerPoint.ContextMenuChartDisplayUnit',
    'PowerPoint.ContextMenuChartDownBars',
    'PowerPoint.ContextMenuChartDropLines',
    'PowerPoint.ContextMenuChartErrorBars',
    'PowerPoint.ContextMenuChartFloor',
    'PowerPoint.ContextMenuChartGridlines',
    'PowerPoint.ContextMenuChartHighLowLine',
    'PowerPoint.ContextMenuChartLeaderLines',
    'PowerPoint.ContextMenuChartLegend',
    'PowerPoint.ContextMenuChartLegendEntry',
    'PowerPoint.ContextMenuChartPlotArea',
    'PowerPoint.ContextMenuChartSeriesLine',
    'PowerPoint.ContextMenuChartSideWall',
    'PowerPoint.ContextMenuChartTrendline',
    'PowerPoint.ContextMenuChartTrendlineLabel',
    'PowerPoint.ContextMenuChartUpBars',
    'PowerPoint.ContextMenuChartWalls',
    //'PowerPoint.ContextMenuChartSketchMode', //
    'PowerPoint.ContextMenuNotesEditText',
    'PowerPoint.ContextMenuTextEditOutline',
    'PowerPoint.ContextMenuGraphicsCompatibility',
    'PowerPoint.ContextMenuGraphicOleClassic',
    'PowerPoint.ContextMenuTable',
    'PowerPoint.ContextMenuTableWhole',
    'PowerPoint.ContextMenuSmartArtContentPane',
    'PowerPoint.ContextMenuSmartArtBackground',
    'PowerPoint.ContextMenuSmartArtEditSmartArt',
    'PowerPoint.ContextMenuSmartArtEdit1DShape',
    'PowerPoint.ContextMenuSmartArtEditText',
    'PowerPoint.ContextMenuSmartArtEdit1DShapeText',

    // Project 2010 (32) Release (32)
    'Project.ContextMenuTaskCell',
    'Project.ContextMenuTask',
    'Project.ContextMenuResourceCell',
    'Project.ContextMenuResource',
    'Project.ContextMenuAssignmentCell',
    'Project.ContextMenuAssignment',
    'Project.ContextMenuGanttChartBar',
    'Project.ContextMenuGanttChart',
    'Project.ContextMenuGanttChartTimescale',
    'Project.ContextMenuTimescale',
    'Project.ContextMenuColumn',
    'Project.ContextMenuCalendarViewBar',
    'Project.ContextMenuCalendarView',
    'Project.ContextMenuNetworkDiagramBox',
    'Project.ContextMenuNetworkDiagram',
    'Project.ContextMenuTaskForm',
    'Project.ContextMenuResourceForm',
    'Project.ContextMenuResourceGraphResource',
    'Project.ContextMenuResourceGraph',
    'Project.ContextMenuTimelineViewTask',
    'Project.ContextMenuTimelineView',
    'Project.ContextMenuViewHeader',
    'Project.ContextMenuDrawObject',
    'Project.ContextMenuGroupBySummary',
    'Project.ContextMenuViewBar',
    'Project.ContextMenuRowColumnHead',
    'Project.ContextMenuTaskUsageDetails',
    'Project.ContextMenuResourceUsageDetails',
    'Project.ContextMenuTeamPlannerAssignment',
    'Project.ContextMenuTeamPlannerBackground',
    'Project.ContextMenuTeamPlannerResource',
    'Project.ContextMenuITeamPlannerTimescale',

    // Published 2010 (31) Release (31)
    'Publisher.ContextMenuWorkspace',
    'Publisher.ContextMenuRulerGuide',
    'Publisher.ContextMenuMultiple',
    'Publisher.ContextMenuMultipleText',
    'Publisher.ContextMenuRightDragDrop',
    'Publisher.ContextMenuObjectsGroup',
    'Publisher.ContextMenuOleObject',
    'Publisher.ContextMenuHtmlCodeFragment',
    'Publisher.ContextMenuHtmlControl',
    'Publisher.ContextMenuPicture',
    'Publisher.ContextMenuDrawnObject',
    'Publisher.ContextMenuCurveNode',
    'Publisher.ContextMenuCurveSegment',
    'Publisher.ContextMenuCurve',
    'Publisher.ContextMenuText',
    'Publisher.ContextMenuTextInsertionPoint',
    'Publisher.ContextMenuTextEdit',
    'Publisher.ContextMenuSpell',
    'Publisher.ContextMenuPreview',
    'Publisher.ContextMenuPageNavigationMaster',
    'Publisher.ContextMenuPageNavigationSection',
    'Publisher.ContextMenuPageNavigationContextualBetweenPages',
    'Publisher.ContextMenuPageNavPaneForegroundView',
    'Publisher.ContextMenuPageNavPaneMasterView',
    'Publisher.ContextMenuTextOverflow',
    'Publisher.ContextMenuTextInsertionPointOverflow',
    'Publisher.ContextMenuTextEditOverflow',
    'Publisher.ContextMenuTable',
    'Publisher.ContextMenuTextTable',
    'Publisher.ContextMenuWordArt',
    'Publisher.ContextMenuBuildingBlockFormatting',

    // Visio 2010 (0) Release (43!)
    'Visio.ContextMenuFullScreen',
    'Visio.ContextMenuCommentMarker',
    'Visio.ContextMenuOleObject',
    'Visio.ContextMenuConnectionPoint',
    'Visio.ContextMenuDrawingPage',
    'Visio.ContextMenuShape',
    'Visio.ContextMenuShape1D',
    'Visio.ContextMenuText',
    'Visio.ContextMenuWindowShapeData',
    'Visio.ContextMenuWindowShapes',
    'Visio.ContextMenuWindowSizePosition',
    'Visio.ContextMenuSpelling',
    'Visio.ContextMenuWindowExternalDataItem',
    'Visio.ContextMenuWindowExternalDataTab',
    'Visio.ContextMenuExplorerDocument',
    'Visio.ContextMenuExplorerLayer',
    'Visio.ContextMenuExplorerLayers',
    'Visio.ContextMenuExplorerMaster',
    'Visio.ContextMenuExplorerMasters',
    'Visio.ContextMenuExplorerPage',
    'Visio.ContextMenuExplorerPages',
    'Visio.ContextMenuExplorerPatterns',
    'Visio.ContextMenuExplorerShape',
    'Visio.ContextMenuExplorerShapes',
    'Visio.ContextMenuExplorerStyle',
    'Visio.ContextMenuExplorerStyles',
    'Visio.ContextMenuMaster',
    'Visio.ContextMenuMasterExplorerDocument',
    'Visio.ContextMenuMasterExplorerMaster',
    'Visio.ContextMenuPageNavigation',
    'Visio.ContextMenuPageTab',
    'Visio.ContextMenuWindowIssuesItem',
    'Visio.ContextMenuShapeSheet',
    'Visio.ContextMenuWindowShapesStencil',
    'Visio.ContextMenuTextDrag',
    'Visio.ContextMenuWindowPanZoom',
    'Visio.ContextMenuWindowDrawingExplorer',
    'Visio.ContextMenuWindowMasterExplorer',
    'Visio.ContextMenuWindowStyleExplorer',
    'Visio.ContextMenuWindowFormulaTracing',
    'Visio.ContextMenuWindowShapesMoreShapes',
    'Visio.ContextMenuWindowExternalData',
    'Visio.ContextMenuWindowIssues',

    // Word 2010 (115) Release (114!)
    'Word.ContextMenuDropCap',
    'Word.ContextMenuEndnote',
    'Word.ContextMenuField',
    'Word.ContextMenuFieldDisplay',
    'Word.ContextMenuFieldDisplayListNumbers',
    'Word.ContextMenuFieldForm',
    'Word.ContextMenuFootnote',
    'Word.ContextMenuFrame',
    'Word.ContextMenuHeading',
    'Word.ContextMenuHeadingLinked',
    'Word.ContextMenuScriptAnchor',
    'Word.ContextMenuList',
    'Word.ContextMenuInlinePicture',
    'Word.ContextMenuTable',
    'Word.ContextMenuTableCell',
    'Word.ContextMenuHeadingTable',
    'Word.ContextMenuListTable',
    'Word.ContextMenuPictureTable',
    'Word.ContextMenuTextTable',
    'Word.ContextMenuTableWhole',
    'Word.ContextMenuTableWholeLinked',
    'Word.ContextMenuText',
    'Word.ContextMenuOfficePreviewHandlerWord',
    'Word.ContextMenuTextLinked',
    'Word.ContextMenuRichTextFont',
    'Word.ContextMenuRichTextFontParagraph',
    'Word.ContextMenuSpell',
    'Word.ContextMenuGrammar',
    'Word.ContextMenuGrammarReading',
    'Word.ContextMenuRevision',
    'Word.ContextMenuFramesetBorder',
    'Word.ContextMenuHyperlink',
    'Word.ContextMenuFieldAutoSignatureList',
    'Word.ContextMenuFieldAutoTextList',
    'Word.ContextMenuNavigationPane',
    'Word.ContextMenuDrawnObject',
    'Word.ContextMenuCurve',
    'Word.ContextMenuCurveNode',
    'Word.ContextMenuCurveSegment',
    'Word.ContextMenuFloatingPicture',
    'Word.ContextMenuCanvasClassic',
    'Word.ContextMenuOleObject',
    'Word.ContextMenuActiveXControl',
    'Word.ContextMenuTextEffect',
    'Word.ContextMenuComment',
    'Word.ContextMenuOrganizationChart',
    'Word.ContextMenuDiagram',
    'Word.ContextMenuConnectorClassic',
    'Word.ContextMenuAddressBlock',
    'Word.ContextMenuGreetingLine',
    'Word.ContextMenuInlineActiveXControl',
    'Word.ContextMenuDocumentStructureNode',
    'Word.ContextMenuXmlError',
    'Word.ContextMenuCoAuthoringState',
    'Word.ContextMenuInkComment',
    'Word.ContextMenuInlineBusinessCard',
    'Word.ContextMenuEquation',
    'Word.ContextMenuHeaderArea',
    'Word.ContextMenuFooterArea',
    'Word.ContextMenuReadOnlyMailText',
    'Word.ContextMenuReadOnlyMailTable',
    'Word.ContextMenuReadOnlyMailTableCell',
    'Word.ContextMenuReadOnlyMailListTable',
    'Word.ContextMenuReadOnlyMailPictureTable',
    'Word.ContextMenuReadOnlyMailTextTable',
    'Word.ContextMenuReadOnlyMailTableWhole',
    'Word.ContextMenuReadOnlyMailList',
    'Word.ContextMenuReadOnlyMailHyperlink',
    'Word.ContextMenuLockedReadingMode',
    'Word.ContextMenuPageNumberingOptions',
    'Word.ContextMenuConflicts',
    'Word.ContextMenuPicture',
    'Word.ContextMenuShape',
    'Word.ContextMenuInk',
    'Word.ContextMenuObjectsGroup',
    'Word.ContextMenuObjectEditPoint',
    'Word.ContextMenuObjectEditSegment',
    'Word.ContextMenuTextEdit',
    'Word.ContextMenuShapeConnector',
    'Word.ContextMenuShapeFreeform',
    'Word.ContextMenuChartArea',
    'Word.ContextMenuChartAxis',
    'Word.ContextMenuChartAxisTitle',
    'Word.ContextMenuChartBackWall',
    'Word.ContextMenuChartTitle',
    'Word.ContextMenuChartDataLabel',
    'Word.ContextMenuChartDataLabels',
    'Word.ContextMenuChartDataPoint',
    'Word.ContextMenuChartDataSeries',
    'Word.ContextMenuChartDataTable',
    'Word.ContextMenuChartDisplayUnit',
    'Word.ContextMenuChartDownBars',
    'Word.ContextMenuChartDropLines',
    'Word.ContextMenuChartErrorBars',
    'Word.ContextMenuChartFloor',
    'Word.ContextMenuChartGridlines',
    'Word.ContextMenuChartHighLowLine',
    'Word.ContextMenuChartLeaderLines',
    'Word.ContextMenuChartLegend',
    'Word.ContextMenuChartLegendEntry',
    'Word.ContextMenuChartPlotArea',
    'Word.ContextMenuChartSeriesLine',
    'Word.ContextMenuChartSideWall',
    'Word.ContextMenuChartTrendline',
    'Word.ContextMenuChartTrendlineLabel',
    'Word.ContextMenuChartUpBars',
    'Word.ContextMenuChartWalls',
    //'Word.ContextMenuChartSketchMode',
    'Word.ContextMenuSmartArtContentPane',
    'Word.ContextMenuSmartArtBackground',
    'Word.ContextMenuSmartArtEditSmartArt',
    'Word.ContextMenuSmartArtEdit1DShape',
    'Word.ContextMenuSmartArtEditText',
    'Word.ContextMenuSmartArtEdit1DShapeText',
    'Word.ContextMenuCanvas');

var
  i: Integer;
  C: TPersistent;
  R: TadxRibbons;
  R2010: TadxRibbons2010;
begin
  Result := TStringList.Create;
  C := Self.GetComponent(0);
  if C is TadxRibbonContextMenu then begin
    R := TadxRibbonContextMenu(C).Ribbons;
    if msrAccessDatabase in R then
      for i := 0 to High(Contexts) do
        if Pos('Access.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrExcelWorkbook in R then
      for i := 0 to High(Contexts) do
        if Pos('Excel.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrPowerPointPresentation in R then
      for i := 0 to High(Contexts) do
        if Pos('PowerPoint.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrWordDocument in R then
      for i := 0 to High(Contexts) do
        if Pos('Word.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);

    if msrOutlookAppointment in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.Appointment.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookContact in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.Contact.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookMailRead in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.Mail.Read.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookMeetingRequestRead in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.MeetingRequest.Read.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookResponseCounterPropose in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.MeetingResponse.Propose.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookResponseRead in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.MeetingResponse.Read.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookPostRead in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.Post.Read.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookReport in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.Report.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookRSS in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.RSS.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookTask in R then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.Task.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    R2010 := TadxRibbonContextMenu(C).Ribbons2010;
    if (msrOutlookExplorer in R) or (msrOutlookExplorer2010 in R2010) then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.Explorer.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrOutlookMMSRead2010 in R2010 then
      for i := 0 to High(Contexts) do
        if Pos('Outlook.MultimediaMessage.Read.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrInfoPathDesigner2010 in R2010 then
      for i := 0 to High(Contexts) do
        if Pos('InfoPath.Designer.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrInforPathFiller2010 in R2010 then
      for i := 0 to High(Contexts) do
        if Pos('InfoPath.Filler.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrPublisherPublication2010 in R2010 then
      for i := 0 to High(Contexts) do
        if Pos('Publisher.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrProjectProject2010 in R2010 then
      for i := 0 to High(Contexts) do
        if Pos('Project.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
    if msrVisioDrawing2010 in R2010 then
      for i := 0 to High(Contexts) do
        if Pos('Visio.', Contexts[i]) > 0 then
          Result.Add(Contexts[i]);
  end;
  Result.Sort();
end;

{ TadxBackstageEditor }

{$IFDEF ADX_VCL5}
procedure TadxBackstageEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxBackstageEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'CONTROLS') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;

procedure TadxBackstageEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

function TadxBackstageEditor.GetVerb(Index: Integer): string;
begin
  Result := '&Controls...';
end;

function TadxBackstageEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TadxBackstageControlsProperty }

procedure TadxBackstageControlsProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := TPersistentAccess(Obj).GetOwner;
  ShowBackstageEditor(Designer, TComponent(Obj), TOwnedCollection(GetOrdValue), GetName);
end;

{ TadxBackstageDummyControlsProperty }

procedure TadxBackstageDummyControlsProperty.Edit;
var
  Obj: TPersistent;
  AOwner: TPersistent;
begin
  Obj := GetComponent(0);
  if Obj is TadxRibbonCustomControl then begin
    AOwner := TCollectionAccess(TadxRibbonCustomControl(Obj).Collection).GetOwner;
    while (AOwner <> nil) and not (AOwner is TadxBackstageView) do
      AOwner := TCollectionAccess(TadxRibbonCustomControl(AOwner).Collection).GetOwner;

    if AOwner <> nil then begin
      if AOwner is TadxBackstageView then
        ShowRibbonEditor(Designer, TadxBackstageView(AOwner), TadxBackstageView(AOwner).Controls, 'Controls');
    end;
  end;
end;

{ Register }

procedure Register;
begin
  RegisterComponents('Add-in Express', [TadxCommandBar, TadxOlExplorerCommandBar, TadxOlInspectorCommandBar,
    TadxMainMenu, TadxOlExplorerMainMenu, TadxOlInspectorMainMenu, TadxContextMenu,
    TadxBuiltInControl, TadxOLBarShortcutManager, TadxKeyboardShortcut,
    TadxRTDTopic, TadxSmartTag]);

  RegisterComponents('Add-in Express MS Forms', [TadxMSFormsCheckBox, TadxMSFormsComboBox,
    TadxMSFormsCommandButton, TadxMSFormsImage, TadxMSFormsLabelControl,
    TadxMSFormsListBox, TadxMSFormsOptionButton, TadxMSFormsScrollBar,
    TadxMSFormsSpinButton, TadxMSFormsTextBox, TadxMSFormsToggleButton]);

  RegisterComponents('Add-in Express', [TadxOutlookAppEvents, TadxExcelAppEvents, TadxWordAppEvents,
    TadxProjectAppEvents, TadxPowerPointAppEvents, TadxFrontPageAppEvents, TadxVisioAppEvents,
    TadxMapPointAppEvents, TadxPublisherAppEvents, TadxInfoPathAppEvents]);
  //RegisterPropertyEditor(TypeInfo(TadxCommandBarControls), TadxCommandBar, 'Controls', TadxCollectionProperty);
  //RegisterPropertyEditor(TypeInfo(TadxCommandBarControls), TadxCommandBarPopup, 'Controls', TadxCollectionProperty);
  // version 3.6
  RegisterPropertyEditor(TypeInfo(TadxCommandBarControls), TadxCustomCommandBar, 'Controls', TadxCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TadxCommandBarControls), TadxCommandBarPopup, 'Controls', TadxCollectionDummyProperty);

  RegisterComponentEditor(TadxCustomCommandBar, TadxCommandBarEditor);
  RegisterPropertyEditor(TypeInfo(TStringList), TadxRTDTopic, 'TopicStrings', TadxTopicsProperty);

  RegisterPropertyEditor(TypeInfo(WideString), TadxSmartTagModule, 'SmartTagName', TadxLocaleProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TadxSmartTagModule, 'SmartTagDesc', TadxLocaleProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TadxSmartTag, 'Caption', TadxLocaleProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TadxSmartTagAction, 'Caption', TadxLocaleProperty);
  {$IFDEF ADX_VCL5}
  RegisterPropertyEditor(TypeInfo(TEditMask), TadxSmartTag, 'RecognizedMask', TMaskProperty);
  {$ENDIF}
  RegisterPropertyEditor(TypeInfo(WideString), TadxCommandBarButton, 'ShortcutText', TadxShortCutProperty);
  RegisterPropertyEditor(TypeInfo(string), TadxKeyboardShortcut, 'ShortcutText', TadxShortCutProperty);

  RegisterComponentEditor(TadxSmartTag, TadxSmartTagsEditor);

  RegisterCustomModule(TadxCOMAddInModule, TCustomModule);
  RegisterCustomModule(TadxXlRTDServerModule, TCustomModule);
  RegisterCustomModule(TadxSmartTagModule, TCustomModule);

  RegisterCustomModule(TadxExcelSheetModule, TCustomModule);
  RegisterCustomModule(TadxWordDocumentModule, TCustomModule);
  //RegisterCustomModule(TadxPowerPointPresentationModule, TCustomModule);

  RegisterPropertyEditor(TypeInfo(string), TadxMSFormsControl, 'ControlName', TadxMSFormsControlNameProperty);
  RegisterPropertyEditor(TypeInfo(TFileName), TadxCustomDocumentModule, 'Document', TadxFileNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TadxCustomDocumentModule, 'PropertyID', TadxPropertyIDProperty);
  RegisterPropertyEditor(TypeInfo(string), TadxCustomDocumentModule, 'PropertyValue', TadxPropertyValueProperty);
  RegisterPropertyEditor(TypeInfo(string), TadxExcelSheetModule, 'WorkSheet', TadxWorkSheetProperty);

  RegisterComponentEditor(TadxCOMAddInModule, TadxModuleEditor);
  RegisterComponentEditor(TadxXlRTDServerModule, TadxModuleEditor);
  RegisterComponentEditor(TadxSmartTagModule, TadxModuleEditor);


  RegisterComponents('Add-in Express', [TadxRibbonTab, TadxRibbonQAT, TadxRibbonOfficeMenu, TadxRibbonCommand]);
  RegisterComponentEditor(TadxRibbonTab, TadxRibbonTabEditor);
  RegisterComponentEditor(TadxRibbonOfficeMenu, TadxRibbonTabEditor);
  RegisterComponentEditor(TadxRibbonQAT, TadxRibbonTabEditor);

  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonTab, 'Controls', TadxRibbonControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonOfficeMenu, 'Controls', TadxRibbonControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonQAT, 'Controls', TadxRibbonControlsProperty);

  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonGroup, 'Controls', TadxRibbonDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonDropDown, 'Controls', TadxRibbonDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonGallery, 'Controls', TadxRibbonDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonMenu, 'Controls', TadxRibbonDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonSplitButton, 'Controls', TadxRibbonDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonBox, 'Controls', TadxRibbonDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonButtonGroup, 'Controls', TadxRibbonDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(string), TadxRibbonTab, 'Context', TadxRibbonTabContextProperty);

  RegisterPropertyEditor(TypeInfo(string), TadxCustomTaskPane, 'ControlProgID', TadxCTPProgIDProperty);

  RegisterPropertyEditor(TypeInfo(WideString), TadxMainMenu, 'CommandBarName', TadxMainMenuNameProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TadxContextMenu, 'CommandBarName', TadxContextMenuNameProperty);

  RegisterComponents('Add-in Express', [TadxOLSolutionModule]);
  RegisterComponentEditor(TadxOLSolutionModule, TadxOLSolutionModuleEditor);
  RegisterPropertyEditor(TypeInfo(TadxOLSolutionFolders), TadxOLSolutionModule, 'Folders', TadxOLSolutionFoldersProperty);
  RegisterPropertyEditor(TypeInfo(TadxOLSolutionFolders), TadxOLSolutionFolder, 'Folders', TadxOLSolutionFoldersProperty);

  RegisterComponents('Add-in Express', [TadxRibbonContextMenu]);
  RegisterComponentEditor(TadxRibbonContextMenu, TadxRibbonTabEditor);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxRibbonContextMenu, 'Controls', TadxRibbonControlsProperty);
  RegisterPropertyEditor(TypeInfo(TStringList), TadxRibbonContextMenu, 'ContextMenuNames', TadxRibbonContextMenuContextMenuNamesProperty);

  RegisterComponents('Add-in Express', [TadxBackstageView]);
  RegisterComponentEditor(TadxBackstageView, TadxBackstageEditor);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageView, 'Controls', TadxBackstageControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageTab, 'FirstColumn', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageTab, 'SecondColumn', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageTaskFormGroup, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageTaskFormGroupCategory, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageTaskFormGroupTask, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageTaskGroup, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageTaskGroupCategory, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageGroup, 'PrimaryItem', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageGroup, 'TopItems', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageGroup, 'BottomItems', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageGroupBox, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageLayoutContainer, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageMenuGroup, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstagePrimaryMenu, 'Controls', TadxBackstageDummyControlsProperty);
  RegisterPropertyEditor(TypeInfo(TadxRibbonControls), TadxBackstageSubMenu, 'Controls', TadxBackstageDummyControlsProperty);
end;

end.
