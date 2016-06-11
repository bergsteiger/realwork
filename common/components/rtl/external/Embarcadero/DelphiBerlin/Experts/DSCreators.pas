{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSCreators;


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

  TModuleCreator = class(TCreator, IOTACreator, IOTAModuleCreator)
  private
    FHaveNames: Boolean;
    FFormName: string;
    FImplFileName: string;
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
  protected
    function GetModuleAndClassNamePrefix: String; virtual;
  end;


implementation

uses DsServerDsnResStrs;


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

{ TModuleCreator }

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

// Override to define a form and unitname prefix
function TModuleCreator.GetModuleAndClassNamePrefix: String;
begin
  Result := '';
end;

procedure TModuleCreator.GetNewModuleAndClassName(out AFormName: string; out AImplFileName: string);
var
  LUnitIdent: string;
  LClassName: string;
  LFileName: string;
begin
  if not FHaveNames then
  begin
    FHaveNames := True;
    LClassName := GetModuleAndClassNamePrefix;
    if LClassName <> '' then
    begin
      (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName(LClassName + 'Unit',   // Do not localize
         LUnitIdent, LClassName, LFileName);
      FImplFileName := LFileName;
      FFormName := LClassName;
    end;
  end;
  AFormName := FFormName;
  AImplFileName := FImplFileName;
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

end.
