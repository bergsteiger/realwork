{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{   Copyright (c) 2002 Borland Software Corp.           }
{                                                       }
{*******************************************************}

unit WebSnapObjs;

interface

{$WARN UNIT_LIBRARY OFF}
{$WARN UNIT_PLATFORM OFF}

uses
  SysUtils, {$IFDEF MSWINDOWS}Windows, ActiveX,{$ENDIF}
  WebCntxt, SiteComp, Classes, HTTPProd, HTTPApp, ObjComAuto;

type
  {$METHODINFO ON}
  TScriptableObject = class(TObjectDispatch)
  private
    FLookupList: TStringList;
    FLookupValues: TInterfaceList;
  protected
    FPreferChild: Boolean;
    function DispatchOfName(const AName: string): IDispatch; virtual;
    function FindObject(const AName: string): TObject; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    class function DispatchOfObject(const AObject: TObject): IDispatch;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount: Integer; LocaleID: Integer; DispIDs: Pointer): HRESULT;
      override;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult: Pointer; ExcepInfo: Pointer;
      ArgErr: Pointer): HRESULT; override;
  end;
  {$METHODINFO OFF}

  TObjectScripter = class(TScriptableObject)
  private
    FObject: TObject; // Object who we are exposing via script
    FObjectIntf: IInterface; // Interface for reference counting
  protected
    function FindObject(const AName: String): TObject; override;
    property ObjectAccess: TObject read FObject;
  public
    constructor Create(AObject: TObject); virtual;
    destructor Destroy; override;
  end;

  TObjectScripterClass = class of TObjectScripter;

  IWebSnapObjClass = interface
  ['{2D98BC03-3595-424C-9F7B-6804F96EF444}']
    function GetWebSnapObjClass: TObjectScripterClass;
    property WebSnapObjClass: TObjectScripterClass read GetWebSnapObjClass;
  end;

  TContextObj = class(TScriptableObject)
  protected
    FContext: IScriptContext;
  public
    constructor Create(AContext: IScriptContext); 
  end;

  TStringsObj = class(TScriptableObject)
  private
    FStrings: TStrings;
    function GetCommaText: string;
    function GetCount: Integer;
    function GetText: string;
    procedure SetCommaText(const Value: string);
    procedure SetText(const Value: string);
  public
    constructor Create(AStrings: TStrings);
  published
    property CommaText: string read GetCommaText write SetCommaText;
    property Count: Integer read GetCount;
    property Text: string read GetText write SetText;
    function Names(Index: Integer): string; // Names[..] isn't allowed
    function Values(const Name: string): string; // Values[..] isn't allowed
    procedure SetValues(const Name: string; const Value: string);
  end;

  TSessionObj = class(TScriptableObject)
  private
    function GetSessionID: string;
  public
    function GetValue(const Name: string): Variant;
    procedure SetValue(const Name: string; const Value: Variant);
    function Values(const Name: string): Variant;
  published
    // Setting of the SessionID never worked, even though it was
    // "writable" in the old scripting style.
    property SessionID: string read GetSessionID;
  end;

  TPageObj = class(TContextObj)
  private
    FPageInfo: IWebPageInfo;
    FPageDispatcher: IPageDispatcher;
    function GetCanView: WordBool;
    function GetDefaultAction: Variant;
    function GetDescription: WideString;
    function GetHREF: WideString;
    function GetLoginRequired: WordBool;
    function GetName: WideString;
    function GetPublished: WordBool;
    function GetTitle: WideString;
    function PageDispatcher: IPageDispatcher;
  published
    property Name: WideString read GetName;
    property PageName: WideString read GetName; { Same as the Name }
    property HREF: WideString read GetHREF;
    property Title: WideString read GetTitle;
    property Description: WideString read GetDescription;
    property Published_: WordBool read GetPublished;
    property LoginRequired: WordBool read GetLoginRequired;
    property CanView: WordBool read GetCanView;
    property DefaultAction: Variant read GetDefaultAction;
  public
    constructor Create(AContext: IScriptContext; APageInfo: IWebPageInfo); reintroduce;
  end;

  TRequestObj = class(TContextObj)
  private
  protected
    function Request: TWebRequest;
    function GetPathTranslated: WideString;
    function GetHost: WideString;
    function GetPathInfo: WideString;
    function GetScriptName: Widestring;
    function GetMethod: WideString;
    function GetProcolVersion: WideString;
    function GetQuery: WideString;
    function GetUrl: WideString;
  published
    property PathInfo: WideString read GetPathInfo;
    property ScriptName: WideString read GetScriptName;
    property Host: WideString read GetHost;
    property Method: WideString read GetMethod;
    property ProtocolVersion: WideString read GetProcolVersion;
    property URL: WideString read GetUrl;
    property Query: WideString read GetQuery;
    property PathTranslated: WideString read GetPathTranslated;
    function QueryFields: Variant;
  end;

  TProducerObj = class(TScriptableObject)
  protected
    FScriptProducer: IScriptProducer; 
    function GetContent: WideString; virtual;
    procedure SetContent(const Value: WideString); virtual;
  public
    procedure Write(Value: Variant); virtual;
    constructor Create(AProducer: IScriptProducer);
  published
    property Content: WideString read GetContent write SetContent;
  end;

  TResponseObj = class(TProducerObj)
  private
    function GetAllow: string;
    function GetContentEncoding: string;
    function GetContentLength: Integer;
    function GetContentVersion: string;
    function GetRealm: string;
    function GetServer: string;
    function GetStatusCode: Integer;
    function GetTitle: string;
    function GetVersion: string;
    function GetWWWAuthenticate: string;
    procedure SetAllow(const Value: string);
    procedure SetContentEncoding(const Value: string);
    procedure SetContentLength(const Value: Integer);
    procedure SetContentVersion(const Value: string);
    procedure SetRealm(const Value: string);
    procedure SetReasonString(const Value: string);
    procedure SetServer(const Value: string);
    procedure SetStatusCode(const Value: Integer);
    procedure SetTitle(const Value: string);
    procedure SetVersion(const Value: string);
    procedure SetWWWAuthenticate(const Value: string);
    function GetReasonString: string;
    function GetLocation: string;
    procedure SetLocation(const Value: string);
    function GetContentType: string;
    procedure SetContentType(const Value: string);
//    function GetExpires: TDateTime;
//    procedure SetExpires(const Value: TDateTime);
  published
    property Allow: string read GetAllow write SetAllow;
    property Version: string read GetVersion write SetVersion;
    property ReasonString: string read GetReasonString write SetReasonString;
    property Server: string read GetServer write SetServer;
    property WWWAuthenticate: string read GetWWWAuthenticate write SetWWWAuthenticate;
    property Realm: string read GetRealm write SetRealm;
    property Location: string read GetLocation write SetLocation;
    property ContentEncoding: string read GetContentEncoding write SetContentEncoding;
    property ContentType: string read GetContentType write SetContentType;
    property ContentVersion: string read GetContentVersion write SetContentVersion;
    property DerivedFrom: string read GetContentVersion write SetContentVersion;
    property Title: string read GetTitle write SetTitle;

    property StatusCode: Integer read GetStatusCode write SetStatusCode;
    property ContentLength: Integer read GetContentLength write SetContentLength;
  end;

  THTMLItemsObj = class(TProducerObj)
  private
    function GetCount: Integer;
    function GetItem(Index: Integer): string;
  published
    property Count: Integer read GetCount;
  public
    function Item(Index: Integer): string;
    procedure  WriteItem(Index: Integer);
  end;

  TEnumeratorObj = class(TObjectScripter)
  private
    FReset: Boolean;
    FCurrentIndex: Integer;
  protected
    function GetListCount: Integer; virtual; abstract;
    function GetListItem(I: Integer): Variant; virtual; abstract;
    property Reset: Boolean read FReset write FReset;
  public
    constructor Create(AObject: TObject); override;

    // Case is done this way on purpose for backwards compat.
    function moveFirst: Boolean; virtual; // Return true if NOT at EOF, else false
    function moveNext: Boolean; virtual; // Return true if NOT at EOF, else false
    function atEnd: Bool; virtual;
    function item: Variant; // override GetListItem

    function Items(Index: Integer): Variant; 
  published
    property Count: Integer read GetListCount;
  end;

  TPagesObj = class(TEnumeratorObj)
  private
    FContext: IScriptContext;
    FSamplePages: IInterfaceList;
    function FindSamplePage(const AName: string): IDispatch;
  protected
    function GetListCount: Integer; override;
    function GetListItem(I: Integer): Variant; override;
    function DispatchOfName(const AName: string): IDispatch; override;
  public
    constructor Create(Context: IScriptContext); reintroduce;
  end;

  TModulesObj = class(TEnumeratorObj)
  protected
    function GetListCount: Integer; override;
    function GetListItem(I: Integer): Variant; override;
    function FindObject(const AName: String): TObject; override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

  // TComponentsEnumerator is a generic iterator for any TComponent that supports IIteratorSupport
  TComponentsEnumerator = class(TEnumeratorObj)
  private
    FIterating: Boolean;
    FAtEof: Boolean;
    function GetName: string;
    function GetClassName: string;
  protected
    FOwnerData: Pointer;
    FObjectIterator: IIterateObjectSupport;
    FIterator: IIteratorSupport;
    FIntfIterator: IIterateIntfSupport;
    function GetListCount: Integer; override;
    function GetListItem(I: Integer): Variant; override;
  public
    function moveNext: Boolean; override;
    function atEnd: Bool; override;
    procedure EndIterating;
    constructor Create(AObject: TObject); override; // Object must have support for the IIteratorSupport interface
    function ClassName: string; reintroduce;
  published
    property Name: string read GetName;
    property Name_: string read GetName; // For backwards compatability
    property ClassName_: string read GetClassName;  // For backwards compatability
  end;

  TModuleObj = class(TComponentsEnumerator)
  private
    function GetObjects: Variant;
  public
    constructor Create(AObject: TObject); override;
    destructor Destroy; override;
  published
    // Really, you can just enumerate the TModuleObj - this is a hack, for backwards compatability
    property Objects: Variant read GetObjects;
  end;

  TErrorsObj = class(TComponentsEnumerator)
  protected
    function GetListCount: Integer; override;
    function GetListItem(I: Integer): Variant; override;
  public
    constructor Create(AObject: TObject); override;
  end;

  TErrorObj = class(TScriptableObject)
  private
    FError: IAdapterError;
    function GetField: Variant;
    function GetID: Integer;
    function GetMessage: string;
  published
    property Message: string read GetMessage;
    property Field: Variant read GetField;
    property ID: Integer read GetID;
  public
    constructor Create(Error: IAdapterError);
  end;


  THiddenFieldsEnum = class(TComponentsEnumerator)
  public
    procedure WriteFields(Response: Variant);
  end;

  TBaseAdapterObj = class(TComponentsEnumerator)
  protected
    function GetFields: Variant; virtual;
    function GetActions: Variant; virtual;
    function GetRecords: Variant; virtual;
  public
    constructor Create(AObject: TObject); override;
  published
    property Fields: Variant read GetFields;
    property Actions: Variant read GetActions;
    property Records: Variant read GetRecords; // Not all adapters may have Records, but this is for simplicity
  end;

  TAdapterObj = class(TBaseAdapterObj)
  private
    procedure SetMode(const Value: string);
  protected
    function GetErrors: Variant;
    function GetMode: string;
    function GetCanView: Boolean;
    function GetCanModify: Boolean;
    function GetHiddenFields: Variant;
    function GetHiddenRecordFields: Variant;
  published
    property Errors: Variant read GetErrors;
    property Mode: string read GetMode write SetMode;
    property CanView: Boolean read GetCanView;
    property CanModify: Boolean read GetCanModify;
    property HiddenFields: Variant read GetHiddenFields;
    property HiddenRecordFields: Variant read GetHiddenRecordFields;
  end;

  TApplicationObj = class(TAdapterObj)
  private
    FContext: IScriptContext;
    FApplicationInfo: IWebApplicationInfo;
    FCachedModuleName: string;
    function GetTitle: WideString;
    function GetDesigning: Boolean;
    function GetModuleFileName: WideString;
    function GetModulePath: WideString;
  public
    constructor Create(AContext: IScriptContext); reintroduce;
    function QualifyFileName(const FileName: WideString): WideString;
  published
    property Designing: Boolean read GetDesigning;
    property ModulePath: WideString read GetModulePath;
    property ModuleFileName: WideString read GetModuleFileName;
    property Title: WideString read GetTitle;
  end;

  TEndUserObj = class(TAdapterObj)
  private
    FEndUser: IWebEndUser;
    FContext: IScriptContext;

    function GetDisplayName: WideString;
    function GetLoggedIn: Boolean;
    function GetLoginForm: Variant;
    function GetLogout: Variant;
  published
    property DisplayName: WideString read GetDisplayName;
    property LoggedIn: Boolean read GetLoggedIn;
    property LoginForm: Variant read GetLoginForm;
    property Logout: Variant read GetLogout;
    property LogoutAction: Variant read GetLogout;
    property LoginFormAction: Variant read GetLoginForm; 
  public
    constructor Create(AContext: IScriptContext); reintroduce;
  end;

  TAdapterValuesListObj = class(TAdapterObj)
  protected
    function GetValueName: string;
    function GetValue: Variant;
    function GetImage: Variant;
  public
    function NameOfValue(Value: Variant): string;
    function ImageOfValue(Value: Variant): Variant;
  published
    property ValueName: string read GetValueName;
    property Value: Variant read GetValue;
    property Image: Variant read GetImage;
  end;

  TAdapterFieldValuesObj = class(TAdapterObj)
  private
    function GetValue: Variant;
  published
    property Value: Variant read GetValue;
    function  HasValue {Flags(1), (2/1) CC:0, INV:1, DBG:6}({VT_12:0}Value: Variant): Boolean;
  end;

  TAdapterFieldObj = class(TComponentsEnumerator)
  private
    function AsEditText(const Value: Variant): string;
    function GetCanModify: Boolean;
    function GetCanView: Boolean;
    function GetDisplayLabel: string;
    function GetDisplayStyle: string;
    function GetDisplayText: string;
    function GetDisplayWidth: Integer;
    function GetEditText: string;
    function GetImage: Variant;
    function GetInputName: string;
    function GetInputStyle: string;
    function GetMaxLength: Integer;
    function GetRequired: Boolean;
    function GetValue: Variant;
    function GetValues: Variant;
    function GetValuesList: Variant;
    function GetViewMode: string;
    function GetVisible: Boolean;
  public
    function IsEqual(Value: Variant): Boolean;
  published
    property Value: Variant read GetValue;
    property DisplayText: string read GetDisplayText;
    property EditText: string read GetEditText;
    property InputName: string read GetInputName;
    property DisplayWidth: Integer read GetDisplayWidth;
    property DisplayLabel: string read GetDisplayLabel;
    property ValuesList: Variant read GetValuesList;
    property InputStyle: string read GetInputStyle;
    property DisplayStyle: string read GetDisplayStyle;
    property Image: Variant read GetImage;
    property CanModify: Boolean read GetCanModify;
    property CanView: Boolean read GetCanView;
    property Values: Variant read GetValues;
    property ViewMode: string read GetViewMode;
    property Required: Boolean read GetRequired;
    property Visible: Boolean read GetVisible;
    property MaxLength: Integer read GetMaxLength;
  end;

  TAdapterActionObj = class(TComponentsEnumerator)
  private
    FSuccessPage, FFailurePage: string;
    function GetEncodedPages(EncodeAsQuery: Boolean): string;
    function GetArray: Variant; deprecated;
    function GetAsFieldValue: string;
    function GetAsHREF: string;
    function GetCanExecute: Boolean;
    function GetDisplayLabel: string;
    function GetDisplayStyle: string;
    function GetEnabled: Boolean;
    function GetName: Variant;
    function GetVisible: Boolean;
  published
    property Array_: Variant read GetArray;
    property Name: Variant read GetName;
    property AsFieldValue: string read GetAsFieldValue;
    property DisplayLabel: string read GetDisplayLabel;
    property Enabled: Boolean read GetEnabled;
    property AsHREF: string read GetAsHREF;
    property CanExecute: Boolean read GetCanExecute;
    property Visible: Boolean read GetVisible;
    property DisplayStyle: string read GetDisplayStyle;
    property SuccessPage: string read FSuccessPage write FSuccessPage;
    property FailurePage: string read FFailurePage write FFailurePage;
    function LinkToPage(PageSuccess, PageFail: string): Variant;
  end;

  TImageObj = class(TComponentsEnumerator)
  public
    function AsHREF: WideString;
  end;

  TImageProducerObj = class(TComponentsEnumerator)
  public
    function GetImage(const ComponentName, Caption: string): Variant;
    function GetEventImage(const ComponentName, Event, Caption: string): Variant;
    function GetDisplayStyle(const Component: TComponent): string;
  end;

  EScriptException = class(Exception);

  TCustomEnumDispatcher = class(TInterfacedObject, IDispatch)
  private
    FScriptObjRef: IDispatch;
  protected
    FScriptObj: TEnumeratorObj;
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount: Integer; LocaleID: Integer; DispIDs: Pointer): HRESULT;
      virtual; stdcall;
    function GetTypeInfo(Index: Integer; LocaleID: Integer;
      out TypeInfo): HRESULT; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HRESULT; virtual; stdcall; 
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult: Pointer; ExcepInfo: Pointer;
      ArgErr: Pointer): HRESULT; virtual; stdcall; 
  public
    constructor Create(ScriptObj: TEnumeratorObj); virtual;
    destructor Destroy; override;
  end;

  TCustomEnumDispClass = class of TCustomEnumDispatcher;

var
  DispatcherClass: TCustomEnumDispClass = nil;
  // Assign DispatcherClass to a particular class in your engine's implementation
  // if you need to handle Enumerators in a special way. Each time
  // a field is created the is an enumerator, it uses
  // this class instead of the TObjectDispatch, if DispatcherClass isn't nil.

function CreateEnumeratedObject(NewEnum: TEnumeratorObj): IDispatch;

implementation

uses
  SiteConst, Variants, WebComp, WebDisp, ObjAuto, WebScript, WebAuto;

function CreateEnumeratedObject(NewEnum: TEnumeratorObj): IDispatch;
begin
  // Should we filter it through an enumerator?
  if DispatcherClass = nil then
    Result := NewEnum
  else
    Result := DispatcherClass.Create(NewEnum) as IDispatch;
end;

{ TApplicationObj }

constructor TApplicationObj.Create(AContext: IScriptContext);
var
  AppModule: TComponent;
  GetIntf: IGetWebAppComponents;
begin
  FContext := AContext;
  FApplicationInfo := nil;
  FCachedModuleName := '';
  FApplicationInfo := nil;

  if FContext <> nil then
  begin
    AppModule := WebContext.FindApplicationModule(FContext.WebModuleContext);
    if Supports(IUnknown(AppModule), IGetWebAppComponents, GetIntf) then
      FApplicationInfo := GetIntf.WebApplicationInfo;
  end;

  if FApplicationInfo <> nil then
    inherited Create(FApplicationInfo.ApplicationAdapter)
  else
    inherited Create(nil);
  FPreferChild := False;
end;

function TApplicationObj.GetDesigning: Boolean;
begin
  if FContext.WebModuleContext is TComponent then
    Result := csDesigning in TComponent(FContext.WebModuleContext).ComponentState
  else
    Result := False;
end;

function TApplicationObj.QualifyFileName(const FileName: WideString): WideString;
begin
  Result := WebComp.QualifyFileName(FileName)
end;

function TApplicationObj.GetTitle: WideString;
begin
  if FApplicationInfo <> nil then
    Result := FApplicationInfo.ApplicationTitle
  else
    Result := '';
end;

function TApplicationObj.GetModuleFileName: WideString;
begin
  if FCachedModuleName = '' then
  begin
    if Assigned(GetModuleFileNameProc) then
      FCachedModuleName := GetModuleFileNameProc
  end;
  Result := FCachedModuleName;
end;

function TApplicationObj.GetModulePath: WideString;
begin
  Result := ExtractFilePath(ModuleFileName)
end;

{ TEndUserObj }

constructor TEndUserObj.Create(AContext: IScriptContext);
var
  AppModule: TComponent;
  GetIntf: IGetWebAppComponents;
begin
  FContext := AContext;
  FEndUser := nil;
  if FContext <> nil then
  begin
    AppModule := WebContext.FindApplicationModule(FContext.WebModuleContext);
    if Supports(IUnknown(AppModule), IGetWebAppComponents, GetIntf) then
      FEndUser := GetIntf.GetWebEndUser;
  end;
  if FEndUser <> nil then
    inherited Create(FEndUser.EndUserAdapter)
  else
    inherited Create(nil);
  FPreferChild := False;
end;

function TEndUserObj.GetDisplayName: WideString;
begin
  if FEndUser <> nil then
    Result := FEndUser.DisplayName
  else
    Result := '';

end;

function TEndUserObj.GetLoggedIn: Boolean;
begin
  if FEndUser <> nil then
    Result := FEndUser.LoggedIn
  else
    Result := False;
end;

function TEndUserObj.GetLoginForm: Variant;
var
  Obj: TComponent;
begin
  Result := Unassigned;
  if FEndUser <> nil then
  begin
    Obj := FEndUser.LoginFormAction;
    if Obj <> nil then
      Result := TAdapterActionObj.Create(Obj) as IDispatch;
  end;
end;

function TEndUserObj.GetLogout: Variant;
var
  Obj: TComponent;
begin
  Result := Unassigned;
  if FEndUser <> nil then
  begin
    Obj := FEndUser.LogoutAction;
    if Obj <> nil then
      Result := TAdapterActionObj.Create(Obj) as IDispatch;
  end;
end;

{ TContextObj }

constructor TContextObj.Create(AContext: IScriptContext);
begin
  inherited Create;
  FContext := AContext;
end;

{ TAdapterActionObj }
function TAdapterActionObj.GetArray: Variant;
var
  Intf: IIsAdapterActionList;
begin
  if Supports(ObjectAccess, IIsAdapterActionList, Intf) and Intf.IsAdapterActionList then
    Result := CreateEnumeratedObject(TAdapterActionObj.Create(ObjectAccess))
  else
    Result := Unassigned;
end;

const
  sUnknown = 'Unknown'; { Do not localize } 

function FindApplicationModuleOfObject(Component: TComponent): TComponent;
var
  C: TComponent;
begin
  if WebContext <> nil then
  begin
    C := Component;
    if C <> nil then
    begin
      while C.GetParentComponent <> nil do
        C := C.GetParentComponent;
      C := C.Owner;
    end;
    Result := WebContext.FindApplicationModule(C);
  end
  else
    Result := nil;
end;

type
  TTempAdapterDispatcher = class(TInterfacedObject, IAdapterDispatcher)
  private
    FAdapterDispatcher: TAdapterDispatcher;
  protected
    property AdapterDispatcher: TAdapterDispatcher read FAdapterDispatcher implements IAdapterDispatcher;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  constructor TTempAdapterDispatcher.Create;
  begin
    inherited;
    FAdapterDispatcher := TAdapterDispatcher.Create(nil);
  end;

  destructor TTempAdapterDispatcher.Destroy;
  begin
    FAdapterDispatcher.Free;
    inherited;
  end;

function FindAdapterDispatcher(Component: TComponent): IAdapterDispatcher;
var
  GetIntf: IGetWebAppComponents;
  AppModule: TComponent;
begin
  AppModule := FindApplicationModuleOfObject(Component);
  if Supports(IUnknown(AppModule), IGetWebAppComponents, GetIntf) then
    Result := GetIntf.GetAdapterDispatcher;
  if Result = nil then
    Result := TTempAdapterDispatcher.Create;
end;

function TAdapterActionObj.GetAsFieldValue: string;
var
  Intf: IAdapterDispatcher;
  ExtraParams: string;
begin
  Intf := FindAdapterDispatcher(ObjectAccess as TComponent);
  if Intf <> nil then
  begin
    ExtraParams := GetEncodedPages(False);
    Result := Intf.EncodeAdapterItemRequestAsFieldValue(TComponent(ObjectAccess), [])
      + ExtraParams;
  end
  else
    Result := sUnknown;
end;

function TAdapterActionObj.GetAsHREF: string;
var
  Intf: IAdapterDispatcher;
  ExtraParams: string;
begin
  Intf := FindAdapterDispatcher(ObjectAccess as TComponent);
  if Intf <> nil then
  begin
    ExtraParams := GetEncodedPages(True);
    Result := Intf.EncodeAdapterItemRequestAsHREF(TComponent(ObjectAccess), []);
    if ExtraParams <> '' then
    begin
      if Length(ExtraParams) > 2 then
        Delete(ExtraParams, 1, 2); // Delete the /?
      Result := Result + '&' + ExtraParams;
    end;
  end
  else
    Result := sUnknown;
end;

function TAdapterActionObj.GetCanExecute: Boolean;
var
  Intf: IAdapterActionAccess;
begin
  if Supports(ObjectAccess, IAdapterActionAccess, Intf) then
    Result := Intf.HasExecuteAccess
  else
    Result := True
end;

function TAdapterActionObj.GetDisplayLabel: string;
var
  GetDisplayLabel: IWebGetDisplayLabel;
begin
  if Supports(ObjectAccess, IWebGetDisplayLabel, GetDisplayLabel) then
    Result := GetDisplayLabel.GetDisplayLabel
  else
    Result := '';
end;

function TAdapterActionObj.GetDisplayStyle: string;
var
  Intf: IGetHTMLStyle;
begin
  if Supports(ObjectAccess, IGetHTMLStyle, Intf) then
    Result := Intf.GetDisplayStyle('')
  else
    Result := '';
end;

function TAdapterActionObj.GetEnabled: Boolean;
var
  Intf: IWebEnabled;
begin
  if Supports(ObjectAccess, IWebEnabled, Intf) then
    Result := Intf.WebEnabled
  else
    Result := True;
end;

function TAdapterActionObj.GetEncodedPages(EncodeAsQuery: Boolean): string;
var
  TempList: TStringList;
begin
  if (FSuccessPage <> '') or (FFailurePage <> '') then
  begin
    TempList := TStringList.Create;
    try
      if FSuccessPage <> '' then
        TempList.Add(sSuccessPageParamName + '=' + FSuccessPage);
      if FFailurePage <> '' then
        TempList.Add(sFailurePageParamName + '=' + FSuccessPage);
      if EncodeAsQuery then
        Result := EncodeParamsAsHTTPQuery(TempList)
      else
        Result := EncodeParamNameValues(TempList);
    finally
      TempList.Free;
    end;
  end
  else
    Result := '';
end;

function TAdapterActionObj.GetName: Variant;
var
  Intf: IWebVariableName;
begin
  if Supports(ObjectAccess, IWebVariableName, Intf) then
    Result := Intf.VariableName
  else                                          
    Result := '';
end;

function TAdapterActionObj.GetVisible: Boolean;
var
  Intf: IAdapterActionAttributes;
begin
  if Supports(ObjectAccess, IAdapterActionAttributes, Intf) then
    Result := Intf.GetVisible
  else
    Result := True;
end;


function TAdapterActionObj.LinkToPage(PageSuccess,
  PageFail: string): Variant;
var
  ResultObj: TAdapterActionObj;
begin
  ResultObj := TAdapterActionObj.Create(FObject);
  ResultObj.SuccessPage := PageSuccess;
  ResultObj.FailurePage := PageFail;
  Result := ResultObj as IDispatch;
end;

{ TSessionObj }

function TSessionObj.GetSessionID: string;
begin
  Result := WebContext.Session.SessionID;
end;

function TSessionObj.GetValue(const Name: string): Variant;
begin
  Result := WebContext.Session.Values[Name];
end;

procedure TSessionObj.SetValue(const Name: string; const Value: Variant);
begin
  WebContext.Session.Values[Name] := Value;
end;

function TSessionObj.Values(const Name: string): Variant;
begin
  Result := GetValue(Name);
end;

{ TPageObj }

constructor TPageObj.Create(AContext: IScriptContext;
  APageInfo: IWebPageInfo);
begin
  inherited Create(AContext);
  FPageInfo := APageInfo;
end;

function TPageObj.GetCanView: WordBool;
begin
  if PageDispatcher <> nil then
    Result := PageDispatcher.GetCanView(FPageInfo.PageName)
  else
    Result := FPageInfo.HasViewAccess;
end;

function TPageObj.GetDefaultAction: Variant;
var
  PageObj: TObject;
  ActionObj: TComponent;
  Intf: IGetDefaultAction;
  ResActionObj: TAdapterActionObj;
begin
  Result := Unassigned;
  if WebContext.FindPage(FPageInfo.PageName, [], PageObj) then
  begin
    if Supports(PageObj, IGetDefaultAction, Intf) then
    begin
      ActionObj := Intf.DefaultAction;
      if ActionObj <> nil then
      begin
        ResActionObj := TAdapterActionObj.Create(ActionObj);
        ResActionObj.SuccessPage := FPageInfo.PageName;
        ResActionObj.FailurePage := FPageInfo.PageName;
        Result := TAdapterActionObj.Create(ActionObj) as IDispatch;
      end;
    end;
  end;
end;

function TPageObj.GetDescription: WideString;
begin
  Result := FPageInfo.PageDescription;
end;

function TPageObj.GetHREF: WideString;
begin
  Result := FPageInfo.PageHREF;
end;

function TPageObj.GetLoginRequired: WordBool;
begin
  if PageDispatcher <> nil then
    Result := PageDispatcher.GetLoginRequired(FPageInfo.PageName)
  else
    Result := FPageInfo.LoginRequired;
end;

function TPageObj.GetName: WideString;
begin
  Result := FPageInfo.PageName;
end;

function TPageObj.GetPublished: WordBool;
begin
  Result := FPageInfo.PageIsPublished;
end;

function TPageObj.GetTitle: WideString;
begin
  Result := FPageInfo.PageTitle;
  if Result = '' then
    Result := FPageInfo.PageName;
end;

function TPageObj.PageDispatcher: IPageDispatcher;
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

{ TRequestObj }

function TRequestObj.GetHost: WideString;
begin
  if Request <> nil then
    Result := Request.Host
  else
    Result := '';
end;

function TRequestObj.GetMethod: WideString;
begin
  if Request <> nil then
    Result := Request.Method
  else
    Result := '';
end;

function TRequestObj.GetPathInfo: WideString;
begin
  if Request <> nil then
    Result := Request.InternalPathInfo
  else
    Result := '';
end;

function TRequestObj.GetPathTranslated: WideString;
begin
  if Request <> nil then
    Result := Request.PathTranslated
  else
    Result := '';
end;

function TRequestObj.GetProcolVersion: WideString;
begin
  if Request <> nil then
    Result := Request.ProtocolVersion
  else
    Result := '';
end;

function TRequestObj.GetQuery: WideString;
begin
  if Request <> nil then
    Result := Request.Query
  else
    Result := ''
end;

function TRequestObj.GetScriptName: WideString;
begin
  if Request <> nil then
    Result := Request.InternalScriptName
  else
    Result := '';
end;

function TRequestObj.GetUrl: WideString;
begin
  if Request <> nil then
    Result := Request.URL
  else
    Result := '';
end;

function TRequestObj.QueryFields: Variant;
begin
  if Request <> nil then
    Result := TStringsObj.Create(Request.QueryFields) as IDispatch
  else
    Result := Unassigned;
end;

function TRequestObj.Request: TWebRequest;
begin
  if WebContext <> nil then
    Result := WebContext.Request
  else
    Result := nil;
end;

{ TEnumeratorObj }

function TEnumeratorObj.atEnd: Bool;
begin
  Result := FCurrentIndex >= GetListCount;
end;

constructor TEnumeratorObj.Create;
begin
  inherited Create(AObject);
  FReset := False;
  FCurrentIndex := 0;
end;

function TEnumeratorObj.item: Variant;
begin
  Result := GetListItem(FCurrentIndex);
end;

function TEnumeratorObj.Items(Index: Integer): Variant;
begin
  Result := GetListItem(Index);
end;

function TEnumeratorObj.moveFirst: Boolean;
begin
  FReset := True;
  Result := moveNext;
end;

function TEnumeratorObj.moveNext: Boolean;
begin
  if FReset then
  begin
    FReset := False;
    FCurrentIndex := 0;
  end
  else
    Inc(FCurrentIndex);
  if not atEnd then
    Result := True
  else
    Result := False;
end;

{ TPagesObj }

constructor TPagesObj.Create(Context: IScriptContext);
begin
  inherited Create(nil);
  FContext := Context;
  if (Context.WebModuleContext is TComponent) and
     (csDesigning in TComponent(Context.WebModuleContext).ComponentState) then
    FSamplePages := TInterfaceList.Create;
end;

function TPagesObj.FindSamplePage(
  const AName: string): IDispatch;
var
  I: Integer;
  V: Variant;
begin
  if FSamplePages <> nil then
  begin
    for I := 0 to FSamplePages.Count - 1 do
    begin
      Result := FSamplePages[I] as IDispatch;
      V := Result;
      if SameText(V.PageName, AName) then
        Exit;
    end;
    Result := TPageObj.Create(FContext, TSampleWebPageInfo.Create(AName));
    FSamplePages.Add(Result);
  end
  else
    Result := nil;
end;

function TPagesObj.DispatchOfName(const AName: string): IDispatch;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to WebContext.PageCount - 1 do
    if SameText(WebContext.Pages[I].PageName, AName) then
    begin
      Result := TPageObj.Create(FContext, WebContext.Pages[I]) as IDispatch;
      Break;
    end;
  if Result = nil then
  begin
    Result := FindSamplePage(AName);
    if Result = nil then
      raise EScriptException.CreateFmt(sComponentNotFound, [AName])
  end;
end;

function TPagesObj.GetListCount: Integer;
begin
  if WebContext <> nil then
    Result := WebContext.PageCount
  else
    Result := 0;
end;

function TPagesObj.GetListItem(I: Integer): Variant;
begin
  Result := TPageObj.Create(FContext, WebContext.Pages[I]) as IDispatch;
end;

{ TWebSnapObjDispatch }

procedure WideCharToShortString(P: PWideChar; var S: ShortString);
var
  I: Integer;
  W: WideChar;
begin
  I := 0;
  repeat
    W := P[I];
    if W = #0 then Break;
    if W >= #256 then W := #0;
    Inc(I);
    S[I] := Char(W);
  until I = 255;
  S[0] := Char(I);
end;


{ TModulesObj }

constructor TModulesObj.Create;
begin
  inherited Create(nil); // no object needed
end;

destructor TModulesObj.Destroy;
begin
  inherited;
end;

function TModulesObj.FindObject(const AName: String): TObject;
var
  Lookup: TVariableLookup;
begin
  Lookup := TVariableLookup.Create(AName, nil { app global context });
  try
    Result := Lookup.FindGlobalVariableContainer(AName);
    if Result = nil then
      raise EScriptException.CreateFmt(sComponentNotFound, [AName])
  finally
    Lookup.Free;
  end;
end;

function TModulesObj.GetListCount: Integer;
begin
  if WebContext <> nil then
    Result := WebContext.WebModules.ItemCount
  else
    Result := 0;
end;

function TModulesObj.GetListItem(I: Integer): Variant;
begin
  Result := DispatchOfObject(WebContext.WebModules.Items[I]);
end;

{ TResponseObj }

function TResponseObj.GetAllow: string;
begin
  Result := WebContext.Response.Allow
end;

function TResponseObj.GetContentEncoding: string;
begin
  Result := WebContext.Response.ContentEncoding;
end;

function TResponseObj.GetContentLength: Integer;
begin
  Result := WebContext.Response.ContentLength;
end;

function TResponseObj.GetContentType: string;
begin
  Result := WebContext.Response.ContentType;
end;

function TResponseObj.GetContentVersion: string;
begin
  Result := WebContext.Response.ContentVersion;
end;

function TResponseObj.GetLocation: string;
begin
  Result := WebContext.Response.Location;
end;

function TResponseObj.GetRealm: string;
begin
  Result := WebContext.Response.Realm
end;

function TResponseObj.GetReasonString: string;
begin
  Result := WebContext.Response.ReasonString
end;

function TResponseObj.GetServer: string;
begin
  Result := WebContext.Response.Server
end;

function TResponseObj.GetStatusCode: Integer;
begin
  Result := WebContext.Response.StatusCode
end;

function TResponseObj.GetTitle: string;
begin
  Result := WebContext.Response.Title
end;

function TResponseObj.GetVersion: string;
begin
  Result := WebContext.Response.Version
end;

function TResponseObj.GetWWWAuthenticate: string;
begin
  Result := WebContext.Response.WWWAuthenticate
end;

procedure TResponseObj.SetAllow(const Value: string);
begin
  WebContext.Response.Allow := Value;
end;

procedure TResponseObj.SetContentEncoding(const Value: string);
begin
  WebContext.Response.ContentEncoding := Value;
end;

procedure TResponseObj.SetContentLength(const Value: Integer);
begin
  WebContext.Response.ContentLength := Value;
end;

procedure TResponseObj.SetContentType(const Value: string);
begin
  WebContext.Response.ContentType := Value;
end;

procedure TResponseObj.SetContentVersion(const Value: string);
begin
  WebContext.Response.ContentVersion := Value;
end;

procedure TResponseObj.SetLocation(const Value: string);
begin
  WebContext.Response.Location := Value;
end;

procedure TResponseObj.SetRealm(const Value: string);
begin
  WebContext.Response.Realm := Value;
end;

procedure TResponseObj.SetReasonString(const Value: string);
begin
  WebContext.Response.ReasonString := Value;
end;

procedure TResponseObj.SetServer(const Value: string);
begin
  WebContext.Response.Server := Value;
end;

procedure TResponseObj.SetStatusCode(const Value: Integer);
begin
  WebContext.Response.StatusCode := Value;
end;

procedure TResponseObj.SetTitle(const Value: string);
begin
  WebContext.Response.Title := Value;
end;

procedure TResponseObj.SetVersion(const Value: string);
begin
  WebContext.Response.Version := Value;
end;

procedure TResponseObj.SetWWWAuthenticate(const Value: string);
begin
  WebContext.Response.WWWAuthenticate := Value;
end;

{ TProducerObj }

constructor TProducerObj.Create(AProducer: IScriptProducer);
begin
  inherited Create;
  FScriptProducer := AProducer;
end;

function TProducerObj.GetContent: WideString;
begin
  Result := FScriptProducer.Content;
end;

procedure TProducerObj.SetContent(const Value: WideString);
begin
  FScriptProducer.Content := Value
end;

procedure TProducerObj.Write(Value: Variant);
begin
  if not VarIsEmpty(Value) then
    FScriptProducer.Write(Value);
end;

{ THTMLItemsObj }

function THTMLItemsObj.GetCount: Integer;
begin
  Result := FScriptProducer.HTMLBlockCount;
end;

function THTMLItemsObj.GetItem(Index: Integer): string;
begin
  Result := FScriptProducer.HTMLBlocks[Index];
end;

function THTMLItemsObj.Item(Index: Integer): string;
begin
  Result := GetItem(Index);
end;

procedure THTMLItemsObj.WriteItem(Index: Integer);
begin
  FScriptProducer.WriteItem(Index);
end;

{ TStringsObj }

constructor TStringsObj.Create(AStrings: TStrings);
begin
  inherited Create;
  FStrings := AStrings;
end;

function TStringsObj.GetCommaText: string;
begin
  Result := FStrings.CommaText;
end;

function TStringsObj.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

function TStringsObj.GetText: string;
begin
  Result := FStrings.Text;
end;

function TStringsObj.Names(Index: Integer): string;
begin
  Result := FStrings.Names[Index];
end;

procedure TStringsObj.SetCommaText(const Value: string);
begin
  FStrings.CommaText := Value;
end;

procedure TStringsObj.SetText(const Value: string);
begin
  FStrings.Text := Value;
end;

procedure TStringsObj.SetValues(const Name: string; const Value: string);
begin
  FStrings.Values[Name] := Value;
end;

function TStringsObj.Values(const Name: string): string;
begin
  Result := FStrings.Values[Name];
end;

{ TComponentsEnumerator }

function TComponentsEnumerator.atEnd: Bool;
begin
  // Don't call inherited
  Result := FAtEof;
end;

function TComponentsEnumerator.ClassName: string;
begin
  Result := inherited ClassName;
end;

constructor TComponentsEnumerator.Create(AObject: TObject);
begin
  inherited Create(AObject);
  if ObjectAccess <> nil then
  begin
    // See which interface we support
    if Supports(ObjectAccess, IIterateIntfSupport, FIntfIterator) then
      FIterator := FIntfIterator
    else if Supports(ObjectAccess, IIterateObjectSupport, FObjectIterator) then
      FIterator := FObjectIterator
    else
      Supports(ObjectAccess, IIteratorSupport, FIterator)
  end;
  FAtEof := True;
end;

procedure TComponentsEnumerator.EndIterating;
begin
  if FIterator <> nil then
  begin
    FIterating := False;
    FIterator.EndIterator(FOwnerData);
  end;
end;

function TComponentsEnumerator.GetClassName: string;
begin
  Result := FObject.ClassName;
end;

function TComponentsEnumerator.GetListCount: Integer;
begin
  raise EScriptException.Create(sCountFromComponentsNotSupported);
end;

function TComponentsEnumerator.GetListItem(I: Integer): Variant;
var
  Current: TObject;
begin
  Result := Unassigned;
  if FObjectIterator <> nil then
  begin
    Current := FObjectIterator.GetCurrentObject(FOwnerData);
    if Current <> nil then
      Result := DispatchOfObject(Current)
  end;
end;

function TComponentsEnumerator.GetName: string;
var
  Intf: IWebVariableName;
begin
  if Supports(ObjectAccess, IWebVariableName, Intf) then
    Result := Intf.VariableName
  else
    Result := TComponent(ObjectAccess).Name;
end;

function TComponentsEnumerator.moveNext: Boolean;
begin
  if FIterator <> nil then
  begin
    if Reset then
    begin
      try
        if FIterating then
          FIterator.EndIterator(FOwnerData);
      finally
        FIterating := False;
      end;
      Reset := False;
      FOwnerData := nil;
      FIterating := True;
      Result := FIterator.StartIterator(FOwnerData);
    end
    else
      Result := FIterator.NextIteration(FOwnerData);
  end
  else
    Result := False;
  FAtEof := not Result;
end;

{ TScriptableObject }

constructor TScriptableObject.Create;
begin
  inherited Create(Self, False);
  FLookupList := TStringList.Create;
  FLookupValues := TInterfaceList.Create;
end;

destructor TScriptableObject.Destroy;
begin
  FLookupList.Free;
  FLookupValues.Free;
  inherited;
end;

function TScriptableObject.DispatchOfName(const AName: string): IDispatch;
var
  Obj: TObject;
begin
  Obj := FindObject(AName);
  if Obj <> nil then
    Result := DispatchOfObject(Obj)
  else
    Result := nil;
end;

const
  cDispatchOffset = 1000;

class function TScriptableObject.DispatchOfObject(
  const AObject: TObject): IDispatch;
var
  ObjClass: IWebSnapObjClass;
  ScriptObj: TObjectScripter;
begin
  if Supports(AObject, IWebSnapObjClass, ObjClass) then
  begin
    ScriptObj := ObjClass.WebSnapObjClass.Create(AObject);
    if ScriptObj is TEnumeratorObj then
      Result := CreateEnumeratedObject(TEnumeratorObj(ScriptObj)) as IDispatch 
    else
      Result := ScriptObj;
  end
  else
    Result := TObjectDispatch.Create(AObject, False);
end;

function TScriptableObject.FindObject(const AName: string): TObject;
begin
  // noop;
  Result := nil;
end;

function TScriptableObject.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT;
type
  PNames = ^TNames;
  TNames = array[0..100] of PWideChar;
const
  cKeywords: array[0..1] of ShortString = ('Published', 'Array'); // Do not localize
  cExtraKeywords: array[0..1] of ShortString = ('Name', 'Count'); // Do not localize
var
  I: Integer;
  Name: ShortString;
  NewNames: Pointer;
  NewName: WideString;

  Disp: IDispatch;
  IdLocation: Integer;

  function FindChildDispatch: Boolean;
  begin
    // See if we have a child component
    if NameCount = 1 then
    begin
      IdLocation := FLookupList.IndexOf(Name);
      if IdLocation < 0 then
      begin
        Disp := DispatchOfName(Name);
        if Disp <> nil then
        begin
          IdLocation := FLookupList.Add(Name);
          FLookupValues.Add(Disp);
        end
      end;

      if IdLocation >= 0 then
      begin
        PDispIDList(DispIDs)[0] := cDispatchOffset + IdLocation;
        Result := True;
      end;
    end
    else
      Result := False;
  end;

  function IsNewKeyword: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := Low(cExtraKeywords) to High(cExtraKeywords) do
      if SameText(cExtraKeywords[I], Name) then
        Exit;
    Result := False;
  end;

begin
  WideCharToShortString(PNames(Names)^[0], Name);
  // Fix up requests for names that end in _
  for I := Low(cKeywords) to High(cKeywords) do
  begin
    if Name = cKeyWords[I] then
    begin
      // Fixup the call
      GetMem(NewNames, Sizeof(NewNames));                                              
      NewName := WideString(cKeywords[I]) + '_';
      PNames(NewNames)^[0] := PWideChar(NewName);
      try
        Result := inherited GetIDsOfNames(IID, NewNames, 1, LocaleID, DispIDs);
      finally
        FreeMem(NewNames);
      end;
      Exit;
    end;
  end;
  // Allow certain scripting objects to prefer children components over RTTI
  // for extra keywords that were not in D6. This preserves backwards
  // compatability.
  if FPreferChild and IsNewKeyword then
  begin
    if FindChildDispatch then
      Result := S_OK
    else
      Result := inherited GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs);
  end
  else
  begin
    Result := inherited GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs);
    if Result = DISP_E_UNKNOWNNAME then
      if FindChildDispatch then
        Result := S_OK;
  end;
end;

function TScriptableObject.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HRESULT;
var
  InternalId: Integer;
  Disp: IDispatch;
begin
  if DispId >= cDispatchOffset then
  begin
    // We are handling the invoke in this case
    InternalId := DispId - cDispatchOffset;
    if (InternalId >= 0) and (InternalId < FLookupValues.Count) then
    begin
      Disp := FLookupValues[InternalId] as IDispatch;
      VarClear((POleVariant(VarResult))^);
      POleVariant(VarResult)^ := Disp;
      Result := S_OK;
    end
    else
      Result := DISP_E_MEMBERNOTFOUND;
  end
  else
  begin
    Result := inherited Invoke(DispId, IID, LocaleId, Flags, Params, VarResult,
      ExcepInfo, ArgErr);
  end;
end;

{ TObjectScripter }

constructor TObjectScripter.Create(AObject: TObject);
begin
  inherited Create;
  FObject := AObject;
  Supports(AObject, IInterface, FObjectIntf);
end;

destructor TObjectScripter.Destroy;
begin
  FObjectIntf := nil;
  inherited Destroy;
end;

function TObjectScripter.FindObject(const AName: String): TObject;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  if Supports(ObjectAccess, IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
  else
    Result := nil;
end;

{ TBaseAdapterObj }

function TBaseAdapterObj.GetFields: Variant;
var
  GetIntf: IGetAdapterFields;
begin
  if Supports(ObjectAccess, IGetAdapterFields, GetIntf) then
    Result := CreateEnumeratedObject(TComponentsEnumerator.Create(GetIntf.GetAdapterFields)) as IDispatch
  else
    Result := Unassigned;
end;

function TBaseAdapterObj.GetActions: Variant;
var
  GetIntf: IGetAdapterActions;
begin
  if Supports(ObjectAccess, IGetAdapterActions, GetIntf) then
    Result := CreateEnumeratedObject(TComponentsEnumerator.Create(GetIntf.GetAdapterActions)) as IDispatch
  else
    Result := Unassigned;
end;

function TBaseAdapterObj.GetRecords: Variant;
begin
  if Supports(ObjectAccess, IIteratorSupport) then
    Result := CreateEnumeratedObject(TComponentsEnumerator.Create(ObjectAccess)) as IDispatch
  else
    Result := Unassigned;
end;

constructor TBaseAdapterObj.Create(AObject: TObject);
begin
  inherited;
  FPreferChild := True;
end;

{ TCustomEnumDispatcher }

constructor TCustomEnumDispatcher.Create(ScriptObj: TEnumeratorObj);
begin
  inherited Create;
  FScriptObjRef := ScriptObj;
  FScriptObj := ScriptObj;
end;

destructor TCustomEnumDispatcher.Destroy;
begin
  FScriptObjRef := nil;
  inherited;
end;

function TCustomEnumDispatcher.GetIDsOfNames(const IID: TGUID;
  Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT;
begin
  Result := FScriptObj.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs)
end;

function TCustomEnumDispatcher.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HRESULT;
begin
  Result := FScriptObj.GetTypeInfo(Index, LocaleID, TypeInfo)
end;

function TCustomEnumDispatcher.GetTypeInfoCount(
  out Count: Integer): HRESULT;
begin
  Result := FScriptObj.GetTypeInfoCount(Count);
end;

function TCustomEnumDispatcher.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HRESULT;
begin
  Result := FScriptObj.Invoke(DispID, IID, LocaleID, Flags, Params, VarResult,
    ExcepInfo, ArgErr);
end;

{ TAdapterObj }

function TAdapterObj.GetCanModify: Boolean;
var
  Intf: IAdapterAccess;
begin
  if Supports(ObjectAccess, IAdapterAccess, Intf) then
    Result := Intf.HasModifyAccess
  else
    Result := True;
end;

function TAdapterObj.GetCanView: Boolean;
var
  Intf: IAdapterAccess;
begin
  if Supports(ObjectAccess, IAdapterAccess, Intf) then
    Result := Intf.HasViewAccess
  else
    Result := True;
end;

function TAdapterObj.GetErrors: Variant;
var
  Intf: IGetAdapterErrors;
begin
  if Supports(ObjectAccess, IGetAdapterErrors, Intf) then
    Result := CreateEnumeratedObject(TErrorsObj.Create(Intf.GetAdapterErrors))
  else
    Result := Unassigned;
end;

function TAdapterObj.GetHiddenFields: Variant;
var
  Intf: IGetAdapterHiddenFields;
  O: TObject;
begin
  if Supports(ObjectAccess, IGetAdapterHiddenFields, Intf) then
  begin
    O := Intf.GetAdapterHiddenFields;
    if O <> nil then
      Result := CreateEnumeratedObject(THiddenFieldsEnum.Create(O))
    else
      Result := Unassigned;
  end
  else
    Result := Unassigned;
end;

function TAdapterObj.GetHiddenRecordFields: Variant;
var
  Intf: IGetAdapterHiddenFields;
  O: TObject;
begin
  if Supports(ObjectAccess, IGetAdapterHiddenFields, Intf) then
  begin
    O := Intf.GetAdapterHiddenRecordFields;
    if O <> nil then
      Result := CreateEnumeratedObject(THiddenFieldsEnum.Create(O))
    else
      Result := Unassigned;
  end
  else
    Result := Unassigned;
end;

function TAdapterObj.GetMode: string;
var
  Intf: IAdapterMode;
begin
  if Supports(ObjectAccess, IAdapterMode, Intf) then
    Result := Intf.GetAdapterMode
  else
    Result := '';
end;

procedure TAdapterObj.SetMode(const Value: string);
var
  Intf: IAdapterMode;
begin
  if Supports(ObjectAccess, IAdapterMode, Intf) then
    Intf.SetAdapterMode(Value);
end;

{ THiddenFieldsEnum }

procedure THiddenFieldsEnum.WriteFields(Response: Variant);
var
  AdapterHiddenFields: IAdapterHiddenFields;
  I: Integer;
  Field: IAdapterHiddenField;
  S: string;
begin
  if Supports(ObjectAccess, IAdapterHiddenFields, AdapterHiddenFields) then
  begin
    S := '';
    for I := 0 to AdapterHiddenFields.FieldCount - 1 do
    begin
      Field := AdapterHiddenFields.Fields[I];
      S := Format('%s<input type="hidden" name="%s" value="%s">%s',
        [S, Field.Name, Field.Value, sLineBreak]);
    end;
    Response.Write(S);
  end;
end;

{ TAdapterFieldObj }

function TAdapterFieldObj.AsEditText(const Value: Variant): string;
begin
  if (not VarIsEmpty(Value)) and (not VarIsNull(Value)) then
    Result := Value
  else
    Result := '';
end;

function TAdapterFieldObj.GetCanModify: Boolean;
var
  Intf: IAdapterFieldAccess;
begin
  if Supports(ObjectAccess, IAdapterFieldAccess, Intf) then
    Result := Intf.HasModifyAccess
  else
    Result := True

end;

function TAdapterFieldObj.GetCanView: Boolean;
var
  Intf: IAdapterFieldAccess;
begin
  if Supports(ObjectAccess, IAdapterFieldAccess, Intf) then
    Result := Intf.HasViewAccess
  else
    Result := True
end;

function TAdapterFieldObj.GetDisplayLabel: string;
var
  GetDisplayLabel: IWebGetDisplayLabel;
begin
  if Supports(ObjectAccess, IWebGetDisplayLabel, GetDisplayLabel) then
    Result := GetDisplayLabel.GetDisplayLabel
  else
    Result := '';

end;

function TAdapterFieldObj.GetDisplayStyle: string;
var
  Intf: IGetHTMLStyle;
begin
  if Supports(ObjectAccess, IGetHTMLStyle, Intf) then
    Result := Intf.GetDisplayStyle('')
  else
    Result := '';
end;

function TAdapterFieldObj.GetDisplayText: string;
var
  AsFormatted: IAsFormatted;
begin
  if Supports(ObjectAccess, IAsFormatted, AsFormatted) then
    Result := AsFormatted.AsFormatted
  else
    Result := GetEditText;
end;

function TAdapterFieldObj.GetDisplayWidth: Integer;
var
  GetDisplayWidth: IWebGetDisplayWidth;
begin
  if Supports(ObjectAccess, IWebGetDisplayWidth, GetDisplayWidth) then
    Result := GetDisplayWidth.GetDisplayWidth
  else
    Result := -1;
end;

function TAdapterFieldObj.GetEditText: string;
begin
  Result := AsEditText(GetValue);
end;

function TAdapterFieldObj.GetImage: Variant;
var
  GetIntf: IGetAdapterImage;
  AdapterImage: TComponent;
begin
  Result := Unassigned;
  if Supports(ObjectAccess, IGetAdapterImage, GetIntf) then
  begin
    AdapterImage := GetIntf.GetAdapterImage;
    if AdapterImage <> nil then
      Result := TImageObj.Create(AdapterImage) as IDispatch;
  end;
end;

function TAdapterFieldObj.GetInputName: string;
var
  Intf: IWebVariableName;
  InputName: IWebInputName;
begin
  if Supports(ObjectAccess, IWebInputName, InputName) then
    Result := InputName.InputName
  else if Supports(ObjectAccess, IWebVariableName, Intf) then
    Result := Intf.VariableName
  else
    Result := '';

end;

function TAdapterFieldObj.GetInputStyle: string;
var
  Intf: IGetHTMLStyle;
begin
  if Supports(ObjectAccess, IGetHTMLStyle, Intf) then
    Result := Intf.GetInputStyle('')
  else
    Result := '';

end;

function TAdapterFieldObj.GetMaxLength: Integer;
var
  GetMax: IWebGetMaxLength;
begin
  if Supports(ObjectAccess, IWebGetMaxLength, GetMax) then
    Result := GetMax.GetMaxLength
  else
    Result := -1;

end;

function TAdapterFieldObj.GetRequired: Boolean;
var
  Intf: IAdapterFieldAttributes;
begin
  if Supports(ObjectAccess, IAdapterFieldAttributes, Intf) then
    Result := Intf.GetRequired
  else
    Result := False
end;

function TAdapterFieldObj.GetValue: Variant;
var
  Intf: IWebGetFieldValue;
begin
  if Supports(ObjectAccess, IWebGetFieldValue, Intf) then
    Result := Intf.GetValue
  else
    Result := Unassigned;
end;

function TAdapterFieldObj.GetValues: Variant;
var
  GetIntf: IGetFieldValuesAdapter;
  AdapterFieldValues: TComponent;
begin
  Result := Unassigned;
  if Supports(ObjectAccess, IGetFieldValuesAdapter, GetIntf) then
  begin
    AdapterFieldValues := GetIntf.GetFieldValuesAdapter;
    if AdapterFieldValues <> nil then
      Result := CreateEnumeratedObject(TAdapterFieldValuesObj.Create(AdapterFieldValues));
  end;
end;


function TAdapterFieldObj.GetValuesList: Variant;
var
  GetIntf: IGetAdapterValuesList;
  AdapterValuesList: IValuesListAdapter;
  Intf: IInterfaceComponentReference;
begin
  Result := Unassigned;
  if Supports(ObjectAccess, IGetAdapterValuesList, GetIntf) then
  begin
    AdapterValuesList := GetIntf.GetAdapterValuesList;
    if AdapterValuesList <> nil then
    begin
      if Supports(AdapterValuesList, IInterfaceComponentReference, Intf) and
        (Intf.GetComponent <> nil) then
        Result := DispatchOfObject(Intf.GetComponent)
      else
        raise EScriptException.Create(sInterfaceCompRefExpected);
    end;
  end;
end;

function TAdapterFieldObj.GetViewMode: string;
var
  Intf: IGetHTMLStyle;
begin
  if Supports(ObjectAccess, IGetHTMLStyle, Intf) then
    Result := Intf.GetViewMode('')
  else
    Result := '';
end;

function TAdapterFieldObj.GetVisible: Boolean;
var
  AdapterFieldAttributes: IAdapterFieldAttributes;
begin
  if Supports(ObjectAccess, IAdapterFieldAttributes, AdapterFieldAttributes) then
    Result := AdapterFieldAttributes.GetVisible
  else
    Result := True;
end;

function TAdapterFieldObj.IsEqual(Value: Variant): Boolean;
var
  Intf: IWebValueIsEqual;
  V: Variant;
begin
  if Supports(ObjectAccess, IWebValueIsEqual, Intf) then
    Result := Intf.IsEqual(Value)
  else
  begin
    V := GetValue;
    try
      Result := (VarIsEmpty(Value) = VarIsEmpty(V)) and (Value = V);
    except
      Result := False
    end
  end;
end;

{ TImageObj }

function TImageObj.AsHREF: WideString;
var
  Dispatcher: IAdapterDispatcher;
  WebImageHREF: IWebImageHREF;
  S: string;
  CompRef: IInterfaceComponentReference;
  Unk: IUnknown;
begin
  if Supports(ObjectAccess, IWebImageHREF, WebImageHREF) then
    if WebImageHREF.WebImageHREF(S) then
    begin
      Result := S;
      Exit;
    end;

  if Supports(ObjectAccess, IInterfaceComponentReference, CompRef) then
    Dispatcher := FindAdapterDispatcher(CompRef.GetComponent)
  else
    Dispatcher := nil; 
    
  if Dispatcher <> nil then
  begin
    if Supports(ObjectAccess, IUnknown, Unk) then
      Result := Dispatcher.EncodeAdapterItemRequestAsHREF(Unk, [])
  end
  else
    Result := sUnknown
end;

function TImageProducerObj.GetDisplayStyle(const Component: TComponent): string;
var
  ImageProducer: IActionImageProducer;
  ObjRef: IInterfaceComponentReference;
begin
  Result := '';
  if Supports(ObjectAccess, IActionImageProducer, ImageProducer) then
    if Supports(Component, IInterfaceComponentReference, ObjRef) then
      Result := ImageProducer.GetDisplayStyle(ObjRef.GetComponent)
    else
      Assert(False, 'Expecting IInterfaceComponentReference support');
end;

function TImageProducerObj.GetEventImage(const ComponentName, Event,
  Caption: string): Variant;
var
  ImageProducer: IActionImageProducer;
  ActualObject: TObject;
begin
  Result := Unassigned;
  if Supports(ObjectAccess, IActionImageProducer, ImageProducer) then
  begin
    ActualObject := ImageProducer.GetAdapterEventImage(ComponentName,
      Event, Caption);
    Result := TImageObj.Create(ActualObject) as IDispatch;
  end;
end;

function TImageProducerObj.GetImage(const ComponentName,
  Caption: string): Variant;
var
  ImageProducer: IImageProducer;
  ActualObject: TObject;
begin
  if Supports(ObjectAccess, IImageProducer, ImageProducer) then
  begin
     ActualObject := ImageProducer.GetAdapterImage(ComponentName, Caption);
     Result := TImageObj.Create(ActualObject) as IDispatch;
  end;
end;

{ TAdapterFieldValuesObj }

function TAdapterFieldValuesObj.GetValue: Variant;
var
  FieldIntf: IWebGetFieldValues;
  AdapterIntf: IFieldValuesAdapter;
begin
  if Supports(ObjectAccess, IFieldValuesAdapter, AdapterIntf) and
    Supports(AdapterIntf.GetField, IWebGetFieldValues, FieldIntf) then
    Result := FieldIntf.GetCurrentValue
  else
    Result := Unassigned;
end;

function TAdapterFieldValuesObj.HasValue(Value: Variant): Boolean;
var
  FieldIntf: IWebGetFieldValues;
  AdapterIntf: IFieldValuesAdapter;
begin
  if Supports(ObjectAccess, IFieldValuesAdapter, AdapterIntf) and
    Supports(AdapterIntf.GetField, IWebGetFieldValues, FieldIntf) then
    Result := FieldIntf.HasValue(Value)
  else
    Result := False;
end;

{ TErrorsObj }

constructor TErrorsObj.Create(AObject: TObject);
begin
  inherited Create(AObject);
  if FIntfIterator = nil then
    raise EScriptException.Create(sErrorsObjectNeedsIntf);
end;

function TErrorsObj.GetListCount: Integer;
var
  Errors: IAdapterErrors;
begin
  if FIntfIterator <> nil then
  begin
   if Supports(FIntfIterator, IAdapterErrors, Errors) then
    begin
      Errors := FIntfIterator.GetCurrentIntf(FOwnerData) as IAdapterErrors;
      Result := Errors.ErrorCount;
    end
    else
      Result := 0;
  end
  else
    Result := 0;
end;

function TErrorsObj.GetListItem(I: Integer): Variant;
var
  Error: IAdapterError;
begin
  if FIntfIterator <> nil then
  begin
    if Supports(FIntfIterator.GetCurrentIntf(FOwnerData), IAdapterError, Error) then
      Result := TErrorObj.Create(Error) as IDispatch
    else
      Result := Unassigned;
  end
  else
    Result := Unassigned;
end;

{ TErrorObj }

constructor TErrorObj.Create(Error: IAdapterError);
begin
  inherited Create;
  FError := Error;
end;

function TErrorObj.GetField: Variant;
begin
  Result := CreateEnumeratedObject(TComponentsEnumerator.Create(FError.Field));
end;

function TErrorObj.GetID: Integer;
begin
  Result := FError.ID;
end;

function TErrorObj.GetMessage: string;
begin
  Result := FError.ErrorText;
end;

{ TModuleObj }

constructor TModuleObj.Create(AObject: TObject);
begin
  inherited;
end;

destructor TModuleObj.Destroy;
begin
  inherited;
end;

function TModuleObj.GetObjects: Variant;
begin
  Result := CreateEnumeratedObject(Self);
end;

{ TAdapterValuesListObj }

function TAdapterValuesListObj.GetImage: Variant;
var
  Intf: IValuesListAdapter;
  AdapterImage: TComponent;
begin
  if Supports(ObjectAccess, IValuesListAdapter, Intf) then
  begin
    AdapterImage := Intf.GetListImage;
    if AdapterImage <> nil then
      Result := TImageObj.Create(AdapterImage) as IDispatch
    else
      Result := Unassigned;
  end
  else
    Result := Unassigned;
end;

function TAdapterValuesListObj.GetValue: Variant;
var
  Intf: IValuesListAdapter;
begin
  if Supports(ObjectAccess, IValuesListAdapter, Intf) then
    Result := Intf.GetListValue
  else
    Result := Unassigned;
end;

function TAdapterValuesListObj.GetValueName: string;
var
  Intf: IValuesListAdapter;
begin
  if Supports(ObjectAccess, IValuesListAdapter, Intf) then
    Result := Intf.GetListName
  else
    Result := '';
end;

function TAdapterValuesListObj.ImageOfValue(Value: Variant): Variant;
var
  Intf: IValuesListAdapter;
  AdapterImage: TComponent;
begin
  if Supports(ObjectAccess, IValuesListAdapter, Intf) then
  begin
    AdapterImage := Intf.GetListImageOfValue(Value);
    if AdapterImage <> nil then
      Result := TImageObj.Create(AdapterImage) as IDispatch
    else
      Result := Unassigned;
  end
  else
    Result := Unassigned;
end;

function TAdapterValuesListObj.NameOfValue(Value: Variant): string;
var
  Intf: IValuesListAdapter;
begin
  if Supports(ObjectAccess, IValuesListAdapter, Intf) then
    Result := Intf.GetListNameOfValue(Value)
  else
    Result := '';
end;

end.
