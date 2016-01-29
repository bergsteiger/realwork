{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompVCLReg;

interface

procedure Register;

implementation

uses DsnConst, System.Classes,
  // Initialization
  Vcl.Bind.DBEngExt, Vcl.Bind.Editors, Data.Bind.Components, BindCompReg, Vcl.Controls,
  DesignIntf, DesignEditors, Vcl.Bind.Grid, Vcl.Bind.GenData, BindCompEdit, Vcl.Grids,
  System.SysUtils, System.Character, Generics.Collections, BindGridReg,
  Data.Bind.Consts, Vcl.Bind.Navigator, System.Actions, BindCompDsnResStrs,
  BindCompVCLResources, Vcl.ExtCtrls, Data.Bind.Grid, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TContainedBindComponentSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TVCLControlFrameFactory = class(TControlClassFactory)
  public
    function GetEnabled: Boolean; override;
    function IsControl(AComponent: TComponent): Boolean; override;
    function ControlClasses: TArray<TComponentClass>; override;
    function GetControlType(AComponentClass: TComponentClass): string; override;
    function CreateControl(AClass: TComponentClass; AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent; override;
    function SupportsOption(AClass: TComponentClass; AOption: TControlClassFactory.TOption): Boolean; override;
//    procedure ApplyOption(AComponent: TComponent; AOptions: TControlClassFactory.TOptions; AProperties: TStrings); override;
  end;

  TVCLNavigatorFactory = class(TNavigatorFactory)
  protected
    function IsNavigatorFor(AComponent1, AComponent2: TComponent): Boolean; override;
    function GetEnabled: Boolean; override;
  public
    function CreateControl(AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent; override;
  end;

const
 sDfm = 'dfm';

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
          Proc('Vcl.Bind.Editors');
          Exit;
        end;
    end;
  end;
end;

{ TVCLControlFrameFactory }


function TVCLControlFrameFactory.ControlClasses: TArray<TComponentClass>;
var
  LList: TList<TComponentClass>;
  LComponentClass: TComponentClass;
begin
  LList := TList<TComponentClass>.Create;
  try
    LList.AddRange(Data.Bind.Components.GetControlValueClasses(sDfm, True)); // Do not localize
    for LComponentClass in GetGridClasses(sDfm) do
      if not LList.Contains(LComponentClass) then
        LList.Add(LComponentClass);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TVCLControlFrameFactory.CreateControl(AClass: TComponentClass; AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent;
var
  LControl: TControl;
  LControlClass: TComponentClass;
  LName: string;
  LCaption: string;
  LLabeledEdit: TCustomLabeledEdit;
begin
  Result := nil;
  LControlClass := AClass;
  if LControlClass <> nil then
  begin
    LControl := Designer.CreateComponent(LControlClass, Designer.Root, 0, 0, 0, 0) as TControl;
    if TControlClassFactory.TOption.optSuffix in AOptions then
    begin
//      LName := LControl.Name;
//      while (Length(LName) > 0) and (IsDigit(LName[Length(LName)])) do
//        Delete(LName, Length(LName), 1);
//      LName := LName + AProperties.Values[TControlClassFactory.sSuffix];
      LName := LControl.Name;
      while (Length(LName) > 0) and (LName[Length(LName)].IsDigit) do
        Delete(LName, Length(LName), 1);
      LName := BindCompReg.CreateUniqueComponentName(Designer.Root,
        LName, AProperties.Values[TControlClassFactory.sSuffix]);
      if Designer.Root.FindComponent(LName) = nil then
        LControl.Name := LName;
    end;
    Result := LControl;
    //if TControlClassFactory.TOption.optLabel in AOptions then
    begin
      if LControl is TCustomLabeledEdit then
      begin
        LLabeledEdit := TCustomLabeledEdit(LControl);
        if AProperties <> nil then
          LCaption := AProperties.Values[sLabelCaption];
        if LCaption <> '' then
         LLabeledEdit.EditLabel.Caption := LCaption;
      end;
    end;
  end;
end;


//function TVCLControlFrameFactory.CreateControl(AClass: TComponentClass; AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent;
//var
//  LControl: TControl;
//  LLabel: TLabel;
//  LControlClass: TComponentClass;
//  LCaption: string;
//  LName: string;
//begin
//  Result := nil;
//  LControlClass := AClass;
//  if LControlClass <> nil then
//  begin
//    LControl := Designer.CreateComponent(LControlClass, Designer.Root, 0, 0, 0, 0) as TControl;
//    if TControlClassFactory.TOption.optSuffix in AOptions then
//    begin
//      LName := LControl.Name;
//      while (Length(LName) > 0) and (IsDigit(LName[Length(LName)])) do
//        Delete(LName, Length(LName), 1);
//      LName := LName + AProperties.Values[TControlClassFactory.sSuffix];
//      if Designer.Root.FindComponent(LName) = nil then
//        LControl.Name := LName;
//    end;
//    Result := LControl;
//    if TControlClassFactory.TOption.optLabel in AOptions then
//    begin
//      LLabel := Designer.CreateComponent(TLabel, nil, 0, 0, 0, 0) as TLabel;
//      LLabel.Parent := LControl;
//      LLabel.Position.Y := 1.0 - LLabel.Height;
//      LLabel.Position.X := 0;
//      LLabel.WordWrap := False;
//      if AProperties <> nil then
//        LCaption := AProperties.Values[sLabelCaption];
//      if LCaption = '' then
//        LLabel.Text := LControl.Name
//      else
//        LLabel.Text := LCaption;
//    end;
//  end;
//end;

function TVCLControlFrameFactory.GetControlType(
  AComponentClass: TComponentClass): string;
var
  LComponentClass: TComponentClass;
begin
  for LComponentClass in GetGridClasses(sDfm) do
    if LComponentClass = AComponentClass then
      Exit(TControlClassFactory.TControlTypes.sGrid);
  Result := TControlClassFactory.TControlTypes.sStandard;

end;

function TVCLControlFrameFactory.GetEnabled: Boolean;
begin
  Result := SameText(Designer.DesignerExtention, sDfm);
end;

function TVCLControlFrameFactory.IsControl(AComponent: TComponent): Boolean;
var
  LPropertyName: string;
  LWritable: Boolean;
begin
  Result := (GetControlType(TComponentClass(AComponent.ClassType)) = TControlClassFactory.TControlTypes.sGrid)
  or (GetControlValuePropertyName(AComponent, LPropertyName, LWritable) and LWritable);
end;

function TVCLControlFrameFactory.SupportsOption(AClass: TComponentClass;
  AOption: TControlClassFactory.TOption): Boolean;
begin
  Result := False;
  case AOption of
    optNoLabel:
      if AClass.InheritsFrom(TCustomLabeledEdit) then
        Result := False
      else
        Result := True;
    optLabel:
      if AClass.InheritsFrom(TCustomLabeledEdit) then
        Result := True
      else
        Result := False;
    optSuffix:
      Result := True;
  else
    Assert(False);
  end;
end;

//procedure TVCLControlFrameFactory.ApplyOption(AComponent: TComponent; AOptions: TControlClassFactory.TOptions; AProperties: TStrings);
//begin
//  Assert(False);
//end;

{ TVCLNavigatorFactory }

function TVCLNavigatorFactory.CreateControl(AOptions: TControlClassFactory.TOptions; AProperties: TStrings): TComponent;
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

function TVCLNavigatorFactory.GetEnabled: Boolean;
begin
  Result := SameText(Self.Designer.DesignerExtention, sDfm);
end;

function TVCLNavigatorFactory.IsNavigatorFor(AComponent1,
  AComponent2: TComponent): Boolean;
begin
  if AComponent1 is TBindNavigator then
    Result := TBindNavigator(AComponent1).DataSource = AComponent2
  else
    Result := False;

end;

procedure Register;
begin
  ForceDemandLoadState(dlDisable); // Always register factories
  RegisterControlFrameFactory(TVCLControlFrameFactory); // Create wizard page to create control
  RegisterControlFrameFactory(TVCLNavigatorFactory);   // Create TBindNavigator

  RegisterComponents(SBindingComponentsCategory, [TBindNavigator]);

  RegisterSelectionEditor(TContainedBindComponent, TContainedBindComponentSelectionEditor);
  // Add "Live Bindings" to controls
  RegisterSelectionEditor(Vcl.Controls.TControl, TAddDataBindingsPropertyFilter);
  // Verbs to add data bindings
  RegisterSelectionEditor(Vcl.Controls.TControl, TBindCompFactorySelectionEditor);

  // Add "Columns..." verb to grids referenced by TLinkGridToDataSource
  RegisterSelectionEditor(TCustomGrid, TLinkGridToDataSourceGridSelectionEditor);

  // Add "Fill List..." verb to list control referenced by TLinkGridToDataSource
  RegisterSelectionEditor(TCustomListBox, TLinkFillSelectionEditor);
  RegisterSelectionEditor(TCustomListView, TLinkFillSelectionEditor);

  RegisterPropertyEditor(TypeInfo(TBaseLinkingBindSource), TBindNavigator, 'DataSource', TLinkingBindScopePropertyEditor);

  RegisterActions('LiveBindings', [TBindNavigateFirst, TBindNavigatePrior, TBindNavigateNext,
    TBindNavigateLast, TBindNavigateInsert, TBindNavigateDelete, TBindNavigateEdit, TBindNavigatePost,
    TBindNavigateCancel, TBindNavigateRefresh, TBindNavigateApplyUpdates, TBindNavigateCancelUpdates],
    TBindSourceActions);

end;

end.

