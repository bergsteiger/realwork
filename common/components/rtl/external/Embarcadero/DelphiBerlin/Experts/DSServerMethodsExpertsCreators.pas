{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerMethodsExpertsCreators;

// Experts creates for server method classes

interface

uses
  SysUtils, Classes, ExpertsTemplates, ExpertsModules, DSServerFeatures;

type
  TDSServerMethodsCreatorModule = class(TDataModule)
    ServerMethodsModuleSourceTemplate: TExpertsTemplateFile;
    DataSnapTemplatePersonalityFiles: TExpertsTemplatePersonalityFiles;
    ServerMethodsModuleIntfTemplate: TExpertsTemplateFile;
    ServerMethodsModule: TExpertsModule;
    ServerMethodUnitSourceTemplate: TExpertsTemplateFile;
    ServerMethodsUnitIntfTemplate: TExpertsTemplateFile;
    ServerMethodsClassUnit: TExpertsClassUnit;
    CommonTemplateProperties: TExpertsTemplateProperties;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateServerMethodsClass(ASelectedClassName: TDSServerClassName;
      const APersonality: string; out AModuleIdent, AFormIdent,
      AAncestorIdent: string; AProperties: TStrings);
  end;

  TDSServerMethodsCreatorModuleClass = class of TDSServerMethodsCreatorModule;

implementation

{$R *.dfm}

procedure TDSServerMethodsCreatorModule.CreateServerMethodsClass(ASelectedClassName: TDSServerClassName;
  const APersonality: string; out AModuleIdent, AFormIdent, AAncestorIdent: string; AProperties: TStrings);
begin
  AModuleIdent := '';
  AFormIdent := '';
  AAncestorIdent := '';
  CommonTemplateProperties.Properties := AProperties;

  case ASelectedClassName of
    scComponent:
    begin
      // Create as unit because there is no designer
      ServerMethodsClassUnit.AncestorName := GetAncestorClass(ASelectedClassName);
      ServerMethodsClassUnit.CreateModuleIdents(APersonality, AModuleIdent, AFormIdent, AAncestorIdent);
    end;
    scDataModule,
    scDSServerModule:
    begin
      ServerMethodsModule.AncestorName := GetAncestorClass(ASelectedClassName);
      ServerMethodsModule.CreateModuleIdents(APersonality, AModuleIdent, AFormIdent, AAncestorIdent);
    end
  else
    Assert(False);
  end;
end;

end.
