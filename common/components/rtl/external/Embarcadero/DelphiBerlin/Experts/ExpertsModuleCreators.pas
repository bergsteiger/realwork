{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsModuleCreators;

interface

uses  Classes, ExpertsBaseCreators, ToolsAPI, ExpertsIntf;

type

  TExpertsNewImplSourceProc = reference to procedure(const ModuleIdent, FormIdent, AncestorIdent: string);
  TExpertsModuleCreator = class(TModuleCreator, IOTAModuleCreator, IOTACreator)
  private
    FExpertsModule: IExpertsModuleAccessor;
    FPersonality: string;
    FOnNewImplSource: TExpertsNewImplSourceProc;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewFormFile(const FormIdent,
      AncestorIdent: string): IOTAFile;
    property Personality: string read FPersonality;
    { IOTACreator }
    function GetUnnamed: Boolean;
    function GetOwner: IOTAModule;
  public
    constructor Create(const APersonality: string; const AExpertsModule: IExpertsModuleAccessor;
      AOnNewImplSource: TExpertsNewImplSourceProc = nil); overload;
  end;

  // Create a module with a formname and ancestor name, but no designer.
  // For example: formname: MyComponentClass, ancestorName: TComponent.
  TExpertsModuleUnitCreator = class(TExpertsModuleCreator, IOTACreator)
  private
    { IOTACreator }
    function GetCreatorType: string;
    function GetOwner: IOTAModule;
  end;

  TExpertsUnitCreator = class(TUnitCreator, IOTAModuleCreator, IOTACreator)
  private
    FExpertsModule: IExpertsModuleAccessor;
    FPersonality: string;
    FOnNewImplSource: TExpertsNewImplSourceProc;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    property Personality: string read FPersonality;
    { IOTACreator }
    function GetUnnamed: Boolean;
    function GetOwner: IOTAModule;
  public
    constructor Create(const APersonality: string; const AExpertsModule: IExpertsModuleAccessor;
      AOnNewImplSource: TExpertsNewImplSourceProc = nil);
  end;

  TExpertsTextFileCreator = class(TTextFileCreator, IOTAModuleCreator, IOTACreator)
  private
    FExpertsModule: IExpertsModuleAccessor;
    { IOTAModuleCreator }
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    { IOTACreator }
    function GetUnnamed: Boolean;
    function GetOwner: IOTAModule;
  public
    constructor Create(const AExpertsModule: IExpertsModuleAccessor);
  end;

  TExpertsPchCreator = class(TPchCreator, IOTAModuleCreator, IOTACreator)
  private
    FExpertsModule: IExpertsModuleAccessor;
    { IOTAModuleCreator }
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    { IOTACreator }
    function GetUnnamed: Boolean;
    function GetOwner: IOTAModule;
  public
    constructor Create(const AExpertsModule: IExpertsModuleAccessor);
  end;


implementation

uses SysUtils;

{ TExpertsModuleCreator }

constructor TExpertsModuleCreator.Create(const APersonality: string; const AExpertsModule: IExpertsModuleAccessor;
  AOnNewImplSource: TExpertsNewImplSourceProc);
begin
  FPersonality := APersonality;
  FExpertsModule := AExpertsModule;
  FOnNewImplSource := AOnNewImplSource;
  inherited Create(AExpertsModule.GetFileName, AExpertsModule.GetFormName);
end;

function TExpertsModuleCreator.GetAncestorName: string;
begin
  Result := FExpertsModule.GetAncestorName;
  if Result = '' then
    Result := 'Form'; // Do not localize
end;

function TExpertsModuleCreator.GetOwner: IOTAModule;
begin
  if FExpertsModule.Designing then
    Result := nil
  else
    Result := inherited;
end;

function TExpertsModuleCreator.GetUnnamed: Boolean;
begin
  if FExpertsModule.Designing then
    Result := True
  else
    Result := FExpertsModule.GetUnnamed;
end;

function TExpertsModuleCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  if Assigned(FOnNewImplSource) then
    FOnNewImplSource(ModuleIdent, FormIdent, AncestorIdent);

  Result := FExpertsModule.NewSourceFile(ModuleIdent, FormIdent, AncestorIdent)
end;

function TExpertsModuleCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  if Personality = sCBuilderPersonality then
  begin
    Result := FExpertsModule.NewInterfaceFile(ModuleIdent, FormIdent, AncestorIdent);
  end
  else
    Result := nil;
end;

function TExpertsModuleCreator.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := FExpertsModule.NewFormFile(FormIdent, AncestorIdent);
end;

{ TExpertsUnitCreator }

constructor TExpertsUnitCreator.Create(const APersonality: string; const AExpertsModule: IExpertsModuleAccessor;
      AOnNewImplSource: TExpertsNewImplSourceProc);
begin
  FPersonality := APersonality;
  FExpertsModule := AExpertsModule;
  FOnNewImplSource := AOnNewImplSource;
  inherited Create(AExpertsModule.GetFileName);
end;

const
  sBlankLine = #13#10#13#10;

  sNewPasUnitSource =
'unit %0:s;'+sBlankLine+
'interface'+sBlankLine+
'implementation'+sBlankLine+
'end.'#13#10;

  sNewCppUnitSource =
'//---------------------------------------------------------------------------'+sBlankLine+
'#pragma hdrstop'+sBlankLine+
'#include "%0:s.h"'+sBlankLine+
'//---------------------------------------------------------------------------'+sBlankLine+
'#pragma package(smart_init)'#13#10;

  sNewCppUnitInterface =
'//---------------------------------------------------------------------------'+sBlankLine+
'#ifndef %0:sH'+sBlankLine+
'#define %0:sH'+sBlankLine+
'//---------------------------------------------------------------------------'+sBlankLine+
'#endif'#13#10;

function TExpertsUnitCreator.GetAncestorName: string;
begin
  Result := FExpertsModule.GetAncestorName;
end;

function TExpertsUnitCreator.GetOwner: IOTAModule;
begin
  if FExpertsModule.Designing then
    Result := nil
  else
    Result := inherited;
end;

function TExpertsUnitCreator.GetUnnamed: Boolean;
begin
  if FExpertsModule.Designing then
    Result := True
  else
    Result := FExpertsModule.GetUnnamed;
end;

function TExpertsUnitCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  if Assigned(FOnNewImplSource) then
    FOnNewImplSource(ModuleIdent, FormIdent, AncestorIdent);
  Result := FExpertsModule.NewSourceFile(ModuleIdent, FormIdent, AncestorIdent);
  if Result = nil then
  begin
    // Must supply a file
    if FPersonality = sDelphiPersonality then
      Result := TOTAFile.Create(Format(sNewPasUnitSource, [ModuleIdent]))
    else if FPersonality = sCBuilderPersonality then
      Result := TOTAFile.Create(Format(sNewCppUnitSource, [ModuleIdent]))
    else
      Result := TOTAFile.Create('')
  end;
end;

function TExpertsUnitCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  if Personality = sCBuilderPersonality then
  begin
    Result := FExpertsModule.NewInterfaceFile(ModuleIdent, FormIdent, AncestorIdent);
    if Result = nil then
    begin
    // Must supply a file
    if FPersonality = sCBuilderPersonality then
      Result := TOTAFile.Create(Format(sNewCppUnitInterface, [ModuleIdent]))
    else
      Result := TOTAFile.Create('')
    end;
  end
  else
    Result := nil;
end;

{ TExpertsTextFileCreator }

constructor TExpertsTextFileCreator.Create(const AExpertsModule: IExpertsModuleAccessor);
begin
  FExpertsModule := AExpertsModule;
  inherited Create(FExpertsModule.GetFileName, FExpertsModule.GetFileNameExt);
end;

function TExpertsTextFileCreator.GetOwner: IOTAModule;
begin
  if FExpertsModule.Designing then
    Result := nil
  else
    Result := inherited;
end;

function TExpertsTextFileCreator.GetUnnamed: Boolean;
begin
  if FExpertsModule.Designing then
    Result := True
  else
    Result := FExpertsModule.GetUnnamed;
end;

function TExpertsTextFileCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := FExpertsModule.NewSourceFile(ModuleIdent, FormIdent, AncestorIdent);
  if Result = nil then
  begin
    // Must supply a file
    Result := TOTAFile.Create('')
  end;
end;

{ TExpertsModuleUnitCreator }

function TExpertsModuleUnitCreator.GetCreatorType: string;
begin
  // No designer
  Result := sUnit;
end;

function TExpertsModuleUnitCreator.GetOwner: IOTAModule;
begin
  if FExpertsModule.Designing then
    Result := nil
  else
    Result := inherited;
end;

{ TExpertsPchCreator }

constructor TExpertsPCHCreator.Create(const AExpertsModule: IExpertsModuleAccessor);
begin
  FExpertsModule := AExpertsModule;
  inherited Create(FExpertsModule.GetFileName, FExpertsModule.GetFileNameExt);
end;

function TExpertsPCHCreator.GetOwner: IOTAModule;
begin
  if FExpertsModule.Designing then
    Result := nil
  else
    Result := inherited;
end;

function TExpertsPCHCreator.GetUnnamed: Boolean;
begin
  if FExpertsModule.Designing then
    Result := True
  else
    Result := FExpertsModule.GetUnnamed;
end;

function TExpertsPCHCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := FExpertsModule.NewSourceFile(ModuleIdent, FormIdent, AncestorIdent);
  if Result = nil then
  begin
    // Must supply a file
    Result := TOTAFile.Create('')
  end;
end;
end.
