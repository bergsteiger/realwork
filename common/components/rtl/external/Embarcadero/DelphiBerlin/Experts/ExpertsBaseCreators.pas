{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsBaseCreators;


interface

uses Windows, Messages, SysUtils, Controls,
  Forms, Dialogs, DesignIntf, DesignEditors,
  DMForm, Consts, IStreams, ToolsAPI;


type

  TCreator = class(TInterfacedObject)
  protected
    { IOTACreator }
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
  end;

  TUnitCreator = class(TCreator, IOTACreator, IOTAModuleCreator)
  private
    FNewImplFileName: string;
    FFileName: string;
    function GetNewUnitFileName: string;
  protected
    { IOTACreator }
    function GetCreatorType: string;
    function GetOwner: IOTAModule;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  protected
    constructor Create(const AFileName: string);
  end;

  TTextFileCreator = class(TCreator, IOTACreator, IOTAModuleCreator)
  private
    FNewTextFileName: string;
    FFileName: string;
    FFileNameExt: string;
    procedure GetNewTextFileName(out ATextFileName: string);
  protected
    { IOTACreator }
    function GetCreatorType: string;
    function GetOwner: IOTAModule;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  public
    constructor Create(const AFileName, AFileNameExt: string);
  end;

  TModuleCreator = class(TCreator, IOTACreator, IOTAModuleCreator)
  private
    FHaveNames: Boolean;
    FFormName: string;
    FFileName: string;
    FImplFileName: string;
    FImplFormName: string;
    procedure GetNewModuleAndClassName(out AFormName, AImplFileName: string);
  protected
    { IOTACreator }
    function GetCreatorType: string;
    function GetOwner: IOTAModule;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  public
    constructor Create(const AFileName, AFormName: string);
  end;

  TPchCreator = class(TCreator, IOTACreator, IOTAModuleCreator)
  private
    procedure GetNewPCHFileName(out APCHFileName: string);
  protected
    { IOTACreator }
    function GetCreatorType: string;
    function GetOwner: IOTAModule;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  public
    constructor Create(const AFileName, AFileNameExt: string);
  end;

  TOTAFile = class(TInterfacedObject, IOTAFile)
  private
    FContent: string;
  public
    constructor Create(const AContent: string);
    { IOTAFile }
    function GetSource: string;
    function GetAge: TDateTime;
  end;

function GetNewModuleFileName(const APrefix, AOptionalDirectory,
  AOptionalFileName: string; AUseDefaultFileExt: Boolean; out LSuffix: string; const AExtensions: string = ''): string;
  
implementation

uses ExpertsResStrs, System.Classes;

function GetNewModuleFileName(const APrefix, AOptionalDirectory,
  AOptionalFileName: string; AUseDefaultFileExt: Boolean;
  out LSuffix: string; const AExtensions: string): string;
var
  LServices: IOTAModuleServices;

  function CheckFileExists(const AFileName: string): Boolean;
  begin
    Result := FileExists(AFileName) or
      ((BorlandIDEServices as IOTAModuleServices).FindModule(AFileName) <> nil);
  end;

  function CheckExtensions(const AFileName: string; const AExtensions: TStrings): Boolean;
  var
    Index: Integer;
  begin
    Result := False;
    for Index := 0 to AExtensions.Count - 1 do
    begin
      Result := CheckFileExists(ChangeFileExt(AFileName, AExtensions[Index]));
      if Result then
        Break;
    end;
  end;

  function ModuleOrFileExists(const AFileName: string; const AExtensions: TStrings): Boolean;
  begin
    Result := CheckFileExists(AFileName);
    if (not Result) and (AExtensions <> nil) then
      Result := CheckExtensions(AFileName, AExtensions)
  end;

  function CanFormatFileName(const AFileName: string): Boolean;
  begin
    Result := (Pos('%d', Lowercase(AFileName)) >= 1) or (Pos('%0:d', Lowercase(AFileName)) >= 1);
  end;

  function MakeFileName(const ADirectory, AFileName, AFileExt: string): string; overload;
  begin
    Result := Format('%0:s%1:s%2:d%3:s', [ADirectory, AFileName, AFileExt]);
  end;

  function MakeFileName(const ADirectory, AFileName, AIndex, AFileExt: string): string; overload;
  begin
    Assert(AFileName <> Format(AFileName, [AIndex]));
    Result := MakeFileName(ADirectory, Format(AFileName, [AIndex]), AFileExt);
  end;

  function FindNextAvailableFileName(const AFileName: string; out LSuffix: string; const AExtensions: TStrings): string;
  var
    I: Integer;
    LFileNameFormat: string;
  begin
    LSuffix := '';
    LFileNameFormat := AFileName;
    if not CanFormatFileName(LFileNameFormat) then
      LFileNameFormat := ExtractFilePath(LFileNameFormat) + 
        ChangeFileExt(ExtractFileName(LFileNameFormat), '') + '%d' +
        ExtractFileExt(LFileNameFormat);
    I := 1;
    Result := Format(LFileNameFormat, [I]);
    while ModuleOrFileExists(Result, AExtensions) do
    begin
      Inc(I);
      Result := Format(LFileNameFormat, [I]);
    end;
    LSuffix := IntToStr(I);
  end;

  function GetDefaultFileExt: string;
  var
    LNewTextFileIdent, LNewClassName, LNewFileName: string;
  begin
    LServices.GetNewModuleAndClassName(APrefix,    // Do not localize
      LNewTextFileIdent, LNewClassName, LNewFileName);
    Result := ExtractFileExt(LNewFileName);
  end;
  
  function GetDefaultDirectory: string;
  var
    LNewTextFileIdent, LNewClassName, LNewFileName: string;
  begin
    LServices.GetNewModuleAndClassName(APrefix,    // Do not localize
      LNewTextFileIdent, LNewClassName, LNewFileName);
    Result := ExtractFilePath(LNewFileName);
  end;
var
  LFileName:string;
  LDirectory: string;
  LExtensions: TStrings;
begin
  LExtensions := nil;
  try
    if AExtensions <> '' then
    begin
      LExtensions := TStringList.Create;
      LExtensions.Delimiter := ';';
      LExtensions.DelimitedText := AExtensions;
      Assert(LExtensions.Count >= 1);
    end;

    LSuffix := '';
    LServices := (BorlandIDEServices as IOTAModuleServices);
    if AOptionalFileName = '' then
      LFileName := ChangeFileExt(APrefix + '%d', GetDefaultFileExt) // do not localize
    else
    begin
      LFileName := AOptionalFileName;
      if AUseDefaultFileExt then
        LFileName := ChangeFileExt(LFileName, GetDefaultFileExt);
    end;
    if AOptionalDirectory <> '' then
      LDirectory := ExtractFilePath(AOptionalDirectory)
    else
      LDirectory := GetDefaultDirectory;
    if not CanFormatFileName(LFileName) then
    begin
      Result := LDirectory + LFileName;
      if ModuleOrFileExists(Result, LExtensions) then
        Result := FindNextAvailableFileName(Result, LSuffix, LExtensions);
    end
    else
      Result := FindNextAvailableFileName(LDirectory + LFileName, LSuffix, LExtensions);
  finally
    LExtensions.Free;
  end;
end;

{ TCreator }

function TCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TCreator.GetOwner: IOTAModule;
begin
  Result := nil;
end;

function TCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

{ TUnitCreator }

constructor TUnitCreator.Create(const AFileName: string);
begin
  FFileName := AFileName;
end;

procedure TUnitCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin

end;

function TUnitCreator.GetAncestorName: string;
begin
  Result := '';
end;

function TUnitCreator.GetCreatorType: string;
begin
  Result := sUnit;
end;

function TUnitCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TUnitCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TUnitCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProject;
end;

function TUnitCreator.GetShowForm: Boolean;
begin
  Result := True;
end;

function TUnitCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TUnitCreator.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TUnitCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TUnitCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TUnitCreator.GetNewUnitFileName: string;
var
  LSuffix: string;
begin
  if FNewImplFileName = '' then
  begin
    FNewImplFileName := GetNewModuleFileName('Unit',
      ExtractFilePath(Self.FFileName), ExtractFileName(Self.FFileName), True, LSuffix);
  end;
  Result := FNewImplFileName;
end;

function TUnitCreator.GetFormName: String;
begin
  Result := '';
end;

function TUnitCreator.GetImplFileName: String;
begin
  Result := GetNewUnitFileName;
end;

{ TTextFileCreator }

constructor TTextFileCreator.Create(const AFileName,
  AFileNameExt: string);
begin
  inherited Create;
  FFileName := AFileName;
  if AFileName = '' then
    FFileName := 'Text%d';
  FFileNameExt := AFileNameExt;
end;

procedure TTextFileCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin

end;

function TTextFileCreator.GetAncestorName: string;
begin
  Result := '';
end;

function TTextFileCreator.GetCreatorType: string;
begin
  Result := sText;
end;

function TTextFileCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TTextFileCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TTextFileCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProject;
end;

function TTextFileCreator.GetShowForm: Boolean;
begin
  Result := True;
end;

function TTextFileCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TTextFileCreator.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TTextFileCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TTextFileCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

procedure TTextFileCreator.GetNewTextFileName(out ATextFileName: string);
var
  LSuffix: string;
begin
  if FNewTextFileName = '' then
  begin
    FNewTextFileName := GetNewModuleFileName('Text',
      ExtractFilePath(Self.FFileName),
      ExtractFileName(Self.FFileName) + Self.FFileNameExt, False, LSuffix);
  end;
  ATextFileName := FNewTextFileName;
end;

function TTextFileCreator.GetFormName: String;
begin
  Result := '';
end;

function TTextFileCreator.GetImplFileName: String;
var
  LImplFileName: string;
begin
  GetNewTextFileName(LImplFileName);
  Result := LImplFileName;
end;

{ TModuleCreator }

constructor TModuleCreator.Create(const AFileName, AFormName: string);
begin
  FFileName := AFileName;
  FFormName := AFormName;
end;

procedure TModuleCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin

end;

function TModuleCreator.GetAncestorName: string;
begin
  Result := '';
end;

function TModuleCreator.GetCreatorType: string;
begin
  Result := sForm;
end;

function TModuleCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TModuleCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TModuleCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProject;
end;

function TModuleCreator.GetShowForm: Boolean;
begin
  Result := True;
end;

function TModuleCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TModuleCreator.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TModuleCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TModuleCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

procedure TModuleCreator.GetNewModuleAndClassName(out AFormName: string; out AImplFileName: string);
  function FormExists(const AFormName, AFileName: string): Boolean;
  begin
    // Form can't have same name as the file
    Result :=
      ((BorlandIDEServices as IOTAModuleServices).FindFormModule(AFormName) <> nil) or
      ((AFileName <> '') and SameFileName(ExtractFileName(ChangeFileExt(AFileName, '')),
            AFormName));

  end;
  function CanFormatName(const AName: string): Boolean;
  begin
    Result := (Pos('%d', Lowercase(AName)) >= 1) or (Pos('%0:d', Lowercase(AName)) >= 1);
  end;
var
  LSuffix: string;
  LFormNameFormat: string;
  I: Integer;
begin
  if not FHaveNames then
  begin
    FHaveNames := True;
    if Self.FFileName <> '' then
      FImplFileName := GetNewModuleFileName('Unit',
        ExtractFilePath(Self.FFileName), ExtractFileName(Self.FFileName), True, LSuffix);
    if FFormName <> '' then
    begin
      if CanFormatName(FFormName) and (LSuffix <> '') then
        FImplFormName := Format(FFormName, [StrToInt(LSuffix)]);
      if FormExists(FImplFormName, FImplFileName) then
      begin
        if not CanFormatName(FFormName) then
          LFormNameFormat := FFormName + '%d'
        else
          LFormNameFormat := FFormName;
        I := 1;
        while FormExists(Format(LFormNameFormat, [I]), FImplFileName) do
          Inc(I);
        FImplFormName := Format(LFormNameFormat, [I]);
      end;
    end
  end;
  AImplFileName := FImplFileName;
  AFormName := FImplFormName;
end;

function TModuleCreator.GetFormName: String;
var
  LFormName: string;
  LImplFileName: string;
begin
  GetNewModuleAndClassName(LFormName, LImplFileName);
  Result := LFormName;
end;

function TModuleCreator.GetImplFileName: String;
var
  LFormName: string;
  LImplFileName: string;
begin
  GetNewModuleAndClassName(LFormName, LImplFileName);
  Result := LImplFileName;
end;

{ TOTAFile }

constructor TOTAFile.Create(const AContent: string);
begin
  FContent := AContent;
end;

function TOTAFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TOTAFile.GetSource: string;
begin
  Result := FContent;
end;

{ TPchCreator }

constructor TPchCreator.Create(const AFileName,
  AFileNameExt: string);
begin
  inherited Create;
end;

procedure TPchCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin

end;

function TPchCreator.GetAncestorName: string;
begin
  Result := '';
end;

function TPchCreator.GetCreatorType: string;
begin
  Result := sText;
end;

function TPchCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TPchCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TPchCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProject;
end;

function TPchCreator.GetShowForm: Boolean;
begin
  Result := False;
end;

function TPchCreator.GetShowSource: Boolean;
begin
  Result := False;
end;

function TPchCreator.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TPchCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TPchCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

procedure TPchCreator.GetNewPCHFileName(out APCHFileName: string);
var
  Project: IOTAProject;
  AncestorName, ModuleIdent, ClassName, HeaderName : string;
begin
  Project := GetActiveProject;
  AncestorName := ChangeFileExt(ExtractFileName(Project.FileName),'');
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName(AncestorName + 'PCH', ModuleIdent,
  ClassName, HeaderName);
  APCHFileName := ExtractFilePath(Project.FileName) + ChangeFileExt(ModuleIdent,'.h');
end;

function TPchCreator.GetFormName: String;
begin
  Result := '';
end;

function TPchCreator.GetImplFileName: String;
var
  LImplFileName: string;
begin
  GetNewPCHFileName(LImplFileName);
  Result := LImplFileName;
end;


end.
