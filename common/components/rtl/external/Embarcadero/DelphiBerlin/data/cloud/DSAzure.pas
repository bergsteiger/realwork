{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzure deprecated;

interface

uses System.Classes, System.SysUtils, System.JSON, IdAuthentication,
  IdHTTP,
  IdHTTPServer,
  IdAssignedNumbers,
  IdContext,
  IdCustomHTTPServer,
  Data.DBXCommon,
  Data.DBXCommonIndy,
  System.Generics.Collections
;

const
  BlobPublicAccessContainer = 'container';
  BlobPublicAccessBlob = 'blob';

type

  TAzureConnectionString = class(TComponent)
  private
    FUseDevelopmentStorage: boolean;
    FAccountName: String;
    FAccountKey: String;
    FUseDefaultEndpoints: boolean;
    FBlobEndpoint: String;
    FQueueEndpoint: String;
    FTableEndpoint: String;
    FProtocol: String;

  private
    procedure SetUseDevelopmentStorage(use: boolean);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function BlobURL: String;
    function TableURL: String;
    function QueueURL: String;

  published
    property UseDevelopmentStorage: boolean read FUseDevelopmentStorage write SetUseDevelopmentStorage;
    property AccountName: string read FAccountName write FAccountName;
    property AccountKey: string read FAccountKey write FAccountKey;
    property UseDefaultEndpoints: boolean read FUseDefaultEndpoints write FUseDefaultEndpoints;
    property BlobEndpoint: string read FBlobEndpoint write FBlobEndpoint;
    property QueueEndpoint: string read FQueueEndpoint write FQueueEndpoint;
    property TableEndpoint: string read FTableEndpoint write FTableEndpoint;
    property Protocol: string read FProtocol write FProtocol;
  end;

  TSharedKeyAuthorization = class(TIdBasicAuthentication)
  private
    FStringToSign: String;
    FSHAKey: TArray<Byte>;
  protected
    class function IsHMAC_SHA256Avail: boolean;
    function HMAC_SHA256(const StringToSign: String): TArray<Byte>;
  public
    function Authentication: String; override;
    procedure SetSHAKey(const Key: String);
    property StringToSign: String read FStringToSign write FStringToSign;
  end;

  TAccessPolicy = record
    Start: String;
    Expiry: String;
    PermRead: boolean;
    PermWrite: boolean;
    PermDelete:boolean;
    PermList: boolean;

    function GetPermission: String;
    procedure SetPermission(const rwdl: String);
    function AsXML: String;

    class function Create: TAccessPolicy; static;

    property Permission: string read GetPermission write SetPermission;
  end;
  TAccessPolicyArray = array of TAccessPolicy;

  TSignedIdentifier = class
  private
    FId: String;
    FAccount: String;
    FSharedKey: String;
    FResource: String;

  protected
    function CanonicalizedResource: String;
    function HMAC_SHA256(const StringToSign: String): TArray<Byte>;

  public
    AccessPolicy: TAccessPolicy;

    constructor Create(const Account: String; const SharedKey: String; const Resource: String); overload;
    constructor Create(const Account: String; const SharedKey: String; const Resource: String; Policy: TAccessPolicy); overload;

    function AsXML: String; virtual;
    function Signature: String; virtual;
    function SI: String;
    function Sig: String;
    property Id: String read FId write FId;
  end;

  TAzureHTTP = class;

  TAzureService = class
  private
    FConnectionString: TAzureConnectionString;
    FDSHTTP: TAzureHTTP;
    FSharedKeyAuth: TSharedKeyAuthorization;
    FReturnCode: Integer; // last returned code
  private
    class function VarRecToString(rec: TVarRec): String;
  protected
    function QueryParams(Params: array of const; Values: array of const): String; overload;
    function QueryParams(Params: array of const; Values: array of const; UserParams: array of const;
                         UserValues: array of const): String; overload;
    function CanonicalizedQueryParams(aParams: array of const; aValues: array of const;
                                      aUserParams: array of const; aUserValues: array of const): String;
    function GetResponseETag: String;
    function GetResponseLastModified: TDateTime;
    function GetResponseDate: TDateTime;
    function GetResponseHeader(const Header: String): String;
    function GetResponseHeaderExists(const Header: String): Boolean;

    function GetResponseText: String;
    function GetResponse(Url: String): String;

    procedure CleanUpHeaders;
  public
    constructor Create(AConnectionString: TAzureConnectionString); virtual;
    destructor Destroy; override;

    procedure Reset;

    function XMsVersion: String;
    function XMsDate: String;

    function StringToSign(const VERB: String; const RequestHeaders: array of const;
               const CanonicalizedHeadersName: array of const; const CanonicalizedHeadersValue: array of const;
               const CanonicalizedResource: array of const): String; overload; virtual;
    function StringToSign(const VERB: String; const RequestHeaders: array of const;
               Headers: TStringList;
               const CanonicalizedResource: array of const): String; overload; virtual;

    procedure PopulateContainer(const Prefix: String; const container: TStrings;
                                ExcludePrefixInKeys: Boolean = False);

    class procedure SetUp;
    class function Encode(const Str: String): String;
    class function Decode(const Str: String): String;
    class function URLEncode(const Str: String): String;

    property ReturnCode: Integer read FReturnCode;
    property ETag: String read GetResponseETag;
    property ResponseDate: TDateTime read GetResponseDate;
    property LastModified: TDateTime read GetResponseLastModified;
    property ResponseHeader[const Header: String]: String read GetResponseHeader;
    property ResponseHeaderExists[const Header: String]: Boolean read GetResponseHeaderExists;

    property ResponseText: String read GetResponseText;
  end;

  /// <summary>API for working with a Microsoft Azure blob service.</summary>
  TAzureBlobService = class(TAzureService)
  private
    function ListContainers(extraQueryParams: String): String; overload;
  public
    constructor Create(AConnectionString: TAzureConnectionString); override;

    function ListContainers: String; overload;
    function ListContainers(Params: array of const; Values: array of const): String; overload;
    function CreateContainer(ContainerName: String; const PublicAccess: String = BlobPublicAccessContainer): boolean; overload;
    function CreateContainer(ContainerName: String; const MetaDataHeaders: TStringList; const PublicAccess: String = BlobPublicAccessContainer): boolean; overload;
    function CreateRootContainer(const PublicAccess: String = BlobPublicAccessContainer): boolean;
    function DeleteContainer(const ContainerName: String): boolean;
    function DeleteRootContainer: boolean;
    function GetContainerProperties(const ContainerName: String): boolean;
    function GetContainerMetadata(const ContainerName: String): boolean;
    function SetContainerMetadata(const ContainerName: String; const MetaDataHeaders: TStringList): boolean;
    function GetContainerACL(const ContainerName: String): String;
    function SetContainerACL(const ContainerName: String; const Id: String; AccessPolicy: TAccessPolicy;
                             const PublicAccess: String = BlobPublicAccessContainer): boolean;

    function ListBlobs(const ContainerName: String; Params: array of const; Values: array of const): String;
    function PutBlockBlob(const ContainerName, BlobName: String; Content: TArray<Byte>;
                          const LeaseId: String = '';
                          const UserHeaders: TStringList = nil;
                          const ContentType: String = 'application/octet-stream';
                          const ContentEncoding: String = ''; const ContentLanguage: String = '';
                          const ContentMD5: String = ''; const CacheControl: String = ''): boolean;
    function PutPageBlob(const ContainerName: String; const BlobName: String; BlobSize: int64; BlobSeqNb: int64 = 0;
                         const UserHeaders: TStringList = nil;
                         const ContentType: String = 'application/octet-stream';
                         const ContentEncoding: String = ''; const ContentLanguage: String = '';
                         const ContentMD5: String = ''; const CacheControl: String = ''): boolean;
    function GetBlob(const ContainerName: String; const BlobName: String; ResponseContent: TStream; const Snapshot: String = ''; StartByte: int64 = 0;
                          EndByte: int64 = 0; const LeaseId: String = ''; GetMD5: boolean = false): boolean;
    function DeleteBlob(const ContainerName: String; const BlobName: String; const Snapshot: String = '';
                        const LeaseId: String = ''; const DeleteSnapshots: String = ''): boolean;
    function PutBlock(const ContainerName: String; const BlobName: String; const BlockId: String;
                      Content: TArray<Byte>;  const LeaseId: String = '';  const ContentMD5: String = ''): boolean;
    function PutPage(const ContainerName: String; const BlobName: String; Content: TArray<Byte>; StartByte: int64;
                     EndByte: int64; PageWrite: String = 'update'; const ContentMD5: String = '';
                     const LeaseId: String = ''; const IfSeqNbLte: String = ''; const IfSeqNbLe: String = '';
                     const IfSeqNbEq: String = ''; const IfModifiedSince: String = '';
                     const IfUnmodifiedSince: String = ''; const IfMatch: String = '';
                     const IfNoneMatch: String = ''): boolean;
    function CopyBlob(const ContainerName: String; const BlobName: String; const SourceContainer: String; const SourceBlob: String;
               const SourceSnapshot: String = ''; const SourceIfModifiedSince: String = '';
               const SourceIfUnmodifiedSince: String = ''; const SourceIfMatch: String = '';
               const SourceIfNoneMatch: String = ''; const IfModifiedSince: String = '';
               const IfUnmodifiedSince: String = ''; const IfMatch: String = '';
               const IfNoneMatch: String = ''; const SourceLeaseId: String = '';
               const LeaseId: String = ''; const MetaHeaders: TStringList = nil): boolean;
    function LeaseBlob(const ContainerName: String; const BlobName: String; const LeaseAction: String = 'acquire';
               const LeaseId: String = ''): String;
    function SnapshotBlob(const ContainerName: String; const BlobName: String; const IfModifiedSince: String = '';
               const IfUnmodifiedSince: String = ''; const IfMatch: String = '';
               const IfNoneMatch: String = ''; const LeaseId: String = ''; const MetaHeaders: TStringList = nil): String;
    function GetPageRegions(const ContainerName: String; const BlobName: String; const Snapshot: String = '';
               StartByte: int64 = 0; EndByte: int64 = 0; const LeaseId: String = ''): String;
    function GetBlockList(const ContainerName: String; const BlobName: String; const BlockListType: String = '';
               const Snapshot: String = ''; const LeaseId: String = ''): String;
    function PutBlockList(const ContainerName: String; const BlobName: String; const BlockList: String;
               const ContentMD5: String = ''; const BlobCacheControl: String = '';
               const BlobContentType: String = ''; const BlobContentEncoding: String = '';
               const BlobContentLanguage: String = ''; const BlobContentMD5: String = '';
               const LeaseId: String = ''; const MetaHeaders: TStringList = nil): boolean;
    function GetBlobProperties(const ContainerName: String; const BlobName: String;
               const Snapshot: String = ''; const LeaseId: String = ''): boolean;
    function SetBlobProperties(const ContainerName: String; const BlobName: String;
               const BlobCacheControl: String = ''; const BlobContentType: String = '';
               const BlobContentEncoding: String = ''; const BlobContentLanguage: String = '';
               const BlobContentMD5: String = ''; const LeaseId: String = ''): boolean;
    function SetPageBlobProperties(const ContainerName: String; const BlobName: String;
               const BlobCacheControl: String = ''; const BlobContentType: String = '';
               const BlobContentEncoding: String = ''; const BlobContentLanguage: String = '';
               const BlobContentMD5: String = ''; const BlobContentLength: String = '';
               const SeqNbAction: String = ''; const BlobSeqNumber: String = '';
               const LeaseId: String = ''): boolean;
    function GetBlobMetadata(const ContainerName: String; const BlobName: String;
               const Snapshot: String = ''; const LeaseId: String = ''): boolean;
    function SetBlobMetadata(const ContainerName: String; const BlobName: String;
               const MetaHeaders: TStringList; const LeaseId: String = ''): boolean;

    procedure PopulateContainerProperties(Props: TStrings);
    function IsProperty(Name: String): Boolean;
  end;

  /// <summary>API for working with a Microsoft Azure table service.</summary>
  TAzureTableService = class(TAzureService)
  protected
    function UpdatedDate: String;
  public
    constructor Create(AConnectionString: TAzureConnectionString); override;

    function QueryTables(const StartingTable: String = ''): String;
    function QueryEntities(const TableName: String; const FilterExpression: String = ''): String; overload;
    function QueryEntities(const TableName: String; const PartitionKey: String; const RowKey: String): String; overload;
    function CreateTable(const TableName: String): boolean;
    function DeleteTable(const TableName: String): boolean;
    function InsertEntity(const TableName: String; entity: TJSONObject): string;
    function UpdateEntity(const TableName: String; entity: TJSONObject): boolean;
    function MergeEntity(const TableName: String; entity: TJSONObject): boolean;
    function DeleteEntity(const TableName: String; const PartitionKey: String; const RowKey: String): boolean;
  end;

  /// <summary>API for working with a Microsoft Azure queue service.</summary>
  TAzureQueueService = class(TAzureService)
  private
    function XMLText(const xml: String; const NodeName: String): String;
  public
    function ListQueues(params: array of const; values: array of const): String;
    function CreateQueue(const QueueName: String): boolean; overload;
    function CreateQueue(const QueueName: String; const MetaDataHeaders: TStringList): boolean; overload;
    function DeleteQueue(const QueueName: String): boolean;
    function GetQueueMetadata(const QueueName: String): boolean;
    function PutQueueMetadata(const QueueName: String; const MetaDataHeaders: TStringList): boolean;
    function PutMessage(const QueueName: String; const MessageText: String; const TimeToLive: Integer = 0): boolean;
    function GetMessages(const QueueName: String; NumOfMessages: Integer = 0; VisibilityTimeout: Integer = 0): String;
    function PeekMessages(const QueueName: String; NumOfMessages: Integer): String;
    function DeleteMessage(const QueueName: String; const MessageId: String; const PopReceipt: String): boolean;
    function ClearMessages(const QueueName: String): boolean;

    function GetPopReceipt(const QueueMessage: String): String;
    function GetMessageId(const QueueMessage: String): String;
  end;

  ///  <summary> Provides HTTP client functionality
  ///  </summary>
  TAzureHTTP = class(TIdHTTP)
  private
    FAuthentication: TIdAuthentication;
    FProtocol: string;
  protected
    procedure InitComponent; override;
  public
    constructor Create; overload;

    ///  <summary> Sends a DELETE command type request. It returns the response.
    ///  </summary>
    ///  <param name="AURL">URL where the delete command is sent</param>
    ///  <returns>Server response</returns>
    function Delete(AURL: string): string; overload;
    function Delete(AURL: string; AResponseStream: TStream): string; overload;
    procedure Merge(AURL: string; RequestStream: TStream);
    procedure Head(AURL: string);
    ///  <summary>PUT command with empty content</summary>
    function Put(AURL: string): string; overload;
    procedure SetBasicAuthentication(const user: String; const password: String);
    procedure SetAuthentication(auth: TIdAuthentication);
    property Protocol: string read FProtocol write FProtocol;
  end;

implementation

uses System.DateUtils, System.StrUtils, IdFIPS, IdURI, IdSSLOpenSSLHeaders, Data.DBXClientResStrs,
 IdGlobal;

const
  Codes64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  Pad = '=';

type
  TCompareByIndex = reference to procedure(I,J: Integer; var Ord: Integer);
  TSwapByIndex = reference to procedure(I,J: Integer);

function EncodeBytes64(asBytes: TArray<Byte>): String;
var
  bitIdx: Integer;
  data: Integer;
  remainder: Integer;
  count: Integer;
  i: Integer;
begin
  bitIdx := 0;
  remainder := 0;
  count := Length(asBytes);
  for i := 0 to count - 1 do
  begin
    data := Ord(asBytes[i]);
    remainder := (remainder shl 8) or data;
    bitIdx := bitIdx + 8;
    while bitIdx >= 6 do
    begin
      bitIdx := bitIdx - 6;
      data := remainder div (1 shl bitIdx);
      remainder := remainder mod (1 shl bitIdx);
      Result := Result + Codes64[data + 1];
    end;
  end;
  if bitIdx > 0 then
  begin
    data := remainder shl (6 - bitIdx);
    Result := Result + Codes64[data + 1];
  end;
  case count mod 3 of
    1: Result := Result + Pad + Pad;
    2: Result := Result + Pad;
  end;
end;

function Encode64(S: string): string;
begin
  Result := EncodeBytes64(TEncoding.UTF8.GetBytes(S));
end;

function DecodeBytes64(S: String): TArray<Byte>;
var
  i: Integer;
  a: Integer;
  enc: Integer;
  b: Integer;
  encLen: Integer;
  byteLen: Integer;
  utf8Idx: Integer;
begin
  encLen := Length(S);
  byteLen := (encLen shr 2) * 3;
  if S[encLen] = Pad then
  begin
    byteLen := byteLen - 1;
    if S[encLen-1] = Pad then
      byteLen := byteLen - 1;
  end;
  SetLength(Result, byteLen);
  utf8Idx := 0;
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    enc := Pos(s[i], codes64) - 1;
    if enc >= 0 then
    begin
      b := (b shl 6) or enc;
      a := a + 6;
      if a >= 8 then
      begin
        a := a - 8;
        enc := b shr a;
        b := b mod (1 shl a);
        enc := enc and 255;

        Assert(utf8Idx < byteLen);
        Result[utf8Idx] := enc;
        utf8Idx := utf8Idx + 1;
      end;
    end
    else
      Break;
  end;
  Assert(utf8Idx = byteLen);
end;

function Decode64(S: string): string;
var
  utf8Bytes: TArray<Byte>;
begin
  utf8Bytes := DecodeBytes64(S);
  Result := TEncoding.UTF8.GetString(utf8Bytes);
end;

procedure QuickSort(L,R: Integer; SCompare: TCompareByIndex; ExchangeItems: TSwapByIndex);
var
  I, J, P, Ord: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      SCompare(I, P, Ord);
      while Ord < 0 do
      begin
        Inc(I);
        SCompare(I, P, Ord);
      end;
      SCompare(J, P, Ord);
      while Ord > 0 do
      begin
        Dec(J);
        SCompare(J, P, Ord);
      end;
      if I <= J then
      begin
        if I <> J then
          ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare, ExchangeItems);
    L := I;
  until I >= R;
end;

{ TAzureConnectionString }

function TAzureConnectionString.BlobURL: String;
var
  url: String;
begin
  if UseDevelopmentStorage then
    url := '127.0.0.1:10000/devstoreaccount1'
  else if UseDefaultEndpoints then
    url := Format('%s.blob.core.windows.net', [AccountName])
  else
    url := BlobEndpoint;
  Result := Format('%s://%s', [Protocol, url]);
end;

constructor TAzureConnectionString.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FUseDevelopmentStorage := false;
  FUseDefaultEndpoints := true;
  FProtocol := 'http';
end;

destructor TAzureConnectionString.Destroy;
begin
  inherited;
end;

function TAzureConnectionString.QueueURL: String;
var
  url: String;
begin
  if UseDevelopmentStorage then
    url := '127.0.0.1:10001/devstoreaccount1'
  else if UseDefaultEndpoints then
    url := Format('%s.queue.core.windows.net', [AccountName])
  else
    url := QueueEndpoint;
  Result := Format('%s://%s', [Protocol, url]);
end;

procedure TAzureConnectionString.SetUseDevelopmentStorage(use: boolean);
begin
  FUseDevelopmentStorage := use;
  if use then
  begin
    FAccountName := 'devstoreaccount1';
    FAccountKey := 'Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==';
  end else begin
    FAccountName := EmptyStr;
    FAccountKey := EmptyStr;
  end;
end;

function TAzureConnectionString.TableURL: String;
var
  url: String;
begin
  if UseDevelopmentStorage then
    url := '127.0.0.1:10002/devstoreaccount1'
  else if UseDefaultEndpoints then
    url := Format('%s.table.core.windows.net', [AccountName])
  else
    url := BlobEndpoint;
  Result := Format('%s://%s', [Protocol, url]);
end;

{ TAzureService }

type
  TVarRecArray = array of TVarRec;

function CreateRecArray(Elements: array of const): TVarRecArray;
var
  I, L: Integer;
begin
  L := Low(Elements);
  SetLength( Result, Length(Elements));
  for I := Low(Elements) to High(Elements) do
    Result[I-L] := Elements[I];
end;

function StrValueOf(Params: array of const; UserParams: array of const; K: Integer; ParamCount, LowParam, ParamOffset: Integer): String;
begin
  if K < ParamCount then
    Exit(TAzureService.VarRecToString(Params[LowParam + K]))
  else
    Exit(TAzureService.VarRecToString(UserParams[ParamOffset + K]));
end;

function TAzureService.CanonicalizedQueryParams(aParams, aValues, aUserParams,
  aUserValues: array of const): String;
var
  count: Integer;
  idx: array of Integer;
  I: Integer;
  paramCount, userParamCount: Integer;
  lowParam, lowUserParam, paramOffset: Integer;
  lowValue, lowUserValue, valueOffset: Integer;
  Params, Values, UserParams, UserValues: TVarRecArray;
  lastParam, nextParam: String;
  function ParamOf(K: Integer): String;
  begin
    Exit(StrValueOf(Params, UserParams, K, paramCount, lowParam, paramOffset));
  end;
  function ValueOf(K: Integer) : String;
  begin
    Exit(StrValueOf(Values, UserValues, K, paramCount, lowValue, valueOffset));
  end;
begin
  Params := CreateRecArray(aParams);
  Values := CreateRecArray(aValues);
  UserParams := CreateRecArray(aUserParams);
  UserValues := CreateRecArray(aUserValues);
  lowParam := Low(Params);
  lowUserParam := Low(UserParams);
  paramCount := High(Params) - lowParam + 1;
  userParamCount := High(UserParams) - lowUserParam + 1;
  paramOffset := lowUserParam - paramCount;
  count := paramCount + userParamCount;
  if count <= 0 then
    Exit(EmptyStr);
  lowValue := Low(Values);
  lowUserValue := Low(UserValues);
  valueOffset := lowUserValue - paramCount;
  // create the index
  SetLength(idx, count);
  for I := 0 to Count - 1 do
    idx[I] := I;
  // sort the index
  if count > 1 then
    QuickSort(0, count - 1, procedure(I, J: Integer; var K: Integer) begin
        K := AnsiCompareStr(StrValueOf(Params, UserParams, idx[I], paramCount, lowParam, paramOffset),
                          StrValueOf(Params, UserParams, idx[J], paramCount, lowParam, paramOffset))
      end, procedure(I,J: Integer) var swap: Integer; begin
        swap := idx[I]; idx[I] := idx[J]; idx[J] := swap;
      end);
  // buid the result
  lastParam := ParamOf(idx[0]);
  Result := Format('%s:%s', [lastParam,
                             ValueOf(idx[0])]);
  for I := 1 to Count - 1 do
  begin
    nextParam := ParamOf(idx[I]);
    if AnsiCompareText(lastParam, nextParam) = 0 then
      Result := Result + Format(',%s', [ValueOf(idx[I])])
    else begin
      Result := Result + Format(#10'%s:%s', [nextParam, ValueOf(idx[I])]);
      lastParam := nextParam
    end;
  end
end;

procedure TAzureService.CleanUpHeaders;
begin
  FDSHTTP.Request.ContentType := '';
  FDSHTTP.Request.ContentLanguage := '';
  FDSHTTP.Request.ContentEncoding := '';
  FDSHTTP.Request.ContentRangeEnd := -1;
  FDSHTTP.Request.ContentRangeStart := -1;
  FDSHTTP.Request.ContentVersion := '';
  FDSHTTP.Request.RawHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
end;

constructor TAzureService.Create(AConnectionString: TAzureConnectionString);
begin
  inherited Create;
  Reset();

  FConnectionString := AConnectionString;

  FSharedKeyAuth := TSharedKeyAuthorization.Create;
  FSharedKeyAuth.Username := AConnectionString.AccountName;
  try
    FSharedKeyAuth.SetSHAKey(AConnectionString.AccountKey);
  except
    raise Exception.Create(SAzureInvalidAcctKey);
  end;
end;

class function TAzureService.Decode(const Str: String): String;
begin
  Result := Decode64(Str);
end;

destructor TAzureService.Destroy;
begin
  FreeAndNil(FDSHTTP);
  FreeAndNil(FSharedKeyAuth);

  inherited;
end;

class function TAzureService.Encode(const Str: String): String;
begin
  Result := Encode64(Str);
end;

function TAzureService.GetResponse(Url: String): String;
var
  MemoryStream: TStream;
  Reader: TStreamReader;
begin
  MemoryStream := TMemoryStream.Create;
  try
    FDSHTTP.Get(Url, MemoryStream);
    MemoryStream.Position := 0;
    Reader := TStreamReader.Create(MemoryStream, True (* Detect BOM *));
    try
      Result := Reader.ReadToEnd;
    finally
      Reader.Free;
    end;
  finally
    MemoryStream.Free;
end;

end;

function TAzureService.GetResponseDate: TDateTime;
begin
  Result := FDSHTTP.Response.Date;
end;

function TAzureService.GetResponseETag: String;
begin
  Result := FDSHTTP.Response.ETag;
end;

function TAzureService.GetResponseHeader(const Header: String): String;
begin
  Result := FDSHTTP.Response.RawHeaders.Values[Header];
end;

function TAzureService.GetResponseHeaderExists(const Header: String): Boolean;
begin
  Result := FDSHTTP.Response.RawHeaders.IndexOfName(Header) > -1;
end;

function TAzureService.GetResponseLastModified: TDateTime;
begin
  Result := FDSHTTP.Response.LastModified;
end;

function TAzureService.GetResponseText: String;
begin
  Result := FDSHTTP.Response.ResponseText;
end;

procedure TAzureService.PopulateContainer(const Prefix: String;
  const container: TStrings; ExcludePrefixInKeys: Boolean);
var
  i, count: Integer;
  name: String;
  nameToUse: String;
begin
  count := FDSHTTP.Response.RawHeaders.Count;
  for i := 0 to count - 1 do
  begin
    name := FDSHTTP.Response.RawHeaders.Names[i];
    if Pos(Prefix, name) = 1 then
    begin
      if ExcludePrefixInKeys and (Length(name) > Length(Prefix))then
        nameToUse := Copy(name, Length(Prefix) + 1)
      else
        nameToUse := name;
      container.Values[nameToUse] := FDSHTTP.Response.RawHeaders.Values[name]
    end;
  end;
end;

function TAzureService.QueryParams(Params, Values, UserParams,
  UserValues: array of const): String;
var
  idx: Integer;
  vidx: Integer;
  count: Integer;
  andKey: String;
begin
  Result := '';
  count := Length(Params) + Length(UserParams);
  if count <= 0 then
    Exit(Result);
  Result := '?';
  vidx := Low(Values);
  for idx := Low(Params) to High(Params) do
  begin
    Result := Result + Format('%s%s=%s', [andKey, URLEncode(VarRecToString(Params[idx])),
                                           URLEncode(VarRecToString(Values[vidx]))]);
    vidx := vidx + 1;
    andKey := '&';
  end;
  vidx := Low(UserValues);
  for idx := Low(UserParams) to High(USerParams) do
  begin
    Result := Result + Format('%s%s=%s', [andKey, URLEncode(VarRecToString(UserParams[idx])),
                                           URLEncode(VarRecToString(UserValues[vidx]))]);
    vidx := vidx + 1;
    andKey := '&';
  end;
end;

function TAzureService.QueryParams(Params, Values: array of const): String;
begin
  Result := QueryParams(Params, Values, [], []);
end;

procedure TAzureService.Reset;
begin
  FreeAndNil(FDSHTTP);

  FDSHTTP := TAzureHTTP.Create;
  FDSHTTP.HTTPOptions := FDSHTTP.HTTPOptions + [hoKeepOrigProtocol];
end;

function HeaderSortCompare(List: TStringList; Index1,
    Index2: Integer): Integer;
begin
    Result := AnsiCompareStr(AnsiLowerCase(List.Names[Index1]),
                               AnsiLowerCase(List.Names[Index2]))
end;

class procedure TAzureService.SetUp;
begin
  IdSSLOpenSSLHeaders.Load;
  if not TSharedKeyAuthorization.IsHMAC_SHA256Avail then
    raise Exception.Create(SSharedKeyError);
end;

function TAzureService.StringToSign(const VERB: String;
  const RequestHeaders: array of const; Headers: TStringList;
  const CanonicalizedResource: array of const): String;
var
  idx: Integer;
  res: String;
begin
  if not Headers.Sorted then
    Headers.CustomSort(HeaderSortCompare);

  Result := Format('%s'#10, [VERB]);
  for idx := Low(RequestHeaders) to High(RequestHeaders) do
    Result := Result + Format('%s'#10, [VarRecToString(RequestHeaders[idx])]);
  for idx := 0 to Headers.Count - 1 do
    Result := Result + Format('%s:%s'#10, [AnsiLowerCase(Headers.Names[idx]), Headers.ValueFromIndex[idx]]);
  if High(CanonicalizedResource) >= Low(CanonicalizedResource) then
    Result := Result + VarRecToString(CanonicalizedResource[Low(CanonicalizedResource)]);
  for idx := Low(CanonicalizedResource)+1 to High(CanonicalizedResource) do
  begin
    res := VarRecToString(CanonicalizedResource[idx]);
    if Length(res) > 0 then
      Result := Result + Format(#10'%s', [res]);
  end;
  FSharedKeyAuth.StringToSign := Result;
end;

class function TAzureService.URLEncode(const Str: String): String;
var
  eq: String;
begin
  eq := '%' + IntToHex(Ord('='), 2);
  Result := TIdURI.ParamsEncode(Str);
  Result := StringReplace(Result, '=', eq, [rfReplaceAll]);
end;

function TAzureService.StringToSign(const VERB: String; const RequestHeaders,
  CanonicalizedHeadersName, CanonicalizedHeadersValue: array of const;
  const CanonicalizedResource: array of const): String;
var
  idx: Integer;
  vidx: Integer;
  res: String;
begin
  Result := Format('%s'#10, [VERB]);
  for idx := Low(RequestHeaders) to High(RequestHeaders) do
    Result := Result + Format('%s'#10, [VarRecToString(RequestHeaders[idx])]);
  vidx := Low(CanonicalizedHeadersValue);
  for idx := Low(CanonicalizedHeadersName) to High(CanonicalizedHeadersName) do
  begin
    Result := Result + Format('%s:%s'#10, [VarRecToString(CanonicalizedHeadersName[idx]),
                                           VarRecToString(CanonicalizedHeadersValue[vidx])]);
    vidx := vidx + 1;
  end;
  if High(CanonicalizedResource) >= Low(CanonicalizedResource) then
    Result := Result + VarRecToString(CanonicalizedResource[Low(CanonicalizedResource)]);
  for idx := Low(CanonicalizedResource)+1 to High(CanonicalizedResource) do
  begin
    res := VarRecToString(CanonicalizedResource[idx]);
    if Length(res) > 0 then
      Result := Result + Format(#10'%s', [res]);
  end;
  FSharedKeyAuth.StringToSign := Result;
end;

class function TAzureService.VarRecToString(rec: TVarRec): String;
begin
  case rec.VType of
    vtChar:
      Result := '' + rec.VChar;
    vtUnicodeString:
      if rec.VUnicodeString <> nil then
        Result := PWideChar(rec.VUnicodeString)
      else
        Result := EmptyStr;
    vtWideChar:
      Result := rec.VWideChar;
  end;
end;

function TAzureService.XMsDate: String;
begin
  Result := FormatDateTime('ddd, dd mmm yyyy hh:nn:ss "GMT"',
                           TTimeZone.Local.ToUniversalTime(Now),
                           TFormatSettings.Create('en-US'));
end;

function TAzureService.XMsVersion: String;
begin
  Result := '2009-09-19';
end;

{ TAzureBlobService }

function TAzureBlobService.CopyBlob(const ContainerName, BlobName, SourceContainer, SourceBlob,
  SourceSnapshot, SourceIfModifiedSince, SourceIfUnmodifiedSince, SourceIfMatch,
  SourceIfNoneMatch, IfModifiedSince, IfUnmodifiedSince, IfMatch, IfNoneMatch,
  SourceLeaseId, LeaseId: String; const MetaHeaders: TStringList): boolean;
var
  headers: TStringList;
  url: String;
  msDate: String;
  idx: Integer;
begin
  headers := TStringList.Create;
  if MetaHeaders <> nil then
    headers.Assign(MetaHeaders);
  try
    msDate := XMsDate;
    url := Format('%s/%s/%s', [FConnectionString.BlobURL, ContainerName, BlobName]);

    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(SourceSnapshot) > 0 then
      headers.Values['x-ms-copy-source'] := Format('/%s/%s/%s?snapshot=%s', [FConnectionString.AccountName,
                   SourceContainer, SourceBlob, SourceSnapshot])
    else
      headers.Values['x-ms-copy-source'] := Format('/%s/%s/%s', [FConnectionString.AccountName,
                   SourceContainer, SourceBlob]);
    if Length(SourceIfModifiedSince) > 0 then
      headers.Values['x-ms-if-modified-since'] := SourceIfModifiedSince;
    if Length(SourceIfUnmodifiedSince) > 0 then
      headers.Values['x-ms-if-unmodified-since'] := SourceIfUnmodifiedSince;
    if Length(SourceIfMatch) > 0 then
      headers.Values['x-ms-source-if-match'] := SourceIfMatch;
    if Length(SourceIfNoneMatch) > 0 then
      headers.Values['x-ms-source-if-none-match'] := SourceIfNoneMatch;
    if Length(SourceLeaseId) > 0 then
      headers.Values['x-ms-source-lease-id'] := SourceLeaseId;
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;

    StringToSign('PUT', ['', '', '0', '', '', IfModifiedSince, IfMatch, IfNoneMatch, IfUnmodifiedSince, '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    if Length(IfModifiedSince) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Modified-Since', IfModifiedSince);
    if Length(IfUnmodifiedSince) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Unmodified-Since', IfUnmodifiedSince);
    if Length(IfMatch) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Match', IfMatch);
    if Length(IfNoneMatch) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-None-Match', IfMatch);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]),
                                                           headers.ValueFromIndex[idx]);
    try
      try
        FDSHTTP.Put(url);
        Result := FDSHTTP.ResponseCode = 201;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end
end;

constructor TAzureBlobService.Create(AConnectionString: TAzureConnectionString);
begin
  inherited Create(AConnectionString);

end;

function TAzureBlobService.SetBlobMetadata(const ContainerName,
  BlobName: String; const MetaHeaders: TStringList;
  const LeaseId: String): boolean;
var
  url: String;
  msDate: String;
  idx: Integer;
  headers: TStringList;
begin
  headers := TStringList.Create;
  try
    msDate := XMsDate;
    headers.Assign(MetaHeaders);
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName,
                            QueryParams(['comp'], ['metadata'])]);
    CleanUpHeaders;

    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;
    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(['comp'], ['metadata'], [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]),
                                                           headers.ValueFromIndex[idx]);

    Result := false;
    try
      try
        FDSHTTP.Put(url);
        Result := FDSHTTP.ResponseCode = 200;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

function TAzureBlobService.SetBlobProperties(const ContainerName, BlobName,
  BlobCacheControl, BlobContentType, BlobContentEncoding, BlobContentLanguage,
  BlobContentMD5, LeaseId: String): boolean;
var
  url: String;
  msDate: String;
  idx: Integer;
  headers: TStringList;
begin
  headers := TStringList.Create;

  try
    msDate := XMsDate;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName,
                                 QueryParams(['comp'], ['properties'])]);
    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;
    if Length(BlobCacheControl) > 0 then
      headers.Values['x-ms-blob-cache-control'] := BlobCacheControl;
    if Length(BlobContentType) > 0 then
      headers.Values['x-ms-blob-content-type'] := BlobContentType;
    if Length(BlobContentEncoding) > 0 then
      headers.Values['x-ms-blob-content-encoding'] := BlobContentEncoding;
    if Length(BlobContentLanguage) > 0 then
      headers.Values['x-ms-blob-content-language'] := BlobContentLanguage;
    if Length(BlobContentMD5) > 0 then
      headers.Values['x-ms-blob-content-md5'] := BlobContentMD5;

    StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(['comp'], ['properties'], [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]), headers.ValueFromIndex[idx]);

    Result := false;
    try
      try
        FDSHTTP.Put(url);
        Result := FDSHTTP.ResponseCode = 200;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

procedure TAzureBlobService.PopulateContainerProperties(Props: TStrings);
var
  i, count: Integer;
  name: String;
begin
  count := FDSHTTP.Response.RawHeaders.Count;
  for i := 0 to count - 1 do
  begin
    name := FDSHTTP.Response.RawHeaders.Names[i];
    if IsProperty(name) then
      Props.Values[name] := FDSHTTP.Response.RawHeaders.Values[name];
  end;
end;

function TAzureBlobService.PutBlock(const ContainerName, BlobName,
  BlockId: String; Content: TArray<Byte>; const LeaseId, ContentMD5: String): boolean;
var
  contentStream: TBytesStream;
  url: String;
  msDate: String;
  idx: Integer;
  headers: TStringList;
begin
  contentStream := TBytesStream.Create(Content);
  headers := TStringList.Create;
  try
    msDate := XMsDate;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName,
                            QueryParams(['comp', 'blockid'], ['block', BlockId])]);
    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;

    StringToSign('PUT', ['', '', IntToStr(contentStream.Size), ContentMD5, '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(['comp', 'blockid'], ['block', BlockId], [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]),
                                                           headers.ValueFromIndex[idx]);
    if Length(ContentMD5) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('Content-MD5', ContentMD5);

    Result := false;
    try
      try
        FDSHTTP.Put(url, contentStream);
        Result := FDSHTTP.ResponseCode = 201;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    contentStream.Free;
    headers.Free;
  end;
end;

function TAzureBlobService.PutBlockBlob(const ContainerName, BlobName: String; Content: TArray<Byte>; const LeaseId: String;
  const UserHeaders: TStringList; const ContentType: String; const ContentEncoding: String;
  const ContentLanguage: String; const ContentMD5: String; const CacheControl: String): boolean;
var
  contentStream: TBytesStream;
  url: String;
  msDate: String;
  idx: Integer;
  headers: TStringList;
begin
  headers := TStringList.Create;
  if UserHeaders <> nil then
    headers.Assign(UserHeaders);

  contentStream := TBytesStream.Create(Content);
  try
    msDate := XMsDate;
    url := Format('%s/%s/%s', [FConnectionString.BlobURL, ContainerName, BlobName]);
    CleanUpHeaders;

    headers.Values['x-ms-blob-type'] := 'BlockBlob';
    headers.Values['x-ms-date'] := msDate;

    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;

    if FConnectionString.UseDevelopmentStorage then
    begin
      StringToSign('PUT', ['', '', ''],
         ['x-ms-blob-type', 'x-ms-date'],
         ['BlockBlob', msDate],
         [Format('/%s/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName, ContainerName, BlobName])]);
    end else begin
      headers.Values['x-ms-version'] := '2009-09-19';
      FDSHTTP.Request.ContentType := ContentType;
      FDSHTTP.Request.ContentEncoding := ContentEncoding;
      FDSHTTP.Request.ContentLanguage := ContentLanguage;
      StringToSign('PUT', [ContentEncoding, ContentLanguage, IntToStr(contentStream.Size),
                           ContentMD5, ContentType, '', '', '', '', '', ''],
         headers,
         [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName])]);
    end;
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]),
                                                           headers.ValueFromIndex[idx]);
    if Length(ContentMD5) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('Content-MD5', ContentMD5);
    if Length(CacheControl) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('Cache-Control', CacheControl);

    Result := false;
    try
      FDSHTTP.Put(url, contentStream);
      Result := FDSHTTP.ResponseCode = 201;
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    contentStream.Free;
    headers.Free;
  end;
end;

function TAzureBlobService.PutBlockList(const ContainerName, BlobName,
  BlockList, ContentMD5, BlobCacheControl, BlobContentType, BlobContentEncoding,
  BlobContentLanguage, BlobContentMD5, LeaseId: String;
  const MetaHeaders: TStringList): boolean;
var
  contentStream: TBytesStream;
  url: String;
  msDate: String;
  idx: Integer;
  headers: TStringList;
begin
  headers := TStringList.Create;
  contentStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(BlockList));

  try
    msDate := XMsDate;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName,
                                 QueryParams(['comp'], ['blocklist'])]);
    CleanUpHeaders;

    if MetaHeaders <> nil then
      headers.Assign(MetaHeaders);
    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;
    if Length(BlobCacheControl) > 0 then
      headers.Values['x-ms-blob-cache-control'] := BlobCacheControl;
    if Length(BlobContentType) > 0 then
      headers.Values['x-ms-blob-content-type'] := BlobContentType;
    if Length(BlobContentEncoding) > 0 then
      headers.Values['x-ms-blob-content-encoding'] := BlobContentEncoding;
    if Length(BlobContentLanguage) > 0 then
      headers.Values['x-ms-blob-content-language'] := BlobContentLanguage;
    if Length(BlobContentMD5) > 0 then
      headers.Values['x-ms-blob-content-md5'] := BlobContentMD5;

    StringToSign('PUT', ['', '', IntToStr(contentStream.Size), ContentMD5, '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(['comp'], ['blocklist'], [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    if Length(ContentMD5) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('Content-MD5', ContentMD5);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]), headers.ValueFromIndex[idx]);

    Result := false;
    try
      try
        FDSHTTP.Put(url, contentStream);
        Result := FDSHTTP.ResponseCode = 201;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    contentStream.Free;
    headers.Free;
  end;
end;

function TAzureBlobService.PutPage(const ContainerName, BlobName: String;
   Content: TArray<Byte>; StartByte, EndByte: int64; PageWrite: String; const ContentMD5, LeaseId, IfSeqNbLte,
  IfSeqNbLe, IfSeqNbEq, IfModifiedSince, IfUnmodifiedSince, IfMatch,
  IfNoneMatch: String): boolean;
var
  contentStream: TBytesStream;
  url: String;
  msDate: String;
  idx: Integer;
  headers: TStringList;
  contentLen: String;
begin
  headers := TStringList.Create;
  if Content = nil then
  begin
    // force clear
    PageWrite := 'clear';
    contentStream := nil;
    contentLen := '0';
  end
  else
  begin
    contentStream := TBytesStream.Create(Content);
    contentLen := IntToStr(Length(Content));
  end;
  try
    msDate := XMsDate;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName,
                                 QueryParams(['comp'], ['page'])]);
    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    headers.Values['x-ms-range'] := Format('bytes=%d-%d', [StartByte, EndByte]);
    headers.Values['x-ms-page-write'] := PageWrite;
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;
    if Length(IfSeqNbLte) > 0 then
      headers.Values['x-ms-if-sequence-number-lte'] := IfSeqNbLte;
    if Length(IfSeqNbLe) > 0 then
      headers.Values['x-ms-if-sequence-number-le'] := IfSeqNbLe;
    if Length(IfSeqNbEq) > 0 then
      headers.Values['x-ms-if-sequence-number-eq'] := IfSeqNbEq;

    StringToSign('PUT', ['', '', contentLen, ContentMD5, '', '', IfModifiedSince, IfMatch, IfNoneMatch, IfUnModifiedSince, ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(['comp'], ['page'], [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    if Length(ContentMD5) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('Content-MD5', ContentMD5);
    if Length(IfModifiedSince) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Modified-Since', IfModifiedSince);
    if Length(IfUnModifiedSince) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Unmodified-Since', IfUnModifiedSince);
    if Length(IfMatch) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Match', IfMatch);
    if Length(IfNoneMatch) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-None-Match', IfNoneMatch);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(headers.Names[idx], headers.ValueFromIndex[idx]);

    Result := false;
    try
      try
        if contentStream <> nil then
          FDSHTTP.Put(url, contentStream)
        else
          FDSHTTP.Put(url);
        Result := FDSHTTP.ResponseCode = 201;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    contentStream.Free;
    headers.Free;
  end;
end;

function TAzureBlobService.PutPageBlob(const ContainerName, BlobName: String;
  BlobSize, BlobSeqNb: int64; const UserHeaders: TStringList; const ContentType: String;
  const ContentEncoding: String; const ContentLanguage: String; const ContentMD5: String;
  const CacheControl: String): boolean;
var
  url: String;
  msDate: String;
  idx: Integer;
  headers: TStringList;
begin
  msDate := XMsDate;
  url := Format('%s/%s/%s', [FConnectionString.BlobURL, ContainerName, BlobName]);

  headers := TStringList.Create;
  if UserHeaders <> nil then
    headers.Assign(UserHeaders);

  headers.Values['x-ms-blob-type'] := 'PageBlob';
  headers.Values['x-ms-date'] := msDate;
  headers.Values['x-ms-blob-content-length'] := IntToStr(BlobSize);
  headers.Values['x-ms-blob-sequence-number'] := IntToStr(BlobSeqNb);
  headers.Values['x-ms-version'] := '2009-09-19';

  CleanUpHeaders;
  FDSHTTP.Request.ContentType := ContentType;
  FDSHTTP.Request.ContentEncoding := ContentEncoding;
  FDSHTTP.Request.ContentLanguage := ContentLanguage;
  StringToSign('PUT', [ContentEncoding, ContentLanguage, '0', ContentMD5, ContentType, '', '', '', '', '', ''],
         headers,
         [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName])]);
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  for idx := 0 to headers.Count - 1 do
    FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]),
                                                           headers.ValueFromIndex[idx]);
  if Length(ContentMD5) > 0 then
    FDSHTTP.Request.CustomHeaders.AddValue('Content-MD5', ContentMD5);
  if Length(CacheControl) > 0 then
    FDSHTTP.Request.CustomHeaders.AddValue('Cache-Control', CacheControl);

  try
    FDSHTTP.Put(url);
    Result := FDSHTTP.ResponseCode = 201;
  finally
    headers.Free;
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureBlobService.CreateContainer(ContainerName: String;
  const MetaDataHeaders: TStringList; const PublicAccess: String): boolean;
var
  url: String;
  msDate: String;
  idx: Integer;
  metaHeaders: TStringList;
begin
  ContainerName := AnsiLowerCase(ContainerName);
  metaHeaders := TStringList.Create;
  if MetaDataHeaders <> nil then
    metaHeaders.Assign(MetaDataHeaders);
  try
    msDate := XMsDate;
    url := Format('%s/%s', [FConnectionString.BlobURL, ContainerName]);
    metaHeaders.Values['x-ms-date'] := msDate;
    if Length(PublicAccess) > 0 then
      metaHeaders.Values['x-ms-blob-public-access'] := PublicAccess;

    CleanUpHeaders;
    if FConnectionString.UseDevelopmentStorage then
      StringToSign('PUT', ['','',''], metaHeaders,
        [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName, ContainerName])])
    else begin
      metaHeaders.Values['x-ms-version'] := '2009-09-19';
      StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''], metaHeaders,
        [Format('/%s/%s', [FConnectionString.AccountName, ContainerName]),
         CanonicalizedQueryParams(['restype'],['container'],[],[])]);
        url := url + QueryParams(['restype'], ['container']);
    end;
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to metaHeaders.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(metaHeaders.Names[idx]),
                                                           metaHeaders.ValueFromIndex[idx]);
    try
      FDSHTTP.Put(url);
      FReturnCode := FDSHTTP.ResponseCode;
      Result := FReturnCode = 201;
    except
      Result := false;
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    metaHeaders.Free;
  end
end;

function TAzureBlobService.CreateContainer(ContainerName: String; const PublicAccess: String): boolean;
begin
  Result := CreateContainer(ContainerName, nil, PublicAccess);
end;

function TAzureBlobService.CreateRootContainer(
  const PublicAccess: String): boolean;
begin
  Result := CreateContainer('$root', PublicAccess);
end;

function TAzureBlobService.DeleteBlob(const ContainerName, BlobName, Snapshot,
  LeaseId, DeleteSnapshots: String): boolean;
var
  url: String;
  msDate: String;
  headers: TStringList;
  idx: Integer;
begin
  headers := TStringList.Create;
  msDate := XMsDate;
  url := Format('%s/%s/%s', [FConnectionString.BlobURL, ContainerName, BlobName]);

  CleanUpHeaders;

  headers.Values['x-ms-date'] := msDate;
  headers.Values['x-ms-version'] := '2009-09-19';
  if Length(LeaseId) > 0 then
    headers.Values['x-ms-lease-id'] := LeaseId;
  if Length(DeleteSnapshots) > 0 then
    headers.Values['x-ms-delete-snapshots'] := DeleteSnapshots;
  if Length(Snapshot) > 0 then
  begin
    StringToSign('DELETE', ['', '', '', '', '', '', '', '', '', '', ''], headers,
       [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
        CanonicalizedQueryParams(['snapshot'],[Snapshot],[],[])]);
    url := url + QueryParams(['snapshot'], [Snapshot]);
  end
  else
    StringToSign('DELETE', ['', '', '', '', '', '', '', '', '', '', ''], headers,
       [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName])]);
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  for idx := 0 to headers.Count - 1 do
    FDSHTTP.Request.CustomHeaders.AddValue(headers.Names[idx], headers.ValueFromIndex[idx]);
  try
    try
      FDSHTTP.Delete(url);
      FReturnCode := FDSHTTP.ResponseCode;
      Result := ReturnCode = 202;
    except
      Result := false;
      FReturnCode := FDSHTTP.ResponseCode;
    end
  finally
    headers.Free;
  end
end;

function TAzureBlobService.DeleteContainer(
  const ContainerName: String): boolean;
var
  url: String;
  msDate: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.BlobURL, ContainerName]);
  CleanUpHeaders;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('DELETE', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName, ContainerName])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('DELETE', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s', [FConnectionString.AccountName,
                               ContainerName]),
        CanonicalizedQueryParams(['restype'],['container'],[],[])]);
    url := url + QueryParams(['restype'],['container']);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  try
    FDSHTTP.Delete(url);
    FReturnCode := FDSHTTP.ResponseCode;
    Result := ReturnCode = 202;
  except
    Result := false;
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureBlobService.DeleteRootContainer: boolean;
begin
  Result := DeleteContainer('$root');
end;

function TAzureBlobService.GetBlob(const ContainerName, BlobName: String; ResponseContent: TStream;
                                   const Snapshot: String; StartByte: int64; EndByte: int64;
                                   const LeaseId: String; GetMD5: boolean): boolean;
var
  msDate: String;
  url: String;
  headers: TStringList;
  idx: Integer;
begin
  msDate := XMsDate;
  url := Format('%s/%s/%s', [FConnectionString.BlobURL, ContainerName, BlobName]);
  headers := TStringList.Create;
  try
    headers.Values['x-ms-date'] := msDate;
    CleanUpHeaders;
    if FConnectionString.UseDevelopmentStorage then
      StringToSign('GET', ['', '', ''],
         ['x-ms-date'],
         [msDate],
         [Format('/%s/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                                ContainerName, BlobName])])
    else begin
      headers.Values['x-ms-version'] := '2009-09-19';
      if EndByte > 0 then
      begin
        headers.Values['x-ms-range'] := Format('bytes=%d-%d', [StartByte, EndByte]);
        if GetMD5 then
          headers.Values['x-ms-range-get-content-md5'] := 'true'
      end;
      if Length(LeaseId) > 0 then
        headers.Values['x-ms-lease-id'] := LeaseId;

      if Length(Snapshot) > 0 then
      begin
        StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
           headers,
           [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
           CanonicalizedQueryParams(['snapshot'], [Snapshot], [], [])]);
        url := url + QueryParams(['snapshot'], [Snapshot])
      end else
        StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
           headers,
           [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName])]);

    end;
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(headers.Names[idx], headers.ValueFromIndex[idx]);

    try
      FDSHTTP.Get(url, ResponseContent);
      Result := FDSHTTP.ResponseCode = 200;
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

function TAzureBlobService.GetBlobMetadata(const ContainerName, BlobName,
  Snapshot, LeaseId: String): boolean;
var
  headers: TStringList;
  url: String;
  msDate: String;
  idx: Integer;
  params, values: TVarRecArray;
begin
  headers := TStringList.Create;
  try
    msDate := XMsDate;
    if Length(Snapshot) > 0 then
    begin
      params := CreateRecArray(['comp', 'snapshot']);
      values := CreateRecArray(['metadata', Snapshot]);
    end else begin
      params := CreateRecArray(['comp']);
      values := CreateRecArray(['metadata']);
    end;

    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName, QueryParams(params, values)]);

    CleanUpHeaders;

    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;
    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';

    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(params, values, [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(headers.Names[idx],
                                             headers.ValueFromIndex[idx]);

    try
      try
        FDSHTTP.Get(url);
        Result := FDSHTTP.ResponseCode = 200;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

function TAzureBlobService.GetBlobProperties(const ContainerName, BlobName,
  Snapshot, LeaseId: String): boolean;
var
  headers: TStringList;
  url: String;
  msDate: String;
  idx: Integer;
  params, values: TVarRecArray;
begin
  headers := TStringList.Create;
  try
    msDate := XMsDate;
    if Length(Snapshot) > 0 then
    begin
      params := CreateRecArray(['snapshot']);
      values := CreateRecArray([Snapshot]);
    end;

    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName, QueryParams(params, values)]);

    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;

    StringToSign('HEAD', ['', '', '', '', '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(params, values, [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(headers.Names[idx],
                                             headers.ValueFromIndex[idx]);

    try
      try
        FDSHTTP.Head(url);
        Result := FDSHTTP.ResponseCode = 200;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

function TAzureBlobService.GetBlockList(const ContainerName, BlobName,
  BlockListType, Snapshot, LeaseId: String): String;
var
  headers: TStringList;
  url: String;
  msDate: String;
  idx: Integer;
  params, values: TVarRecArray;
begin
  headers := TStringList.Create;
  try
    msDate := XMsDate;
    if Length(Snapshot) > 0 then
      if Length(BlockListType) > 0 then
      begin
        params := CreateRecArray(['comp', 'snapshot', 'blocklisttype']);
        values := CreateRecArray(['blocklist', Snapshot, BlockListType])
      end else begin
        params := CreateRecArray(['comp', 'snapshot']);
        values := CreateRecArray(['blocklist', Snapshot])
      end
    else if Length(BlockListType) > 0 then
    begin
      params := CreateRecArray(['comp', 'blocklisttype']);
      values := CreateRecArray(['blocklist', BlockListType])
    end else begin
      params := CreateRecArray(['comp']);
      values := CreateRecArray(['blocklist'])
    end;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName, QueryParams(params, values)]);

    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;

    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(params, values, [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(headers.Names[idx],
                                             headers.ValueFromIndex[idx]);
    try
      Result := GetResponse(url);
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

function TAzureBlobService.GetContainerACL(const ContainerName: String): String;
var
  msDate: String;
  url: String;
  queryString: String;
begin
  msDate := XMsDate;
  queryString := '?comp=acl';
  url := Format('%s/%s', [FConnectionString.BlobURL, ContainerName]);

  CleanUpHeaders;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
  begin
    StringToSign('GET', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                            ContainerName, queryString])]);
    url := url + queryString
  end else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s', [FConnectionString.AccountName, ContainerName]),
        CanonicalizedQueryParams(['restype', 'comp'], ['container', 'acl'], [], [])]);
    url := url + QueryParams(['restype', 'comp'], ['container', 'acl']);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    Result := GetResponse(url);
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureBlobService.GetContainerMetadata(
  const ContainerName: String): boolean;
var
  url: String;
  msDate: String;
  qry: String;
begin
  msDate := XMsDate;
  qry := '?comp=metadata';
  url := Format('%s/%s', [FConnectionString.BlobURL, ContainerName]);

  CleanUpHeaders;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
  begin
    StringToSign('GET', ['','',''], ['x-ms-date'], [msDate],
      [Format('/%s/%s/%s%s', [FConnectionString.AccountName, FConnectionString.AccountName, ContainerName, qry])]);
    url := url + qry
  end else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s', [FConnectionString.AccountName, ContainerName]),
        CanonicalizedQueryParams(['restype', 'comp'], ['container', 'metadata'], [], [])]);
    url := url + QueryParams(['restype', 'comp'], ['container', 'metadata']);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    FDSHTTP.Get(url);
    FReturnCode := FDSHTTP.ResponseCode;
    Result := FReturnCode = 200;
  except
    FReturnCode := FDSHTTP.ResponseCode;
    Result := false;
  end;
end;

function TAzureBlobService.GetContainerProperties(const ContainerName: String): boolean;
var
  url: String;
  msDate: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.BlobURL, ContainerName]);

  CleanUpHeaders;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('GET', ['','',''], ['x-ms-date'], [msDate],
      [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName, ContainerName])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s', [FConnectionString.AccountName, ContainerName]),
        CanonicalizedQueryParams(['restype'], ['container'], [], [])]);
    url := url + QueryParams(['restype'], ['container']);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    FDSHTTP.Get(url);
    FReturnCode := FDSHTTP.ResponseCode;
    Result := FReturnCode = 200;
  except
    FReturnCode := FDSHTTP.ResponseCode;
    Result := false;
  end;

end;

function TAzureBlobService.GetPageRegions(const ContainerName, BlobName,
  Snapshot: String; StartByte, EndByte: int64; const LeaseId: String): String;
var
  headers: TStringList;
  url: String;
  msDate: String;
  idx: Integer;
  params, values: TVarRecArray;
begin
  headers := TStringList.Create;
  try
    msDate := XMsDate;
    if Length(Snapshot) > 0 then
    begin
      params := CreateRecArray(['comp', 'snapshot']);
      values := CreateRecArray(['pagelist', Snapshot])
    end
    else
    begin
      params := CreateRecArray(['comp']);
      values := CreateRecArray(['pagelist'])
    end;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName, QueryParams(params, values)]);

    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;
    if EndByte > 0 then
      headers.Values['x-ms-range'] := Format('bytes=%d-%d', [StartByte, EndByte]);

    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(params, values, [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(headers.Names[idx],
                                             headers.ValueFromIndex[idx]);
    try
      Result := GetResponse(url);
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

function TAzureBlobService.IsProperty(Name: String): Boolean;
begin
  Result := True;
  if AnsiStartsStr('x-ms-meta-', Name) or
       (Name = 'Transfer-Encoding') or
       (Name = 'Server') or
       (Name = 'x-ms-request-id') or
       (Name = 'x-ms-version') or
       (Name = 'Date') then
     Exit(False);
end;

function TAzureBlobService.LeaseBlob(const ContainerName, BlobName, LeaseAction,
  LeaseId: String): String;
var
  headers: TStringList;
  url: String;
  msDate: String;
  idx: Integer;
begin
  headers := TStringList.Create;
  try
    msDate := XMsDate;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName, QueryParams(['comp'], ['lease'])]);

    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;
    headers.Values['x-ms-lease-action'] := LeaseAction;

    StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(['comp'], ['lease'], [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]),
                                                           headers.ValueFromIndex[idx]);
    try
      FDSHTTP.Put(url);
      Result := FDSHTTP.Response.RawHeaders.Values['x-ms-lease-id'];
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

function TAzureBlobService.ListBlobs(const ContainerName: String; Params: array of const;
                                     Values: array of const): String;
var
  msDate: String;
  url: String;
  queryString: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.BlobURL, ContainerName]);

  CleanUpHeaders;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
  begin
    queryString := '?comp=list';
    StringToSign('GET', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                            ContainerName, queryString])]);
    url := url + queryString
  end else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s', [FConnectionString.AccountName, ContainerName]),
        CanonicalizedQueryParams(['comp', 'restype'], ['list', 'container'], Params, Values)]);
    url := url + QueryParams(['comp', 'restype'], ['list', 'container'], Params, Values);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    Result := GetResponse(url);
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end
end;

function TAzureBlobService.SetContainerMetadata(const ContainerName: String;
  const MetaDataHeaders: TStringList): boolean;
var
  msDate: String;
  url: String;
  queryString: String;
  idx: Integer;
begin
  msDate := XMsDate;
  queryString := 'comp=metadata';
  url := Format('%s/%s', [FConnectionString.BlobURL, ContainerName]);

  CleanUpHeaders;
  MetaDataHeaders.Values['x-ms-date'] := msDate;
  if FConnectionString.UseDevelopmentStorage then
  begin
    StringToSign('PUT', ['', '', ''],
       MetaDataHeaders,
       [Format('/%s/%s/%s?%s', [FConnectionString.AccountName, FConnectionString.AccountName,
          ContainerName, queryString])]);
    url := url + '?' + queryString;
  end else begin
    MetaDataHeaders.Values['x-ms-version'] := '2009-09-19';
    StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''], MetaDataHeaders,
      [Format('/%s/%s', [FConnectionString.AccountName, ContainerName]),
       CanonicalizedQueryParams(['restype', 'comp'],['container', 'metadata'],[],[])]);
    url := url + QueryParams(['restype', 'comp'], ['container', 'metadata']);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  for idx := 0 to MetaDataHeaders.Count - 1 do
    FDSHTTP.Request.CustomHeaders.AddValue(MetaDataHeaders.Names[idx], MetaDataHeaders.ValueFromIndex[idx]);

  try
    FDSHTTP.Put(url);
    Result := FDSHTTP.ResponseCode = 200;
    FReturnCode := FDSHTTP.ResponseCode;
  except
    Result := FDSHTTP.ResponseCode = 200;
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureBlobService.SetPageBlobProperties(const ContainerName, BlobName,
  BlobCacheControl, BlobContentType, BlobContentEncoding, BlobContentLanguage,
  BlobContentMD5, BlobContentLength, SeqNbAction, BlobSeqNumber,
  LeaseId: String): boolean;
var
  url: String;
  msDate: String;
  idx: Integer;
  headers: TStringList;
begin
  headers := TStringList.Create;

  try
    msDate := XMsDate;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName,
                                 QueryParams(['comp'], ['properties'])]);
    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;
    if Length(BlobCacheControl) > 0 then
      headers.Values['x-ms-blob-cache-control'] := BlobCacheControl;
    if Length(BlobContentType) > 0 then
      headers.Values['x-ms-blob-content-type'] := BlobContentType;
    if Length(BlobContentEncoding) > 0 then
      headers.Values['x-ms-blob-content-encoding'] := BlobContentEncoding;
    if Length(BlobContentLanguage) > 0 then
      headers.Values['x-ms-blob-content-language'] := BlobContentLanguage;
    if Length(BlobContentMD5) > 0 then
      headers.Values['x-ms-blob-content-md5'] := BlobContentMD5;
    if Length(BlobContentLength) > 0 then
      headers.Values['x-ms-blob-content-length'] := BlobContentLength;
    if Length(SeqNbAction) > 0 then
      headers.Values['x-ms-sequence-number-action'] := SeqNbAction;
    if Length(BlobSeqNumber) > 0 then
      headers.Values['x-ms-blob-sequence-number'] := BlobSeqNumber;

    StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(['comp'], ['properties'], [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]), headers.ValueFromIndex[idx]);

    Result := false;
    try
      try
        FDSHTTP.Put(url);
        Result := FDSHTTP.ResponseCode = 200;
      except
        Result := false;
      end
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end;
end;

function TAzureBlobService.SnapshotBlob(const ContainerName, BlobName,
  IfModifiedSince, IfUnmodifiedSince, IfMatch, IfNoneMatch, LeaseId: String;
  const MetaHeaders: TStringList): String;
var
  headers: TStringList;
  url: String;
  msDate: String;
  idx: Integer;
begin
  headers := TStringList.Create;
  if MetaHeaders <> nil then
    headers.Assign(MetaHeaders);
  try
    msDate := XMsDate;
    url := Format('%s/%s/%s%s', [FConnectionString.BlobURL, ContainerName, BlobName,
                                 QueryParams(['comp'], ['snapshot'])]);

    CleanUpHeaders;

    headers.Values['x-ms-date'] := msDate;
    headers.Values['x-ms-version'] := '2009-09-19';
    if Length(LeaseId) > 0 then
      headers.Values['x-ms-lease-id'] := LeaseId;

    StringToSign('PUT', ['', '', '0', '', '', IfModifiedSince, IfMatch, IfNoneMatch, IfUnmodifiedSince, '', ''],
         headers, [Format('/%s/%s/%s', [FConnectionString.AccountName, ContainerName, BlobName]),
                   CanonicalizedQueryParams(['comp'], ['snapshot'], [], [])]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    if Length(IfModifiedSince) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Modified-Since', IfModifiedSince);
    if Length(IfUnmodifiedSince) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Unmodified-Since', IfUnmodifiedSince);
    if Length(IfMatch) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-Match', IfMatch);
    if Length(IfNoneMatch) > 0 then
      FDSHTTP.Request.CustomHeaders.AddValue('If-None-Match', IfMatch);

    for idx := 0 to headers.Count - 1 do
      FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(headers.Names[idx]),
                                                           headers.ValueFromIndex[idx]);
    try
      FDSHTTP.Put(url);
      Result := FDSHTTP.Response.RawHeaders.Values['x-ms-snapshot'];
    finally
      FReturnCode := FDSHTTP.ResponseCode;
    end;
  finally
    headers.Free;
  end
end;

function TAzureBlobService.ListContainers(extraQueryParams: String): String;
var
  msDate: String;
  url: String;
  queryString: String;
begin
  // this code works for Development Storage
  msDate := XMsDate;
  queryString := '?comp=list';
  url := Format('%s%s', [FConnectionString.BlobURL, extraQueryParams]);
  CleanUpHeaders;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  StringToSign('GET', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                            queryString])]);
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  try
    Result := GetResponse(url);
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureBlobService.ListContainers: String;
begin
  if FConnectionString.UseDevelopmentStorage then
    Result := ListContainers(QueryParams(['comp'], ['list']))
  else
    Result := ListContainers([], []);
end;

function TAzureBlobService.ListContainers(Params,
  Values: array of const): String;
var
  msDate: String;
  url: String;
begin
  if FConnectionString.UseDevelopmentStorage then
    Result := ListContainers(QueryParams(['comp'], ['list'], Params, Values))
  else begin
    msDate := XMsDate;
    url := Format('%s/%s', [FConnectionString.BlobURL, QueryParams(['comp'],['list'],
                                  Params, Values)]);
    CleanUpHeaders;
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/', [FConnectionString.AccountName]),
        CanonicalizedQueryParams(['comp'], ['list'], Params, Values)]);
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    try
      Result := GetResponse(url);
    finally
      FReturnCode := FDSHTTP.ResponseCode
    end;
  end
end;

function TAzureBlobService.SetContainerACL(const ContainerName, Id: String;
  AccessPolicy: TAccessPolicy; const PublicAccess: String): boolean;
var
  SigId: TSignedIdentifier;
  ContentStream: TBytesStream;
  msDate: String;
  url: String;
  queryString: String;
begin
  ContentStream := nil;
  SigId := TSignedIdentifier.Create(FConnectionString.FAccountName, FConnectionString.FAccountKey, ContainerName, AccessPolicy);
  SigId.Id := Id;
  try
    msDate := XMsDate;
    queryString := '?comp=acl';
    url := Format('%s/%s', [FConnectionString.BlobURL, ContainerName]);
    CleanUpHeaders;
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);

    ContentStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(
      '<?xml version="1.0" encoding="utf-8"?><SignedIdentifiers>' +
                             SigId.AsXML + '</SignedIdentifiers>'));

    if FConnectionString.UseDevelopmentStorage then
    begin
      FDSHTTP.Request.CustomHeaders.AddValue('x-ms-prop-publicaccess', 'true');
      StringToSign('PUT', ['', '', ''],
         ['x-ms-date', 'x-ms-prop-publicaccess'],
         [msDate, 'true'],
         [Format('/%s/%s/%s%s', [FConnectionString.AccountName, FConnectionString.AccountName,
            ContainerName, queryString])]);
      url := url + queryString;
    end else begin
      FDSHTTP.Request.CustomHeaders.AddValue('x-ms-blob-public-access', PublicAccess);
      FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
      StringToSign('PUT', ['', '', IntToStr(ContentStream.Size), '', '', '', '', '', '', '', ''],
        ['x-ms-blob-public-access', 'x-ms-date', 'x-ms-version'], [PublicAccess, msDate, '2009-09-19'],
        [Format('/%s/%s', [FConnectionString.AccountName, ContainerName]),
         CanonicalizedQueryParams(['restype', 'comp'],['container', 'acl'],[],[])]);
      url := url + QueryParams(['restype', 'comp'], ['container', 'acl']);
    end;
    FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

    FDSHTTP.Put(url, ContentStream);
    Result := FDSHTTP.ResponseCode = 200;
  finally
    SigId.Free;
    ContentStream.Free;
  end;
end;

{ TSharedKeyAuthorization }

function TSharedKeyAuthorization.Authentication: String;
begin
  Result := Format('SharedKey %s:%s', [UserName, EncodeBytes64(HMAC_SHA256(StringToSign))]); {do not localize}
end;

function TSharedKeyAuthorization.HMAC_SHA256(const StringToSign: String): TArray<Byte>;
var
  hmacInst: TIdHMACIntCtx;
  utf8Data: TArray<Byte>;
begin
  // get the HMAC-SHA256 for the key
  hmacInst := GetHMACSHA256HashInst(TIdBytes(FSHAKey));
  // convert StringToSign into UTF8
  utf8Data := TEncoding.UTF8.GetBytes(StringToSign);
  // Sign it
  UpdateHMACInst(hmacInst, TIdBytes(utf8Data));
  // build the Base64 result
  Result := TArray<Byte>(FinalHMACInst(hmacInst));
end;


class function TSharedKeyAuthorization.IsHMAC_SHA256Avail: boolean;
begin
  Result := IdFIPS.IsHMACSHA256Avail;
end;

procedure TSharedKeyAuthorization.SetSHAKey(const Key: String);
begin
  Password := Key;
  FSHAKey := DecodeBytes64(Password);
end;

{ TAccessPolicy }

function TAccessPolicy.AsXML: String;
begin
  Result := '<AccessPolicy><Start>' + Start + '</Start><Expiry>' + Expiry +
    '</Expiry><Permission>' + Permission + '</Permission></AccessPolicy>';
end;

class function TAccessPolicy.Create: TAccessPolicy;
var
  ap: TAccessPolicy;
begin
  ap.Start := FormatDateTime('yyyy-mm-dd', Now);
  ap.SetPermission('r');
  exit(ap);
end;

function TAccessPolicy.GetPermission: String;
begin
  Result := '';
  if PermRead then
    Result := Result + 'r';
  if PermWrite then
    Result := Result + 'w';
  if PermDelete then
    Result := Result + 'd';
  if PermList then
    Result := Result + 'l';
end;

procedure TAccessPolicy.SetPermission(const rwdl: String);
var
  i, count: Integer;
begin
  count := Length(rwdl);
  PermRead   := false;
  PermWrite  := false;
  PermDelete := false;
  PermList   := false;
  for i := 1 to count do
    if rwdl[i] = 'r' then
      PermRead := true
    else if rwdl[i] = 'w' then
      PermWrite := true
    else if rwdl[i] = 'd' then
      PermDelete := true
    else if rwdl[i] = 'l' then
      PermList := true;
end;

{ TSignedIdentifier }

function TSignedIdentifier.AsXML: String;
begin
  Result := '<SignedIdentifier><Id>' + Id + '</Id>' + AccessPolicy.AsXML + '</SignedIdentifier>';
end;

function TSignedIdentifier.CanonicalizedResource: String;
begin
  Result := Format('%s/%s', [FAccount, FResource]);
end;

constructor TSignedIdentifier.Create(const Account, SharedKey, Resource: String;
  Policy: TAccessPolicy);
begin
  FAccount := Account;
  FResource := Resource;
  FSharedKey := SharedKey;
  AccessPolicy := Policy;
end;

constructor TSignedIdentifier.Create(const Account, SharedKey, Resource: String);
begin
  FAccount := Account;
  FResource := Resource;
  FSharedKey := SharedKey;
  AccessPolicy.PermRead := false;
  AccessPolicy.PermWrite := false;
  AccessPolicy.PermDelete := false;
  AccessPolicy.PermList := false;
end;

function TSignedIdentifier.HMAC_SHA256(const StringToSign: String): TArray<Byte>;
var
  hmacInst: TIdHMACIntCtx;
  key: TArray<Byte>;
begin
  // decode account key from Base64
  key := DecodeBytes64(FSharedKey);
  // get the HMAC-SHA256 for the key
  hmacInst := GetHMACSHA256HashInst(TIdBytes(key));
  // convert StringToSign into UTF8
  key := TEncoding.UTF8.GetBytes(StringToSign);
  UpdateHMACInst(hmacInst, TIdBytes(key));
  Result := TArray<Byte>(FinalHMACInst(hmacInst));
end;

function TSignedIdentifier.SI: String;
begin
  Result := 'si=' + TIdURI.ParamsEncode(Id);
end;

function TSignedIdentifier.Sig: String;
begin
  Result := 'sig=' + Signature;
end;

function TSignedIdentifier.Signature: String;
var
  StringToSign: String;
begin
  StringToSign := Format('%s'#10'%s'#10'%s'#10'%s'#10'%s', [AccessPolicy.Permission,
    AccessPolicy.Start, AccessPolicy.Expiry, CanonicalizedResource, Id]);
  Result := EncodeBytes64(HMAC_SHA256(StringToSign));
end;

{ TAzureTableService }

constructor TAzureTableService.Create(
  AConnectionString: TAzureConnectionString);
begin
  inherited Create(AConnectionString);
end;

function TAzureTableService.QueryEntities(const TableName,
  FilterExpression: String): String;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  if FilterExpression = EmptyStr then
    url := Format('%s/%s()', [FConnectionString.TableURL, TableName])
  else
    url := Format('%s/%s()?$filter=%s', [FConnectionString.TableURL, TableName, TIdURI.ParamsEncode(FilterExpression)]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.ContentType := '';
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('GET', ['', '', msDate],
         [], [],
         [Format('/%s/%s/%s()', [FConnectionString.AccountName, FConnectionString.AccountName,
                            TableName])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    // filter is not part of the signature!!!
    StringToSign('GET', ['', '', msDate],
         [], [],
         [Format('/%s/%s()', [FConnectionString.AccountName, TableName])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  Result := GetResponse(url);
end;

function TAzureTableService.CreateTable(const TableName: String): boolean;
var
  msDate: String;
  url: String;
  InputStream : TBytesStream;
  xml: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.TableURL, 'Tables']);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := 'application/atom+xml';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('POST', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                            'Tables'])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    StringToSign('POST', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s', [FConnectionString.AccountName, 'Tables'])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  xml := Format('<?xml version="1.0" encoding="utf-8" standalone="yes"?>' +
                  '<entry xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" ' +
                         'xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" ' +
                         'xmlns="http://www.w3.org/2005/Atom">' +
                    '<title />' +
                    '<updated>%s</updated>' +
                    '<author>' +
                      '<name />' +
                    '</author>' +
                    '<content type="application/xml">' +
                        '<m:properties>' +
                          '<d:TableName>%s</d:TableName>' +
                        '</m:properties>' +
                    '</content>' +
                  '</entry>',
                  [UpdatedDate, TableName]);
  InputStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));
  try
    try
      FDSHTTP.Post(url, InputStream);
      Result := FDSHTTP.ResponseCode = 201;
    except
      Result := false;
    end;
  finally
    FReturnCode := FDSHTTP.ResponseCode;
    InputStream.Free;
  end;
end;

function TAzureTableService.DeleteEntity(const TableName, PartitionKey,
  RowKey: String): boolean;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.TableURL,
          TableName, PartitionKey, RowKey]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := 'application/atom+xml';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.CustomHeaders.AddValue('If-Match', '*');
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('DELETE', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.AccountName,
       FConnectionString.AccountName, TableName, PartitionKey, RowKey])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    StringToSign('DELETE', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.AccountName,
                            TableName, PartitionKey, RowKey])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  try
    try
      FDSHTTP.Delete(url);
      Result := FDSHTTP.ResponseCode = 204;
    except
      Result := false;
    end;
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureTableService.DeleteTable(const TableName: String): boolean;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/Tables(''%s'')', [FConnectionString.TableURL, TableName]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := 'application/atom+xml';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('DELETE', ['', 'application/atom+xml', msDate],
         [], [],
         [Format('/%s/%s/Tables(''%s'')', [FConnectionString.AccountName, FConnectionString.AccountName,
                                           TableName])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    StringToSign('DELETE', ['', 'application/atom+xml', msDate],
         [], [],
         [Format('/%s/Tables(''%s'')', [FConnectionString.AccountName, TableName])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    FDSHTTP.Delete(url);
    FReturnCode := FDSHTTP.ResponseCode;
    Result := FReturnCode = 204;
  except
    FReturnCode := FDSHTTP.ResponseCode;
    Result := false;
  end;
end;

function TAzureTableService.InsertEntity(const TableName: String;
  entity: TJSONObject): string;
var
  msDate: String;
  url: String;
  InputStream : TBytesStream;
  xml: String;
  idx: Integer;
  jsonProp: TJSONPair;
  propName, propValue, propType: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.TableURL, TableName]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := 'application/atom+xml';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('POST', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                            TableName])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    StringToSign('POST', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s', [FConnectionString.AccountName, TableName])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  xml := Format('<?xml version="1.0" encoding="utf-8" standalone="yes"?>' +
                  '<entry xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" ' +
                         'xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" ' +
                         'xmlns="http://www.w3.org/2005/Atom">' +
                    '<title />' +
                    '<updated>%s</updated>' +
                    '<author>' +
                      '<name />' +
                    '</author>' +
                    '<id />' +
                    '<content type="application/xml">' +
                        '<m:properties>',
                  [UpdatedDate]);
  // populate the properties - assumes the input well formeness
  for idx := 0 to entity.Count - 1 do
  begin
    jsonProp := entity.Pairs[idx];
    propName := jsonProp.JsonString.Value;
    if jsonProp.JsonValue is TJSONArray then
    begin
      propValue := ((jsonProp.JsonValue as TJSONArray).Items[0] as TJSONString).Value;
      propType  := ((jsonProp.JsonValue as TJSONArray).Items[1] as TJSONString).Value;
    end
    else
    begin
      propValue := jsonProp.JsonValue.Value;
      propType  := '';
    end;
    if Length(propType) > 0 then
      xml := xml + Format('<d:%s m:type="%s">%s</d:%s>', [propName, propType, propValue, propName])
    else
      xml := xml + Format('<d:%s>%s</d:%s>', [propName, propValue, propName]);
  end;
  xml := xml + '</m:properties>' +
             '</content>' +
           '</entry>';
  InputStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));
  try
    Result := FDSHTTP.Post(url, InputStream);
  finally
    FReturnCode := FDSHTTP.ResponseCode;
    InputStream.Free;
  end;
end;

function TAzureTableService.MergeEntity(const TableName: String;
  entity: TJSONObject): boolean;
var
  partitionKey, rowKey: String;
  msDate: String;
  url: String;
  InputStream : TBytesStream;
  xml: String;
  idx: Integer;
  jsonProp: TJSONPair;
  propName, propValue, propType: String;
begin
  // recoup the partition and row keys from the entity
  partitionKey := entity.Get('PartitionKey').JsonValue.Value;
  rowKey := entity.Get('RowKey').JsonValue.Value;

  msDate := XMsDate;
  url := Format('%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.TableURL,
          TableName, partitionKey, rowKey]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := 'application/atom+xml';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.CustomHeaders.AddValue('If-Match', '*');
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('MERGE', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.AccountName, FConnectionString.AccountName,
                            TableName, partitionKey, rowKey])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    StringToSign('MERGE', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.AccountName,
                            TableName, partitionKey, rowKey])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  xml := Format('<?xml version="1.0" encoding="utf-8" standalone="yes"?>' +
                  '<entry xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" ' +
                         'xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" ' +
                         'xmlns="http://www.w3.org/2005/Atom">' +
                    '<title />' +
                    '<updated>%s</updated>' +
                    '<author>' +
                      '<name />' +
                    '</author>' +
                    '<id />' +
                    '<content type="application/xml">' +
                        '<m:properties>',
                  [UpdatedDate]);
  // populate the properties - assumes the input well formeness
  for idx := 0 to entity.Count - 1 do
  begin
    jsonProp := entity.Pairs[idx];
    propName := jsonProp.JsonString.Value;
    if jsonProp.JsonValue is TJSONArray then
    begin
      propValue := ((jsonProp.JsonValue as TJSONArray).Items[0] as TJSONString).Value;
      propType  := ((jsonProp.JsonValue as TJSONArray).Items[1] as TJSONString).Value;
    end
    else
    begin
      propValue := jsonProp.JsonValue.Value;
      propType  := '';
    end;
    if Length(propType) > 0 then
      xml := xml + Format('<d:%s m:type="%s">%s</d:%s>', [propName, propType, propValue, propName])
    else
      xml := xml + Format('<d:%s>%s</d:%s>', [propName, propValue, propName]);
  end;
  xml := xml + '</m:properties>' +
             '</content>' +
           '</entry>';
  InputStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));
  try
    try
      FDSHTTP.Merge(url, InputStream);
      Result := FDSHTTP.ResponseCode = 204;
    except
      Result := false;
    end;
  finally
    FReturnCode := FDSHTTP.ResponseCode;
    InputStream.Free;
  end;
end;

function TAzureTableService.QueryEntities(const TableName, PartitionKey,
  RowKey: String): String;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.TableURL,
    TableName, PartitionKey, RowKey]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.ContentType := '';
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('GET', ['', '', msDate],
       [], [],
       [Format('/%s/%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.AccountName, FConnectionString.AccountName,
                            TableName, PartitionKey, RowKey])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    StringToSign('GET', ['', '', msDate],
       [], [],
       [Format('/%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.AccountName,
                            TableName, PartitionKey, RowKey])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  Result := GetResponse(url);
end;

function TAzureTableService.QueryTables(const StartingTable: String): String;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.TableURL, 'Tables']);

  if StartingTable <> EmptyStr then
    url := url + Format('?NextTableName=%s', [URLEncode(StartingTable)]);

  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := '';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.ContentType := '';

  if FConnectionString.UseDevelopmentStorage then
    StringToSign('GET', ['', '', msDate],
       [], [],
       [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                            'Tables'])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    StringToSign('GET', ['', '', msDate],
         [], [],
         [Format('/%s/%s', [FConnectionString.AccountName, 'Tables'])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    Result := GetResponse(url);
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end
end;

function TAzureTableService.UpdatedDate: String;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', TTimeZone.Local.ToUniversalTime(Now));
end;

function TAzureTableService.UpdateEntity(const TableName: String;
  entity: TJSONObject): boolean;
var
  partitionKey, rowKey: String;
  msDate: String;
  url: String;
  InputStream : TBytesStream;
  xml: String;
  idx: Integer;
  jsonProp: TJSONPair;
  propName, propValue, propType: String;
begin
  // recoup the partition and row keys from the entity
  partitionKey := entity.Get('PartitionKey').JsonValue.Value;
  rowKey := entity.Get('RowKey').JsonValue.Value;

  msDate := XMsDate;
  url := Format('%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.TableURL,
          TableName, partitionKey, rowKey]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := 'application/atom+xml';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.CustomHeaders.AddValue('If-Match', '*');
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('PUT', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.AccountName, FConnectionString.AccountName,
                            TableName, partitionKey, rowKey])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    FDSHTTP.Request.CustomHeaders.AddValue('DataServiceVersion', '1.0;NetFx');
    FDSHTTP.Request.CustomHeaders.AddValue('MaxDataServiceVersion', '1.0;NetFx');
    StringToSign('PUT', ['', 'application/atom+xml', msDate],
       [], [],
       [Format('/%s/%s(PartitionKey=''%s'',RowKey=''%s'')', [FConnectionString.AccountName,
                            TableName, partitionKey, rowKey])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  xml := Format('<?xml version="1.0" encoding="utf-8" standalone="yes"?>' +
                  '<entry xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" ' +
                         'xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" ' +
                         'xmlns="http://www.w3.org/2005/Atom">' +
                    '<title />' +
                    '<updated>%s</updated>' +
                    '<author>' +
                      '<name />' +
                    '</author>' +
                    '<id />' +
                    '<content type="application/xml">' +
                        '<m:properties>',
                  [UpdatedDate]);
  // populate the properties - assumes the input well formeness
  for idx := 0 to entity.Count - 1 do
  begin
    jsonProp := entity.Pairs[idx];
    propName := jsonProp.JsonString.Value;
    if jsonProp.JsonValue is TJSONArray then
    begin
      propValue := ((jsonProp.JsonValue as TJSONArray).Items[0] as TJSONString).Value;
      propType  := ((jsonProp.JsonValue as TJSONArray).Items[1] as TJSONString).Value;
    end
    else
    begin
      propValue := jsonProp.JsonValue.Value;
      propType  := '';
    end;
    if Length(propType) > 0 then
      xml := xml + Format('<d:%s m:type="%s">%s</d:%s>', [propName, propType, propValue, propName])
    else
      xml := xml + Format('<d:%s>%s</d:%s>', [propName, propValue, propName]);
  end;
  xml := xml + '</m:properties>' +
             '</content>' +
           '</entry>';
  InputStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(xml));
  try
    try
      FDSHTTP.Put(url, InputStream);
      Result := FDSHTTP.ResponseCode = 204;
    except
      Result := false;
    end;
  finally
    FReturnCode := FDSHTTP.ResponseCode;
    InputStream.Free;
  end;
end;

{ TAzureQueueService }

function TAzureQueueService.CreateQueue(const QueueName: String): boolean;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.QueueURL, QueueName]);
  FDSHTTP.Request.ContentType := '';
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if not FConnectionString.UseDevelopmentStorage then
  begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s', [FConnectionString.AccountName,
                               QueueName])])
  end
  else
    StringToSign('PUT', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName])]);

  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    FDSHTTP.Put(url);
    FReturnCode := FDSHTTP.ResponseCode;
    Result := (FDSHTTP.ResponseCode = 201) or (FDSHTTP.ResponseCode = 204);
  except
    FReturnCode := FDSHTTP.ResponseCode;
    Result := false;
  end;
end;

function TAzureQueueService.ClearMessages(const QueueName: String): boolean;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s/messages', [FConnectionString.QueueURL, QueueName]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.ContentType := '';
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('DELETE', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s/messages', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('DELETE', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s/messages', [FConnectionString.AccountName, QueueName])]);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    FDSHTTP.Delete(url);
    Result := FDSHTTP.ResponseCode = 204;
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureQueueService.CreateQueue(const QueueName: String;
  const MetaDataHeaders: TStringList): boolean;
var
  msDate: String;
  url: String;
  idx: Integer;
begin
  url := Format('%s/%s', [FConnectionString.QueueURL, QueueName]);
  msDate := XMsDate;
  MetaDataHeaders.Values['x-ms-date'] := msDate;
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('PUT', ['','',''], MetaDataHeaders,
       [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName])])
  else
  begin
    MetaDataHeaders.Values['x-ms-version'] := '2009-09-19';
    StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''],
       MetaDataHeaders,
       [Format('/%s/%s', [FConnectionString.AccountName,
                               QueueName])])
  end;

  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := '';
  for idx := 0 to MetaDataHeaders.Count - 1 do
    FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(MetaDataHeaders.Names[idx]),
                                                         MetaDataHeaders.ValueFromIndex[idx]);

  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  try
    FDSHTTP.Put(url);
    Result := FDSHTTP.ResponseCode = 201;
    FReturnCode := FDSHTTP.ResponseCode;
  except
    FReturnCode := FDSHTTP.ResponseCode;
    Result := false;
  end;
end;

function TAzureQueueService.DeleteMessage(const QueueName, MessageId,
  PopReceipt: String): boolean;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s/messages/%s?popreceipt=%s', [FConnectionString.QueueURL, QueueName,
            MessageId, PopReceipt]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.ContentType := '';
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('DELETE', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s/messages/%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName, MessageId])])
  else begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('DELETE', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s/messages/%s', [FConnectionString.AccountName, QueueName, MessageId]),
        CanonicalizedQueryParams(['popreceipt'], [PopReceipt], [], [])]);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    FDSHTTP.Delete(url);
    Result := FDSHTTP.ResponseCode = 204;
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureQueueService.DeleteQueue(const QueueName: String): boolean;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.QueueURL, QueueName]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.ContentType := '';
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('DELETE', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName])])
  else
  begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('DELETE', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s', [FConnectionString.AccountName,
                               QueueName])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  try
    FDSHTTP.Delete(url);
    Result := FDSHTTP.ResponseCode = 204;
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureQueueService.GetMessageId(const QueueMessage: String): String;
begin
  Result := XMLText(QueueMessage, 'MessageId');
end;

function TAzureQueueService.GetMessages(const QueueName: String; NumOfMessages,
  VisibilityTimeout: Integer): String;
var
  msDate: String;
  url: String;
  userParams, userValues: TVarRecArray;
begin
  msDate := XMsDate;
  url := Format('%s/%s/messages', [FConnectionString.QueueURL, QueueName]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := '';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);

  if NumOfMessages > 0 then
  begin
    if VisibilityTimeout > 0 then
    begin
      userParams := CreateRecArray(['numofmessages', 'visibilitytimeout']);
      userValues := CreateRecArray([IntToStr(NumOfMessages), IntToStr(VisibilityTimeout)])
    end
    else
    begin
      userParams := CreateRecArray(['numofmessages']);
      userValues := CreateRecArray([IntToStr(NumOfMessages)])
    end
  end
  else if VisibilityTimeout > 0 then
  begin
    userParams := CreateRecArray(['visibilitytimeout']);
    userValues := CreateRecArray([IntToStr(VisibilityTimeout)])
  end;

  if FConnectionString.UseDevelopmentStorage then
    StringToSign('GET', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s/messages', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName])])
  else
  begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s/messages', [FConnectionString.AccountName, QueueName]),
        CanonicalizedQueryParams(userParams, userValues, [], [])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    Result := GetResponse(url + QueryParams(userParams, userValues));
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureQueueService.GetPopReceipt(const QueueMessage: String): String;
begin
  Result := XMLText(QueueMessage, 'PopReceipt');
end;

function TAzureQueueService.GetQueueMetadata(const QueueName: String): boolean;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := Format('%s/%s', [FConnectionString.QueueURL, QueueName]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.ContentType := '';
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('GET', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s?%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName, 'comp=metadata'])])
  else
  begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s', [FConnectionString.AccountName, QueueName]),
       CanonicalizedQueryParams(['comp'], ['metadata'], [], [])]);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    FDSHTTP.Get(url + QueryParams(['comp'], ['metadata']));
    FReturnCode := FDSHTTP.ResponseCode;
    Result := FReturnCode = 200;
  except
    FReturnCode := FDSHTTP.ResponseCode;
    Result := False;
  end;
end;

function TAzureQueueService.ListQueues(params: array of const; values: array of const): String;
var
  msDate: String;
  url: String;
begin
  msDate := XMsDate;
  url := FConnectionString.QueueURL;
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.ContentType := '';
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('GET', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s?%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               'comp=list'])])
  else
  begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/', [FConnectionString.AccountName]),
        CanonicalizedQueryParams(['comp'], ['list'], params, values)]);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  try
    Result := GetResponse(url + QueryParams(['comp'], ['list'], params, values));
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureQueueService.PeekMessages(const QueueName: String;
  NumOfMessages: Integer): String;
var
  msDate: String;
  url: String;
  userParams, userValues: TVarRecArray;
begin
  msDate := XMsDate;
  url := Format('%s/%s/messages', [FConnectionString.QueueURL, QueueName]);
  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := '';
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  if FConnectionString.UseDevelopmentStorage then
  begin
    StringToSign('GET', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s/messages%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName, '?peekonly=true'])]);
    url := url + '?peekonly=true';
    if NumOfMessages > 0 then
      url := url + '&numofmessages=' + IntToStr(NumOfMessages);

  end
  else
  begin
    if NumOfMessages > 0 then
    begin
      userParams := CreateRecArray(['peekonly', 'numofmessages']);
      userValues := CreateRecArray(['true', IntToStr(NumOfMessages)]);
    end else begin
      userParams := CreateRecArray(['peekonly']);
      userValues := CreateRecArray(['true']);
    end;
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('GET', ['', '', '', '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'],
       [msDate, '2009-09-19'],
       [Format('/%s/%s/messages', [FConnectionString.AccountName, QueueName]),
        CanonicalizedQueryParams(userParams, userValues, [], [])]);
    url := url + QueryParams(userParams, userValues);
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    Result := GetResponse(url);
  finally
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureQueueService.PutMessage(const QueueName, MessageText: String;
  const TimeToLive: Integer): boolean;
var
  strContent: String;
  msDate: String;
  url: String;
  reqStream: TBytesStream;
  userParams, userValues: TVarRecArray;
begin
  strContent := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>' +
    '<QueueMessage><MessageText>' + MessageText + '</MessageText></QueueMessage>';

  url := Format('%s/%s/messages', [FConnectionString.QueueURL, QueueName]);
  msDate := XMsDate;

  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.CustomHeaders.AddValue('x-ms-date', msDate);
  FDSHTTP.Request.ContentType := '';
  if TimeToLive > 0 then
  begin
    userParams := CreateRecArray(['messagettl']);
    userValues := CreateRecArray([IntToStr(TimeToLive)]);
  end
  else
  begin
    SetLength(userParams, 0);
    SetLength(userValues, 0);
  end;

  reqStream := TBytesStream.Create(TEncoding.UTF8.GetBytes(strContent));
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('POST', ['', '', ''],
       ['x-ms-date'],
       [msDate],
       [Format('/%s/%s/%s/messages%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName, QueryParams(userParams, userValues)])])
  else
  begin
    FDSHTTP.Request.CustomHeaders.AddValue('x-ms-version', '2009-09-19');
    StringToSign('POST', ['', '', IntToStr(reqStream.Size), '', '', '', '', '', '', '', ''],
       ['x-ms-date', 'x-ms-version'], [msDate, '2009-09-19'],
       [Format('/%s/%s/messages', [FConnectionString.AccountName, QueueName]),
        CanonicalizedQueryParams(userParams, userValues, [], [])])
  end;
  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);

  try
    try
      FDSHTTP.Post(url + QueryParams(userParams, userValues), reqStream);
      Result := FDSHTTP.ResponseCode = 201;
    except
      Result := false;
    end;
  finally
    reqStream.Free;
    FReturnCode := FDSHTTP.ResponseCode;
  end;
end;

function TAzureQueueService.PutQueueMetadata(const QueueName: String;
  const MetaDataHeaders: TStringList): boolean;
var
  msDate: String;
  url: String;
  idx: Integer;
  queryString: String;
begin
  queryString := 'comp=metadata';
  url := Format('%s/%s', [FConnectionString.QueueURL, QueueName]);
  msDate := XMsDate;
  MetaDataHeaders.Values['x-ms-date'] := msDate;
  if FConnectionString.UseDevelopmentStorage then
    StringToSign('PUT', ['','',''], MetaDataHeaders,
       [Format('/%s/%s/%s?%s', [FConnectionString.AccountName, FConnectionString.AccountName,
                               QueueName, 'comp=metadata'])])
  else
  begin
    MetaDataHeaders.Values['x-ms-version'] := '2009-09-19';
    StringToSign('PUT', ['', '', '0', '', '', '', '', '', '', '', ''],
       MetaDataHeaders,
       [Format('/%s/%s', [FConnectionString.AccountName, QueueName]), CanonicalizedQueryParams(['comp'], ['metadata'], [], [])])
  end;

  FDSHTTP.Request.CustomHeaders.Clear;
  FDSHTTP.Request.CustomHeaders.FoldLines := false;
  FDSHTTP.Request.ContentType := '';
  for idx := 0 to MetaDataHeaders.Count - 1 do
    FDSHTTP.Request.CustomHeaders.AddValue(AnsiLowerCase(MetaDataHeaders.Names[idx]),
                                                         MetaDataHeaders.ValueFromIndex[idx]);

  FDSHTTP.Request.CustomHeaders.AddValue('Authorization', FSharedKeyAuth.Authentication);
  try
    FDSHTTP.Put(url + QueryParams(['comp'], ['metadata']));
    Result := FDSHTTP.ResponseCode = 204;
    FReturnCode := FDSHTTP.ResponseCode;
  except
    FReturnCode := FDSHTTP.ResponseCode;
    Result := false;
  end;
end;

function TAzureQueueService.XMLText(const xml, NodeName: String): String;
var
  idx, ndx: Integer;
  xmlNode, xmlEndNode: String;
begin
  xmlNode := '<' + NodeName + '>';
  idx := Pos(xmlNode, xml);
  if idx > 0 then
  begin
    xmlEndNode := '</' + NodeName + '>';
    idx := idx + Length(xmlNode);
    ndx := PosEx(xmlEndNode, xml, idx);
    Result := Copy(xml, idx, ndx - idx)
  end
  else
    Result := '';
end;

{TAzureHTTP}

constructor TAzureHTTP.Create;
begin
  inherited Create(nil);
end;

function TAzureHTTP.Delete(AURL: string): string;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    DoRequest(Id_HTTPMethodDelete, AURL, nil, LStream, []);
    LStream.Position := 0;
    // This is here instead of a TStringStream for .net conversions?
    Result := ReadStringFromStream(LStream, -1);//, ContentTypeToEncoding(Response.ContentType));
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TAzureHTTP.InitComponent;
begin
  inherited;
  Protocol := 'http';
end;

function TAzureHTTP.Delete(AURL: string; AResponseStream: TStream): string;
begin
  DoRequest(Id_HTTPMethodDelete, AURL, nil, AResponseStream, []);
end;

procedure TAzureHTTP.Head(AURL: string);
begin
  DoRequest(Id_HTTPMethodHead, AURL, nil, nil, []);
end;

procedure TAzureHTTP.Merge(AURL: string; RequestStream: TStream);
begin
  DoRequest('MERGE', AURL, RequestStream, nil, []);
end;

function TAzureHTTP.Put(AURL: string): string;
var
  emptyStream: TMemoryStream;
begin
  emptyStream := TMemoryStream.Create;
  try
    Result := Put(AURL, emptyStream);
  finally
    emptyStream.Free;
  end;
end;

procedure TAzureHTTP.SetAuthentication(auth: TIdAuthentication);
begin
  FAuthentication := auth;
  Request.Authentication := auth;
end;

procedure TAzureHTTP.SetBasicAuthentication(const user, password: String);
begin
  FAuthentication := TIdBasicAuthentication.Create;
  FAuthentication.Password := password;
  FAuthentication.Username := user;
  Request.Authentication := FAuthentication;
end;

end.
