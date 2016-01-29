{ ********************************************************************** }
{                                                                        }
{ Delphi and Kylix Cross-Platform Open Tools API                         }
{                                                                        }
{ Copyright (C) 2000, 2001 Borland Software Corporation                  }
{                                                                        }
{ ********************************************************************** }


unit StFilSys;

interface

{$IFDEF MSWINDOWS}
uses Windows, ActiveX, SysUtils, Classes, IStreams, TypInfo, ToolsAPI;
{$ENDIF}
{$IFDEF Linux}
uses Types, SysUtils, Classes, IStreams, TypInfo, ToolsAPI;
{$ENDIF}

const
  sTStringsFileSystem = 'Delphi.TStringsFileSystem';

type
  TActiveTStringsProperty = class;

  { TOTANotifier }

  TOTANotifier = class(TNotifierObject)
  protected
    FOwner: TActiveTStringsProperty;
    { IOTANotifier }
    procedure Destroyed;
  public
    constructor Create(AOwner: TActiveTStringsProperty);
  end;

  { TOTAModuleNotifier }

  TOTAModuleNotifier = class(TOTANotifier, IOTANotifier, IOTAModuleNotifier)
  protected
    { IOTANotifier }
    procedure Modified;
    { IOTAModuleNotifier }
    function CheckOverwrite: Boolean;
    procedure ModuleRenamed(const NewName: string);
  end;

  { TOTAFormNotifier }

  TOTAFormNotifier = class(TOTANotifier, IOTANotifier, IOTAFormNotifier)
  protected
    { IOTAFormNotifier }
    procedure FormActivated;
    procedure FormSaving;
    procedure ComponentRenamed(ComponentHandle: TOTAHandle;
      const OldName, NewName: string);
  end;

  { TActiveTStringsProperty }

  TActiveTStringsProperty = class(TComponent)
  private
    FComponent: TComponent;
    FPropertyName: string;
    FModule: IOTAModule;
    FFormEditor: IOTAFormEditor;
    FModuleNotifier: IOTAModuleNotifier;
    FFormModuleNotifier: IOTAFormNotifier;
    FIndex: Integer;
    FModuleNotifierIndex, FFormNotifierIndex: Integer;
    FDiskAge: Longint;
    procedure SetModule(const Value: IOTAModule);
    procedure SetComponent(Value: TComponent);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor CreateNew(AOwner, AComponent: TComponent;
      const APropertyName: string);
    destructor Destroy; override;
    procedure RenameComponent(const OldName, NewName: string);
    property Module: IOTAModule read FModule write SetModule;
    property Component: TComponent read FComponent write SetComponent;
    property PropertyName: string read FPropertyName write FPropertyName;
    property DiskAge: Longint read FDiskAge write FDiskAge;
  end;

  { TStringsStream }

  TStringsStream = class(TIMemoryStream)
  private
    FComponent: TComponent;
    FStringsProperty: TStrings;
    FActiveTStringsProperty: TActiveTStringsProperty;
    FModified: Boolean;
    constructor Create(ActiveTStringsProperty: TActiveTStringsProperty;
      AComponent: TComponent; const APropName: string; Mode: Integer);
    procedure SetDesignerModified;
  public
    destructor Destroy; override;
    function Write(pv: Pointer; cb: Longint; pcbWritten: PLongint): HResult; override;
  end;

  { TStringsFileSystem }

  TStringsFileSystem = class(TInterfacedObject, IOTAFileSystem)
  private
    FActiveTStringsProperties: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetTStringsProperty(const IDent: string;
      AComponent: TComponent; const APropertyName: string): TActiveTStringsProperty;
    function GetFileStream(const FileName: string; Mode: Integer): IStream;
    function FileAge(const FileName: string): Longint;
    function RenameFile(const OldName, NewName: string): Boolean;
    function IsReadonly(const FileName: string): Boolean;
    function IsFileBased: Boolean;
    function DeleteFile(const FileName: string): Boolean;
    function FileExists(const FileName: string): Boolean;
    function GetTempFileName(const FileName: string): string;
    function GetBackupFileName(const FileName: string): string;
    function GetIDString: string;
  end;

var
  StringsFileSystem: TStringsFileSystem = nil;
  StringsFileSystemCounter: IUnknown;
  StringsFileSystemIndex: Integer;

procedure Register;
procedure Unregister;

implementation

{$IFDEF MSWINDOWS}
uses Forms, DesignConst, ComponentDesigner;
{$ENDIF}
{$IFDEF LINUX}
uses QForms, DesignConst, ComponentDesigner;
{$ENDIF}

type
  TComponentHack = class(TComponent);

procedure SplitComponentName(const Ident: string; var Idents: array of string);
var
  ID: string;
  DotPos: Integer;
  I: Integer;
begin
  ID := Ident;
  for I := Low(Idents) to High(Idents) do
  begin
    DotPos := Pos(DotSep, ID);
    if DotPos > 0 then
      Idents[I] := Copy(ID, 1, DotPos - 1)
    else Idents[I] := ID;
    if I < High(IDents) then Delete(ID, 1, DotPos + Length(DotSep) - 1);
  end;
end;

procedure FindFormAndComponent(const IDent: string;
  var Component: TComponent; var APropName: string);
var
  NameComponents: array[0..2] of string;
  LibForm: IRoot;
begin
  Component := nil;
  SplitComponentName(Ident, NameComponents);
  LibForm := ActiveDesigner.FindRoot(NameComponents[0]);
  if LibForm = nil then
  begin
    ActiveDesigner.Environment.OpenRoot(NameComponents[0], False);
    LibForm := ActiveDesigner.FindRoot(NameComponents[0]);
  end;
  if LibForm <> nil then
    Component := LibForm.Root.FindComponent(NameComponents[1]);
  if Component <> nil then APropName := NameComponents[2];
end;

{ TOTANotifier }

constructor TOTANotifier.Create(AOwner: TActiveTStringsProperty);
begin
  inherited Create;
  FOwner := AOWner;
end;

procedure TOTANotifier.Destroyed;
begin
  FOwner.Free;
end;

{ TOTAModuleNotifier }

function TOTAModuleNotifier.CheckOverwrite: Boolean;
begin
  Result := True;
end;

procedure TOTAModuleNotifier.Modified;
begin
  //if FOwner.FFormEditor <> nil then FOwner.FFormEditor.MarkModified;
end;

procedure TOTAModuleNotifier.ModuleRenamed(const NewName: string);
begin
  if AnsiCompareFileName(StringsFileSystem.FActiveTStringsProperties[FOwner.FIndex],
    FOwner.FModule.FileName) <> 0 then
  begin
    FOwner.Module.FileSystem := ''; {Reset the file system to the default}
    FOwner.Free;
  end;
end;

{ TOTAFormNotifier }

procedure TOTAFormNotifier.ComponentRenamed(ComponentHandle: TOTAHandle;
  const OldName, NewName: string);
begin
  FOwner.RenameComponent(OldName, NewName);
end;

procedure TOTAFormNotifier.FormActivated;
begin
end;

procedure TOTAFormNotifier.FormSaving;
begin
  FOwner.FModule.Save(False, False);
end;

{ TActiveTStringsProperty }

constructor TActiveTStringsProperty.CreateNew(AOwner, AComponent: TComponent;
  const APropertyName: string);
begin
  inherited Create(AOwner);
  FModuleNotifier := TOTAModuleNotifier.Create(Self);
  FFormModuleNotifier := TOTAFormNotifier.Create(Self);
  SetComponent(AComponent);
  FPropertyName := APropertyName;
end;

destructor TActiveTStringsProperty.Destroy;
begin
  with StringsFileSystem.FActiveTStringsProperties do
    Delete(IndexOfObject(Self));
  SetModule(nil);
  if FFormEditor <> nil then
    FFormEditor.RemoveNotifier(FFormNotifierIndex);
  inherited Destroy;
end;

procedure TActiveTStringsProperty.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FComponent) and (Operation = opRemove) and
    (FModule <> nil) then FModule.CloseModule(True);
end;

procedure TActiveTStringsProperty.RenameComponent(const OldName, NewName: string);
var
  NewModuleName: string;
begin
  if CompareText(FComponent.Name, OldName) = 0 then
    NewModuleName := Format('%s.%s.%s', [FComponent.Owner.Name, NewName,
      FPropertyName])
  else if CompareText(FComponent.Owner.Name, OldName) = 0 then
    NewModuleName := Format('%s.%s.%s', [NewName, FComponent.Name,
      FPropertyName]);
  if NewModuleName <> '' then
  begin
    StringsFileSystem.FActiveTStringsProperties[FIndex] := NewModuleName;
    FModule.SetFileName(NewModuleName);
  end;
end;

procedure TActiveTStringsProperty.SetModule(const Value: IOTAModule);
begin
  if FModule <> nil then
  begin
    if FModuleNotifier <> nil then
      FModule.RemoveNotifier(FModuleNotifierIndex);
    FModule := nil;
  end;
  FModule := Value;
  if (FModule<> nil) and (FModuleNotifier <> nil) then
    FModuleNotifierIndex := FModule.AddNotifier(FModuleNotifier);
end;

procedure TActiveTStringsProperty.SetComponent(Value: TComponent);
var
  ModuleServices: IOTAModuleServices;
  FormModule: IOTAModule;
begin
  if Value <> FComponent then
  begin
    if FComponent <> nil then
    begin
      Notification(FComponent, opRemove);
      TComponentHack(FComponent).Notification(Self, opRemove);
      if FFormEditor <> nil then
        FFormEditor.RemoveNotifier(FFormNotifierIndex);
      FFormEditor := nil;
    end;
    FComponent := Value;
    if FComponent <> nil then
    begin
      FComponent.FreeNotification(Self);
      ModuleServices := BorlandIDEServices as IOTAModuleServices;
      FormModule := ModuleServices.FindFormModule(FComponent.Owner.Name);
      Assert(FormModule <> nil, 'Cannot Locate Form Module!'); //Do not localize
      Assert(FormModule.GetModuleFileCount > 1, 'Not a Form Module'); //Do not localize
      FFormEditor := FormModule.GetModuleFileEditor(1) as IOTAFormEditor;
      FFormNotifierIndex := FFormEditor.AddNotifier(FFormModuleNotifier);
    end;
  end;
end;

{ TStringsStream }

constructor TStringsStream.Create(ActiveTStringsProperty: TActiveTStringsProperty;
  AComponent: TComponent; const APropName: string; Mode: Integer);
var
  PropInfo: PPropInfo;
begin
  inherited Create(nil, soOwned);  // creates owned memory stream for us
  FComponent := AComponent;
  FActiveTStringsProperty := ActiveTStringsProperty;
  SetModifyTime(FActiveTStringsProperty.DiskAge);
  PropInfo := GetPropInfo(AComponent.ClassInfo, APropName);
  if PropInfo = nil then
    raise Exception.CreateResFmt(@sCantFindProperty, [APropName, AComponent.Name]);
  FStringsProperty := TStrings(GetOrdProp(AComponent, PropInfo));
  if FStringsProperty = nil then
    raise Exception.CreateResFmt(@sStringsPropertyInvalid, [APropName,
      AComponent.Name]);
  if Mode <> fmCreate then FStringsProperty.SaveToStream(MemoryStream);
  MemoryStream.Position := 0;
end;

destructor TStringsStream.Destroy;
begin
  if FModified then
  begin
    MemoryStream.Position := 0;
    FStringsProperty.LoadFromStream(MemoryStream);
    FActiveTStringsProperty.DiskAge := GetModifyTime;
    SetDesignerModified;
  end;
  inherited Destroy;
end;

function TStringsStream.Write(pv: Pointer; cb: Longint; pcbWritten: PLongint): HResult;
begin
  Result := inherited Write(pv, cb, pcbWritten);
  if (cb > 0) and (Result = 0) then FModified := True;
end;

procedure TStringsStream.SetDesignerModified;  
var
  Designer: IDesignerNotify;
begin
  Designer := FindRootDesigner(FComponent);
  if Designer <> nil then
    Designer.Modified;
end;

{ TStringsFileSystem }

constructor TStringsFileSystem.Create;
begin
  inherited Create;
  FActiveTStringsProperties := TStringList.Create;
end;

destructor TStringsFileSystem.Destroy;
begin
  FActiveTStringsProperties.Free;
  inherited Destroy;
end;

function TStringsFileSystem.GetTStringsProperty(const Ident: string;
  AComponent: TComponent; const APropertyName: string): TActiveTStringsProperty;
var
  Index: Integer;
begin
  Index := FActiveTStringsProperties.IndexOf(Ident);
  if Index > -1 then
    TObject(Result) := FActiveTStringsProperties.Objects[Index]
  else
  begin
    Result := TActiveTStringsProperty.CreateNew(Application, AComponent,
      APropertyName);
    Result.Module := (BorlandIDEServices as IOTAModuleServices).FindModule(Ident);
    Result.FIndex := FActiveTStringsProperties.AddObject(Ident, Result);
  end;
end;


{$IFDEF MSWINDOWS}
function TStringsFileSystem.GetFileStream(const FileName: string; Mode: Integer): ActiveX.IStream;
{$ENDIF}
{$IFDEF Linux}
function TStringsFileSystem.GetFileStream(const FileName: string; Mode: Integer): Types.IStream;
{$ENDIF}
var
  Component: TComponent;
  PropertyName: string;

  procedure Error;
  begin
    raise Exception.CreateResFmt(@sUnableToFindComponent, [FileName]);
  end;

begin
  Result := nil;
  FindFormAndComponent(FileName, Component, PropertyName);
  if Component <> nil then
    Result := TStringsStream.Create(GetTStringsProperty(FileName, Component,
      PropertyName), Component, PropertyName, Mode)
  else Error;
end;

function TStringsFileSystem.FileAge(const FileName: string): Longint;
var
  ActiveTStringsProperty: TActiveTStringsProperty;
  Index: Integer;
begin
  Index := FActiveTStringsProperties.IndexOf(FileName);
  if Index > -1 then
  begin
    TObject(ActiveTStringsProperty) := FActiveTStringsProperties.Objects[Index];
    Result := ActiveTStringsProperty.DiskAge;
  end else Result := -1;
end;

function TStringsFileSystem.RenameFile(const OldName, NewName: string): Boolean;
begin
  Result := True;
end;

function TStringsFileSystem.IsReadonly(const FileName: string): Boolean;
begin
  Result := False;
end;

function TStringsFileSystem.IsFileBased: Boolean;
begin
  Result := False;
end;

function TStringsFileSystem.DeleteFile(const FileName: string): Boolean;
begin
  Result := True;
end;

function TStringsFileSystem.FileExists(const FileName: string): Boolean;
begin
  Result := FActiveTStringsProperties.IndexOf(FileName) <> -1;
end;

function TStringsFileSystem.GetTempFileName(const FileName: string): string;
begin
  Result := FileName;
end;

function TStringsFileSystem.GetBackupFileName(const FileName: string): string;
begin
  Result := FileName;
end;

function TStringsFileSystem.GetIDString: string;
begin
  Result := sTStringsFileSystem;
end;

procedure Register;
var
  ModuleServices: IOTAModuleServices;
begin
  if (StringsFileSystem = nil) and
    Supports(BorlandIDEServices, IOTAModuleServices, ModuleServices) then
  begin
    StringsFileSystem := TStringsFileSystem.Create;
    StringsFileSystemCounter := StringsFileSystem;
    StringsFileSystemIndex := ModuleServices.AddFileSystem(StringsFileSystem);
    if StringsFileSystemIndex < 0 then
    begin
      StringsFileSystem := nil;
      StringsFileSystemCounter := nil;
    end;
  end;
end;

procedure Unregister;
var
  ModuleServices: IOTAModuleServices;
begin
  if (StringsFileSystemIndex > -1) and
    Supports(BorlandIDEServices, IOTAModuleServices, ModuleServices) then
  begin
    StringsFileSystem := nil;
    StringsFileSystemCounter := nil;
    ModuleServices.RemoveFileSystem(StringsFileSystemIndex);
  end;
end;

end.
