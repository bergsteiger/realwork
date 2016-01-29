{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 2000-2001 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit WebAuto;

interface

uses
  Classes, Contnrs, SiteComp, HTTPProd, HTTPApp, WebCntxt, WebScript;

type

  IGetStub = interface
  ['{8821619B-6B26-4232-A2AA-EAE012AF31AB}']
    function GetStub: IInterface;
  end;

  IComponentsStub = interface
  ['{B6C2349D-59B2-4638-BAAA-FC50F59C7D5C}']
    function DispatchOfName(const AName: string; ScriptEngine: TAbstractScriptEngine): IInterface;
  end;

  TWebComponentsStub = class(TScriptComponent, IComponentsStub)
  private
  protected
    function FindObject(const AName: string): TObject; virtual;
    function DispatchOfObject(const AObject: TObject; ScriptEngine: TAbstractScriptEngine): IInterface;
    function DispatchOfName(const AName: string; ScriptEngine: TAbstractScriptEngine): IInterface; virtual;
  public
    constructor Create(AObject: TComponent); override;
    destructor Destroy; override;
  end;

  IComponentStub = interface
  ['{174E8CEC-0256-4FD0-B6B6-941D49EE0845}']
    function  Get_ClassName_: string;
    function  Get_Name_: string;
  end;

  IModuleStub = interface(IComponentStub)
  ['{C4F2F5E8-CD68-41AF-952D-61D6CD865A2A}']
    function  Get_Objects: IInterface;
  end;

  TWebModuleStub = class(TWebComponentsStub, IComponentStub, IModuleStub)
  protected
    function CreateModuleObjectsStub(Obj: TComponent): IInterface; virtual; abstract;
    { IComponentStub }
    function  Get_ClassName_: string;
    function  Get_Name_: string;
    function FindObject(const AName: string): TObject; override;
    { IModuleStub }
    function  Get_Objects: IInterface;
  public
    property Name: string read Get_Name_;
  end;

  TModuleObjectsStub = class({TScriptObject, IComponentsStub}TWebComponentsStub)
  private
    FModule: TComponent;
  protected
    function FindObject(const AName: string): TObject; override;
  public
    constructor Create(AModule: TComponent); override;
    property Module: TComponent read FModule;
  end;

  TWebComponentsStubClass = class of TWebComponentsStub;

  TWebResponseStub = class;
  THTMLItemsStub = class;

  IResponseStub = interface
  ['{4A61D005-46D3-4214-9946-5BC1DD511F02}']
    procedure Write(varText: PChar); overload;
    procedure Write(varText: string); overload;
    function  Get_Content: PChar;
    procedure Set_Content(Value: PChar);
  end;

  TWebResponseStub = class(TScriptObject, IResponseStub)
  private
    FProducer: IScriptProducer;
  private
    { IResponseStub }
    procedure Write(varText: PChar); overload;
    procedure Write(varText: string); overload;
    function  Get_Content: PChar;
    procedure Set_Content(Value: PChar);
  public
    constructor Create(AProducer: IScriptProducer);
    property Content: PChar read Get_Content write Set_Content;
  end;

  IRequestStub = interface
    ['{F1EFEE0D-3BA6-4362-8824-129BA5784ABA}']
    function  Get_PathInfo {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_ScriptName {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Host {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
  end;

  TWebRequestStub = class(TScriptObject, IRequestStub)
  protected
    function Request: TWebRequest;
    { IRequestStub }
    function  Get_PathInfo {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_ScriptName {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Host {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
  public
    constructor Create(AContext: IScriptContext);
  end;

  ISessionIDStub = interface
    ['{CDD7CF89-1C7C-40FE-AD7D-A2C726652A53}']
    function  Get_Value: string;
  end;

  TWebSessionIDStub = class(TScriptObject, ISessionIDStub)
  protected
    function  Get_Value: string;
  end;

  ISessionStub = interface
    ['{E4C2CB4F-CE1A-4D53-90C2-5CB8E7D47899}']
    function  Get_Values(Name: PChar): Variant;
    function  Get_SessionID: IInterface;
  end;

  TWebSessionStub = class(TScriptObject, ISessionStub)
  private
    FSessionIDStub: IInterface;
  protected
    function CreateSessionIDStub: IInterface; virtual; abstract;
    { IWebSession }
    function  Get_Values(Name: PChar): Variant;
    function  Get_SessionID: IInterface;
  end;

  IProducerStub = interface
    ['{8EE59B46-2F4C-40F5-837D-57E2C18F1861}']
    procedure Write(varText: PChar);
    function  Get_Content: PChar;
    procedure Set_Content(Value: PChar);
  end;

  TWebProducerStub = class(TScriptObject, IProducerStub)
  private
    FProducer: IScriptProducer;
  private
    { IProducerStub }
    procedure Write(varText: PChar);
    function  Get_Content: PChar;
    procedure Set_Content(Value: PChar);
  public
    constructor Create(AProducer: IScriptProducer);
    property Content: PChar read Get_Content write Set_Content;
  end;

  IHTMLItemsStub = interface
    ['{4671F071-AED2-4377-B0B1-E5D2B7C080FB}']
    function  Get_ControlDefault {Flags(1), (2/1) CC:0, INV:2, DBG:6}({VT_3:0}Index: Integer): Variant;
    function  Count {Flags(1), (1/0) CC:0, INV:1, DBG:6}: Integer;
    function  Get_Item {Flags(1), (2/1) CC:0, INV:2, DBG:6}({VT_3:0}Index: Integer): String;
    procedure WriteItem {Flags(1), (1/1) CC:0, INV:1, DBG:6}({VT_3:0}Index: Integer);
    property ControlDefault {Flags(2), (2/1) CC:0, INV:2, DBG:5}[{VT_3:0}Index: Integer]: Variant read Get_ControlDefault; default;
    property Item {Flags(2), (2/1) CC:0, INV:2, DBG:5}[{VT_3:0}Index: Integer]: string read Get_Item;
  end;

  THTMLItemsStub = class(TScriptObject, IHTMLItemsStub)
  private
    FProducer: IScriptProducer;
  protected
    procedure  WriteItem(Index: Integer);
    function Count: Integer;
    function Get_ControlDefault(Index: Integer): Variant;
    function Get_Item(Index: Integer): string;
  public
    constructor Create(AProducer: IScriptProducer);
  end;

  IAdapterActionArrayStub = interface
    ['{77561E9B-3754-4552-88CA-13AD02C495E2}']
  end;

  IAdapterActionStub = interface
    ['{6C3ACA7D-6314-11D4-A4A2-00C04F6BB853}']
    function  Get_Name {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Variant;
    function  Get_AsFieldValue {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  LinkToPage {Flags(1), (3/2) CC:0, INV:1, DBG:6}({VT_8:0}const PageSuccess: string;
                                                              {VT_8:0}const PageFail: string): IInterface;
    function  Get_DisplayLabel {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_Enabled {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_AsHREF {Flags(1), (1/0) CC:0, INV:2, DBG:6}: string;
    function  Get_CanExecute {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_Visible {Flags(1), (1/0) CC:0, INV:2, DBG:6}: Boolean;
    function  Get_Array_ {Flags(1), (1/0) CC:0, INV:2, DBG:6}: IInterface;
    function  Get_DisplayStyle {Flags(1), (1/0) CC:0, INV:2, DBG:6}: String;
    property Name: Variant read Get_Name;
    property AsFieldValue: string read Get_AsFieldValue;
    property DisplayLabel: string read Get_DisplayLabel;
    property Enabled: Boolean read Get_Enabled;
    property AsHREF: string read Get_AsHREF;
    property CanExecute: Boolean read Get_CanExecute;
    property Visible: Boolean read Get_Visible;
    property Array_: IInterface read Get_Array_;
    property DisplayStyle: string read Get_DisplayStyle;
  end;

  IPageStub = interface
    ['{12C4FC99-E45A-4767-8100-9B4A894EFF57}']
    function  Get_Name: string;
    function  Get_HREF: string;
    function  Get_Title: string;
    function  Get_Description: string;
    function  Get_Published: Boolean;
    function  Get_LoginRequired: Boolean;
    function  Get_CanView: Boolean;
    function  Get_DefaultAction: IInterface;
  end;

  TWebPageStub = class(TScriptObject, IPageStub)
  private
    FPageInfo: IWebPageInfo;
    FPageDispatcher: IPageDispatcher;
    FContext: IScriptContext;
  protected
    function CreateActionStub(O: TInterfacedObject): IInterface; virtual; abstract;
    { IWebPage }
    function  Get_Name: string;
    function  Get_HREF: string;
    function  Get_Title: string;
    function  Get_Description: string;
    function  Get_Published: Boolean;
    function  Get_LoginRequired: Boolean;
    function  Get_CanView: Boolean;
    function  Get_DefaultAction: IInterface;
  public
    constructor Create(AContext: IScriptContext; const APageInfo: IWebPageInfo);
    function PageDispatcher: IPageDispatcher;
    property Name: string read Get_Name;
    property Context: IScriptContext read FContext;
  end;

  IModulesStub = interface
    ['{4A5B2D92-64B3-11D4-A4A5-00C04F6BB853}']
  end;

  TWebModulesStub = class(TWebComponentsStub, IModulesStub)
  protected
    function FindObject(const AName: string): TObject; override;
  end;

  IPagesStub = interface
    ['{1CFF50C8-6995-11D4-A4AA-00C04F6BB853}']
  end;

  TWebPagesStub = class(TWebComponentsStub, IPagesStub)
  private
    FSamplePages: IInterfaceList;
    FContext: IScriptContext;
  protected
    function CreatePageStub(AContext: IScriptContext; const APageInfo: IWebPageInfo): IInterface; virtual; abstract;
    { IWebPages }
    function DispatchOfName(const AName: string; ScriptEngine: TAbstractScriptEngine): IInterface; override;
    function FindPageInfo(const AName: string): IWebPageInfo;
    function FindSamplePage(const AName: string): IWebPageInfo;
  public
    constructor Create(AContext: IScriptContext); reintroduce;
    property Context: IScriptContext read FContext;
  end;

  TSampleWebPageInfo = class(TInterfacedObject, IWebPageInfo)
  private
    FPageName: string;
  protected
    { IWebPageInfo }
    function GetPageName: string;
    function GetPageHREF: string;
    function GetPageDescription: string;
    function GetPageTitle: string;
    function GetPageIsPublished: Boolean;
    function GetLoginRequired: Boolean;
    function GetHasViewAccess: Boolean;
  public
    constructor Create(const APageName: string);
  end;

procedure RaiseStringParameterExpected;
procedure RaiseObjectParameterExpected;
procedure RaiseIntegerParameterExpected;
procedure RaiseParameterExpected;

implementation

uses SysUtils, Variants, SiteConst, AutoAdap;

procedure RaiseParameterExpected;
begin
  raise EScriptEvalError.Create(sParameterExpected)
end;

procedure RaiseStringParameterExpected;
begin
  raise EScriptEvalError.Create(sStringParameterExpected)
end;

procedure RaiseObjectParameterExpected;
begin
  raise EScriptEvalError.Create(sStringParameterExpected)
end;

procedure RaiseIntegerParameterExpected;
begin
  raise EScriptEvalError.Create(sIntegerParameterExpected)
end;

{ TWebComponentsStub }

constructor TWebComponentsStub.Create(AObject: TComponent);
begin
  inherited Create(AObject);
end;

function TWebComponentsStub.DispatchOfName(
  const AName: string; ScriptEngine: TAbstractScriptEngine): IInterface;
var
 Obj: TObject;
begin
  Result := nil;
  Obj := FindObject(AName);
  if Obj <> nil then
    Result := DispatchOfObject(Obj, ScriptEngine);
end;

function TWebComponentsStub.DispatchOfObject(const AObject: TObject; ScriptEngine: TAbstractScriptEngine): IInterface;
begin
  if AObject <> nil then
    Result := ScriptEngine.CreateComponentStub(AObject)
  else
    Result := nil;
end;

destructor TWebComponentsStub.Destroy;
begin
  inherited;
end;

function TWebComponentsStub.FindObject(const AName: string): TObject;
begin
  Assert(False, 'FindObject not implemented');
  Result := nil;
end;

{ TWebModuleStub }

function TWebModuleStub.FindObject(const AName: string): TObject;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  if Supports(Obj, IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
  else
    Result := nil;
end;

function TWebModuleStub.Get_ClassName_: string;
begin
  Result := Obj.ClassName;
end;

function TWebModuleStub.Get_Name_: string;
begin
  if Obj <> nil then
    Result := Obj.Name
  else
    Result := '';
end;

function TWebModuleStub.Get_Objects: IInterface;
begin
  if Obj <> nil then
    Result := CreateModuleObjectsStub(Obj)
  else
    Result := nil;
end;

{ TWebResponseStub }

constructor TWebResponseStub.Create(AProducer: IScriptProducer);
begin
  FProducer := AProducer;
  inherited Create;
end;

function TWebResponseStub.Get_Content: PChar;
begin
  Result := PChar(FProducer.Content);
end;

procedure TWebResponseStub.Set_Content(Value: PChar);
begin
  FProducer.Content := Value;
end;

procedure TWebResponseStub.Write(varText: PChar);
begin
  FProducer.Write(varText);
end;

procedure TWebResponseStub.Write(varText: string);
begin
  Write(PChar(varText));
end;
{ TWebProducerStub }

constructor TWebProducerStub.Create(AProducer: IScriptProducer);
begin
  FProducer := AProducer;
  inherited Create;
end;

function TWebProducerStub.Get_Content: PChar;
begin
  Result := PChar(FProducer.Content);
end;

procedure TWebProducerStub.Set_Content(Value: PChar);
begin
  FProducer.Content := FProducer.ReplaceTags(Value);
end;

procedure TWebProducerStub.Write(varText: PChar);
begin
  FProducer.Write(FProducer.ReplaceTags(varText));
end;


{ THTMLItemsStub }

constructor THTMLItemsStub.Create(AProducer: IScriptProducer);
begin
  FProducer := AProducer;
  inherited Create;
end;

procedure THTMLItemsStub.WriteItem(Index: Integer);
begin
  FProducer.WriteItem(Index);
end;

function THTMLItemsStub.Count: Integer;
begin
  Result := FProducer.HTMLBlockCount;
end;

function THTMLItemsStub.Get_ControlDefault(Index: Integer): Variant;
begin
  Result := FProducer.HTMLBlocks[Index];
end;

function THTMLItemsStub.Get_Item(Index: Integer): string;
begin
  Result := FProducer.HTMLBlocks[Index];
end;

{ TWebPageStub }

constructor TWebPageStub.Create(AContext: IScriptContext; const APageInfo: IWebPageInfo);
begin
  FPageInfo := APageInfo;
  FContext := AContext;
  inherited Create;
end;

function TWebPageStub.PageDispatcher: IPageDispatcher;
var
  AppModule: TComponent;
  GetIntf: IGetWebAppComponents;
begin
  if not Assigned(FPageDispatcher) then
  begin
    if WebContext <> nil then
    begin
      AppModule := WebContext.FindApplicationModule(FContext.WebModuleContext);
      if Supports(IUnknown(AppModule), IGetWebAppComponents, GetIntf) then
        FPageDispatcher := GetIntf.GetPageDispatcher;
    end;
  end;
  Result := FPageDispatcher;
end;

function TWebPageStub.Get_Description: string;
begin
  Result := FPageInfo.PageDescription;
end;

function TWebPageStub.Get_Title: string;
begin
  Result := FPageInfo.PageTitle;
  if Result = '' then
    Result := FPageInfo.PageName;
end;

function TWebPageStub.Get_HREF: string;
begin
  Result := FPageInfo.PageHREF;
end;

function TWebPageStub.Get_Name: string;
begin
  Result := FPageInfo.PageName;
end;

function TWebPageStub.Get_Published: Boolean;
begin
  Result := FPageInfo.PageIsPublished;
end;

function TWebPageStub.Get_LoginRequired: Boolean;
begin
  if PageDispatcher <> nil then
    Result := PageDispatcher.GetLoginRequired(FPageInfo.PageName)
  else
    Result := FPageInfo.LoginRequired;
end;

function TWebPageStub.Get_CanView: Boolean;
begin
  if PageDispatcher <> nil then
    Result := PageDispatcher.GetCanView(FPageInfo.PageName)
  else
    Result := FPageInfo.HasViewAccess;
end;

function TWebPageStub.Get_DefaultAction: IInterface;
var
  PageObj: TObject;
  ActionObj: TComponent;
  Intf: IGetDefaultAction;
  Link: TInterfacedObject;
begin
  Result := nil;
  if WebContext.FindPage(FPageInfo.PageName, [], PageObj) then
  begin
    if Supports(PageObj, IGetDefaultAction, Intf) then
    begin
      ActionObj := Intf.DefaultAction;
      if ActionObj <> nil then
      begin
        Link := TActionLink.Create(ActionObj, FPageInfo.PageName, FPageInfo.PageName);
        Result := CreateActionStub(Link);
      end;
    end;
  end;
end;

{ TWebPagesStub }

constructor TWebPagesStub.Create(AContext: IScriptContext);
begin
  FContext := AContext;
  if (AContext.WebModuleContext is TComponent) and
   (csDesigning in TComponent(AContext.WebModuleContext).ComponentState) then
    FSamplePages := TInterfaceList.Create;
  inherited Create(nil);
end;

function TWebPagesStub.FindPageInfo(const AName: string): IWebPageInfo;
var
  I: Integer;
begin
  for I := 0 to WebContext.PageCount - 1 do
  begin
    Result := WebContext.Pages[I];
    if SameText(Result.PageName, AName) then
      Exit;
  end;
  Result := nil;
  if Result = nil then
    Result := FindSamplePage(AName);
end;

function TWebPagesStub.FindSamplePage(
  const AName: string): IWebPageInfo;
var
  I: Integer;
begin
  if FSamplePages <> nil then
  begin
    for I := 0 to FSamplePages.Count - 1 do
    begin
      Result := (FSamplePages[I] as IWebPageInfo);
      if SameText(Result.PageName, AName) then
        Exit;
    end;
    Result := TSampleWebPageInfo.Create(AName) as IWebPageInfo;
    FSamplePages.Add(Result);
  end
  else
    Result := nil;
end;

function TWebPagesStub.DispatchOfName(const AName: string; ScriptEngine: TAbstractScriptEngine): IInterface;
var
  Intf: IWebPageInfo;
begin
  Intf := FindPageInfo(AName);
  if Intf <> nil then
    Result := CreatePageStub(FContext, Intf)
  else
    Result := nil;
end;

{ TSampleWebPageInfo }

constructor TSampleWebPageInfo.Create(const APageName: string);
begin
  FPageName := APageName;
  inherited Create;
end;

function TSampleWebPageInfo.GetPageTitle: string;
begin
  Result := FPageName;
end;

function TSampleWebPageInfo.GetPageDescription: string;
begin
  Result := FPageName;
end;

function TSampleWebPageInfo.GetPageHREF: string;
begin
  Result := FPageName;
end;

function TSampleWebPageInfo.GetPageIsPublished: Boolean;
begin
  Result := True;
end;

function TSampleWebPageInfo.GetLoginRequired: Boolean;
begin
  Result := False;
end;

function TSampleWebPageInfo.GetPageName: string;
begin
  Result := FPageName;
end;

function TSampleWebPageInfo.GetHasViewAccess: Boolean;
begin
  Result := True;
end;

{ TWebSessionStub }

function TWebSessionStub.Get_SessionID: IInterface;
begin
  if FSessionIDStub = nil then
    FSessionIDStub := CreateSessionIDStub;
  Result := FSessionIDStub;
end;

function TWebSessionStub.Get_Values(Name: PChar): Variant;
begin
  Result := WebContext.Session.Values[Name];
end;


{ TWebSessionIDStub }

function TWebSessionIDStub.Get_Value: string;
begin
  Result := WebContext.Session.SessionID;
end;

{ TWebModulesStub }

function TWebModulesStub.FindObject(const AName: string): TObject;
var
  Lookup: TVariableLookup;
begin
  Lookup := TVariableLookup.Create(AName, nil { app global context });
  try
    Result := Lookup.FindGlobalVariableContainer(AName);
    Assert(Assigned(Result), 'Component not found: ' + AName);
  finally
    Lookup.Free;
  end;
end;


{ TWebRequestStub }
constructor TWebRequestStub.Create(AContext: IScriptContext);
begin
  inherited Create;
  // AContext not used
end;

function TWebRequestStub.Request: TWebRequest;
begin
  if WebContext <> nil then
    Result := WebContext.Request
  else
    Result := nil;
end;

function TWebRequestStub.Get_PathInfo: string;
begin
  if Request <> nil then
    Result := Request.InternalPathInfo
  else
    Result := '';
end;

function TWebRequestStub.Get_ScriptName: string;
begin
  if Request <> nil then
    Result := Request.InternalScriptName
  else
    Result := '';
end;

function TWebRequestStub.Get_Host: string;
begin
  if Request <> nil then
    Result := Request.Host
  else
    Result := '';
end;


{ TModuleObjectsStub }

constructor TModuleObjectsStub.Create(AModule: TComponent);
begin
  FModule := AModule;
  inherited Create(AModule);
end;

function TModuleObjectsStub.FindObject(const AName: string): TObject;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  if Supports(Obj, IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
  else
    Result := nil;
end;

end.
