{*********************************************************************}
{*                                                                   *}
{*             Add-In Express Component Library                      *}
{*                Add-in Express 2010 for VCL                        *}
{*                                                                   *}
{*             Copyright (C) Add-in Express Ltd.                     *}
{*             ALL RIGHTS RESERVED                                   *}
{*                                                                   *}
{*   The entire contents of this file is protected by U.S. and       *}
{*   International Copyright Laws. Unauthorized reproduction,        *}
{*   reverse-engineering, and distribution of all or any portion of  *}
{*   the code contained in this file is strictly prohibited and may  *}
{*   result in severe civil and criminal penalties and will be       *}
{*   prosecuted to the maximum extent possible under the law.        *}
{*                                                                   *}
{*   RESTRICTIONS                                                    *}
{*                                                                   *}
{*   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE       *}
{*   CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS    *}
{*   LTD.                                                            *}
{*   THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE              *}
{*   THE ADX Extensions VCL for Microsoft Outlook                    *}
{*   AND ALL ACCOMPANYING VCL COMPONENTS AS PART OF                  *}
{*   AN EXECUTABLE PROGRAM ONLY.                                     *}
{*                                                                   *}
{*   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      *}
{*   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        *}
{*   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       *}
{*   AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT          *}
{*   AND PERMISSION FROM ADD-IN EXPRESS LTD.                         *}
{*                                                                   *}
{*   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       *}
{*   ADDITIONAL RESTRICTIONS.                                        *}
{*                                                                   *}
{*********************************************************************}

unit adxolReg;

{$I adxolDefs.inc}

interface

uses Windows, SysUtils, Classes, Menus, ComCtrls, ActnList,
  Forms, Controls, ExtCtrls, StdCtrls, Grids, ToolsAPI,
  ExptIntf, TypInfo,
  {$IFDEF ADX_VCL5}
  DsgnIntf,
  {$ELSE}
  DesignIntf,
  DesignEditors,
  {$ENDIF}
  {$IFNDEF ADX_VCL5}Variants,{$ENDIF}
  adxolWClasses,  Dialogs,  ColnEdit;


type

  TadxolFormClassNameProperty = class(TStringProperty)
  private
    FList: TStringList;
  public
    {$IFDEF ADX_VCL5}
    constructor Create(const ADesigner: IFormDesigner; APropCount: Integer); override;
    {$ELSE}
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    {$ENDIF}
    destructor Destroy; override;

    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure AddItem(const S: string);
  end;

  TadxExcelTaskPaneClassNameProperty = class(TStringProperty)
  private
    FList: TStringList;
  public
    {$IFDEF ADX_VCL5}
    constructor Create(const ADesigner: IFormDesigner; APropCount: Integer); override;
    {$ELSE}
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    {$ENDIF}
    destructor Destroy; override;

    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure AddItem(const S: string);
  end;

  TadxWordTaskPaneClassNameProperty = class(TStringProperty)
  private
    FList: TStringList;
  public
    {$IFDEF ADX_VCL5}
    constructor Create(const ADesigner: IFormDesigner; APropCount: Integer); override;
    {$ELSE}
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    {$ENDIF}
    destructor Destroy; override;

    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure AddItem(const S: string);
  end;

  TadxPowerPointTaskPaneClassNameProperty = class(TStringProperty)
  private
    FList: TStringList;
  public
    {$IFDEF ADX_VCL5}
    constructor Create(const ADesigner: IFormDesigner; APropCount: Integer); override;
    {$ELSE}
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    {$ENDIF}
    destructor Destroy; override;

    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure AddItem(const S: string);
  end;

  TadxolCollectionProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxExcelCollectionProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxWordCollectionProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxPowerPointCollectionProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

  TadxolControlsEditor = class(TCollectionEditor)
  private
    FAddedItemIDList: TList;
    function GetRegKey: string;
    procedure LoadProperties;
    procedure SaveProperties;
  protected
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure DoNothing(Sender: TObject);
    procedure DoAddControl(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
  end;

  TadxxlControlsEditor = class(TCollectionEditor)
  private
    FAddedItemIDList: TList;
    function GetRegKey: string;
    procedure LoadProperties;
    procedure SaveProperties;
  protected
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure DoNothing(Sender: TObject);
    procedure DoAddControl(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
  end;

  TadxwdControlsEditor = class(TCollectionEditor)
  private
    FAddedItemIDList: TList;
    function GetRegKey: string;
    procedure LoadProperties;
    procedure SaveProperties;
  protected
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure DoNothing(Sender: TObject);
    procedure DoAddControl(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
  end;

  TadxppControlsEditor = class(TCollectionEditor)
  private
    FAddedItemIDList: TList;
    function GetRegKey: string;
    procedure LoadProperties;
    procedure SaveProperties;
  protected
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure DoNothing(Sender: TObject);
    procedure DoAddControl(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
  end;

  {$IFDEF DELPHI_9_UP}
  TadxOlFormCustomModule = class(TCustomModule)
    class function DesignClass: TComponentClass; override;
  end;
  TadxExcelFormCustomModule = class(TCustomModule)
    class function DesignClass: TComponentClass; override;
  end;
  TadxWordFormCustomModule = class(TCustomModule)
    class function DesignClass: TComponentClass; override;
  end;
  TadxPowerPointFormCustomModule = class(TCustomModule)
    class function DesignClass: TComponentClass; override;
  end;
  {$ENDIF}

procedure Register;

implementation

uses
 {$IFDEF ADX_VCL5}
 LibIntf,
 {$ENDIF}
 Registry, DesignConst,
 adxolFormsManager,
 adxwdFormsManager,
 adxppFormsManager,
 adxxlFormsManager;

{$R adxolReg.res}

{ TadxolControlsEditor }

constructor TadxolControlsEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TadxolControlsEditor.Destroy;
begin
  SaveProperties;
  inherited Destroy;
end;

procedure TadxolControlsEditor.Loaded;
begin
  inherited Loaded;
  // disable standard Add action
  AddCmd.ShortCut := 0;

  AddCmd.OnExecute := DoNothing;
  DeleteCmd.OnExecute := DeleteClick;
end;

procedure TadxolControlsEditor.DoNothing(Sender: TObject);
begin
  if Sender is TAction then DoAddControl(Sender);
end;

procedure TadxolControlsEditor.DoAddControl(Sender: TObject);
var
  Item: TListItem;
  PrevCount: Integer;
begin

  SelectNone(False);
  Collection.BeginUpdate;
  try
    PrevCount := Collection.Count + 1;
    TadxolFormsCollection(Collection).Add;
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

procedure TadxolControlsEditor.DeleteClick(Sender: TObject);
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

function TadxolControlsEditor.GetRegKey: string;
begin
  try
    {$IFDEF ADX_VCL5}
    Result := DelphiIDE.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
    {$ELSE}
    Result := ComponentDesigner.Environment.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
    {$ENDIF}
  except
  end;
end;

procedure TadxolControlsEditor.LoadProperties;
begin
  try
    with TRegIniFile.Create(GetRegKey) do
    try
      Top := ReadInteger(Collection.ClassName, 'Top', Top);
      Left := ReadInteger(Collection.ClassName, 'Left', Left);
      Width := ReadInteger(Collection.ClassName, 'Width', Width);
      Height := ReadInteger(Collection.ClassName, 'Height', Height);
    finally
      Free;
    end;
  except
  end;
end;

procedure TadxolControlsEditor.DoShow;
begin
  inherited;
  LoadProperties;
end;

procedure TadxolControlsEditor.SaveProperties;
begin
  try
    with TRegIniFile.Create(GetRegKey) do
    try
      WriteInteger(Collection.ClassName, 'Top', Top);
      WriteInteger(Collection.ClassName, 'Left', Left);
      WriteInteger(Collection.ClassName, 'Width', Width);
      WriteInteger(Collection.ClassName, 'Height', Height);
    finally
      Free;
    end;
  except
  end;
end;


{ TadxxlControlsEditor }

constructor TadxxlControlsEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TadxxlControlsEditor.Destroy;
begin
  SaveProperties;
  inherited Destroy;
end;

procedure TadxxlControlsEditor.Loaded;
begin
  inherited Loaded;
  // disable standard Add action
  AddCmd.ShortCut := 0;

  AddCmd.OnExecute := DoNothing;
  DeleteCmd.OnExecute := DeleteClick;
end;

procedure TadxxlControlsEditor.LoadProperties;
begin
  try
    with TRegIniFile.Create(GetRegKey) do
    try
      Top := ReadInteger(Collection.ClassName, 'Top', Top);
      Left := ReadInteger(Collection.ClassName, 'Left', Left);
      Width := ReadInteger(Collection.ClassName, 'Width', Width);
      Height := ReadInteger(Collection.ClassName, 'Height', Height);
    finally
      Free;
    end;
  except
  end;
end;

procedure TadxxlControlsEditor.SaveProperties;
begin
  try
    with TRegIniFile.Create(GetRegKey) do
    try
      WriteInteger(Collection.ClassName, 'Top', Top);
      WriteInteger(Collection.ClassName, 'Left', Left);
      WriteInteger(Collection.ClassName, 'Width', Width);
      WriteInteger(Collection.ClassName, 'Height', Height);
    finally
      Free;
    end;
  except
  end;
end;

procedure TadxxlControlsEditor.DoNothing(Sender: TObject);
begin
  if Sender is TAction then DoAddControl(Sender);
end;

procedure TadxxlControlsEditor.DoShow;
begin
  inherited;
  LoadProperties;
end;

procedure TadxxlControlsEditor.DoAddControl(Sender: TObject);
var
  Item: TListItem;
  PrevCount: Integer;
begin

  SelectNone(False);
  Collection.BeginUpdate;
  try
    PrevCount := Collection.Count + 1;
    TadxExcelTaskPanesCollection(Collection).Add;
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

procedure TadxxlControlsEditor.DeleteClick(Sender: TObject);
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

{ TadxwdControlsEditor }
constructor TadxwdControlsEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TadxwdControlsEditor.Destroy;
begin
  SaveProperties;
  inherited Destroy;
end;

procedure TadxwdControlsEditor.Loaded;
begin
  inherited Loaded;
  // disable standard Add action
  AddCmd.ShortCut := 0;

  AddCmd.OnExecute := DoNothing;
  DeleteCmd.OnExecute := DeleteClick;
end;

function TadxwdControlsEditor.GetRegKey: string;
begin
  try
    {$IFDEF ADX_VCL5}
    Result := DelphiIDE.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
    {$ELSE}
    Result := ComponentDesigner.Environment.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
    {$ENDIF}
  except
  end;
end;

procedure TadxwdControlsEditor.LoadProperties;
begin
  try
    with TRegIniFile.Create(GetRegKey) do
    try
      Top := ReadInteger(Collection.ClassName, 'Top', Top);
      Left := ReadInteger(Collection.ClassName, 'Left', Left);
      Width := ReadInteger(Collection.ClassName, 'Width', Width);
      Height := ReadInteger(Collection.ClassName, 'Height', Height);
    finally
      Free;
    end;
  except
  end;
end;

procedure TadxwdControlsEditor.SaveProperties;
begin
  try
    with TRegIniFile.Create(GetRegKey) do
    try
      WriteInteger(Collection.ClassName, 'Top', Top);
      WriteInteger(Collection.ClassName, 'Left', Left);
      WriteInteger(Collection.ClassName, 'Width', Width);
      WriteInteger(Collection.ClassName, 'Height', Height);
    finally
      Free;
    end;
  except
  end;
end;

procedure TadxwdControlsEditor.DoNothing(Sender: TObject);
begin
  if Sender is TAction then DoAddControl(Sender);
end;

procedure TadxwdControlsEditor.DoShow;
begin
  inherited;
  LoadProperties;
end;

procedure TadxwdControlsEditor.DoAddControl(Sender: TObject);
var
  Item: TListItem;
  PrevCount: Integer;
begin
  SelectNone(False);
  Collection.BeginUpdate;
  try
    PrevCount := Collection.Count + 1;
    TadxWordTaskPanesCollection(Collection).Add;
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

procedure TadxwdControlsEditor.DeleteClick(Sender: TObject);
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

{ TadxppControlsEditor }
constructor TadxppControlsEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TadxppControlsEditor.Destroy;
begin
  SaveProperties;
  inherited Destroy;
end;

procedure TadxppControlsEditor.Loaded;
begin
  inherited Loaded;
  // disable standard Add action
  AddCmd.ShortCut := 0;

  AddCmd.OnExecute := DoNothing;
  DeleteCmd.OnExecute := DeleteClick;
end;

function TadxppControlsEditor.GetRegKey: string;
begin
  try
    {$IFDEF ADX_VCL5}
    Result := DelphiIDE.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
    {$ELSE}
    Result := ComponentDesigner.Environment.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
    {$ENDIF}
  except
  end;
end;

procedure TadxppControlsEditor.LoadProperties;
begin
  try
    with TRegIniFile.Create(GetRegKey) do
    try
      Top := ReadInteger(Collection.ClassName, 'Top', Top);
      Left := ReadInteger(Collection.ClassName, 'Left', Left);
      Width := ReadInteger(Collection.ClassName, 'Width', Width);
      Height := ReadInteger(Collection.ClassName, 'Height', Height);
    finally
      Free;
    end;
  except
  end;
end;

procedure TadxppControlsEditor.SaveProperties;
begin
  try
    with TRegIniFile.Create(GetRegKey) do
    try
      WriteInteger(Collection.ClassName, 'Top', Top);
      WriteInteger(Collection.ClassName, 'Left', Left);
      WriteInteger(Collection.ClassName, 'Width', Width);
      WriteInteger(Collection.ClassName, 'Height', Height);
    finally
      Free;
    end;
  except
  end;
end;

procedure TadxppControlsEditor.DoNothing(Sender: TObject);
begin
  if Sender is TAction then DoAddControl(Sender);
end;

procedure TadxppControlsEditor.DoShow;
begin
  inherited;
  LoadProperties;
end;

procedure TadxppControlsEditor.DoAddControl(Sender: TObject);
var
  Item: TListItem;
  PrevCount: Integer;
begin
  SelectNone(False);
  Collection.BeginUpdate;
  try
    PrevCount := Collection.Count + 1;
    TadxPowerPointTaskPanesCollection(Collection).Add;
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

procedure TadxppControlsEditor.DeleteClick(Sender: TObject);
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

{ Register }

procedure Register;
begin
  //RegisterLibraryExpert(TadxOlFormExpert.Create);
  RegisterPackageWizard(TadxOlFormExpert2.Create);
  RegisterPackageWizard(TadxXlFormExpert2.Create);
  RegisterPackageWizard(TadxWdFormExpert2.Create);
  RegisterPackageWizard(TadxPpFormExpert2.Create);
  RegisterComponents('Add-in Express', [TadxOlFormsManager]);
  RegisterComponents('Add-in Express', [TadxExcelTaskPanesManager]);
  RegisterComponents('Add-in Express', [TadxWordTaskPanesManager]);
  RegisterComponents('Add-in Express', [TadxPowerPointTaskPanesManager]);
  RegisterPropertyEditor(TypeInfo(TadxOlFormsCollection), TadxOlFormsManager, 'Items', TadxOlCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TadxExcelTaskPanesCollection), TadxExcelTaskPanesManager, 'Items', TadxExcelCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TadxWordTaskPanesCollection), TadxWordTaskPanesManager, 'Items', TadxWordCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TadxPowerPointTaskPanesCollection), TadxPowerPointTaskPanesManager, 'Items', TadxPowerPointCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TadxOlFormClassName), TadxOlFormsCollectionItem, 'FormClassName', TadxOlFormClassNameProperty);
  RegisterPropertyEditor(TypeInfo(TadxExcelTaskPaneClassName), TadxExcelTaskPanesCollectionItem, 'TaskPaneClassName', TadxExcelTaskPaneClassNameProperty);
  RegisterPropertyEditor(TypeInfo(TadxWordTaskPaneClassName), TadxWordTaskPanesCollectionItem, 'TaskPaneClassName', TadxWordTaskPaneClassNameProperty);
  RegisterPropertyEditor(TypeInfo(TadxPowerPointTaskPaneClassName), TadxPowerPointTaskPanesCollectionItem, 'TaskPaneClassName', TadxPowerPointTaskPaneClassNameProperty);
  {$IFDEF DELPHI_9_UP}
  RegisterCustomModule(TadxOlForm, TadxOlFormCustomModule);
  RegisterCustomModule(TadxExcelTaskPane, TadxExcelFormCustomModule);
  RegisterCustomModule(TadxWordTaskPane, TadxWordFormCustomModule);
  RegisterCustomModule(TadxPowerPointTaskPane, TadxPowerPointFormCustomModule);
  {$ELSE}
  RegisterCustomModule(TadxOlForm, TCustomModule);
  RegisterCustomModule(TadxExcelTaskPane, TCustomModule);
  RegisterCustomModule(TadxWordTaskPane, TCustomModule);
  RegisterCustomModule(TadxPowerPointTaskPane, TCustomModule);
  {$ENDIF}
  RegisterComponentEditor(TadxOlFormsManager, TadxolModuleEditor);
  RegisterComponentEditor(TadxExcelTaskPanesManager, TadxExcelModuleEditor);
  RegisterComponentEditor(TadxWordTaskPanesManager, TadxWordModuleEditor);
  RegisterComponentEditor(TadxPowerPointTaskPanesManager, TadxPowerPointModuleEditor);
end;

function TadxxlControlsEditor.GetRegKey: string;
begin
  try
    {$IFDEF ADX_VCL5}
    Result := DelphiIDE.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
    {$ELSE}
    Result := ComponentDesigner.Environment.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
    {$ENDIF}
  except
  end;
end;

{ TadxolCollectionProperty }

function TadxolCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxolControlsEditor;
end;

{ TadxxlCollectionProperty }

function TadxExcelCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxxlControlsEditor;
end;

{ TadxwdCollectionProperty }
function TadxWordCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxwdControlsEditor;
end;

{ TadxPowerPointCollectionProperty }
function TadxPowerPointCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TadxppControlsEditor;
end;

{ TadxolFormClassNameProperty }

procedure TadxolFormClassNameProperty.AddItem(const S: string);
begin
  FList.Add('T' + S);
end;

{$IFDEF ADX_VCL5}
constructor TadxolFormClassNameProperty.Create(const ADesigner: IFormDesigner; APropCount: Integer);
{$ELSE}
constructor TadxolFormClassNameProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
{$ENDIF}
begin
  inherited Create(ADesigner, APropCount);
  FList := TStringList.Create;
end;

destructor TadxolFormClassNameProperty.Destroy;
begin
  if Assigned(FList) then begin
    FList.Free;
  end;
  inherited;
end;

function TadxolFormClassNameProperty.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList];
end;

procedure TadxolFormClassNameProperty.GetValues(Proc: TGetStrProc);
var
  XModuleServices: IOTAModuleServices;
  XModule: IOTAModule;
  XModuleInfo: IOTAModuleInfo;
  XProject: IOTAProject;
  XResult: HRESULT;
  XFormName: String;
  i: integer;
begin
  FList.Clear;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TadxOlForm)), AddItem);
  for i := 0 to FList.Count - 1 do begin
    Proc(FList[i]);
  end;

  //Designer.GetComponentNames(GetTypeData(TypeInfo(TadxolForm)), Proc);
  exit;
  if Assigned(BorlandIDEServices) then begin
    XResult:=BorlandIDEServices.QueryInterface(IOTAModuleServices, XModuleServices);
    if (XResult=S_Ok) and Assigned(XModuleServices) then begin
      XModule:=XModuleServices.CurrentModule;
      if Assigned(XModule) and (XModule.GetOwnerCount > 0) then begin
        XProject:=XModule.GetOwner(0);
        if Assigned(XProject) then begin
          for i:=0 to XProject.GetModuleCount-1 do begin
            XModuleInfo:=XProject.GetModule(i);
            if Assigned(XModuleInfo) then begin
              XFormName:=XModuleInfo.FormName;
              if trim(XFormName)<>''
                then Proc(XModuleInfo.FormName);
            end;
          end;
        XProject:=nil;
        end;
      XModule:=nil;
      end;
    XModuleServices:=nil;
    end;
  end;
end;

{ TadxxlFormClassNameProperty }

procedure TadxExcelTaskPaneClassNameProperty.AddItem(const S: string);
begin
  FList.Add('T' + S);
end;

{$IFDEF ADX_VCL5}
constructor TadxExcelTaskPaneClassNameProperty.Create(const ADesigner: IFormDesigner; APropCount: Integer);
{$ELSE}
constructor TadxExcelTaskPaneClassNameProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
{$ENDIF}
begin
  inherited Create(ADesigner, APropCount);
  FList := TStringList.Create;
end;

destructor TadxExcelTaskPaneClassNameProperty.Destroy;
begin
  if Assigned(FList) then begin
    FList.Free;
  end;
  inherited;
end;

function TadxExcelTaskPaneClassNameProperty.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList];
end;

procedure TadxExcelTaskPaneClassNameProperty.GetValues(Proc: TGetStrProc);
var
  XModuleServices: IOTAModuleServices;
  XModule: IOTAModule;
  XModuleInfo: IOTAModuleInfo;
  XProject: IOTAProject;
  XResult: HRESULT;
  XFormName: String;
  i: integer;
begin
  FList.Clear;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TadxExcelTaskPane)), AddItem);
  for i := 0 to FList.Count - 1 do begin
    Proc(FList[i]);
  end;

  //Designer.GetComponentNames(GetTypeData(TypeInfo(TadxolForm)), Proc);
  exit;
  if Assigned(BorlandIDEServices) then begin
    XResult:=BorlandIDEServices.QueryInterface(IOTAModuleServices, XModuleServices);
    if (XResult=S_Ok) and Assigned(XModuleServices) then begin
      XModule:=XModuleServices.CurrentModule;
      if Assigned(XModule) and (XModule.GetOwnerCount > 0) then begin
        XProject:=XModule.GetOwner(0);
        if Assigned(XProject) then begin
          for i:=0 to XProject.GetModuleCount-1 do begin
            XModuleInfo:=XProject.GetModule(i);
            if Assigned(XModuleInfo) then begin
              XFormName:=XModuleInfo.FormName;
              if trim(XFormName)<>''
                then Proc(XModuleInfo.FormName);
            end;
          end;
        XProject:=nil;
        end;
      XModule:=nil;
      end;
    XModuleServices:=nil;
    end;
  end;
end;

{ TadxwdFormClassNameProperty }

procedure TadxWordTaskPaneClassNameProperty.AddItem(const S: string);
begin
  FList.Add('T' + S);
end;

{$IFDEF ADX_VCL5}
constructor TadxWordTaskPaneClassNameProperty.Create(const ADesigner: IFormDesigner; APropCount: Integer);
{$ELSE}
constructor TadxWordTaskPaneClassNameProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
{$ENDIF}
begin
  inherited Create(ADesigner, APropCount);
  FList := TStringList.Create;
end;

destructor TadxWordTaskPaneClassNameProperty.Destroy;
begin
  if Assigned(FList) then begin
    FList.Free;
  end;
  inherited;
end;

function TadxWordTaskPaneClassNameProperty.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList];
end;

procedure TadxWordTaskPaneClassNameProperty.GetValues(Proc: TGetStrProc);
var
  XModuleServices: IOTAModuleServices;
  XModule: IOTAModule;
  XModuleInfo: IOTAModuleInfo;
  XProject: IOTAProject;
  XResult: HRESULT;
  XFormName: String;
  i: integer;
begin
  FList.Clear;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TadxWordTaskPane)), AddItem);
  for i := 0 to FList.Count - 1 do begin
    Proc(FList[i]);
  end;

  //Designer.GetComponentNames(GetTypeData(TypeInfo(TadxolForm)), Proc);
  exit;
  if Assigned(BorlandIDEServices) then begin
    XResult:=BorlandIDEServices.QueryInterface(IOTAModuleServices, XModuleServices);
    if (XResult=S_Ok) and Assigned(XModuleServices) then begin
      XModule:=XModuleServices.CurrentModule;
      if Assigned(XModule) and (XModule.GetOwnerCount > 0) then begin
        XProject:=XModule.GetOwner(0);
        if Assigned(XProject) then begin
          for i:=0 to XProject.GetModuleCount-1 do begin
            XModuleInfo:=XProject.GetModule(i);
            if Assigned(XModuleInfo) then begin
              XFormName:=XModuleInfo.FormName;
              if trim(XFormName)<>''
                then Proc(XModuleInfo.FormName);
            end;
          end;
        XProject:=nil;
        end;
      XModule:=nil;
      end;
    XModuleServices:=nil;
    end;
  end;
end;

{ TadxPowerPointTaskPaneClassNameProperty }

procedure TadxPowerPointTaskPaneClassNameProperty.AddItem(const S: string);
begin
  FList.Add('T' + S);
end;

{$IFDEF ADX_VCL5}
constructor TadxPowerPointTaskPaneClassNameProperty.Create(const ADesigner: IFormDesigner; APropCount: Integer);
{$ELSE}
constructor TadxPowerPointTaskPaneClassNameProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
{$ENDIF}
begin
  inherited Create(ADesigner, APropCount);
  FList := TStringList.Create;
end;

destructor TadxPowerPointTaskPaneClassNameProperty.Destroy;
begin
  if Assigned(FList) then begin
    FList.Free;
  end;
  inherited;
end;

function TadxPowerPointTaskPaneClassNameProperty.GetAttributes: TPropertyAttributes;
begin
  result := [paValueList];
end;

procedure TadxPowerPointTaskPaneClassNameProperty.GetValues(Proc: TGetStrProc);
var
  XModuleServices: IOTAModuleServices;
  XModule: IOTAModule;
  XModuleInfo: IOTAModuleInfo;
  XProject: IOTAProject;
  XResult: HRESULT;
  XFormName: String;
  i: integer;
begin
  FList.Clear;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TadxPowerPointTaskPane)), AddItem);
  for i := 0 to FList.Count - 1 do begin
    Proc(FList[i]);
  end;

  //Designer.GetComponentNames(GetTypeData(TypeInfo(TadxolForm)), Proc);
  exit;
  if Assigned(BorlandIDEServices) then begin
    XResult:=BorlandIDEServices.QueryInterface(IOTAModuleServices, XModuleServices);
    if (XResult=S_Ok) and Assigned(XModuleServices) then begin
      XModule:=XModuleServices.CurrentModule;
      if Assigned(XModule) and (XModule.GetOwnerCount > 0) then begin
        XProject:=XModule.GetOwner(0);
        if Assigned(XProject) then begin
          for i:=0 to XProject.GetModuleCount-1 do begin
            XModuleInfo:=XProject.GetModule(i);
            if Assigned(XModuleInfo) then begin
              XFormName:=XModuleInfo.FormName;
              if trim(XFormName)<>''
                then Proc(XModuleInfo.FormName);
            end;
          end;
        XProject:=nil;
        end;
      XModule:=nil;
      end;
    XModuleServices:=nil;
    end;
  end;
end;


{$IFDEF DELPHI_9_UP}

{ TadxOlFormCustomModule }

class function TadxOlFormCustomModule.DesignClass: TComponentClass;
begin
  Result := TadxOlForm;
end;

class function TadxExcelFormCustomModule.DesignClass: TComponentClass;
begin
  Result := TadxExcelTaskPane;
end;

class function TadxWordFormCustomModule.DesignClass: TComponentClass;
begin
  Result := TadxWordTaskPane;
end;

class function TadxPowerPointFormCustomModule.DesignClass: TComponentClass;
begin
  Result := TadxPowerPointTaskPane;
end;

{$ENDIF}
end.
