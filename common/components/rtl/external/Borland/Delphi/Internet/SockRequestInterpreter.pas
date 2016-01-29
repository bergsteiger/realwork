unit SockRequestInterpreter;


interface

uses
  Classes, SysUtils, IdTCPClient, idTCPConnection,
  SockTransport, IndySockTransport,
  HTTPApp, IdUDPServer, IdSocketHandle, IdUDPClient, SyncObjs, Contnrs;

type

  TWebRequestDataBlockInterpreter = class(TCustomDataBlockInterpreter)
  private
    FWebRequest: TWebRequest;
    FWebResponse: TWebResponse;
    FUsingStub: Boolean;
    function DoGetFieldByName(Data: IDataBlock): IDataBlock;
    function DoReadClient(Data: IDataBlock): IDataBlock;
    function DoReadString(Data: IDataBlock): IDataBlock;
    function DoTranslateURI(Data: IDataBlock): IDataBlock;
    function DoWriteClient(Data: IDataBlock): IDataBlock;
    function DoWriteHeaders(Data: IDataBlock): IDataBlock;
    function DoUsingStub(Data: IDataBlock): IDataBlock;
    function DoGetStringVariable(Data: IDataBlock): IDataBlock;
  protected
    function DoHandleRequest(Data: IDataBlock): IDataBlock; virtual; abstract;
  public
    procedure CallHandleRequest(ARequest: TWebRequest; AResponse: TWebResponse; AUsingStub: Boolean);
    function CallGetFieldByName(const AName: string): string;
    function CallReadClient(var ABuffer: string; ACount: Integer): Integer;
    function CallReadString(var ABuffer: string; ACount: Integer): Integer;
    function CallTranslateURI(const Value: string): string;
    function CallWriteClient(const ABuffer: string): Integer;
    function CallGetStringVariable(Index: Integer): string;
    function CallWriteHeaders(StatusCode: Integer; StatusText: string;
                           Headers: string): Boolean;
    function CallUsingStub: Boolean;

    procedure InterpretData(const Data: IDataBlock); override;
  end;

  // Interpreter with built in logging support
  TLogWebAppDataBlockInterpreter = class(TWebRequestDataBlockInterpreter)
  private
    FComplete: Boolean;
  protected
    function DoHandleRequest(Data: IDataBlock): IDataBlock; override;
  published
    property Complete: Boolean read FComplete;
  end;

  // Sender with built in logging support
  TLogSendDataBlock = class(TSendDataBlock)
  protected
    { ISendDataBlock }
    function Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock; override; stdcall;
  end;

const
  asError         = $01;   // Specify an exception was raised
  asHandleRequest = $02;
  asGetFieldByName = $03;
  asReadClient   =   $04;
  asReadString   =   $05;
  asTranslateURI =   $06;
  asWriteClient  =   $07;
  asWriteHeaders =   $08;
  asUsingStub    =   $09;
  asGetStringVariable = $0A;

implementation

// 
uses
  RTLConsts, IdException

  , DateUtils
;



procedure LogData(const Prefix: string; Data: IDataBlock);
var
  F: TFileStream;
  S: string;
  Action: string;
  Params: string;
begin
  if not FileExists('c:\logdata.txt') then     { Do not localize }
    F := TFileStream.Create('c:\logdata.txt', fmCreate or fmShareExclusive) { Do not localize }
  else
    F := TFileStream.Create('c:\logdata.txt', fmOpenWrite or fmShareExclusive); { Do not localize }
  try
    case (Data.Signature and asMask) of
      asHandleRequest: Action := 'asHandleRequest'; { Do not localize }
      asGetFieldByName: Action := 'asReadClient'; { Do not localize }
      asReadClient: Action := 'asReadClient'; { Do not localize }
      asReadString: Action := 'asReadString'; { Do not localize }
      asTranslateURI: Action := 'asTranslateURI'; { Do not localize }
      asWriteClient: Action := 'asWriteClient'; { Do not localize }
      asWriteHeaders: Action := 'asWriteHeaders'; { Do not localize }
      asUsingStub: Action := 'asUsingStub'; { Do not localize }
      asGetStringVariable: Action := 'asGetStringVariable'; { Do not localize }
    else
      Action := 'Unknown'; { Do not localize }
    end;
    if (Data.Signature and $FF00) = CallSig then
      Action := 'Call' + Action { Do not localize }
    else if (Data.Signature and $FF00) = ResultSig then
      Action := 'Result' + Action; { Do not localize }
    S := Format('%s Action: %s, Parameters: %s, Time: %d'#10#10, [Prefix, Action, Params, MilliSecondOfTheWeek(Time)]); { Do not localize }

    F.Seek(0, soEnd);
    F.Write(S[1], Length(S));
  finally
    F.Free;
  end;
end;


{ TWebRequestDataBlockInterpreter }

resourcestring
  sInvalidAction = 'Invalid Action %d';
  sInterpretDataException = 'Exception in InterpretData: %s';

procedure TWebRequestDataBlockInterpreter.InterpretData(
  const Data: IDataBlock);
var
  Action: Integer;
  NextData: IDataBlock;
begin
  NextData := Data;
  while NextData <> nil do
  begin

    LogData('InterpretData', NextData); { Do not localize }

    Action := NextData.Signature;
    if (Action and asMask) = asError then DoException(NextData);
    try
      case (Action and asMask) of
        asHandleRequest: NextData := DoHandleRequest(NextData);
        asGetFieldByName: NextData := DoGetFieldByName(NextData);
        asReadClient: NextData := DoReadClient(NextData);
        asReadString: NextData := DoReadString(NextData);
        asTranslateURI: NextData := DoTranslateURI(NextData);
        asWriteClient: NextData := DoWriteClient(NextData);
        asWriteHeaders: NextData := DoWriteHeaders(NextData);
        asUsingStub: NextData := DoUsingStub(NextData);
        asGetStringVariable: NextData := DoGetStringVariable(NextData);
      else
        raise EInterpreterError.CreateFmt(sInvalidAction, [Action and asMask]);
      end;
    except
      on E: EIdConnClosedGracefully do
        // jmt.  Raising an exception here causes Web App Debugger executables to 
        // shutdown.
        // raise;
        NextData := nil;
      on E: Exception do
      begin
        NextData.Clear;
        WriteVariant(Format(sInterpretDataException, [E.Message]), NextData);
        Data.Signature := ResultSig or asError;
        FSendDataBlock.Send(NextData, True);
        NextData := nil;
      end;
    end;
  end;
end;

// Server side request
procedure TWebRequestDataBlockInterpreter.CallHandleRequest(ARequest: TWebRequest; AResponse: TWebResponse;
  AUsingStub: Boolean);
var
  Data: IDataBlock;
begin
  FWebRequest := ARequest;
  FWebResponse := AResponse;
  FUsingStub := AUsingStub;
  Data := TDataBlock.Create as IDataBlock;
  Data.Signature := CallSig or asHandleRequest;
  Data := FSendDataBlock.Send(Data, True);
  // Handle additional calls
  InterpretData(Data);
end;


function TWebRequestDataBlockInterpreter.CallGetFieldByName(
  const AName: string): string;
var
  Flags: TVarFlags;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  WriteVariant(AName, Data);
  Data.Signature := CallSig or asGetFieldByName;
  Data := FSendDataBlock.Send(Data, True);
  try
    Result := ReadVariant(Flags, Data);
  except
    Result := '';
  end;
end;

function TWebRequestDataBlockInterpreter.DoGetFieldByName(Data: IDataBlock): IDataBlock;
var
  Name: string;
  Flags: TVarFlags;
begin
  Name := ReadVariant(Flags, Data);
  Data.Clear;
  WriteVariant(FWebRequest.GetFieldByName(Name), Data);
  Data.Signature := ResultSig or asGetFieldByName;
  Result := FSendDataBlock.Send(Data, True);
end;

function TWebRequestDataBlockInterpreter.CallGetStringVariable(
  Index: Integer): string;
var
  Flags: TVarFlags;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  WriteVariant(Index, Data);
  Data.Signature := CallSig or asGetStringVariable;
  Data := FSendDataBlock.Send(Data, True);
  try
    Result := ReadVariant(Flags, Data);
  except
    Result := '';
  end;
end;

type
  TWebRequestCracker = class(TWebRequest);
  TWebResponseCracker = class(TWebResponse);

function TWebRequestDataBlockInterpreter.DoGetStringVariable(Data: IDataBlock): IDataBlock;
var
  Index: Integer;
  Flags: TVarFlags;
  RetVal: string;
begin
  Index := ReadVariant(Flags, Data);
  Data.Clear;
  RetVal := TWebRequestCracker(FWebRequest).GetStringVariable(Index);
  WriteVariant(RetVal, Data);
  Data.Signature := ResultSig or asGetStringVariable;
  Result := FSendDataBlock.Send(Data, True);
end;


function TWebRequestDataBlockInterpreter.CallReadClient(var ABuffer: string;
  ACount: Integer): Integer;
var
  Flags: TVarFlags;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  WriteVariant(ACount, Data);
  Data.Signature := CallSig or asReadClient;
  Data := FSendDataBlock.Send(Data, True);
  Result := ReadVariant(Flags, Data);
  try
    ABuffer := ReadVariant(Flags, Data);
  except
    ABuffer := '';
  end;
end;

function TWebRequestDataBlockInterpreter.DoReadClient(Data: IDataBlock): IDataBlock;
var
  Count: Integer;
  Flags: TVarFlags;
  RetVal: string;
begin
  Count := ReadVariant(Flags, Data);
  Data.Clear;
  SetLength(RetVal, Count);
  FWebRequest.ReadClient(RetVal[1], Count);
  WriteVariant(RetVal, Data);
  Data.Signature := ResultSig or asReadClient;
  Result := FSendDataBlock.Send(Data, True);
end;


function TWebRequestDataBlockInterpreter.CallReadString(var ABuffer: string;
  ACount: Integer): Integer;
var
  Flags: TVarFlags;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  WriteVariant(ACount, Data);
  Data.Signature := CallSig or asReadString;
  Data := FSendDataBlock.Send(Data, True);
  try
    Result := ReadVariant(Flags, Data);
    ABuffer := ReadVariant(Flags, Data);
  except
    Result := 0;
    ABuffer := '';
  end;
end;

function TWebRequestDataBlockInterpreter.DoReadString(Data: IDataBlock): IDataBlock;
var
  Count: Integer;
  Flags: TVarFlags;
  RetVal: string;
begin
  Count := ReadVariant(Flags, Data);
  Data.Clear;
  SetLength(RetVal, Count);
  RetVal := FWebRequest.ReadString(Count);
  WriteVariant(RetVal, Data);
  Data.Signature := ResultSig or asReadString;
  Result := FSendDataBlock.Send(Data, True);
end;


function TWebRequestDataBlockInterpreter.CallTranslateURI(
  const Value: string): string;
var
  Flags: TVarFlags;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  WriteVariant(Value, Data);
  Data.Signature := CallSig or asTranslateURI;
  Data := FSendDataBlock.Send(Data, True);
  try
    Result := ReadVariant(Flags, Data);
  except
    Result := Value;
  end;
end;

function TWebRequestDataBlockInterpreter.DoTranslateURI(Data: IDataBlock): IDataBlock;
var
  Flags: TVarFlags;
  Value: string;
begin
  Value := ReadVariant(Flags, Data);
  Data.Clear;
  Value := FWebRequest.TranslateURI(Value);
  WriteVariant(Value, Data);
  Data.Signature := ResultSig or asTranslateURI;
  Result := FSendDataBlock.Send(Data, True);
end;

function TWebRequestDataBlockInterpreter.CallUsingStub: Boolean;
var
  Flags: TVarFlags;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  Data.Signature := CallSig or asUsingStub;
  Data := FSendDataBlock.Send(Data, True);
  try
    Result := ReadVariant(Flags, Data);
  except
    Result := False;
  end;
end;

function TWebRequestDataBlockInterpreter.DoUsingStub(Data: IDataBlock): IDataBlock;
begin
  Data.Clear;
  WriteVariant(FUsingStub, Data);
  Data.Signature := ResultSig or asUsingStub;
  Result := FSendDataBlock.Send(Data, True);
end;

function TWebRequestDataBlockInterpreter.CallWriteClient(const ABuffer: string): Integer;
var
  Flags: TVarFlags;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  WriteVariant(ABuffer, Data);
  Data.Signature := CallSig or asWriteClient;
  Data := FSendDataBlock.Send(Data, True);
  try
    Result := ReadVariant(Flags, Data);
  except
    Result := 0;
  end;
end;

function TWebRequestDataBlockInterpreter.DoWriteClient(Data: IDataBlock): IDataBlock;
var
  Flags: TVarFlags;
  Buffer: string;
  RetVal: Integer;
begin
  Buffer := ReadVariant(Flags, Data);
  Data.Clear;
  RetVal := FWebRequest.WriteClient(Buffer[1], Length(Buffer));
  WriteVariant(RetVal, Data);
  Data.Signature := ResultSig or asWriteClient;
  Result := FSendDataBlock.Send(Data, True);
end;

function TWebRequestDataBlockInterpreter.CallWriteHeaders(StatusCode: Integer;
  StatusText, Headers: string): Boolean;
var
  Flags: TVarFlags;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  WriteVariant(StatusCode, Data);
  WriteVariant(StatusText, Data);
  WriteVariant(Headers, Data);
  Data.Signature := CallSig or asWriteHeaders;
  Data := FSendDataBlock.Send(Data, True);
  try
    Result := ReadVariant(Flags, Data);
  except
    Result := True;
  end;
end;

function TWebRequestDataBlockInterpreter.DoWriteHeaders(Data: IDataBlock): IDataBlock;
var
  Flags: TVarFlags;
  StatusCode: Integer;
  StatusText, Headers: string;
  RetVal: Boolean;
begin
  StatusCode := ReadVariant(Flags, Data);
  StatusText := ReadVariant(Flags, Data);
  Headers := ReadVariant(Flags, Data);
  Data.Clear;
  RetVal := FWebRequest.WriteHeaders(StatusCode, StatusText, Headers);
  WriteVariant(RetVal, Data);
  Data.Signature := ResultSig or asWriteHeaders;
  Result := FSendDataBlock.Send(Data, True);
end;

{ TLogWebAppDataBlockInterpreter }

function TLogWebAppDataBlockInterpreter.DoHandleRequest(
  Data: IDataBlock): IDataBlock;
begin
  FComplete := True;
  Result := nil;
end;

{ TLogSendDataBlock }

function TLogSendDataBlock.Send(const Data: IDataBlock;
  WaitForResult: Boolean): IDataBlock;
begin

  LogData('SendDataBlock', Data); { Do not localize }

  Result := inherited Send(Data, WaitForResult);
end;

end.



