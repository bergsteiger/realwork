{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Registration of Web server application and      }
{       internet components                             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit InetWiz;

interface

uses Classes, Forms;

type
  TProjectType = (ptISAPI, ptCGI, ptWinCGI, ptApacheTwo,
    ptIndyForm, ptIndyConsole);
  TProjectTypes = set of TProjectType;

  TWizardOption = (woUknown, woNoCrossplatformCB, woOutputToProjectDirectory, woDBXTerminateThreads,
    woVCLFramework);

  TWizardOptions = set of TWizardOption;

  TCreateWebProjectOption = (wpCrossplatform, wpNamedProject, wpOutputToProjectDirectory, wbDBXTerminateThreads,
    wpVCLFramework);
  TCreateWebProjectOptions = set of TCreateWebProjectOption;
  TFrameWorkType = (frameworkNone, frameworkVCL, frameworkFMX);

  procedure RegisterWebProjectWizards;

procedure Register;

implementation

uses
  ColnEdit, LibHelp, Web.WebConst, NetConst, Windows, Messages, SysUtils, Controls,
  Dialogs, DesignIntf, DesignEditors, Web.HTTPApp, PlatformAPI,
  DMForm, Consts, IStreams, ToolsAPI, DCCStrs, CommonOptionStrs, ExpertsRepository, InetExpertsUI,
  InetExpertsCreators, BCCStrs;

{$R *.res}

type

{ TCustomWebModule }

  TCustomWebModule = class(TDataModuleCustomModule)//TDataModuleDesignerCustomModule)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ValidateComponent(Component: TComponent); override;
  end;


{ TCustomWebModule }

procEdure TCustomWebModule.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
  begin
                                             
    ShowCollectionEditor({TForm(Root.Owner).}Designer, Root,
      TCustomWebDispatcher(Root).Actions, 'Actions');
  end;
end;

function TCustomWebModule.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := sEditURLMap
  else Result := '';
end;

function TCustomWebModule.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TCustomWebModule.ValidateComponent(Component: TComponent);
begin
  if (Component = nil) or (Component is TControl) then
    raise Exception.CreateRes(@SControlInWebModule);
end;

{ Register procedure }

procedure RegisterWebProjectWizard(const APersonality: string);
begin
  RegisterPackageWizard(TExpertsRepositoryProjectWizardWithProc.Create(APersonality,
    sNewWebModuleExpertComment, sNewWebModuleExpertName,   'Borland.NewWebModule',  // do not localize
    sNewPage,
      'Embarcadero', // do not localize
    procedure
    var
      LUIModule: TInetExpertsUIModule;
    begin
      LUIModule := TInetExpertsUIModule.Create(nil);
      try
        LUIModule.ShowPlatformsPage := False;
        LUIModule.WebServerProjectWizard.Execute(
          procedure
          var
            LModule: TInetExpertsCreatorsModule;
          begin
            LModule := TInetExpertsCreatorsModule.Create(nil);
            try
              LModule.WebProject.PlatformTypes := LUIModule.PlatformTypes;
              LModule.WebProject.FrameWorkType := LUIModule.GetFrameWorkType;
              // Set personality so the correct template files are used
              LModule.Personality := APersonality;
              // Indicate which type of project to create
              LModule.ProjectType := LUIModule.ProjectType;
              // Indicate port
              LModule.HTTPPort := LUIModule.HTTPPort;

              LModule.HTTPS := LUIModule.HTTPS;
              LModule.CertFileInfo := LUIModule.CertFileInfo;
              LModule.ApacheInfo := LUIModule.ApacheInfo;

              LModule.WebProject.CreateProject(APersonality);
            finally
              LModule.Free;
            end;
          end);
      finally
        LUIModule.Free;
      end;
    end,
    function: Cardinal
    begin
      Result := LoadIcon(HInstance, 'WEBAPP')
    end,
    TArray<string>.Create(cWin32Platform, cWin64Platform),
    TArray<string>.Create()
    ) as IOTAWizard);
end;

procedure RegisterWebProjectWizards;
begin
  RegisterWebProjectWizard(sDelphiPersonality);
  RegisterWebProjectWizard(sCBuilderPersonality);
end;

procedure Register;
begin
  // Make module designable
  RegisterCustomModule(TWebModule, TCustomWebModule);
  // Note tha webbroker wizards are registered in a different package
end;




end.
