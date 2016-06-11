{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsModules;

interface

uses Classes, ToolsAPI, SysUtils, ExpertsTemplates, ExpertsIntf;

type

  TExpertsModulesComponent = class(TComponent)
  strict private
    FTemplatePropertiesDoc: TStrings;
    FTemplateProperties: TCustomExpertsTemplateProperties;
    procedure SetTemplateProperties(
      const Value: TCustomExpertsTemplateProperties);
    procedure SetTemplatePropertiesDoc(const Value: TStrings);
  private
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property TemplateProperties: TCustomExpertsTemplateProperties read FTemplateProperties write SetTemplateProperties;
    property TemplatePropertiesDoc: TStrings read FTemplatePropertiesDoc write SetTemplatePropertiesDoc;
  end;

  TExpertsPersonalityModuleComponent = class(TExpertsModulesComponent)
  public
    procedure CreateModule(const APersonality: string); virtual; abstract;
  end;

  TExpertsGenericModuleComponent = class(TExpertsModulesComponent)
  public
    procedure CreateModule; virtual; abstract;
  end;

  // TForm, TDataModule, etc. with Implementation, Interface (C++ only) and DFM
  TCustomExpertsModule = class(TExpertsPersonalityModuleComponent)
  private
    FFormTemplateFile: TCustomExpertsTemplateFile;
    FInterfaceTemplateFile: TCustomExpertsTemplateFile;
    FSourceTemplateFile: TCustomExpertsTemplateFile;
//    FTemplateProperties: TCustomExpertsTemplateProperties;
    FAncestorName: string;
    FFileName: string;
    FUnnamed: Boolean;
    FFileDirectory: string;
    FFormName: string;
//    FTemplatePropertiesDoc: TStrings;
    procedure SetFormTemplateFile(const Value: TCustomExpertsTemplateFile);
    procedure SetInterfaceTemplateFile(const Value: TCustomExpertsTemplateFile);
    procedure SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
//    procedure SetTemplateProperties(const Value: TCustomExpertsTemplateProperties);
    procedure SetFileDirectory(const Value: string);
    procedure SetFileName(const Value: string);
//    procedure SetTemplatePropertiesDoc(const Value: TStrings);
    function CreateAccessor(const APersonality: string): IExpertsModuleAccessor;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateModule(const APersonality: string); overload; override;
    procedure CreateModuleIdents(const APersonality: string;  out AModuleIdent, AFormIdent, AAncestorIdent: string);
//    procedure CreateUnit(const APersonality: string); overload;
//    procedure CreateUnit(const APersonality: string;  out AModuleIdent, AFormIdent, AAncestorIdent: string); overload;
    property FormTemplateFile: TCustomExpertsTemplateFile read FFormTemplateFile write SetFormTemplateFile;
    property SourceTemplateFile: TCustomExpertsTemplateFile read FSourceTemplateFile write SetSourceTemplateFile;
    property InterfaceTemplateFile: TCustomExpertsTemplateFile read FInterfaceTemplateFile write SetInterfaceTemplateFile;
//    property TemplateProperties: TCustomExpertsTemplateProperties read FTemplateProperties write SetTemplateProperties;
//    property TemplatePropertiesDoc: TStrings read FTemplatePropertiesDoc write SetTemplatePropertiesDoc;
    property AncestorName: string read FAncestorName write FAncestorName;
    property FileName: string read FFileName write SetFileName;
    property FileDirectory: string read FFileDirectory write SetFileDirectory;
    property Unnamed: Boolean read FUnnamed write FUnnamed default true;
    property FormName: string read FFormName write FFormName;
  end;

  TExpertsModule = class(TCustomExpertsModule)
  published
    property SourceTemplateFile;
    property InterfaceTemplateFile;
    property FormTemplateFile;
    property TemplateProperties;
    property TemplatePropertiesDoc;
    property AncestorName;
    property FileName;
    property FileDirectory;
    property Unnamed;
    property FormName;
  end;


  // Unit with Implementation, Interface (C++ only).  Contents is a class with ancestor.
  TCustomExpertsClassUnit = class(TExpertsPersonalityModuleComponent)
  private
    FInterfaceTemplateFile: TCustomExpertsTemplateFile;
    FSourceTemplateFile: TCustomExpertsTemplateFile;
//    FTemplateProperties: TCustomExpertsTemplateProperties;
    FAncestorName: string;
    FFileName: string;
    FUnnamed: Boolean;
    FFileDirectory: string;
    FClassName: string;
//    FTemplatePropertiesDoc: TStrings;
    procedure SetInterfaceTemplateFile(const Value: TCustomExpertsTemplateFile);
    procedure SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
//    procedure SetTemplateProperties(const Value: TCustomExpertsTemplateProperties);
    procedure SetFileDirectory(const Value: string);
    procedure SetFileName(const Value: string);
//    procedure SetTemplatePropertiesDoc(const Value: TStrings);
    function CreateAccessor(const APersonality: string): IExpertsModuleAccessor;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateModule(const APersonality: string); overload; override;
    procedure CreateModuleIdents(const APersonality: string;  out AModuleIdent, AClassIdent, AAncestorIdent: string); overload;
    property SourceTemplateFile: TCustomExpertsTemplateFile read FSourceTemplateFile write SetSourceTemplateFile;
    property InterfaceTemplateFile: TCustomExpertsTemplateFile read FInterfaceTemplateFile write SetInterfaceTemplateFile;
//    property TemplateProperties: TCustomExpertsTemplateProperties read FTemplateProperties write SetTemplateProperties;
//    property TemplatePropertiesDoc: TStrings read FTemplatePropertiesDoc write SetTemplatePropertiesDoc;
    property AncestorName: string read FAncestorName write FAncestorName;
    property FileName: string read FFileName write SetFileName;
    property FileDirectory: string read FFileDirectory write SetFileDirectory;
    property Unnamed: Boolean read FUnnamed write FUnnamed default true;
    property UnitClassName: string read FClassName write FClassName;
  end;

  TExpertsClassUnit = class(TCustomExpertsClassUnit)
  published
    property SourceTemplateFile;
    property InterfaceTemplateFile;
    property TemplateProperties;
    property TemplatePropertiesDoc;
    property AncestorName;
    property FileName;
    property FileDirectory;
    property Unnamed;
    property UnitClassName;
  end;


  // Unit with implementation and interface file (C++ only)
  TCustomExpertsUnit = class(TExpertsPersonalityModuleComponent)
  private
    FInterfaceTemplateFile: TCustomExpertsTemplateFile;
    FSourceTemplateFile: TCustomExpertsTemplateFile;
//    FTemplateProperties: TCustomExpertsTemplateProperties;
    FFileName: string;
    FUnnamed: Boolean;
    FFileDirectory: string;
//    FTemplatePropertiesDoc: TStrings;
    procedure SetInterfaceTemplateFile(const Value: TCustomExpertsTemplateFile);
    procedure SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
//    procedure SetTemplateProperties(const Value: TCustomExpertsTemplateProperties);
    procedure SetFileDirectory(const Value: string);
    procedure SetFileName(const Value: string);
//    procedure SetTemplatePropertiesDoc(const Value: TStrings);
    function CreateAccessor(const APersonality: string): IExpertsModuleAccessor;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateModule(const APersonality: string); overload; override;
    procedure CreateModuleIdents(const APersonality: string;  out AModuleIdent, AFormIdent, AAncestorIdent: string); overload;
    property SourceTemplateFile: TCustomExpertsTemplateFile read FSourceTemplateFile write SetSourceTemplateFile;
    property InterfaceTemplateFile: TCustomExpertsTemplateFile read FInterfaceTemplateFile write SetInterfaceTemplateFile;
//    property TemplateProperties: TCustomExpertsTemplateProperties read FTemplateProperties write SetTemplateProperties;
//    property TemplatePropertiesDoc: TStrings read FTemplatePropertiesDoc write SetTemplatePropertiesDoc;
    property FileName: string read FFileName write SetFileName;
    property FileDirectory: string read FFileDirectory write SetFileDirectory;
    property Unnamed: Boolean read FUnnamed write FUnnamed default true;
  end;

  TExpertsUnit = class(TCustomExpertsUnit)
  published
    property SourceTemplateFile;
    property InterfaceTemplateFile;
    property TemplateProperties;
    property TemplatePropertiesDoc;
    property FileName;
    property FileDirectory;
    property Unnamed;
  end;

  // Single file (no C++ interface, no .dfm)
  TCustomExpertsTextFile = class(TExpertsGenericModuleComponent)
  private
    FSourceTemplateFile: TCustomExpertsTemplateFile;
//    FTemplateProperties: TCustomExpertsTemplateProperties;
    FFileName: string;
    FFileNameExt: string;
    FUnnamed: Boolean;
    FFileDirectory: string;
//    FTemplatePropertiesDoc: TStrings;
    procedure SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
//    procedure SetTemplateProperties(const Value: TCustomExpertsTemplateProperties);
    procedure SetFileNameExt(const Value: string);
    procedure SetFileDirectory(const Value: string);
    procedure SetFileName(const Value: string);
//    procedure SetTemplatePropertiesDoc(const Value: TStrings);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateModule; override;
    property SourceTemplateFile: TCustomExpertsTemplateFile read FSourceTemplateFile write SetSourceTemplateFile;
//    property TemplateProperties: TCustomExpertsTemplateProperties read FTemplateProperties write SetTemplateProperties;
//    property TemplatePropertiesDoc: TStrings read FTemplatePropertiesDoc write SetTemplatePropertiesDoc;
    property FileName: string read FFileName write SetFileName;
    property FileDirectory: string read FFileDirectory write SetFileDirectory;
    property FileNameExt: string read FFileNameExt write SetFileNameExt;
    property Unnamed: Boolean read FUnnamed write FUnnamed default true;
  end;

  TExpertsTextFile = class(TCustomExpertsTextFile)
  published
    property SourceTemplateFile;
    property FileName;
    property FileNameExt;
    property FileDirectory;
    property TemplateProperties;
    property TemplatePropertiesDoc;
    property Unnamed;
  end;


  // Single pch file as precompiled header for C++ Win64 platform
  TCustomExpertsPCHModule = class(TExpertsGenericModuleComponent)
  private
    FSourceTemplateFile: TCustomExpertsTemplateFile;
//    FTemplateProperties: TCustomExpertsTemplateProperties;
    FFileName: string;
    FFileNameExt: string;
    FUnnamed: Boolean;
    FFileDirectory: string;
//    FTemplatePropertiesDoc: TStrings;
    procedure SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
//    procedure SetTemplateProperties(const Value: TCustomExpertsTemplateProperties);
    procedure SetFileNameExt(const Value: string);
    procedure SetFileDirectory(const Value: string);
    procedure SetFileName(const Value: string);
//    procedure SetTemplatePropertiesDoc(const Value: TStrings);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateModule; override;
    property SourceTemplateFile: TCustomExpertsTemplateFile read FSourceTemplateFile write SetSourceTemplateFile;
//    property TemplateProperties: TCustomExpertsTemplateProperties read FTemplateProperties write SetTemplateProperties;
//    property TemplatePropertiesDoc: TStrings read FTemplatePropertiesDoc write SetTemplatePropertiesDoc;
    property FileName: string read FFileName write SetFileName;
    property FileDirectory: string read FFileDirectory write SetFileDirectory;
    property FileNameExt: string read FFileNameExt write SetFileNameExt;
    property Unnamed: Boolean read FUnnamed write FUnnamed default true;
  end;

  TExpertsPchModule = class(TCustomExpertsPCHModule)
  published
    property SourceTemplateFile;
    property FileName;
    property FileNameExt;
    property FileDirectory;
    property TemplateProperties;
    property TemplatePropertiesDoc;
    property Unnamed;
  end;


implementation

uses ExpertsModuleCreators, ExpertsResStrs;

type
  TExpertsModuleAccessor = class(TInterfacedObject, IExpertsModuleAccessor)
  private
    FPersonality: string;
    FExpertsModule: TCustomExpertsModule;
    // IExpertsModuleAccessor
    function NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function GetAncestorName: string;
    function GetFileName: string;
    function GetFileNameExt: string;
    function GetUnnamed: Boolean;
    function GetFormName: string;
    function Designing: Boolean;
  public
    constructor Create(const APersonality: string; AExpertsModule: TCustomExpertsModule);
  end;

   TExpertsClassUnitAccessor = class(TInterfacedObject, IExpertsModuleAccessor)
  private
    FPersonality: string;
    FExpertsClassUnit: TCustomExpertsClassUnit;
    // IExpertsModuleAccessor
    function NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function GetAncestorName: string;
    function GetFileName: string;
    function GetFileNameExt: string;
    function GetUnnamed: Boolean;
    function GetFormName: string;
    function Designing: Boolean;
  public
    constructor Create(const APersonality: string; AExpertsClassUnit: TCustomExpertsClassUnit);
  end;

  TExpertsUnitAccessor = class(TInterfacedObject, IExpertsModuleAccessor)
  private
    FPersonality: string;
    FExpertsUnit: TCustomExpertsUnit;
    // IExpertsModuleAccessor
    function NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function GetAncestorName: string;
    function GetFileName: string;
    function GetFileNameExt: string;
    function GetUnnamed: Boolean;
    function GetFormName: string;
    function Designing: Boolean;
  public
    constructor Create(const APersonality: string; AExpertsUnit: TCustomExpertsUnit);
  end;

  TExpertsTextFileAccessor = class(TInterfacedObject, IExpertsModuleAccessor)
  private
    FExpertsTextFile: TCustomExpertsTextFile;
    // IExpertsModuleAccessor
    function NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function GetAncestorName: string;
    function GetFileName: string;
    function GetFileNameExt: string;
    function GetUnnamed: Boolean;
    function GetFormName: string;
    function Designing: Boolean;
  public
    constructor Create(AExpertsTextFile: TCustomExpertsTextFile);
  end;

  TExpertsPchAccessor = class(TInterfacedObject, IExpertsModuleAccessor)
  private
    FExpertsPch: TCustomExpertsPCHModule;
    // IExpertsModuleAccessor
    function NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function GetAncestorName: string;
    function GetFileName: string;
    function GetFileNameExt: string;
    function GetUnnamed: Boolean;
    function GetFormName: string;
    function Designing: Boolean;
  public
    constructor Create(AExpertsPch: TCustomExpertsPCHModule);
  end;


{ TCustomExpertsModule }

constructor TCustomExpertsModule.Create(AOwner: TComponent);
begin
  inherited;
  FUnnamed := True;
end;

function TCustomExpertsModule.CreateAccessor(const APersonality: string): IExpertsModuleAccessor;
begin
  Result := TExpertsModuleAccessor.Create(APersonality, Self);
end;

procedure TCustomExpertsModule.CreateModule(const APersonality: string);
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsModuleCreator.Create(APersonality, TExpertsModuleAccessor.Create(APersonality, Self)))
end;

procedure TCustomExpertsModule.CreateModuleIdents(const APersonality: string; out AModuleIdent, AFormIdent, AAncestorIdent: string);
var
  LModuleIdent, LFormIdent, LAncestorIdent: string;
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsModuleCreator.Create(APersonality, CreateAccessor(APersonality),
    procedure(const ModuleIdent, FormIdent, AncestorIdent: string)
    begin
      LModuleIdent := ModuleIdent;
      LFormIdent := FormIdent;
      LAncestorIdent := AncestorIdent;
    end));
   AModuleIdent := LModuleIdent;
   AFormIdent := LFormIdent;
   AAncestorIdent := LAncestorIdent;
end;

//procedure TCustomExpertsModule.CreateModule(const APersonality: string);
//begin
//  (BorlandIDEServices as IOTAModuleServices).CreateModule(
//    TExpertsModuleUnitCreator.Create(APersonality, CreateAccessor(APersonality)))
//end;
//
//procedure TCustomExpertsModule.CreateModule(const APersonality: string; out AModuleIdent, AFormIdent, AAncestorIdent: string);
//var
//  LModuleIdent, LFormIdent, LAncestorIdent: string;
//begin
//  (BorlandIDEServices as IOTAModuleServices).CreateModule(
//    TExpertsModuleUnitCreator.Create(APersonality, CreateAccessor(APersonality),
//    procedure(const ModuleIdent, FormIdent, AncestorIdent: string)
//    begin
//      LModuleIdent := ModuleIdent;
//      LFormIdent := FormIdent;
//      LAncestorIdent := AncestorIdent;
//    end));
//   AModuleIdent := LModuleIdent;
//   AFormIdent := LFormIdent;
//   AAncestorIdent := LAncestorIdent;
//end;

destructor TCustomExpertsModule.Destroy;
begin
  inherited;
end;

procedure TCustomExpertsModule.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFormTemplateFile) then
    FFormTemplateFile := nil;
  if (Operation = opRemove) and (AComponent = FSourceTemplateFile) then
    FSourceTemplateFile := nil;
  if (Operation = opRemove) and (AComponent = FInterfaceTemplateFile) then
    FInterfaceTemplateFile := nil;
end;

procedure TCustomExpertsModule.SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FSourceTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FSourceTemplateFile := Value;
  end;
end;

procedure TCustomExpertsModule.SetFileDirectory(const Value: string);
begin
  FFileDirectory := Trim(Value);
  if FFileDirectory <> '' then
    FFileDirectory := IncludeTrailingPathDelimiter(FFileDirectory);
end;

procedure TCustomExpertsModule.SetFileName(const Value: string);
begin
  FFileName := Trim(Value);
  if FFileName <> '' then
  begin
    FFileName := ChangeFileExt(ExtractFileName(FFileName), '');
  end;
end;

procedure TCustomExpertsModule.SetFormTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FFormTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FFormTemplateFile := Value;
  end;
end;

procedure TCustomExpertsModule.SetInterfaceTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FInterfaceTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FInterfaceTemplateFile := Value;
  end;
end;

//procedure TCustomExpertsModule.SetTemplateProperties(
//  const Value: TCustomExpertsTemplateProperties);
//begin
//  if FTemplateProperties <> Value then
//  begin
//    if Value <> nil then Value.FreeNotification(Self);
//    FTemplateProperties := Value;
//  end;
//end;

//procedure TCustomExpertsModule.SetTemplatePropertiesDoc(const Value: TStrings);
//begin
//  FTemplatePropertiesDoc := Value;
//end;

{ TCustomExpertsClassUnit }

constructor TCustomExpertsClassUnit.Create(AOwner: TComponent);
begin
  inherited;
  FUnnamed := True;
end;

function TCustomExpertsClassUnit.CreateAccessor(const APersonality: string): IExpertsModuleAccessor;
begin
  Result := TExpertsClassUnitAccessor.Create(APersonality, Self);
end;

procedure TCustomExpertsClassUnit.CreateModule(const APersonality: string);
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsModuleUnitCreator.Create(APersonality, CreateAccessor(APersonality)))
end;

procedure TCustomExpertsClassUnit.CreateModuleIdents(const APersonality: string; out AModuleIdent, AClassIdent, AAncestorIdent: string);
var
  LModuleIdent, LFormIdent, LAncestorIdent: string;
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsModuleUnitCreator.Create(APersonality, CreateAccessor(APersonality),
    procedure(const ModuleIdent, FormIdent, AncestorIdent: string)
    begin
      LModuleIdent := ModuleIdent;
      LFormIdent := FormIdent;
      LAncestorIdent := AncestorIdent;
    end));
   AModuleIdent := LModuleIdent;
   AClassIdent := LFormIdent;
   AAncestorIdent := LAncestorIdent;
end;

destructor TCustomExpertsClassUnit.Destroy;
begin
  inherited;
end;

procedure TCustomExpertsClassUnit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSourceTemplateFile) then
    FSourceTemplateFile := nil;
  if (Operation = opRemove) and (AComponent = FInterfaceTemplateFile) then
    FInterfaceTemplateFile := nil;
end;

procedure TCustomExpertsClassUnit.SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FSourceTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FSourceTemplateFile := Value;
  end;
end;

procedure TCustomExpertsClassUnit.SetFileDirectory(const Value: string);
begin
  FFileDirectory := Trim(Value);
  if FFileDirectory <> '' then
    FFileDirectory := IncludeTrailingPathDelimiter(FFileDirectory);
end;

procedure TCustomExpertsClassUnit.SetFileName(const Value: string);
begin
  FFileName := Trim(Value);
  if FFileName <> '' then
  begin
    FFileName := ChangeFileExt(ExtractFileName(FFileName), '');
  end;
end;

procedure TCustomExpertsClassUnit.SetInterfaceTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FInterfaceTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FInterfaceTemplateFile := Value;
  end;
end;

//procedure TCustomExpertsClassUnit.SetTemplateProperties(
//  const Value: TCustomExpertsTemplateProperties);
//begin
//  if FTemplateProperties <> Value then
//  begin
//    if Value <> nil then Value.FreeNotification(Self);
//    FTemplateProperties := Value;
//  end;
//end;
//
//procedure TCustomExpertsClassUnit.SetTemplatePropertiesDoc(const Value: TStrings);
//begin
//  FTemplatePropertiesDoc := Value;
//end;


{ TExpertsModuleAccessor }

constructor TExpertsModuleAccessor.Create(
  const APersonality: string; AExpertsModule: TCustomExpertsModule);
begin
  FPersonality := APersonality;
  FExpertsModule := AExpertsModule;
end;

function TExpertsModuleAccessor.Designing: Boolean;
begin
  Result := csDesigning in FExpertsModule.ComponentState;
end;

function TExpertsModuleAccessor.GetAncestorName: string;
begin
  Result := FExpertsModule.AncestorName;
end;

function TExpertsModuleAccessor.GetFileNameExt: string;
begin
  Result := '';
end;

function TExpertsModuleAccessor.GetFormName: string;
begin
  Result := FExpertsModule.FormName;
end;

function TExpertsModuleAccessor.GetUnnamed: Boolean;
begin
  Result := FExpertsModule.Unnamed;
end;

function TExpertsModuleAccessor.GetFileName: string;
begin
  Result := FExpertsModule.FileDirectory + FExpertsModule.FileName;
end;

function GetFileTypePropertyPairs(const AFileType, ModuleIdent, FormIdent, AncestorIdent: string): IPropertyPairs;
var
  LBuiltInProperties: TStrings;
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  LBuiltInProperties := TStringList.Create;
  LBuiltInProperties.Values['FileType'] := AFileType;
  LBuiltInProperties.Values['ModuleIdent'] := ModuleIdent;
  LBuiltInProperties.Values['FormIdent'] := FormIdent;
  LBuiltInProperties.Values['AncestorIdent'] := AncestorIdent;
  LBuiltInPropertyPairs := TStringsPropertiesPairs.Create(LBuiltInProperties, True); // Owns strings
  Result :=  LBuiltInPropertyPairs;
end;

function TExpertsModuleAccessor.NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsModule.FSourceTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs := GetFileTypePropertyPairs('Source', ModuleIdent, FormIdent, AncestorIdent);
    LBuiltInPropertyPairs :=  MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsModule.TemplatePropertiesDoc, False));
    Result := FExpertsModule.FSourceTemplateFile.CreateFile(FPersonality,
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsModule.TemplateProperties)))
  end
  else
    Result := nil;
end;

function TExpertsModuleAccessor.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsModule.FFormTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs := GetFileTypePropertyPairs('Form', '', FormIdent, AncestorIdent);
    LBuiltInPropertyPairs :=  MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsModule.TemplatePropertiesDoc, False));
    Result := FExpertsModule.FFormTemplateFile.CreateFile(FPersonality,
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsModule.TemplateProperties)))
  end
  else
    Result := nil;
end;

function TExpertsModuleAccessor.NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsModule.FInterfaceTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs := GetFileTypePropertyPairs('Interface', ModuleIdent, FormIdent, AncestorIdent);
    LBuiltInPropertyPairs :=  MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsModule.TemplatePropertiesDoc, False));
    Result := FExpertsModule.FInterfaceTemplateFile.CreateFile(FPersonality,
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsModule.TemplateProperties)))
  end
  else
    Result := nil;
end;

{ TExpertsUnitAccessor }

constructor TExpertsUnitAccessor.Create(
  const APersonality: string; AExpertsUnit: TCustomExpertsUnit);
begin
  FPersonality := APersonality;
  FExpertsUnit := AExpertsUnit;
end;

function TExpertsUnitAccessor.Designing: Boolean;
begin
  Result := csDesigning in FExpertsUnit.ComponentState;
end;

function TExpertsUnitAccessor.GetAncestorName: string;
begin
  Result := ''; // FExpertsModule.AncestorName;
end;

function TExpertsUnitAccessor.GetFileNameExt: string;
begin
  Result := '';
end;

function TExpertsUnitAccessor.GetFormName: string;
begin
  Result := '';
end;

function TExpertsUnitAccessor.GetFileName: string;
begin
  Result := FExpertsUnit.FileDirectory + FExpertsUnit.FileName;
end;

function TExpertsUnitAccessor.GetUnnamed: Boolean;
begin
  Result :=  FExpertsUnit.Unnamed;
end;

function TExpertsUnitAccessor.NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsUnit.FSourceTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs := GetFileTypePropertyPairs('Source', ModuleIdent, FormIdent, AncestorIdent);
    LBuiltInPropertyPairs :=  MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsUnit.TemplatePropertiesDoc, False));
    Result := FExpertsUnit.FSourceTemplateFile.CreateFile(FPersonality,
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsUnit.TemplateProperties)))
  end
  else
    Result := nil;
end;

function TExpertsUnitAccessor.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TExpertsUnitAccessor.NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsUnit.FInterfaceTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs :=GetFileTypePropertyPairs('Interface', ModuleIdent, FormIdent, AncestorIdent);
    LBuiltInPropertyPairs :=  MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsUnit.TemplatePropertiesDoc, False));
    Result := FExpertsUnit.FInterfaceTemplateFile.CreateFile(FPersonality,
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsUnit.TemplateProperties)))
  end
  else
    Result := nil;
end;

{ TExpertsClassUnitAccessor }

constructor TExpertsClassUnitAccessor.Create(
  const APersonality: string; AExpertsClassUnit: TCustomExpertsClassUnit);
begin
  FPersonality := APersonality;
  FExpertsClassUnit := AExpertsClassUnit;
end;

function TExpertsClassUnitAccessor.Designing: Boolean;
begin
  Result := csDesigning in FExpertsClassUnit.ComponentState;
end;

function TExpertsClassUnitAccessor.GetAncestorName: string;
begin
  Result := FExpertsClassUnit.AncestorName;
end;

function TExpertsClassUnitAccessor.GetFileNameExt: string;
begin
  Result := '';
end;

function TExpertsClassUnitAccessor.GetFormName: string;
begin
  Result := FExpertsClassUnit.UnitClassName;
end;

function TExpertsClassUnitAccessor.GetUnnamed: Boolean;
begin
  Result := FExpertsClassUnit.Unnamed;
end;

function TExpertsClassUnitAccessor.GetFileName: string;
begin
  Result := FExpertsClassUnit.FileDirectory + FExpertsClassUnit.FileName;
end;

function TExpertsClassUnitAccessor.NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsClassUnit.FSourceTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs := GetFileTypePropertyPairs('Source', ModuleIdent, FormIdent, AncestorIdent);
    LBuiltInPropertyPairs :=  MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsClassUnit.TemplatePropertiesDoc, False));
    Result := FExpertsClassUnit.FSourceTemplateFile.CreateFile(FPersonality,
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsClassUnit.TemplateProperties)))
  end
  else
    Result := nil;
end;

function TExpertsClassUnitAccessor.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TExpertsClassUnitAccessor.NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsClassUnit.FInterfaceTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs := GetFileTypePropertyPairs('Interface', ModuleIdent, FormIdent, AncestorIdent);
    LBuiltInPropertyPairs :=  MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsClassUnit.TemplatePropertiesDoc, False));
    Result := FExpertsClassUnit.FInterfaceTemplateFile.CreateFile(FPersonality,
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsClassUnit.TemplateProperties)))
  end
  else
    Result := nil;
end;



{ TExpertsTextFileAccessor }

constructor TExpertsTextFileAccessor.Create(AExpertsTextFile: TCustomExpertsTextFile);
begin
  FExpertsTextFile := AExpertsTextFile;
end;

function TExpertsTextFileAccessor.Designing: Boolean;
begin
  Result := csDesigning in FExpertsTextFile.ComponentState;
end;

function TExpertsTextFileAccessor.GetAncestorName: string;
begin
  Result := ''; //
end;

function TExpertsTextFileAccessor.GetFileNameExt: string;
begin
  Result := FExpertsTextFile.FileNameExt;
end;

function TExpertsTextFileAccessor.GetFormName: string;
begin
  Result := '';
end;

function TExpertsTextFileAccessor.GetFileName: string;
begin
  Result := FExpertsTextFile.FileDirectory +  FExpertsTextFile.FileName
end;

function TExpertsTextFileAccessor.GetUnnamed: Boolean;
begin
  Result :=  FExpertsTextFile.Unnamed;
end;

function TExpertsTextFileAccessor.NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsTextFile.FSourceTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs :=GetFileTypePropertyPairs('Source', ModuleIdent, FormIdent, AncestorIdent);
    LBuiltInPropertyPairs :=  MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsTextFile.TemplatePropertiesDoc, False));
    Result := FExpertsTextFile.FSourceTemplateFile.CreateFile('',
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsTextFile.TemplateProperties)))
  end
  else
    Result := nil;
end;

function TExpertsTextFileAccessor.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TExpertsTextFileAccessor.NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

{ TCustomExpertsUnit }

constructor TCustomExpertsUnit.Create(AOwner: TComponent);
begin
  inherited;
  FUnnamed := True;
//  FTemplatePropertiesDoc := TStringList.Create;
end;

procedure TCustomExpertsUnit.CreateModule(const APersonality: string);
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsUnitCreator.Create(APersonality, CreateAccessor(APersonality)))
end;

function TCustomExpertsUnit.CreateAccessor(
  const APersonality: string): IExpertsModuleAccessor;
begin
  Result := TExpertsUnitAccessor.Create(APersonality, Self);
end;

procedure TCustomExpertsUnit.CreateModuleIdents(const APersonality: string; out AModuleIdent, AFormIdent, AAncestorIdent: string);
var
  LModuleIdent, LFormIdent, LAncestorIdent: string;
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsUnitCreator.Create(APersonality, CreateAccessor(APersonality),
    procedure(const ModuleIdent, FormIdent, AncestorIdent: string)
    begin
      LModuleIdent := ModuleIdent;
      LFormIdent := FormIdent;
      LAncestorIdent := AncestorIdent;
    end));
   AModuleIdent := LModuleIdent;
   AFormIdent := LFormIdent;
   AAncestorIdent := LAncestorIdent;
end;

destructor TCustomExpertsUnit.Destroy;
begin
//  FTemplatePropertiesDoc.Free;
  inherited;
end;

procedure TCustomExpertsUnit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSourceTemplateFile) then
    FSourceTemplateFile := nil;
  if (Operation = opRemove) and (AComponent = FInterfaceTemplateFile) then
    FInterfaceTemplateFile := nil;
//  if (Operation = opRemove) and (AComponent = FTemplateProperties) then
//    FTemplateProperties := nil;
end;

procedure TCustomExpertsUnit.SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FSourceTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FSourceTemplateFile := Value;
  end;
end;

procedure TCustomExpertsUnit.SetFileDirectory(const Value: string);
begin
  FFileDirectory := Trim(Value);
  if FFileDirectory <> '' then
    FFileDirectory := IncludeTrailingPathDelimiter(FFileDirectory);
end;

procedure TCustomExpertsUnit.SetFileName(const Value: string);
begin
  FFileName := Trim(Value);
  if FFileName <> '' then
  begin
    FFileName := ChangeFileExt(ExtractFileName(FFileName), '');
  end;
end;

procedure TCustomExpertsUnit.SetInterfaceTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FInterfaceTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FInterfaceTemplateFile := Value;
  end;
end;

//procedure TCustomExpertsUnit.SetTemplateProperties(
//  const Value: TCustomExpertsTemplateProperties);
//begin
//  if FTemplateProperties <> Value then
//  begin
//    if Value <> nil then Value.FreeNotification(Self);
//    FTemplateProperties := Value;
//  end;
//end;
//
//procedure TCustomExpertsUnit.SetTemplatePropertiesDoc(const Value: TStrings);
//begin
//  FTemplatePropertiesDoc.Assign(Value);
//end;
//
{ TCustomExpertsTextFile }

constructor TCustomExpertsTextFile.Create(AOwner: TComponent);
begin
  inherited;
  FFileName := 'text';
  FFileNameExt := '.txt';
  FUnnamed := True;
//  FTemplatePropertiesDoc := TStringList.Create;
end;

procedure TCustomExpertsTextFile.CreateModule;
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsTextFileCreator.Create(TExpertsTextFileAccessor.Create(Self)))
end;

destructor TCustomExpertsTextFile.Destroy;
begin
//  FTemplatePropertiesDoc.Free;
  inherited;
end;

procedure TCustomExpertsTextFile.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSourceTemplateFile) then
    FSourceTemplateFile := nil;
end;

procedure TCustomExpertsTextFile.SetFileDirectory(const Value: string);
begin
  FFileDirectory := Trim(Value);
  if FFileDirectory <> '' then
    FFileDirectory := IncludeTrailingPathDelimiter(FFileDirectory);
end;

procedure TCustomExpertsTextFile.SetFileName(const Value: string);
begin
  FFileName := Trim(Value);
  if FFileName <> '' then
  begin
    FFileName := ChangeFileExt(ExtractFileName(FFileName), '');
  end;
end;

procedure TCustomExpertsTextFile.SetFileNameExt(const Value: string);
begin
  FFileNameExt := Trim(Value);
  if FFileNameExt <> '' then
    if FFileNameExt[1] <> '.' then
      FFileNameExt := '.' + FFileNameExt;

end;

procedure TCustomExpertsTextFile.SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FSourceTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FSourceTemplateFile := Value;
  end;
end;

//procedure TCustomExpertsTextFile.SetTemplateProperties(
//  const Value: TCustomExpertsTemplateProperties);
//begin
//  if FTemplateProperties <> Value then
//  begin
//    if Value <> nil then Value.FreeNotification(Self);
//    FTemplateProperties := Value;
//  end;
//end;
//
//
//procedure TCustomExpertsTextFile.SetTemplatePropertiesDoc(
//  const Value: TStrings);
//begin
//  FTemplatePropertiesDoc.Assign(Value);
//end;

{ TExpertsModulesComponent }

constructor TExpertsModulesComponent.Create(AOwner: TComponent);
begin
  inherited;
  FTemplatePropertiesDoc := TStringList.Create;
end;

destructor TExpertsModulesComponent.Destroy;
begin
  FTemplatePropertiesDoc.Free;
  inherited;
end;

procedure TExpertsModulesComponent.SetTemplateProperties(
  const Value: TCustomExpertsTemplateProperties);
begin
  if FTemplateProperties <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FTemplateProperties := Value;
  end;
end;

procedure TExpertsModulesComponent.SetTemplatePropertiesDoc(const Value: TStrings);
begin
  FTemplatePropertiesDoc.Assign(Value);
end;

procedure TExpertsModulesComponent.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FTemplateProperties) then
    FTemplateProperties := nil;
end;

{ TCustomExpertsPCHModule }

constructor TCustomExpertsPCHModule.Create(AOwner: TComponent);
begin
  inherited;
  FFileName := '';
  FFileNameExt := '';
  FUnnamed := True;
//  FTemplatePropertiesDoc := TStringList.Create;
end;

procedure TCustomExpertsPCHModule.CreateModule;
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsPchCreator.Create(TExpertsPchAccessor.Create(Self)))
end;

destructor TCustomExpertsPCHModule.Destroy;
begin
//  FTemplatePropertiesDoc.Free;
  inherited;
end;

procedure TCustomExpertsPCHModule.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSourceTemplateFile) then
    FSourceTemplateFile := nil;
end;

procedure TCustomExpertsPCHModule.SetFileDirectory(const Value: string);
begin
  FFileDirectory := Trim(Value);
  if FFileDirectory <> '' then
    FFileDirectory := IncludeTrailingPathDelimiter(FFileDirectory);
end;

procedure TCustomExpertsPCHModule.SetFileName(const Value: string);
begin
  FFileName := Trim(Value);
  if FFileName <> '' then
  begin
    FFileName := ChangeFileExt(ExtractFileName(FFileName), '');
  end;
end;

procedure TCustomExpertsPCHModule.SetFileNameExt(const Value: string);
begin
  FFileNameExt := Trim(Value);
  if FFileNameExt <> '' then
    if FFileNameExt[1] <> '.' then
      FFileNameExt := '.' + FFileNameExt;

end;

procedure TCustomExpertsPCHModule.SetSourceTemplateFile(const Value: TCustomExpertsTemplateFile);
begin
  if FSourceTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FSourceTemplateFile := Value;
  end;
end;
{ TExpertsPchAccessor }

constructor TExpertsPchAccessor.Create(AExpertsPch: TCustomExpertsPCHModule);
begin
  FExpertsPch := AExpertsPch;
end;

function TExpertsPchAccessor.Designing: Boolean;
begin
  Result := csDesigning in FExpertsPch.ComponentState;
end;

function TExpertsPchAccessor.GetAncestorName: string;
begin
  Result := ''; //
end;

function TExpertsPchAccessor.GetFileNameExt: string;
begin
  Result := FExpertsPch.FileNameExt;
end;

function TExpertsPchAccessor.GetFormName: string;
begin
  Result := '';
end;

function TExpertsPchAccessor.GetFileName: string;
var
  Project: IOTAProject;
  AncestorName, ModuleIdent, ClassName, HeaderName : string;
begin
  Project := GetActiveProject;
  AncestorName := ChangeFileExt(ExtractFileName(Project.FileName),'');
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName(AncestorName + 'PCH', ModuleIdent,
  ClassName, HeaderName);
  Result := ExtractFilePath(Project.FileName) + ChangeFileExt(ModuleIdent,'.h');
end;

function TExpertsPchAccessor.GetUnnamed: Boolean;
begin
  Result :=  FExpertsPch.Unnamed;
end;

function TExpertsPchAccessor.NewSourceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsPch.FSourceTemplateFile <> nil then
  begin
    LBuiltInPropertyPairs :=  GetFileTypePropertyPairs('Source', ModuleIdent, FormIdent, AncestorIdent);
    LBuiltInPropertyPairs := MergePropertyPairs(LBuiltInPropertyPairs,
      TStringsPropertiesPairs.Create(FExpertsPch.TemplatePropertiesDoc, False));
    Result := FExpertsPch.FSourceTemplateFile.CreateFile('',
      MergePropertyPairs(LBuiltInPropertyPairs,
        TExpertsPropertiesPairs.Create(FExpertsPch.TemplateProperties)))
  end
  else
    Result := nil;
end;

function TExpertsPchAccessor.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TExpertsPchAccessor.NewInterfaceFile(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

end.
