{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompDBReg;

interface

uses  System.Classes, Data.Bind.DBLinks, BindCompReg,
  Data.Bind.Components, DesignEditors, DesignIntf;

procedure Register;

{$DEFINE RENAMEBINDSCOPEDB} // Temporary

type
  TBindDBGridColumnsSelectionEditor = class(TSelectionEditor)
  private
    FGridLink: TBaseBindDBGridLink;
    FTempStringList: TStrings;
    procedure AddTempString(const S: string);
  protected
    function GetCollection(AGridLink: TBaseBindDBGridLink): TCollection; virtual;
    function GetPropertyName(AGridLink: TBaseBindDBGridLink): string; virtual;
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer; const List: IDesignerSelections); override;
    constructor Create(const ADesigner: IDesigner); override;
  end;

  TBindDBGridLinkEditor = class(TBindCompExpressionEditor)
  protected
    function GetCollection(AGridLink: TBaseBindDBGridLink): TCollection;  virtual;
    function GetPropertyName(AGridLink: TBaseBindDBGridLink): string; virtual;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


implementation

uses ToolsApi, DsnConst, Data.Bind.DBScope, Data.Bind.Consts,
  ColnEdit, BindDbColEd, BindCompDsnResStrs,
  BindCompDesigners, TypInfo, System.SysUtils;

type
  TBindDBGridLinkDesigner = class(TBindCompDelegateDesigner)
  protected
    function GetDelegate(ADataBinding: TContainedBindComponent): TContainedBindComponent; override;
  end;

  TBindDBGridLinkColumnsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;


type
  TBaseBindDBGridLinkWrapper = class(TBaseBindDBGridLink)

  end;
procedure TBindDBGridLinkEditor.ExecuteVerb(Index: Integer);
begin
  case Index - inherited GetVerbCount of
    0:
    ShowCollectionEditorClass(Designer, TBindDBGridColumnsEditor, Component,
      GetCollection(Component as TBaseBindDBGridLink),
      GetPropertyName(Component as TBaseBindDBGridLink));
  else
    inherited ExecuteVerb(Index);
  end;
end;

function TBindDBGridLinkEditor.GetVerb(Index: Integer): string;
begin
  case Index - inherited GetVerbCount of
    0:
     Result := SDBGridColEditor;
  else
    Result := inherited GetVerb(Index);
  end
end;

function TBindDBGridLinkEditor.GetCollection(AGridLink: TBaseBindDBGridLink): TCollection;
begin
  Result := TBaseBindDBGridLinkWrapper(AGridLink).GetColumns;
end;

function TBindDBGridLinkEditor.GetPropertyName(AGridLink: TBaseBindDBGridLink): string;
begin
 Result := 'Columns'; // Do not localize
end;

function TBindDBGridLinkEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1;
end;

procedure TBindDBGridLinkColumnsProperty.Edit;
begin
  ShowCollectionEditorClass(Designer, TBindDBGridColumnsEditor,
    GetComponent(0) as TComponent, TBaseDBGridLinkColumns(GetOrdValue), GetName);
end;

function TBindDBGridLinkColumnsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly{$IFDEF LINUX}, paVCL{$ENDIF}];
end;


{ TBindDBGridLinkDesigner }

function TBindDBGridLinkDesigner.GetDelegate(
  ADataBinding: TContainedBindComponent): TContainedBindComponent;
var
  LComponent: TBaseBindDBGridLink;
begin
  LComponent := ADataBinding as TBaseBindDBGridLink;
  Result := LComponent.BindGridLink;
end;

procedure Register;
begin
{$IFDEF RENAMEBINDSCOPEDB}
  RegisterClasses([TBindScopeDB]);
  //RegisterNoIcon([TBindScopeDB]);
  RegisterComponents(SBindingComponentsCategory, [TBindSourceDB]);
{$ELSE}
  RegisterComponents(SBindingComponentsCategory, [TBindScopeDB]);
{$ENDIF}

  // Bind DB components
  RegisterComponentEditor(TBaseBindDBFieldLink, TBindCompExpressionEditor);
  RegisterComponentEditor(TBaseBindDBGridLink, TBindCompExpressionEditor);
  RegisterPropertyEditor(TypeInfo(string), TBaseBindDBFieldLink, 'FieldName', TFieldNamePropertyEditor);
  RegisterBindCompDesigner(TBaseBindDBFieldLink, TBindDBFieldLinkDesigner.Create);
  RegisterBindCompDesigner(TBaseBindDBGridLink, TBindDBGridLinkDesigner.Create);

  RegisterPropertyEditor(TypeInfo(TBaseDBGridLinkColumns), TBaseBindDBGridLink, '', TBindDBGridLinkColumnsProperty);
  RegisterPropertyEditor(TypeInfo(string), TBaseDBGridLinkColumn, 'FieldName', TFieldNamePropertyEditor);

end;

{ TBindDBGridColumnsSelectionEditor }


// Update on demand to improve prerformance of code insite.
procedure UpdateGridLink(AEditor: TBindDBGridColumnsSelectionEditor);
var
  I: Integer;
  LComponent: TComponent;
  List: IDesignerSelections;
  LGridLink: TBaseBindDBGridLink;
begin
  // Use FTempStringList as a flag because we can't change 
  // TBindGridColumnSelectionEditor layout in update3
  if AEditor.FTempStringList <> nil then
    Exit;
  List := CreateSelectionList;
  AEditor.Designer.GetSelections(List);
  if (List.Count > 0) and (List[0] is TComponent) then
    LComponent := TComponent(List[0])
  else
    LComponent := nil;
  // Build list of ActionLists
  if LComponent <> nil then
  begin
    AEditor.FTempStringList := TStringList.Create;
    try
      AEditor.Designer.GetComponentNames(GetTypeData(TypeInfo(TBaseBindDBGridLink)), AEditor.AddTempString);
      for I := 0 to AEditor.FTempStringList.Count - 1 do
      begin
        LGridLink := AEditor.Designer.GetComponent(AEditor.FTempStringList[I]) as TBaseBindDBGridLink;

        if LGridLink.ControlComponent = LComponent then
        begin
          AEditor.FGridLink := LGridLink;
          break;
        end;
      end;
    finally
      // Free but do not nil because using as a flag
      AEditor.FTempStringList.Free;
    end;
  end;
end;

constructor TBindDBGridColumnsSelectionEditor.Create(
  const ADesigner: IDesigner);
begin
  inherited;

end;

procedure TBindDBGridColumnsSelectionEditor.ExecuteVerb(Index: Integer;
  const List: IDesignerSelections);
begin
  // Update on demand to improve performance of code insite.
  UpdateGridLink(Self);
  if FGridLink <> nil then
  begin
    ShowCollectionEditorClass(Designer, TBindDBGridColumnsEditor, FGridLink,
      GetCollection(FGridLink), GetPropertyName(FGridLink));
  end;
end;

function TBindDBGridColumnsSelectionEditor.GetCollection(AGridLink: TBaseBindDBGridLink): TCollection;
begin
  Result := TBaseBindDBGridLinkWrapper(AGridLink).GetColumns;
end;

function TBindDBGridColumnsSelectionEditor.GetPropertyName(AGridLink: TBaseBindDBGridLink): string;
begin
 Result := 'Columns'; // Do not localize
end;

function TBindDBGridColumnsSelectionEditor.GetVerb(Index: Integer): string;
begin
  Result := SDBGridColEditor;
end;

function TBindDBGridColumnsSelectionEditor.GetVerbCount: Integer;
begin
  // Update on demand to improve performance of code insite.
  UpdateGridLink(Self);
  if FGridLink <> nil then
    Result := 1
  else
    Result := 0;
end;

procedure TBindDBGridColumnsSelectionEditor.AddTempString(const S: string);
begin
  FTempStringList.Add(S);
end;

end.
