{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Web server application components               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WebScript;

interface

uses System.SysUtils, System.Classes, System.Contnrs, Web.HTTPApp, Web.HTTPProd,
  WebSnapObjs, SiteComp, Web.WebCntxt, Web.CopyPrsr;

type
  { Exception to look out for }
  EScriptEvalError = class(EWebBrokerException);

  ERecursiveIncludeFile = class(EScriptError)
  end;

  THTMLItem = class;
  THTMLItems = class;
  TScriptItem = class;
  TScriptItems = class;
  TLineNumberMap = class;

  TScriptProducer = class;
  TScriptFile = class
  private
    FSourceStream: TStream;
    FStreamOwned: Boolean;
    FProducer: TScriptProducer;
    FScriptItems: TScriptItems;
    function GetScript: string;
    function GetSource: string;
    function GetApplicationName: string;
    function GetLongName: string;
    function GetShortName: string;
    function GetDestLineCount: Integer;
  public
                                       
    FLineNumberMap: TLineNumberMap;
    constructor Create(AProducer: TScriptProducer);
    destructor Destroy; override;
    procedure ParseStream(ASource: TStream; AOwned: Boolean);
    procedure ParseString(const ASource: string);
    property Script: string read GetScript;
    property Source: string read GetSource;
    property ShortName: string read GetShortName;
    property LongName: string read GetLongName;
    property ApplicationName: string read GetApplicationName;
  end;

  TIncludeType = (incFile, incPage);
  TScriptIncludeFile = class(TScriptFile)
  private
    FFileName: string;
    FIncludeType: TIncludeType;
    FLoaded: Boolean;
    FLoading: Boolean;
    procedure LoadIncludeFile;
    procedure LoadIncludePage;
  public
    constructor Create(AProducer: TScriptProducer; AIncludeType: TIncludeType; const AFileName: string);
    procedure LoadFile;
  end;

  TScriptIncludeFiles = class(TObjectList)
  private
    FProducer: TScriptProducer;
  public
    constructor Create(AProducer: TScriptProducer);
    function GetScriptIncludeFile(I: Integer): TScriptIncludeFile;
    property Items[Index: Integer]: TScriptIncludeFile read GetScriptIncludeFile; default;
  end;

  TScriptProducer = class(TAbstractScriptProducer, IScriptProducer, IScriptContext)
  private
    FDesigning: Boolean;
    FHTMLItems: THTMLItems;
    FIncludeFiles: TScriptIncludeFiles;
    FWebModuleContext: TWebModuleContext;
    FStripParamQuotes: Boolean;
    FHandleTag: THandleTagProc;
    FContent: TStringStream;
    FLocateFileService: ILocateFileService;
    function GetHTMLItem(I: Integer): THTMLItem;
    function GetHTMLItemCount: Integer;
    function GetScript: string;
    function GetComponent: TComponent;
    procedure WritePChar(const AValue: PAnsiChar; ALength: Integer);
  protected
                                       
    FScriptFile: TScriptFile;
    FScriptEngine: string;
    FErrors: TAbstractScriptErrors;
    function EvaluateExpression(AScriptFile: TScriptFile): string; virtual; abstract;
    function ImplHandleScriptError(const ScriptError: IUnknown): HRESULT; virtual; abstract;
    { IScriptContext }
    function GetWebModuleContext: TWebModuleContext;
    { IScriptProducer }
    function GetHTMLBlock(I: Integer): string;
    function GetHTMLBlockCount: Integer;
    function GetErrors: TAbstractScriptErrors;
    procedure ParseStream(Stream: TStream; Owned: Boolean);
    procedure ParseString(const S: string);
    function ReplaceTags(const AValue: string): string;
    function Evaluate: string;
    procedure HandleParserError(E: Exception);
    procedure Write(const AValue: PWideChar; ALength: Integer); overload;
    procedure Write(const Value: string); overload;
    procedure Write(Value: PAnsiChar); overload;
    function  GetContent: string;
    procedure SetContent(const Value: string);
    procedure WriteItem(Index: Integer);
    function HandleScriptError(const ScriptError: IUnknown): HRESULT;
    property Script: string read GetScript;
    property Errors: TAbstractScriptErrors read FErrors;
    property Designing: Boolean read FDesigning;
    property Component: TComponent read GetComponent;
    property Content: string read GetContent;
  public
    constructor Create(AWebModuleContext: TWebModuleContext;
        AStripParamQuotes: Boolean; AHandleTag: THandleTagProc;
        const AScriptEngine: string; ALocateFileService: ILocateFileService); override;
    destructor Destroy; override;
  end;

  TAbstractScriptObjectFactory = class;

  TAbstractScriptEngine = class;

  TVariableLookup = class(TObject)
  private
    FValue: Variant;
    FIdent: string;
    FObject: TObject;
    FWebModuleContext: TWebModuleContext;
    function FindFieldVariable(AParent: TComponent;
      const AName: string): TComponent;
    function FindVariable(const AName: string): TComponent;
    procedure SetIdent(const Value: string);
    function GetObject: TObject;
  public
    function FindGlobalVariable(const AName: string): TComponent;
    function FindGlobalVariableContainer(const AName: string): TComponent;
    constructor Create(const AIdent: string; AWebModuleContext: TWebModuleContext);
    function LookupObject: Boolean;
    property Ident: string read FIdent write SetIdent;
    property Obj: TObject read GetObject;
  end;

  THTMLItems = class(TObjectList)
  private
    FStream: TStringStream;
    FProducer: TScriptProducer;
  public
    constructor Create(AProducer: TScriptProducer);
    destructor Destroy; override;
    function MakeIdentifier(AItem: THTMLItem): string;
    function GetHTMLItem(I: Integer): THTMLItem;
    property Items[Index: Integer]: THTMLItem read GetHTMLItem; default;
  end;

  THTMLItem = class(TObject)
  private
    FItems: THTMLItems;
    FIndex: Integer;
    FStreamOffset: Integer;
    FLength: Integer;
    FTagToken: Boolean;
    function GetHTML: string;
    function GetIdent: string;
    function GetPHTMLChar: PAnsiChar;
  public
    constructor Create(AItems: THTMLItems);
    procedure AssignString(AOffset: Integer; AHTML: PAnsiChar; ALength: Integer; AEncoding: TEncoding);
    property Ident: string read GetIdent;
    property HTML: string read GetHTML;
    property TagToken: Boolean read FTagToken write FTagToken;
    property ItemLength: Integer read FLength;
  end;

  TScriptItems = class(TObjectList)
  private
    FProducer: TScriptProducer;
  public
    constructor Create(AProducer: TScriptProducer);
    function GetScriptItem(I: Integer): TScriptItem;
    property Items[Index: Integer]: TScriptItem read GetScriptItem; default;
  end;

  TScriptItem = class(TObject)
  private
    FItems: TScriptItems;
  protected
    function GetScript: string; virtual;
  public
    constructor Create(AItems: TScriptItems);
    property Script: string read GetScript;
  end;

  TScriptCodeItem = class(TScriptItem)
  private
    FScript: string;
  protected
    function GetScript: string; override;
  public
    procedure AssignString(const AValue: string);
  end;

  TScriptIncludeItem = class(TScriptItem)
  private
    FScriptIncludeFile: TScriptIncludeFile;
  protected
    function GetScript: string; override;
  public
    constructor Create(AItems: TScriptItems;  AIncludeFile: TScriptIncludeFile);
  end;

  TGlobalScriptVariables = (svPage, svPages, svModules, svApplication,
    svSession, svEndUser, svResponse, svRequest, svHTMLItems, svProducer);

  TScriptGlobalObjects = class;

  TAbstractScriptObjectFactory = class
  protected
    function GetScriptEngine: TAbstractScriptEngine; virtual; abstract;
    function CreateComponentObject(AComponent: TObject; AClassKey: TClass): IInterface; virtual; abstract;
    procedure AddGlobalObjects(AScriptGlobalObjects: TScriptGlobalObjects); virtual;
    function CreateProducerObject(AVariable: TGlobalScriptVariables; AProducer: IScriptProducer): IInterface; virtual; abstract;
  public
    function CreateGlobalObject(AVariable: TGlobalScriptVariables; AContext: IScriptContext): IInterface; virtual; abstract;
  end;

  TScriptGlobalObjects = class(TObject)
  private
    FIntfList: IInterfaceList;
    FNamedList: TStrings;
    FProducer: IScriptProducer;
  protected
    function GetScriptEngine: TAbstractScriptEngine; virtual; abstract;
  public
    constructor Create(AProducer: IScriptProducer);
    function GetNamedItemCount: Integer;
    function GetNamedItemName(I: Integer): string;
    procedure AddNamedIntf(const AName: string; AIntf: IUnknown);
    function FindNamedItemIntf(const AName: string): IUnknown;
    destructor Destroy; override;
    property NamedItemCount: Integer read GetNamedItemCount;
    property NamedItemName[I: Integer]: string read GetNamedItemName;
    property Producer: IScriptProducer read FProducer;
    property ScriptEngine: TAbstractScriptEngine read GetScriptEngine;
  end;

  TScriptErrors = class(TAbstractScriptErrors)
  private
    FList: TObjectList;
  protected
    function GetError(I: Integer): TAbstractScriptError; override;
    function GetErrorCount: Integer; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const AError: TAbstractScriptError); override;
  end;

  TScriptError = class(TAbstractScriptError)
  protected
    FLine: Integer;
    FCharPos: Integer;
    FDescription: string;
    FSourceLine: string;
    FFileName: string;
    function GetSourceLine: string; override;
    function GetCharPos: Integer;  override;
    function GetLine: Integer; override;
    function GetDescription: string; override;
    procedure SetDescription(const AValue: string); override;
    function GetFileName: string; override;
  public
    constructor Create(E: Exception); overload;
  end;

  TCurrentWebPageInfo = class(TInterfacedObject, IWebPageInfo)
  private
    FContext: IScriptContext;
    FWebPageInfo: IWebPageInfo;
  protected
    function WebPageInfo: IWebPageInfo;
    { IWebPageInfo }
    function GetPageName: string;
    function GetPageHREF: string;
    function GetPageDescription: string;
    function GetPageTitle: string;
    function GetPageIsPublished: Boolean;
    function GetLoginRequired: Boolean;
    function GetHasViewAccess: Boolean;
  public
    constructor Create(AContext: IScriptContext);
  end;

  TLineNumbers = record
    SourceStartLine: Integer;
    SourceLineCount: Integer;
    DestStartLine: Integer;
    DestLineCount: Integer;
    ScriptIncludeFile: TScriptIncludeFile;
  end;

  PLineNumbers = ^TLineNumbers;

  TLineNumberMap = class(TObject)
  private
    FFileName: string;
    FArray: array of TLineNumbers;
    function GetCount: Integer;
    function GetLineNumbers(I: Integer): PLineNumbers;
  public
    function New: PLineNumbers;
    function DestLineToSourceLine(ALine: Integer; var AFileName: string): Integer;
    property Count: Integer read GetCount;
    property Items[I: Integer]: PLineNumbers read GetLineNumbers; default;
  end;

  TAbstractScriptObjectFactories = class(TObject)
  protected
    function GetCount: Integer; virtual; abstract;
    function GetFactory(I: Integer): TAbstractScriptObjectFactory; virtual; abstract;
    function GetObjectList: TObjectList; virtual; abstract;
  public
    property Count: Integer read GetCount;
    property Factories[I: Integer]: TAbstractScriptObjectFactory read GetFactory; default;
    property ObjectList: TObjectList read GetObjectList;
  end;

  TScriptObjectFactories = class(TAbstractScriptObjectFactories)
  private
    FObjectList: TObjectList;
  protected
    function GetCount: Integer; override;
    function GetFactory(I: Integer): TAbstractScriptObjectFactory; override;
    function GetObjectList: TObjectList; override;
  public
    constructor Create;
    destructor Destroy; override;
    function CreateGlobalObject(AVariable: TGlobalScriptVariables; AContext: IScriptContext): IInterface;
    property Count: Integer read GetCount;
    property Factories[I: Integer]: TAbstractScriptObjectFactory read GetFactory; default;
  end;

  CreateComponentStubFactory = function(AComponent: TObject; AComponentClass: TClass): IInterface;

  TScriptEnginesList = class(TAbstractScriptEnginesList)
  private
    FList: TObjectList;
    function GetCount: Integer;
    function GetItem(I: Integer): TAbstractScriptEngine;
  public
    constructor Create;
    destructor Destroy; override;
    function FindScriptProducerClass(const ALanguageName: string): TScriptProducerClass; override;
    function Find(const AName: string): TAbstractScriptEngine;
    procedure AddObjectFactory(AFactory: TAbstractScriptObjectFactory; const AEngineName: string);
    procedure AddEngine(AEngine: TAbstractScriptEngine);
    procedure RemoveEngine(AEngine: TAbstractScriptEngine);
    procedure ListLanguageNames(AList: TStrings);
    property Count: Integer read GetCount;
    property Items[I: Integer]: TAbstractScriptEngine read GetItem;
  end;

  TAbstractScriptEngine = class(TObject)
  private
    FName: string;
    FScriptProducerClass: TScriptProducerClass;
    FScriptObjectFactories: TAbstractScriptObjectFactories;
  public
    procedure ListLanguageNames(AList: TStrings); virtual; abstract;
    function SupportsLanguage(const AName: string): Boolean;virtual; abstract;
    constructor Create(const AName: string);
    destructor Destroy; override;
    function CreateComponentStub(AObject: TObject): IInterface;
    procedure AddObjectFactory(AFactory: TAbstractScriptObjectFactory);
    property Name: string read FName;
    property ScriptObjectFactories: TAbstractScriptObjectFactories read FScriptObjectFactories;
    property ScriptProducerClass: TScriptProducerClass read FScriptProducerClass write FScriptProducerClass;
  end;

const
  GlobalScriptVariableNames: array[TGlobalScriptVariables] of PChar =
    ('Page', 'Pages', 'Modules', 'Application', 'Session', 'EndUser', 'Response', 'Request', 'HTML_',
    'Producer');

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  Web.WebConst, WebComp, System.Variants,
{$IFDEF LINUX}
 WebScriptSM,  // Force use of spider monkey engine
{$ENDIF}
{$IFDEF MSWINDOWS}
 WebScriptAS,  // Force use of active scripting engine
{$ENDIF}
 WebDisp, SiteConst;

procedure RaiseObjectDoesNotSupportScripting(AObject: TObject);
begin
  if AObject is TComponent then
    raise EScriptEvalError.CreateFmt(sComponentDoesNotSupportScripting,
      [TComponent(AObject).ClassName, TComponent(AObject).Name])
  else
    raise EScriptEvalError.CreateFmt(sClassDoesNotSupportScripting,
      [AObject.ClassName]);
end;

procedure RaiseIncludePageNotFound(const APage: string);
begin
  raise EScriptError.CreateFmt(sCantFindIncludePage, [APage]);
end;

procedure RaisePageDoesNotSupportInclusion(const APage: string);
begin
  raise EScriptError.CreateFmt(sInclusionNotSupported, [APage]);
end;

{ TScriptProducer }

procedure TScriptProducer.ParseStream(Stream: TStream; Owned: Boolean);
begin
  FHTMLItems.Clear;
  FScriptFile.ParseStream(Stream, Owned);
end;

procedure TScriptProducer.ParseString(const S: string);
begin
  FHTMLItems.Clear;
  FScriptFile.ParseString(S);
end;

constructor TScriptProducer.Create(AWebModuleContext: TWebModuleContext;
    AStripParamQuotes: Boolean; AHandleTag: THandleTagProc;
    const AScriptEngine: string; ALocateFileService: ILocateFileService);
begin
  inherited Create(AWebModuleContext, AStripParamQuotes, AHandleTag, AScriptEngine,
    ALocateFileService);
  FContent := TStringStream.Create('', TEncoding.UTF8);
  FDesigning := (AWebModuleContext is TComponent) and (csDesigning in TComponent(AWebModuleContext).ComponentState);
  FLocateFileService := ALocateFileService;
  FScriptEngine := AScriptEngine;
  if FScriptEngine = '' then
    FScriptEngine := 'JSCRIPT';
  FErrors := TScriptErrors.Create;
  FHTMLItems := THTMLItems.Create(Self);
  FScriptFile := TScriptFile.Create(Self);
  FIncludeFiles := TScriptIncludeFiles.Create(Self);
  FWebModuleContext := AWebModuleContext;
  FStripParamQuotes := AStripParamQuotes;
  FHandleTag := AHandleTag;
end;

destructor TScriptProducer.Destroy;
begin
  inherited;
  FHTMLItems.Free;
  FScriptFile.Free;
  FIncludeFiles.Free;
  FErrors.Free;
  FContent.Free;
end;

function TScriptProducer.GetHTMLItemCount: Integer;
begin
  Result := FHTMLItems.Count;
end;

function TScriptProducer.GetHTMLItem(I: Integer): THTMLItem;
begin
  Result := THTMLItem(FHTMLItems[I]);
end;

function TScriptProducer.GetHTMLBlock(I: Integer): string;
begin
  Result := GetHTMLItem(I).HTML;
end;

function TScriptProducer.Evaluate: string;
begin
  Result := EvaluateExpression(FScriptFile);
end;

function TScriptProducer.GetContent: string;
begin
  Result := FContent.DataString;
end;

procedure TScriptProducer.SetContent(const Value: string);
begin
  FContent.Size := 0;
  Write(Value);
end;

procedure TScriptProducer.Write(const AValue: PWideChar; ALength: Integer);
begin
  Write(WideCharLenToString(AValue, ALength));
end;

procedure TScriptProducer.WritePChar(const AValue: PAnsiChar; ALength: Integer);
begin
  FContent.Write(AValue[0], ALength)
end;

procedure TScriptProducer.Write(const Value: string);
begin
  if Value <> '' then
    FContent.WriteString(Value);
end;

procedure TScriptProducer.Write(Value: PAnsiChar);
begin
  WritePChar(Value, Length(Value));
end;

procedure TScriptProducer.HandleParserError(
  E: Exception);
begin
  FErrors.Add(TScriptError.Create(E));
end;

function TScriptProducer.GetScript: string;
begin
  Result := FScriptFile.Script;
end;

function TScriptProducer.GetErrors: TAbstractScriptErrors;
begin
  Result := FErrors;
end;

function TScriptProducer.GetComponent: TComponent;
begin
  if FWebModuleContext is TComponent then
    Result := TComponent(FWebModuleContext)
  else
    Result := nil;
end;

function TScriptProducer.HandleScriptError(
  const ScriptError: IInterface): HRESULT;
begin
  Result := ImplHandleScriptError(ScriptError);
end;

{ TVariableLookup }

function TVariableLookup.LookupObject: Boolean;
begin
  if (FObject = nil) and (FIdent <> '') then
    FObject := FindVariable(FIdent);
  Result := Assigned(FObject);
end;

function TVariableLookup.FindVariable(const AName: string): TComponent;
var
  S1, S2: string;
  P: Integer;
  Context: TComponent;
begin
  Result := nil;
  if AName <> '' then
  begin
    S1 := AName;
    Context := nil;
    P := Pos('.', S1);
    if P > 0 then
    begin
      while P > 0 do
      begin
        S2 := Copy(S1, 1, P-1);
        Delete(S1, 1, P);
        if not Assigned(Context) then
          Context := FindGlobalVariableContainer(S2)
        else
          Context := FindFieldVariable(Context, S2);
        if not Assigned(Context) then
          raise EScriptError.CreateFmt(sVariableNotFound, [AName]);
        P := Pos('.', S1);
      end;
      Result := FindFieldVariable(Context, S1);
    end
    else
      Result := FindGlobalVariable(AName);
  end;
end;

function TVariableLookup.FindGlobalVariableContainer(const AName: string): TComponent;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  Result := nil;
  if FWebModuleContext <> nil then
  begin
    if Supports(FWebModuleContext, IWebVariablesContainer, WebVariablesContainer) then
    begin
      Result := WebVariablesContainer.FindVariableContainer(AName);
      if Assigned(Result) then
        Exit;
    end;
  end;
  if not Assigned(Result) then
    if WebContext <> nil then
    begin
      Result := WebContext.FindVariableContainer(AName);
      if Assigned(Result) then
        Exit;
    end;
  raise EScriptError.CreateFmt(sVariableNotFound, [AName]);
end;

function TVariableLookup.FindGlobalVariable(const AName: string): TComponent;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  Result := nil;
  if AName <> '' then
  begin
    if FWebModuleContext <> nil then
    begin
      if Supports(FWebModuleContext, IWebVariablesContainer, WebVariablesContainer) then
      begin
        Result := WebVariablesContainer.FindVariable(AName);
      end
      else
        Assert(False) //  IWebVariablesContainer not implemented
    end
    else
      Assert(False) // No module context
  end;
end;

function TVariableLookup.FindFieldVariable(AParent: TComponent; const AName: string): TComponent;
var
  WebVariablesContainer: IWebVariablesContainer;
begin
  Result := nil;
  if Supports(IInterface(AParent), IWebVariablesContainer, WebVariablesContainer) then
    Result := WebVariablesContainer.FindVariable(AName)
end;

constructor TVariableLookup.Create(const AIdent: string; AWebModuleContext: TWebModuleContext);
begin
  inherited Create;
  Ident := AIdent;
  FWebModuleContext := AWebModuleContext;
end;

procedure TVariableLookup.SetIdent(const Value: string);
begin
  FIdent := Value;
  FValue := Unassigned;
  FObject := nil;
end;

function TVariableLookup.GetObject: TObject;
begin
  if LookupObject then
    Result := FObject
  else
    Result := nil;
end;

function TScriptProducer.ReplaceTags(const AValue: string): string;
begin
  Result := string(ContentFromString(AValue, FStripParamQuotes,
    FHandleTag, nil));
end;

function TScriptProducer.GetHTMLBlockCount: Integer;
begin
  Result := GetHTMLItemCount;
end;

function TScriptProducer.GetWebModuleContext: TWebModuleContext;
begin
  Result := FWebModuleContext;
end;

{ THTMLItem }

procedure THTMLItem.AssignString(AOffset: Integer; AHTML: PAnsiChar; ALength: Integer; AEncoding: TEncoding);
var
  Bytes: TBytes;
  S: string;
begin
  FStreamOffset := FItems.FStream.Size;
  if AEncoding <> FItems.FStream.Encoding then
  begin
    SetLength(Bytes, ALength);
    Move(AHTML[0], Bytes[0], ALength);
    S := AEncoding.GetString(Bytes);
    FItems.FStream.WriteString(S);
    FLength := FItems.FStream.Size - FStreamOffset;
  end
  else
  begin
    FLength := ALength;
    FItems.FStream.Write(AHTML[0], ALength);
  end;
end;

constructor THTMLItem.Create(AItems: THTMLItems);
begin
  inherited Create;
  FItems := AItems;
  FIndex := AItems.Count;
  AItems.Add(Self);
end;

function THTMLItem.GetIdent: string;
begin
  Result := FItems.MakeIdentifier(Self);
end;

function THTMLItem.GetHTML: string;
var
  AAnsiString: AnsiString;
begin
  Assert(FItems.FStream.Encoding = TEncoding.UTF8);
  SetString(AAnsiString, PAnsiChar(FItems.FStream.Memory) + FStreamOffset, FLength);
  Result := UTF8ToUnicodeString(RawByteString(AAnsiString));
end;

function THTMLItem.GetPHTMLChar: PAnsiChar;
begin
  Result := PAnsiChar(FItems.FStream.Memory) + FStreamOffset;
end;

{ THTMLItems }

constructor THTMLItems.Create(AProducer: TScriptProducer);
begin
  inherited Create(True); // it owns the objects
  FProducer := AProducer;
  FStream := TStringStream.Create('', TEncoding.UTF8);
end;

destructor THTMLItems.Destroy;
begin
  FStream.Free;
  inherited;
end;

function THTMLItems.GetHTMLItem(I: Integer): THTMLItem;
begin
  Result := THTMLItem(GetItem(I));
end;

function THTMLItems.MakeIdentifier(AItem: THTMLItem): string;
begin
  Result := Format('%s.Item(%d)', [GlobalScriptVariableNames[svHTMLItems], AItem.FIndex]);
end;

{ TScriptGlobalObjects }

procedure TScriptGlobalObjects.AddNamedIntf(const AName: string; AIntf: IUnknown);
begin
  FNamedList.Add(AName);
  FIntfList.Add(AIntf);
end;

constructor TScriptGlobalObjects.Create(AProducer: IScriptProducer);
var
  I: Integer;
begin
  inherited Create;
  FProducer := AProducer;
  FNamedList := TStringList.Create;
  FIntfList := TInterfaceList.Create;
  for I := 0 to ScriptEngine.ScriptObjectFactories.Count - 1 do
    ScriptEngine.ScriptObjectFactories[I].AddGlobalObjects(Self);
end;

destructor TScriptGlobalObjects.Destroy;
begin
  inherited;
  FNamedList.Free;
end;

function TScriptGlobalObjects.FindNamedItemIntf(const AName: string): IUnknown;
var
  I: Integer;
begin
  I := FNamedList.IndexOf(AName);
  if I >= 0 then
    Result := FIntfList[I]
  else
    Result := nil;
end;

function TScriptGlobalObjects.GetNamedItemCount: Integer;
begin
  Result := FNamedList.Count;
end;

function TScriptGlobalObjects.GetNamedItemName(I: Integer): string;
begin
  Result := FNamedList[I];
end;

{ TCurrentWebPageInfo }

constructor TCurrentWebPageInfo.Create(AContext: IScriptContext);
begin
  FContext := AContext;
  inherited Create;
end;

function TCurrentWebPageInfo.GetPageDescription: string;
begin
  if WebPageInfo <> nil then
    Result := WebPageInfo.PageDescription
  else
    Result := GetPageName;
end;

function TCurrentWebPageInfo.GetPageHREF: string;
begin
  if WebPageInfo <> nil then
    Result := WebPageInfo.PageHREF
  else
    Result := '';

end;

function TCurrentWebPageInfo.GetPageIsPublished: Boolean;
begin
  if WebPageInfo <> nil then
    Result := WebPageInfo.PageIsPublished
  else
    Result := False;
end;

function TCurrentWebPageInfo.GetLoginRequired: Boolean;
begin
  if WebPageInfo <> nil then
    Result := WebPageInfo.LoginRequired
  else
    Result := False;
end;

function TCurrentWebPageInfo.GetPageTitle: string;
begin
  if WebPageInfo <> nil then
    Result := WebPageInfo.PageTitle
  else
    Result := '';

end;

function TCurrentWebPageInfo.GetPageName: string;
begin
  if WebContext <> nil then
    Result := WebContext.DispatchedPageName
  else
    Result := '';
end;

function TCurrentWebPageInfo.WebPageInfo: IWebPageInfo;
var
  I: Integer;
begin
  Result := FWebPageInfo;
  if (Result = nil) and (WebContext <> nil) then
  begin
    for I := 0 to WebContext.PageCount - 1 do
    begin
      Result := WebContext.Pages[I];
      if Result.PageName = GetPageName then
        Exit;
    end;
    Result := nil;
  end;
end;

function TCurrentWebPageInfo.GetHasViewAccess: Boolean;
begin
  if WebPageInfo <> nil then
    Result := WebPageInfo.GetHasViewAccess
  else
    Result := True;
end;

{ TScriptError }

constructor TScriptError.Create(E: Exception);
begin
   inherited Create;
   FDescription := E.Message;
end;

function TScriptError.GetCharPos: Integer;
begin
  Result := FCharPos;
end;

function TScriptError.GetDescription: string;
begin
  Result := FDescription;
end;

function TScriptError.GetFileName: string;
begin
  Result := FFileName;
end;

function TScriptError.GetLine: Integer;
begin
  Result := FLine;
end;

function TScriptError.GetSourceLine: string;
begin
  Result := FSourceLine;
end;

procedure TScriptError.SetDescription(const AValue: string);
begin
  FDescription := AValue;
end;

{ TScriptErrors }

procedure TScriptErrors.Add(const AError: TAbstractScriptError);
begin
  FList.Add(AError);
end;

constructor TScriptErrors.Create;
begin
  inherited Create;
  FList := TObjectList.Create(True { Owned });
end;

function TScriptErrors.GetError(I: Integer): TAbstractScriptError;
begin
  Result := FList[I] as TAbstractScriptError;
end;

function TScriptErrors.GetErrorCount: Integer;
begin
  Result := FList.Count;
end;

destructor TScriptErrors.Destroy;
begin
  FList.Free;
  inherited;
end;

{ TAbstractScriptObjectFactory }

procedure TAbstractScriptObjectFactory.AddGlobalObjects(
  AScriptGlobalObjects: TScriptGlobalObjects);
var
  Context: IScriptContext;

  procedure Add(AVariable: TGlobalScriptVariables);
  begin
    with AScriptGlobalObjects do
      AddNamedIntf(GlobalScriptVariableNames[AVariable], CreateGlobalObject(AVariable, Producer));
  end;

var
  WebVariablesContainer: IWebVariablesContainer;
  I: Integer;
  V: TComponent;
  Intf: IInterface;
begin
  // Note: WebScriptAS overrides this function and adds the proper objects.
  with AScriptGlobalObjects do
  begin
    Context := Producer;
    AddNamedIntf(GlobalScriptVariableNames[svResponse], CreateProducerObject(svResponse, Producer));
    AddNamedIntf(GlobalScriptVariableNames[svProducer], CreateProducerObject(svProducer, Producer));
    AddNamedIntf(GlobalScriptVariableNames[svHTMLItems], CreateProducerObject(svHTMLItems, Producer));
    if Supports(Producer.WebModuleContext, IWebVariablesContainer, WebVariablesContainer) then
      for I := 0 to WebVariablesContainer.VariableCount - 1 do
      begin
        V := WebVariablesContainer.Variables[I];
        if Supports(V, IGetScriptObjectClassKey, Intf) then
          AddNamedIntf(V.Name, GetScriptEngine.CreateComponentStub(V));
      end;
  end;

  Add(svRequest);
  Add(svPage);
  Add(svModules);
  Add(svPages);
  Add(svApplication);
  Add(svEndUser);
  Add(svSession);
end;

{ TScriptCodeItem }

function TScriptCodeItem.GetScript: string;
begin
  Result := FScript;
end;

procedure TScriptCodeItem.AssignString(const AValue: string);
begin
  FScript := AValue;
end;

{ TScriptItem }

constructor TScriptItem.Create(AItems: TScriptItems);
begin
  inherited Create;
  FItems := AItems;
  FItems.Add(self);
end;

function TScriptItem.GetScript: string;
begin
  Assert(False);
end;

{ TScriptIncludeItem }

constructor TScriptIncludeItem.Create(AItems: TScriptItems; AIncludeFile: TScriptIncludeFile);
begin
  inherited Create(AItems);
  FScriptIncludeFile := AIncludeFile;
end;

function TScriptIncludeItem.GetScript: string;
begin
  Result := FScriptIncludeFile.Script;
end;

{ TScriptFile }

constructor TScriptFile.Create(AProducer: TScriptProducer);
begin
  FProducer := AProducer;
  FScriptItems := TScriptItems.Create(AProducer);
  FLineNumberMap := TLineNumberMap.Create;
  inherited Create;
end;

function TScriptFile.GetDestLineCount: Integer;
var
  I: Integer;
  P: PLineNumbers;
begin
  Result := 0;
  if FLineNumberMap.Count > 0 then
    with FLineNumberMap[FLineNumberMap.Count - 1]^ do
    begin
      Result := (DestStartLine - 1) + DestLineCount;
    end;
  for I := 0 to FLineNumberMap.Count - 1 do
  begin
    P := FLineNumberMap[I];
    if P.ScriptIncludeFile <> nil then
      Result := Result + P.ScriptIncludeFile.GetDestLineCount;
  end;
end;

destructor TScriptFile.Destroy;
begin
  inherited;
  FScriptItems.Free;
  if FStreamOwned then
    FSourceStream.Free;
  FLineNumberMap.Free;
end;

function TScriptFile.GetApplicationName: string;
var
  C: TComponent;
begin
  C := FProducer.GetComponent;
  if C <> nil then
    Result := C.Name
  else
    Result := '';
end;

function TScriptFile.GetLongName: string;
begin
  Result := GetApplicationName;
end;

function TScriptFile.GetScript: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to FScriptItems.Count - 1 do
    Result := Result + FScriptItems[I].Script;
end;

function TScriptFile.GetShortName: string;
begin
  Result := GetApplicationName;
end;

function TScriptFile.GetSource: string;
begin
  Result := '';
  if FSourceStream <> nil then
  begin
    SetLength(Result, FSourceStream.Size);
    FSourceStream.Seek(0, soBeginning);
    FSourceStream.ReadBuffer(Result[1], FSourceStream.Size)
  end;
end;

procedure TScriptFile.ParseStream(ASource: TStream; AOwned: Boolean);
  function NotBlank(P: PAnsiChar; L: Integer): Boolean;
  var
    I: Integer;
  begin
    for I := 0 to L - 1 do
      if not (P[I] in [' ', #13, #10]) then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;
type
  TScriptCmd = (cmdEcho, cmdNone);
var
  OutStream: TStringStream;
  ScriptSection: string;
  Parser: TCopyParser;
  TagToken: Boolean;
  ScriptLine: Integer;
  ScriptBlockLines: Integer;
  Encoding: TEncoding;

  procedure WriteHTML(ASourceStartLine, ASourceEndLine: Integer);
  var
    Item: THTMLItem;
  begin
    if NotBlank(PAnsiChar(OutStream.Memory), OutStream.Size) then
    begin
      Item := THTMLItem.Create(FProducer.FHTMLItems);
      Item.AssignString(0, PAnsiChar(OutStream.Memory), OutStream.Size, Encoding);
      Item.TagToken := TagToken;
      ScriptSection := ScriptSection +
        Format('%s.WriteItem(%d)'#13#10, [GlobalScriptVariableNames[svHTMLItems], Item.FIndex]);  // Do not localize
      OutStream.Size := 0;
      with FLineNumberMap.New^ do
      begin
        SourceStartLine := ASourceStartLine;
        SourceLineCount := ASourceEndLine;
        DestStartLine := ScriptLine;
        DestLineCount := 1;
      end;
      Inc(ScriptLine, 1);
    end
    else
      with FLineNumberMap.New^ do
      begin
        SourceStartLine := ASourceStartLine;
        SourceLineCount := ASourceEndLine;
        DestStartLine := ScriptLine;
        DestLineCount := 0;
      end;
    TagToken := False;
  end;

  procedure WriteScript;
  var
    Item: TScriptCodeItem;
  begin
    if (Trim(ScriptSection) <> '') then
    begin
      Item := TScriptCodeItem.Create(FScriptItems);
      try
        Item.AssignString(ScriptSection);
      except
        Item.Free;
        raise;
      end;
      ScriptSection := '';
    end;
  end;

  function IncludeTypeOfString(const AToken: string): TIncludeType;
  begin
    if SameText(AToken, 'file') then
      Result := incFile
    else if SameText(AToken, 'page') then
      Result := incPage
    else
    begin
      Assert(False);
      Result := incFile;
    end;
  end;

  procedure WriteIncludeFile(const AIncludeType, AFileName: string; ASourceStartLine, ASourceLineCount: Integer);
  var
    IncludeFile: TScriptIncludeFile;
  begin
    IncludeFile := TScriptIncludeFile.Create(FProducer, IncludeTypeOfString(AIncludeType), AFileName);
    TScriptIncludeItem.Create(FScriptItems, IncludeFile);
    IncludeFile.LoadFile;
    with FLineNumberMap.New^ do
    begin
      SourceStartLine := ASourceStartLine;
      SourceLineCount := ASourceLineCount;
      DestStartLine := ScriptLine;
      ScriptIncludeFile := IncludeFile;
    end;
  end;

  function ExtractIncludeFile(var AType, AFileName: AnsiString): Boolean;
  var
    InDblQuote: Boolean;
  begin
    InDblQuote := False;
    Result := False;
    with Parser do
    begin
      if (NextToken = '-') and
         (NextToken = '-') and
         (NextToken = '#') and
         (NextToken = toSymbol) and TokenSymbolIs('include') then
      begin
        // Have include file
        if (NextToken = toSymbol) and (TokenSymbolIs('file') or
           TokenSymbolIs('page')) then
        begin
          AType := TokenString;
          if NextToken = '=' then
          begin
            if NextToken = '"' then
            begin
              InDblQuote := True;
              NextToken;
            end;
            AFileName := '';
            while not (Token in [toEof, '"', '>']) do
            begin
              if Token = toSymbol then
                AFileName := AFileName + TokenString
              else
              begin
                if (not InDblQuote) and (Token in [' ', '-']) then
                begin
                  NextToken;
                  break;
                end;
                AFileName := AFileName + Token;  
              end;
              NextToken;
            end;
            if InDblQuote and (Token <> '"') then
              raise EScriptError.CreateFmt(sIncDblQuoteError,
                [Parser.SourceLine]);
            if Token <> '>' then
            begin
              CopyToToken('>');
              Result := True;
            end;
          end
          else
            raise EScriptError.CreateFmt(sIncEqualsError, [Parser.SourceLine]);
        end
        else if (Token = toSymbol) then
          raise EScriptError.CreateFmt(sIncTypeError,
            [Parser.SourceLine, TokenString]);
      end
    end;
  end;

  procedure TrimScriptBlock(ACmd: TScriptCmd; AScriptEnd: Integer; var AScriptBlock: AnsiString);
  var
    C: AnsiChar;
    I: Integer;
  begin
    for I := 1 to Length(AScriptBlock) do
    begin
      C := AScriptBlock[I];
      if not (C in [#13, #10]) then
        AScriptBlock[I] := ' ';
      if ACmd = cmdEcho then
      begin
        if C = '=' then break;
      end
      else  if C = '%' then break;
    end;
    if AScriptEnd > 0 then
    begin
      for I := Length(AScriptBlock) - (OutStream.Position - AScriptEnd) to Length(AScriptBlock) do
        if not (AScriptBlock[I] in [#13, #10]) then
          AScriptBlock[I] := ' ';
    end;
    if ACmd <> cmdEcho then
      AScriptBlock := AScriptBlock + AnsiString(#13#10);
  end;

var
  ScriptBlock: AnsiString;
  Cmd: TScriptCmd;
  RawIncludeFileName: AnsiString;
  RawIncludeType: AnsiString;
  SavePos: Integer;
  SaveSize: Int64;
  ScriptEnd: Integer;
  SaveScriptSourceLine: Integer;
  SaveHTMLSourceLine: Integer;
  SignatureSize: Integer;
begin
  Assert(FSourceStream = nil);  // Only expect to process one stream
  FStreamOwned := AOwned;
  FSourceStream := ASource;

  ScriptSection := '';
  ScriptLine := 1;
  SaveHTMLSourceLine := 1;
  Encoding := GetEncodingOfStream(ASource, SignatureSize);
  ASource.Position := SignatureSize;
  OutStream := TStringStream.Create('', Encoding);
  try
    Parser := TCopyParser.Create(ASource, OutStream);
    with Parser do
    try
      CopyTokenToOutput;
      while True do
      begin
        while not (Token in [toEof, '<']) do
          NextToken;
        if Token = toEOF then Break;
        if Token = '<' then
        begin
          SavePos := OutStream.Position;
          SaveSize := OutStream.Size;
          SaveScriptSourceLine := Parser.SourceLine;
          if NextToken = '%' then
          begin
            try
              ScriptEnd := -1;
              if NextToken = '=' then
                Cmd := cmdEcho
              else
                Cmd := cmdNone;
              while True do
              begin
                if (NextToken = '%') then
                begin
                  ScriptEnd := OutStream.Position;
                  if (NextToken = '>') then
                    break;
                end;
                if Token = toEOF then
                begin
                  Assert(False, 'Expected %>');
                  break;
                end;
              end;
              SetString(ScriptBlock, PAnsiChar(OutStream.Memory) + SavePos-1, OutStream.Position - SavePos + 1);
              //ScriptBlock := Copy(PAnsiChar(OutStream.Memory), SavePos, OutStream.Position - SavePos + 1);
              ScriptBlockLines := Parser.SourceLine - SaveScriptSourceLine + 1;
              TrimScriptBlock(Cmd, ScriptEnd, ScriptBlock);
              case Cmd of
                cmdEcho:
                  begin
                    ScriptBlock := AnsiString('Response.Write(') + ScriptBlock + AnsiString(')'#13#10);
                  end;
                cmdNone: ;
              end;
              OutStream.Position := SavePos-1;
              OutStream.Size := SaveSize-1;
              WriteHTML(SaveHTMLSourceLine, SaveScriptSourceLine - SaveHTMLSourceLine);
              SaveHTMLSourceLine := Parser.SourceLine + 1;
              ScriptLine := ScriptLine + ScriptBlockLines;
              ScriptSection := ScriptSection + Encoding.GetString(BytesOf(ScriptBlock));;
            except
              on E: Exception do
                FProducer.HandleParserError(E);
            end;
            if Token = toEof then break;
            NextToken;
          end
          else if Token = '!' then
          begin
            try
              if ExtractIncludeFile(RawIncludeType, RawIncludeFileName) then
              begin
                OutStream.Position := SavePos-1;
                OutStream.Size := SaveSize-1;
                WriteHTML(SaveHTMLSourceLine, SaveScriptSourceLine - SaveHTMLSourceLine + 1);
                SaveHTMLSourceLine := Parser.SourceLine + 1;
                WriteScript;

                WriteIncludeFile(Encoding.GetString(BytesOf(RawIncludeType)),
                  Encoding.GetString(BytesOf(RawIncludeFileName)), SaveScriptSourceLine,
                  Parser.SourceLine - SaveScriptSourceLine + 1);
              end
            except
              on E: Exception do
                FProducer.HandleParserError(E);
            end;
            if Token = toEof then break;
            NextToken;
          end
          else if Token = '#' then
            TagToken := True;
        end
      end;
      WriteHTML(SaveHTMLSourceLine, Parser.SourceLine - SaveHTMLSourceLine + 1);
      WriteScript;
    finally
      Parser.Free;
    end;
  finally
    OutStream.Free;
  end;
end;

procedure TScriptFile.ParseString(const ASource: string);
var
  InStream: TStream;
begin
  InStream := TStringStream.Create(ASource, TEncoding.UTF8);
  ParseStream(InStream, True);
end;

{ TScriptItems }

constructor TScriptItems.Create(AProducer: TScriptProducer);
begin
  FProducer := AProducer;
  inherited Create;
end;

function TScriptItems.GetScriptItem(I: Integer): TScriptItem;
begin
  Result := inherited Items[I] as TScriptItem;
end;

{ TScriptIncludeFile }

constructor TScriptIncludeFile.Create(AProducer: TScriptProducer; AIncludeType: TIncludeType; const AFileName: string);
begin
  inherited Create(AProducer);
  FFileName := AFileName;
  FIncludeType := AIncludeType;
  FLineNumberMap.FFileName := FFileName;
  AProducer.FIncludeFiles.Add(Self);
end;

procedure TScriptIncludeFile.LoadFile;
begin
  case FIncludeType of
    incFile: LoadIncludeFile;
    incPage: LoadIncludePage;
  else
    Assert(False);
  end;
end;

procedure TScriptIncludeFile.LoadIncludeFile;
var
  S: TStream;
  Temp: string;
  Owned: Boolean;
  FindIncludeFile: IFindIncludeFile;
  FileFound: Boolean;
begin
  if not FLoaded then
  begin
    if FLoading then
      raise ERecursiveIncludeFile.CreateFmt(sRecursiveIncludeFile, [FFileName]);
    FLoading := True;
    S := nil;
    try
      try
        FileFound := False;
        if FProducer.FLocateFileService <> nil then
        begin
          S := FProducer.FLocateFileService.GetTemplateStream(FProducer.Component, FFileName, Owned);
          if S = nil then
          begin
            if Supports(FProducer.FLocateFileService, IFindIncludeFile, FindIncludeFile) then
            begin
              if FindIncludeFile.FindIncludeFile(FProducer.Component, FFileName, Temp) then
              begin
                FileFound := True;
                FFileName := Temp;
              end;
            end;
          end;
        end;
        if (S = nil) and (not FileFound) then
          if IDEFileManager <> nil then
          begin
            Temp := IDEFileManager.SearchFile(FFileName);
            if Temp <> '' then
              FFileName := Temp;
          end;
        if S = nil then
          if DesignerFileManager <> nil then
            S := DesignerFileManager.GetStream(FFileName, Owned);
        if S = nil then
        begin
          FFileName := QualifyFileName(FFileName);
          S := TFileStream.Create(FFileName, fmOpenRead or fmShareDenyNone);
          Owned := True;
        end;
      except
        if Owned then
          S.Free;
        raise;
      end;
      ParseStream(S, Owned);
    finally
      FLoaded := True;
      FLoading := False;
    end;
  end;
end;

procedure TScriptIncludeFile.LoadIncludePage;
var
  S: TStream;
  Owned: Boolean;
  PageComponent: TObject;
  IncludePage: IPageResult;
begin
  if not FLoaded then
  begin
    if not WebContext.FindPage(FFileName, [], PageComponent) then
      RaiseIncludePageNotFound(FFileName);
    if not Supports(PageComponent, IPageResult, IncludePage) then
      RaisePageDoesNotSupportInclusion(FFileName);
    S := IncludePage.IncludePage(FFileName, Owned);
    try
      ParseStream(S, Owned);
    finally
      FLoaded := True;
    end;
  end;
end;

{ TScriptIncludeFiles }

constructor TScriptIncludeFiles.Create(AProducer: TScriptProducer);
begin
  FProducer := AProducer;
  inherited Create;
end;

function TScriptIncludeFiles.GetScriptIncludeFile(
  I: Integer): TScriptIncludeFile;
begin
  Result := inherited Items[I] as TScriptIncludeFile;
end;

procedure TScriptProducer.WriteItem(Index: Integer);
var
  Item: THTMLItem;
begin
  Item := GetHTMLItem(Index);
  if Item.TagToken then
    Write(ReplaceTags(Item.GetHTML))
  else
    WritePChar(Item.GetPHTMLChar, Item.ItemLength);
end;

{ TLineNumberMap }

function TLineNumberMap.GetCount: Integer;
begin
  Result := Length(FArray);
end;

function TLineNumberMap.GetLineNumbers(I: Integer): PLineNumbers;
begin
  Result := @FArray[I];
end;

function TLineNumberMap.New: PLineNumbers;
begin
  SetLength(FArray, Length(FArray)+1);
  Result := Items[Count-1];
end;

function TLineNumberMap.DestLineToSourceLine(ALine: Integer; var AFileName: string): Integer;
var
  I: Integer;
  Item: PLineNumbers;
begin
  AFileName := QualifyFileName(FFileName);
  ALine := ALine + 1; // Make one based
  for I := 0 to Count - 1 do
  begin
    Item := Items[I];
    if (ALine >= Item.DestStartLine) and
      (Item.ScriptIncludeFile <> nil) and
      (ALine <= Item.DestStartLine + Item.ScriptIncludeFile.GetDestLineCount -1) then
    begin
      ALine := ALine - 1; // Make zero based
      Result := Item.SourceStartLine +
        Item.ScriptIncludeFile.FLineNumberMap.DestLineToSourceLine(ALine -
          Item.DestStartLine + 1, AFileName) - 1;
      Exit;
    end
    else if (ALine >= Item.DestStartLine) and
      (ALine <= Item.DestStartLine + Item.DestLineCount - 1) then
    begin
      Result := Item.SourceStartLine + ALine - Item.DestStartLine;
      Exit;
    end
    else if (ALine >= Item.DestStartLine + Item.DestLineCount) then
      if (I = Count-1) or (ALine < Items[I+1].DestStartLine) then
      begin
        Result := Item.SourceStartLine + Item.SourceLineCount +
          ALine - (Item.DestStartLine + Item.DestLineCount);
        Exit;
      end;
    if Item.ScriptIncludeFile <> nil then
      ALine := ALine - Item.ScriptIncludeFile.GetDestLineCount;
  end;
  Result := ALine;
end;

{ TScriptObjectFactories }

constructor TScriptObjectFactories.Create;
begin
  inherited Create;
  FObjectList := TObjectList.Create(True { owned });
end;

function TScriptObjectFactories.CreateGlobalObject(AVariable: TGlobalScriptVariables;
  AContext: IScriptContext): IInterface;
var
  I: Integer;
begin
  Result := nil;
  for I := Count - 1 downto 0 do
  begin
    Result := Factories[I].CreateGlobalObject(AVariable, AContext);
    if Result <> nil then
      exit;
  end;
end;

destructor TScriptObjectFactories.Destroy;
begin
  inherited;
  FObjectList.Free;
end;

function TScriptObjectFactories.GetCount: Integer;
begin
  Result := FObjectList.Count;
end;

function TScriptObjectFactories.GetFactory(
  I: Integer): TAbstractScriptObjectFactory;
begin
  Result := TAbstractScriptObjectFactory(FObjectList[I]);
end;

function TScriptObjectFactories.GetObjectList: TObjectList;
begin
  Result := FObjectList;
end;

{ TScriptEnginesList }

procedure TScriptEnginesList.AddEngine(AEngine: TAbstractScriptEngine);
begin
  FList.Add(AEngine);
end;

procedure TScriptEnginesList.RemoveEngine(AEngine: TAbstractScriptEngine);
begin
  FList.Remove(AEngine);
end;

procedure TScriptEnginesList.AddObjectFactory(
  AFactory: TAbstractScriptObjectFactory; const AEngineName: string);
var
  Engine: TAbstractScriptEngine;
begin
  Engine := Find(AEngineName);
  if Engine <> nil then
    Engine.AddObjectFactory(AFactory)
  else
    raise EScriptError.CreateFmt(sScriptEngineNotFound, [AEngineName]);
end;

constructor TScriptEnginesList.Create;
begin
  inherited Create;
  FList := TObjectList.Create(False { not owned });
end;

destructor TScriptEnginesList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TScriptEnginesList.Find(const AName: string): TAbstractScriptEngine;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if AnsiCompareText(Result.Name, AName) = 0 then
      Exit;
  end;
  Result := nil;
end;

function TScriptEnginesList.FindScriptProducerClass(
  const ALanguageName: string): TScriptProducerClass;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    if Items[I].SupportsLanguage(ALanguageName) then
    begin
      Result := Items[I].ScriptProducerClass;
      Exit;
    end;
  end;
  Result := nil;
end;

function TScriptEnginesList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TScriptEnginesList.GetItem(I: Integer): TAbstractScriptEngine;
begin
  Result := TAbstractScriptEngine(FList[I]);
end;

procedure TScriptEnginesList.ListLanguageNames(AList: TStrings);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].ListLanguageNames(AList);
end;

{ TAbstractScriptEngine }

procedure TAbstractScriptEngine.AddObjectFactory(
  AFactory: TAbstractScriptObjectFactory);
begin
  FScriptObjectFactories.ObjectList.Add(AFactory);
end;

constructor TAbstractScriptEngine.Create(const AName: string);
begin
  FName := AName;
  if ScriptEnginesList = nil then
    TScriptEnginesList.Create;
  (ScriptEnginesList as TScriptEnginesList).AddEngine(Self);
  FScriptObjectFactories := TScriptObjectFactories.Create;
end;

function TAbstractScriptEngine.CreateComponentStub(
  AObject: TObject): IInterface;
var
  GetIntf: IGetScriptObject;
  GetKeyIntf: IGetScriptObjectClassKey;
  I: Integer;
begin
  // This procedure is left in for backwards compatability with Kylix
  if Supports(AObject, IGetScriptObjectClassKey, GetKeyIntf) then
  begin
    for I := FScriptObjectFactories.Count - 1 downto 0 do
    begin
      Result := FScriptObjectFactories.Factories[I].CreateComponentObject(AObject,
        GetKeyIntf.GetScriptObjectClassKey);
      if Result <> nil then Exit;
    end;
    RaiseObjectDoesNotSupportScripting(AObject)
  end
  else if Supports(AObject, IGetScriptObject, GetIntf) then
    Result := GetIntf.GetScriptObject
  else
    RaiseObjectDoesNotSupportScripting(AObject)
end;

destructor TAbstractScriptEngine.Destroy;
begin
  FScriptObjectFactories.Free;
  if ScriptEnginesList <> nil then
  (ScriptEnginesList as TScriptEnginesList).RemoveEngine(Self);
  inherited;
end;

initialization
  if ScriptEnginesList = nil then
    TScriptEnginesList.Create;
finalization
  FreeAndNil(ScriptEnginesList);
end.
