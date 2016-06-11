{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Net.HttpClient.Mac;

interface

implementation

uses
  System.Classes, System.Generics.Collections, System.SysUtils, System.Net.URLClient, System.NetConsts,
{$IF defined(IOS)}
  iOSapi.Foundation, iOSapi.CocoaTypes, iOSapi.Security,
{$ELSE}
  Macapi.Foundation, Macapi.CocoaTypes, Macapi.Security,
{$ENDIF !IOS}
  Macapi.ObjCRuntime, Macapi.Helpers, Macapi.ObjectiveC, Macapi.CoreFoundation, System.Net.HttpClient,
  System.DateUtils, System.NetEncoding;

type
  TMacCertList = TList<SecCertificateRef>;
  TMacIdentityList = TList<SecIdentityRef>;
  TMacHTTPRequest = class;
  TMacHTTPResponse = class;
  TMacConnectionDataDelegate = class;
  TDataTasks = class(TDictionary<NSURLConnection, TMacHTTPResponse>)
  public
    procedure AddTask(const AConnection: NSURLConnection; const AResponse: TMacHTTPResponse);
    function FindResponseData(const AConnection: NSURLConnection; var AResponse: TMacHTTPResponse): Boolean; inline;
    procedure FinishRequest(const AConnection: NSURLConnection; const AError: NSError);
  end;

  TMacHTTPClient = class(THTTPClient)
  private
    FDataTasks: TDataTasks;
    FDelegate: TMacConnectionDataDelegate;
  protected
    function DoExecuteRequest(const ARequest: THTTPRequest; var AResponse: THTTPResponse;
      const AContentStream: TStream): TMacHTTPClient.TExecutionResult; override;
    function DoSetCredential(AnAuthTargetType: TAuthTargetType; const ARequest: THTTPRequest;
      const ACredential: TCredentialsStorage.TCredential): Boolean; override;
    function DoGetHTTPRequestInstance(const AClient: THTTPClient; const ARequestMethod: string;
      const AURI: TURI): IHTTPRequest; override;
    function DoProcessStatus(const ARequest: IHTTPRequest; const  AResponse: IHTTPResponse): Boolean; override;
    function DoGetSSLCertificateFromServer(const ARequest: THTTPRequest): TCertificate; override;
    procedure DoServerCertificateAccepted(const ARequest: THTTPRequest); override;
    procedure DoGetClientCertificates(const ARequest: THTTPRequest; const ACertificateList: TList<TCertificate>); override;
    function DoClientCertificateAccepted(const ARequest: THTTPRequest; const AnIndex: Integer): Boolean; override;
    class function CreateInstance: TURLClient; override;

    function DoGetResponseInstance(const AContext: TObject; const AProc: TProc;
      const AsyncCallback: TAsyncCallback; const AsyncCallbackEvent: TAsyncCallbackEvent;
      const ARequest: IHTTPRequest; const AContentStream: TStream): IHTTPResponse; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TMacConnectionDataDelegate = class(TOCLocal, NSURLConnectionDelegate, NSURLConnectionDataDelegate)
  private
    [Weak] FDataTasks: TDataTasks;
    [Weak] FMacHTTPClient: TMacHTTPClient;
    procedure ExtractCertificateInfo(ACertificate: SecCertificateRef; var CertInfo: TCertificate);
{$If defined(IOS)}
    /// <summary>Import a client certificate from an stream that contains raw certificate data</summary>
    function ImportP12Certificate(var AIdentity: SecIdentityRef; var ACertificates: NSArray;
      const ARequest: TMacHTTPRequest): Boolean;
{$ELSE !IOS}
    /// <summary>Obtain from the keychain the certificates that match the issuer</summary>
    procedure FilterCertificates(const AIssuers: NSArray; const AMacCertList: TMacCertList;
      const ACertList: TCertificateList);
    /// <summary>For client certificate authentication challenge we need the certificate and the identity</summary>
    procedure GetKeychainIdentities(const AIdentityList: TMacIdentityList);
    /// <summary>Get the identity of the provied certificate. This is needed to create the
    /// NSURLCredential instance to reply to a client certificate authentication challenge</summary>
    function FindIdentityForCertificate(const AIdentityList: TMacIdentityList; ACertificate: SecCertificateRef): SecIdentityRef;
{$ENDIF}
  public
    constructor Create(const ADataTasks: TDataTasks; const AClient: TMacHTTPClient);
    function GetObjectID: Pointer;
    [MethodName('connection:didFailWithError:')]
    procedure connectionDidFailWithError(connection: NSURLConnection; didFailWithError: NSError); cdecl;
    function connectionShouldUseCredentialStorage(connection: NSURLConnection): Boolean; cdecl;
    [MethodName('connection:willSendRequestForAuthenticationChallenge:')]
    procedure connectionWillSendRequestForAuthenticationChallenge(connection: NSURLConnection;
      willSendRequestForAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    [MethodName('connection:canAuthenticateAgainstProtectionSpace:')]
    function connectionCanAuthenticateAgainstProtectionSpace(connection: NSURLConnection;
      canAuthenticateAgainstProtectionSpace: NSURLProtectionSpace): Boolean; cdecl;
    [MethodName('connection:didReceiveAuthenticationChallenge:')]
    procedure connectionDidReceiveAuthenticationChallenge(connection: NSURLConnection;
      didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    [MethodName('connection:didCancelAuthenticationChallenge:')]
    procedure connectionDidCancelAuthenticationChallenge(connection: NSURLConnection;
      didCancelAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    //////////////////////////////// NSURLConnectionDataDelegate ////////////////////////////////
    [MethodName('connection:willSendRequest:redirectResponse:')]
    function connectionWillSendRequestRedirectResponse(connection: NSURLConnection; willSendRequest: NSURLRequest;
      redirectResponse: NSURLResponse): NSURLRequest; cdecl;
    [MethodName('connection:didReceiveResponse:')]
    procedure connectionDidReceiveResponse(connection: NSURLConnection; didReceiveResponse: NSURLResponse); cdecl;
    [MethodName('connection:didReceiveData:')]
    procedure connectionDidReceiveData(connection: NSURLConnection; didReceiveData: NSData); cdecl;
    [MethodName('connection:needNewBodyStream:')]
    function connectionNeedNewBodyStream(connection: NSURLConnection; needNewBodyStream: NSURLRequest): NSInputStream; cdecl;
    [MethodName('connection:didSendBodyData:totalBytesWritten:totalBytesExpectedToWrite:')]
    procedure connectionDidSendBodyDataTotalBytesWrittenTotalBytesExpectedToWrite(connection: NSURLConnection;
      didSendBodyData: NSInteger; totalBytesWritten: NSInteger; totalBytesExpectedToWrite: NSInteger); cdecl;
    [MethodName('connection:willCacheResponse:')]
    function connectionWillCacheResponse(connection: NSURLConnection; willCacheResponse: NSCachedURLResponse)
      : NSCachedURLResponse; cdecl;
    procedure connectionDidFinishLoading(connection: NSURLConnection); cdecl;
  end;

  /// <summary> NSURLAuthenticationChallenge has a sender property that is a NSURLAuthenticationChallengeSender
  ///  *protocol*. We created an interface that has the same methods in order to use Wrap function with
  ///  sender value (Pointer) and call required methods. </summary>
  NSMacURLAuthenticationChallengeSenderClass = interface(NSObjectClass)
    ['{4DD25336-8AF7-495A-B380-F1DD9695961B}']
  end;
  NSMacURLAuthenticationChallengeSender = interface(NSObject)
    ['{44077E0E-15CC-4496-9123-D5577E84F6FF}']
    procedure useCredential(credential: NSURLCredential; forAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    procedure continueWithoutCredentialForAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure cancelAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure performDefaultHandlingForAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure rejectProtectionSpaceAndContinueWithChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
  end;
  TNSMacURLAuthenticationChallengeSender = class(TOCGenericImport<NSMacURLAuthenticationChallengeSenderClass, NSMacURLAuthenticationChallengeSender>) end;

  TMacHTTPRequest = class(THTTPRequest)
  private
    FRequest: NSMutableURLRequest;
    FRedirects: Integer;
    procedure RequestToNative;
  protected
    procedure DoPrepare; override;

    function GetHeaders: TNetHeaders; override;

    procedure AddHeader(const AName, AValue: string); override;
    function RemoveHeader(const AName: string): Boolean; override;

    function GetHeaderValue(const AName: string): string; override;
    procedure SetHeaderValue(const AName, Value: string); override;

    /// <summary> Setter for the ConnectionTimeout property.</summary>
    procedure SetConnectionTimeout(const Value: Integer); override;
    /// <summary> Setter for the ResponseTimeout property.</summary>
    procedure SetResponseTimeout(const Value: Integer); override;
  public
    constructor Create(const AClient: THTTPClient; const ARequestMethod: string; const AURI: TURI);
    destructor Destroy; override;
    function AddRedirect: Integer; inline;
    property Redirects: Integer read FRedirects;
  end;

  TMacHTTPResponse = class(THTTPResponse)
  private
    [Weak] FRequest: TMacHTTPRequest;
    FDone: Boolean;
    FError: NSError;
    FResponse: NSHTTPURLResponse;
    FReaded: Int64;
  protected
    procedure DoReadData(const AStream: TStream); override;

    function GetHeaders: TNetHeaders; override;
    function GetStatusCode: Integer; override;
    function GetStatusText: string; override;
    function GetVersion: THTTPProtocolVersion; override;
  public
    procedure CreateNativeData(const ANativeResponse: NSURLResponse);
    constructor Create(const AContext: TObject; const AProc: TProc; const AAsyncCallback: TAsyncCallback; const AAsyncCallbackEvent: TAsyncCallbackEvent;
      const ARequest: TMacHTTPRequest; const AContentStream: TStream);
    destructor Destroy; override;
  end;

procedure InternalWaitMessage(AInterval: Single);
var
  TimeoutDate: NSDate;
begin
  TimeoutDate := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceNow(AInterval));
  TNSRunLoop.Wrap(TNSRunLoop.OCClass.currentRunLoop).runMode(NSDefaultRunLoopMode, TimeoutDate);
  if TThread.CurrentThread.ThreadID <> MainThreadID then
    Sleep(Trunc(AInterval * 1000));
end;

{ TMacHTTPClient }

constructor TMacHTTPClient.Create;
begin
  inherited Initializer;
  FDataTasks := TDataTasks.Create;
  FDelegate := TMacConnectionDataDelegate.Create(FDataTasks, Self);
end;

destructor TMacHTTPClient.Destroy;
begin
  FDataTasks.Free;
  FDelegate.Free;
  inherited;
end;

class function TMacHTTPClient.CreateInstance: TURLClient;
begin
  Result := TMacHTTPClient.Create;
end;

function TMacHTTPClient.DoClientCertificateAccepted(const ARequest: THTTPRequest; const AnIndex: Integer): Boolean;
begin
  inherited;
  Result := True;
end;

function TMacHTTPClient.DoExecuteRequest(const ARequest: THTTPRequest; var AResponse: THTTPResponse;
  const AContentStream: TStream): TMacHTTPClient.TExecutionResult;
var
  LMacRequest: TMacHTTPRequest;
  LConnection: NSURLConnection;
  LResponse: TMacHTTPResponse;
begin
  LMacRequest := TMacHTTPRequest(ARequest);
  LConnection := TNSURLConnection.Wrap(TNSURLConnection.Alloc.initWithRequest(LMacRequest.FRequest,
    FDelegate.GetObjectID, True));
  LResponse := TMacHTTPResponse(AResponse);
  LResponse.FRequest := LMacRequest;
  FDataTasks.AddTask(LConnection, LResponse);
  while not LResponse.FDone do
    InternalWaitMessage(0.01);

  if LResponse.FError = nil then
    Result := TMacHTTPClient.TExecutionResult.Success
  else
    raise ENetHTTPClientException.CreateResFmt(@SNetHttpClientErrorAccessing, [LResponse.FError.code,
      LMacRequest.FURL.ToString, NSStrToStr(LResponse.FError.localizedDescription)]);
end;

procedure TMacHTTPClient.DoGetClientCertificates(const ARequest: THTTPRequest;
  const ACertificateList: TList<TCertificate>);
begin
                                                                 
end;

function TMacHTTPClient.DoGetHTTPRequestInstance(const AClient: THTTPClient; const ARequestMethod: string; const AURI: TURI): IHTTPRequest;
begin
  Result := TMacHTTPRequest.Create(AClient, ARequestMethod, AURI);
end;

function TMacHTTPClient.DoGetResponseInstance(const AContext: TObject; const AProc: TProc;
  const AsyncCallback: TAsyncCallback; const AsyncCallbackEvent: TAsyncCallbackEvent; const ARequest: IHTTPRequest;
  const AContentStream: TStream): IHTTPResponse;
begin
  Result := TMacHTTPResponse.Create(AContext, AProc, AsyncCallback, AsyncCallbackEvent, ARequest as TMacHttpRequest, AContentStream);
end;

function TMacHTTPClient.DoGetSSLCertificateFromServer(const ARequest: THTTPRequest): TCertificate;
begin
  Result := Default(TCertificate);
                                                                 
end;

function TMacHTTPClient.DoProcessStatus(const ARequest: IHTTPRequest; const AResponse: IHTTPResponse): Boolean;
begin
  Result := True;
end;

procedure TMacHTTPClient.DoServerCertificateAccepted(const ARequest: THTTPRequest);
begin
                                                                 
end;

function TMacHTTPClient.DoSetCredential(AnAuthTargetType: TAuthTargetType;
  const ARequest: THTTPRequest; const ACredential: TCredentialsStorage.TCredential): Boolean;
begin
  Result := False;
end;

{ TMacHTTPResponse }

constructor TMacHTTPResponse.Create(const AContext: TObject; const AProc: TProc; const AAsyncCallback: TAsyncCallback; const AAsyncCallbackEvent: TAsyncCallbackEvent;
      const ARequest: TMacHTTPRequest; const AContentStream: TStream);
begin
  inherited Create(AContext, AProc, AAsyncCallback, AAsyncCallbackEvent, ARequest as TMacHTTPRequest, AContentStream);
end;

procedure TMacHTTPResponse.CreateNativeData(const ANativeResponse: NSURLResponse);
begin
  FResponse := TNSHTTPURLResponse.Wrap((ANativeResponse as ILocalObject).GetObjectID);
  FResponse.retain;
end;

destructor TMacHTTPResponse.Destroy;
begin
  if FError <> nil then
  begin
    FError.release;
    FError := nil;
  end;

  if FResponse <> nil then
  begin
    FResponse.release;
    FResponse := nil;
  end;

  inherited;
end;

procedure TMacHTTPResponse.DoReadData(const AStream: TStream);
begin
  // Do nothing
end;

procedure KeyValueToNetHeaders(const AKeys: NSArray; const AValues: NSArray; var AHeaders: TNetHeaders);
var
  I, J: Integer;
  LName: string;
  LValue: string;
begin
  SetLength(AHeaders, AKeys.count);
  J := 0;
  for I := 0 to NativeInt(AKeys.count) - 1 do
  begin
    LName := NSStrToStr(TNSString.Wrap(AKeys.objectAtIndex(I)));
    LValue := NSStrToStr(TNSString.Wrap(AValues.objectAtIndex(I)));
    if not SameText(LName, 'Set-Cookie') then // do not localize
    begin
      AHeaders[J].Name := LName;
      AHeaders[J].Value := LValue;
      Inc(J);
    end;
  end;
  SetLength(AHeaders, J);
end;

function TMacHTTPResponse.GetHeaders: TNetHeaders;
var
  LAllCookies: NSArray;
  LNSCookie: NSHTTPCookie;
  LCookie: TCookie;
  I: Integer;
begin
  if Length(FHeaders) = 0 then
  begin
    LAllCookies := TNSHTTPCookie.OCClass.cookiesWithResponseHeaderFields(FResponse.allHeaderFields, FRequest.FRequest.URL);
    if LAllCookies.count > 0 then
      for I := 0 to LAllCookies.count - 1 do
      begin
        LNSCookie := TNSHTTPCookie.Wrap(LAllCookies.objectAtIndex(I));
        LCookie.Name := TNetEncoding.URL.Decode(NSStrToStr(LNSCookie.name), [TURLEncoding.TDecodeOption.PlusAsSpaces]);
        LCookie.Value := TNetEncoding.URL.Decode(NSStrToStr(LNSCookie.value), [TURLEncoding.TDecodeOption.PlusAsSpaces]);
        LCookie.Expires := NSDateToDateTime(LNSCookie.expiresDate);
        LCookie.Domain := NSStrToStr(LNSCookie.domain);
        if (LCookie.Domain <> '') and (LCookie.Domain.Chars[0] <> '.') then
          LCookie.Domain := '.' + LCookie.Domain;
        LCookie.Path := NSStrToStr(LNSCookie.path);
        LCookie.Secure := LNSCookie.isSecure;
        LCookie.HttpOnly := LNSCookie.isHTTPOnly;
        FCookies.Add(LCookie);
      end;

    KeyValueToNetHeaders(FResponse.allHeaderFields.allKeys, FResponse.allHeaderFields.allValues, FHeaders);
  end;
  Result := FHeaders;
end;

function TMacHTTPResponse.GetStatusCode: Integer;
begin
  Result := FResponse.statusCode;
end;

function TMacHTTPResponse.GetStatusText: string;
begin
  Result := NSStrToStr(TNSHTTPURLResponse.OCClass.localizedStringForStatusCode(FResponse.statusCode));
end;

function TMacHTTPResponse.GetVersion: THTTPProtocolVersion;
begin
  Result := THTTPProtocolVersion.HTTP_1_1;
end;

{ TMacHTTPRequest }

function TMacHTTPRequest.AddRedirect: Integer;
begin
  Inc(FRedirects);
  Result := FRedirects;
end;

constructor TMacHTTPRequest.Create(const AClient: THTTPClient; const ARequestMethod: string; const AURI: TURI);
begin
  inherited Create(AClient, ARequestMethod, AURI);
  FRequest := TNSMutableURLRequest.Create;
  FRequest.setTimeoutInterval(ResponseTimeout / 1000);
end;

destructor TMacHTTPRequest.Destroy;
begin
  FRequest.release;
  inherited;
end;

procedure TMacHTTPRequest.DoPrepare;
begin
  if FURL.Username <> '' then
    SetCredential(TCredentialsStorage.TCredential.Create(TAuthTargetType.Server, '', FURL.ToString,
      FURL.Username, FURL.Password));

  RequestToNative;
end;

procedure TMacHTTPRequest.AddHeader(const AName, AValue: string);
begin
  inherited;
  FRequest.addValue(StrToNSStr(AValue), StrToNSStr(AName));
end;

function TMacHTTPRequest.GetHeaders: TNetHeaders;
begin
  Result := [];
  if (FRequest.allHTTPHeaderFields <> nil) and (FRequest.allHTTPHeaderFields.allValues <> nil) and
     (FRequest.allHTTPHeaderFields.allValues.count > 0) then
    KeyValueToNetHeaders(FRequest.allHTTPHeaderFields.allKeys, FRequest.allHTTPHeaderFields.allValues, Result)
end;

function TMacHTTPRequest.GetHeaderValue(const AName: string): string;
begin
  Result := NSStrToStr(FRequest.valueForHTTPHeaderField(StrToNSStr(AName)));
end;

function TMacHTTPRequest.RemoveHeader(const AName: string): Boolean;
begin
  FRequest.setValue(nil, StrToNSStr(AName));
  Result := True;
end;

procedure TMacHTTPRequest.RequestToNative;

  function GetParams(const AURI: TURI): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to Length(AURI.Params) - 1 do
      Result := Result + AURI.Params[I].Name + '=' + AURI.Params[I].Value + '&';
    Result := Result.Substring(0, Result.Length - 1); //Remove last '&'
  end;

  function GetURLString(const AURI: TURI): NSString;
  var
    URLText: string;
  begin
    URLText := AURI.Scheme + '://' + AURI.Host;
    if ((AURI.Port <> -1) and (AURI.Port <> 0)) and
       ((AURI.Scheme.Equals('http') and (AURI.Port <> 80)) or (AURI.Scheme.Equals('https') and (AURI.Port <> 443))) then
      URLText := URLText + ':' + AURI.Port.ToString;

    if AURI.Path = '' then
      URLText := URLText + '/'
    else
      URLText := URLText + AURI.Path;

    if AURI.Query <> '' then
      URLText := URLText + '?' + AURI.Query;

    Result := StrToNSStr(URLText);
  end;

var
  LBody: NSData;
  LBytes: TBytes;
begin
  FRequest.setHTTPMethod(StrToNSStr(FMethodString));
  FRequest.setURL(TNSURL.Wrap(TNSURL.OCClass.URLWithString(GetURLString(FURL))));
  FRequest.setHTTPShouldHandleCookies(False);
  if FSourceStream <> nil then
  begin
    SetLength(LBytes, FSourceStream.Size);
    FSourceStream.Position := 0;
    FSourceStream.Read(LBytes, FSourceStream.Size);
    if Length(LBytes) > 0 then
    begin
      LBody := TNSData.Wrap(TNSData.OCClass.dataWithBytes(@LBytes[0], Length(LBytes)));
      FRequest.setHTTPBody(LBody);
    end;
  end;
end;

procedure TMacHTTPRequest.SetConnectionTimeout(const Value: Integer);
begin
  inherited;
  // Not Available in MacOS/iOS. The Connection Timeout has no effect...
end;

procedure TMacHTTPRequest.SetHeaderValue(const AName, Value: string);
begin
  FRequest.setValue(StrToNSStr(Value), StrToNSStr(AName));
end;

procedure TMacHTTPRequest.SetResponseTimeout(const Value: Integer);
begin
  inherited;
  FRequest.setTimeoutInterval(Value / 1000);
end;

{ TMacConnectionDataDelegate }

function TMacConnectionDataDelegate.connectionCanAuthenticateAgainstProtectionSpace(connection: NSURLConnection;
  canAuthenticateAgainstProtectionSpace: NSURLProtectionSpace): Boolean;
begin
  { For debug purposes only, authentication implemented in connectionWillSendRequestForAuthenticationChallenge }
  Result := False;
end;

procedure TMacConnectionDataDelegate.connectionDidCancelAuthenticationChallenge(connection: NSURLConnection;
  didCancelAuthenticationChallenge: NSURLAuthenticationChallenge);
begin
  { For debug purposes only, authentication implemented in connectionWillSendRequestForAuthenticationChallenge }
end;

procedure TMacConnectionDataDelegate.connectionDidFailWithError(connection: NSURLConnection; didFailWithError: NSError);
begin
  FDataTasks.FinishRequest(connection, didFailWithError);
end;

procedure TMacConnectionDataDelegate.connectionDidFinishLoading(connection: NSURLConnection);
begin
  FDataTasks.FinishRequest(connection, nil);
end;

procedure TMacConnectionDataDelegate.connectionDidReceiveAuthenticationChallenge(connection: NSURLConnection;
  didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge);
begin
  { For debug purposes only, authentication implemented in connectionWillSendRequestForAuthenticationChallenge }
end;

procedure TMacConnectionDataDelegate.connectionDidReceiveData(connection: NSURLConnection; didReceiveData: NSData);
var
  LResponseData: TMacHTTPResponse;
  LAbort: Boolean;
begin
  if FDataTasks.FindResponseData(connection, LResponseData) then
  begin
    LAbort := False;
    LResponseData.FReaded := LResponseData.FReaded + didReceiveData.length;
     LResponseData.FRequest.DoReceiveDataProgress(LResponseData.GetStatusCode, LResponseData.GetContentLength,
      LResponseData.FReaded, LAbort);
    if LAbort then
    begin
      connection.cancel;
      FDataTasks.FinishRequest(connection, nil);
    end
    else
      LResponseData.FStream.Write(didReceiveData.bytes^, didReceiveData.length);
  end
  else
    raise ENetHTTPClientException.Create(SNetHttpClientResponseError);
end;

procedure TMacConnectionDataDelegate.connectionDidReceiveResponse(connection: NSURLConnection;
  didReceiveResponse: NSURLResponse);
var
  LResponseData: TMacHTTPResponse;
  LAbort: Boolean;
begin
  if FDataTasks.FindResponseData(connection, LResponseData) then
  begin
    LResponseData.CreateNativeData(didReceiveResponse);
    LAbort := False;
    LResponseData.FRequest.DoReceiveDataProgress(LResponseData.GetStatusCode, LResponseData.GetContentLength, 0, LAbort);
    if LAbort then
    begin
      connection.cancel;
      FDataTasks.FinishRequest(connection, nil);
    end;
  end
  else
    raise ENetHTTPClientException.Create(SNetHttpClientResponseError);
end;

procedure TMacConnectionDataDelegate.connectionDidSendBodyDataTotalBytesWrittenTotalBytesExpectedToWrite(
  connection: NSURLConnection; didSendBodyData, totalBytesWritten, totalBytesExpectedToWrite: NSInteger);
begin
  { For debug purposes only }
end;

function TMacConnectionDataDelegate.connectionNeedNewBodyStream(connection: NSURLConnection;
  needNewBodyStream: NSURLRequest): NSInputStream;
begin
  { For debug purposes only }
end;

function TMacConnectionDataDelegate.connectionShouldUseCredentialStorage(connection: NSURLConnection): Boolean;
begin
  Result := True;
end;

function TMacConnectionDataDelegate.connectionWillCacheResponse(connection: NSURLConnection;
  willCacheResponse: NSCachedURLResponse): NSCachedURLResponse;
begin
  Result := nil;
end;

function CFStringRefToString(const Value: CFStringRef; Release: Boolean = False): string;
var
  Range: CFRange;
  Tmp: TCharArray;
begin
  if Value = nil then Exit('');
  try
    Range := CFRangeMake(0, CFStringGetLength(Value));
    if Range.Length > 0 then
    begin
      SetLength(Tmp, Range.Length);
      CFStringGetCharacters(Value, Range, MarshaledString(Tmp));
      Result := string.Create(Tmp);
    end
    else
      Result := EmptyStr;
  finally
    if Release then
      CFRelease(Value);
  end;
end;

procedure TMacConnectionDataDelegate.ExtractCertificateInfo(ACertificate: SecCertificateRef; var CertInfo: TCertificate);
{$IF defined(IOS)}
var
  LCertSummary: CFStringRef;
  LData: string;
begin
  LCertSummary := SecCertificateCopySubjectSummary(ACertificate);
  LData := CFStringRefToString(LCertSummary, True);
  CertInfo.Subject := LData;
  CertInfo.Issuer := LData;
end;
{$ELSE !MACOS}
  procedure DictInfoToString(const ADict: NSDictionary);
  var
    I: Integer;
    LAllKeys: NSArray;
    LDataDict: NSDictionary;
    LValue: NSString;
    LocalValue: string;
    LArrayValues: NSArray;
    LValuesDict: NSDictionary;
    J: Integer;
    LDateValue: NSDate;
  const
    kIssuer = 'Issuer Name'; // Do not translate
    kSubjectName = 'Subject Name';
    kExpires = 'Expires';
  begin
    LAllKeys := ADict.allKeys;
    for I := 0 to LAllKeys.count - 1 do
    begin
      LValue := TNSString.Wrap(ADict.AllKeys.objectAtIndex(I));
      LDataDict := TNSDictionary.Wrap(ADict.allValues.objectAtIndex(I));

      LValue := TNSString.Wrap(LDataDict.valueForKey(kSecPropertyKeyLabel));
      LocalValue := NSStrToStr(LValue);
      if (CompareText(LocalValue, kIssuer) = 0) or (CompareText(LocalValue, kSubjectName) = 0) then
      begin
        CertInfo.Subject := NSStrToStr(LValue) + ';';
        LArrayValues := TNSArray.Wrap(LDataDict.valueForKey(kSecPropertyKeyValue));
        if LArrayValues.count > 0 then
        begin
          for J := 0 to LArrayValues.count - 1 do
          begin
            LValuesDict := TNSDictionary.Wrap(LArrayValues.objectAtIndex(J));
            LValue := TNSString.Wrap(LValuesDict.valueForKey(kSecPropertyKeyValue));
            CertInfo.Subject := CertInfo.Subject + NSSTrToStr(LValue) + ';';
          end;
        end;
      end
      else
        if CompareText(LocalValue, kExpires) = 0 then
        begin
          LDateValue := TNSDate.Wrap(LDataDict.valueForKey(kSecPropertyKeyValue));
          CertInfo.Expiry := UnixToDateTime(trunc(LDateValue.timeIntervalSince1970));
        end;
    end;
  end;

var
  LError: CFErrorRef;
  LCFCertData: CFDictionaryRef;
  LDict: NSDictionary;
begin
  LError := nil;
  LCFCertData := SecCertificateCopyValues(ACertificate, nil, LError);
  try
    LDict := TNSDictionary.Wrap(LCFCertData);
    DictInfoToString(LDict);
  finally
    CFRelease(LCFCertData);
  end;
end;
{$ENDIF}

{$If defined(MACOS) and not defined(IOS)}
procedure TMacConnectionDataDelegate.GetKeychainIdentities(const AIdentityList: TMacIdentityList);
var
  LIdentDict: NSMutableDictionary;
  LRes: OSStatus;
  I: Integer;
  LIdents: Pointer;
  LAllIdents: NSArray;
begin
  LIdentDict := TNSMutableDictionary.Create;
  try
    LIdentDict.setValue((kSecClassIdentity as ILocalObject).GetObjectID, kSecClass);
    LIdentDict.setValue(kCFBooleanTrue, kSecReturnRef);
    LIdentDict.setValue((kSecMatchLimitAll as ILocalObject).GetObjectID, KSecMatchLimit);
    LIdents := nil;
    LRes := SecItemCopyMatching((LIdentDict as ILocalObject).GetObjectID, @LIdents);
    if (LRes <> errSecSuccess) then
      raise ENetHTTPCertificateException.CreateRes(@SNetHttpIdentitiesError);

    LAllIdents := TNSArray.Wrap(LIdents);
    if LAllIdents.count > 0 then
      for I := 0 to LAllIdents.count - 1 do
        AIdentityList.Add(LAllIdents.objectAtIndex(I));

  finally
    LIdentDict.release;
  end;
end;

procedure TMacConnectionDataDelegate.FilterCertificates(const AIssuers: NSArray; const AMacCertList: TMacCertList;
  const ACertList: TCertificateList);
var
  LDict: NSMutableDictionary;
  LRes: OSStatus;
  LCerts: Pointer;
  LAllCerts: NSArray;
  I: Integer;
  LCert: SecCertificateRef;
  LCertInfo: TCertificate;
begin
  LDict := TNSMutableDictionary.Create;
  try
    LDict.setValue((kSecClassCertificate as ILocalObject).GetObjectID, kSecClass);
    LDict.setValue(kCFBooleanTrue, kSecReturnRef);
    if AIssuers.count > 0 then
      LDict.setValue(AIssuers.objectAtIndex(0), kSecAttrIssuer);
    LDict.setValue(kCFBooleanFalse, kSecMatchTrustedOnly);
    LDict.setValue(kCFBooleanTrue, kSecMatchCaseInsensitive);
    LDict.setValue((kSecMatchLimitAll as ILocalObject).GetObjectID, KSecMatchLimit);

    LCerts := nil;
    LRes := SecItemCopyMatching((LDict as ILocalObject).GetObjectID, @LCerts);
    if (LRes <> errSecSuccess) and (LRes <> errSecItemNotFound) then
      raise ENetHTTPCertificateException.CreateRes(@SNetHttpCertificatesError);

    LAllCerts := TNSArray.Wrap(LCerts);
    if LAllCerts.count > 0 then
    begin
      for I := 0 to LAllCerts.count - 1 do
      begin
        LCert := LAllCerts.objectAtIndex(I);
        ExtractCertificateInfo(LCert, LCertInfo);
        AMacCertList.Add(LCert);
        ACertList.Add(LCertInfo);
      end;
    end;

  finally
    LDict.release;
  end;
end;

function TMacConnectionDataDelegate.FindIdentityForCertificate(const AIdentityList: TMacIdentityList;
  ACertificate: SecCertificateRef): SecIdentityRef;
var
  LNewCert: SecCertificateRef;
  I: Integer;
  LRes: OSStatus;
begin
  LNewCert := nil;
  for I := 0 to AIdentityList.Count - 1 do
  begin
    LRes := SecIdentityCopyCertificate(AIdentityList[I], @LNewCert);
    try
      if (LRes = errSecSuccess) and (LNewCert = ACertificate) then
         Exit(AIdentityList[I]);
    finally
      CFRelease(LNewCert);
    end;
  end;
  Result := nil;
end;
{$ENDIF}

{$If defined(IOS)}
function TMacConnectionDataDelegate.ImportP12Certificate(var AIdentity: SecIdentityRef; var ACertificates: NSArray;
  const ARequest: TMacHTTPRequest): Boolean;
var
  LCertData: NSData;
  LDict: NSMutableDictionary;
  LPassword: NSString;
  LImported: Pointer;
  LImportedData: NSArray;
  LRes: OSStatus;
  LIdentityDict: NSDictionary;
  LCert: SecCertificateRef;
  LRawCert: TBytes;
begin
  Result := False;
  if ARequest.FClientCertificate <> nil then
  begin
    SetLength(LRawCert, ARequest.FClientCertificate.Size);
    ARequest.FClientCertificate.Position := 0;
    ARequest.FClientCertificate.Read(LRawCert, Length(LRawCert));
    LCertData := TNSData.Wrap(TNSData.OCClass.dataWithBytes(@LRawCert[0], Length(LRawCert)));
    LDict := TNSMutableDictionary.Create;
    try
      LPassword := StrToNSStr(ARequest.FClientCertPassword);
      LDict.setValue((LPassword as ILocalObject).GetObjectID, kSecImportExportPassphrase);
      LRes := SecPKCS12Import((LCertData as ILocalObject).GetObjectID, (LDict as ILocalObject).GetObjectID, @LImported);
      if LRes <> errSecSuccess then
        raise ENetHTTPCertificateException.CreateRes(@SNetHttpCertificateImportError);
      LImportedData := TNSArray.Wrap(LImported);
      LIdentityDict := TNSDictionary.Wrap(LImportedData.objectAtIndex(0));
      AIdentity := LIdentityDict.valueForKey(kSecImportItemIdentity);
      LRes := SecIdentityCopyCertificate(AIdentity, @LCert);
      if LRes <> errSecSuccess then
        raise ENetHTTPCertificateException.CreateRes(@SNetHttpCertificateImportError);

      ACertificates := TNSArray.Wrap(TNSArray.OCClass.arrayWithObject(LCert));
      Result := True;

    finally
      LDict.release;
    end;
  end;
end;
{$ENDIF !IOS}


procedure TMacConnectionDataDelegate.connectionWillSendRequestForAuthenticationChallenge(connection: NSURLConnection;
  willSendRequestForAuthenticationChallenge: NSURLAuthenticationChallenge);
var
  LProtSpace: NSURLProtectionSpace;
  LAuthMethod: NSString;
  LSender: NSMacURLAuthenticationChallengeSender;
  LCredentials: TCredentialsStorage.TCredentialArray;
  LResponse: TMacHTTPResponse;
  LNewCredential: NSURLCredential;
  LAuthType: TAuthTargetType;
  LUserName: string;
  LPassword: string;
  LAbortAuth: Boolean;
  LPersistence: TAuthPersistenceType;
  LAccepted: Boolean;
  LCertificate: TCertificate;
  LIndex: Integer;
  LCertRef: SecCertificateRef;
{$If defined(MACOS) and not Defined(IOS)}
  LMacCertList: TMacCertList;
  LCertList: TCertificateList;
  LIdentityList: TMacIdentityList;
  LClientCertIndex: Integer;
{$ENDIF}
  LIdentity: SecIdentityRef;
  LCertArray: NSArray;
begin
  if not FDataTasks.FindResponseData(connection, LResponse) then
    raise ENetHTTPClientException.Create(SNetHttpClientResponseError);

  LSender := TNSMacURLAuthenticationChallengeSender.Wrap(willSendRequestForAuthenticationChallenge.sender);
  LProtSpace := willSendRequestForAuthenticationChallenge.protectionSpace;
  LAuthMethod := LProtSpace.authenticationMethod;
  if LAuthMethod.isEqualToString(NSURLAuthenticationMethodHTTPBasic) or
     LAuthMethod.isEqualToString(NSURLAuthenticationMethodHTTPDigest) or
     LAuthMethod.isEqualToString(NSURLAuthenticationMethodNTLM) then
  begin
    if not LProtSpace.isProxy then
    begin
      if LResponse.FRequest.GetCredential.UserName <> '' then
      begin
        SetLength(LCredentials, 1);
        LCredentials[0] := TCredentialsStorage.TCredential.Create(TAuthTargetType.Server,
          NSStrToStr(LProtSpace.realm), LResponse.FRequest.FURL.ToString, LResponse.FRequest.GetCredential.UserName,
          LResponse.FRequest.GetCredential.Password);
      end
      else
        LCredentials := FMacHTTPClient.GetCredentials(TAuthTargetType.Server,
          NSStrToStr(LProtSpace.realm), LResponse.FRequest.FURL.ToString);
    end
    else
      LCredentials := FMacHTTPClient.GetCredentials(TAuthTargetType.Proxy, NSStrToStr(LProtSpace.realm), '');

    if Length(LCredentials) = 0 then
    begin
      if LProtSpace.isProxy then
        LAuthType := TAuthTargetType.Proxy
      else
        LAuthType := TAuthTargetType.Server;
      LUserName := '';
      LAbortAuth := False;
      FMacHTTPClient.DoAuthCallback(LAuthType, NSStrToStr(LProtSpace.realm), LResponse.FRequest.FURL.ToString,
          LUserName, LPassword, LAbortAuth, LPersistence);
      if LAbortAuth or (LUserName = '') then
      begin
        LSender.rejectProtectionSpaceAndContinueWithChallenge(willSendRequestForAuthenticationChallenge);
        Exit;
      end
      else
      begin
        SetLength(LCredentials, 1);
        LCredentials[0] := TCredentialsStorage.TCredential.Create(LAuthType, NSStrToStr(LProtSpace.realm),
          LResponse.FRequest.FURL.ToString, LUserName, LPassword);
      end;
    end;

    LIndex := willSendRequestForAuthenticationChallenge.previousFailureCount;
    if (Length(LCredentials) > 0) and (LIndex < Length(LCredentials)) then
    begin
      LNewCredential := TNSURLCredential.Wrap(TNSURLCredential.OCClass.credentialWithUser(
        StrToNSStr(LCredentials[0].UserName), StrToNSStr(LCredentials[0].Password), NSURLCredentialPersistenceForSession));
      LSender.useCredential(LNewCredential, willSendRequestForAuthenticationChallenge);
    end
    else
      LSender.rejectProtectionSpaceAndContinueWithChallenge(willSendRequestForAuthenticationChallenge);
  end
  else
  begin
    if LAuthMethod.isEqualToString(NSURLAuthenticationMethodServerTrust) then
    begin
      LAccepted := True;
      if SecTrustGetCertificateCount(LProtSpace.serverTrust) > 0 then
      begin
        LCertRef := SecTrustGetCertificateAtIndex(LProtSpace.serverTrust, 0);
        ExtractCertificateInfo(LCertRef, LCertificate);

        if Assigned(FMacHTTPClient.FValidateServerCertificateCallback) then
          FMacHTTPClient.FValidateServerCertificateCallback(FMacHTTPClient, LResponse.FRequest, LCertificate, LAccepted)
        else if Assigned(FMacHTTPClient.FValidateServerCertificateEvent) then
          FMacHTTPClient.FValidateServerCertificateEvent(FMacHTTPClient, LResponse.FRequest, LCertificate, LAccepted);

        if LAccepted then
        begin
          LNewCredential := TNSURLCredential.Wrap(TNSURLCredential.OCClass.credentialForTrust(LProtSpace.serverTrust));
          LSender.useCredential(LNewCredential, willSendRequestForAuthenticationChallenge);
        end
        else
          LSender.cancelAuthenticationChallenge(willSendRequestForAuthenticationChallenge);
      end
      else
        LSender.cancelAuthenticationChallenge(willSendRequestForAuthenticationChallenge);
    end
    else
    begin
      if LAuthMethod.isEqualToString(NSURLAuthenticationMethodClientCertificate) then
      begin
{$IF defined(IOS)}
        if ImportP12Certificate(LIdentity, LCertArray, LResponse.FRequest) then
        begin
          try
            LNewCredential := TNSURLCredential.Wrap(TNSURLCredential.OCClass.credentialWithIdentity(LIdentity, LCertArray, 1));
            LSender.useCredential(LNewCredential, willSendRequestForAuthenticationChallenge);
          finally
            CFRelease(LCertArray.objectAtIndex(0));
          end;
        end
        else
          LSender.cancelAuthenticationChallenge(willSendRequestForAuthenticationChallenge);
{$ELSE}
        LMacCertList := TMacCertList.Create;
        LCertList := TCertificateList.Create;
        LIdentityList := TMacIdentityList.Create;
        try
          if Assigned(FMacHTTPClient.FNeedClientCertificateCallback) or Assigned(FMacHTTPClient.FNeedClientCertificateEvent) then
          begin
            LClientCertIndex := -1;
            FilterCertificates(LProtSpace.distinguishedNames, LMacCertList, LCertList);
            GetKeyChainIdentities(LIdentityList);

            if Assigned(FMacHTTPClient.FNeedClientCertificateCallback) then
              FMacHTTPClient.FNeedClientCertificateCallback(Self, LResponse.FRequest, LCertList, LClientCertIndex)
            else
              FMacHTTPClient.FNeedClientCertificateEvent(Self, LResponse.FRequest, LCertList, LClientCertIndex);

            if LClientCertIndex >= 0 then
            begin
              LIdentity := FindIdentityForCertificate(LIdentityList, LMacCertList[LClientCertIndex]);

              if LIdentity <> nil then
              begin
                LCertArray := TNSArray.Wrap(TNSArray.OCClass.arrayWithObject(LMacCertList[LClientCertIndex]));
                LNewCredential := TNSURLCredential.Wrap(TNSURLCredential.OCClass.credentialWithIdentity(LIdentity, LCertArray, 1));
                LSender.useCredential(LNewCredential, willSendRequestForAuthenticationChallenge);
              end
              else
                raise ENetHTTPCertificateException.CreateRes(@SNetHttpIdentityCertError);
            end
            else
              LSender.cancelAuthenticationChallenge(willSendRequestForAuthenticationChallenge);
          end
          else
            LSender.cancelAuthenticationChallenge(willSendRequestForAuthenticationChallenge);

        finally
          LMacCertList.Free;
          LCertList.Free;
          LIdentityList.Free;
        end;
{$ENDIF !IOS}
      end
      else
        LSender.performDefaultHandlingForAuthenticationChallenge(willSendRequestForAuthenticationChallenge);
    end;
  end;
end;

function TMacConnectionDataDelegate.connectionWillSendRequestRedirectResponse(connection: NSURLConnection;
  willSendRequest: NSURLRequest; redirectResponse: NSURLResponse): NSURLRequest;
var
  LResponse: TMacHTTPResponse;
  LStatus: Integer;
begin
  Result := willSendRequest;
  if redirectResponse <> nil then
  begin
    LStatus := TNSHTTPURLResponse.Wrap((redirectResponse as ILocalObject).GetObjectID).statusCode;
    if LStatus <> 0 then
    begin
      if FMacHTTPClient.HandleRedirects and (LStatus >= 300) and (LStatus < 400) then
      begin
        if not FDataTasks.FindResponseData(connection, LResponse) then
          raise ENetHTTPClientException.Create(SNetHttpClientResponseError);

        if LResponse.FRequest.AddRedirect > FMacHTTPClient.FMaxRedirects then
        begin
          connection.cancel;
          raise ENetHTTPRequestException.CreateResFmt(@SNetHttpMaxRedirections, [FMacHTTPClient.FMaxRedirects]);
        end;
      end
      else
      begin
        Result := nil;
        connection.cancel;
      end;
    end;
  end;
end;

constructor TMacConnectionDataDelegate.Create(const ADataTasks: TDataTasks; const AClient: TMacHTTPClient);
begin
  Inherited Create;
  FDataTasks := ADataTasks;
  FMacHTTPClient := AClient;
end;

function TMacConnectionDataDelegate.GetObjectID: Pointer;
begin
  Result := inherited;
end;

{ TDataTasks }

procedure TDataTasks.AddTask(const AConnection: NSURLConnection; const AResponse: TMacHTTPResponse);
begin
  TMonitor.Enter(Self);
  try
    Add(AConnection, AResponse);
  finally
    TMonitor.Exit(Self);
  end;
end;

function TDataTasks.FindResponseData(const AConnection: NSURLConnection; var AResponse: TMacHTTPResponse): Boolean;
var
  LTaskData: TPair<NSURLConnection, TMacHTTPResponse>;
  LObjectID: Pointer;
begin
  LObjectID := (AConnection as ILocalObject).GetObjectID;
  for LTaskData in Self do
    if (LTaskData.Key as ILocalObject).GetObjectID = LObjectID then
    begin
      AResponse := LTaskData.Value;
      Exit(True);
    end;
  Result := False;
end;

procedure TDataTasks.FinishRequest(const AConnection: NSURLConnection; const AError: NSError);
var
  LResponse: TMacHTTPResponse;
begin
  if FindResponseData(AConnection, LResponse) then
  begin
    if AError <> nil then
    begin
      LResponse.FError := AError;
      LResponse.FError.retain;
    end;
    LResponse.FDone := True;
  end
  else
    raise ENetHTTPClientException.Create(SNetHttpClientResponseError);
end;

initialization
  TURLSchemes.RegisterURLClientScheme(TMacHTTPClient, 'HTTP');
  TURLSchemes.RegisterURLClientScheme(TMacHTTPClient, 'HTTPS');

finalization
  TURLSchemes.UnRegisterURLClientScheme('HTTP');
  TURLSchemes.UnRegisterURLClientScheme('HTTPS');
end.

