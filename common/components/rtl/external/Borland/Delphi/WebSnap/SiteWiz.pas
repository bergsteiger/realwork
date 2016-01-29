{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Registration of WebBroker wizards               }
{                                                       }
{   Copyright (c) 2000-2001 Borland Software Corp.      }
{                                                       }
{*******************************************************}

unit SiteWiz;

interface

uses
  Windows, SysUtils, Classes,
  Dialogs, Forms, ToolsAPI, WebSess, WebDisp, WebAdapt,
  WProdReg, HTTPApp, WebFact, ProdTemplateReg, NwWebPageMod, NwWebDataMod, NwPageFrame, Contnrs,
  WebUsers, InetSource, InetWiz;

const
  sAppServicesProperty = 'AppServices'; // do not localize
  sPageDispatcherProperty = 'PageDispatcher';      // do not localize
  sAdapterDispatcherProperty = 'AdapterDispatcher';  // do not localize
  sDispatchActionsProperty = 'DispatchActions';          // do not localize
  sSessionsProperty = 'Sessions';                          // do not localize
  sLocateFileServiceProperty = 'LocateFileService';                    // do not localize
  sApplicationAdapterProperty = 'ApplicationAdapter';            // do not localize
  sEndUserAdapterProperty = 'EndUserAdapter';                    // do not localize
  sScriptEngineProperty = 'ScriptEngine';                  // do not localize
  sPageProducerProperty = 'PageProducer'; // Do not localize
  sUserListProperty = 'UserListService'; // Do not localize

type
  EWebWizardException = class(Exception);

  TWebAppWizard = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard, IOTARepositoryWizard60, IOTAProjectWizard)
  private
    function PageNameOfClassName(const AClassName: string): string;
  public
    { IOTAWizard }
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string;
    function GetPage: string;
    function GetGlyph: Cardinal;
    { IOTARepositoryWizard60 }
    function GetDesigner: string;
  end;

  TWebModuleWizard = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard, IOTARepositoryWizard60, IOTAFormWizard)
  protected
    FIDString: string;
    FName: string;
    FComment: string;
    FIcon: string;
  protected
    { IOTAWizard }
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    procedure ImplExecute; virtual; abstract;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string;
    function GetPage: string;
    function GetGlyph: Cardinal;
    { IOTARepositoryWizard60 }
    function GetDesigner: string;
  end;

  TNewPageHelper = class
  private
    FSaveTemplate: string;
    FSaveHaveTemplate: Boolean;
    FSelectedProducerInfo: TModulePageProducerInfo;
    FSelectedTemplate: TObject;
    FAccess: TWebPageAccess;
    FPageName: string;
    FPageTitle: string;
    FScriptEngine: string;
    FFrame: TNewPageFrame;
    FTemplate: string;
    FHaveTemplate: Boolean;
    FNewTemplateFile: Boolean;
    FPageNameModified: Boolean;
    FPageTitleModified: Boolean;
    function ExtractTemplate: Boolean;
    procedure ListProducers(S: TStrings);
    procedure ListProducersCallback(AProducerInfo: TModulePageProducerInfo;
      Info: Pointer);
    procedure ListTemplates(S: TStrings; var Default: Integer);
    procedure ListEngines(S: TStrings; var Default: Integer);
    procedure ListTemplatesCallback(ProducerTemplate: TAbstractProducerTemplate;
      Info: Pointer);
    function PageNameOfClassName(const AClassName: string): string;
  public
    constructor Create(AFrame: TNewPageFrame);
    function HaveTemplate: Boolean;
    function GetTemplate: Boolean;
    procedure SaveOptions;
    procedure RestoreOptions;
    property Template: string read FTemplate;
    property Frame: TNewPageFrame read FFrame;
  end;

  TWebPageModuleWizard = class(TWebModuleWizard)
  private
  protected
    procedure ImplExecute; override;
  public
    constructor Create;
  end;

  TWebDataModuleWizard = class(TWebModuleWizard)
  protected
    procedure ImplExecute; override;
  public
    constructor Create;
  end;

  TWebAppServiceType = (wsApplicationAdapter, wsEndUserAdapter,
                        wsPageDispatcher, wsAdapterDispatcher,
                        wsDispatchActions, wsLocateFileService,
                        wsSessions, wsUserList);
  TWebAppServiceTypes = set of TWebAppServiceType;

  TWebAppServiceClasses = array[TWebAppServiceType] of TComponentClass;
  const
  DefaultSelectedServices = [wsAdapterDispatcher, wsPageDispatcher,
    wsApplicationAdapter];
  DefaultServiceClasses: TWebAppServiceClasses = (
                        TApplicationAdapter, TEndUserAdapter,
                        TPageDispatcher, TAdapterDispatcher,
                        TWebDispatcher  , TLocateFileService,
                        TSessionsService, TWebUserList
                        );
  type
  
  TBaseWebProjectCreator = class(TInterfacedObject, IOTACreator, IOTAProjectCreator)
  private
    FServiceClasses: TWebAppServiceClasses;
    FSelectedServices: TWebAppServiceTypes;
    function GetServices: TWebAppServiceClasses;
  protected
    function GetAppModuleCreator: IOTAModuleCreator; virtual; abstract;
  public
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    property CreatorType: string read GetCreatorType;
    property Existing: Boolean read GetExisting;
    property FileSystem: string read GetFileSystem;
    property Owner: IOTAModule read GetOwner;
    property Unnamed: Boolean read GetUnnamed;
    { IOTAProjectCreator }
    function GetFileName: string;
    function GetOptionFileName: string;
    function GetShowSource: Boolean;
    procedure NewDefaultModule;
    function NewOptionSource(const ProjectName: string): IOTAFile;
    procedure NewProjectResource(const Project: IOTAProject);
    function NewProjectSource(const ProjectName: string): IOTAFile;
    property FileName: string read GetFileName;
    property OptionFileName: string read GetOptionFileName;
    property ShowSource: Boolean read GetShowSource;
  end;

  const
    sHTMLComment = ' {*.%s}';
    sCHTMLComment = #13#10'USEADDITIONALFILES("*.%s");';
  type

  TWebProjectWPageModuleCreator = class(TBaseWebProjectCreator)
  private
    FCacheMode: TWebModuleCacheMode;
    FPageName: string;
    FProducerInfo: TModulePageProducerInfo;
    FAccess: TWebPageAccess;
    FTemplate: string;
  protected
    PageTitle: string;
    ScriptEngine: string;
    CreateTemplateFile: Boolean;
    TemplateFileExt: string;
    function GetAppModuleCreator: IOTAModuleCreator; override;
  public
    constructor CreateProject(AProducerInfo: TModulePageProducerInfo; const ATemplate: string; const APageName: string; ACacheMode: TWebModuleCacheMode;
      AAccess: TWebPageAccess);
  end;

  TWebProjectWDataModuleCreator = class(TBaseWebProjectCreator)
  private
    FCacheMode: TWebModuleCacheMode;
  protected
    function GetAppModuleCreator: IOTAModuleCreator; override;
  public
    constructor CreateProject(ACacheMode: TWebModuleCacheMode);
  end;

  TFormComponentsList = class;

  TComponentPropertyItem = class
  public
    PropertyName: string;
    PropertyValue: string;
  end;

  TComponentObjectItem = class
  public
    ComponentName: string;
    ComponentClassName: string;
    ComponentsList: TFormComponentsList;
    destructor Destroy; override;
  end;

  TFormComponentsList = class
  private
    FProperties: TObjectList;
    FObjects: TObjectList;
    function GetPropertyItem(I: Integer): TComponentPropertyItem;
    function GetObjectItem(I: Integer): TComponentObjectItem;
  public
    constructor Create;
    destructor Destroy; override;
    function PropertyCount: Integer;
    property PropertyItems[I: Integer]: TComponentPropertyItem read GetPropertyItem;
    function ObjectCount: Integer;
    property ObjectItems[I: Integer]: TComponentObjectItem read GetObjectItem;
    procedure AddObject(const AComponentName, AComponentClassName: string;
      AComponents: TFormComponentsList);
    procedure AddProperty(const APropertyName, APropertyValue: string);
  end;

  TBaseWebModuleCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    FFileName: string;
    FFormName: string;
    FModuleName: string;
    FAncestorName: string;
    FCacheMode: TWebModuleCacheMode;
    FCreateMode: TWebModuleCreateMode;
    FAccess: TWebPageAccess;
    FUsesUnits: string;
    FComponentsList: TFormComponentsList;
    FHaveComponents: Boolean;
    function MinFormHeight: Integer;
    function MinFormWidth: Integer;
  protected
    PageTitle: string;
    ScriptEngine: string;
    CreateTemplateFile: Boolean;
    TemplateFileExt: string;
    function FormatFields: string;
    function FormatObjects: string;
    function FormatProperties: string;
    constructor CreateModule(const AAncestorName, AFormName, AUsesUnits: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode; AAccess: TWebPageAccess);
    procedure PopulateComponentsList(AList: TFormComponentsList); virtual;
    function GetComponentsList: TFormComponentsList;
    property ComponentsList: TFormComponentsList read GetComponentsList;
  public
    destructor Destroy; override;
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function ImplNewFormFile(const FormIdent, AncestorIdent: string): IOTAFile; virtual;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function ImplNewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile; virtual; abstract;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function ImplNewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile; virtual; abstract;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  end;

  TSiteSourceIndex = (stWebModuleSource, 
                      stWebModuleIntf,
                      stWebAppPageModuleFactory, 
                      stWebAppDataModuleFactory, 
                      stWebPageModuleFactory, 
                      stWebDataModuleFactory);

const

  SiteSourceNames: array[TSiteSourceIndex] of string = (
                      'WebModuleSource', 
                      'WebModuleIntf',
                      'WebAppPageModuleFactory', 
                      'WebAppDataModuleFactory', 
                      'WebPageModuleFactory', 
                      'WebDataModuleFactory');

type

  TBaseWebPageModuleCreator = class(TBaseWebModuleCreator, IOTAAdditionalFilesModuleCreator)
  private
    FSourceIndex: TSiteSourceIndex;
    FIntfIndex: TSiteSourceIndex;
    FFactoryIndex: TSiteSourceIndex;
    FProducerTemplate: string;
    FProducerInfo: TModulePageProducerInfo;
  protected
    procedure PopulateComponentsList(AList: TFormComponentsList); override;
  public
    constructor CreateModule(AProducerInfo: TModulePageProducerInfo; const AAncestorName, AFormName, AUsesUnits: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode; AAccess: TWebPageAccess;
      AFactoryIndex: TSiteSourceIndex;
      const AProducerTemplate: string);
    { IOTAAdditionalFilesModuleCreator }
    function GetAdditionalFilesCount: Integer;
    function NewAdditionalFileSource(I: Integer; const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function GetAdditionalFileName(I: Integer): string;
    function GetAdditionalFileExt(I: Integer): string;
    function ImplNewHTMLSource(const ModuleIdent,
      FormIdent, AncestorIdent: string): IOTAFile; virtual;
    function ImplNewImplSource(const ModuleIdent,
      FormIdent, AncestorIdent: string): IOTAFile; override;
    function ImplNewIntfSource(const ModuleIdent,
      FormIdent, AncestorIdent: string): IOTAFile; override;
  end;

  TBaseWebDataModuleCreator = class(TBaseWebModuleCreator)
  protected
    FSourceIndex: TSiteSourceIndex;
    FIntfIndex: TSiteSourceIndex;
    FFactoryIndex: TSiteSourceIndex;
  public
    constructor CreateModule(const AAncestorName, AFormName, AUsesUnits: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
      AFactoryIndex: TSiteSourceIndex);
    function ImplNewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile; override;
    function ImplNewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile; override;
  end;

  TWebAppDataModuleCreator = class(TBaseWebDataModuleCreator)
  private
    FServices: TWebAppServiceClasses;
  protected
    procedure PopulateComponentsList(AList: TFormComponentsList); override;
  public
    constructor CreateModule(ACacheMode: TWebModuleCacheMode);
    function ImplNewFormFile(const FormIdent, AncestorIdent: string): IOTAFile; override;
  end;

  TWebAppPageModuleCreator = class(TBaseWebPageModuleCreator)
  private
    FServices: TWebAppServiceClasses;
  protected
    procedure PopulateComponentsList(AList: TFormComponentsList); override;
  public
    constructor CreateModule(AProducerInfo: TModulePageProducerInfo; const ATemplate: string; const APageName: string;
      ACacheMode: TWebModuleCacheMode; AAccess: TWebPageAccess);
    { IOTAModuleCreator }
    function ImplNewFormFile(const FormIdent, AncestorIdent: string): IOTAFile; override;
    function GetModuleClassName: string; virtual;
  end;

  TWebPageModuleCreator = class(TBaseWebPageModuleCreator)
  public
    constructor CreateModule(AProducerInfo: TModulePageProducerInfo; const ATemplate: string; const APageName: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode; AAccess: TWebPageAccess;
      AFactoryIndex: TSiteSourceIndex);
    { IOTAModuleCreator }
    function ImplNewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;  override;
    function GetModuleClassName: string; virtual;
  end;

  TWebDataModuleCreator = class(TBaseWebDataModuleCreator)
  public
    constructor CreateModule(
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
      AFactoryIndex: TSiteSourceIndex);
  end;

  TWebModuleCOMFormCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    fFileName: string;
    fFormName: string;
    fModuleName: string;
  public
    constructor CreateModule;
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
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
  end;

  TProjectFile = class(TInterfacedObject, IOTAFile)
  private
    fProjectName: string;
  public
    constructor CreateNamedProject(ProjName: string);
    { IOTAFile }
    function GetSource: string;
    function GetAge: TDateTime;
  end;

  TBaseHTMLFile = class(TInterfacedObject, IOTAFile)
    { IOTAFile }
    function GetSource: string;
    function ImplGetSource: string; virtual; abstract;
    function GetAge: TDateTime;
  end;

  THTMLFile = class(TBaseHTMLFile)
  protected
    FTemplate: string;
  public
    constructor CreateModule(const ATemplate: string);
    function ImplGetSource: string; override;
  end;

  TBaseWebFormFile = class(TInterfacedObject, IOTAFile)
  protected
    FFormIdent: string;
    FObjects: string;
    FProperties: string;
    FMinWidth: Integer;
    FMinHeight: Integer;
  public
    { IOTAFile }
    function GetSource: string;
    function ImplGetSource: string; virtual;
    function GetAge: TDateTime;
    constructor Create(const AFormIdent, AProperties, AObjects: string;
      AMinWidth, AMinHeight: Integer);
  end;

  TBaseWebModuleFile = class(TInterfacedObject, IOTAFile)
  private
    FCreateMode: TWebModuleCreateMode;
    FCacheMode: TWebModuleCacheMode;
    fModuleIdent: string;
    fFormIdent: string;
    fAncestorIdent: string;
    FSourceIndex: TSiteSourceIndex;
    FUsesUnits: string;
    FFactoryIndex: TSiteSourceIndex;
    FAccess: TWebPageAccess;
    FFields: string;
    function FormatFactory: string;
  protected
    PageTitle: string;
    ScriptEngine: string;
    CreateTemplateFile: Boolean;
    TemplateFileExt: string;
    constructor CreateModule(const AModuleIdent, AAncestorName, AFormName, AUsesUnits: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
      AAccess: TWebPageAccess; AFactoryIndex: TSiteSourceIndex;
      const AFields: string);
    function CacheOption: string;
    function CreateOption: string;
    function PageInfo: string;
  public
    { IOTAFile }
    function GetSource: string;
    function ImplGetSource: string; virtual;
    function GetAge: TDateTime;
  end;

  TBaseWebPageModuleFile = class(TBaseWebModuleFile)
  protected
    constructor CreateModule(const AModuleIdent, AAncestorName, AFormName, AUsesUnits: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode; AAccess: TWebPageAccess;
      AFactoryIndex: TSiteSourceIndex;
      const AFields: string);
  end;

  TWebPageModuleFile = class(TBaseWebPageModuleFile)
  public
    constructor CreateModule(const AModuleIdent, AAncestorName, AFormName, AUsesUnits: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode; AAccess: TWebPageAccess;
      AFactoryIndex: TSiteSourceIndex;
      const AFields: string);
  end;

  TBaseWebDataModuleFile = class(TBaseWebModuleFile)
  public
    constructor CreateModule(const AModuleIdent, AAncestorIdent, AFormIdent, AUsesUnits: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
      AFactoryIndex: TSiteSourceIndex;
      const AFields: string);
  end;

  TWebDataModuleFile = class(TBaseWebDataModuleFile);

  TBaseWebModuleIntfFile = class(TInterfacedObject, IOTAFile)
  private
    FFields: string;
    fModuleIdent: string;
    fFormIdent: string;
    fAncestorIdent: string;
    FUsesUnits: string;
    FSourceIndex: TSiteSourceIndex;
  protected
    constructor CreateModule(const AModuleIdent, AFormIdent, AAncestorIdent, AUsesUnits, AFields: string;
      ASourceIndex: TSiteSourceIndex);
  public
    { IOTAFile }
    function GetSource: string;
    function ImplGetIntfSource: string; virtual;
    function GetAge: TDateTime;
  end;

  TWebModuleCOMFormFile = class(TBaseWebModuleFile, IOTAFile)
  private
    fModuleIdent: string;
    fFormIdent: string;
    fAncestorIdent: string;
  public
    constructor CreateModule(const ModuleIdent, FormIdent, AncestorIdent: string);
    { IOTAFile }
    function ImplGetSource: string; override;
  end;

  TWebModuleCOMFormIntfFile = class(TBaseWebModuleIntfFile, IOTAFile)
  private
    fModuleIdent: string;
    fFormIdent: string;
    fAncestorIdent: string;
  public
    constructor CreateModule(const ModuleIdent, FormIdent, AncestorIdent: string);
    { IOTAFile }
    function ImplGetIntfSource: string; override;
  end;

  TStandardProducerTemplates = class(TProducerTemplatesList)
  public
    constructor Create;
  end;

  TProducerTemplatesIndex = (prodtEndUser, 
                             prodtPageLinks, 
                             prodtHTMLStandard,
                             prodtXSLStandard, 
                             prodtXSLDataPacket);

  function GetHTMLSampleImage: string;
  function GetHTMLFileExt: string;
  procedure Register;

const

  ProducerTemplateNames: array[TProducerTemplatesIndex] of string = 
                             ('EndUser', 
                             'PageLinks', 
                             'HTMLStandard',
                             'XSLStandard', 
                             'XSLDataPacket');

implementation

{$R SiteWiz.res}

uses
{$IFDEF MSWINDOWS}
  ActiveX, ComObj,
{$ENDIF}
  WebScript,HTTPProd,
  NwSiteSrv,
  Controls, WebModu, SiteProd,
  Registry, ComponentDesigner, SiteComp;

type

  TSiteSources = class(TInetSources)
  private
    function GetSiteSources(SourceIndex: TSiteSourceIndex): string;
    function GetProducerTemplates(TemplatesIndex: TProducerTemplatesIndex): string;
  public
    property SiteSources[SourceIndex: TSiteSourceIndex]: string read GetSiteSources;
    property ProducerTemplates[TemplatesIndex: TProducerTemplatesIndex]: string read GetProducerTemplates;
    constructor Create;
  end;

var
  ProjectType: TProjectType;
  ProjectCoClassName: string;
  SiteSources: TSiteSources;

resourcestring

  sWebAppComment = 'Creates a WebSnap Application';
  sWebAppName = 'WebSnap Application';

  sWebSnapPageModuleComment = 'Creates a WebSnap Page Module';
  sWebSnapPageModuleName = 'WebSnap Page Module';
  sWebSnapDataModuleComment = 'Creates a WebSnap Data Module';
  sWebSnapDataModuleName = 'WebSnap Data Module';

  sNoActiveProj = 'There is currently no active project.';
  sNewPage = 'WebSnap';

const
  sWebAuthor = 'Borland';
  sWebAppIDString = 'Borland.NewWebSnapApplication';

  sWebSnapPageModuleIDString = 'Borland.NewWebSnapPageModule';
  sWebSnapDataModuleIDString = 'Borland.NewWebSnapDataModule';

  sWebSnapPageModuleIconName = 'SITEPAGEMODULE';
  sWebSnapDataModuleIconName = 'SITEDATAMODULE';
  sWebAppIconName = 'WEBAPP';

{ file scoped variables }

const sProducerTemplateNamespace = 'Borland.SiteReg';

procedure Register;
begin
  RegisterPackageWizard(TWebAppWizard.Create as IOTAProjectWizard);
  RegisterPackageWizard(TWebPageModuleWizard.Create);
  RegisterPackageWizard(TWebDataModuleWizard.Create);
  RegisterProducerTemplates(sProducerTemplateNamespace, TStandardProducerTemplates.Create);

end;

function GetWebAppServices(AServiceClasses: TWebAppServiceClasses;
  ASelectedServices: TWebAppServiceTypes): TWebAppServiceClasses;
var
  I: TWebAppServiceType;
begin
  for I := Low(TWebAppServiceType) to High(TWebAppServiceType) do
  begin
    if I in ASelectedServices then
      Result[I] := AServiceClasses[I]
    else
      Result[I] := nil;
  end;
end;

function GetActiveProjectGroup: IOTAProjectGroup;
var
  ModuleServices: IOTAModuleServices;
  i: Integer;

begin
  Result := nil;
  ModuleServices := BorlandIDEServices as IOTAModuleServices;
  for i := 0 to ModuleServices.ModuleCount - 1 do
    if Succeeded(ModuleServices.Modules[i].QueryInterface(IOTAProjectGroup, Result)) then
      Break;
end;

function GetActiveProject: IOTAProject;
var
  ProjectGroup: IOTAProjectGroup;
  
begin
  Result := nil;
  ProjectGroup := GetActiveProjectGroup;

  if ProjectGroup <> nil then
    Result := ProjectGroup.ActiveProject;
end;

const
  sWebSnapSection = 'WebSnap';

function GetRegKey: string;
begin
  Result := ActiveDesigner.Environment.GetBaseRegKey + '\' + sWebSnapSection;
end;

function GetHTMLFileExt: string;
begin
  if SiteComp.InternetEnvOptions <> nil then
    Result := SiteComp.InternetEnvOptions.HTMLExt
  else
    Result := '';
  if Result <> '' then
  begin
    if Result[1] = '.' then
      Delete(Result, 1, 1);
  end
  else
    Result := 'html'; // Do not localize
end;

function GetHTMLSampleImage: string;
begin
  if SiteComp.InternetEnvOptions <> nil then
    Result := SiteComp.InternetEnvOptions.SampleImageFile
  else
    Result := '';
end;

{ TWebAppWizard }

resourcestring
  sMakeAppModuleName = 'WebAppModule';
function TWebAppWizard.PageNameOfClassName(const AClassName: string): string;
var
  ModuleName: string;
  FormName: string;
  FileName: string;
begin
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName(Format(sMakeAppModuleName, [AClassName]),
    ModuleName, FormName, FileName);
  FileName := FileName + '';
  Result := FormName;
end;

procedure RestoreWebAppDefaults(Dlg: TNewSiteSrvForm); forward;
procedure SaveWebAppDefaults(Dlg: TNewSiteSrvForm); forward;
procedure TWebAppWizard.Execute;
var
  PageCreator: TWebProjectWPageModuleCreator;
  DataModuleCreator: TWebProjectWDataModuleCreator;
  Dlg: TNewSiteSrvForm;
begin
  Dlg := TNewSiteSrvForm.Create(Application);
  with Dlg do
  try
    PageNameOfClassNameCallback := PageNameOfClassName;
    SetServiceClasses(DefaultServiceClasses);
    SetSelectedServices(DefaultSelectedServices);
    {$IFDEF MSWINDOWS}
    RestoreWebAppDefaults(Dlg);
    {$ENDIF MSWINDOWS}
    if ShowModal = mrOK then
    begin
      SiteWiz.ProjectType := ProjectType;
      if CrossPlatform then
        SiteSources.SourceFlags := sfClx
      else
        SiteSources.SourceFlags := sfVcl;
      try
        if ProjectType = ptCOM then
          ProjectCoClassName := CoClassName.Text;
        if AppModuleType <> mtDataModule then
        begin
          PageCreator := TWebProjectWPageModuleCreator.CreateProject(Helper.Frame.SelectedProducerInfo, Helper.FTemplate, PageName, CacheMode,
             Helper.Frame.Access);
          if Helper.Frame.PageTitle <> Helper.Frame.PageName then
            PageCreator.PageTitle := Helper.Frame.PageTitle;
          PageCreator.ScriptEngine := Helper.Frame.ScriptEngine;
          if Helper.Frame.NewTemplateFile then
          begin
            PageCreator.CreateTemplateFile := True;
            PageCreator.TemplateFileExt := Helper.Frame.TemplateFileExt;
          end
          else
            PageCreator.CreateTemplateFile := False;
          PageCreator.FServiceClasses := GetServiceClasses;
          PageCreator.FSelectedServices := GetSelectedServices;
         (BorlandIDEServices as IOTAModuleServices).CreateModule(
           PageCreator);
        end
        else
        begin
          DataModuleCreator := TWebProjectWDataModuleCreator.CreateProject(CacheMode);
          DataModuleCreator.FServiceClasses := GetServiceClasses;
          DataModuleCreator.FSelectedServices := GetSelectedServices;
         (BorlandIDEServices as IOTAModuleServices).CreateModule(
           DataModuleCreator);
        end;
      finally
        SiteSources.SourceFlags := sfActiveDesigner;
      end;
      {$IFDEF MSWINDOWS}
      if Default.Checked then
        SaveWebAppDefaults(Dlg);
      {$ENDIF MSWINDOWS}
    end;
  finally
    Free;
  end;
end;

function TWebAppWizard.GetAuthor: string;
begin
  Result := sWebAuthor;
end;

function TWebAppWizard.GetComment: string;
begin
  Result := sWebAppComment;
end;

{$IFDEF LINUX}
var
  {* XPM *}
  WebAppIco : array[0..44] of pchar = (
  {* width height ncolors chars_per_pixel *}
  '32 32 12 1',
  {* colors *}
  '  c #000000',
  '* c none',
  '. c #00FFFF',
  'X c #00FF00',
  'o c #C0C0C0',
  'O c #008080',
  '+ c #808080',
  '@ c #000080',
  '# c #FFFFFF',
  '$ c #008000',
  '% c #808000',
  '& c #0000FF',
  {* pixels *}
  '************** $$$$$$$@ ********',
  '************ $$XXX$oO&@@@ ******',
  '********** $$$X.X.o.oOo&@@ *****',
  '********* $$$X.X...XX$$$&@@ ****',
  '******** $$$X.#.#..$$$$O$$@@ ***',
  '******* $$$X.#.#...$$$O$%$$@@ **',
  '******* $$X.#.#.#...$$$%$$%$@@ *',
  '****** $$X.#.#.#...X$$%$O$$$@@ *',
  '****** $X.X.#.#.#.o$$$$$%$$$O@@ ',
  '***** $O.X.......oX$$$&&%$$@&@@ ',
  '***** $Xo.o.....o.$$$&&O$&@&@@@@',
  '***** $O.o.o.o.o.o$$$$$%$$&@&@@@',
  '***** $.O.o.o.o.oX$$O$%$%&@&@&@@',
  '***** $O.O.O.O.OX$$OO%$O%$&@&@@@',
  '***** $.O.O.O.OX$$$$%OO$$$$&@&@@',
  '***** $O.O.O.O.$$$$$O%$$$@&$&@@@',
  '***** $OO.O.O.O.O.$$$$$$$$$&@&@@',
  '****** $.O.O.O.O.O.$$$$$$$&@&@@@',
  '&&&&& o O.O.O.O.O.O%$$@&$&@&@&@@',
  '.&.&. #         .O@O$$&$&@&@&@@@',
  '&o&o& # %%o###o%       &@&@&@@ *',
  '&&&&& # %o######o%%%%%% &@&@@ **',
  '@&@&@ # %%##%%%%###+##o @&@@  % ',
  '&@&@& # %o%#%%  %ooooo @@@  %%% ',
  '@&@&@ # %%o%#%o%          %%o% *',
  '@@@@@ # %%%o%#%#%%     %%%#o%% *',
  '@@@@@ o * %%%o#%#o%% %%o#%o%% **',
  '@@@@@ + **** %%o%#o%%o%#%o%% ***',
  ' @ @ ********  %%o#%#%#o%% *****',
  '**************** %%%%%%% *******',
  '********************************',
  '********************************'
  );

function TWebAppWizard.GetGlyph: Cardinal;
begin
  Result := Cardinal(@WebAppIco);
end;
{$ENDIF LINUX}

{$IFDEF MSWINDOWS}
function TWebAppWizard.GetGlyph: Cardinal;
begin
  Result := LoadIcon(Hinstance, PChar(sWebAppIconName));
end;
{$ENDIF MSWINDOWS}

function TWebAppWizard.GetIDString: string;
begin
  Result := sWebAppIDString;
end;

function TWebAppWizard.GetName: string;
begin
  Result := sWebAppName;
end;

function TWebAppWizard.GetPage: string;
begin
  Result := sNewPage;
end;

function TWebAppWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

function TWebAppWizard.GetDesigner: string;
begin
  Result := dAny;
end;

{ TBaseWebProjectCreator }

function TBaseWebProjectCreator.GetCreatorType: string;
begin
  case ProjectType of
    ptCGI: Result := sConsole;
    ptCOM: Result := sApplication;
{$IFDEF MSWINDOWS}
    ptWinCGI: Result := sApplication;
{$ENDIF}
  else
    Result := sLibrary;
  end;
end;

function TBaseWebProjectCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TBaseWebProjectCreator.GetFileName: string;
const
  PROJ_EXT: array [Boolean] of string = ('.bpr', '.dpr');   { do not localize }

var
  i: Integer;
  j: Integer;
  ProjGroup: IOTAProjectGroup;
  Found: Boolean;
  TempFileName: string;
  TempFileName2: string;

begin
  Result := GetCurrentDir + PathDelim + 'Project%d' + PROJ_EXT[IsPascal]; { do not localize }

  ProjGroup := GetActiveProjectGroup;

  if ProjGroup <> nil then
  begin
    for j := 0 to ProjGroup.ProjectCount-1 do
    begin
      Found := False;
      TempFileName2 := Format(Result, [j+1]);

      for i := 0 to ProjGroup.ProjectCount-1 do
      begin
        try
          TempFileName := ProjGroup.Projects[i].FileName;
          if AnsiCompareFileName(ExtractFileName(TempFileName), ExtractFileName(TempFileName2)) = 0 then
          begin
            Found := True;
            Break;
          end;
        except on E: Exception do
          if not (E is EIntfCastError) then
            raise; 
        end;
      end;

      if not Found then
      begin
        Result := TempFileName2;
        Exit;
      end;
    end;
    Result := Format(Result, [ProjGroup.ProjectCount+1]);
  end
  else
    Result := Format(Result, [1]);
end;

function TBaseWebProjectCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TBaseWebProjectCreator.GetOptionFileName: string;
begin
  Result := '';
end;

function TBaseWebProjectCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProjectGroup;
end;

function TBaseWebProjectCreator.GetServices: TWebAppServiceClasses;
begin
  Result := GetWebAppServices(FServiceClasses, FSelectedServices);
end;

function TBaseWebProjectCreator.GetShowSource: Boolean;
begin
  Result := False;
end;

function TBaseWebProjectCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

procedure TBaseWebProjectCreator.NewDefaultModule;
begin
  case ProjectType of
    ptCOM:
    begin
      (BorlandIDEServices as IOTAModuleServices).CreateModule(TWebModuleCOMFormCreator.CreateModule as IOTAModuleCreator);
      (BorlandIDEServices as IOTAModuleServices).CreateModule(GetAppModuleCreator);
    end
  else
    (BorlandIDEServices as IOTAModuleServices).CreateModule(GetAppModuleCreator);
  end;
end;

function TBaseWebProjectCreator.NewOptionSource(
  const ProjectName: string): IOTAFile;
begin
  Result := nil;
end;

procedure TBaseWebProjectCreator.NewProjectResource(
  const Project: IOTAProject);
begin
end;

function TBaseWebProjectCreator.NewProjectSource(
  const ProjectName: string): IOTAFile;
begin
  Result := TProjectFile.CreateNamedProject(ProjectName) as IOTAFile;
end;

{ TProjectFile }

constructor TProjectFile.CreateNamedProject(ProjName: string);
begin
  inherited Create;
  fProjectName := ProjName;
end;

function TProjectFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TProjectFile.GetSource: string;
var
  AppType: string;
  SourceIndex: TSourceIndex;
begin
  case ProjectType of
    ptCGI: SourceIndex := stCGISource;
    ptCOM: SourceIndex := stCOMProjectSource;
    ptApache: SourceIndex := stApache;
{$IFDEF MSWINDOWS}
    ptISAPI: SourceIndex := stISAPISource;
    ptWinCGI: SourceIndex := stWinCGISource;
    ptApacheTwo: SourceIndex := stApacheTwo;
{$ENDIF}
  else
    SourceIndex := stCGISource;
  end;
  if ProjectType = ptCGI then
    AppType := 'CONSOLE'   { do not localize }
  else AppType := 'GUI';   { do not localize }
  if IsPascal then
    Result := Format(SiteSources.InetSources[SourceIndex],
      [FProjectName, AppType])
  else
    Result := Format(SiteSources.InetSources[SourceIndex],
      [FProjectName, AppType, ''  { WebInit.o no longer needed, see WebInit.h }]);
end;

{ TWebModuleWizard }

procedure TWebModuleWizard.Execute;
var
  Project: IOTAProject;
begin
  Project := GetActiveProject;
  if Project <> nil then
  begin
    ImplExecute;
  end
  else
    raise EWebWizardException.CreateRes(@sNoActiveProj);
end;

function TWebModuleWizard.GetAuthor: string;
begin
  Result := sWebAuthor;
end;

function TWebModuleWizard.GetComment: string;
begin
  Result := FComment;
end;

function TWebModuleWizard.GetDesigner: string;
begin
  Result := (BorlandIDEServices as IOTAServices).GetActiveDesignerType;
end;

{$IFDEF LINUX}
var
(* XPM *)
  WebModuleIco: array[0..41] of PChar = (
  (* width height ncolors chars_per_pixel *)
  '32 32 9 1',
  {* colors *}
  '  c #000000',
  '. c #00FFFF',
  'X c #C0C0C0',
  'o c #008080',
  'O c #808080',
  '+ c #000080',
  '@ c #FFFFFF',
  '# c #008000',
  '* c None',
  {* pixels *}
  '*****##### *********************',
  '***###....## *******************',
  '**###...##### ******************',
  '*###...######+ *****************',
  '*#......#####+ *****************',
  '#......##.####+ ****************',
  '#.@.@.##..####+ ****************',
  '#..@.######ooo+ ****************',
  '#.@.@#XXXXXXXXO ****************',
  '#.....X                         ',
  '#.....X oooooooooooooooo X X X O',
  'X#....X                        O',
  '*##o.oX @X@X@X@X@X@X@X@X@X@X@O O',
  '*X+.o.X XOOOOOOOOOOOOOOOOOOOXO O',
  '**X++oX @O@@@@@@@@@@@@@@@@@X@O O',
  '***XX+O XO@@@@@@@@@@@@@@@@@XXO O',
  '*****XX @O@@@@@@@@@@@@@@@@@X@O O',
  '******* XO@@@@@@@@@@@@@@@@@XXO O',
  '******* @O@@@@@@@@@@@@@@@@@X@O O',
  '******* XO@@@@@@@@@@@@@@@@@XXO O',
  '******* @O@@@@@@@@@@@@@@@@@X@O O',
  '******* XO@@@@@@@@@@@@@@@@@XXO O',
  '******* @O@@@@@@@@@@@@@@@@@X@O O',
  '******* XO@@@@@@@@@@@@@@@@@XXO O',
  '******* @O@@@@@@@@@@@@@@@@@X@O O',
  '******* XO@@@@@@@@@@@@@@@@@XXO O',
  '******* @O@@@@@@@@@@@@@@@@@X@O O',
  '******* XOXXXXXXXXXXXXXXXXXXXO O',
  '******* @X@X@X@X@X@X@X@X@X@X@O O',
  '******* OOOOOOOOOOOOOOOOOOOOOO O',
  '*******                        O',
  '******* OOOOOOOOOOOOOOOOOOOOOOOO'
  );

var
  {* XPM *}
  WebPageDataIco : array[0..41]of pchar = (
  {/* width height ncolors chars_per_pixel *}
  '32 32 9 1',
  {* colors *}
  '  c #000000',
  '* c none',
  '. c #00FFFF',
  'X c #C0C0C0',
  'o c #008080',
  'O c #808080',
  '+ c #000080',
  '@ c #FFFFFF',
  '# c #008000',
  {* pixels *}
  '*******##### *******************',
  '*****###....## *****************',
  '****###...##### ****************',
  '***###...######+ ***************',
  '***#......#####+ ***************',
  '**#......##.####+ **************',
  '**#.@.@.##..####+ **************',
  '**#..@.######ooo+ **************',
  '**#.@.@#####o.oo+ **************',
  '**#......##XXXXXO **************',
  '**#......##X               *****',
  '***#....o.#X @@@@@@@@@@@OX *****',
  '***##o.o.o#X @@ooXoXo@@@OXX ****',
  '***X+.o.o.#X @@@@@@@@@@@OXXX ***',
  '****X++o.o.X @@oXoooo@@@O    O**',
  '******X++++O @@@@@@@@@@@@XXX O**',
  '*******XXXXX @@@@@@@@@@@@@@@ O**',
  '************ @@oXooXoo@@@@@@ O**',
  '************ @@@@@@@@@@@@@@@ O**',
  '************ @@ooXoooXoooo@@ O**',
  '************ @@@@@@@@@@@@@@@ O**',
  '************ @@oXooXooXooo@@ O**',
  '************ @@@@@@@@@@@@@@@ O**',
  '************ @@ooXo@@@@@@@@@ O**',
  '************ @@@@@@@@@@@@@@@ O**',
  '************ @@oXooXoooXoo@@ O**',
  '************ @@@@@@@@@@@@@@@ O**',
  '************ @@ooXoo@@@@@@@@ O**',
  '************ @@@@@@@@@@@@@@@ O**',
  '************ @@@@@@@@@@@@@@@ O**',
  '************                 O**',
  '************ OOOOOOOOOOOOOOOOO**'
  );

function TWebModuleWizard.GetGlyph: Cardinal;
begin
  Result := 0;
  if FIcon = sWebSnapPageModuleIconName then
     Result := Cardinal(@WebPageDataIco);
  if FIcon = sWebSnapDataModuleIconName then
     Result := Cardinal(@WebModuleIco);
end;
{$ENDIF LINUX}

{$IFDEF MSWINDOWS}
function TWebModuleWizard.GetGlyph: Cardinal;
begin
  Result := LoadIcon(Hinstance, PChar(FIcon));
end;
{$ENDIF MSWINDOWS}

function TWebModuleWizard.GetIDString: string;
begin
  Result := FIDString;
end;

function TWebModuleWizard.GetName: string;
begin
  Result := FName;
end;

function TWebModuleWizard.GetPage: string;
begin
  Result := sNewPage;
end;

function TWebModuleWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

{ TWebPageModuleWizard }

constructor TWebPageModuleWizard.Create;
begin
  inherited;
  FComment := sWebSnapPageModuleComment;
  FIcon := sWebSnapPageModuleIconName ;
  FIDString := sWebSnapPageModuleIDString;
  FName := sWebSnapPageModuleName;
end;

const
  sDefaultModuleProducerName = 'DefaultModuleProducerName';
  sDefaultModuleTemplateName = 'DefaultModuleTemplateName';
  sDefaultModuleCreateMode = 'DefaultModuleCreateMode';
  sDefaultModuleCacheMode = 'DefaultModuleCacheMode';
  sDefaultModulePublished = 'DefaultModulePublished';
  sDefaultModuleLoginRequired = 'DefaultModuleLoginRequired';
  sDefaultModuleScriptEngine = 'DefaultModuleScriptEngine';
  sDefaultModuleNewTemplateFile = 'DefaultModuleNewTemplateFile';
  sMakePageModuleName = '%sPage'; { This is used as an identifier.
                                    It shouldn't be localized }

procedure SaveWebPageDefaults(Dlg: TNewWebPageForm);
var
  RegIniFile: TRegIniFile;
begin
  RegIniFile := TRegIniFile.Create(GetRegKey);
  with RegIniFile, Dlg do
  try
    WriteString('', sDefaultModuleProducerName, NewPageFrame.ProducerClassName);
    WriteString('', sDefaultModuleTemplateName, NewPageFrame.SelectedTemplateName);
    WriteString('', sDefaultModuleScriptEngine, NewPageFrame.ScriptEngine);
    WriteBool('', sDefaultModuleLoginRequired, NewPageFrame.cbLoginRequired.Checked);
    WriteBool('', sDefaultModulePublished, NewPageFrame.cbPublished.Checked);
    WriteBool('', sDefaultModuleNewTemplateFile, NewPageFrame.CreateHTMLModule);
    WriteInteger('', sDefaultModuleCreateMode, CreateModeIndex);
    WriteInteger('', sDefaultModuleCacheMode, CacheModeIndex);
  finally
    RegIniFile.Free;
  end;
end;

procedure RestoreWebPageDefaults(Dlg: TNewWebPageForm);
var
  RegIniFile: TRegIniFile;
begin
  RegIniFile := TRegIniFile.Create(GetRegKey);
  with RegIniFile, Dlg do
  try
    NewPageFrame.ProducerClassName := ReadString('', sDefaultModuleProducerName, NewPageFrame.ProducerClassName);
    NewPageFrame.SelectedTemplateName := ReadString('', sDefaultModuleTemplateName, NewPageFrame.SelectedTemplateName);
    NewPageFrame.ScriptEngine := ReadString('', sDefaultModuleScriptEngine, NewPageFrame.ScriptEngine);
    NewPageFrame.cbLoginRequired.Checked := ReadBool('', sDefaultModuleLoginRequired, NewPageFrame.cbLoginRequired.Checked);
    NewPageFrame.cbPublished.Checked := ReadBool('', sDefaultModulePublished, NewPageFrame.cbPublished.Checked);
    NewPageFrame.CreateHTMLModule := ReadBool('', sDefaultModuleNewTemplateFile, NewPageFrame.CreateHTMLModule);
    CreateModeIndex := ReadInteger('', sDefaultModuleCreateMode, CreateModeIndex);
    CacheModeIndex := ReadInteger('', sDefaultModuleCacheMode, CacheModeIndex);
  finally
    RegIniFile.Free;
  end;
end;

const
  sDefaultAppProducerName = 'DefaultAppProducerName';
  sDefaultAppPageName = 'DefaultAppPageName';
  sDefaultAppPageTitle = 'DefaultAppPageTitle';
  sDefaultAppTemplateName = 'DefaultAppTemplateName';
  sDefaultAppCacheMode = 'DefaultAppCacheMode';
  sDefaultAppPublished = 'DefaultAppPublished';
  sDefaultAppLoginRequired = 'DefaultAppLoginRequired';
  sDefaultAppScriptEngine = 'DefaultAppScriptEngine';
  sDefaultAppNewTemplateFile = 'DefaultAppNewTemplateFile';
  sDefaultAppModuleType = 'DefaultAppModuleType';
  sDefaultAppProjectType = 'DefaultAppProjectType';
  sDataModuleType = 'DataModule';
  sPageModuleType = 'PageModule';
  sDefaultServiceClass = 'DefaultServiceClass';
  sServiceChecked = 'Checked';

const
  sAppModuleTypeNames: array[TWebAppModuleType] of string =
                       ('PageModule', 'DataModule');
{$IFDEF MSWINDOWS}
  sProjectTypeNames: array[TProjectType] of string =
                     ('ISAPI', 'CGI', 'WinCGI', 'COM', 'Apache', 'ApacheTwo');
{$ENDIF}
{$IFDEF LINUX}
  sProjectTypeNames: array[TProjectType] of string =
                     ('CGI', 'Apache', 'COM');
{$ENDIF}
  sWebAppServiceTypeNames: array[TWebAppServiceType] of string =
                           ('ApplicationAdapter', 
                            'EndUserAdapter',
                            'PageDispatcher', 
                            'AdapterDispatcher',
                            'DispatchActions', 
                            'LocateFileService',
                            'Sessions', 
                            'UserList');

procedure SaveWebAppDefaults(Dlg: TNewSiteSrvForm);
var
  RegIniFile: TRegIniFile;
  I: TWebAppServiceType;
begin
  RegIniFile := TRegIniFile.Create(GetRegKey);
  with RegIniFile, Dlg do
  try
    WriteString('', sDefaultAppProjectType, sProjectTypeNames[Dlg.ProjectType]);
    WriteString('', sDefaultAppModuleType, sAppModuleTypeNames[AppModuleType]);
    WriteInteger('', sDefaultAppCacheMode, CacheModeIndex);
    if AppModuleType <> mtDataModule then
    begin
      WriteString('', sDefaultAppProducerName, Helper.Frame.ProducerClassName);
      WriteString('', sDefaultAppTemplateName, Helper.Frame.SelectedTemplateName);
      WriteString('', sDefaultAppScriptEngine, Helper.Frame.ScriptEngine);
      if not IsDefaultPageName then
        WriteString('', sDefaultAppPageName, PageName)
      else
        WriteString('', sDefaultAppPageName, '');
      if not Helper.Frame.IsDefaultPageTitle then
        WriteString('', sDefaultAppPageTitle, Helper.Frame.PageTitle)
      else
        WriteString('', sDefaultAppPageTitle, '');
      WriteBool('', sDefaultAppLoginRequired, Helper.Frame.cbLoginRequired.Checked);
      WriteBool('', sDefaultAppPublished, Helper.Frame.cbPublished.Checked);
      WriteBool('', sDefaultAppNewTemplateFile, Helper.Frame.CreateHTMLModule);
      for I := Low(TWebAppServiceType) to High(TWebAppServiceType) do
      begin
        WriteString(sWebAppServiceTypeNames[I], sDefaultServiceClass, ServiceClassName[I]);
        WriteBool(sWebAppServiceTypeNames[I], sServiceChecked, IncludeService[I]);
      end;
    end
  finally
    RegIniFile.Free;
  end;
end;

procedure RestoreWebAppDefaults(Dlg: TNewSiteSrvForm);
var
  RegIniFile: TRegIniFile;
  I: TWebAppModuleType;
  J: TProjectType;
  K: TWebAppServiceType;
  S: string;
begin
  RegIniFile := TRegIniFile.Create(GetRegKey);
  with RegIniFile, Dlg do
  try
    S := ReadString('', sDefaultAppProjectType, '');
    for J := Low(TProjectType) to High(TProjectType) do
      if CompareText(S, sProjectTypeNames[J]) = 0 then
        Dlg.ProjectType := J;
    Helper.Frame.ProducerClassName := ReadString('', sDefaultAppProducerName, Helper.Frame.ProducerClassName);
    Helper.Frame.SelectedTemplateName := ReadString('', sDefaultAppTemplateName, Helper.Frame.SelectedTemplateName);
    Helper.Frame.ScriptEngine := ReadString('', sDefaultAppScriptEngine, Helper.Frame.ScriptEngine);
    S := ReadString('', sDefaultAppPageName, Helper.Frame.PageName);
    if (S <> '') and (S <> PageName) then
    begin
      PageName := S;
      Helper.Frame.AutoUpdatePageName := False;
    end;
    S := ReadString('', sDefaultAppPageTitle, Helper.Frame.PageTitle);
    if (S <> '') and (S <> Helper.Frame.PageTitle) then
    begin
      Helper.Frame.PageTitle := S;
      Helper.Frame.AutoUpdatePageTitle := False;
    end;
    Helper.Frame.cbLoginRequired.Checked := ReadBool('', sDefaultAppLoginRequired, Helper.Frame.cbLoginRequired.Checked);
    Helper.Frame.cbPublished.Checked := ReadBool('', sDefaultAppPublished, Helper.Frame.cbPublished.Checked);
    Helper.Frame.CreateHTMLModule := ReadBool('', sDefaultAppNewTemplateFile, Helper.Frame.CreateHTMLModule);
    CacheModeIndex := ReadInteger('', sDefaultAppCacheMode, CacheModeIndex);
    S :=  ReadString('', sDefaultAppModuleType, '');
    for I := Low(TWebAppModuleType) to High(TWebAppModuleType) do
      if CompareText(S, sAppModuleTypeNames[I]) = 0 then
        AppModuleType := I;
    for K := Low(TWebAppServiceType) to High(TWebAppServiceType) do
    begin
      ServiceClassName[K] := ReadString(sWebAppServiceTypeNames[K], sDefaultServiceClass, ServiceClassName[K]);
      IncludeService[K] := ReadBool(sWebAppServiceTypeNames[K], sServiceChecked, IncludeService[K]);
    end;
  finally
    RegIniFile.Free;
  end;
end;

procedure TWebPageModuleWizard.ImplExecute;
var
  ProducerInfo: TModulePageProducerInfo;
  PageCreator: TWebPageModuleCreator;
  Helper: TNewPageHelper;
  Dlg: TNewWebPageForm;
begin
  Dlg := TNewWebPageForm.Create(Application);
  with Dlg do
  try
    Helper := TNewPageHelper.Create(NewPageFrame);
    try
      {$IFDEF MSWINDOWS}
      RestoreWebPageDefaults(Dlg);
      {$ENDIF MSWINDOWS}
      if ShowModal = mrOK then
      begin
        ProducerInfo := NewPageFrame.SelectedProducerInfo;
        PageCreator := TWebPageModuleCreator.CreateModule(ProducerInfo, Helper.FTemplate, NewPageFrame.PageName,
          CreateMode, CacheMode, NewPageFrame.Access, stWebPageModuleFactory);
        if NewPageFrame.PageTitle <> NewPageFrame.PageName then
          PageCreator.PageTitle := NewPageFrame.PageTitle;
        PageCreator.ScriptEngine := NewPageFrame.ScriptEngine;
        if NewPageFrame.NewTemplateFile then
        begin
          PageCreator.CreateTemplateFile := True;
          PageCreator.TemplateFileExt := NewPageFrame.TemplateFileExt;
        end
        else
          PageCreator.CreateTemplateFile := False;
        (BorlandIDEServices as IOTAModuleServices).CreateModule(PageCreator as IOTAModuleCreator);
        {$IFDEF MSWINDOWS}
        if Default.Checked then
        begin
          SaveWebPageDefaults(Dlg);
        end;
        {$ENDIF MSWINDOWS}
      end;
    finally
      Helper.Free;
    end;
  finally
    Free;
  end;
end;


{ TBaseWebModuleCreator }

constructor TBaseWebModuleCreator.CreateModule(
  const AAncestorName, AFormName, AUsesUnits: string;
  ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
  AAccess: TWebPageAccess);
begin
  inherited Create;
  FComponentsList := TFormComponentsList.Create;
  FAncestorName := AAncestorName;
  FUsesUnits := AUsesUnits;
  FCacheMode := ACacheMode;
  FCreateMode := ACreateMode;
  FAccess := AAccess;
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName(FAncestorName,
    FModuleName, FFormName, FFileName);
  if AFormname <> '' then
    FFormName := AFormName;
end;

procedure TBaseWebModuleCreator.FormCreated(
  const FormEditor: IOTAFormEditor);
begin
end;

function TBaseWebModuleCreator.GetAncestorName: string;
begin
  if FAncestorName = '' then
    Result := Copy(TWebModule.ClassName, 2, MaxInt)
  else
    Result := FAncestorName;
end;

function TBaseWebModuleCreator.GetCreatorType: string;
begin
  Result := sForm;
end;

function TBaseWebModuleCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TBaseWebModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TBaseWebModuleCreator.GetFormName: string;
begin
  Result := fFormName;
end;

function TBaseWebModuleCreator.GetImplFileName: string;
begin
  Result := fFileName;
end;

function TBaseWebModuleCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TBaseWebModuleCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TBaseWebModuleCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProject
end;

function TBaseWebModuleCreator.GetShowForm: Boolean;
begin
  Result := True;
end;

function TBaseWebModuleCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TBaseWebModuleCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

function TBaseWebModuleCreator.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := ImplNewFormFile(FormIdent, AncestorIdent);
end;

function TBaseWebModuleCreator.ImplNewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TBaseWebModuleCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := ImplNewImplSource(ModuleIdent, FormIdent, AncestorIdent)
end;

function TBaseWebModuleCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  if IsPascal then
    Result := nil
  else
    Result := ImplNewIntfSource(ModuleIdent, FormIdent, AncestorIdent);
end;

destructor TBaseWebModuleCreator.Destroy;
begin
  inherited;
  FComponentsList.Free;
end;

function TBaseWebModuleCreator.FormatFields: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to ComponentsList.ObjectCount - 1 do
    if IsPascal then
      Result := Result + Format(#13#10'    %0:s: %1:s;', [ComponentsList.ObjectItems[I].ComponentName,
        ComponentsList.ObjectItems[I].ComponentClassName])
    else
      Result := Result + Format(#13#10#9'%0:s *%1:s;', [ComponentsList.ObjectItems[I].ComponentClassName,
        ComponentsList.ObjectItems[I].ComponentName]);
end;

const
  ComponentVTop = 8;
  ComponentVSpace = 48;

function TBaseWebModuleCreator.MinFormWidth: Integer;
begin
  Result := 215;
end;

function TBaseWebModuleCreator.MinFormHeight: Integer;
var
  I: Integer;
begin
  Result := 150;
  I := ComponentVTop + ComponentVSpace * (ComponentsList.ObjectCount + 1);
  if I > Result then
    Result := I;
end;

function TBaseWebModuleCreator.FormatObjects: string;
var
  Top, Left: Integer;

  function FormatSubProperties(AComponents: TFormComponentsList): string;
  var
    I: Integer;
  begin
    Result := '';
    if Assigned(AComponents) then
      for I := 0 to AComponents.PropertyCount - 1 do
        Result := Result + Format('  %0:s = %1:s'#13#10, [AComponents.PropertyItems[I].PropertyName,
          AComponents.PropertyItems[I].PropertyValue]);
    if Result <> '' then
      Result := #13#10 + Result;
  end;

  function FormatSubObjects(AComponents: TFormComponentsList): string;
  var
    I: Integer;
  begin
    Result := '';
    if Assigned(AComponents) then
      for I := 0 to AComponents.ObjectCount - 1 do
      begin
        Result := Result + Format('  object %0:s: %1:s' + #13#10 +   { do not localize }
                                  '    Left = %2:d' + #13#10 +       { do not localize }
                                  '    Top = %3:d' + #13#10 +        { do not localize }
                                  FormatSubProperties(AComponents.ObjectItems[I].ComponentsList) +
                                  FormatSubObjects(AComponents.ObjectItems[I].ComponentsList) +
                                  '  end' + #13#10,                  { do not localize }
          [AComponents.ObjectItems[I].ComponentName,
            AComponents.ObjectItems[I].ComponentClassName, Left, Top]);
        Top := Top + ComponentVSpace;
      end;
    if Result <> '' then
      Result := #13#10 + Result;
  end;

begin
  Top := ComponentVTop;
  Left := 48;
  Result := '';
  if Assigned(ComponentsList) then
    Result := FormatSubObjects(ComponentsList);
end;

function TBaseWebModuleCreator.FormatProperties: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to ComponentsList.PropertyCount - 1 do
    Result := Result + Format('  %0:s = %1:s'#13#10, [ComponentsList.PropertyItems[I].PropertyName,
      ComponentsList.PropertyItems[I].PropertyValue]);
  if Result <> '' then
    Result := #13#10 + Result;

end;

procedure TBaseWebModuleCreator.PopulateComponentsList(AList: TFormComponentsList);
begin
  // no components
end;

function TBaseWebModuleCreator.GetComponentsList: TFormComponentsList;
begin
  if not FHaveComponents then
  begin
    PopulateComponentsList(FComponentsList);
    FHaveComponents := True;
  end;
  Result := FComponentsList;
end;

{ TWebModuleCOMFormCreator }

constructor TWebModuleCOMFormCreator.CreateModule;
begin
  // NOTE: This is done so that the linker finds the added file _before_ any user code
  //       otherwise the application is not initialized correctly and the app fails.
  if not IsPascal then
    AddBCBAppUnits(ProjectType);  // AddBCBAppUnits called elsewhere for other project types
  inherited Create;
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName('Unit',  { do not localize }
    fModuleName, fFormName, fFileName); { do not localize }
  FFormName := ''; // Get default form name
end;

procedure TWebModuleCOMFormCreator.FormCreated(
  const FormEditor: IOTAFormEditor);
begin
end;

function TWebModuleCOMFormCreator.GetAncestorName: string;
begin
  Result := '';
end;

function TWebModuleCOMFormCreator.GetCreatorType: string;
begin
  Result := sForm;
end;

function TWebModuleCOMFormCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TWebModuleCOMFormCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TWebModuleCOMFormCreator.GetFormName: string;
begin
  Result := fFormName;
end;

function TWebModuleCOMFormCreator.GetImplFileName: string;
begin
  Result := fFileName;
end;

function TWebModuleCOMFormCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TWebModuleCOMFormCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TWebModuleCOMFormCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProject;
end;

function TWebModuleCOMFormCreator.GetShowForm: Boolean;
begin
  Result := True;
end;

function TWebModuleCOMFormCreator.GetShowSource: Boolean;
begin
  Result := False;
end;

function TWebModuleCOMFormCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

function TWebModuleCOMFormCreator.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TWebModuleCOMFormCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := TWebModuleCOMFormFile.CreateModule(FModuleName, FormIdent, AncestorIdent) as IOTAFile
end;

function TWebModuleCOMFormCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  if IsPascal then
    Result := nil
  else
    Result := TWebModuleCOMFormIntfFile.CreateModule(ModuleIdent, FormIdent, AncestorIdent) as IOTAFile;
end;

{ TBaseWebDataModuleFile }

constructor TBaseWebDataModuleFile.CreateModule(
  const AModuleIdent, AAncestorIdent, AFormIdent, AUsesUnits: string;
  ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
  AFactoryIndex: TSiteSourceIndex; const AFields: string);
begin
  inherited CreateModule(
    AModuleIdent,
    AAncestorIdent,
    AFormIdent,
    AUsesUnits,
    ACreateMode,
    ACacheMode,
    [], { not Published }
    AFactoryIndex,
    AFields);
end;


{ TBaseWebPageModuleFile }

constructor TBaseWebPageModuleFile.CreateModule(const AModuleIdent, AAncestorName, AFormName, AUsesUnits: string;
  ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
  AAccess: TWebPageAccess; AFactoryIndex: TSiteSourceIndex; const AFields: string);
begin
  inherited CreateModule(
    AModuleIdent,
    AAncestorName,
    AFormName,
    AUsesUnits,
    ACreateMode,
    ACacheMode,
    AAccess,
    AFactoryIndex,
    AFields);
end;

{ TBaseWebModuleFile }

function TBaseWebModuleFile.CacheOption: string;
begin
  Result := '';
  case FCacheMode of
    caDestroy: Result := 'caDestroy';   { do not localize }
    caCache:   Result := 'caCache';     { do not localize }
  else
    Assert(False, 'Unknown case');      { do not localize }
  end;
end;

function TBaseWebModuleFile.PageInfo: string;
var
  NeedComma: Boolean;

  procedure AddOption(const S: string; Include: Boolean);
  var
    Temp: string;
  begin
    Temp := '';
    if NeedComma then
      Temp := Temp + ', ';
    Temp := Temp + S;
    if Include then
    begin
      NeedComma := True;
      Result := Result + Temp
    end
    else
    begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + '{' + Temp + '}';
    end;
  end;
begin
  NeedComma := False;
  Result := '';
  if IsPascal then
  begin
    AddOption('wpPublished', wpPublished in FAccess);   { do not localize }
    AddOption('wpLoginRequired', wpLoginRequired in FAccess);  { do not localize }
    Result := Format('[%s]', [Result]);
    if CreateTemplateFile then
      Result := Format('%s, ''.%s''', [Result, TemplateFileExt])
    else
      Result := Format('%s, ''''', [Result]);

    if PageTitle <> '' then
      Result := Result + ', ''''' +  ', ''' + PageTitle + '''';
  end
  else  // BCB - return only TWebPageAccess parameter other parameters are handled separately
    if wpPublished in FAccess then
    begin
      Result := '<< wpPublished';
      if wpLoginRequired in FAccess then
        Result := Format('%s << wpLoginRequired', [Result])
      else
        Result := Format('%s /* << wpLoginRequired */', [Result])
    end
    else
      Result := '/* << wpPublished << wpLoginRequired */'
end;

function TBaseWebModuleFile.CreateOption: string;
begin
  Result := '';
  case FCreateMode of
    crOnDemand: Result := 'crOnDemand';   { do not localize }
    crAlways:   Result := 'crAlways';     { do not localize }
  else
    Assert(False, 'Unknown case');
  end;
end;

constructor TBaseWebModuleFile.CreateModule(const AModuleIdent, AAncestorName, AFormName, AUsesUnits: string;
  ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
  AAccess: TWebPageAccess; AFactoryIndex: TSiteSourceIndex; const AFields: string);
begin
  inherited Create;
  FFields := AFields;
  FAccess := AAccess;
  FModuleIdent := AModuleIdent;
  FAncestorIdent := AAncestorName;
  FFormIdent := AFormName;
  FCacheMode := ACacheMode;
  FCreateMode := ACreateMode;
  FUsesUnits := AUsesUnits;
  FFactoryIndex := AFactoryIndex;
end;


function TBaseWebModuleFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TBaseWebModuleFile.GetSource: string;
begin
  Result := ImplGetSource;
end;

function TBaseWebModuleFile.FormatFactory: string;

  function GetTemplateExt: string;
  begin
    Result := '';
    if CreateTemplateFile then
      if TemplateFileExt <> '' then
        Result := '.' + TemplateFileExt
  end;

begin
  if IsPascal then
    Result := Format(SiteSources.SiteSources[FFactoryIndex],
      [FFormIdent, CreateOption, CacheOption, PageInfo])
  else
    Result := Format(SiteSources.SiteSources[FFactoryIndex],
      [FFormIdent, CreateOption, CacheOption, PageInfo, GetTemplateExt, PageTitle]);
end;

function TBaseWebModuleFile.ImplGetSource: string;
var
  S: string;
begin
  if CreateTemplateFile then
    if IsPascal then
      S := Format(sHTMLComment, [TemplateFileExt])
    else
      S := Format(sCHTMLComment, [TemplateFileExt])
  else
    S := '';
  Result := Format(SiteSources.SiteSources[FSourceIndex],
    [FModuleIdent, FFormIdent, FAncestorIdent, FUsesUnits,
    FormatFactory, FFields, S]);
end;

{ TBaseHTMLFile }

function TBaseHTMLFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TBaseHTMLFile.GetSource: string;
begin
  Result := ImplGetSource;
end;

{ TWebModuleCOMFormFile }

constructor TWebModuleCOMFormFile.CreateModule(const ModuleIdent, FormIdent,
  AncestorIdent: string);
begin
  inherited Create;

  fModuleIdent := ModuleIdent;
  fFormIdent := FormIdent;
  fAncestorIdent := AncestorIdent;
end;

function TWebModuleCOMFormFile.ImplGetSource: string;
begin
  Result := Format(SiteSources.InetSources[stCOMConsoleSource],
    [FModuleIdent, FFormIdent, FAncestorIdent, ProjectCoClassName]);
end;

{ TWebModuleCOMFormIntfFile }

constructor TWebModuleCOMFormIntfFile.CreateModule(const ModuleIdent, FormIdent,
  AncestorIdent: string);
begin
  inherited Create;

  fModuleIdent := ModuleIdent;
  fFormIdent := FormIdent;
  fAncestorIdent := AncestorIdent;
end;

function TWebModuleCOMFormIntfFile.ImplGetIntfSource: string;
begin
  if IsPascal then
    Result := Format(SiteSources.InetSources[stCOMConsoleSource],
      [FModuleIdent, FFormIdent, FAncestorIdent])
  else
    Result := Format(SiteSources.InetSources[stCOMConsoleIntf],
      [FModuleIdent, FFormIdent, FAncestorIdent, '', '']);
end;

{ TWebPageModuleCreator }

constructor TWebPageModuleCreator.CreateModule(
    AProducerInfo: TModulePageProducerInfo;
    const ATemplate: string;
    const APageName: string;
    ACreateMode: TWebModuleCreateMode;
    ACacheMode: TWebModuleCacheMode;
    AAccess: TWebPageAccess;
    AFactoryIndex: TSiteSourceIndex);
var
  Units: String;
begin
  if IsPascal then
    Units := ', HTTPProd'    { do not localize }
  else
    Units := '#include <HTTPProd.hpp>';  { do not localize }
  inherited CreateModule(
    AProducerInfo,
    GetModuleClassName, // Ancestor name
    APageName, // FormName
    Units, // Uses Units
    ACreateMode,
    ACacheMode,
    AAccess,
    AFactoryIndex,
    ATemplate);
end;

function TWebPageModuleCreator.GetModuleClassName: string;
begin
  Result := Copy(TWebPageModule.ClassName, 2, MaxInt);
end;

function TWebPageModuleCreator.ImplNewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := TBaseWebFormFile.Create(FormIdent, FormatProperties, FormatObjects,
    MinFormWidth, MinFormHeight);
end;


{ TWebAppPageModuleCreator }

constructor TWebAppPageModuleCreator.CreateModule(
      AProducerInfo: TModulePageProducerInfo;
      const ATemplate: string;
      const APageName: string;
      ACacheMode: TWebModuleCacheMode;
      AAccess: TWebPageAccess);
var
  Units: string;
begin
  // NOTE: This is done so that the linker finds the added file _before_ any user code
  //       otherwise the application is not initialized correctly and the app fails.
  if not IsPascal then
    if ProjectType <> ptCOM then  // ptCOM handled in TWebModuleCOMFormCreator.CreateModule
      AddBCBAppUnits(ProjectType);
  FServices := GetWebAppServices(DefaultServiceClasses, DefaultSelectedServices);
  if IsPascal then
    Units := ', HTTPProd, ReqMulti'   { do not localize }
  else
    Units := '#include <HTTPProd.hpp>'#13#10'#include <ReqMulti.hpp>';  { do not localize }
  inherited CreateModule(
    AProducerInfo,
    GetModuleClassName, // Ancestor name
    APageName, // FormName
    Units, // AUsesUnits
    crAlways,
    ACacheMode,
    AAccess,
    stWebAppPageModuleFactory,
    ATemplate);
end;


procedure GetAppModuleComponents(AClasses: TWebAppServiceClasses; AList: TFormComponentsList);
var
  SubComponentsList: TFormComponentsList;

  procedure AddService(const APropertyName: string; AClass: TComponentClass);
  var
    S: string;
  begin
    S := Copy(AClass.ClassName, 2, MaxInt);
    SubComponentsList.AddProperty(APropertyName, S);
    AList.AddObject(S,
     AClass.ClassName, nil);
  end;

  function ServiceToPropertyName(AValue: TWebAppServiceType): string;
  begin
    case AValue of
      wsPageDispatcher: Result := sPageDispatcherProperty;
      wsAdapterDispatcher: Result := sAdapterDispatcherProperty;
      wsApplicationAdapter: Result := sApplicationAdapterProperty;
      wsEndUserAdapter: Result := sEndUserAdapterProperty;
      wsSessions: Result := sSessionsProperty;
      wsLocateFileService: Result := sLocateFileServiceProperty;
      wsDispatchActions: Result := sDispatchActionsProperty;
      wsUserList: Result := sUserListProperty;
    else
      Assert(False);
    end;
  end;

var
  I: TWebAppServiceType;
begin
  AList.AddProperty(sAppServicesProperty, Copy(TWebAppComponents.ClassName, 2, MaxInt));
  SubComponentsList := TFormComponentsList.Create;
  AList.AddObject(Copy(TWebAppComponents.ClassName, 2, MaxInt),
    TWebAppComponents.ClassName, SubComponentsList);

  for I := Low(AClasses) to High(AClasses) do
    if AClasses[I] <> nil then
      AddService(ServiceToPropertyName(I), AClasses[I]);
end;


procedure TWebAppPageModuleCreator.PopulateComponentsList(
  AList: TFormComponentsList);
begin
  inherited;
  GetAppModuleComponents(FServices, AList);
end;

function TWebAppPageModuleCreator.GetModuleClassName: string;
begin
  Result := Copy(TWebAppPageModule.ClassName, 2, MaxInt);
end;

function TWebAppPageModuleCreator.ImplNewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := TBaseWebFormFile.Create(FormIdent, FormatProperties, FormatObjects,
    MinFormWidth, MinFormHeight);
end;

{ TBaseWebModuleIntfFile }

constructor TBaseWebModuleIntfFile.CreateModule(const AModuleIdent,
  AFormIdent, AAncestorIdent, AUsesUnits, AFields: string;
  ASourceIndex: TSiteSourceIndex);
begin
  FModuleIdent := AModuleIdent;
  FFormIdent := AFormIdent;
  FAncestorIdent := AAncestorIdent;
  FUsesUnits := AUsesUnits;
  FSourceIndex := ASourceIndex;
  FFields := AFields;
end;

function TBaseWebModuleIntfFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TBaseWebModuleIntfFile.GetSource: string;
begin
  Result := ImplGetIntfSource;
end;

function TBaseWebModuleIntfFile.ImplGetIntfSource: string;
begin
  if IsPascal then
    Result := Format(SiteSources.SiteSources[FSourceIndex],
       [FModuleIdent, FFormIdent, FAncestorIdent, FUsesUnits])
  else
    Result := Format(SiteSources.SiteSources[FSourceIndex],
       [FModuleIdent, FFormIdent, FAncestorIdent, FUsesUnits, FFields]);
end;

{ TBaseWebPageModuleCreator }

function TBaseWebPageModuleCreator.GetAdditionalFileName(I: Integer): string;
begin
  Result := '';
end;

function TBaseWebPageModuleCreator.GetAdditionalFileExt(I: Integer): string;
begin
  Result := '.' + TemplateFileExt;
end;

function TBaseWebPageModuleCreator.GetAdditionalFilesCount: Integer;
begin
  if CreateTemplateFile then
    Result := 1
  else
    Result := 0
end;

function TBaseWebPageModuleCreator.NewAdditionalFileSource(I: Integer;
  const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Assert(I = 0);
  Result := ImplNewHTMLSource(ModuleIdent, FormIdent, AncestorIdent);
end;

constructor TBaseWebPageModuleCreator.CreateModule(AProducerInfo: TModulePageProducerInfo; const AAncestorName, AFormName, AUsesUnits: string;
  ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode; AAccess: TWebPageAccess;
  AFactoryIndex: TSiteSourceIndex;
  const AProducerTemplate: string);
begin
   FProducerInfo := AProducerInfo;
   inherited CreateModule(AAncestorName, AFormName, AUsesUnits,
   ACreateMode, ACacheMode, AAccess);
   FSourceIndex := stWebModuleSource;
   FIntfIndex := stWebModuleIntf;
   FFactoryIndex := AFactoryIndex;
   FProducerTemplate := AProducerTemplate;
end;

function TBaseWebPageModuleCreator.ImplNewHTMLSource(const ModuleIdent,
  FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := THTMLFile.CreateModule(FProducerTemplate) as IOTAFile;
end;

function TBaseWebPageModuleCreator.ImplNewImplSource(const ModuleIdent,
  FormIdent, AncestorIdent: string): IOTAFile;
var
  F: TWebPageModuleFile;
begin
  F := TWebPageModuleFile.CreateModule(ModuleIdent, AncestorIdent, FormIdent, FUsesUnits,
    FCreateMode, FCacheMode, FAccess, FFactoryIndex, FormatFields);
  F.PageTitle := PageTitle;
  F.ScriptEngine := ScriptEngine;
  F.CreateTemplateFile := CreateTemplateFile;
  F.TemplateFileExt := TemplateFileExt;
  Result := F as IOTAFile;
end;

function TBaseWebPageModuleCreator.ImplNewIntfSource(const ModuleIdent,
  FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TBaseWebModuleIntfFile.CreateModule(ModuleIdent, AncestorIdent, FormIdent, FUsesUnits,
    FormatFields, stWebModuleIntf) as IOTAFile;
end;

procedure TBaseWebPageModuleCreator.PopulateComponentsList(AList: TFormComponentsList);
var
  SubComponentsList: TFormComponentsList;
begin
  inherited;
  AList.AddProperty(sPageProducerProperty, Copy(FProducerInfo.ComponentClass.ClassName, 2, MaxInt));
  SubComponentsList := TFormComponentsList.Create;
  if FProducerInfo.ScriptEngines.Count <> 1 then
    if ScriptEngine <> '' then
      SubComponentsList.AddProperty(sScriptEngineProperty, Format('''%s''', [ScriptEngine]));
  AList.AddObject(Copy(FProducerInfo.ComponentClass.ClassName, 2, MaxInt),
    FProducerInfo.ComponentClass.ClassName, SubComponentsList);
end;

{ THTMLFile }

constructor THTMLFile.CreateModule(const ATemplate: string);
begin
  FTemplate := ATemplate;
  inherited Create;
end;

function THTMLFile.ImplGetSource: string;
begin
  Result := FTemplate;
end;

{ TSiteSources }

constructor TSiteSources.Create;
begin
  inherited;
  PropValues.Add('WebSnap=TRUE'); // Do not localize
end;

function TSiteSources.GetProducerTemplates(
  TemplatesIndex: TProducerTemplatesIndex): string;
begin
  Result := GetSourceFromTemplate('SiteTemplates.txt',  { Do not localize }
                                    ProducerTemplateNames[TemplatesIndex], SourceFlags);
end;

function TSiteSources.GetSiteSources(
  SourceIndex: TSiteSourceIndex): string;
var
  SiteModulesFileName: string;
begin
  if IsPascal then
    SiteModulesFileName := 'SiteModules.pas'  { Do not localize }
  else
    SiteModulesFileName := 'SiteModules.cpp';  { Do not localize }
  Result := GetSourceFromTemplate(SiteModulesFileName,
                                    SiteSourceNames[SourceIndex], SourceFlags);
end;

procedure InitWeb;
begin
  { Is Pascal now set in InetSource.pas }
  SiteSources := TSiteSources.Create;
end;

procedure DoneWeb;
begin
  FreeAndNil(SiteSources);
end;

{ TWebProjectWPageModuleCreator }

constructor TWebProjectWPageModuleCreator.CreateProject(AProducerInfo: TModulePageProducerInfo; const ATemplate: string; const APageName: string; ACacheMode: TWebModuleCacheMode;
      AAccess: TWebPageAccess);
begin
  inherited Create;
  FProducerInfo := AProducerInfo;
  FAccess := AAccess;
  FCacheMode := ACacheMode;
  FPageName := APageName;
  FTemplate := ATemplate;
end;

function TWebProjectWPageModuleCreator.GetAppModuleCreator: IOTAModuleCreator;
var
  PageCreator: TWebAppPageModuleCreator;
begin
  PageCreator := TWebAppPageModuleCreator.CreateModule(FProducerInfo, FTemplate, FPageName,
    FCacheMode, FAccess);
  PageCreator.PageTitle := PageTitle;
  PageCreator.ScriptEngine := ScriptEngine;
  PageCreator.CreateTemplateFile := CreateTemplateFile;
  PageCreator.TemplateFileExt := TemplateFileExt;
  PageCreator.FServices := GetServices;
  Result := PageCreator as IOTAModuleCreator;
end;

{ TWebProjectWDataModuleCreator }

constructor TWebProjectWDataModuleCreator.CreateProject(
  ACacheMode: TWebModuleCacheMode);
begin
  inherited Create;
  FCacheMode := ACacheMode;
end;

function TWebProjectWDataModuleCreator.GetAppModuleCreator: IOTAModuleCreator;
var
  DataModuleCreator: TWebAppDataModuleCreator;
begin
  DataModuleCreator := TWebAppDataModuleCreator.CreateModule(FCacheMode);
  DataModuleCreator.FServices := GetServices;
  Result := DataModuleCreator as IOTAModuleCreator;
end;

{ TWebAppDataModuleCreator }

constructor TWebAppDataModuleCreator.CreateModule(
  ACacheMode: TWebModuleCacheMode);
var
  Units: string;
begin
  FServices := GetWebAppServices(DefaultServiceClasses, DefaultSelectedServices);
  if IsPascal then
    Units := ', ReqMulti'   { do not localize }
  else
    Units := '#include <ReqMulti.hpp>';  { do not localize }
  inherited CreateModule(Copy(TWebAppDataModule.ClassName, 2, MaxInt),
      '', // Formname
      Units, // AUsesUnits
      crAlways,
      ACacheMode,
      stWebAppDataModuleFactory); // FactoryIndex
end;

procedure TWebAppDataModuleCreator.PopulateComponentsList(AList: TFormComponentsList);
begin
  GetAppModuleComponents(FServices, AList);
end;

function TWebAppDataModuleCreator.ImplNewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := TBaseWebFormFile.Create(FormIdent, FormatProperties, FormatObjects,
    MinFormWidth, MinFormHeight);
end;

{ TBaseWebDataModuleCreator }

constructor TBaseWebDataModuleCreator.CreateModule(const AAncestorName, AFormName, AUsesUnits: string;
      ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
      AFactoryIndex: TSiteSourceIndex);
begin
   inherited CreateModule(AAncestorName, AFormName, AUsesUnits,
   ACreateMode, ACacheMode, []);
   FSourceIndex := stWebModuleSource;
   FIntfIndex := stWebModuleIntf;
   FFactoryIndex := AFactoryIndex;
end;

function TBaseWebDataModuleCreator.ImplNewImplSource(const ModuleIdent,
  FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TWebDataModuleFile.CreateModule(ModuleIdent, AncestorIdent, FormIdent, FUsesUnits,
    FCreateMode, FCacheMode, FFactoryIndex, FormatFields) as IOTAFile;
end;

function TBaseWebDataModuleCreator.ImplNewIntfSource(const ModuleIdent,
  FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TBaseWebModuleIntfFile.CreateModule(ModuleIdent, AncestorIdent, FormIdent,
    FUsesUnits, FormatFields, 
    stWebModuleIntf) as IOTAFile;
end;


{ TWebPageModuleFile }

constructor TWebPageModuleFile.CreateModule(const AModuleIdent,
  AAncestorName, AFormName, AUsesUnits: string;
  ACreateMode: TWebModuleCreateMode; ACacheMode: TWebModuleCacheMode;
  AAccess: TWebPageAccess; AFactoryIndex: TSiteSourceIndex; const AFields: string);
begin
  inherited CreateModule(
    AModuleIdent,
    AAncestorName,
    AFormName,
    AUsesUnits,
    ACreateMode,
    ACacheMode,
    AAccess,
    AFactoryIndex,
    AFields);
end;

{ TWebDataModuleCreator }

constructor TWebDataModuleCreator.CreateModule(
  ACreateMode: TWebModuleCreateMode;
  ACacheMode: TWebModuleCacheMode;
  AFactoryIndex: TSiteSourceIndex);
begin
  inherited CreateModule(
    Copy(TWebDataModule.ClassName, 2, MaxInt), // Ancestor name
    '', // FormName
    '', // UsesUnits
    ACreateMode,
    ACacheMode,
    AFactoryIndex);
end;

{ TBaseWebFormFile }

constructor TBaseWebFormFile.Create(const AFormIdent, AProperties, AObjects: string;
  AMinWidth, AMinHeight: Integer);
begin
  FFormIdent := AFormIdent;
  FObjects := AObjects;
  FProperties := AProperties;
  FProperties := AProperties;
  FMinWidth := AMinWidth;
  FMinHeight := AMinHeight;
  inherited Create;
end;

function TBaseWebFormFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TBaseWebFormFile.GetSource: string;
begin
  Result := ImplGetSource;
end;

function TBaseWebFormFile.ImplGetSource: string;
begin
  Result := Format(
'object %0:s: %1:s' + #13#10 +                  { do not localize }
'    OldCreateOrder = False%2:s' + #13#10 +     { do not localize }
'    Left = 254' + #13#10 +                     { do not localize }
'    Top = 107' + #13#10 +                      { do not localize }
'    Height = %4:d' + #13#10 +                  { do not localize }
'    Width = %5:d%3:s' + #13#10 +               { do not localize }
'end', [FFormIdent, 'T' + FFormIdent, FProperties,  { do not localize }
  FObjects, FMinHeight, FMinWidth]);

end;

{ TNewPageHelper }

procedure TNewPageHelper.ListProducersCallback(AProducerInfo: TModulePageProducerInfo;
    Info: Pointer);
var
  S: TStrings;
begin
  S := TStrings(Info);
  // Assumes object is not temporary
  S.AddObject(AProducerInfo.ProducerName, AProducerInfo);
end;

procedure TNewPageHelper.ListTemplatesCallback(ProducerTemplate: TAbstractProducerTemplate;
    Info: Pointer);
var
  S: TStrings;
begin
  S := TStrings(Info);
  // Assumes object is not temporary
  S.AddObject(ProducerTemplate.Name, ProducerTemplate);
end;

procedure TNewPageHelper.ListProducers(S: TStrings);
begin
  EnumRegisteredModulePageProducers(ListProducersCallback, Pointer(S));
end;

procedure TNewPageHelper.ListTemplates(S: TStrings;
  var Default: Integer);
var
  I: Integer;
  ProducerInfo: TModulePageProducerInfo;
  T: TStringList;
begin
  ProducerInfo := FFrame.SelectedProducerInfo;
  T := TStringList.Create;
  try
    EnumRegisteredProducerTemplatesOfClass(ListTemplatesCallback, ProducerInfo.ComponentClass, Pointer(T));
    T.Sort;
    S.Assign(T);
  finally
    T.Free;
  end;
  for I := S.Count -1 downto 0 do
    with S.Objects[I] as TAbstractProducerTemplate do
      if not SupportsScriptEngine(FFrame.ScriptEngine) or
        not SupportsFileType(ProducerInfo.TemplateFileType) then
        S.Delete(I);
  for I := S.Count -1 downto 0 do
    with S.Objects[I] as TAbstractProducerTemplate do
      if IsDefault(ProducerInfo.ComponentClass) then
      begin
        Default := I;
        Exit;
      end;
  Default := -1;
end;

resourcestring
  sScriptNone = '(none)';

procedure TNewPageHelper.ListEngines(S: TStrings;
  var Default: Integer);
var
  I: Integer;
  ProducerInfo: TModulePageProducerInfo;
  L: TStrings;
begin
  ProducerInfo := FFrame.SelectedProducerInfo;
  L := TStringList.Create;
  try
    with ScriptEnginesList as TScriptEnginesList do
      ListLanguageNames(L);
    for I := 0 to L.Count - 1 do
    begin
      if ProducerInfo.SupportsScriptEngine(L[I]) then
        S.AddObject(L[I], TObject(1));
    end;
    if ProducerInfo.SupportsScriptEngine('') then
      S.InsertObject(0, sScriptNone, TObject(0));
    Default := S.IndexOf('JScript');  { do not localize }
    if Default = -1 then
      if (S.Count > 1) and (S.Objects[0] = nil) then
        Default := 1
      else
        Default := 0;
  finally
    L.Free;
  end;
  if ProducerInfo.RequiresScriptEngine and (S.Count = 0) then
    try
      ProducerInfo.RaiseMissingScriptEngine;
    except
      Application.HandleException(Self);
    end;
end;

function TNewPageHelper.ExtractTemplate: Boolean;
var
  ProducerInfo: TModulePageProducerInfo;
  T: TObject;
  Template: TAbstractProducerTemplate;
begin
  FTemplate := '';
  ProducerInfo := FFrame.SelectedProducerInfo;
  T := FFrame.SelectedTemplate;
  if T <> nil then
  begin
    Template := T as TAbstractProducerTemplate;
    Result := Template.GetText(ProducerInfo.ComponentClass, FFrame.ScriptEngine, ProducerInfo.RequiredTags, FTemplate);
  end
  else
    Result := True;
  FHaveTemplate := Result;
end;

function TNewPageHelper.PageNameOfClassName(const AClassName: string): string;
var
  ModuleName: string;
  FormName: string;
  FileName: string;
begin
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName(Format(sMakePageModuleName, [AClassName]),
    ModuleName, FormName, FileName);
  Result := FormName;
end;

constructor TNewPageHelper.Create(AFrame: TNewPageFrame);
var
  S: TStrings;
begin
  FFrame := AFrame;
  FFrame.PageNameOfClassNameCallback := PageNameOfClassName;
  FFrame.ListTemplatesCallback := ListTemplates;
  FFrame.ListEnginesCallback := ListEngines;
  FFrame.ExtractTemplateCallback := ExtractTemplate;
  S := TStringList.Create;
  try
    ListProducers(S);
    FFrame.cbProducerType.Items.Assign(S);
    FFrame.SelectedProducerInfo := S.Objects[0] as TModulePageProducerInfo;
  finally
    S.Free;
  end;
  FTemplate := '';
  inherited Create;
end;

procedure TNewPageHelper.RestoreOptions;
begin
  FFrame.SelectedProducerInfo := FSelectedProducerInfo;
  FFrame.SelectedTemplate := FSelectedTemplate;
  FFrame.Access := FAccess;
  FFrame.PageName := FPageName;
  FFrame.PageTitle := FPageTitle;
  FFrame.edPageName.Modified := FPageNameModified;
  FFrame.edTitle.Modified := FPageTitleModified;
  FFrame.ScriptEngine := FScriptEngine;
  FFrame.NewTemplateFile := FNewTemplateFile;
  FHaveTemplate := FSaveHaveTemplate;
  FTemplate := FSaveTemplate;
end;

procedure TNewPageHelper.SaveOptions;
begin
  FSelectedProducerInfo := FFrame.SelectedProducerInfo;
  FSelectedTemplate := FFrame.SelectedTemplate;
  FAccess := FFrame.Access;
  FPageName := FFrame.PageName;
  FPageNameModified := FFrame.edPageName.Modified;
  FPageTitleModified := FFrame.edTitle.Modified;
  FPageTitle := FFrame.PageTitle;
  FScriptEngine := FFrame.ScriptEngine;
  FNewTemplateFile := FFrame.NewTemplateFile;
  FSaveHaveTemplate := FHaveTemplate;
  FSaveTemplate := FTemplate;
end;

function TNewPageHelper.GetTemplate: Boolean;
begin
  Result := ExtractTemplate;
end;

function TNewPageHelper.HaveTemplate: Boolean;
begin
  Result := FHaveTemplate;
end;

{ TFormComponentsList }

procedure TFormComponentsList.AddObject(const AComponentName,
  AComponentClassName: string; AComponents: TFormComponentsList);
var
  Item: TComponentObjectItem;
begin
  Item := TComponentObjectItem.Create;
  Item.ComponentName := AComponentName;
  Item.ComponentClassName := AComponentClassName;
  Item.ComponentsList := AComponents;
  FObjects.Add(Item);
end;

procedure TFormComponentsList.AddProperty(const APropertyName,
  APropertyValue: string);
var
  Item: TComponentPropertyItem;
begin
  Item := TComponentPropertyItem.Create;
  Item.PropertyName := APropertyName;
  Item.PropertyValue := APropertyValue;
  FProperties.Add(Item);
end;

constructor TFormComponentsList.Create;
begin
  FObjects := TObjectList.Create(True { Owned });
  FProperties := TObjectList.Create(True { Owned });
  inherited Create;
end;

destructor TFormComponentsList.Destroy;
begin
  inherited;
  FObjects.Free;
  FProperties.Free;
end;

function TFormComponentsList.GetObjectItem(I: Integer): TComponentObjectItem;
begin
  Result := FObjects[I] as TComponentObjectItem;
end;

function TFormComponentsList.GetPropertyItem(
  I: Integer): TComponentPropertyItem;
begin
  Result := FProperties[I] as TComponentPropertyItem;
end;

function TFormComponentsList.ObjectCount: Integer;
begin
  Result := FObjects.Count;
end;

function TFormComponentsList.PropertyCount: Integer;
begin
  Result := FProperties.Count;
end;

{ TWebDataModuleWizard }

constructor TWebDataModuleWizard.Create;
begin
  inherited;
  FComment := sWebSnapDataModuleComment;
  FIcon := sWebSnapDataModuleIconName ;
  FIDString := sWebSnapDataModuleIDString;
  FName := sWebSnapDataModuleName;
end;

procedure TWebDataModuleWizard.ImplExecute;
begin
  with TNewWebDataModForm.Create(Application) do
  try
    if ShowModal = mrOK then
    begin
      (BorlandIDEServices as IOTAModuleServices).CreateModule(TWebDataModuleCreator.CreateModule(
        CreateMode, CacheMode, stWebDataModuleFactory) as IOTAModuleCreator)
    end;
  finally
    Free;
  end;
end;

{ TStandardProducerTemplates }

resourcestring
  sStandardHTMLTemplateName = 'Standard';
  sStandardXSLTemplateName = 'Standard';
  sDataPacketXSLTemplateName = 'Data Packet';
constructor TStandardProducerTemplates.Create;
var
  PageLinks: string;
  EndUser: string;
begin
  PageLinks := Format(SiteSources.ProducerTemplates[prodtPageLinks], ['|']);
  EndUser := Format(SiteSources.ProducerTemplates[prodtEndUser], ['|']);
  inherited Create;
  Add(TProducerTemplateScriptString.Create(sStandardHTMLTemplateName,
    Format(SiteSources.ProducerTemplates[prodtHTMLStandard], ['|',
      PageLinks, EndUser]),
    [], [], [sHTMLTemplateFileType], True { Default } ));
  Add(TProducerTemplateScriptString.Create(sStandardXSLTemplateName,
    Format(SiteSources.ProducerTemplates[prodtXSLStandard], ['|']),
    [], [], [sXSLTemplateFileType], True { Default } ));
  Add(TProducerTemplateScriptString.Create(sDataPacketXSLTemplateName,
    Format(SiteSources.ProducerTemplates[prodtXSLDataPacket], ['|']),
    [], [], [sXSLTemplateFileType], False ));
  Add(TProducerTemplateString.Create(sBlankTemplateName, '%0:s',
    [], [], []));
end;


{ TComponentObjectItem }

destructor TComponentObjectItem.Destroy;
begin
  inherited;
  ComponentsList.Free;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\SiteWiz.pas initialization enter'); {$EndIf}
begin
  InitWeb;
  {$IFDEF MSWINDOWS}
  if Assigned(ComObj.CoInitializeEx) then
    ComObj.CoInitializeEx(nil, COINIT_MULTITHREADED or COINIT_APARTMENTTHREADED)
  else
    CoInitialize(nil);
  {$ENDIF}
end;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\SiteWiz.pas initialization leave'); {$EndIf}
finalization
begin
  DoneWeb;
  UnRegisterProducerTemplates(sProducerTemplateNamespace);
  {$IFDEF MSWINDOWS}
  CoUninitialize;
  {$ENDIF}
end;

end.
