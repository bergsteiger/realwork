{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsReg;

interface

uses ToolsAPI, SysUtils, StrEdit;

procedure Register;

implementation

uses ExpertsResStrs, ExpertsProject, ExpertsModules, Classes, ExpertsTemplates, DesignEditors, DesignIntf,
  Dialogs, Forms;

type
{ TTemplateFilePropertyEditor }

  TTemplateFilePropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TCustomExpertsTemplateFileComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure Edit; override;
  end;

  TCustomExpertsTemplatePersonalityFilesEditor = class(TComponentEditor)
  private
    FFiles: TStrings;
    function GetFiles: TStrings;
  public
    destructor Destroy; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure Edit; override;
  end;


  TCustomExpertsModuleComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure Edit; override;
  end;


procedure Register;
begin
//  RegisterPropertyEditor(TypeInfo(TFileName), TCustomExpertsTemplateFile, 'TemplateFile',
//    TTemplateFilePropertyEditor);
//  RegisterPropertyEditor(TypeInfo(TFileName), TCustomExpertsModule, 'TemplateFile',
//    TTemplateFilePropertyEditor);
//  RegisterPropertyEditor(TypeInfo(TFileName), TCustomExpertsUnit, 'TemplateFile',
//    TTemplateFilePropertyEditor);
//  RegisterPropertyEditor(TypeInfo(TFileName), TCustomExpertsClassUnit, 'TemplateFile',
//    TTemplateFilePropertyEditor);
//  RegisterPropertyEditor(TypeInfo(TFileName), TCustomExpertsTextFile, 'TemplateFile',
//    TTemplateFilePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TFileName), TExpertsModulesComponent, 'TemplateFile',
    TTemplateFilePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TFileName), TExpertsTemplatePersonalityFiles, 'DelphiTemplateFile',
    TTemplateFilePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TFileName), TExpertsTemplatePersonalityFiles, 'CBuilderTemplateFile',
    TTemplateFilePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TFileName), TExpertsTemplatePersonalityFiles, 'GenericTemplateFile',
    TTemplateFilePropertyEditor);

  RegisterPropertyEditor(TypeInfo(TStrings), TCustomExpertsTemplateProperties, 'Properties', TValueListProperty);

//  RegisterPropertyEditor(TypeInfo(TStrings), TCustomExpertsModule, 'TemplatePropertiesDoc', TValueListProperty);
//  RegisterPropertyEditor(TypeInfo(TStrings), TCustomExpertsUnit, 'TemplatePropertiesDoc', TValueListProperty);
//  RegisterPropertyEditor(TypeInfo(TStrings), TCustomExpertsClassUnit, 'TemplatePropertiesDoc', TValueListProperty);
//  RegisterPropertyEditor(TypeInfo(TStrings), TCustomExpertsTextFile, 'TemplatePropertiesDoc', TValueListProperty);
//  RegisterPropertyEditor(TypeInfo(TStrings), TCustomExpertsProject, 'TemplatePropertiesDoc', TValueListProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TExpertsModulesComponent, 'TemplatePropertiesDoc', TValueListProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TExpertsTemplateFile, 'TemplatePropertiesDoc', TValueListProperty);

  RegisterComponents(rsExpertsComponents, [TExpertsProject, TExpertsTemplateFile, TExpertsTemplateProperties,
    TExpertsModule, TExpertsUnit, TExpertsTextFile, TExpertsClassUnit, TExpertsPchModule, TExpertsTemplatePersonalityFiles]);
  RegisterComponentEditor(TCustomExpertsTemplateFile, TCustomExpertsTemplateFileComponentEditor);
  RegisterComponentEditor(TExpertsPersonalityModuleComponent, TCustomExpertsModuleComponentEditor);
  RegisterComponentEditor(TExpertsGenericModuleComponent, TCustomExpertsModuleComponentEditor);
  RegisterComponentEditor(TCustomExpertsTemplatePersonalityFiles, TCustomExpertsTemplatePersonalityFilesEditor);
end;

{ TTemplateFilePropertyEditor }

resourcestring
  SOpenFileTitle = 'Open';
  sCreateSampleModuleCommand = 'Create sample module';
  sCreateDelphiSampleModuleCommand = 'Create Delphi sample module';
  sCreateCBuilderSampleModuleCommand = 'Create CBuilder sample module';
  sTemplateFileFilter = 'Source File(*.pas; *.cpp; *.txt)|*.pas;*.cpp;*.txt|Any file (*.*)|*.*';
  sOpenTemplateFileCommand = 'Open %s';
  sFileNotFound = 'File not found: %s';

procedure TCustomExpertsTemplateFileComponentEditor.Edit;
begin
  //do nothing
end;

procedure TCustomExpertsTemplateFileComponentEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
  LComponent: TCustomExpertsTemplateFile;
  LFile: string;
begin
  LComponent := TCustomExpertsTemplateFile(Component);
  I := inherited GetVerbCount;
  if Index < I then
    inherited
  else
  begin
    i := Index - I;
    case I of
      0:
      try
        if not FindTemplateFile(LComponent.TemplateFile, LFile) then
          MessageDlg(Format(sFileNotFound, [LFile]), mtError, [mbOK], 0)
        else
          (BorlandIDEServices as IOTAActionServices).OpenFile(LFile);
//          DocModul.CallDefaultOpenProc(
//            LFile);
      except
        on E: EAbort do
          Exit;
        on E: Exception do
          MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    end;
  end;
end;

//class function TDSDesigntimeProxyGenerator.GetDefaultClientClassesUnitName: string;
//var
//  LUnitIdent, LClassName, LFileName: string;
//begin
//  Result := '';
//  if rsClientClassesUnitName <> '' then
//  begin
//    (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName(rsClientClassesUnitName,
//       LUnitIdent, LClassName, LFileName);
//    Result := LUnitIdent;
//  end;
//end;

function TCustomExpertsTemplateFileComponentEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
  LComponent: TCustomExpertsTemplateFile;
begin
  LComponent := TCustomExpertsTemplateFile(Component);
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited GetVerb(Index)
  else
  begin
    i := Index - I;
    case I of
      0: Result := Format(sOpenTemplateFileCommand, [LComponent.TemplateFile]);
    end;
  end;
end;

function TCustomExpertsTemplateFileComponentEditor.GetVerbCount: Integer;
var
  LComponent: TCustomExpertsTemplateFile;
begin
  LComponent := TCustomExpertsTemplateFile(Component);
  Result := inherited;
  if LComponent.TemplateFile <> '' then
    Result := Result + 1;
end;

destructor TCustomExpertsTemplatePersonalityFilesEditor.Destroy;
begin
  FFiles.Free;
  inherited;
end;

procedure TCustomExpertsTemplatePersonalityFilesEditor.Edit;
begin
  //do nothing
end;

function TCustomExpertsTemplatePersonalityFilesEditor.GetFiles: TStrings;
var
  LComponent: TCustomExpertsTemplatePersonalityFiles;
begin
  if FFiles = nil then
  begin
    LComponent := TCustomExpertsTemplatePersonalityFiles(Component);
    FFiles := TStringList.Create;
    if LComponent.DelphiTemplateFile <> '' then
      FFiles.Add(LComponent.DelphiTemplateFile);
    if LComponent.CBuilderTemplateFile <> '' then
      FFiles.Add(LComponent.CBuilderTemplateFile);
    if LComponent.GenericTemplateFile <> '' then
      FFiles.Add(LComponent.GenericTemplateFile);
  end;
  Result := FFiles;
end;

procedure TCustomExpertsTemplatePersonalityFilesEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
  LFile: string;
begin
  I := inherited GetVerbCount;
  if Index < I then
    inherited
  else
  begin
    i := Index - I;
    try
      if not FindTemplateFile(GetFiles[I], LFile) then
        MessageDlg(Format(sFileNotFound, [LFile]), mtError, [mbOK], 0)
      else
        (BorlandIDEServices as IOTAActionServices).OpenFile(LFile);
//          DocModul.CallDefaultOpenProc(
//            LFile);
    except
      on E: EAbort do
        Exit;
      on E: Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;

//class function TDSDesigntimeProxyGenerator.GetDefaultClientClassesUnitName: string;
//var
//  LUnitIdent, LClassName, LFileName: string;
//begin
//  Result := '';
//  if rsClientClassesUnitName <> '' then
//  begin
//    (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName(rsClientClassesUnitName,
//       LUnitIdent, LClassName, LFileName);
//    Result := LUnitIdent;
//  end;
//end;

function TCustomExpertsTemplatePersonalityFilesEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited GetVerb(Index)
  else
  begin
    i := Index - I;
    Result := Format(sOpenTemplateFileCommand, [GetFiles[I]])
  end;
end;

function TCustomExpertsTemplatePersonalityFilesEditor.GetVerbCount: Integer;
var
  LComponent: TCustomExpertsTemplateFile;
begin
  LComponent := TCustomExpertsTemplateFile(Component);
  Result := inherited;
  if LComponent.TemplateFile <> '' then
    Result := Result + GetFiles.Count;
end;

{ TCustomExpertsModuleComponentEditor }

procedure TCustomExpertsModuleComponentEditor.Edit;
begin
  //do nothing
end;

resourcestring
  sUnexpectedClass = 'Unexpected class: %';

function PersonalityExists(const APersonality: string): Boolean;
begin
  Result := PersonalityServices.PersonalityExists(APersonality);
end;

procedure ExecuteInPersonality(const APersonality: string; ACallback: TProc);
var
  LCurrentPersonality: string;
begin
  LCurrentPersonality := PersonalityServices.CurrentPersonality;
  try
    PersonalityServices.CurrentPersonality := APersonality;
    ACallback();
  finally
    PersonalityServices.CurrentPersonality := LCurrentPersonality;
  end;
end;

procedure TCustomExpertsModuleComponentEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
  LComponent: TExpertsModulesComponent;
begin
  LComponent := TExpertsModulesComponent(Component);
  I := inherited GetVerbCount;
  if Index < I then
    inherited
  else
  begin
    i := Index - I;
    case I of
      0:
        // Prompt for personality
        if LComponent is TExpertsPersonalityModuleComponent then
          ExecuteInPersonality(sDelphiPersonality,
            procedure begin
              TExpertsPersonalityModuleComponent(LComponent).CreateModule(sDelphiPersonality)
            end)
        else if LComponent is TExpertsGenericModuleComponent then
          TExpertsGenericModuleComponent(LComponent).CreateModule
        else
          raise Exception.CreateFmt(sUnexpectedClass, [LComponent.ClassName]);
      1:
        // Prompt for personality
        if LComponent is TExpertsPersonalityModuleComponent then
          ExecuteInPersonality(sCBuilderPersonality,
            procedure begin
              TExpertsPersonalityModuleComponent(LComponent).CreateModule(sCBuilderPersonality)
            end)
        else
          raise Exception.CreateFmt(sUnexpectedClass, [LComponent.ClassName]);
    end;
  end;
end;

function TCustomExpertsModuleComponentEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
  LComponent: TExpertsModulesComponent;
begin
  LComponent := TExpertsModulesComponent(Component);
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited GetVerb(Index)
  else
  begin
    i := Index - I;
    case I of
      0:
       if LComponent is TExpertsPersonalityModuleComponent then
          Result := sCreateDelphiSampleModuleCommand
       else
         Result := sCreateSampleModuleCommand;
      1: Result := sCreateCBuilderSampleModuleCommand;
    end;
  end;
end;

function TCustomExpertsModuleComponentEditor.GetVerbCount: Integer;
var
  LComponent: TExpertsModulesComponent;
begin
  LComponent := TExpertsModulesComponent(Component);
  Result := inherited;
  //if LComponent.TemplateFile <> '' then
  Result := Result + 1;
  if LComponent is TExpertsPersonalityModuleComponent then
    Result := Result + 1
end;


procedure TTemplateFilePropertyEditor.Edit;
var
  Dialog: Dialogs.TOpenDialog;
  TemplateDir: string;
begin
  TemplateDir := (BorlandIDEServices as IOTAServices).GetTemplateDirectory;
  Dialog := Dialogs.TOpenDialog.Create(Application);
  with Dialog do
  try
    Title := sOpenFileTitle;
    Filename := GetValue;
    if IsRelativePath(FileName) then
      FileName := ExpandFileName(TemplateDir + FileName);
    Filter := sTemplateFileFilter;
    if FileName = '' then
      InitialDir := (BorlandIDEServices as IOTAServices).GetTemplateDirectory;
    HelpContext := 0;                          
    Options := Options + [ofShowHelp, ofPathMustExist, ofHideReadonly, ofFileMustExist];
    if Dialog.Execute then
      SetValue(ExtractRelativePath(TemplateDir, Filename));
  finally
    Free;
  end;
end;

function TTemplateFilePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable, paVCL];
end;

end.
