{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompFMXReg;

interface

uses System.Classes, System.Generics.Collections, Data.Bind.Components, Data.Bind.DBLinks;

type
 TDBBindLinkAssocations = class
  private
    class var FAssociations: TDictionary<TContainedBindCompClass, TList<TComponentClass>>;
  public
    class constructor Create;
    class destructor Destroy;
    class function SupportedBindings(
      AControl: TComponent): TArray<TContainedBindCompClass>; static;
    class procedure AddAssociation(ABindCompType: TContainedBindCompClass;
      AControlType: TComponentClass);
    class procedure AddAssociations(
      const ABindCompTypes: array of TContainedBindCompClass;
      const AControlTypes: array of TComponentClass);
    class procedure RemoveAssociations(
      const ABindCompTypes: array of TContainedBindCompClass);
    class procedure RemoveAssociation(
      ABindCompType: TContainedBindCompClass);
    class function SupportsControl(
      ABindLink: TContainedBindComponent;
      AControl: TComponent;
      out AHasAssociations: Boolean): Boolean; overload;
    class function SupportsControl(
      ABindLinkClass: TContainedBindCompClass;
      AControl: TComponent;
      out AHasAssociations: Boolean): Boolean; overload;


  end;

procedure Register;

implementation

uses DsnConst, System.UITypes, Fmx.Bind.Navigator, Data.Bind.Consts, Fmx.Bind.DBLinks,
  // Initialization
  Fmx.Bind.DBEngExt, Fmx.Bind.Editors, BindCompReg, DesignIntf, FMX.Types,
  BindCompDsnResStrs,  BindCompNewDBLinkForm, Data.Bind.DBScope,
  System.Character, Data.DB,
  FMX.Controls, FMX.Dialogs, FMX.Edit, FMX.Layouts, FMX.ListBox, FMX.ListView, FMX.StdCtrls,
  FMX.Memo,  FMX.Grid, VCL.Forms, DesignEditors, System.TypInfo, System.SysUtils,
  BindCompDesigners, BindCompDBReg, BindCompEdit,
  Fmx.Colors, FMX.Bind.Grid, BindGridReg, Data.Bind.Grid,
  Fmx.Bind.GenData, System.Actions, BindCompFMXResources; // register

type

  TBindFMXDBControlSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TBindDBControlProperty = class(TComponentProperty)
  private
    FTempStrings: TStrings;
    procedure AddTempString(const S: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TFMXControlFrameFactory = class(TControlClassFactory)
  public
    function GetEnabled: Boolean; override;
    function IsControl(AComponent: TComponent): Boolean; override;
    function ControlClasses: TArray<TComponentClass>; override;
    function GetControlType(AComponentClass: TComponentClass): string; override;
    function CreateControl(AClass: TComponentClass; AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent; override;
    function SupportsOption(AClass: TComponentClass; AOption: TControlClassFactory.TOption): Boolean; override;
  end;

  TFMXNavigatorFactory = class(TNavigatorFactory)
  protected
    function IsNavigatorFor(AComponent1, AComponent2: TComponent): Boolean; override;
    function GetEnabled: Boolean; override;
  public
    function CreateControl(AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent; override;
  end;

const
  sFmx = 'fmx';

procedure RegisterDBBindLinkAssociations(
  const ABindCompTypes: array of TContainedBindCompClass;
  const AControlTypes: array of TComponentClass); forward;

procedure RegisterDBBindLinkAssociations(
  const ABindCompTypes: array of TContainedBindCompClass;
  const AControlTypes: array of TComponentClass);
begin
  TDBBindLinkAssocations.AddAssociations(ABindCompTypes,
    AControlTypes);
end;

class procedure TDBBindLinkAssocations.AddAssociation
  (ABindCompType: TContainedBindCompClass; AControlType: TComponentClass);
var
  LList: TList<TComponentClass>;
begin
  if not FAssociations.TryGetValue(ABindCompType,
    LList) then
  begin
    LList := TList<TComponentClass>.Create;
    FAssociations.Add(ABindCompType, LList);
  end;
  LList.Add(AControlType);
end;


class procedure TDBBindLinkAssocations.AddAssociations
  (const ABindCompTypes: array of TContainedBindCompClass; const AControlTypes: array of TComponentClass);
var
  LBindCompClass: TContainedBindCompClass;
  LControlClass: TComponentClass;
begin
  for LBindCompClass in ABindCompTypes do
    for LControlClass in AControlTypes do
      TDBBindLinkAssocations.AddAssociation(LBindCompClass,
        LControlClass);
end;

{ TDBBindLinkAssocations }

class constructor TDBBindLinkAssocations.Create;
begin
  FAssociations := TObjectDictionary<TContainedBindCompClass, TList<TComponentClass>>.Create([doOwnsValues]);

end;

class destructor TDBBindLinkAssocations.Destroy;
begin
  FAssociations.Free;

end;

class procedure TDBBindLinkAssocations.RemoveAssociation(
  ABindCompType: TContainedBindCompClass);
begin
  if FAssociations.ContainsKey(ABindCompType) then
    FAssociations.Remove(ABindCompType);

end;

class procedure TDBBindLinkAssocations.RemoveAssociations(
  const ABindCompTypes: array of TContainedBindCompClass);
var
  LBindCompClass: TContainedBindCompClass;
begin
  for LBindCompClass in ABindCompTypes do
    RemoveAssociation(LBindCompClass);
end;

class function TDBBindLinkAssocations.SupportsControl(
  ABindLinkClass: TContainedBindCompClass; AControl: TComponent;
  out AHasAssociations: Boolean): Boolean;
var
  LList: TList<TComponentClass>;
  LControlClass: TComponentClass;
begin
  AHasAssociations := False;
  Result := False;
  if FAssociations.TryGetValue(ABindLinkClass,
    LList) then
  begin
    AHasAssociations := True;
    for LControlClass in LList do
    begin
      if AControl.ClassType.InheritsFrom(LControlClass) then
        Exit(True);
    end;
  end;
end;

class function TDBBindLinkAssocations.SupportsControl(
  ABindLink: TContainedBindComponent; AControl: TComponent;
  out AHasAssociations: Boolean): Boolean;
begin
  Result := SupportsControl(TContainedBindCompClass(ABindLink.ClassType),
    AControl, AHasAssociations);
end;

class function TDBBindLinkAssocations.SupportedBindings(
  AControl: TComponent): TArray<TContainedBindCompClass>;
var
//  LList: TList<TComponentClass>;
  LControlClass: TComponentClass;
  LResult: TList<TContainedBindCompClass>;
  LPair: TPair<TContainedBindCompClass, TList<TComponentClass>>;
begin
  LResult := TList<TContainedBindCompClass>.Create;
  try
    for LPair in FAssociations do
    begin
      for LControlClass in LPair.Value do
      begin
        if AControl.ClassType.InheritsFrom(LControlClass) then
          LResult.Add(LPair.Key);
      end;
    end;
    Result := LResult.ToArray;
  finally
    LResult.Free;
  end;
end;

procedure UnregisterDBBindLinkAssociations(
  const ABindCompTypes: array of TContainedBindCompClass);
var
  LBindCompClass: TContainedBindCompClass;
begin
  for LBindCompClass in ABindCompTypes do
    TDBBindLinkAssocations.RemoveAssociations(LBindCompClass)
end;



type
  THasExistingDBLink = class
  private
    FStrings: TStrings;
    procedure AddString(const S: string);
  public
    constructor Create;
    destructor Destroy; override;
    function HasExistingDBLink(ADesigner: IDesigner; AControl: TComponent): Boolean;
  end;

constructor THasExistingDBLink.Create;
begin
  FStrings := TStringList.Create;
end;

procedure THasExistingDBLink.AddString(const S: string);
begin
  FStrings.Add(S);
end;

function  THasExistingDBLink.HasExistingDBLink(ADesigner: IDesigner; AControl: TComponent): Boolean;
var
  S: string;
  LDataBinding: TBaseBindDBControlLink;
begin
  FStrings.Clear;
  ADesigner.GetComponentNames(GetTypeData(TypeInfo(TBaseBindDBControlLink)), AddString);
  for S in FStrings do
  begin
    LDataBinding := TBaseBindDBControlLink(ADesigner.GetComponent(S));
    if LDataBinding.ControlComponent = AControl then
      Exit(True);
  end;
  Result := False;
end;

destructor THasExistingDBLink.Destroy;
begin
  inherited;
  FStrings.Free;
end;


{ TBindDBControlProperty }


procedure TBindDBControlProperty.AddTempString(const S: string);
begin
  FTempStrings.Add(S);
end;

procedure TBindDBControlProperty.GetValues(Proc: TGetStrProc);
var
  LComponent: TComponent;
  LHasAssociations: Boolean;
  LBindComponent: TContainedBindComponent;
  S: string;
begin
  if not (GetComponent(0) is TContainedBindComponent) then
  begin
    inherited GetValues(Proc);
    Exit;
  end;
  LBindComponent := TContainedBindComponent(GetComponent(0));
  FTempStrings := TStringList.Create;
  try
    Designer.GetComponentNames(GetTypeData(GetPropType), AddTempString);
    for S in FTempStrings do
    begin
      LComponent := Designer.GetComponent(S) as TComponent;
      if TDBBindLinkAssocations.SupportsControl(LBindComponent,
        LComponent, LHasAssociations) or (not LHasAssociations) then
        Proc(S);
    end;
  finally
    FTempStrings.Free;
  end;

end;

type
  TBindDBFieldLinkDesignerFMX_NoParse = class(TBindDBFieldLinkDesigner_NoParse)
  protected
    function CanBindComponent(ADataBindingClass: TContainedBindCompClass; AComponent: TComponent;
    ADesigner: IInterface): Boolean; override;
  end;

  TBindDBFieldLinkDesignerFMX = class(TBindDBFieldLinkDesigner)
  protected
    function CanBindComponent(ADataBindingClass: TContainedBindCompClass; AComponent: TComponent;
    ADesigner: IInterface): Boolean; override;
  end;

type
  TContainedBindComponentSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure TContainedBindComponentSelectionEditor.RequiresUnits(Proc: TGetStrProc);
var
  I: Integer;
  LContainedBindComponent: TContainedBindComponent;
begin
  for I := 0 to Designer.Root.ComponentCount - 1 do
  begin
    if Designer.Root.Components[i] is TContainedBindComponent then
    begin
      LContainedBindComponent := TContainedBindComponent(Designer.Root.Components[i]);
      if Assigned(LContainedBindComponent.ControlComponent) then
        if LContainedBindComponent.ControlComponent is TControl then
        begin
          Proc('Fmx.Bind.Editors');
          Exit;
        end;
    end;
  end;
end;


procedure Register;
const
  sFieldName = 'FieldName';
begin
  ForceDemandLoadState(dlDisable); // Always register factories
  RegisterControlFrameFactory(TFMXControlFrameFactory); // Create wizard page to create control
  RegisterControlFrameFactory(TFMXNavigatorFactory);   // Create TBindNavigator

  RegisterComponents(SBindingComponentsCategory, [TBindNavigator]);

  RegisterNoIcon([TBindDBEditLink, TBindDBTextLink, TBindDBListLink,
    TBindDBImageLink, TBindDBMemoLink, TBindDBCheckLink, TBindDBGridLink]);
  RegisterBindComponents(SDataBindingsCategory_DBLinks,
    [TBindDBEditLink, TBindDBTextLink, TBindDBListLink,
    TBindDBImageLink, TBindDBMemoLink, TBindDBCheckLink, TBindDBGridLink]);
  GroupDescendentsWith(TBaseBindDBFieldControlLink, TFmxObject);
  GroupDescendentsWith(TBaseBindDBGridControlLink, TFmxObject);

  RegisterDBBindLinkAssociations(
    [TBindDBEditLink],
    [TCustomEdit]);
  RegisterDBBindLinkAssociations(
    [TBindDBTextLink],
    [TLabel]);
  RegisterDBBindLinkAssociations(
    [TBindDBListLink],
    [TListBox, TComboBox]);
  RegisterDBBindLinkAssociations(
    [TBindDBMemoLink],
    [TMemo]);
  RegisterDBBindLinkAssociations(
    [TBindDBCheckLink],
    [TCheckBox]);
  RegisterDBBindLinkAssociations(
    [TBindDBImageLink],
    [TImageControl]);
  RegisterDBBindLinkAssociations(
    [TBindDBGridLink],
    //[TStringGrid, TGrid]);
    [TStringGrid]);

  RegisterBindCompDesigner(TCustomBindDBTextLink, TBindDBFieldLinkDesignerFMX_NoParse.Create);
  RegisterBindCompDesigner(TCustomBindDBImageLink, TBindDBFieldLinkDesignerFMX_NoParse.Create);
  RegisterBindCompDesigner(TBaseBindDBFieldControlLink, TBindDBFieldLinkDesignerFMX.Create);
  RegisterBindCompDesigner(TBaseBindDBGridControlLink, TBindDBFieldLinkDesignerFMX.Create);

  // Remove Link to Field... from object inspector/popup menu
  // RegisterBindCompFactory(TBindDBLinkDialogFactory.Create);

  // Filter controls in drop down list
  RegisterPropertyEditor(TypeInfo(TStyledControl), TCustomBindDBEditLink, 'EditControl',
    TBindDBControlProperty);
  RegisterPropertyEditor(TypeInfo(TStyledControl), TCustomBindDBTextLink, 'TextControl',
    TBindDBControlProperty);
  RegisterPropertyEditor(TypeInfo(TStyledControl), TCustomBindDBListLink, 'ListControl',
    TBindDBControlProperty);
  RegisterPropertyEditor(TypeInfo(TStyledControl), TCustomBindDBMemoLink, 'MemoControl',
    TBindDBControlProperty);
  RegisterPropertyEditor(TypeInfo(TStyledControl), TCustomBindDBCheckLink, 'CheckControl',
    TBindDBControlProperty);
  RegisterPropertyEditor(TypeInfo(TStyledControl), TCustomBindDBImageLink, 'ImageControl',
    TBindDBControlProperty);
  RegisterPropertyEditor(TypeInfo(TStyledControl), TCustomBindDBGridLink, 'GridControl',
    TBindDBControlProperty);

  // Add BindingsList used methods/converters required units to the uses list
  RegisterSelectionEditor(TBaseBindDBFieldControlLink, TBindFMXDBControlSelectionEditor);
  RegisterSelectionEditor(TBaseBindDBGridControlLink, TBindFMXDBControlSelectionEditor);

  RegisterComponentEditor(TBindDBGridLink, TBindDBGridLinkEditor);

  // Add "Live Bindings" to controls
  RegisterSelectionEditor(Fmx.Controls.TControl, TAddDataBindingsPropertyFilter);
  // Verbs to add data bindings
  RegisterSelectionEditor(Fmx.Types.TFmxObject, TBindCompFactorySelectionEditor);

  // Add "Columns..." verb to grids referenced by TDBGridLink
  RegisterSelectionEditor(TCustomGrid, TBindDBGridColumnsSelectionEditor);

  // Add "Columns..." verb to grids referenced by TLinkGridToDataSource
  RegisterSelectionEditor(TCustomGrid, TLinkGridToDataSourceGridSelectionEditor);

  // Add "Fill List..." verb to list control referenced by TLinkGridToDataSource
  RegisterSelectionEditor(TCustomListBox, TLinkFillSelectionEditor);

  // Add "Fill List..." verb to list control referenced by TLinkGridToDataSource
  RegisterSelectionEditor(TCustomListView, TLinkFillSelectionEditor);

  // Use Fmx.Bind.Editors
  RegisterSelectionEditor(TContainedBindComponent, TContainedBindComponentSelectionEditor);

  RegisterPropertyEditor(TypeInfo(TBaseLinkingBindSource), TBindNavigator, 'DataSource', TLinkingBindScopePropertyEditor);

  RegisterActions('LiveBindings', [TFMXBindNavigateFirst, TFMXBindNavigatePrior, TFMXBindNavigateNext,
    TFMXBindNavigateLast, TFMXBindNavigateInsert, TFMXBindNavigateDelete, TFMXBindNavigateEdit, TFMXBindNavigatePost,
    TFMXBindNavigateCancel, TFMXBindNavigateRefresh, TFMXBindNavigateApplyUpdates, TFMXBindNavigateCancelUpdates],
    TFMXBindSourceActions);

end;


{ TBindDBControlSelectionEditor }

procedure TBindFMXDBControlSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('Fmx.Bind.Editors');
  Proc('Fmx.Bind.DBEngExt');
  // Proc('Data.Bind.EngExt');  // Added by other selection editor
end;

{ TBindDBFieldLinkDesignerFMX_NoParse }

function TBindDBFieldLinkDesignerFMX_NoParse.CanBindComponent(
  ADataBindingClass: TContainedBindCompClass; AComponent: TComponent;
    ADesigner: IInterface): Boolean;
var
  LHasAssociations: Boolean;
begin
  Result := TDBBindLinkAssocations.SupportsControl(
    ADataBindingClass, AComponent, LHasAssociations);
  if Result then
    with THasExistingDBLink.Create do
    try
      Result := not HasExistingDBLink(ADesigner as IDesigner, AComponent);
    finally
      Free;
    end;
end;

{ TBindDBFieldLinkDesignerFMX }

function TBindDBFieldLinkDesignerFMX.CanBindComponent(
  ADataBindingClass: TContainedBindCompClass; AComponent: TComponent;
    ADesigner: IInterface): Boolean;
var
  LHasAssociations: Boolean;
begin
  Result := TDBBindLinkAssocations.SupportsControl(
    ADataBindingClass, AComponent, LHasAssociations);
  if Result then
    with THasExistingDBLink.Create do
    try
      Result := not HasExistingDBLink(ADesigner as IDesigner, AComponent);
    finally
      Free;
    end;
end;


{ TFXMControlFrameFactory }


function TFMXControlFrameFactory.ControlClasses: TArray<TComponentClass>;
var
  LList: TList<TComponentClass>;
  LComponentClass: TComponentClass;
begin
  LList := TList<TComponentClass>.Create;
  try
    LList.AddRange(Data.Bind.Components.GetControlValueClasses(sFmx, True)); // Do not localize
    for LComponentClass in GetGridClasses(sFmx) do
      if not LList.Contains(LComponentClass) then
        LList.Add(LComponentClass);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure RenameControl(const ADesigner: IDesigner; AControl: TControl; const ASuffix: string);
var
  LName: string;
begin
  LName := AControl.Name;
  while (Length(LName) > 0) and (LName[Length(LName)].IsDigit) do
    Delete(LName, Length(LName), 1);
  LName := BindCompReg.CreateUniqueComponentName(ADesigner.Root,
    LName, ASuffix);
  if ADesigner.Root.FindComponent(LName) = nil then
    AControl.Name := LName;
end;

function TFMXControlFrameFactory.CreateControl(AClass: TComponentClass; AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent;
var
  LControl: TControl;
  LLabel: TLabel;
  LControlClass: TComponentClass;
  LCaption: string;
begin
  Result := nil;
  LControlClass := AClass;
  if LControlClass <> nil then
  begin
    LControl := Designer.CreateComponent(LControlClass, Designer.Root, 0, 0, 0, 0) as TControl;
    if TControlClassFactory.TOption.optSuffix in AOptions then
      RenameControl(Designer, LControl, AProperties.Values[TControlClassFactory.sSuffix]);
    Result := LControl;
    if TControlClassFactory.TOption.optLabel in AOptions then
    begin
      LLabel := Designer.CreateComponent(TLabel, nil, 0, 0, 0, 0) as TLabel;
      if TControlClassFactory.TOption.optSuffix in AOptions then
        RenameControl(Designer, LLabel, AProperties.Values[TControlClassFactory.sSuffix]);
      LLabel.Parent := LControl;
      LLabel.Position.Y := 1.0 - LLabel.Height;
      LLabel.Position.X := 0;
      LLabel.WordWrap := False;
      if AProperties <> nil then
        LCaption := AProperties.Values[sLabelCaption];
      if LCaption = '' then
        LLabel.Text := LControl.Name
      else
        LLabel.Text := LCaption;
    end;
  end;
end;

function TFMXControlFrameFactory.GetControlType(
  AComponentClass: TComponentClass): string;
var
  LComponentClass: TComponentClass;
begin
  for LComponentClass in GetGridClasses(sFmx) do
    if LComponentClass = AComponentClass then
      Exit(TControlClassFactory.TControlTypes.sGrid);
  Result := TControlClassFactory.TControlTypes.sStandard;

end;

function TFMXControlFrameFactory.GetEnabled: Boolean;
begin
  Result := SameText(Designer.DesignerExtention, sFmx);
end;

function TFMXControlFrameFactory.IsControl(AComponent: TComponent): Boolean;
var
  LPropertyName: string;
  LWritable: Boolean;
begin
  Result := (GetControlType(TComponentClass(AComponent.ClassType)) = TControlClassFactory.TControlTypes.sGrid)
  or (GetControlValuePropertyName(AComponent, LPropertyName, LWritable) and LWritable);
end;


function TFMXControlFrameFactory.SupportsOption(AClass: TComponentClass;
  AOption: TControlClassFactory.TOption): Boolean;
begin
  Result := False;
  case AOption of
    optNoLabel:
      Result := True;
    optLabel:
      // Adding a label to a grid interferes will columns
      Result := not AClass.InheritsFrom(TCustomGrid);
    optSuffix:
      Result := True;
  else
    Assert(False);
  end;

end;

//procedure TFMXControlFrameFactory.ApplyOption(AComponent: TComponent; AOptions: TControlClassFactory.TOptions; AProperties: TStrings);
//begin
//  Assert(False);
//end;

{ TFMXNavigatorFactory }

function TFMXNavigatorFactory.CreateControl(AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent;
var
  LControl: TBindNavigator;
  LControlClass: TComponentClass;
  LName: string;
begin
  Result := nil;
  LControlClass := TBindNavigator;
  if LControlClass <> nil then
  begin
    LControl := Self.Designer.CreateComponent(LControlClass, Designer.Root, 0, 0, 0, 0) as TBindNavigator;
    if TControlClassFactory.TOption.optSuffix in AOptions then
    begin
      LName := 'Navigator' + AProperties.Values[TControlClassFactory.sSuffix];
      if Designer.Root.FindComponent(LName) = nil then
        LControl.Name := LName;
    end;
    LControl.DataSource := Self.BindScope;
    Designer.Modified;
    Result := LControl;
  end;
end;

function TFMXNavigatorFactory.GetEnabled: Boolean;
begin
  Result := SameText(Self.Designer.DesignerExtention, sFmx);
end;

function TFMXNavigatorFactory.IsNavigatorFor(AComponent1,
  AComponent2: TComponent): Boolean;
begin
  if AComponent1 is TBindNavigator then
    Result := TBindNavigator(AComponent1).DataSource = AComponent2
  else
    Result := False;

end;

end.
