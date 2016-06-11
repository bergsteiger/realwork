{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.EdgePayload;

{$HPPEMIT LINKUNIT}

interface

uses System.Classes, System.SysUtils, System.Generics.Collections;

type

  TStringKeyValue = TPair<string, string>;
  TStringKeyValues = TArray<TStringKeyValue>;

  IEdgeRequest = interface
  ['{561B2566-0DEA-40B9-9E6D-9588A9102A37}']
    function GetMethod: string;
    function GetPath: string;
    function GetSessionToken: string;
    function GetQuery: TStringKeyValues;
    function GetBasePath: string;
    function GetServerHost: string;
    property Method: string read GetMethod;
    property Path: string read GetPath;
    property Query: TStringKeyValues read GetQuery;
    property SessionToken: string read GetSessionToken;
    property BasePath: string read GetBasePath;
    property ServerHost: string read GetServerHost;
  end;

  TEdgeRequest = class(TInterfacedObject, IEdgeRequest)
  private
    FMethod: string;
    FPath: string;
    FBasePath: string;
    FServerHost: string;
    FSessionToken: string;
    FQuery: TStringKeyValues;
  protected
    function GetMethod: string;
    function GetPath: string;
    function GetSessionToken: string;
    function GetQuery: TStringKeyValues;
    function GetBasePath: string;
    function GetServerHost: string;
  public
    constructor Create(const AMethod, AServerhost, ABasePath, APath: string; const AQuery: TStringKeyValues; const ASessionToken: string);
  end;

  IEdgeRequestReader = interface
    ['{FDC7D9B1-DCE8-4D97-98B7-3CBB5E9B9636}']
    function ReadRequest: IEdgeRequest;
    function ReadContentType(out AContentType: string; out AContentLength: Integer): Boolean;
    procedure ReadContent(const ALength: Integer; out ABody: string); overload;
    procedure ReadContent(const ALength: Integer; out ABytes: TBytes); overload;
    procedure ReadContent(const ALength: Int64; const AStream: TStream); overload;
  end;

  IEdgeResponse = interface
  ['{7DDF5C07-A4DD-481A-99C8-4AAB309C9E57}']
    function GetStatusCode: UInt16;
    function GetStatusText: string;
    property StatusCode: UInt16 read GetStatusCode;
    property StatusText: string read GetStatusText;
  end;

  TEdgeResponse = class(TInterfacedObject, IEdgeResponse)
  private
    FStatusText: string;
    FStatusCode: UInt16;
    function GetStatusText: string;
    function GetStatusCode: UInt16;
  public
    constructor Create(const AStatusCode: UInt16; const AStatusText: string);
  end;

  IEdgeResponseWriter = interface
    ['{91E2C804-A926-4F3D-A382-79855AB383E6}']
    procedure WriteResponse(const AResponse: IEdgeResponse);
    procedure WriteContent(const AContentType, ABody: string); overload;
    procedure WriteContent(const AContentType: string; const AStream: TStream); overload;
    procedure WriteContent(const AContentType: string; const ABody: TBytes); overload;
  end;

  TEdgeVersion = record
  private
    FMajor: UInt8;
    FMinor: UInt8;
  public
    constructor Create(AMajor, AMinor: UInt8);
    property Minor: UInt8 read FMinor;
    property Major: UInt8 read FMajor;
  end;

  TEdgeReaderWriterFactory = class
  public type
    ICreateRequestReader = interface
      function TryCreateReader(const AVersion: TEdgeVersion; const AStream: TStream; out AReader: IEdgeRequestReader): Boolean;
    end;
    ICreateResponseWriter = interface
      function TryCreateWriter(const AVersion: TEdgeVersion; const AStream: TStream; out AReader: IEdgeResponseWriter): Boolean;
    end;
  private
    FRequestReaders: TDictionary<Integer, ICreateRequestReader>;
    FResponseWriters: TDictionary<Integer, ICreateResponseWriter>;
  private
    class var FInstance: TEdgeReaderWriterFactory;
    function ReadVersion(const AStream: TStream): TEdgeVersion;
    procedure RaiseDuplicate;
    procedure RaiseNotFound;
    var FID: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function RegisterRequestReader(const AReader: ICreateRequestReader): Integer;
    procedure UnregisterRequestReader(AID: Integer);
    function RegisterResponseWriter(const AWriter: ICreateResponseWriter): Integer;
    procedure UnregisterResponseWriter(AID: Integer);
    function TryCreateResponseWriter(const AStream: TStream; out AWriter: IEdgeResponseWriter; const AVersion: TEdgeVersion): Boolean; overload;
    function TryCreateResponseWriter(const AStream: TStream; out AWriter: IEdgeResponseWriter): Boolean; overload;
    function TryCreateRequestReader(const AStream: TStream; out AReader: IEdgeRequestReader): Boolean;
    function CreateResponseWriter(const AStream: TStream; const AVersion: TEdgeVersion): IEdgeResponseWriter; overload;
    function CreateResponseWriter(const AStream: TStream): IEdgeResponseWriter; overload;
    function CreateRequestReader(const AStream: TStream): IEdgeRequestReader;
    class property Instance: TEdgeReaderWriterFactory read FInstance;
  end;

  TEdgeStreamReader = class
  private
    FStream: TStream;
    procedure RaiseContentError;
    procedure RaiseReadEOFError;
  public
    constructor Create(const AStream: TStream);
    function ReadVersion: TEdgeVersion;
    function ReadShortUInt: UInt16;
    function ReadUInt: UInt32;
    function ReadShortString: string;
    function ReadStringKeyValues: TStringKeyValues;
    function CanReadShortString: Boolean;
    procedure ReadBytes(const ABytes: TBytes; AOffset: Integer); overload;
    procedure ReadBytes(const ABytes: TBytes); overload;
    procedure ReadStream(const AStream: TStream; ACount: Int64); overload;
    function CanRead(ACount: Integer): Boolean;
    property Stream: TStream read FStream;
  end;

  TEdgeStreamWriter = class
  private
    FStream: TStream;
  public
    constructor Create(const AStream: TStream);
    procedure WriteVersion(const AVersion: TEdgeVersion);
    procedure WriteShortUInt(ALength: UInt16);
    procedure WriteUInt(ALength: UInt32);
    procedure WriteStringKeyValues(const APairs: TStringKeyValues);
    procedure WriteShortString(const AValue: string);
    procedure WriteBytes(const ABytes: TBytes);
    procedure WriteStream(const AStream: TStream);
    property Stream: TStream read FStream;
  end;

  EEdgeReadError = class(Exception);
  EEdgeReaderWriterFactoryError = class(Exception);
  EEdgeReaderVersionError = class(Exception);

const
  EdgePayloadVersion10: TEdgeVersion = (FMajor: 1; FMinor: 0);
  EdgePayloadVersion20: TEdgeVersion = (FMajor: 2; FMinor: 0);

implementation

{ TStreamWriter }

uses EMSHosting.Consts;

constructor TEdgeStreamWriter.Create(const AStream: TStream);
begin
  FStream := AStream;
end;

procedure TEdgeStreamWriter.WriteVersion(const AVersion: TEdgeVersion);
var
  LVersion: string;
  LBytes: TBytes;
begin
  LVersion := Format('%.2d.%.2d', [AVersion.Major, AVersion.Minor]);
  Assert(Length(LVersion) = 5);
  LBytes := TEncoding.UTF8.GetBytes(LVersion);
  Assert(Length(LBytes) = 5);
  FStream.Write(LBytes, Length(LBytes));

end;

procedure TEdgeStreamWriter.WriteShortString(const AValue: string);
var
  LBytes: TBytes;
begin
  LBytes := TEncoding.UTF8.GetBytes(AValue);
  WriteShortUInt(Length(LBytes));
  Stream.Write(LBytes, 0, Length(LBytes));
end;

procedure TEdgeStreamWriter.WriteStringKeyValues(const APairs: TStringKeyValues);
var
  LPair: TStringKeyValue;
begin
  WriteShortUInt(Length(APairs));
  for LPair in  APairs do
  begin
    WriteShortString(LPair.Key);
    WriteShortString(LPair.Value);
  end;

end;

procedure TEdgeStreamWriter.WriteShortUInt(ALength: UInt16);
var
  LBuffer: TBytes;
begin
  LBuffer := TEncoding.UTF8.GetBytes(IntToHex(ALength, 4));
  Assert(Length(LBuffer) = 4);
  Stream.Write(LBuffer, 0, Length(LBuffer));

end;

procedure TEdgeStreamWriter.WriteStream(const AStream: TStream);
begin
  WriteUInt(AStream.Size);
  Stream.CopyFrom(AStream, AStream.Size)
end;

procedure TEdgeStreamWriter.WriteBytes(const ABytes: TBytes);
begin
  WriteUInt(Length(ABytes));
  Stream.Write(ABytes, 0, Length(ABytes));
end;

procedure TEdgeStreamWriter.WriteUInt(ALength: UInt32);
var
  LBuffer: TBytes;
begin
  LBuffer := TEncoding.UTF8.GetBytes(IntToHex(ALength, 8));
  Assert(Length(LBuffer) = 8);
  Stream.Write(LBuffer, 0, Length(LBuffer));

end;

{ TStreamReader }

function TEdgeStreamReader.CanRead(ACount: Integer): Boolean;
begin
  Result := FStream.Position + ACount <= FStream.Size;
end;

constructor TEdgeStreamReader.Create(const AStream: TStream);
begin
  FStream := AStream;
end;

function TEdgeStreamReader.ReadVersion: TEdgeVersion;
var
  LBuffer: TBytes;
  LMajor: Integer;
  LMinor: Integer;
begin
  SetLength(LBuffer, 5);
  try
    ReadBytes(LBuffer);
  except
    RaiseContentError;
  end;
  if LBuffer[2] <> Byte('.') then
    RaiseContentError;
  if not TryStrToInt(TEncoding.UTF8.GetString(LBuffer, 0, 2), LMajor) then
    RaiseContentError;
  if (LMajor <= 0) and (LMajor >= 256) then
    RaiseContentError;
  if not TryStrToInt(TEncoding.UTF8.GetString(LBuffer, 3, 2), LMinor) then
    RaiseContentError;
  if (LMinor < 0) and (LMinor >= 256) then
    RaiseContentError;
  Result := TEdgeVersion.Create(LMajor, LMinor);
end;

procedure TEdgeStreamReader.RaiseReadEOFError;
begin
  raise EEdgeReadError.Create(sEdgeEOFError);
end;

procedure TEdgeStreamReader.RaiseContentError;
begin
  raise EEdgeReadError.Create(sEdgeContentError);
end;

procedure TEdgeStreamReader.ReadBytes(const ABytes: TBytes; AOffset: Integer);
begin
  if FStream.Read(ABytes, AOffset, Length(ABytes)-AOffset) <> Length(ABytes) - AOffset then
    RaiseReadEOFError;
end;

procedure TEdgeStreamReader.ReadBytes(const ABytes: TBytes);
begin
  ReadBytes(ABytes, 0);
end;

procedure TEdgeStreamReader.ReadStream(const AStream: TStream; ACount: Int64);
begin
  if AStream.CopyFrom(FStream, ACount) < ACount then
    RaiseReadEOFError;
end;

function TEdgeStreamReader.CanReadShortString: Boolean;
begin
  Result := CanRead(4);
end;

function TEdgeStreamReader.ReadShortString: string;
var
  LLength: Integer;
  LBuffer: TBytes;
begin
  LLength := ReadShortUInt;
  Assert(LLength >= 0);
  SetLength(LBuffer, LLength);
  ReadBytes(LBuffer);
  Result := TEncoding.UTF8.GetString(LBuffer);
end;

function TEdgeStreamReader.ReadShortUInt: UInt16;
var
  LBuffer: TBytes;
  S: string;
begin
  SetLength(LBuffer, 5);
  LBuffer[0] := Byte('$');
  ReadBytes(LBuffer, 1);
  S := TEncoding.UTF8.GetString(LBuffer);
  Result := StrToInt(S);
end;

function TEdgeStreamReader.ReadUInt: UInt32;
var
  LBuffer: TBytes;
  S: string;
begin
  SetLength(LBuffer, 9);
  LBuffer[0] := Byte('$');
  ReadBytes(LBuffer, 1);
  S := TEncoding.UTF8.GetString(LBuffer);
  Result := StrToInt(S);
end;

function TEdgeStreamReader.ReadStringKeyValues: TStringKeyValues;
var
  LCount: Integer;
  I: Integer;
  LKey, LValue: string;
begin
  LCount := ReadShortUInt;
  Assert(LCount >= 0);
  SetLength(Result, LCount);
  for I := 0 to LCount - 1 do
  begin
    LKey := ReadShortString;
    LValue := ReadShortString;
    Result[I] := TStringKeyValue.Create(LKey, LValue);
  end;
end;

{ TReaderWriterFactory }

constructor TEdgeReaderWriterFactory.Create;
begin
  FRequestReaders :=  TDictionary<Integer, ICreateRequestReader>.Create;
  FResponseWriters :=  TDictionary<Integer, ICreateResponseWriter>.Create;
end;

destructor TEdgeReaderWriterFactory.Destroy;
begin
  FRequestReaders.Free;
  FResponseWriters.Free;
  inherited;
end;

function TEdgeReaderWriterFactory.RegisterRequestReader(
  const AReader: ICreateRequestReader): Integer;
begin
  Inc(FID);
  FRequestReaders.Add(FID, AReader);
  Result := FID;
end;

function TEdgeReaderWriterFactory.RegisterResponseWriter(
  const AWriter: ICreateResponseWriter): Integer;
begin
  Inc(FID);
  FResponseWriters.Add(FID, AWriter);
  Result := FID;
end;

function TEdgeReaderWriterFactory.ReadVersion(const AStream: TStream): TEdgeVersion;
begin
  AStream.Position := 0;
  with TEdgeStreamReader.Create(AStream) do
  try
    Result := ReadVersion;
  finally
    AStream.Position := 0;
    Free;
  end;
end;

procedure TEdgeReaderWriterFactory.RaiseDuplicate;
begin
  raise EEdgeReaderWriterFactoryError.Create(sEdgeFactoryDuplicate);
end;

procedure TEdgeReaderWriterFactory.RaiseNotFound;
begin
  raise EEdgeReaderWriterFactoryError.Create(sEdgeFactoryNotFound);
end;

function TEdgeReaderWriterFactory.TryCreateRequestReader(const AStream: TStream;
  out AReader: IEdgeRequestReader): Boolean;
var
  LIntf: ICreateRequestReader;
  LVersion: TEdgeVersion;
begin
  LVersion := ReadVersion(AStream);
  Result := False;
  for LIntf in  FRequestReaders.Values do
    if LIntf.TryCreateReader(LVersion, AStream, AReader) then
    begin
      if Result then
        RaiseDuplicate;
      Result := True;
    end;
end;

function TEdgeReaderWriterFactory.CreateRequestReader(const AStream: TStream): IEdgeRequestReader;
begin
  if not TryCreateRequestReader(AStream, Result) then
    RaiseNotFound;
end;

function TEdgeReaderWriterFactory.TryCreateResponseWriter(const AStream: TStream;
  out AWriter: IEdgeResponseWriter; const AVersion: TEdgeVersion): Boolean;
var
  LIntf: ICreateResponseWriter;
begin
  Result := False;
  for LIntf in  FResponseWriters.Values do
    if LIntf.TryCreateWriter(AVersion, AStream, AWriter) then
    begin
      if Result then
        RaiseDuplicate;
      Result := True;
    end;
end;

function TEdgeReaderWriterFactory.CreateResponseWriter(const AStream: TStream;
  const AVersion: TEdgeVersion): IEdgeResponseWriter;
begin
  if not TryCreateResponseWriter(AStream, Result, AVersion) then
    RaiseNotFound;
end;

function TEdgeReaderWriterFactory.TryCreateResponseWriter(const AStream: TStream;
  out AWriter: IEdgeResponseWriter): Boolean;
begin
  Result := TryCreateResponseWriter(AStream, AWriter, EdgePayloadVersion20);
end;

function TEdgeReaderWriterFactory.CreateResponseWriter(const AStream: TStream): IEdgeResponseWriter;
begin
  if not TryCreateResponseWriter(AStream, Result) then
    RaiseNotFound;
end;

procedure TEdgeReaderWriterFactory.UnregisterRequestReader(AID: Integer);
begin
  Assert(FRequestReaders.ContainsKey(AID));
  FRequestReaders.Remove(AID);
end;

procedure TEdgeReaderWriterFactory.UnregisterResponseWriter(AID: Integer);
begin
  Assert(FResponseWriters.ContainsKey(AID));
  FResponseWriters.Remove(AID);
end;

{ TVersion }

constructor TEdgeVersion.Create(AMajor, AMinor: UInt8);
begin
  FMajor := AMajor;
  FMinor := AMinor;
end;

{ TRequest }

constructor TEdgeRequest.Create(const AMethod, AServerhost, ABasePath, APath: string; const AQuery: TStringKeyValues;
  const ASessionToken: string);
begin
  FMethod := AMethod;
  FPath := APath;
  FBasePath := ABasePath.Replace(FPath, '');
  FServerHost := AServerhost;
  FQuery := AQuery;
  FSessionToken := ASessionToken;
end;

function TEdgeRequest.GetBasePath: string;
begin
  Result := FBasePath;
end;

function TEdgeRequest.GetServerHost: string;
begin
  Result := FServerHost;
end;

function TEdgeRequest.GetSessionToken: string;
begin
  Result := FSessionToken;
end;

function TEdgeRequest.GetQuery: TStringKeyValues;
begin
  Result := FQuery;
end;

function TEdgeRequest.GetMethod: string;
begin
  Result := FMethod;
end;

function TEdgeRequest.GetPath: string;
begin
  Result := FPath;
end;

{ TResponse }

constructor TEdgeResponse.Create(const AStatusCode: UInt16;
  const AStatusText: string);
begin
  FStatusCode := AStatusCode;
  FStatusText := AStatusText;
end;

function TEdgeResponse.GetStatusCode: UInt16;
begin
  Result := FStatusCode;
end;

function TEdgeResponse.GetStatusText: string;
begin
  Result := FStatusText;
end;

type
  TRequestReader = class(TInterfacedObject, IEdgeRequestReader)
  private
    FStreamReader: TEdgeStreamReader;
    function ReadRequest: IEdgeRequest;
    function ReadContentType(out AContentType: string; out AContentLength: Integer): Boolean;
    procedure ReadContent(const ALength: Integer; out ABody: string); overload;
    procedure ReadContent(const ALength: Integer; out ABytes: TBytes); overload;
    procedure ReadContent(const ALength: Int64; const AStream: TStream); overload;
  public
    constructor Create(const AStream: TStream);
    destructor Destroy; override;
  end;

  TResponseWriter = class(TInterfacedObject, IEdgeResponseWriter)
  private
    FStreamWriter: TEdgeStreamWriter;
    procedure WriteResponse(const AResponse: IEdgeResponse);
    procedure WriteContent(const AContentType, ABody: string); overload;
    procedure WriteContent(const AContentType: string; const AStream: TStream); overload;
    procedure WriteContent(const AContentType: string; const ABody: TBytes); overload;
  public
    constructor Create(const AStream: TStream);
    destructor Destroy; override;
  end;

function SupportsVersion(const AVersion: TEdgeVersion): Boolean;
begin
  Result := AVersion.Major = EdgePayloadVersion20.Major;
end;

function SupportsOldVersion(const AVersion: TEdgeVersion): Boolean;
begin
  Result := AVersion.Major = EdgePayloadVersion10.Major;
end;

{ TRequestReader }

constructor TRequestReader.Create(const AStream: TStream);
begin
  FStreamReader := TEdgeStreamReader.Create(AStream);
end;

destructor TRequestReader.Destroy;
begin
  FStreamReader.Free;
  inherited;
end;

procedure TRequestReader.ReadContent(const ALength: Integer; out ABody: string);
var
  LBuffer: TBytes;
begin
  SetLength(LBuffer, ALength);
  FStreamReader.ReadBytes(LBuffer);
  ABody := TEncoding.UTF8.GetString(LBuffer);
end;

procedure TRequestReader.ReadContent(const ALength: Integer;
  out ABytes: TBytes);
begin
  SetLength(ABytes, ALength);
  FStreamReader.ReadBytes(ABytes);
end;

procedure TRequestReader.ReadContent(const ALength: Int64;
  const AStream: TStream);
begin
  FStreamReader.ReadStream(AStream, ALength);
end;

function TRequestReader.ReadContentType(out AContentType: string;
  out AContentLength: Integer): Boolean;
begin
  Result := FStreamReader.CanReadShortString;
  if Result then
  begin
    AContentType := FStreamReader.ReadShortString;
    if Result then
      AContentLength := FStreamReader.ReadUInt;
  end;
end;

function TRequestReader.ReadRequest: IEdgeRequest;
var
  LMethod, LPath, LSessionToken, LBasePath, LServerHost: string;
  LVersion: TEdgeVersion;
  LQuery: TStringKeyValues;
begin
  LVersion := FStreamReader.ReadVersion;
  if not SupportsVersion(LVersion) then
    if SupportsOldVersion(LVersion) then
      raise EEdgeReaderVersionError.Create(sEdgeOldVersionError)
    else
      raise EEdgeReaderVersionError.Create(sEdgeVersionError);
  LMethod := FStreamReader.ReadShortString;
  LPath := FStreamReader.ReadShortString;
  LQuery := FStreamReader.ReadStringKeyValues;
  LSessionToken := FStreamReader.ReadShortString;
  LBasePath := FStreamReader.ReadShortString;
  LServerHost := FStreamReader.ReadShortString;
  Result := TEdgeRequest.Create(LMethod, LServerHost, LBasePath, LPath, LQuery, LSessionToken);
end;


{ TResponseWriter }

constructor TResponseWriter.Create(const AStream: TStream);
begin
  FStreamWriter := TEdgeStreamWriter.Create(AStream);
end;

destructor TResponseWriter.Destroy;
begin
  FStreamWriter.Free;
  inherited;
end;

procedure TResponseWriter.WriteContent(const AContentType, ABody: string);
var
  LBytes: TBytes;
begin
  LBytes := TEncoding.UTF8.GetBytes(ABody);
  WriteContent(AContentType, LBytes);
end;

procedure TResponseWriter.WriteContent(const AContentType: string; const ABody: TBytes);
begin
  FStreamWriter.WriteShortString(AContentType);
  FStreamWriter.WriteBytes(ABody);
end;

procedure TResponseWriter.WriteContent(const AContentType: string;
  const AStream: TStream);
begin
  FStreamWriter.WriteShortString(AContentType);
  FStreamWriter.WriteStream(AStream);
end;

procedure TResponseWriter.WriteResponse(const AResponse: IEdgeResponse);
begin
  FStreamWriter.WriteVersion(EdgePayloadVersion20);
  FStreamWriter.WriteShortUInt(AResponse.StatusCode);
  FStreamWriter.WriteShortString(AResponse.StatusText);
end;


type
  TReaderWriterCreators = class(TInterfacedObject,
    TEdgeReaderWriterFactory.ICreateRequestReader,
    TEdgeReaderWriterFactory.ICreateResponseWriter)
  private
    function TryCreateReader(const AVersion: TEdgeVersion; const AStream: TStream; out AReader: IEdgeRequestReader): Boolean; overload;
    function TryCreateWriter(const AVersion: TEdgeVersion; const AStream: TStream; out AReader: IEdgeResponseWriter): Boolean; overload;
  end;


function TReaderWriterCreators.TryCreateReader(const AVersion: TEdgeVersion; const AStream: TStream; out AReader: IEdgeRequestReader): Boolean;
begin
  Result := SupportsVersion(AVersion);
  if Result then
    AReader := TRequestReader.Create(AStream);
end;

function TReaderWriterCreators.TryCreateWriter(const AVersion: TEdgeVersion; const AStream: TStream; out AReader: IEdgeResponseWriter): Boolean;
begin
  Result := SupportsVersion(AVersion);
  if Result then
    AReader := TResponseWriter.Create(AStream);
end;


var
  LID1: Integer;
  LID2: Integer;
initialization
  TEdgeReaderWriterFactory.FInstance := TEdgeReaderWriterFactory.Create;

  LID1 := TEdgeReaderWriterFactory.Instance.RegisterRequestReader(TReaderWriterCreators.Create);
  LID2 := TEdgeReaderWriterFactory.Instance.RegisterResponseWriter(TReaderWriterCreators.Create);
finalization
  TEdgeReaderWriterFactory.Instance.UnregisterRequestReader(LID1);
  TEdgeReaderWriterFactory.Instance.UnregisterResponseWriter(LID2);

  FreeAndNil(TEdgeReaderWriterFactory.FInstance);
end.

