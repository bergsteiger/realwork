{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Registration of WebBroker components            }
{                                                       }
{   Copyright (c) 2000-2001 Borland Software Corp.      }
{                                                       }
{*******************************************************}

unit DsgnCntxt;

interface

uses
  SysUtils, Classes, HTTPApp, WebCntxt, WebScript, SiteComp;

type

  TWebDesignSession = class(TAbstractWebSession)
  protected
    function GetValue(const AName: string): Variant; override;
    procedure SetValue(const AName: string; const AValue: Variant); override;
    function GetTimeoutMinutes: Integer; override;
    procedure SetTimeoutMinutes(AValue: Integer); override;
    function GetSessionID: string; override;
  public
    procedure UpdateResponse(AResponse: TWebResponse); override;
    procedure Terminate; override;
  end;

  TDesignWebPageInfo = class;

  TWebDesignContext = class(TAbstractWebContext)
  private
    FSession: TAbstractWebSession;
    FWebModuleList: TAbstractWebModuleList;
    FDispatchedPageName: string;
    FRequestedPageName: string;
    FDesignWebPageInfo: TDesignWebPageInfo;
  protected
    function GetWebRequest: TWebRequest; override;
    function GetWebResponse: TWebResponse; override;
    function GetPageCount: Integer; override;
    function GetPageInfo(I: Integer): IWebPageInfo; override;
    function GetWebModules: TAbstractWebModuleList; override;
    function GetSession: TAbstractWebSession; override;
    function GetEndUser: IWebEndUser; override;
    function GetDispatchedPageName: string; override;
    procedure SetDispatchedPageName(const APageName: string); override;
    function GetRequestedPageName: string; override;
    procedure SetRequestedPageName(const APageName: string); override;
    function GetAdapterRequest: IUnknown; override;
    function GetAdapterResponse: IUnknown; override;
    procedure SetAdapterRequest(Intf: IUnknown); override;
    procedure SetAdapterResponse(Intf: IUnknown); override;
  public
    constructor Create;
    destructor Destroy; override;
    function FindApplicationModule(WebModuleContext: TWebModuleContext): TComponent; override;
    function FindModuleClass(AClass: TComponentClass): TComponent; override;
    function FindModuleName(const AName: string): TComponent; override;
    function FindPage(const APage: string; AOptions: TFindPageOptions; out AComponent: TObject): Boolean; override;
    function FindPageInfo(const APage: string; AOptions: TFindPageOptions; out APageInfo: TAbstractWebPageInfo): Boolean; override;
    function FindDefaultPageInfo(AComponentClass: TComponentClass; out APageInfo: TAbstractWebPageInfo): Boolean; override;
    function FindVariableContainer(const AIdent: string): TComponent; override;
  end;

  TWebDesignModuleList = class(TAbstractWebModuleList)
  protected
    function GetItem(I: Integer): TComponent; override;
    function GetItemCount: Integer; override;
    function GetOnModuleAdded: TModuleAddedProc; override;
    procedure SetOnModuleAdded(AProc: TModuleAddedProc); override;
    function GetFactoryCount: Integer; override;
    function GetFactory(I: Integer): TAbstractWebModuleFactory; override;
  public
    function FindModuleClass(AClass: TComponentClass): TComponent; override;
    function FindModuleName(const AClass: string): TComponent; override;
    function AddModuleClass(AClass: TComponentClass): TComponent; override;
    function AddModuleName(const AClass: string): TComponent; override;
  end;

  TDesignWebPageInfo = class(TAbstractWebPageInfo)
  private
    FFileName: string;
    FPageName: string;
  protected
    function GetPageFile: string; override;
    function GetPageName: string; override;
  end;

implementation

uses WebComp, ToolsAPI;

var
  WebContext: TAbstractWebContext;

{ TWebContext }

constructor TWebDesignContext.Create;
begin
  inherited;
  if Assigned(SetWebContextProc) then
    SetWebContextProc(Self);
  FSession := TWebDesignSession.Create;
  FDesignWebPageInfo := TDesignWebPageInfo.Create;
end;

destructor TWebDesignContext.Destroy;
begin
  inherited;
  if Assigned(SetWebContextProc) then
    SetWebContextProc(nil);
  FSession.Free;
  FWebModuleList.Free;
  FDesignWebPageInfo.Free;
end;

function TWebDesignContext.FindPage(const APage: string; AOptions: TFindPageOptions; out AComponent: TObject): Boolean;
begin
  AComponent := FindModuleName(APage);
  Result := AComponent <> nil;
end;

function FindModuleInfo(const AFormName: string): IOTAModuleInfo; forward;
function FindPageFileName(Module: IOTAModule): string; forward;

function TWebDesignContext.FindPageInfo(const APage: string; AOptions: TFindPageOptions;out APageInfo: TAbstractWebPageInfo): Boolean;
var
  ModuleServices: IOTAModuleServices;
  Module: IOTAModule;
  ModuleInfo: IOTAModuleInfo;
  FileName: string;
begin
  FileName := '';
  ModuleServices := BorlandIDEServices as IOTAModuleServices;
  Module := ModuleServices.FindFormModule(APage);
  if Module = nil then
  begin
    ModuleInfo := FindModuleInfo(APage);
    if Assigned(ModuleInfo) then
      Module := ModuleInfo.OpenModule;
  end;
  if Module <> nil then
    FileName := FindPageFileName(Module);

  FDesignWebPageInfo.FFileName := FileName;
  FDesignWebPageInfo.FPageName := APage;
  APageInfo := FDesignWebPageInfo;
  Result := True;
end;

function TWebDesignContext.FindModuleClass(AClass: TComponentClass): TComponent;
begin
  Assert(False);  // Unexpected call
  Result := nil;
end;

//  Need to set the page file name by finding the correct editor file
function FindPageFileName(Module: IOTAModule): string;
var
  Additional: IOTAAdditionalModuleFiles;
begin
  if Assigned(Module) and
    Supports(Module, IOTAAdditionalModuleFiles, Additional) then
  begin
    if Additional.AdditionalModuleFileCount > 0 then
    begin
      // Assume only a single additional file
      Result := Additional.AdditionalModuleFileEditors[0].FileName;
      Exit;
    end;
  end;
  Result := '';
end;

function FindModuleInfo(const AFormName: string): IOTAModuleInfo;

  function GetProjectGroup: IOTAProjectGroup;
  var
    ModuleServices: IOTAModuleServices;
    i: Integer;
  begin
    Result := nil;
    ModuleServices := BorlandIDEServices as IOTAModuleServices;
    for i := 0 to ModuleServices.ModuleCount - 1 do
      if Supports(ModuleServices.Modules[i], IOTAProjectGroup, Result) then
        Break;
  end;

var
  ProjectGroup: IOTAProjectGroup;
  I, J: Integer;
  Project: IOTAProject;
begin
  ProjectGroup := GetProjectGroup;
  if Assigned(ProjectGroup) then
  begin
    for I := 0 to ProjectGroup.GetProjectCount - 1 do
    begin
      Project := ProjectGroup.GetProject(I);
      if Assigned(Project) then
      begin
        for J := 0 to Project.GetModuleCount - 1 do
        begin
          Result := Project.GetModule(J);
          if CompareText(AFormName, Result.GetFormName) = 0 then
            Exit;
        end;
      end;
    end;
  end;
  Result := nil;
end;

function FindModuleComponent(Module: IOTAModule): TComponent;
var
  I: Integer;
  FormEditor: IOTAFormEditor;
  OTAComponent: IOTAComponent;
  NTAComponent: INTAComponent;
begin
  Result := nil;
  if Assigned(Module) then
    for I := 0 to Module.GetModuleFileCount - 1 do
      if Assigned(Module.GetModuleFileEditor(I)) and
        Supports(Module.GetModuleFileEditor(I), IOTAFormEditor, FormEditor) then
      begin
        OTAComponent := FormEditor.GetRootComponent;
        if Assigned(OTAComponent) then
        begin
          if Supports(OTAComponent, INTAComponent, NTAComponent) then
          begin
            Result := NTAComponent.GetComponent;
            Exit;
          end;
        end;
      end;
end;

function TWebDesignContext.FindModuleName(const AName: string): TComponent;
var
  ModuleServices: IOTAModuleServices;
  Module: IOTAModule;
  ModuleInfo: IOTAModuleInfo;
  DefaultPageFileName: IDefaultPageFileName;
  FileName: string;
begin
  { Dynamically create a module if not in the module list }
  ModuleServices := BorlandIDEServices as IOTAModuleServices;
  Module := ModuleServices.FindFormModule(AName);
  Result := nil;
  if Assigned(Module) then
    Result := FindModuleComponent(Module);
  if not Assigned(Result) then
  begin
    ModuleInfo := FindModuleInfo(AName);
    if Assigned(ModuleInfo) then
    begin
      Module := ModuleInfo.OpenModule;
      if Assigned(Module) then
        Result := FindModuleComponent(Module);
    end;
  end;
  if Assigned(Result) then
  begin
    FileName := FindPageFileName(Module);
    if (FileName <> '') and
       Supports(IUnknown(Result), IDefaultPageFileName, DefaultPageFileName) then
       DefaultPageFileName.SetDefaultPageFileName(FileName);
  end;
end;

function TWebDesignContext.FindVariableContainer(
  const AIdent: string): TComponent;
begin
  Result := FindModuleName(AIdent);
end;

function TWebDesignContext.GetWebRequest: TWebRequest;
begin
  Result := nil;
end;

function TWebDesignContext.GetWebResponse: TWebResponse;
begin
  Result := nil;
end;

function GetWebContext: TAbstractWebContext;
begin
  Result := WebContext;
end;

procedure SetWebContext(AWebContext: TAbstractWebContext);
begin
  WebContext := AWebContext;
end;

function TWebDesignContext.GetPageCount: Integer;
begin
  { We don't get page names at design time. }
  Result := 0;
end;

function TWebDesignContext.GetPageInfo(I: Integer): IWebPageInfo;
begin
  Assert(False, 'Unexpected call');
end;

function TWebDesignContext.GetWebModules: TAbstractWebModuleList;
begin
  if FWebModuleList = nil then
    FWebModuleList := TWebDesignModuleList.Create;
  Result := FWebModuleList;
end;

{ Use the toolsapi to find out the active module }
function TWebDesignContext.FindApplicationModule(WebModuleContext: TWebModuleContext): TComponent;
var
  Module: IOTAModule;
  ModuleInfo: IOTAModuleInfo;
  I, J: Integer;
  Project: IOTAProject;
  AppModule: IOTAModule;
  Intf: IUnknown;
begin
  if (WebModuleContext is TComponent) then
  begin
    ModuleInfo := FindModuleInfo(TComponent(WebModuleContext).Name);
    if ModuleInfo <> nil then
    begin
      Module := ModuleInfo.OpenModule;
      if Assigned(Module) then
      begin
        for I := 0 to Module.OwnerCount - 1 do
        begin
          Project := Module.Owners[I];
          if Assigned(Project) then
          begin
            for J := 0 to Project.GetModuleCount - 1 do
            begin
              ModuleInfo := Project.GetModule(J);
              if ModuleInfo.DesignClass <> '' then
              begin
                AppModule := ModuleInfo.OpenModule;
                if Assigned(AppModule) then
                begin
                  Result := FindModuleComponent(AppModule);
                  if Supports(IUnknown(Result), IGetWebAppServices, Intf) then
                    Exit;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Result := nil;
end;

function TWebDesignContext.GetSession: TAbstractWebSession;
begin
  Result := FSession;
end;

{ TWebDesignSession }

function TWebDesignSession.GetSessionID: string;
begin
  Result := '0';
end;

function TWebDesignSession.GetTimeoutMinutes: Integer;
begin
  Result := 0;
end;

function TWebDesignSession.GetValue(const AName: string): Variant;
begin
  Result := '';
end;

procedure TWebDesignSession.SetTimeoutMinutes(AValue: Integer);
begin
  // Do nothing
end;

procedure TWebDesignSession.SetValue(const AName: string;
  const AValue: Variant);
begin
  // Do nothing
end;

procedure TWebDesignSession.Terminate;
begin
  // Do nothing

end;

procedure TWebDesignSession.UpdateResponse(AResponse: TWebResponse);
begin
  // Do nothing

end;

{ TWebDesignModuleList }

function TWebDesignModuleList.AddModuleClass(
  AClass: TComponentClass): TComponent;
begin
  // Do nothing
  Result := nil;
end;

function TWebDesignModuleList.AddModuleName(
  const AClass: string): TComponent;
begin
  // Do nothing
  Result := nil;
end;

function TWebDesignModuleList.FindModuleClass(
  AClass: TComponentClass): TComponent;
begin
  Result := nil;
end;

function TWebDesignModuleList.FindModuleName(
  const AClass: string): TComponent;
begin
  // Do nothing
  Result := nil;
end;

function TWebDesignModuleList.GetFactory(
  I: Integer): TAbstractWebModuleFactory;
begin
  // Do nothing
  Result := nil;
end;

function TWebDesignModuleList.GetFactoryCount: Integer;
begin
  // Do nothing
  Result := 0;
end;

function TWebDesignModuleList.GetItem(I: Integer): TComponent;
begin
  // Do nothing
  Result := nil;
end;

function TWebDesignModuleList.GetItemCount: Integer;
begin
  // Do nothing
  Result := 0;
end;

function TWebDesignModuleList.GetOnModuleAdded: TModuleAddedProc;
begin
  Result := nil;
end;

procedure TWebDesignModuleList.SetOnModuleAdded(AProc: TModuleAddedProc);
begin
  // Do nothing
end;

function TWebDesignContext.GetEndUser: IWebEndUser;
begin
  Result := nil;
end;

function TWebDesignContext.GetDispatchedPageName: string;
begin
  Result := FDispatchedPageName;
end;

function TWebDesignContext.GetRequestedPageName: string;
begin
  Result := FRequestedPageName;
end;

procedure TWebDesignContext.SetDispatchedPageName(const APageName: string);
begin
  FDispatchedPageName := APageName;
end;

procedure TWebDesignContext.SetRequestedPageName(const APageName: string);
begin
  FRequestedPageName := APageName;
end;

function TWebDesignContext.GetAdapterRequest: IUnknown;
begin
  Result := nil;
end;

function TWebDesignContext.GetAdapterResponse: IUnknown;
begin
  Result := nil;
end;

procedure TWebDesignContext.SetAdapterRequest(Intf: IUnknown);
begin
  // Do nothing
end;

procedure TWebDesignContext.SetAdapterResponse(Intf: IUnknown);
begin
  // Do nothing
end;

function TWebDesignContext.FindDefaultPageInfo(
  AComponentClass: TComponentClass;
  out APageInfo: TAbstractWebPageInfo): Boolean;
begin
  Result := False;
end;

{ TDesignWebPageInfo }

function TDesignWebPageInfo.GetPageFile: string;
begin
  Result := FFileName;
end;

function TDesignWebPageInfo.GetPageName: string;
begin
  Result := FPageName;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\DsgnCntxt.pas initialization enter'); {$EndIf}
  GetWebContextProc := GetWebContext;
  SetWebContextProc := SetWebContext;
  WebContext := TWebDesignContext.Create;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\DsgnCntxt.pas initialization leave'); {$EndIf}
finalization
  FreeAndNil(WebContext);
  if @GetWebContextProc = @GetWebContext then
    GetWebContextProc := nil;
  if @SetWebContextProc = @SetWebContext then
    SetWebContextProc := nil;

end.
