{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Web server application components               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WebScriptAS;

interface

uses System.SysUtils, System.Classes, System.Contnrs, Web.HTTPApp, Web.HTTPProd, AscrLib, Winapi.ActiveX, SiteComp,
  WebAuto, Web.WebCntxt, WebScript, WebSnapObjs;

type
  { Exception to look out for }
  EActiveScriptError = class(EWebBrokerException);

  ECannotCreateScriptEngine = class(EActiveScriptError)
  private
    FProgID: string;
    FHR: HRESULT;
  public
    constructor Create(const AProgID: string; AHR: HRESULT);
    property ProgID: string read FProgID;
    property HR: HRESULT read FHR;
  end;

  TActiveScriptGlobalObjects = class(TScriptGlobalObjects)
  protected
    function GetScriptEngine: TAbstractScriptEngine; override;
  end;

  TActiveScriptSite = class(TInterfacedObject, IActiveScriptSite)
  private
    FGlobalObjects: TActiveScriptGlobalObjects;
  protected
    { IActiveScriptSite }
    function  GetLCID(out plcid: LongWord): HResult; stdcall;
    function  GetItemInfo(pstrName: PWideChar; dwReturnMask: LongWord; out ppiunkItem: IUnknown;
                          out ppti: IUnknown): HResult; stdcall;
    function  GetDocVersionString(out pbstrVersion: WideString): HResult; stdcall;
    function  OnScriptTerminate(var pvarResult: OleVariant; var pexcepinfo: EXCEPINFO): HResult; stdcall;
    function  OnStateChange(ssScriptState: tagSCRIPTSTATE): HResult; stdcall;
    function  OnScriptError(const pscripterror: IActiveScriptError): HResult; stdcall;
    function  OnEnterScript: HResult; stdcall;
    function  OnLeaveScript: HResult; stdcall;
    property GlobalObjects: TActiveScriptGlobalObjects read FGlobalObjects;
  public
    procedure RunExpression(AScriptFile: TScriptFile;
      AEngine: IInterface); virtual;
    constructor Create(AProducer: IScriptProducer);
    destructor Destroy; override;
  end;

  TActiveScriptError = class(TScriptError)
  public
    constructor Create(const ScriptError: IActiveScriptError; ALineNumberMap: TLineNumberMap); overload;
  end;

  TActiveScriptProducer = class(TScriptProducer)
  protected
    function EvaluateExpression(AScriptFile: TScriptFile): string; override;
    function ImplHandleScriptError(const ScriptError: IUnknown): HRESULT; override;
  end;

  TActiveScriptSiteClass = class of TActiveScriptSite;

  TActiveScriptEngine = class(TAbstractScriptEngine)
  private
    FScriptSiteClass: TActiveScriptSiteClass;
  public
    constructor Create;
    function SupportsLanguage(const AName: string): Boolean; override;
    procedure ListLanguageNames(ANames: TStrings); override;
    property ScriptSiteClass: TActiveScriptSiteClass read FScriptSiteClass write FScriptSiteClass;
  end;

  TActiveScriptObjectFactory = class(TAbstractScriptObjectFactory)
  protected
    function GetScriptEngine: TAbstractScriptEngine; override;
    function CreateProducerObject(AVariable: TGlobalScriptVariables;
      AProducer: IScriptProducer): IInterface; override;
    function CreateComponentObject(AComponent: TObject; AClassKey: TClass): IInterface; override;
    procedure AddGlobalObjects(AScriptGlobalObjects: TScriptGlobalObjects);
      override;
  public
    function CreateGlobalObject(AVariable: TGlobalScriptVariables; AContext: IScriptContext): IInterface; override;
    constructor Create;
  end;
  
  TAbstractActiveScriptLanguages = class
  public
    function List: TStrings; virtual; abstract;
    constructor Create; virtual;
  end;

  TActiveScriptLanguagesClass = class of TAbstractActiveScriptLanguages;

var
  ActiveScriptEngine: TActiveScriptEngine;
  ActiveScriptLanguagesClass: TActiveScriptLanguagesClass;

const
  sActiveScriptEngine = 'ActiveScript'; { Do not localize }

implementation

uses Winapi.Windows, Web.CopyPrsr, Web.WebConst, WebComp, System.Variants, System.Win.ComObj, AutoAdap, AutoAdapAS,
  WebDisp, SiteConst;

procedure RaiseCannotCreateScriptEngine(const AProgID: string;
  HR: HRESULT);
begin
  raise ECannotCreateScriptEngine.Create(AProgID, HR);
end;

{ TActiveScriptSite }

constructor TActiveScriptSite.Create(AProducer: IScriptProducer);
begin
  inherited Create;
  FGlobalObjects := TActiveScriptGlobalObjects.Create(AProducer);
end;

destructor TActiveScriptSite.Destroy;
begin
  inherited;
  FGlobalObjects.Free;
end;

function TActiveScriptSite.GetDocVersionString(
  out pbstrVersion: WideString): HResult;
begin
  Result := E_NOTIMPL;
end;

function TActiveScriptSite.GetItemInfo(pstrName: PWideChar;
  dwReturnMask: LongWord; out ppiunkItem: IUnknown;
  out ppti: IUnknown): HResult;
begin

   if (dwReturnMask and SCRIPTINFO_IUNKNOWN) <> 0 then
   begin
     ppiunkItem := GlobalObjects.FindNamedItemIntf(pstrName);
     if ppiunkItem <> nil then
       Result := S_OK
     else
       Result := E_NOTIMPL;
     Exit;
   end
   else if (dwReturnMask and SCRIPTINFO_ITYPEINFO) <> 0 then
   begin
     Result := E_NOTIMPL;
     Exit;
   end;

   Result := TYPE_E_ELEMENTNOTFOUND;
end;

function TActiveScriptSite.GetLCID(out plcid: LongWord): HResult;
begin
  Result := E_NOTIMPL;
end;

function TActiveScriptSite.OnEnterScript: HResult;
begin
  result := S_OK;
end;

function TActiveScriptSite.OnLeaveScript: HResult;
begin
  result := S_OK;
end;

function TActiveScriptSite.OnScriptError(
  const pscripterror: IActiveScriptError): HResult;
begin
  Result := GlobalObjects.Producer.HandleScriptError(pscripterror);
end;

function TActiveScriptSite.OnScriptTerminate(var pvarResult: OleVariant;
  var pexcepinfo: ExcepInfo): HResult;
begin
  Result := S_OK;
end;

function TActiveScriptSite.OnStateChange(ssScriptState: tagSCRIPTSTATE): HResult;
begin
   case ssScriptState of
     SCRIPTSTATE_UNINITIALIZED:;
     SCRIPTSTATE_INITIALIZED:;
     SCRIPTSTATE_STARTED:;
     SCRIPTSTATE_CONNECTED:;
     SCRIPTSTATE_DISCONNECTED:;
     SCRIPTSTATE_CLOSED:;
   end;

   Result := S_OK;
end;

procedure TActiveScriptSite.RunExpression(AScriptFile: TScriptFile; AEngine: IInterface);
var
  hr: HRESULT;
{$IFDEF WIN64}
  Parser: IActiveScriptParse64;
{$ELSE}
  Parser: IActiveScriptParse;
{$ENDIF}
  I: Integer;
  ExcepInfo: TExcepInfo;
  Engine: IActiveScript;
  S: WideString;
begin

  Engine := AEngine as IActiveScript;

  //Now query for the IActiveScriptParse interface of the engine
{$IFDEF WIN64}
  hr := Engine.QueryInterface(IActiveScriptParse64, Parser);
{$ELSE}
  hr := Engine.QueryInterface(IActiveScriptParse, Parser);
{$ENDIF}
  OLECHECK(hr);

  //The engine needs to know the host it runs on.
  hr := Engine.SetScriptSite(Self);
  OLECHECK(hr);

  //Initialize the script engine so it's ready to run.
  hr := Parser.InitNew();
  OLECHECK(hr);

  for I := 0 to GlobalObjects.NamedItemCount - 1 do
    Engine.AddNamedItem(PWideChar(WideString(GlobalObjects.NamedItemName[I])), SCRIPTITEM_ISVISIBLE);

  S := AScriptFile.Script;
  hr := Parser.ParseScriptText(PWideChar(S), nil {sScriptMain}, nil, nil,
       0, 0, 0, { V1 }nil, ExcepInfo);
  // hr <> S_OK means that an error occured.  FErrors should
  // contain the error
  Assert((hr = S_OK) or (GlobalObjects.Producer.Errors.Count > 0), 'Errors expected');

  if hr = S_OK then
  begin
    hr := Engine.SetScriptState(SCRIPTSTATE_CONNECTED);
    // hr <> S_OK means that an error occured.  FErrors should
    // contain the error
    Assert((hr = S_OK) or (GlobalObjects.Producer.Errors.Count > 0), 'Errors expected');
  end;

end;

{ TActiveScriptObjectFactory }

function TActiveScriptObjectFactory.CreateGlobalObject(AVariable: TGlobalScriptVariables;
  AContext: IScriptContext): IInterface;
begin
  case AVariable of
    svPage:
      Result := TPageObj.Create(AContext, TCurrentWebPageInfo.Create(AContext));
    svPages:
      Result := CreateEnumeratedObject(TPagesObj.Create(AContext));
    svModules:
      Result := CreateEnumeratedObject(TModulesObj.Create);
    svApplication:
      Result := TApplicationObj.Create(AContext);
    svSession:
      Result := TSessionObj.Create;
    svEndUser:
      Result := TEndUserObj.Create(AContext);
    svResponse:
      Result := TResponseObj.Create(AContext as IScriptProducer);
    svRequest:
      Result := TRequestObj.Create(AContext);
    svHTMLItems:
      Result := THTMLItemsObj.Create(AContext as IScriptProducer);
    svProducer:
      Result := TProducerObj.Create(AContext as IScriptProducer);
  else
    Result := nil;
  end;
end;

function TActiveScriptObjectFactory.CreateProducerObject(AVariable: TGlobalScriptVariables; AProducer: IScriptProducer): IInterface;
begin
  // Nothing special needed
  Result := nil;
end;

constructor TActiveScriptObjectFactory.Create;
begin
  inherited Create;
  (ScriptEnginesList as TScriptEnginesList).AddObjectFactory(Self, sActiveScriptEngine);
end;

function TActiveScriptObjectFactory.GetScriptEngine: TAbstractScriptEngine;
begin
  Result := ActiveScriptEngine;
end;

function TActiveScriptObjectFactory.CreateComponentObject(AComponent: TObject;
  AClassKey: TClass): IInterface;
begin
  // Nothing needed  
end;

procedure TActiveScriptObjectFactory.AddGlobalObjects(
  AScriptGlobalObjects: TScriptGlobalObjects);
var
  Variables: TGlobalScriptVariables;
  WebVariablesContainer: IWebVariablesContainer;
  I: Integer;
  AComponent: TComponent;
begin
  for Variables := Low(TGlobalScriptVariables) to High(TGlobalScriptVariables) do
    AScriptGlobalObjects.AddNamedIntf(
      GlobalScriptVariableNames[Variables],
      CreateGlobalObject(Variables, AScriptGlobalObjects.Producer));

  if Supports(AScriptGlobalObjects.Producer.WebModuleContext,
    IWebVariablesContainer, WebVariablesContainer) then
  begin
    for I := 0 to WebVariablesContainer.VariableCount - 1 do
    begin
      AComponent := WebVariablesContainer.Variables[I];
      AScriptGlobalObjects.AddNamedIntf(AComponent.Name, TObjectScripter.DispatchOfObject(AComponent))
    end;
  end;
end;

{ TActiveScriptError }

constructor TActiveScriptError.Create(
  const ScriptError: IActiveScriptError; ALineNumberMap: TLineNumberMap);
var
  Context, Line: LongWord;
  CharPos: Integer;
  W: WideString;
  E: ExcepInfo;
begin
   if ScriptError.GetExceptionInfo(E) = S_OK then
     FDescription := E.bstrDescription;

   if ScriptError.GetSourcePosition(Context, Line, CharPos) = S_OK then
   begin
     FLine := ALineNumberMap.DestLineToSourceLine(Line, FFileName);
     FCharPos := CharPos;
   end;

   if ScriptError.GetSourceLineText(W) = S_OK then
     FSourceLine := W;
end;

{ TActiveScriptProducer }

function TActiveScriptProducer.EvaluateExpression(AScriptFile: TScriptFile): string;
var
  ClsID: TGUID;
  hr: HRESULT;
  Engine: IActiveScript;
{$IFDEF WIN64}
  Parser: IActiveScriptParse64;
{$ELSE}
  Parser: IActiveScriptParse;
{$ENDIF}
  ScriptSite: TActiveScriptSite;
  SaveScriptSite: IUnknown;
  ProgID: WideString;
  E: Exception;
begin
  ProgID := FScriptEngine;
  CLSIDFromProgID(PWideChar(ProgID), ClsID);

  // Call coinitialize on this thread
  if (CoInitFlags = -1) and (IsMultiThread) then
    CoInitFlags := COINIT_MULTITHREADED; // Required for multithreaded 
  if Assigned(System.Win.ComObj.CoInitializeEx) and (CoInitFlags <> -1) then
    System.Win.ComObj.CoInitializeEx(nil, CoInitFlags)
  else
    CoInitialize(nil);
  try
    hr := CoCreateInstance(ClsID, nil, CLSCTX_INPROC_SERVER,
        IActiveScript, Engine);
    if (FAILED(hr)) then
      RaiseCannotCreateScriptEngine(ProgID, hr);

    //Now query for the IActiveScriptParse interface of the engine
{$IFDEF WIN64}
    hr := Engine.QueryInterface(IActiveScriptParse64, Parser);
{$ELSE}
    hr := Engine.QueryInterface(IActiveScriptParse, Parser);
{$ENDIF}
    OLECHECK(hr);

    //The engine needs to know the host it runs on.
    if ActiveScriptEngine.ScriptSiteClass <> nil then
      ScriptSite := ActiveScriptEngine.ScriptSiteClass.Create(Self)
    else
      ScriptSite := TActiveScriptSite.Create(Self);
    SaveScriptSite := ScriptSite;
    ScriptSite.RunExpression(AScriptFile, Engine);
    hr := Engine.Close();
    OLECHECK(hr);

    if FErrors.Count > 0 then
    begin
      E := EScriptError.Create(FErrors, Content);
      FErrors := nil;
      raise E;
    end;
    Result := Content;
  finally
    // Clear all Interfaces before uninitializing
    Engine := nil;
    Parser := nil;
    SaveScriptSite := nil;
    CoUninitialize;
  end;
end;

function TActiveScriptProducer.ImplHandleScriptError(
  const ScriptError: IUnknown): HRESULT;
begin
  FErrors.Add(TActiveScriptError.Create(ScriptError as IActiveScriptError, FScriptFile.FLineNumberMap));
  Result := S_OK;
end;

{ ECannotCreateScriptEngine }

constructor ECannotCreateScriptEngine.Create(const AProgID: string;
  AHR: HRESULT);
begin
  FProgID := AProgID;
  FHR := AHR;
  inherited CreateFmt(sCannotCreateScriptEngine, [AProgID, HR]);
end;

{ TActiveScriptEngine }

constructor TActiveScriptEngine.Create;
begin
  inherited Create(sActiveScriptEngine);
  ScriptSiteClass := TActiveScriptSite;
  ScriptProducerClass := TActiveScriptProducer;
  TActiveScriptObjectFactory.Create;
end;

function TActiveScriptEngine.SupportsLanguage(const AName: string): Boolean;
var
  Languages: TAbstractActiveScriptLanguages;
begin
  if ActiveScriptLanguagesClass <> nil then
  begin
    Languages := ActiveScriptLanguagesClass.Create;
    try
      Result := Languages.List.IndexOf(AName) <> -1;
    finally
      Languages.Free;
    end;
  end
  else
    Result := True;
end;

procedure TActiveScriptEngine.ListLanguageNames(ANames: TStrings);
var
  Languages: TAbstractActiveScriptLanguages;
begin
  if ActiveScriptLanguagesClass <> nil then
  begin
    Languages := ActiveScriptLanguagesClass.Create;
    try
      ANames.AddStrings(Languages.List);
    finally
      Languages.Free;
    end;
  end;
end;

{ TAbstractActiveScriptLanguages }

constructor TAbstractActiveScriptLanguages.Create;
begin
  inherited;
end;

{ TActiveScriptGlobalObjects }

function TActiveScriptGlobalObjects.GetScriptEngine: TAbstractScriptEngine;
begin
  Result := ActiveScriptEngine;
end;

initialization
  ActiveScriptEngine := TActiveScriptEngine.Create;
finalization
  FreeAndNil(ActiveScriptEngine);
end.
