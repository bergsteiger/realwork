{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsIntf;


interface

uses ToolsAPI, ExpertsProject;

type
  IExpertsProjectAccessor = interface
    ['{5758F0ED-8CE5-48C1-B772-739005977158}']
    function GetCreatorType: string;
    function NewProjectSource(const ProjectName: string): IOTAFile;
    procedure NewDefaultModule;
    function GetFileName: string;
    function GetDirectory: string;
    function GetFrameWorkType: string;
    function GetPlatformTypes: TOSFamilySet;
    function GetUnnamed: Boolean;
  end;

  IExpertsModuleAccessor = interface
    ['{1452FEA7-4A4A-4A34-B7E3-CCB3A6604EDE}']
    function Designing: Boolean;
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
  end;

implementation

end.
