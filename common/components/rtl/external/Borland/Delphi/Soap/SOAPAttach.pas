{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{         SOAP Attachment                               }
{                                                       }
{       Copyright (c) 2001 Inprise Corporation          }
{                                                       }
{*******************************************************}
unit SOAPAttach;

interface

uses
  SysUtils, Types, Classes, InvokeRegistry,
  {XSBuiltIns,} HTTPApp, SOAPAttachIntf, WSDLIntf;
const
  EOL           = #13#10;             { Linux vs. Windows is not relevant }
  BlockReadSize = 10240;              { Buffer side reading stream blocks }

type

  TSOAPAttachmentData = class(TSOAPAttachment)
  private
    FID: string;
  public
    { Id used to identify Attachment: Content-Id or Content-Location }
    property ID: string read FID write FID;
    procedure SetSourceStream(const Value: TStream; const Ownership: TStreamOwnership = soOwned); override;
    { allow Filename to be set without clearing out SourceStream }
    procedure SetCacheFile(const Value: string);
  end;

{ treats a TWebRequest as a TStream }

  TWebRequestStream = class(TStream)
  private
    FWebRequest: TWebRequest;
    FPosition: Int64;
    FSize: Int64;
    FContentSize: Integer;
    FSavedChars: string;
    FContentType: string;
    FMaxLine: Integer;
  public
    constructor Create(ARequest: TWebRequest); reintroduce;
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function ReadLn: String;
    function Seek(Offset: Longint; Origin: Word): Longint; overload; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    property MaxLine: Integer read FMaxLine write FMaxLine;
  end;

{ Utility functions }

  function GetTempHandle(var ATempFileName: string): THandle;
  function GetTempDir: string;
  function GetMimeBoundaryFromType(const ContentType: string): string;
  function GetBorlandMimeContentType: string;

  function GetMimeAttachmentHandler(const ContentType: String): IMimeAttachmentHandler; overload;
  function GetMimeAttachmentHandler(const BindingType: TWebServiceBindingType): IMimeAttachmentHandler; overload;

implementation

uses Math, SOAPConst, {$IFDEF LINUX}Libc{$ENDIF}{$IFDEF MSWINDOWS}Windows{$ENDIF};

{ Utility functions }

  function GetTempDir: string;
  begin;
{$IFDEF LINUX}
    Result := GetEnv('TMPDIR');
    if Result = '' then
      Result := '/tmp/'
    else if Result[Length(Result)] <> PathDelim then
      Result := Result + PathDelim;
{$ENDIF}
{$IFDEF MSWINDOWS}
    SetLength(Result, 255);
    SetLength(Result, GetTempPath(255, (PChar(Result))));
{$ENDIF}
  end;

  function GetTempHandle(var ATempFileName: string): THandle;
{$IFDEF MSWINDOWS}
  var
    Index: Integer;
    AFileName: string;
{$ENDIF}
  begin
{$IFDEF MSWINDOWS}
    Index := 0;
    AFileName := ATempFileName + IntToStr(Index);
    while FileExists(AFileName) do
    begin
      Inc(Index);
      AFileName := ATempFileName + IntToStr(Index);
    end;
    ATempFileName := AFileName;
    Result := FileCreate(AFileName);
{$ENDIF}
{$IFDEF LINUX}
    UniqueString(ATempFileName);
    Result := mkstemp(Pointer(ATempFileName));
{$ENDIF}
    if Integer(Result) < 1 then
      raise Exception.Create(STempFileAccessError);
  end;

  function GetBorlandMimeContentType: string;
  begin
    Result := Format(ContentHeaderMime, [SBorlandMimeBoundary]) +
                          Format(SStart, [SBorlandSoapStart]);
  end;

  function GetMimeBoundaryFromType(const ContentType: string): string;
  begin
    { As per rfc2112 - http://www.faqs.org/rfcs/rfc2112.html -
      we expect a content-type 'Multipart/Related' }
    if Pos(SMultipartRelated, LowerCase(ContentType)) = 1 then                        { do not localize }
    begin
      Result := Copy(ContentType, Pos(SBoundary, ContentType) + Length(SBoundary), MaxInt);
      if Pos(';', Result) > 1 then
        Result := Copy(Result, 1, Pos(';', Result) -1);
    end else
      Result := '';
  end;

{ TSOAPAttachmentData }

procedure TSOAPAttachmentData.SetSourceStream(const Value: TStream; const Ownership: TStreamOwnership = soOwned);
begin
  InternalSetSourceStream(Value, Ownership);
end;

procedure TSOAPAttachmentData.SetCacheFile(const Value: string);
begin
  SetSourceFile('');
  InternalSetCacheFile(Value);
  CacheFilePersist := True;
end;

{ TWebRequestStream }

constructor TWebRequestStream.Create(ARequest: TWebRequest);
begin
  inherited Create;
  FWebRequest := ARequest;
  FSize := FWebRequest.ContentLength;
  FPosition := 0;
  FContentSize := Length(FWebRequest.Content);
  FContentType := FWebRequest.ContentType;
  FSavedChars := '';
  FMaxLine := BlockReadSize;
end;

destructor TWebRequestStream.Destroy;
begin
  inherited;
end;

{ assumes user knows headers are to follow, followed by blank line }
function TWebRequestStream.ReadLn: string;
var
  ReadCount, CRPos: Integer;
  SplitLF: string;
begin
  SetLength(Result, MaxLine);
  ReadCount := Read(Result[1], MaxLine);
  SetLength(Result, ReadCount);
  CrPos := Pos(EOL, Result);
  if CrPos > 0 then
  begin
    Inc(CrPos);
    FSavedChars := Copy(Result, CrPos + 1, Length(Result) - CrPos) + FSavedChars;
    SetLength(Result, CrPos);
  end else
  begin
    { Check for split EOL }
    if (Length(Result) > 0 ) and (Result[Length(Result)] = #13) then
    begin
      SetLength(SplitLF, 1);
      Read(SplitLF[1], 1 );
      if SplitLF[1] = #10 then
      begin
        { cut off #13 from result }
        SetLength(Result, MaxLine -1);
        FSavedChars := FSavedChars + EOL;
      end;
    end;
  end;
end;

function TWebRequestStream.Read(var Buffer; Count: Longint): Longint;
var
  BytesToRead, BytesRead, SaveStart: LongInt;
  P: PChar;

  procedure LoadSavedChars(SaveStart: Integer);
  var
    Buffer : string;
  begin
    if FPosition < FContentSize then
    begin
      { read first from FWebRequest.Content buffer }
      BytesToRead := Min(Count, FContentSize - FPosition);
      SetLength(Buffer, BytesToRead);
      Move(FWebRequest.Content[FPosition + 1], Buffer[1], BytesToRead);
      FSavedChars := FSavedChars + Buffer;
      Inc(FPosition, BytesToRead);
      Inc(SaveStart, BytesToRead);
    end;
    if SaveStart < Count then
    begin
      { if still missing bytes then use TWebRequest.ReadClient }
      while (SaveStart < Count) and (FPosition < FSize) do
      begin
        BytesToRead := Min(Count - SaveStart, FSize - FPosition);
        SetLength(Buffer, BytesToRead);
        BytesRead := FWebRequest.ReadClient(Buffer[1], BytesToRead);
        if BytesRead < 1 then
          break;
        SetLength(Buffer, BytesRead);
        FSavedChars := FSavedChars + Buffer;
        Inc(FPosition, BytesRead);
        Inc(SaveStart, BytesRead);
      end;
    end;
  end;

begin
  if Assigned(FWebRequest) then
  begin
    SaveStart := Length(FSavedChars);
    if SaveStart < Count then
      LoadSavedChars(SaveStart);
    P := @Buffer;
    Result := 0;
    { retrieve from Saved Buffer }
    BytesToRead := Min(Count, Length(FSavedChars));
    Move(FSavedChars[1], P[Result], BytesToRead);
    Inc(Result, BytesToRead);
    if BytesToRead >= Length(FSavedChars) then
      FSavedChars := ''
    else
      FSavedChars := Copy(FSavedChars, BytesToRead + 1, MaxInt);
  end else
    Result := 0;
end;

function TWebRequestStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning: FPosition := Offset + Length(FSavedChars);
    soFromEnd: FPosition := FSize + Length(FSavedChars);
    soFromCurrent: Inc(FPosition, Offset);
  end;
  Result := FPosition - Length(FSavedChars);
end;

function TWebRequestStream.Write(const Buffer; Count: Longint): Longint;
begin
  raise Exception.Create(SMethodNotSupported);
end;

{ TAggregatedStream }

type

{ treats a collection of Streams as a single stream.
      all streams in the FStreams TList are freed when object is destroyed! }
  TAggregatedStream = class(TStream)
  private
    FCurrentStream: Integer;
    FStreams: TList;
    FOwners: array of TStreamOwnerShip;
    FSize: Int64;
    FPosition: Int64;
  protected
    procedure SetStreamToPosition;
  public
    { from TAggregatedStream }
    procedure AddStream(AStream: TStream; Ownership: TStreamOwnerShip); overload;
    procedure AddStream(AValue: string); overload;
    procedure ClearStream(FreeStreams: Boolean);
    { from TStream }
    constructor Create;
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; overload; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    property Position: Int64 read FPosition;
    property Size: Int64 read FSize;
  end;


constructor TAggregatedStream.Create;
begin
  FStreams := TList.Create;
  FCurrentStream := -1;
  FSize := 0;
  FPosition := 0;
end;

destructor TAggregatedStream.Destroy;
begin
  ClearStream(True);
  FreeAndNil(FStreams);
  inherited;
end;

function TAggregatedStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning: FPosition := Offset;
    soFromCurrent: Inc(FPosition, Offset);
    soFromEnd: FPosition := FSize + Offset;
  end;
  Result := FPosition;
end;

procedure TAggregatedStream.SetStreamToPosition;
var
  FPos, FPositionInStream: LongInt;
begin
  if FPosition = FSize then
  begin
    FCurrentStream := FStreams.Count -1;
    FPositionInStream := TStream(FStreams[FCurrentStream]).Size;
    FPos := FPosition;
  end else
  begin
    FPos := 0;
    FPositionInStream := 0;
    FCurrentStream := 0;
  end;
  while FPos < FPosition do
  begin
    if (FPosition - FPos) > TStream(FStreams[FCurrentStream]).Size then
    begin
      Inc(FPos, TStream(FStreams[FCurrentStream]).Size);
      if FCurrentStream < FStreams.Count -1 then
        Inc(FCurrentStream)
      else
        break;
    end else
    begin
      FPositionInStream := FPosition - FPos;
      FPos := FPosition;
    end;
  end;
  TStream(FStreams[FCurrentStream]).Seek(FPositionInStream, 0);
end;

function TAggregatedStream.Read(var Buffer; Count: Longint): Longint;
var
  P: PChar;
  BytesRead, ToRead: LongInt;
begin
  Result := 0;
  if FStreams.Count = 0 then
    raise Exception.Create(SEmptyStream);
  SetStreamToPosition;
  if FPosition = FSize then exit;
  P := @Buffer;
  Result := 0;
  while (Result < Count) and (FCurrentStream < FStreams.Count) do
  begin
    ToRead := Min(TStream(FStreams[FCurrentStream]).Size -
              TStream(FStreams[FCurrentStream]).Position, Count - Result);
    BytesRead := TStream(FStreams[FCurrentStream]).Read(P[Result], ToRead);
    Inc(FPosition, BytesRead);
    Inc(Result, BytesRead);
    if Result < Count then
    begin
      if TStream(FStreams[FCurrentStream]).Position < TStream(FStreams[FCurrentStream]).Size then
        continue;
      if FCurrentStream < FStreams.Count -1 then
      begin
        Inc(FCurrentStream);
        TStream(FStreams[FCurrentStream]).Seek(0, 0);
      end else
      begin
        FPosition := FSize;
        break;
      end;
    end;
  end;
end;

function TAggregatedStream.Write(const Buffer; Count: Longint): Longint;
begin
  raise Exception.Create(SMethodNotSupported);
end;

procedure TAggregatedStream.AddStream(AStream: TStream; OwnerShip: TStreamOwnership);
begin
  AStream.Seek(0, 0);
  FStreams.Add(AStream);
  SetLength(FOwners, FStreams.Count);
  FOwners[FStreams.Count - 1] := Ownership;
  Inc(FSize, AStream.Size);
  FPosition := 0;
  FCurrentStream := 0;
end;

procedure TAggregatedStream.AddStream(AValue: string);
var
  AStream: TMemoryStream;
begin
  AStream := TMemoryStream.Create;
  AStream.Write(AValue[1], Length(AValue));
  AddStream(AStream, soOwned);
end;

procedure TAggregatedStream.ClearStream(FreeStreams: Boolean);
var
  I: Integer;
begin
  if FreeStreams then
    for I := 0 to FStreams.Count -1 do
    begin
      if FOwners[I] = soOwned then
        TStream(FStreams[I]).Free;
    end;
  SetLength(FOwners, 0);  
  FStreams.Clear;
  FSize := 0;
  FPosition := 0;
end;

type
{ TMimeStream }

  TMimeAttachmentHandler = class(TAggregatedStream)
  private
    FAttachmentsStream: TAggregatedStream;
    FLastMimeBoundary: string;
    FMimeBoundary: string;
    FSoapEnvelope: TStream;
    FSoapHeaders: TStrings;
    FOnSendAttachment: TOnSendAttachmentEvent;
    FOnGetAttachment: TOnGetAttachmentEvent;
    FContentType: string;
  protected
    { create Attachments portion of Stream }
    procedure CreateAttachmentStream(Attachments: TSoapDataList);
    procedure DoOnSendAttachment(AttachmentStream: TStream; Attachment: TSOAPAttachment); virtual;
    procedure DoOnGetAttachment(AttachmentStream: TStream; Attachment: TSOAPAttachment); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    { break up MultiPart form (as stream) into Soap Envelope
      and Attachments }
    procedure ProcessMultiPartForm(
              const ASourceStream, ADestStream: TStream;
              AMimeBoundary: string; SoapHeaders: TStrings;
              Attachments: TSoapDataList; TempDir: string);
    { Add a new Soap Header  }
    procedure AddSoapHeader(Value: string);
    procedure CreateMimeStream(Envelope: TStream; Attachments: TSoapDataList);
    { combine MimeBoundary, Soap Headers and Envelope, and Attachments into single Stream }
    procedure FinalizeStream;
    { access Soap Envelope portion of stream }
    property SoapEnvelope: TStream read FSoapEnvelope;
    property ContentType: string read FContentType write FContentType;
    property MimeBoundary: string read FMimeBoundary write FMimeBoundary;
    { access SOAP Headers portion of stream }
    property SoapHeaders: TStrings read FSoapHeaders;
    property OnSendAttachment: TOnSendAttachmentEvent read FOnSendAttachment write FOnSendAttachment;
    property OnGetAttachment: TOnGetAttachmentEvent read FOnGetAttachment write FOnGetAttachment;
  end;

constructor TMimeAttachmentHandler.Create;
begin
  inherited;
  FSOAPHeaders := TStringList.Create;
  FAttachmentsStream := TAggregatedStream.Create;
end;

destructor TMimeAttachmentHandler.Destroy;
begin
  FSOAPHeaders.Free;
  FSoapEnvelope.Free;
  FAttachmentsStream.Free;
  inherited;
end;

procedure TMimeAttachmentHandler.FinalizeStream;
const
  MimeStart = '--';       { do not localize }
var
  Boundary : string;
  I: Integer;
begin
  if FAttachmentsStream.Size = 0 then
  begin
    AddStream(FSoapEnvelope, soReference);
    FSoapHeaders.Clear;
  end else
  begin
    Boundary := MimeStart + FMimeBoundary;
    { add starting MimeBoundary }
    AddStream(EOL + Boundary + EOL);
    { add Soap Headers }
    AddSoapHeader(Format(SContentId + ': <%s>', [SBorlandSoapStart]));          { do not localize }
    AddSoapHeader(Format(SContentLocation + ': %s', [SBorlandSoapStart]));      { do not localize }
    AddSoapHeader(Format(SContentLength + ': %d', [FSoapEnvelope.Size]));    { do not localize }
//    AddSoapHeader('Content-Transfer-Encoding: 8bit');
    for I := 0 to FSoapHeaders.Count -1 do
      AddStream(FSoapHeaders[I] + EOL);
    { add Soap Envelope with Mime boundary }
    AddStream(EOL);
    AddStream(FSoapEnvelope, soReference);
    AddStream(EOL);
    AddStream(FAttachmentsStream, soReference);
  end;
end;

type 
  TMimeStreamHolder = class(TObject)
  private
    FSourceStream: TStream;
    FHeaders: TStrings;
  public
    constructor Create; 
    destructor Destroy; override;
    property Headers: TStrings read FHeaders;
    property SourceStream: TStream read FSourceStream write FSourceStream;
  end;

constructor TMimeStreamHolder.Create;
begin
  inherited;
  FHeaders := TStringList.Create;
end;

destructor TMimeStreamHolder.Destroy;
begin
  FHeaders.Free;
  inherited;
end;

procedure TMimeAttachmentHandler.ProcessMultiPartForm(
          const ASourceStream, ADestStream: TStream;
          AMimeBoundary: string; SoapHeaders: TStrings;
          Attachments: TSoapDataList;
          TempDir: string);
const
{$IFDEF MSWINDOWS}
  BorlandTempFile = 'BorlandSoapAttachment';
{$ENDIF}
{$IFDEF LINUX}
  BorlandTempFile = 'BorlandSoapAttachmentXXXXXX';
{$ENDIF}
var
  Target: THandleStream;
  HaveEnvelope, Done: Boolean;
  Attachment: TSOAPAttachmentData;
  MimeStream: TMimeStreamHolder;
  AttachFileName, TempFileName: string;
  TargetHandle: Integer;

  function ReadLine(const SourceStream: TStream; BlockSize: Integer = 10240): String;
  var
    StreamPos, Size: Integer;
  begin
    if SourceStream is TWebRequestStream then
    begin
      Result := (MimeStream.SourceStream as TWebRequestStream).readln;
    end else
    begin
      SetLength(Result, BlockSize);
      StreamPos := SourceStream.Position;
      SourceStream.Read(Result[1], BlockSize);
      Size := Pos(EOL, Result);
      if Size > 0 then
      begin
        Inc(Size);
        SetLength(Result, Size);
        SourceStream.Position := StreamPos + Size;
      end;
    end;
  end;

  function SameMimeBoundary(SFound, SMime: string): Boolean;
  begin
    Result := SameText(SFound, SMime) or
              SameText(SFound, '--' + SMime + EOL) or
              SameText(SFound, '--' + SMime + '--') or
              SameText(SFound, '--' + SMime + '--' + EOL) or
              SameText(SFound, SMime + EOL);
  end;

  procedure ReadContent(ADestStream: TStream);
  var
    SLine: string;
  begin
    SLine := ReadLine(MimeStream.SourceStream);
    while (MimeStream.SourceStream.Position <= MimeStream.SourceStream.Size) and
          (not SameMimeBoundary(SLine, MimeBoundary)) do
    begin
      ADestStream.Write(SLine[1], Length(SLine));
      SLine := ReadLine(MimeStream.SourceStream);
      if Length(SLine) = 0 then
        Raise Exception.Create(SMimeReadError);
    end;
    FLastMimeBoundary := sLine;
  end;

  procedure ReadBody(ADestStream: TStream; var AMsgEnd: Boolean);
  var
    Size: Integer;
  begin
    if MimeStream.SourceStream.Position < MimeStream.SourceStream.Size then
    begin
      if MimeStream.Headers.Count = 0 then
        exit;
      if MimeStream.Headers.Values[SContentLength] = '' then
      begin
        ReadContent(ADestStream);
      end else
      begin
        Size := StrToInt(MimeStream.Headers.Values[SContentLength]);
        if (MimeStream.SourceStream.Size - MimeStream.SourceStream.Position) < Size then
          raise Exception.Create(SInvalidContentLength);
        if Size > 0 then
          ADestStream.CopyFrom(MimeStream.SourceStream, Size);
      end;
    end;
    if MimeStream.SourceStream.Position >= MimeStream.SourceStream.Size then
      AMsgEnd := True;
  end;

  procedure GetHeaders;
  var
    AHeaders: TStringList;
    Line: string;
  begin
    AHeaders := TStringList.Create;
    try
      Line := 'l';
      while (Line <> '') and (Line <> EOL) do
      begin
        Line := ReadLine(MimeStream.SourceStream, 1024);
        if (Line = '') or (Line = EOL) then
        begin
          MimeStream.Headers.Clear;
          MimeStream.Headers.AddStrings(AHeaders);
          break;
        end else
        begin
          Line := StringReplace(Line, EOL, '', []);
          AHeaders.Add(StringReplace(Line, ': ', '=', []));
        end;
      end;
    finally
      AHeaders.Free;
    end;  
  end;

  procedure SkipMimeBoundary;
  var
    MimeStr: string;
  begin
    if (FLastMimeBoundary = '') or (not SameMimeBoundary(FLastMimeBoundary, MimeBoundary)) then
    begin
      while ((MimeStr = '') or (MimeStr = eol)) and (MimeStream.SourceStream.Position < MimeStream.SourceStream.Size) do
      begin
        MimeStr := ReadLine(MimeStream.SourceStream);
      end;
    end;
    Done := MimeStream.SourceStream.Position >= MimeStream.SourceStream.Size;
  end;

begin
  if TempDir = '' then
    TempDir := GetTempDir;
  TempFileName := TempDir + BorlandTempFile;

  { The MimeBoundary may come from a parameter }
  if Pos('multipart/related', LowerCase(AMimeBoundary)) = 1 then  { do not localize }
    { received ContentType, not MimeBoundary }
    FMimeBoundary := GetMimeBoundaryFromType(AMimeBoundary)
  else
    FMimeBoundary := AMimeBoundary;

  if FMimeBoundary = '' then
    exit;

  ASourceStream.Seek(0, 0);
  MimeStream := TMimeStreamHolder.Create;
  try
    MimeStream.SourceStream := ASourceStream;
    SkipMimeBoundary;
    Done := False;
    HaveEnvelope := False;
    while not Done do
    begin
      GetHeaders;
      if MimeStream.Headers.Count = 0 then
        break;
      if not HaveEnvelope then
      begin
        HaveEnvelope := True;
        if MimeStream.Headers.Count > 0 then
        begin
          if Assigned(SoapHeaders) then
            SoapHeaders.AddStrings(MimeStream.Headers);
        end;
        ADestStream.Position := 0;
        ReadBody(ADestStream, Done);
        SkipMimeBoundary;
      end else
      begin
        Attachment := TSOAPAttachmentData.Create;
        AttachFileName := TempFileName;
        TargetHandle := GetTempHandle(AttachFileName);
        if TargetHandle = -1 then
          RaiseLastOSError;
        try
          Target := THandleStream.Create(TargetHandle);
          try
            Attachment.ID := MimeStream.Headers.Values[SContentID];
            if Attachment.ID = '' then  { if not ContentID, ID is location }
              Attachment.ID := MimeStream.Headers.Values[SContentLocation];
            Attachment.Headers.AddStrings(MimeStream.Headers);
            ReadBody(Target, Done);
            Attachment.SetCacheFile(AttachFileName);
            DoOnGetAttachment(Target, Attachment);
            FreeAndNil(Target);
            Attachment.DataContext := Nil;
            Attachment.ContentType := MimeStream.Headers.Values[SContentType];
            Attachment.Encoding := MimeStream.Headers.Values[SCharacterEncoding];
            Attachments.Add(Attachment);
            SkipMimeBoundary;
          finally
            if Assigned(Target) then
              FreeAndNil(Target);
          end;
        finally
          FileClose(TargetHandle);
        end;
      end;
    end;
  finally
    MimeStream.SourceStream := Nil;
    MimeStream.Free;
  end;
end;

procedure TMimeAttachmentHandler.DoOnSendAttachment(AttachmentStream: TStream;
                                                    Attachment: TSOAPAttachment);
begin
  if Assigned(FOnSendAttachment) then
    FOnSendAttachment(AttachmentStream, Attachment);
end;

procedure TMimeAttachmentHandler.DoOnGetAttachment(AttachmentStream: TStream;
                                                    Attachment: TSOAPAttachment);
begin
  if Assigned(FOnGetAttachment) then
    FOnGetAttachment(AttachmentStream, Attachment);
end;

procedure TMimeAttachmentHandler.AddSoapHeader(Value: string);
begin
  FSoapHeaders.Add(Value);
end;

procedure TMimeAttachmentHandler.CreateMimeStream(Envelope: TStream; Attachments: TSoapDataList);
begin
  { Free any current Envelope stream }
  { And copy one passed in }
  FSoapEnvelope.Free;
  FSoapEnvelope := TMemoryStream.Create;
  FSoapEnvelope.CopyFrom(Envelope, 0);

  CreateAttachmentStream(Attachments);

  FMimeBoundary := SBorlandMimeBoundary;
end;

{ store Attachments as AggregatedStream member FAttachmentsStream }
procedure TMimeAttachmentHandler.CreateAttachmentStream(Attachments: TSoapDataList);
const
  MimeStart = '--';
var
  Header: string;
  I, J: Integer;
  Stream: TStream;
  Boundary : string;
  Attachment: TSOAPAttachmentData;
  Owner: TStreamOwnership;
begin
  FMimeBoundary := SBorlandMimeBoundary;
  Boundary := MimeStart + FMimeBoundary;
  if FAttachmentsStream.Size > 0 then
    FAttachmentsStream.ClearStream(True);
  if Attachments.Count = 0 then
  begin
    FAttachmentsStream.AddStream(EOL + Boundary + '--');       { do not localize }
    exit;
  end;
  for I := 0 to Attachments.Count -1 do
  begin
    Attachment := TSOAPAttachmentData(Attachments[I]);
    Header := EOL + Boundary + EOL;
    Owner := soOwned;
    if Attachment.CacheFile <> '' then
      Stream := TFileStream.Create(Attachment.CacheFile, fmOpenRead)
    else if Assigned(Attachment.SourceStream) then
    begin
      Stream := Attachment.SourceStream;
      Owner := Attachment.Ownership;
    end else
    begin
      Stream := TMemoryStream.Create;
      Stream.Write(Attachment.SourceString[1], Length(Attachment.SourceString));
    end;
    DoOnSendAttachment(Stream, Attachment);
    for J := 0 to Attachment.Headers.Count -1 do
      Header := Header + Attachment.Headers.Strings[J]+ EOL;
    Header := Header + Format('Content-Length: %d' + EOL, [Stream.Size]);           { do not localize }
    if Attachment.ContentType <> '' then
      Header := Header + Format(ContentTypeTemplate, [Attachment.ContentType]) + EOL { do not localize }
    else
      Header := Header + Format(ContentTypeTemplate, [ContentTypeApplicationBinary]) + EOL; { do not localize }
    if Attachment.Encoding <> '' then
      Header := Header + Format(SCharacterEncodingFormat, [Attachment.Encoding]) + EOL;
    FAttachmentsStream.AddStream(Header + EOL);
    FAttachmentsStream.AddStream(Stream, Owner);     // TAggregateStreams takes care of freeing
    { if ownership is soOwned, Stream will be freed by TAggregatedStream }
    Attachment.Ownership := soReference;
    if I = Attachments.Count -1 then                 // unless Owner is soReference
      FAttachmentsStream.AddStream(EOL + Boundary + '--')                           { do not localize }
    else
      FAttachmentsStream.AddStream(EOL);
  end;
end;

type

  TMimeAttachHandlerImpl = class(TInterfacedObject, IMimeAttachmentHandler)
  private
    FMimeAttachmentHandler: TMimeAttachmentHandler;
  public
    constructor Create;
    destructor Destroy; override;

    { IMimeAttachmentHandler }
    procedure ProcessMultiPartForm(
                const ASourceStream, ADestStream: TStream;
                AMimeBoundary: string; SoapHeaders: TStrings;
                Attachments: TSoapDataList; TempDir: string);

    { Add a new Soap Header  }
    procedure AddSoapHeader(Value: string);
    procedure CreateMimeStream(Envelope: TStream; Attachments: TSoapDataList(*; WebNode: IWebNode*));
    { combine MimeBoundary, Soap Headers and Envelope, and Attachments into single Stream }
    procedure FinalizeStream;

    function  GetMIMEStream(Release: Boolean = False): TStream;
    function  GetMIMEBoundary: string;
    procedure SetMIMEBoundary(const MimeBndry: string);

    function  GetOnSendAttachmentEvent: TOnSendAttachmentEvent;
    procedure SetOnSendAttachmentEvent(OnSendAttachment: TOnSendAttachmentEvent);
    function  GetOnGetAttachmentEvent: TOnGetAttachmentEvent;
    procedure SetOnGetAttachmentEvent(OnGetAttachment: TOnGetAttachmentEvent);
  end;

function GetMimeAttachmentHandler(const ContentType: String): IMimeAttachmentHandler;
begin
  Result := TMimeAttachHandlerImpl.Create;
end;

function GetMimeAttachmentHandler(const BindingType: TWebServiceBindingType): IMimeAttachmentHandler;
begin
  Result := TMimeAttachHandlerImpl.Create;
end;


{ TMimeAttachHandlerImpl }

constructor TMimeAttachHandlerImpl.Create;
begin
  FMimeAttachmentHandler := TMimeAttachmentHandler.Create;
  inherited;
end;

destructor TMimeAttachHandlerImpl.Destroy;
begin
  inherited;
  FMimeAttachmentHandler.Free;
end;

procedure TMimeAttachHandlerImpl.AddSoapHeader(Value: string);
begin
  FMimeAttachmentHandler.AddSoapHeader(Value);
end;

procedure TMimeAttachHandlerImpl.CreateMimeStream(Envelope: TStream;
  Attachments: TSoapDataList);
begin
  FMimeAttachmentHandler.CreateMimeStream(Envelope, Attachments);
end;

procedure TMimeAttachHandlerImpl.FinalizeStream;
begin
  FMimeAttachmentHandler.FinalizeStream;
end;

function TMimeAttachHandlerImpl.GetMIMEStream(Release: Boolean): TStream;
begin
  Result := FMimeAttachmentHandler;
  if Release then
    FMimeAttachmentHandler := Nil;
end;

procedure TMimeAttachHandlerImpl.ProcessMultiPartForm(const ASourceStream,
  ADestStream: TStream; AMimeBoundary: string; SoapHeaders: TStrings;
  Attachments: TSoapDataList; TempDir: string);
begin
  FMimeAttachmentHandler.ProcessMultiPartForm(ASourceStream, ADestStream, AMimeBoundary,
                                              SoapHeaders, Attachments, TempDir);
end;

function TMimeAttachHandlerImpl.GetOnGetAttachmentEvent: TOnGetAttachmentEvent;
begin
  Result := FMimeAttachmentHandler.OnGetAttachment;
end;

function TMimeAttachHandlerImpl.GetOnSendAttachmentEvent: TOnSendAttachmentEvent;
begin
  Result := FMimeAttachmentHandler.OnSendAttachment;
end;

procedure TMimeAttachHandlerImpl.SetOnGetAttachmentEvent(
  OnGetAttachment: TOnGetAttachmentEvent);
begin
  FMimeAttachmentHandler.OnGetAttachment := OnGetAttachment;
end;

procedure TMimeAttachHandlerImpl.SetOnSendAttachmentEvent(
  OnSendAttachment: TOnSendAttachmentEvent);
begin
  FMimeAttachmentHandler.OnSendAttachment := OnSendAttachment;
end;

function TMimeAttachHandlerImpl.GetMIMEBoundary: String;
begin
  Result := FMimeAttachmentHandler.FMimeBoundary;
end;

procedure TMimeAttachHandlerImpl.SetMIMEBoundary(const MimeBndry: String);
begin
  FMimeAttachmentHandler.FMimeBoundary := MimeBndry;
end;

end.
