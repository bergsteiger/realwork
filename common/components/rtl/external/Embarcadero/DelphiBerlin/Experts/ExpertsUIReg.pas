{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsUIReg;

interface

uses ToolsAPI, SysUtils;

procedure Register;

implementation

uses ExpertsUIResStrs, Classes,  DesignEditors, DesignIntf,
  Dialogs, Forms, ExpertsUIWizard;


procedure Register;
begin
  RegisterComponents(rsExpertsComponents, [TExpertsWizard, TExpertsFrameWizardPage,
    TExpertsFeaturesWizardPage]);
end;


end.
