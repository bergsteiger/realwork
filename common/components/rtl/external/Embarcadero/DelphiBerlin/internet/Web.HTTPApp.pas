{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ *************************************************************************** }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit Web.HTTPApp;

{ $WARN SYMBOL_DEPRECATED OFF}

interface

uses
  System.SysUtils, System.Classes, System.Masks,
  System.Generics.Collections,
  Web.WebFileDispatcher;

const
  sDateFormat = '"%s", dd "%s" yyyy hh":"nn":"ss';

  MAX_STRINGS = 12;
  MAX_INTEGERS = 1;
  MAX_DATETIMES = 3;

type
  TWebExceptionEvent = procedure (Sender: TObject; E: Exception; var Handled: Boolean) of object;
  TMethodType = (mtAny, mtGet, mtPut, mtPost, mtHead, mtDelete, mtPatch);

{ Forward declaration }

  TWebResponse = class;

{ TWebRequest }

  TExtractCharSet = set of UTF8Char;

  TAbstractContentParser = class;
  TAbstractWebRequestFiles = class;
  TWebRequest = class(TObject)
  private
    FContentParser: TAbstractContentParser;
    FMethodType: TMethodType;
    FCookieFields: TStrings;
    FQueryFields: TStrings;
    function GetContentParser: TAbstractContentParser;
    function GetContentFields: TStrings;
    function GetCookieFields: TStrings;
    function GetQueryFields: TStrings;
    function GetFiles: TAbstractWebRequestFiles;
    function GetContent: string;
  protected
    function GetRemoteIP: string; virtual;
    /// <summary>Reads the request content as Array of Bytes.</summary>
    function GetRawContent: TBytes; virtual; abstract;
    function GetStringVariable(Index: Integer): string; virtual; abstract;
    function GetDateVariable(Index: Integer): TDateTime; virtual; abstract;
    function GetIntegerVariable(Index: Integer): Integer; virtual; abstract;
    function GetInternalPathInfo: string; virtual;
    function GetRawPathInfo: string; virtual;
    function GetInternalScriptName: string; virtual;
    procedure UpdateMethodType;
    /// <summary>Reads the total content returned by the server.</summary>
    procedure DoReadTotalContent; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    // Read count bytes from client
    function ReadClient(var Buffer: TBytes; Offset: Integer; Count: Integer): Integer; overload; virtual; abstract;
    function ReadClient(var Buffer; Count: Integer): Integer; overload; virtual; abstract;
    // Read count characters as a string from client
    function ReadString(Count: Integer): string; virtual; abstract;
    // Note:  This function seems problematic.  It is unsafe to start reading a string, that may
    // contain multibyte characters, using an arbitrary offset and arbitrary count.  The offset
    // and count must be on a character boundary.
    function ReadUnicodeString(Count: Integer): string;
    // Translate a relative URI to a local absolute path
    function TranslateURI(const URI: string): string; virtual; abstract;
    // Write count bytes back to client
    function WriteClient(var Buffer; Count: Integer): Integer; virtual; abstract;
    // Write string contents back to client
    function WriteString(const AString: string): Boolean; virtual; abstract;
    // Write HTTP header string
    function WriteHeaders(StatusCode: Integer; const ReasonString, Headers: string): Boolean; virtual; abstract;
    // Utility to extract fields from a given string buffer
    procedure ExtractFields(Separators, _WhiteSpace: TExtractCharSet;
      const Content: string; Strings: TStrings); overload;
    // Fills the given string list with the content fields as the result
    // of a POST method
    procedure ExtractContentFields(Strings: TStrings);
    // Fills the given string list with values from the cookie header field
    procedure ExtractCookieFields(Strings: TStrings);
    // Fills the given TStrings with the values from the Query data
    // (ie: data following the "?" in the URL)
    procedure ExtractQueryFields(Strings: TStrings);
    // Read an arbitrary HTTP/Server Field not lists here
    function GetFieldByName(const Name: string): string; virtual; abstract;
    /// <summary>Reads the total content returned by the server.</summary>
    procedure ReadTotalContent;
    // The request method as an enumeration
    property MethodType: TMethodType read FMethodType;
    // Content parser
    property ContentParser: TAbstractContentParser read GetContentParser;
    // Field lists
    property ContentFields: TStrings read GetContentFields;
    property CookieFields: TStrings read GetCookieFields;
    property QueryFields: TStrings read GetQueryFields;
    // HTTP header Fields
    property Method: string index 0 read GetStringVariable;
    property ProtocolVersion: string index 1 read GetStringVariable;
    property URL: string index 2 read GetStringVariable;
    property Query: string index 3 read GetStringVariable;
    property PathInfo: string index 4 read GetStringVariable;
    property PathTranslated: string index 5 read GetStringVariable;
    property Authorization: string index 28 read GetStringVariable;
    property CacheControl: string index 6 read GetStringVariable;
    property Cookie: string index 27 read GetStringVariable;
    property Date: TDateTime index 7 read GetDateVariable;
    property Accept: string index 8 read GetStringVariable;
    property From: string index 9 read GetStringVariable;
    property Host: string index 10 read GetStringVariable;
    property IfModifiedSince: TDateTime index 11 read GetDateVariable;
    property Referer: string index 12 read GetStringVariable;
    property UserAgent: string index 13 read GetStringVariable;
    property ContentEncoding: string index 14 read GetStringVariable;
    property ContentType: string index 15 read GetStringVariable;
    property ContentLength: Integer index 16 read GetIntegerVariable;
    property ContentVersion: string index 17 read GetStringVariable;
    property RawContent: TBytes read GetRawContent;
    property Content: string read GetContent;
    property Connection: string index 26 read GetStringVariable;
    property DerivedFrom: string index 18 read GetStringVariable;
    property Expires: TDateTime index 19 read GetDateVariable;
    property Title: string index 20 read GetStringVariable;
    property RemoteAddr: string index 21 read GetStringVariable;
    property RemoteHost: string index 22 read GetStringVariable;
    property ScriptName: string index 23 read GetStringVariable;
    property ServerPort: Integer index 24 read GetIntegerVariable;
    // Perform special processing to get normalized PathInfo when using WebAppDbg
    property InternalPathInfo: string read GetInternalPathInfo;
    // PathInfo that has not been decoded.
    property RawPathInfo: string read GetRawPathInfo;
    // Perform special processing to get normalized ScriptName when using WebAppDbg
    property InternalScriptName: string read GetInternalScriptName;
    property Files: TAbstractWebRequestFiles read GetFiles;
    property RemoteIP: string read GetRemoteIP;
  end;

  TAbstractContentParser = class(TObject)
  private
    FWebRequest: TWebRequest;
  protected
    property WebRequest: TWebRequest read FWebRequest;
    function GetContentFields: TStrings; virtual; abstract;
    function GetFiles: TAbstractWebRequestFiles; virtual; abstract;
  public
    constructor Create(AWebRequest: TWebRequest); virtual;
    class function CanParse(AWebRequest: TWebRequest): Boolean; virtual;
  end;

  TContentParser = class(TAbstractContentParser)
  private
    FContentFields: TStrings;
    FFiles: TAbstractWebRequestFiles;
  public
    destructor Destroy; override;
    function GetContentFields: TStrings; override;
    function GetFiles: TAbstractWebRequestFiles; override;
    class function CanParse(AWebRequest: TWebRequest): Boolean; override;
  end;

  TContentParserClass = class of TAbstractContentParser;

  TAbstractWebRequestFile = class;
  TAbstractWebRequestFiles = class(TObject)
  protected
    function GetCount: Integer; virtual; abstract;
    function GetItem(I: Integer): TAbstractWebRequestFile; virtual; abstract;
  public
    property Items[I: Integer]: TAbstractWebRequestFile read GetItem; default;
    property Count: Integer read GetCount;
  end;

  TAbstractWebRequestFile = class(TObject)
  protected
    function GetFieldName: string; virtual; abstract;
    function GetFileName: string; virtual; abstract;
    function GetStream: TStream; virtual; abstract;
    function GetContentType: string; virtual; abstract;
  public
    property FieldName: string read GetFieldName;
    property FileName: string read GetFileName;
    property Stream: TStream read GetStream;
    property ContentType: string read GetContentType;
  end;


{ TCookie }

  TCookie = class(TCollectionItem)
  private
    FName: string;
    FValue: string;
    FPath: string;
    FDomain: string;
    FExpires: TDateTime;
    FSecure: Boolean;
  protected
    function GetHeaderValue: string;
  public
    constructor Create(Collection: TCollection); override;
    procedure AssignTo(Dest: TPersistent); override;
    property Name: string read FName write FName;
    property Value: string read FValue write FValue;
    property Domain: string read FDomain write FDomain;
    property Path: string read FPath write FPath;
    property Expires: TDateTime read FExpires write FExpires;
    property Secure: Boolean read FSecure write FSecure;
    property HeaderValue: string read GetHeaderValue;
  end;

{ TCookieCollection }

  TCookieCollection = class(TCollection)
  private
    FWebResponse: TWebResponse;
  protected
    function GetCookie(Index: Integer): TCookie;
    procedure SetCookie(Index: Integer; Cookie: TCookie);
  public
    constructor Create(WebResponse: TWebResponse; ItemClass: TCollectionItemClass);
    function  Add: TCookie;
    property WebResponse: TWebResponse read FWebResponse;
    property Items[Index: Integer]: TCookie read GetCookie write SetCookie; default;
  end;

{ TWebResponse }

  TWebResponse = class(TObject)
  private
    FFreeContentStream: Boolean;
    FContentStream: TStream;
    FCookies: TCookieCollection;
    procedure SetCustomHeaders(Value: TStrings);
  protected
    FHTTPRequest: TWebRequest;
    FCustomHeaders: TStrings;      
    procedure AddCustomHeaders(var Headers: string);
    function GetStringVariable(Index: Integer): string; virtual; abstract;
    procedure SetStringVariable(Index: Integer; const Value: string); virtual; abstract;
    function GetDateVariable(Index: Integer): TDateTime; virtual; abstract;
    procedure SetDateVariable(Index: Integer; const Value: TDateTime); virtual; abstract;
    function GetIntegerVariable(Index: Integer): Integer; virtual; abstract;
    procedure SetIntegerVariable(Index: Integer; Value: Integer); virtual; abstract;
    function GetContent: string; virtual; abstract;
    procedure SetContent(const Value: string); virtual; abstract;
    procedure SetContentStream(Value: TStream); virtual;
    function GetStatusCode: Integer; virtual; abstract;
    procedure SetStatusCode(Value: Integer); virtual; abstract;
    function GetLogMessage: string; virtual; abstract;
    procedure SetLogMessage(const Value: string); virtual; abstract;
    function FormatAuthenticate: string;
  public
    constructor Create(HTTPRequest: TWebRequest);
    destructor Destroy; override;
    function GetCustomHeader(const Name: string): String;
    procedure SendResponse; virtual; abstract;
    procedure SendRedirect(const URI: string); virtual; abstract;
    procedure SendStream(AStream: TStream); virtual; abstract;
    function Sent: Boolean; virtual;
    procedure SetCookieField(Values: TStrings; const ADomain, APath: string;
      AExpires: TDateTime; ASecure: Boolean);
    procedure SetCustomHeader(const Name, Value: string);
    property Cookies: TCookieCollection read FCookies;
    property HTTPRequest: TWebRequest read FHTTPRequest;
    property Version: string index 0 read GetStringVariable write SetStringVariable;
    property ReasonString: string index 1 read GetStringVariable write SetStringVariable;
    property Server: string index 2 read GetStringVariable write SetStringVariable;
    property WWWAuthenticate: string index 3 read GetStringVariable write SetStringVariable;
    property Realm: string index 4 read GetStringVariable write SetStringVariable;
    property Allow: string index 5 read GetStringVariable write SetStringVariable;
    property Location: string index 6 read GetStringVariable write SetStringVariable;
    property ContentEncoding: string index 7 read GetStringVariable write SetStringVariable;
    property ContentType: string index 8 read GetStringVariable write SetStringVariable;
    property ContentVersion: string index 9 read GetStringVariable write SetStringVariable;
    property DerivedFrom: string index 10 read GetStringVariable write SetStringVariable;
    property Title: string index 11 read GetStringVariable write SetStringVariable;

    property StatusCode: Integer read GetStatusCode write SetStatusCode;
    property ContentLength: Integer index 0 read GetIntegerVariable write SetIntegerVariable;

    property Date: TDateTime index 0 read GetDateVariable write SetDateVariable;
    property Expires: TDateTime index 1 read GetDateVariable write SetDateVariable;
    property LastModified: TDateTime index 2 read GetDateVariable write SetDateVariable;

    property Content: string read GetContent write SetContent;
    property ContentStream: TStream read FContentStream write SetContentStream;

    property LogMessage: string read GetLogMessage write SetLogMessage;

    property CustomHeaders: TStrings read FCustomHeaders write SetCustomHeaders;

    property FreeContentStream: Boolean read FFreeContentStream write FFreeContentStream;
  end;

  TCustomWebDispatcher = class;
  TCustomContentProducer = class;

  ISetAppDispatcher = interface
  ['{2F5E959E-DA65-11D3-A411-00C04F6BB853}']
    procedure SetAppDispatcher(const ADispatcher: TComponent);
  end;

  IProduceContent = interface
  ['{AAFA17B7-E814-11D4-A54A-00C04F6BB853}']
    function ProduceContent: string;
  end;

  IProduceContentFrom = interface
  ['{AA0CC875-E81B-11D4-A54A-00C04F6BB853}']
    function ProduceContentFromStream(Stream: TStream): string;
    function ProduceContentFromString(const S: string): string;
  end;

  IWebAppServices180 = interface
  ['{D62F1586-E307-11D3-A418-00C04F6BB853}']
    procedure InitContext(WebModule: TComponent; Request: TWebRequest;
  Response: TWebResponse);
    function HandleRequest: Boolean;
    procedure FinishContext;
    function GetExceptionHandler: TObject;
    property ExceptionHandler: TObject read GetExceptionHandler;
  end;

  IWebAppServices = interface(IWebAppServices180)
  ['{8B627D59-897B-452C-9633-05CC3A634196}']
    function GetActive: Boolean;
    property Active: Boolean read GetActive;
  end;

  IWebExceptionHandler = interface
  ['{7664268F-9629-11D4-A4EC-00C04F6BB853}']
    procedure HandleException(E: Exception; var Handled: Boolean);
  end;

  IGetWebAppServices = interface
  ['{5CF7B3BD-DAB0-D511-99A8-0050568E0E44}']
    function GetWebAppServices: IWebAppServices;
  end; // deprecated 'websnap';

  IWebRequestHandler = interface
  ['{6FCCB05F-8FE0-11D4-A4E5-00C04F6BB853}']
    function HandleRequest(Request: TWebRequest; Response: TWebResponse): Boolean;
  end;

  // Indicates dispatch actions container
  IWebDispatchActions = interface
  ['{E4444CD8-9FAE-D511-8D38-0050568E0E44}']
  end;

  IGetWebRequestHandler = interface
  ['{6FCCB060-8FE0-11D4-A4E5-00C04F6BB853}']
    function GetWebRequestHandler: IWebRequestHandler;
  end;

  IWebDispatcherAccess = interface
  ['{144CD1DF-9FAE-D511-8D38-0050568E0E44}']
    function Request: TWebRequest;
    function Response: TWebResponse;
  end;

{ TCustomContentProducer }

  TCustomContentProducer = class(TComponent, ISetAppDispatcher, IProduceContent, IProduceContentFrom)
  private
    FDispatcher: TComponent;
    function GetDispatcher: IWebDispatcherAccess;
    procedure SetDispatcher(Value: TComponent);
  protected
    { IProduceContent }
    function ProduceContent: string;
    { IProduceContentFrom }
    function ProduceContentFromStream(Stream: TStream): string;
    function ProduceContentFromString(const S: string): string;
    { ISetAppDispatcher }
    procedure SetAppDispatcher(const ADispatcher: TComponent);
    { IGetAppDispatcher }
    function GetAppDispatcher: TComponent;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function Content: string; virtual;
    function ContentFromStream(Stream: TStream): string; virtual;
    function ContentFromString(const S: string): string; virtual;
    property Dispatcher: IWebDispatcherAccess read GetDispatcher;
    property DispatcherComponent: TComponent read FDispatcher;
  end;

{ TWebActionItem }

  THTTPMethodEvent = procedure (Sender: TObject; Request: TWebRequest;
    Response: TWebResponse; var Handled: Boolean) of object;

  TWebActionItem = class(TCollectionItem)
  private
    FOnAction: THTTPMethodEvent;
    FPathInfo: string;
    FMethodType: TMethodType;
    FDefault: Boolean;
    FEnabled: Boolean;
    FMaskPathInfo: string;
    FMask: TMask;
    FName: string;
    FProducer: TCustomContentProducer;
    FProducerContent: TComponent;
    function DispatchAction(Request: TWebRequest; Response: TWebResponse;
      DoDefault: Boolean): Boolean;
    procedure SetDefault(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetMethodType(Value: TMethodType);
    procedure SetOnAction(Value: THTTPMethodEvent);
    procedure SetPathInfo(const Value: string);
    procedure SetProducer(const Value: TCustomContentProducer);
    function GetMask: TMask;
    function ProducerPathInfo: string;
    procedure SetProducerContent(const Value: TComponent);
  protected
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
    function GetPathInfo: string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure AssignTo(Dest: TPersistent); override;
  published
    property Default: Boolean read FDefault write SetDefault default False;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property MethodType: TMethodType read FMethodType write SetMethodType default mtAny;
    property Name: string read GetDisplayName write SetDisplayName;
    property PathInfo: string read GetPathInfo write SetPathInfo;
    property Producer: TCustomContentProducer read FProducer write SetProducer;
    property ProducerContent: TComponent read FProducerContent write SetProducerContent;
    property OnAction: THTTPMethodEvent read FOnAction write SetOnAction;
  end;

{ TWebActionItems }

  TWebActionItems = class(TCollection)
  public type
    TEnumerator = class(TCollectionEnumerator)
    public
      function GetCurrent: TWebActionItem; inline;
      property Current: TWebActionItem read GetCurrent;
    end;
  private
    FWebDispatcher: TCustomWebDispatcher;
    function GetActionItem(Index: Integer): TWebActionItem;
    procedure SetActionItem(Index: Integer; Value: TWebActionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    function GetOwner: TPersistent; override;
    procedure SetItemName(Item: TCollectionItem); override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(WebDispatcher: TCustomWebDispatcher;
      ItemClass: TCollectionItemClass);
    function GetEnumerator: TEnumerator;
    function  Add: TWebActionItem;
    property WebDispatcher: TCustomWebDispatcher read FWebDispatcher;
    property Items[Index: Integer]: TWebActionItem read GetActionItem
      write SetActionItem; default;
  end;

{ IWebDispatch }

  IWebDispatch = interface
  ['{E6D33BE4-9FAE-D511-8D38-0050568E0E44}']
    function DispatchEnabled: Boolean;
    function DispatchMethodType: TMethodType;
    function DispatchRequest(Sender: TObject; Request: TWebRequest; Response: TWebResponse): Boolean;
    function DispatchMask: TMask;
    property Enabled: Boolean read DispatchEnabled;
    property MethodType: TMethodType read DispatchMethodType;
    property Mask: TMask read DispatchMask;
  end;

{ TCustomWebDispatcher }

  TCustomWebDispatcher = class(TDataModule, IWebRequestHandler, IWebDispatchActions, IWebDispatcherAccess, IWebExceptionHandler)
  private
    FRequest: TWebRequest;
    FResponse: TWebResponse;
    FActions: TWebActionItems;
    FBeforeDispatch: THTTPMethodEvent;
    FAfterDispatch: THTTPMethodEvent;
    FDispatchList: TObjectList<TComponent>;//TComponentList;
    FOnException: TWebExceptionEvent;

    function GetAction(Index: Integer): TWebActionItem;
    procedure SetActions(Value: TWebActionItems);
    function GetRequest: TWebRequest;
    function GetResponse: TWebResponse;
  protected
    { IWebRequestHandler }
    function HandleRequest(Request: TWebRequest; Response: TWebResponse): Boolean;
    { IWebDispatcherAccess }
    function Access_Request: TWebRequest;
    function Access_Response: TWebResponse;
    function IWebDispatcherAccess.Request = Access_Request;
    function IWebDispatcherAccess.Response = Access_Response;
    { IWebExceptionHandler }
    procedure HandleException(E: Exception; var Handled: Boolean);

    function DoAfterDispatch(Request: TWebRequest; Response: TWebResponse): Boolean;
    function DoBeforeDispatch(Request: TWebRequest; Response: TWebResponse): Boolean;
    function DispatchAction(Request: TWebRequest;
      Response: TWebResponse): Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property BeforeDispatch: THTTPMethodEvent read FBeforeDispatch write FBeforeDispatch;
    property AfterDispatch: THTTPMethodEvent read FAfterDispatch write FAfterDispatch;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ActionByName(const AName: string): TWebActionItem;
    property Actions: TWebActionItems read FActions write SetActions;
    property Action[Index: Integer]: TWebActionItem read GetAction;
    property Request: TWebRequest read GetRequest;
    property Response: TWebResponse read GetResponse;
    property OnException: TWebExceptionEvent read FOnException write FOnException;
  end;

{ TWebDispatcher }

  TWebDispatcher = class(TCustomWebDispatcher)
  published
    property Actions;
    property BeforeDispatch;
    property AfterDispatch;
    property OnException;
  end;

  TDispatchFileEvent = procedure (Sender: TObject; const AFileName: string; Request: TWebRequest;
    Response: TWebResponse; var Handled: Boolean) of object;

  { Webbroker component that dispatches file requests }

  TCustomWebFileDispatcher = class(TComponent, IWebDispatch)
  private
    FFileDispatcherProperties: TWebFileDispatcherProperties;
    FMask: TMask;
    FBeforeDispatch: TDispatchFileEvent;
    FAfterDispatch: TDispatchFileEvent;
    procedure SetWebFileExtensions(const Value: TWebFileExtensions);
    function GetWebFileExtensions: TWebFileExtensions;
    procedure SetWebDirectories(const Value: TWebDirectories);
    function GetWebDirectories: TWebDirectories;
    function GetRootDirectory: string;
    procedure SetRootDirectory(const Value: string);
  protected
    { IWebDispatch }
    function DispatchEnabled: Boolean;
    function DispatchMask: TMask;
    function DispatchMethodType: TMethodType;
    function DispatchRequest(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse): Boolean;
    property BeforeDispatch: TDispatchFileEvent read FBeforeDispatch write FBeforeDispatch;
    property AfterDispatch: TDispatchFileEvent read FAfterDispatch write FAfterDispatch;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property WebFileExtensions: TWebFileExtensions read GetWebFileExtensions write SetWebFileExtensions;
    property WebDirectories: TWebDirectories read GetWebDirectories write SetWebDirectories;
    property RootDirectory: string read GetRootDirectory write SetRootDirectory;
  end;

  TWebFileDispatcher = class(TCustomWebFileDispatcher)
  published
    property WebFileExtensions;
    property BeforeDispatch;
    property AfterDispatch;
    property WebDirectories;
    property RootDirectory;
  end;


{ TWebModule }

  TWebModule = class(TCustomWebDispatcher)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Actions;
    property BeforeDispatch;
    property AfterDispatch;
    property OnException;
  end;

  TDefaultWebAppServices = class(TInterfacedObject, IWebAppServices)
  private
    FRequestHandler: IWebRequestHandler;
    FRequest: TWebRequest;
    FWebModule: TComponent;
    FResponse: TWebResponse;
    function FindWebDispatcher: TComponent;
  protected

    { IWebAppServices }
    procedure InitContext(WebModule: TComponent; Request: TWebRequest;
      Response: TWebResponse);
    procedure FinishContext;
    function HandleRequest: Boolean;
    function GetExceptionHandler: TObject;
    function GetActive: Boolean;

    function InvokeDispatcher: Boolean;
    function FindRequestHandler: IWebRequestHandler; virtual;
    function GetRequestHandler: IWebRequestHandler;
    property Request: TWebRequest read FRequest;
    property Response: TWebResponse read FResponse;
    /// <summary>Get the module responsible for dispatching web requests</summary>
    property WebModule: TComponent read FWebModule;
    property RequestHandler: IWebRequestHandler read GetRequestHandler;
  end;

  EWebBrokerException = class(Exception)
  end;

function DosPathToUnixPath(const Path: string): string;
function HTTPDecode(const AStr: string): string; inline; deprecated 'Use TNetEncoding.URL.Decode';
function HTTPEncode(const AStr: string): string; inline; deprecated 'Use TNetEncoding.URL.Encode';
function HTMLEncode(const AStr: string): string; inline; deprecated 'Use TNetEncoding.HTML.Encode';
function HTMLDecode(const AStr: string): string; inline; deprecated 'Use TNetEncoding.HTML.Decode';
function ParseDate(const DateStr: string): TDateTime;

procedure ExtractHTTPFields(Separators, _WhiteSpace: TExtractCharSet; Content: PChar;
  Strings: TStrings; StripQuotes: Boolean = False); overload;
procedure ExtractHTTPFields(Separators, _WhiteSpace: TExtractCharSet; const Content: string;
  Strings: TStrings; StripQuotes: Boolean = False); overload;
procedure ExtractHeaderFields(Separators, _WhiteSpace: TExtractCharSet; Content: PChar;
  Strings: TStrings; Decode: Boolean; StripQuotes: Boolean = False); overload;
procedure ExtractHeaderFields(Separators, _WhiteSpace: TExtractCharSet; const Content: string;
  Strings: TStrings; Decode: Boolean; StripQuotes: Boolean = False); overload;
function StatusString(StatusCode: Integer): string;
function UnixPathToDosPath(const Path: string): string;
function MonthStr(DateTime: TDateTime): string;
function DayOfWeekStr(DateTime: TDateTime): string;
function EncodingFromContentType(const AContentType: string): TEncoding;
function EncodingGetString(const AContentType: string; const AValue: TBytes): string;
function EncodingGetBytes(const AContentType: string; const AValue: string): TBytes;
procedure RegisterContentParser(AClass: TContentParserClass);
function WebApplicationDirectory: string;
function WebApplicationFileName: string;
function DefaultCharSetEncoding: TEncoding;
function DefaultCharSet: string;

var
  /// <summary>Method pointer to a function that can retrieve the name of the module file (e.g.; the name of the ISAPI dll)</summary>
  GetModuleFileNameProc: function: string = nil;
  /// <summary>Method pointer to a function that can return the default charset encoding</summary>
  GetDefaultCharSetEncoding: TEncoding = nil;
  FWebApplicationFileName: string;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
{$IFDEF POSIX}
  Posix.String_,
{$ENDIF}
  Web.WebConst, Web.BrkrConst, System.TypInfo,
  System.Character, System.StrUtils, System.NetEncoding;

var
  FWebApplicationDirectory: string;

function WebApplicationDirectory: string;
begin
  if FWebApplicationDirectory = '' then
    FWebApplicationDirectory := ExtractFilePath(WebApplicationFileName);
  Result := FWebApplicationDirectory;
end;

function WebApplicationFileName: string;
begin
  if FWebApplicationFileName = '' then
  begin
    // Default is the name of the .EXE.
    FWebApplicationFileName := GetModuleName(MainInstance);
    // UNC issue in Vista.
    if Pos('\\?\', FWebApplicationDirectory) = 1 then
      Delete(FWebApplicationFileName, 1, 4);
  end;
  Result := FWebApplicationFileName;
end;

function DefaultCharSetEncoding: TEncoding;
begin
  Result := nil;
  if Assigned(GetDefaultCharSetEncoding) then
    Result := GetDefaultCharSetEncoding;
  if Result = nil then
    Result := TEncoding.UTF8;
end;

function DefaultCharSet: string;
var
  LEncoding: TEncoding;
begin
  LEncoding := DefaultCharSetEncoding;
  if LEncoding = TEncoding.UTF8 then
    Result := 'UTF-8'  // Do not localize
  else if LEncoding = TEncoding.ANSI then
    Result := 'ANSI'  // Do not localize
  else if LEncoding = TEncoding.ASCII then
    Result := 'ASCII'  // Do not localize
end;

var
  FContentParsers: TList<TContentParserClass>;

function ContentParsers: TList<TContentParserClass>;
begin
  if FContentParsers = nil then
    FContentParsers := TList<TContentParserClass>.Create;//TClassList.Create;
  Result := FContentParsers;
end;

procedure RegisterContentParser(AClass: TContentParserClass);
begin
  ContentParsers.Add(AClass);
end;

{ TWebRequest }

constructor TWebRequest.Create;
begin
  inherited Create;
  UpdateMethodType;
end;

procedure TWebRequest.UpdateMethodType;
begin
  if Method = 'GET' then  { do not localize }
    FMethodType := mtGet
  else if Method = 'PUT' then   { do not localize }
    FMethodType := mtPut
  else if Method = 'POST' then  { do not localize }
    FMethodType := mtPost
  else if Method = 'HEAD' then  { do not localize }
    FMethodType := mtHead
  else if Method = 'DELETE' then  { do not localize }
    FMethodType := mtDelete
  else if Method = 'PATCH' then  { do not localize }
    FMethodType := mtPatch;
end;

destructor TWebRequest.Destroy;
begin
  FCookieFields.Free;
  FQueryFields.Free;
  FContentParser.Free;
  inherited Destroy;
end;

procedure TWebRequest.ExtractFields(Separators, _WhiteSpace: TExtractCharSet;
  const Content: string; Strings: TStrings);
begin
  ExtractHTTPFields(Separators, _WhiteSpace, Content, Strings);
end;

procedure TWebRequest.ExtractContentFields(Strings: TStrings);
begin
  if ContentLength > 0 then
  begin
    ReadTotalContent;
    ExtractFields(['&'], [], Content, Strings);
  end;
end;


procedure TWebRequest.ExtractCookieFields(Strings: TStrings);
begin
  ExtractHeaderFields([';', ','], [' '], Cookie, Strings, True);
end;

procedure TWebRequest.ExtractQueryFields(Strings: TStrings);
begin
  ExtractFields(['&'], [], Query, Strings);
end;

function TWebRequest.GetContent: string;
begin
  Result := EncodingGetString(ContentType, RawContent);
end;

function TWebRequest.GetContentFields: TStrings;
begin
  Result := ContentParser.GetContentFields;
end;
 
function TWebRequest.GetCookieFields: TStrings;
begin
  if FCookieFields = nil then
  begin
    FCookieFields := TStringList.Create;
    ExtractCookieFields(FCookieFields);
  end;
  Result := FCookieFields;
end;

function TWebRequest.GetQueryFields: TStrings;
begin
  if FQueryFields = nil then
  begin
    FQueryFields := TStringList.Create;
    ExtractQueryFields(FQueryFields);
  end;
  Result := FQueryFields;
end;

procedure TWebRequest.ReadTotalContent;
begin
  DoReadTotalContent;
end;

procedure TWebRequest.DoReadTotalContent;
begin
  // If this method is not implemented, the total content must be automatically read into RawContent.
  Assert(Length(RawContent) = ContentLength);
end;


function TWebRequest.ReadUnicodeString(Count: Integer): string;                           
begin
  Result := ReadString(Count); // ReadString returns unicode now
end;

function TWebRequest.GetInternalPathInfo: string;
begin
  Result := PathInfo;
end;

function TWebRequest.GetRawPathInfo: string;
begin
  Result := PathInfo;
end;

function TWebRequest.GetRemoteIP: string;
begin
  Result := EmptyStr;
end;

function TWebRequest.GetInternalScriptName: string;
begin
  Result := ScriptName;
end;

function TWebRequest.GetFiles: TAbstractWebRequestFiles;
begin
  Result := ContentParser.GetFiles;
end;

function TWebRequest.GetContentParser: TAbstractContentParser;
var
  I: Integer;
  C: TContentParserClass;
begin
  if FContentParser = nil then
  begin
    for I := ContentParsers.Count - 1 downto 0 do
    begin
      C := TContentParserClass(ContentParsers[I]);
      if C.CanParse(Self) then
      begin
        FContentParser := C.Create(Self);
        Break;
      end;
    end;
  end;
  if FContentParser = nil then
    FContentParser := TContentParser.Create(Self);
  Result := FContentParser;
end;

{ TCookie }

constructor TCookie.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FExpires := -1;
end;

procedure TCookie.AssignTo(Dest: TPersistent);
begin
  if Dest is TCookie then
    with TCookie(Dest) do
    begin
      Name := Self.FName;
      Value := Self.FValue;
      Domain := Self.FDomain;
      Path := Self.FPath;
      Expires := Self.FExpires;
      Secure := Self.FSecure;
    end else inherited AssignTo(Dest);
end;

function TCookie.GetHeaderValue: string;
var
  S: string;
begin
  S := Format('%s=%s; ', [TNetEncoding.URL.Encode(FName), TNetEncoding.URL.Encode(FValue)]);
  if Domain <> '' then
    S := S + Format('domain=%s; ', [Domain]);  { do not localize }
  if Path <> '' then
    S := S + Format('path=%s; ', [Path]);      { do not localize }
  if Expires > -1 then
    S := S +
      Format(FormatDateTime('"expires="' + sDateFormat + ' "GMT; "', Expires),  { do not localize }
        [DayOfWeekStr(Expires), MonthStr(Expires)]);
  if Secure then S := S + 'secure';  { do not localize }
  if Copy(S, Length(S) - 1, MaxInt) = '; ' then
    SetLength(S, Length(S) - 2);
  Result := S;
end;

{ TCookieCollection }

constructor TCookieCollection.Create(WebResponse: TWebResponse; ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FWebResponse := WebResponse;
end;

function TCookieCollection.Add: TCookie;
begin
  Result := TCookie(inherited Add);
end;

function TCookieCollection.GetCookie(Index: Integer): TCookie;
begin
  Result := TCookie(inherited Items[Index]);
end;

procedure TCookieCollection.SetCookie(Index: Integer; Cookie: TCookie);
begin
  Items[Index].Assign(Cookie);
end;

{ TWebResponse }

constructor TWebResponse.Create(HTTPRequest: TWebRequest);
begin
  inherited Create;
  FHTTPRequest := HTTPRequest;
  FCustomHeaders := TStringList.Create;
  FCookies := TCookieCollection.Create(Self, TCookie);
  FFreeContentStream := True;
end;

destructor TWebResponse.Destroy;
begin
  if FreeContentStream then
    FContentStream.Free
  else
    FContentStream := nil;
  FCustomHeaders.Free;
  FCookies.Free;
  inherited Destroy;
end;

procedure TWebResponse.AddCustomHeaders(var Headers: string);
var
  I: Integer;
  Name, Value: string;
begin
  for I := 0 to FCustomHeaders.Count - 1 do
  begin
    Name := FCustomHeaders.Names[I];
    Value := FCustomHeaders.values[Name];
    Headers := Headers + Name + ': ' + Value + #13#10;
  end;
end;

function TWebResponse.GetCustomHeader(const Name: string): string;
begin
  Result := FCustomHeaders.Values[Name];
end;

function TWebResponse.Sent: Boolean;
begin
  Result := False;
end;

procedure TWebResponse.SetContentStream(Value: TStream);
begin
  if Value <> FContentStream then
  begin
    if FreeContentStream then
      FContentStream.Free;
    FContentStream := Value;
    if FContentStream <> nil then
      ContentLength := FContentStream.Size
    else ContentLength := Length(Content);
  end;
end;

procedure TWebResponse.SetCookieField(Values: TStrings; const ADomain,
  APath: string; AExpires: TDateTime; ASecure: Boolean);
var
  I: Integer;
begin
  for I := 0 to Values.Count - 1 do
    with Cookies.Add do
    begin
      Name := Values.Names[I];
      Value := Values.Values[Values.Names[I]];
      Domain := ADomain;
      Path := APath;
      Expires := AExpires;
      Secure := ASecure;
    end;
end;

procedure TWebResponse.SetCustomHeader(const Name, Value: string);
begin
  FCustomHeaders.Values[Name] := Value;
end;

procedure TWebResponse.SetCustomHeaders(Value: TStrings);
begin
  FCustomHeaders.Assign(Value);
end;

function TWebResponse.FormatAuthenticate: string;
begin
  if Realm <> '' then
    Result := Format('%s Realm=%s', [WWWAuthenticate, Realm])
  else
    Result := WWWAuthenticate;
end;

{ TCustomContentProducer }

procedure TCustomContentProducer.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDispatcher) then
    FDispatcher := nil;
end;

procedure TCustomContentProducer.SetDispatcher(Value: TComponent);
begin
  if FDispatcher <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FDispatcher := Value;
  end;
end;

function TCustomContentProducer.Content: string;
begin
  Result := '';
end;

function TCustomContentProducer.ContentFromStream(Stream: TStream): string;
begin
  Result := Content;
end;

function TCustomContentProducer.ContentFromString(const S: string): string;
begin
  Result := Content;
end;

procedure TCustomContentProducer.SetAppDispatcher(
  const ADispatcher: TComponent);
begin
  SetDispatcher(ADispatcher);
end;

function TCustomContentProducer.GetDispatcher: IWebDispatcherAccess;
begin
  if Assigned(FDispatcher) then
    Supports(IInterface(FDispatcher), IWebDispatcherAccess, Result)
  else
    Result := nil;
end;

function TCustomContentProducer.ProduceContent: string;
begin
  Result := Content;
end;

function TCustomContentProducer.ProduceContentFromStream(
  Stream: TStream): string;
begin
  Result := ContentFromStream(Stream);
end;

function TCustomContentProducer.ProduceContentFromString(
  const S: string): string;
begin
  Result := ContentFromString(S);
end;

function TCustomContentProducer.GetAppDispatcher: TComponent;
begin
  Result := FDispatcher;
end;

{ TWebActionItem }

constructor TWebActionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FEnabled := True;
end;

destructor TWebActionItem.Destroy;
begin
  FMask.Free;
  inherited Destroy;
end;

procedure TWebActionItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TWebActionItem then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      with TWebActionItem(Dest) do
      begin
        Default := Self.Default;
        PathInfo := Self.PathInfo;
        Enabled := Self.Enabled;
        MethodType := Self.MethodType;
      end;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end else inherited AssignTo(Dest);
end;

function TWebActionItem.DispatchAction(Request: TWebRequest; Response: TWebResponse;
  DoDefault: Boolean): Boolean;
var
  Intf: IProduceContent;
  LInternalPathInfo: string;
begin
  Result := False;
  LInternalPathInfo := string(Request.InternalPathInfo);
  if LInternalPathInfo = '/' then
    LInternalPathInfo := ''; // Treat '/' and '' as equivalent
  if (FDefault and DoDefault) or (FEnabled and ((FMethodType = mtAny) or
    (FMethodType = Request.MethodType)) and
    GetMask.Matches(LInternalPathInfo)) then
  begin
    if Assigned(FProducer) then
    begin
      Result := True;
      Response.Content := FProducer.Content;
    end
    else if Assigned(FProducerContent) then
    begin
      Result := Supports(IUnknown(FProducerContent), IProduceContent, Intf);
      if Result then
        Response.Content := Intf.ProduceContent;
    end;
    if Assigned(FOnAction) then
    begin
      Result := True;
      FOnAction(Self, Request, Response, Result);
    end
  end;
end;

function TWebActionItem.GetDisplayName: string;
begin
  Result := FName;
end;

procedure TWebActionItem.SetDefault(Value: Boolean);
var
  I: Integer;
  Action: TWebActionItem;
begin
  if Value <> FDefault then
  begin
    if Value and (Collection <> nil) then
      for I := 0 to Collection.Count - 1 do
      begin
        Action := TWebActionItems(Collection).Items[I];
        if (Action <> Self) and (Action is TWebActionItem) then
          Action.Default := False;
      end;
    FDefault := Value;
    Changed(False);
  end;
end;

procedure TWebActionItem.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    Changed(False);
  end;
end;

procedure TWebActionItem.SetMethodType(Value: TMethodType);
begin
  if Value <> FMethodType then
  begin
    FMethodType := Value;
    Changed(False);
  end;
end;

procedure TWebActionItem.SetDisplayName(const Value: string);
var
  I: Integer;
  Action: TWebActionItem;
begin
  if CompareText(Value, FName) <> 0 then
  begin
    if Collection <> nil then
      for I := 0 to Collection.Count - 1 do
      begin
        Action := TWebActionItems(Collection).Items[I];
        if (Action <> Self) and (Action is TWebActionItem) and
          (CompareText(Value, Action.Name) = 0) then
          raise EWebBrokerException.Create(sDuplicateActionName);
      end;
    FName := Value;
    Changed(False);
  end;
end;

procedure TWebActionItem.SetOnAction(Value: THTTPMethodEvent);
begin
  FOnAction := Value;
  Changed(False);
end;

procedure TWebActionItem.SetPathInfo(const Value: string);
var
  NewValue: string;
begin
  if Value <> '' then NewValue := DosPathToUnixPath(Value);
  if (NewValue <> '') and (NewValue[Low(string)] <> '/') then Insert('/', NewValue, 1);
  if Assigned(FProducer) and (NewValue = ProducerPathInfo) then
    NewValue := '';
  if CompareText(FPathInfo, NewValue) <> 0 then
  begin
    FPathInfo := NewValue;
    Changed(False);
  end;
end;

procedure TWebActionItem.SetProducer(const Value: TCustomContentProducer);
begin
  if Assigned(Value) then
  begin
    Value.FreeNotification(TWebActionItems(Collection).WebDispatcher);
    FProducerContent := nil;
  end;
  FProducer := Value;
end;

function TWebActionItem.ProducerPathInfo: string;
begin
  Assert(Assigned(FProducer));
  Result := '/' + FProducer.Name
end;

function TWebActionItem.GetPathInfo: string;
begin
  if (FPathInfo = '') and Assigned(FProducer) then
    Result := ProducerPathInfo
  else
    Result := FPathInfo;
end;

function TWebActionItem.GetMask: TMask;
var
  Mask: TMask;
  MaskPathInfo: string;
begin
  MaskPathInfo := GetPathInfo;
  if MaskPathInfo = '/' then
    MaskPathInfo := ''; // Treat '/' and '' as equivalent
  if (not Assigned(FMask)) or
    (CompareText(FMaskPathInfo, MaskPathInfo) <> 0) then
  begin
    Mask := TMask.Create(MaskPathInfo);
    try
      FMaskPathInfo := MaskPathInfo;
      if Assigned(FMask) then
      begin
        FMask.Free;
        FMask := nil;
      end;
    except
      Mask.Free;
      raise;
    end;
    FMask := Mask;
  end;
  Result := FMask;
end;

procedure TWebActionItem.SetProducerContent(const Value: TComponent);
begin
  if Assigned(Value) then
  begin
    Value.FreeNotification(TWebActionItems(Collection).WebDispatcher);
    FProducer := nil;
  end;
  FProducerContent := Value;
end;

{ TWebActionItems }

constructor TWebActionItems.Create(WebDispatcher: TCustomWebDispatcher;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FWebDispatcher := WebDispatcher;
end;

function TWebActionItems.Add: TWebActionItem;
begin
  Result := TWebActionItem(inherited Add);
end;

function TWebActionItems.GetActionItem(Index: Integer): TWebActionItem;
begin
  Result := TWebActionItem(inherited Items[Index]);
end;

function TWebActionItems.GetAttrCount: Integer;
begin
  Result := 6;
end;

function TWebActionItems.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

function TWebActionItems.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sHTTPItemName;
    1: Result := sHTTPItemURI;
    2: Result := sHTTPItemEnabled;
    3: Result := sHTTPItemDefault;
    4: Result := sHTTPItemMethod;
    5: Result := sHTTPItemProducer;
  else
    Result := '';
  end;
end;

function TWebActionItems.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Items[ItemIndex].Name;
    1: Result := Items[ItemIndex].PathInfo;
    2: if Items[ItemIndex].Enabled then
         Result := 'True' else Result := 'False'; // do not localize
    3: if Items[ItemIndex].Default then
         Result := '*' else Result := '';  //do not localize
    4: Result := System.TypInfo.GetEnumName(TypeInfo(TMethodType), Integer(Items[ItemIndex].MethodType));
    5: if Items[ItemIndex].Producer <> nil then
         Result := Items[ItemIndex].Producer.Name
       else if Items[ItemIndex].ProducerContent <> nil then
         Result := Items[ItemIndex].ProducerContent.Name
       else
         Result := ''  //do not localize
  else
    Result := '';
  end;
end;

function TWebActionItems.GetOwner: TPersistent;
begin
  Result := FWebDispatcher;
end;

procedure TWebActionItems.SetActionItem(Index: Integer; Value: TWebActionItem);
begin
  Items[Index].Assign(Value);
end;

procedure TWebActionItems.SetItemName(Item: TCollectionItem);
var
  I, J: Integer;
  ItemName: string;
  CurItem: TWebActionItem;
begin
  J := 1;
  while True do
  begin
    ItemName := Format('WebActionItem%d', [J]);  { do not localize }
    I := 0;
    while I < Count do
    begin
      CurItem := Items[I] as TWebActionItem;
      if (CurItem <> Item) and (CompareText(CurItem.Name, ItemName) = 0) then
      begin
        Inc(J);
        Break;
      end;
      Inc(I);
    end;
    if I >= Count then
    begin
      (Item as TWebActionItem).Name := ItemName;
      Break;
    end;
  end;
end;

procedure TWebActionItems.Update(Item: TCollectionItem);
begin
{+ !!  if (FWebDispatcher <> nil) and
    not (csLoading in FWebDispatcher.ComponentState) then }
end;

{ TWebActionItems.TEnumerator }

function TWebActionItems.TEnumerator.GetCurrent: TWebActionItem;
begin
  Result := TWebActionItem(inherited GetCurrent);
end;

{ TCustomWebDispatcher }

constructor TCustomWebDispatcher.Create(AOwner: TComponent);
var
  I: Integer;
  Component: TComponent;
  SetAppDispatcher: ISetAppDispatcher;
begin
{$IFDEF MSWINDOWS}
  RPR;
{$ENDIF}
  FDispatchList := TObjectList<TComponent>.Create;//TComponentList.Create;
  FDispatchList.OwnsObjects := False;
  FOnException := nil;
  if AOwner <> nil then
    if AOwner is TCustomWebDispatcher then
      raise EWebBrokerException.Create(sOnlyOneDispatcher)
    else
      for I := 0 to AOwner.ComponentCount - 1 do
        if AOwner.Components[I] is TCustomWebDispatcher then
          raise EWebBrokerException.Create(sOnlyOneDispatcher);
  inherited CreateNew(AOwner, -1);
  FActions := TWebActionItems.Create(Self, TWebActionItem);
  if Owner <> nil then
    for I := 0 to Owner.ComponentCount - 1 do
    begin
      Component := Owner.Components[I];
      if Supports(IInterface(Component), ISetAppDispatcher, SetAppDispatcher) then
        SetAppDispatcher.SetAppDispatcher(Self)
      else if Supports(IInterface(Component), IWebDispatch) then
        FDispatchList.Add(Component);
    end;
end;

destructor TCustomWebDispatcher.Destroy;
begin
  inherited Destroy;
  FActions.Free;
  FDispatchList.Free;
end;

procedure TCustomWebDispatcher.HandleException(E: Exception; var Handled: Boolean);
begin
  Handled := False;
  if Assigned(FOnException) then
  begin
    Handled := True;
    if Response <> nil then
      Response.StatusCode := 500; { Allow the user to override the StatusCode }
    FOnException(Self, E, Handled);
    if Handled and (Response <> nil) then
      Response.SendResponse;
  end;
  if not Handled then
    if Response <> nil then
    begin
      Response.Content := Format(sInternalApplicationError, [E.Message, Request.PathInfo]);
      if not Response.Sent then
      begin
        Response.StatusCode := 500;
        Response.SendResponse;
      end;
      Handled := True;
    end;
end;

function TCustomWebDispatcher.ActionByName(const AName: string): TWebActionItem;
var
  I: Integer;
begin
  for I := 0 to FActions.Count - 1 do
  begin
    Result := FActions[I];
    if CompareText(AName, Result.Name) = 0 then Exit;
  end;
  Result := nil;
end;

function TCustomWebDispatcher.DoAfterDispatch(Request: TWebRequest; Response: TWebResponse): Boolean;
begin
  Result := True;
  if Assigned(FAfterDispatch) then
    FAfterDispatch(Self, Request, Response, Result);
end;

function TCustomWebDispatcher.DoBeforeDispatch(Request: TWebRequest; Response: TWebResponse): Boolean;
begin
  Result := False;
  if Assigned(FBeforeDispatch) then
    FBeforeDispatch(Self, Request, Response, Result);
end;

function DispatchHandler(Sender: TObject; Dispatch: IWebDispatch; Request: TWebRequest; Response: TWebResponse;
  DoDefault: Boolean): Boolean;
begin
  Result := False;
  if (Dispatch.Enabled and ((Dispatch.MethodType = mtAny) or
    (Request.MethodType = Dispatch.MethodType)) and
    Dispatch.Mask.Matches(string(Request.InternalPathInfo))) then
  begin
    Result := Dispatch.DispatchRequest(Sender, Request, Response);
  end;
end;

function TCustomWebDispatcher.DispatchAction(Request: TWebRequest;
  Response: TWebResponse): Boolean;
var
  I: Integer;
  Action, Default: TWebActionItem;
  Dispatch: IWebDispatch;
begin
  FRequest := Request;
  FResponse := Response;
  I := 0;
  Default := nil;
  if Response.Sent then
  begin
    Result := True;
    { Note that WebSnapSvr enabled apps have no way to mark response as sent }
    Exit;
  end;
  Result := DoBeforeDispatch(Request, Response) or Response.Sent;
  while not Result and (I < FActions.Count) do
  begin
    Action := FActions[I];
    Result := Action.DispatchAction(Request, Response, False);
    if Action.Default then Default := Action;
    Inc(I);
  end;
  // Dispatch to self registering components
  I := 0;
  while not Result and (I < FDispatchList.Count) do
  begin
    if Supports(IInterface(FDispatchList.Items[I]), IWebDispatch, Dispatch) then
    begin
      Result := DispatchHandler(Self, Dispatch,
        Request, Response, False);
    end;
    Inc(I);
  end;

  if not Result and Assigned(Default) then
    Result := Default.DispatchAction(Request, Response, True);
  if Result and not Response.Sent then
    Result := DoAfterDispatch(Request, Response);

end;

function TCustomWebDispatcher.GetAction(Index: Integer): TWebActionItem;
begin
  Result := FActions[Index];
end;

procedure TCustomWebDispatcher.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
  DispatchIntf: IWebDispatch;
  SetAppDispatcher: ISetAppDispatcher;
begin
  { For classic style WebBroker apps we assume a single data module that owns all producers. }
  inherited Notification(AComponent, Operation);
  if (Operation = opInsert) then
  begin
    if Supports(IInterface(AComponent), ISetAppDispatcher, SetAppDispatcher) then
      SetAppDispatcher.SetAppDispatcher(Self)
    else if Supports(IInterface(AComponent), IWebDispatch, DispatchIntf) then
      FDispatchList.Add(AComponent);
  end;
  if (Operation = opRemove) and (AComponent is TCustomContentProducer) then
    for I := 0 to FActions.Count - 1 do
      if FActions.Items[I].Producer = AComponent then
        FActions.Items[I].Producer := nil
      else if FActions.Items[I].ProducerContent = AComponent then
        FActions.Items[I].ProducerContent := nil;
end;

function TCustomWebDispatcher.HandleRequest(
  Request: TWebRequest; Response: TWebResponse): Boolean;
begin
  FRequest := Request;
  FResponse := Response;
  Result := DispatchAction(Request, Response);
end;

procedure TCustomWebDispatcher.SetActions(Value: TWebActionItems);
begin
  FActions.Assign(Value);
end;

function TCustomWebDispatcher.GetRequest: TWebRequest;
begin
  Result := FRequest;
end;

function TCustomWebDispatcher.GetResponse: TWebResponse;
begin
  Result := FResponse;
end;

function TCustomWebDispatcher.Access_Request: TWebRequest;
begin
  Result := GetRequest;
end;

function TCustomWebDispatcher.Access_Response: TWebResponse;
begin
  Result := GetResponse;
end;

{ TWebModule }

constructor TWebModule.Create(AOwner: TComponent);
begin
  // Code to load a resource associated with this module.  If the class
  // is TCustomWebDispatcher, assume that there is no resource.  This
  // allows an app to dynamically instantiate a TCustomWebDispatcher as
  // run time.
  inherited Create(AOwner);
  if (ClassType <> TCustomWebDispatcher) and not (csDesigning in ComponentState) then
  try
    if not InitInheritedComponent(Self, TCustomWebDispatcher) then
      raise EResNotFound.CreateFmt(SResNotFound, [ClassName]);
  {$IFDEF MSWINDOWS}
    if Assigned(OnCreate) and OldCreateOrder then OnCreate(Self);
  {$ENDIF}

  {$IFDEF POSIX}
    if Assigned(OnCreate) then OnCreate(Self);
  {$ENDIF}
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(nil);
  end;
end;

function EncodingFromContentType(const AContentType: string): TEncoding;
var
  S: string;
begin
  Result := nil;
  S := UpperCase(string(AContentType));
  if (Pos('CHARSET', S) > 0) then // Do not localize
    if (Pos('UTF-8', S) > 0) then // Do not localize
      Result := TEncoding.UTF8
    else if (Pos('ISO-8859-1', S) > 0) then // Do not localize
      Result := TEncoding.ANSI
    else if (Pos('ANSI', S) > 0) then // Do not localize
      Result := TEncoding.ANSI
    else if (Pos('ASCII', S) > 0) then // Do not localize
      Result := TEncoding.ASCII;

  if Result = nil then
    Result := Web.HTTPApp.DefaultCharSetEncoding;

end;

function EncodingGetString(const AContentType: string; const AValue: TBytes): string;
var
  Encoding: TEncoding;
begin
  Encoding := EncodingFromContentType(AContentType);
  Result := Encoding.GetString(AValue);
end;

function EncodingGetBytes(const AContentType: string; const AValue: string): TBytes;
var
  Encoding: TEncoding;
begin
  Encoding := EncodingFromContentType(AContentType);
  Result := Encoding.GetBytes(AValue);
end;

function HTTPDecode(const AStr: string): string;
begin
  Result := TNetEncoding.URL.Decode(AStr);
end;

function HTTPEncode(const AStr: string): string;
begin
  Result := TNetEncoding.URL.Encode(AStr);
end;

function HTMLEncode(const AStr: String): String;
begin
  Result := TNetEncoding.HTML.Encode(AStr);
end;

function HTMLDecode(const AStr: String): String;
begin
  Result := TNetEncoding.HTML.Decode(AStr);
end;

const
// These strings are NOT to be resourced

  Months: array[1..12] of string = (
    'Jan', 'Feb', 'Mar', 'Apr',
    'May', 'Jun', 'Jul', 'Aug',
    'Sep', 'Oct', 'Nov', 'Dec');
  DaysOfWeek: array[1..7] of string = (
    'Sun', 'Mon', 'Tue', 'Wed',
    'Thu', 'Fri', 'Sat');
  LongDaysOfWeek: array[1..7] of string = (
    'Sunday', 'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday');

function OldParseDate(Parser: TParser; const DateStr: string): TDateTime; forward;
function ParseHTTPDate(Parser: TParser; const DateStr: string): TDateTime; forward;

function ParseDate(const DateStr: string): TDateTime;
var
  Parser: TParser;
  StringStream: TStringStream;
  S: string;
begin
  S := DateStr;
  S := S.Replace('-', ':'); // Change delimiter to work with TParser
  StringStream := TStringStream.Create(S);
  try
    Parser := TParser.Create(StringStream);
    try
      if Parser.Token = toInteger then
        Result := OldParseDate(Parser, DateStr)
      else
        Result := ParseHTTPDate(Parser, DateStr);
    finally
      Parser.Free;
    end;
  finally
    StringStream.Free;
  end;
end;

// MM/DD/YY HH:MM:SS
function OldParseDate(Parser: TParser; const DateStr: string): TDateTime;
var
  Month, Day, Year, Hour, Minute, Sec: Integer;

  function GetMonth: Boolean;
  begin
    if Month < 13 then
    begin
      Result := False;
      Exit;
    end;
    Month := 1;
    while not Parser.TokenSymbolIs(Months[Month]) and (Month < 13) do Inc(Month);
    Result := Month < 13;
  end;

  procedure GetTime;
  begin
    with Parser do
    begin
      Hour := TokenInt;
      NextToken;
      if Token = ':' then NextToken;
      Minute := TokenInt;
      NextToken;
      if Token = ':' then NextToken;
      Sec := TokenInt;
      NextToken;
    end;
  end;

begin
  Month := 13;
  with Parser do
  begin
    Month := TokenInt;
    NextToken;
    if Token = ':' then NextToken;
    NextToken;
    if Token = ',' then NextToken;
    if GetMonth then
    begin
      NextToken;
      Day := TokenInt;
      NextToken;
      GetTime;
      Year := TokenInt;
    end else
    begin
      Day := TokenInt;
      NextToken;
      if Token = '-' then NextToken;
      GetMonth;
      NextToken;
      if Token = '-' then NextToken;
      Year := TokenInt;
      if Year < 100 then Inc(Year, 2000);
      NextToken;
      GetTime;
    end;
    Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Sec, 0);
  end;
end;

// From http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html
//  HTTP-date    = rfc1123-date | rfc850-date | asctime-date
//  rfc1123-date = wkday "," SP date1 SP time SP "GMT"
//  rfc850-date  = weekday "," SP date2 SP time SP "GMT"
//  asctime-date = wkday SP date3 SP time SP 4DIGIT
//  date1        = 2DIGIT SP month SP 4DIGIT
//                 ; day month year (e.g., 02 Jun 1982)
//  date2        = 2DIGIT "-" month "-" 2DIGIT
//                 ; day-month-year (e.g., 02-Jun-82)
//  date3        = month SP ( 2DIGIT | ( SP 1DIGIT ))
//                 ; month day (e.g., Jun 2)
//  time         = 2DIGIT ":" 2DIGIT ":" 2DIGIT
//                 ; 00:00:00 - 23:59:59
//  wkday        = "Mon" | "Tue" | "Wed"
//               | "Thu" | "Fri" | "Sat" | "Sun"
//  weekday      = "Monday" | "Tuesday" | "Wednesday"
//               | "Thursday" | "Friday" | "Saturday" | "Sunday"
//  month        = "Jan" | "Feb" | "Mar" | "Apr"
//               | "May" | "Jun" | "Jul" | "Aug"
//               | "Sep" | "Oct" | "Nov" | "Dec"
function ParseHTTPDate(Parser: TParser; const DateStr: string): TDateTime;
var
  DayOfWeek, Month, Day, Year, Hour, Minute, Sec: Integer;

  procedure GetWeekDayOrWkDay;
  begin
    with Parser do
    begin
      DayOfWeek := 1;
      while not Parser.TokenSymbolIs(DaysOfWeek[DayOfWeek]) and (DayOfWeek <= 7) do Inc(DayOfWeek);
      if DayOfWeek > 7 then
      begin
        DayOfWeek := 1;
        while not Parser.TokenSymbolIs(LongDaysOfWeek[DayOfWeek]) and (DayOfWeek <= 7) do Inc(DayOfWeek);
      end;
      if DayOfWeek > 7 then
        raise EParserError.CreateFmt(sNotAValidDay, [TokenString]);
      NextToken;
    end;
  end;

  procedure GetDate1Or2;
  begin
    with Parser do
    begin
      Day := TokenInt;
      NextToken;
      if Token = ':' then NextToken; // Note that '-' has been replaced with ':' to work with TParser
      Month := 1;
      while not Parser.TokenSymbolIs(Months[Month]) and (Month <= 12) do Inc(Month);
      if Month > 12 then
        raise EParserError.CreateFmt(sNotAValidMonth, [TokenString]);
      NextToken;
      if Token = ':' then NextToken;
      if Length(TokenString) < 4 then
        Year := 2000 + TokenInt
      else
        Year := TokenInt;
      NextToken;
    end;
  end;

  procedure GetDate3;
  begin
    with Parser do
    begin
      Month := 1;
      while not Parser.TokenSymbolIs(Months[Month]) and (Month <= 12) do Inc(Month);
      if Month > 12 then
        raise EParserError.CreateFmt(sNotAValidMonth, [TokenString]);
      NextToken;
      Day := TokenInt;
      NextToken;
    end;
  end;

  procedure GetTime;
  begin
    with Parser do
    begin
      Hour := TokenInt;
      NextToken;
      if Token = ':' then NextToken;
      Minute := TokenInt;
      NextToken;
      if Token = ':' then NextToken;
      Sec := TokenInt;
      NextToken;
    end;
  end;

begin
  with Parser do
  begin
    GetWeekDayOrWkDay;
    if Token = ',' then
    begin
      NextToken;
      GetDate1or2;
      GetTime;
    end
    else
    begin
      GetDate3;
      GetTime;
      Year := TokenInt;
    end;
    Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Sec, 0);
  end;
end;

procedure ExtractHeaderFields(Separators, _WhiteSpace: TExtractCharSet; const Content: string;
  Strings: TStrings; Decode: Boolean; StripQuotes: Boolean = False);
begin
  ExtractHeaderFields(Separators, _WhiteSpace, PChar(Content), Strings, Decode, StripQuotes);
end;

procedure ExtractHeaderFields(Separators, _WhiteSpace: TExtractCharSet; Content: PChar;
  Strings: TStrings; Decode: Boolean; StripQuotes: Boolean = False);
var
  Head, Tail: PChar;
  EOS, InQuote, LeadQuote: Boolean;
  QuoteChar: Char;
  ExtractedField: String;
  WhiteSpaceWithCRLF: TExtractCharSet;
  SeparatorsWithCRLF: TExtractCharSet;

  function CharInSet(C: Char; const CharSet: TExtractCharSet): Boolean;
  begin
    Assert(Ord(C) < 128);
    Result := UTF8Char(C) in CharSet;
  end;

  function DoStripQuotes(const S: String): String;
  var
    I: Integer;
    InStripQuote: Boolean;
    StripQuoteChar: Char;
    LChar: Char;
  begin
    Result := S;
    InStripQuote := False;
    StripQuoteChar := #0;

    if StripQuotes then
    begin
      for I := High(Result) downto Low(Result) do
      begin
        LChar := Result.Chars[I];
        if CharInSet(LChar, ['''', '"']) then
          if InStripQuote and (StripQuoteChar = LChar) then
          begin
            Result := Result.Remove(I, 1);
            InStripQuote := False;
          end
          else if not InStripQuote then
          begin
            StripQuoteChar := LChar;
            InStripQuote := True;
            Result := Result.Remove(I, 1);
          end
      end;
    end;
  end;

begin
  if (Content = nil) or (Content^ = #0) then Exit;
  WhiteSpaceWithCRLF := _WhiteSpace + [#13, #10];
  SeparatorsWithCRLF := Separators + [#0, #13, #10, '"'];
  Tail := Content;
  QuoteChar := #0;
  repeat
    while CharInSet(Tail^, WhiteSpaceWithCRLF) do Inc(Tail);
    Head := Tail;
    InQuote := False;
    LeadQuote := False;
    while True do
    begin
     while (InQuote and not CharInSet(Tail^, [#0, '"'])) or
        not CharInSet(Tail^, SeparatorsWithCRLF) do Inc(Tail);
      if Tail^ = '"' then
      begin
        if (QuoteChar <> #0) and (QuoteChar = Tail^) then
          QuoteChar := #0
        else
        begin
          LeadQuote := Head = Tail;
          QuoteChar := Tail^;
          if LeadQuote then Inc(Head);
        end;
        InQuote := QuoteChar <> #0;
        if InQuote then
          Inc(Tail)
        else Break;
      end else Break;
    end;
    if not LeadQuote and (Tail^ <> #0) and (Tail^ = '"') then
      Inc(Tail);
    EOS := Tail^ = #0;
    if Head^ <> #0 then
    begin
      SetString(ExtractedField, Head, Tail-Head);
      if Decode then
        Strings.Add(TNetEncoding.URL.Decode(DoStripQuotes(ExtractedField)))
      else
        Strings.Add(DoStripQuotes(ExtractedField));
    end;
    Inc(Tail);
  until EOS;
end;

procedure ExtractHTTPFields(Separators, _WhiteSpace: TExtractCharSet; Content: PChar;
  Strings: TStrings; StripQuotes: Boolean = False);
begin
  ExtractHeaderFields(Separators, _WhiteSpace, Content, Strings, True, StripQuotes);
end;

procedure ExtractHTTPFields(Separators, _WhiteSpace: TExtractCharSet; const Content: string;
  Strings: TStrings; StripQuotes: Boolean = False);
begin
  ExtractHeaderFields(Separators, _WhiteSpace, Content, Strings, True, StripQuotes);
end;

function StatusString(StatusCode: Integer): string;
begin
  case StatusCode of
    100: Result := 'Continue';                                 {do not localize}
    101: Result := 'Switching Protocols';                      {do not localize}
    200: Result := 'OK';                                       {do not localize}
    201: Result := 'Created';                                  {do not localize}
    202: Result := 'Accepted';                                 {do not localize}
    203: Result := 'Non-Authoritative Information';            {do not localize}
    204: Result := 'No Content';                               {do not localize}
    205: Result := 'Reset Content';                            {do not localize}
    206: Result := 'Partial Content';                          {do not localize}
    300: Result := 'Multiple Choices';                         {do not localize}
    301: Result := 'Moved Permanently';                        {do not localize}
    302: Result := 'Moved Temporarily';                        {do not localize}
    303: Result := 'See Other';                                {do not localize}
    304: Result := 'Not Modified';                             {do not localize}
    305: Result := 'Use Proxy';                                {do not localize}
    400: Result := 'Bad Request';                              {do not localize}
    401: Result := 'Unauthorized';                             {do not localize}
    402: Result := 'Payment Required';                         {do not localize}
    403: Result := 'Forbidden';                                {do not localize}
    404: Result := 'Not Found';                                {do not localize}
    405: Result := 'Method Not Allowed';                       {do not localize}
    406: Result := 'None Acceptable';                          {do not localize}
    407: Result := 'Proxy Authentication Required';            {do not localize}
    408: Result := 'Request Timeout';                          {do not localize}
    409: Result := 'Conflict';                                 {do not localize}
    410: Result := 'Gone';                                     {do not localize}
    411: Result := 'Length Required';                          {do not localize}
    412: Result := 'Unless True';                              {do not localize}
    500: Result := 'Internal Server Error';                    {do not localize}
    501: Result := 'Not Implemented';                          {do not localize}
    502: Result := 'Bad Gateway';                              {do not localize}
    503: Result := 'Service Unavailable';                      {do not localize}
    504: Result := 'Gateway Timeout';                          {do not localize}
  else
    Result := '';
  end
end;

function UnixPathToDosPath(const Path: string): string;
begin
  Result := Path.Replace('/', '\');
end;

function DosPathToUnixPath(const Path: string): string;
begin
  Result := Path.Replace('\', '/');
end;

function MonthStr(DateTime: TDateTime): string;
var
  Year, Month, Day: Word;
begin
  DecodeDate(DateTime, Year, Month, Day);
  Result := Months[Month];
end;

function DayOfWeekStr(DateTime: TDateTime): string;
begin
  Result := DaysOfWeek[DayOfWeek(DateTime)];
end;


{ TDefaultWebAppServices }

function TDefaultWebAppServices.FindRequestHandler: IWebRequestHandler;
var
  Component: TComponent;
begin
  Result := nil;
  Component := FindWebDispatcher;
  if Component <> nil then
    if not Supports(Component, IWebRequestHandler, Result) then
      Assert(False, 'Expect support for IWebRequestHandler');  { do not localize }
end;

function TDefaultWebAppServices.GetRequestHandler: IWebRequestHandler;
begin
  if FRequestHandler = nil then
    FRequestHandler := FindRequestHandler;
  Result := FRequestHandler;
end;

function TDefaultWebAppServices.HandleRequest: Boolean;
begin
  Result := InvokeDispatcher;
end;

procedure TDefaultWebAppServices.InitContext(
  WebModule: TComponent; Request: TWebRequest;
  Response: TWebResponse);
begin
  FRequest := Request;
  FResponse := Response;
  FWebModule := WebModule;
end;

procedure TDefaultWebAppServices.FinishContext;
begin
end;

function TDefaultWebAppServices.InvokeDispatcher: Boolean;
begin
  if RequestHandler <> nil then
  begin
    Result := RequestHandler.HandleRequest(Request, Response);
  end
  else
    raise EWebBrokerException.CreateRes(@sNoDispatcherComponent);
end;

function TDefaultWebAppServices.FindWebDispatcher: TComponent;
var
  J: Integer;
begin
  Result := nil;
  if WebModule is TCustomWebDispatcher then
    Result := WebModule
  else
    for J := 0 to WebModule.ComponentCount - 1 do
      if WebModule.Components[J] is TCustomWebDispatcher then
      begin
        Result := WebModule.Components[J];
        break;
      end;
end;

function TDefaultWebAppServices.GetActive: Boolean;
begin
  Result := True;
end;

function TDefaultWebAppServices.GetExceptionHandler: TObject;
var
  Intf: IUnknown;
begin
  Result := FindWebDispatcher;
  if Result <> nil then
    if not Supports(Result, IWebExceptionHandler, Intf) then
      Assert(False, 'Expect support for IWebExceptionHandler'); { do not localize }
end;

{ TAbstractContentParser }

class function TAbstractContentParser.CanParse(
  AWebRequest: TWebRequest): Boolean;
begin
  Result := False;
end;

constructor TAbstractContentParser.Create(AWebRequest: TWebRequest);
begin
  FWebRequest := AWebRequest;
  inherited Create;
end;

{ TContentParser }

class function TContentParser.CanParse(AWebRequest: TWebRequest): Boolean;
begin
  Result := True;
end;

destructor TContentParser.Destroy;
begin
  FContentFields.Free;
  FFiles.Free;
  inherited;
end;

function TContentParser.GetContentFields: TStrings;
begin
  if FContentFields = nil then
  begin
    FContentFields := TStringList.Create;
    WebRequest.ExtractContentFields(FContentFields);
  end;
  Result := FContentFields;
end;

type
  TEmptyRequestFiles = class(TAbstractWebRequestFiles)
  protected
    function GetCount: Integer; override;
    function GetItem(I: Integer): TAbstractWebRequestFile; override;
  end;

function TEmptyRequestFiles.GetCount: Integer;
begin
  Result := 0;
end;

function TEmptyRequestFiles.GetItem(I: Integer): TAbstractWebRequestFile;
begin
  Result := nil;
end;

function TContentParser.GetFiles: TAbstractWebRequestFiles;
begin
  if FFiles = nil then
    FFiles := TEmptyRequestFiles.Create;
  Result := FFiles;
end;

type
  TWebBrokerDispatchFileRequest = class(TDispatchFileRequest)
  private
    FRequestInfo:  TWebRequest;
    FResponseInfo: TWebResponse;
    FComponent: TCustomWebFileDispatcher;
  protected
    function GetApplicationPath: string; override;
    function IsGetRequest: Boolean; override;
    function IsHeadRequest: Boolean; override;
    procedure SetErrorCode(AStatusCode: Integer); override;
    function GetIfModifiedSince: TDateTime; override;
    procedure SetContentStream(AStream: TStream); override;
    procedure SetContentLength(ALength: Integer); override;
    procedure SetContentType(const AValue: string); override;
    procedure SetLastModified(AValue: TDateTime); override;
    function GetExceptionClass: TClass; override;
    procedure DoBeforeDispatch(const AFileName: string; var AHandled: Boolean); override;
    procedure DoAfterDispatch(const AFileName: string; var AHandled: Boolean); override;
    function GetRequestPathInfo: string; override;
    function GetResponseSent: Boolean; override;
  public
    constructor Create(AComponent: TCustomWebFileDispatcher; ARequestInfo: TWebRequest;
      AResponseInfo: TWebResponse);
  end;

{ TWebBrokerFileDispatcher }

constructor TWebBrokerDispatchFileRequest.Create(AComponent: TCustomWebFileDispatcher; ARequestInfo: TWebRequest;
  AResponseInfo: TWebResponse);
begin
  inherited Create(AComponent.FFileDispatcherProperties);
  FComponent := AComponent;
  FRequestInfo := ARequestInfo;
  FResponseInfo := AResponseInfo;
end;

function TWebBrokerDispatchFileRequest.IsGetRequest: Boolean;
begin
  Result := FRequestInfo.MethodType = TMethodType.mtGet;
end;

function TWebBrokerDispatchFileRequest.IsHeadRequest: Boolean;
begin
  Result := FRequestInfo.MethodType = TMethodType.mtHead;
end;

procedure TWebBrokerDispatchFileRequest.SetErrorCode(AStatusCode: Integer);
begin
 FResponseInfo.StatusCode := AStatusCode;
end;

function TWebBrokerDispatchFileRequest.GetIfModifiedSince: TDateTime;
begin
  Result := FRequestInfo.IfModifiedSince;
end;

procedure TWebBrokerDispatchFileRequest.SetContentStream(AStream: TStream);
begin
  FResponseInfo.ContentStream := AStream;
end;

procedure TWebBrokerDispatchFileRequest.SetContentLength(ALength: Integer);
begin
  FResponseInfo.ContentLength := ALength;
end;

procedure TWebBrokerDispatchFileRequest.SetContentType(const AValue: string);
begin
  FResponseInfo.ContentType := AValue;
end;

procedure TWebBrokerDispatchFileRequest.SetLastModified(AValue: TDateTime);
begin
  FResponseInfo.LastModified := AValue;
end;

function TWebBrokerDispatchFileRequest.GetApplicationPath: string;
begin
  Result := WebApplicationDirectory;
end;

function TWebBrokerDispatchFileRequest.GetExceptionClass: TClass;
begin
  Result := Exception;
end;

procedure TWebBrokerDispatchFileRequest.DoBeforeDispatch(const AFileName: string; var AHandled: Boolean);
begin
  if Assigned(FComponent.FBeforeDispatch) then
    FComponent.FBeforeDispatch(FComponent, AFileName, FRequestInfo, FResponseInfo, AHandled)
end;

procedure TWebBrokerDispatchFileRequest.DoAfterDispatch(const AFileName: string; var AHandled: Boolean);
begin
  if Assigned(FComponent.FAfterDispatch) then
    FComponent.FAfterDispatch(FComponent, AFileName, FRequestInfo, FResponseInfo, AHandled);
end;

function TWebBrokerDispatchFileRequest.GetRequestPathInfo: string;
begin
  Result := string(FRequestInfo.InternalPathInfo);
end;

function TWebBrokerDispatchFileRequest.GetResponseSent: Boolean;
begin
  Result := FResponseInfo.Sent;
end;

{ TCustomWebFileDispatcher }

constructor TCustomWebFileDispatcher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFileDispatcherProperties := TWebFileDispatcherProperties.Create(Self);
  FMask := TMask.Create('/*'); // Match all files
end;

destructor TCustomWebFileDispatcher.Destroy;
begin
  inherited Destroy;
  FMask.Free;
end;

function TCustomWebFileDispatcher.DispatchEnabled: Boolean;
begin
  Result := True;
end;

function TCustomWebFileDispatcher.DispatchMask: TMask;
begin
  Result := FMask;
end;

function TCustomWebFileDispatcher.DispatchMethodType: TMethodType;
begin
  Result := mtAny;  // Head or Get
end;

function TCustomWebFileDispatcher.GetRootDirectory: string;
begin
  Result := FFileDispatcherProperties.RootDirectory;
end;

function TCustomWebFileDispatcher.GetWebFileExtensions: TWebFileExtensions;
begin
  Result := FFileDispatcherProperties.WebFileExtensions;
end;

function TCustomWebFileDispatcher.GetWebDirectories: TWebDirectories;
begin
  Result := FFileDispatcherProperties.WebDirectories;
end;

procedure TCustomWebFileDispatcher.SetRootDirectory(const Value: string);
begin
  FFileDispatcherProperties.RootDirectory := Value;
end;

procedure TCustomWebFileDispatcher.SetWebFileExtensions(
  const Value: TWebFileExtensions);
begin
  FFileDispatcherProperties.WebFileExtensions := Value;
end;

procedure TCustomWebFileDispatcher.SetWebDirectories(
  const Value: TWebDirectories);
begin
  FFileDispatcherProperties.WebDirectories := Value;
end;

function TCustomWebFileDispatcher.DispatchRequest(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse): Boolean;
var
  LDispatcher: TWebBrokerDispatchFileRequest;
begin
  LDispatcher := TWebBrokerDispatchFileRequest.Create(Self,
    Request, Response);
  try
    Result := LDispatcher.DispatchFileRequest;
  finally
    LDispatcher.Free;
  end;
end;

initialization
finalization
  FreeAndNil(FContentParsers);
end.
