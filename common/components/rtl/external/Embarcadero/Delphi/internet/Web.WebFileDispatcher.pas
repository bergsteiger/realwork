{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ *************************************************************************** }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit Web.WebFileDispatcher;

interface

  uses System.Classes, System.SysUtils, System.Masks, System.Generics.Collections;

type

  TWebFileExtensions = class;
  TWebDirectories = class;
  TWebFileDispatcherProperties = class;

  TDispatchFileRequest = class
  private
    FProperties: TWebFileDispatcherProperties;
    function QualifyFileName(AFileName: string): string;
    function IsDispatchFileName(const APathInfo: string): Boolean;
    function GetDispatchFileName(const APathInfo: string; out AFileName: string): Boolean;
    function CanDispatchFileName(const AFileName: string): Boolean;
    function IsIncludeDirectory(const ADirectory: string): Boolean;
    function SetResponse(const AFileName: string): Boolean;
    function GetMimeType(const FileName: string): string;
    procedure UpdateExtensionMimeType;
  protected
    function GetApplicationPath: string; virtual;
    function IsGetRequest: Boolean; virtual; abstract;
    function IsHeadRequest: Boolean; virtual; abstract;
    procedure SetErrorCode(AStatusCode: Integer); virtual; abstract;
    function GetIfModifiedSince: TDateTime; virtual; abstract;
    procedure SetContentStream(AStream: TStream); virtual; abstract;
    procedure SetContentLength(ALength: Integer); virtual; abstract;
    procedure SetContentType(const AValue: string); virtual; abstract;
    procedure SetLastModified(AValue: TDateTime); virtual; abstract;
    function GetExceptionClass: TClass; virtual; abstract;
    procedure DoBeforeDispatch(const AFileName: string; var AHandled: Boolean); virtual; abstract;
    procedure DoAfterDispatch(const AFileName: string; var AHandled: Boolean); virtual; abstract;
    function GetRequestPathInfo: string; virtual; abstract;
    function GetResponseSent: Boolean; virtual; abstract;
  public
    constructor Create(AProperties: TWebFileDispatcherProperties);
    destructor Destroy; override;
    function DispatchFileRequest: Boolean;
  end;

  TWebFileDispatcherProperties = class(TComponent)
  private
    FRootDirectory: string;
    FExtensionMimeType: TDictionary<string, string>;
    FWebFileExtensions: TWebFileExtensions;
    FWebDirectories: TWebDirectories;
    procedure SetWebFileExtension(const Value: TWebFileExtensions);
    procedure SetWebDirectories(const Value: TWebDirectories);
    function GetRootDirectory: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property RootDirectory: string read GetRootDirectory write FRootDirectory;
    property WebFileExtensions: TWebFileExtensions read FWebFileExtensions write SetWebFileExtension;
    property WebDirectories: TWebDirectories read FWebDirectories write SetWebDirectories;
  end;

  TWebFileExtensionItem = class(TCollectionItem)
  private
    FExtensions : String;
    FMimeType : String;
    procedure SetMimeType(const Value: String);
    procedure SetExtensions(const Value: String);
    function GetComponentState: TComponentState;
    property ComponentState: TComponentState read GetComponentState;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(AOwner: TCollection; const AMimeType, AExtensions: string); reintroduce;
  published
    property MimeType : String read FMimeType write SetMimeType;
    property Extensions : String read FExtensions write SetExtensions;
  end;

  TWebFileExtensions = class(TCollection)
  private
    FOwner: TComponent;
    procedure SetDefaultExtensions;
  protected
    function GetItem(Index: Integer) : TWebFileExtensionItem;
    procedure SetItem(Index: Integer; const Value: TWebFileExtensionItem );
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TComponent);
    function Add: TWebFileExtensionItem;
    property Items[Index: Integer]: TWebFileExtensionItem read GetItem
      write SetItem; default;
  end;

  TWebDirectoryAction = (dirInclude, dirExclude);

  TWebDirectoryItem = class(TCollectionItem)
  private
    FDirectoryAction : TWebDirectoryAction;
    FDirectoryMask : string;
    FMask: TMask;
    procedure UpdateMask;
    procedure SetDirectoryMask(const Value: String);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(AOwner: TCollection; ADirectoryAction: TWebDirectoryAction; const ADirectoryMask: string); reintroduce;
    destructor Destroy; override;
  published
    property DirectoryAction: TWebDirectoryAction read FDirectoryAction write FDirectoryAction;
    property DirectoryMask : String read FDirectoryMask write SetDirectoryMask;
  end;

  TWebDirectories = class(TCollection)
  private
    FOwner: TComponent;
    procedure SetDefaultDirectories;
  protected
    function GetItem(Index: Integer) : TWebDirectoryItem;
    procedure SetItem(Index: Integer; const Value: TWebDirectoryItem );
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TComponent);
    function Add: TWebDirectoryItem;
    property Items[Index: Integer]: TWebDirectoryItem read GetItem
      write SetItem; default;
  end;

  TLookupMimeType = function(const AExtensions: string): string;
  TLookupExtensions = function(const AMimeType: string): string;

  TExtensionMethod = reference to function(AExt: PChar; ALength: Integer): Boolean;
  function EnumerateExtensions(const Extensions: string; WithDot: Boolean; Method: TExtensionMethod): Boolean;

var
  FLookupMimeType: TLookupMimeType;
  FLookupExtensions: TLookupExtensions;

implementation

uses System.DateUtils, System.StrUtils, Web.WebConst;

type
  TSkipPreambleStream = class(TStream)
  private
    FEncodingLength: Integer;
    FStream: TStream;
  protected
    function GetSize: Int64; override;
    procedure SetSize(NewSize: Longint); overload; override;
    procedure SetSize(const NewSize: Int64); overload; override;
  public
    constructor Create(AStream: TStream; AEncodingLength: Integer);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; overload; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; overload; override;
  end;

function EnumerateExtensions(const Extensions: string; WithDot: Boolean; Method: TExtensionMethod): Boolean;
var
  I, J: Integer;
  Ext: array[0..255] of Char;
begin
  I := Low(Extensions);
  while I <= High(Extensions) do
  begin
    if WithDot then
    begin
      Ext[0] := '.';
      J := 1;
    end
    else
      J := 0;
    while (I <= High(Extensions)) and (Extensions[I] <> ';') do
    begin
      if Extensions[I] <> ' ' then
      begin
        Ext[J] := Extensions[I];
        Inc(J);
      end;
      Inc(I);
    end;
    Ext[J] := #0;
    if not Method(Ext, J) then
      Exit(False);
    Inc(I);
  end;
  Result := True;
end;

function TDispatchFileRequest.IsIncludeDirectory(const ADirectory: string): Boolean;
var
  I: Integer;
  LItem: TWebDirectoryItem;
begin
  if FProperties.FWebDirectories.Count = 0 then
    Exit(False);
  Result := False;
  for I := 0 to FProperties.FWebDirectories.Count - 1 do
  begin
    LItem := FProperties.FWebDirectories[I];
    LItem.UpdateMask;
    if LItem.FMask <> nil then
    begin
      case LItem.FDirectoryAction of
        dirInclude:
          if LItem.FMask.Matches(ADirectory) then
            Result := True;
        dirExclude:
          if LItem.FMask.Matches(ADirectory) then
            Result := False;
      end;
    end;
  end;
end;

function TDispatchFileRequest.CanDispatchFileName(
  const AFileName: string): Boolean;
begin
  Result := IsIncludeDirectory(ExtractFilePath(AFileName));
end;

constructor TDispatchFileRequest.Create(AProperties: TWebFileDispatcherProperties);
begin
  FProperties := AProperties;
end;

destructor TDispatchFileRequest.Destroy;
begin
  inherited Destroy;
end;

function TDispatchFileRequest.GetApplicationPath: string;
var
  LModuleName: string;
begin
  LModuleName := GetModuleName(MainInstance);
  // UNC issue in Vista.
  if Pos('\\?\', LModuleName) = 1 then
    Delete(LModuleName, 1, 4);
  Result := ExtractFilePath(LModuleName);
end;

function TDispatchFileRequest.QualifyFileName(AFileName: string): string;
var
  LRootDirectory: string;
begin
  if (Length(AFileName) > 0) and (AFileName[Low(string)] = PathDelim) then
      Delete(AFileName, 1, 1);
  Result := AFileName;
  LRootDirectory := IncludeTrailingPathDelimiter(FProperties.FRootDirectory);
  if not (((Length(LRootDirectory) >= 3) and (LRootDirectory[1+Low(string)] = ':')) or
    ((Length(LRootDirectory) >= 2) and (LRootDirectory[Low(string)] = PathDelim) and (Result[1+Low(string)] = PathDelim))) then
    if not ((Length(LRootDirectory) >= 1) and (LRootDirectory[Low(string)] = PathDelim)) then
      Result := GetApplicationPath + LRootDirectory + AFileName
    else
      Result := ExtractFileDrive(GetApplicationPath) + LRootDirectory + AFileName
  else
    Result := LRootDirectory + AFileName; // Absolute path
  Result := ExpandFileName(Result);
end;

function TDispatchFileRequest.GetMimeType(const FileName: string): string;
begin
  UpdateExtensionMimeType;
  if not FProperties.FExtensionMimeType.TryGetValue(Lowercase(ExtractFileExt(FileName)), Result) then
    Result := 'application/octet-stream';
end;

function TDispatchFileRequest.SetResponse(const AFileName: string): Boolean;
var
  LStream: TStream;
  LFileAge: TDateTime;
  LIfModifiedSince: TDateTime;
  LMimeType: string;
  LBytes: TBytes;
  LEncodingLength: Integer;
  LEncoding: TEncoding;
begin
  if not FileExists(AFileName) then
  begin
    SetErrorCode(404);
    Exit(True);
  end;

  LIfModifiedSince := GetIfModifiedSince;
  if LIfModifiedSince <> -1 then
  begin
    LIfModifiedSince := TTimeZone.Local.ToLocalTime(GetIfModifiedSince);
    FileAge(AFileName, LFileAge);
    if Abs(LFileAge - LIfModifiedSince) < OneSecond then
    begin
      LMimeType := GetMimeType(AFileName);
      SetContentType(LMimeType);

      SetErrorCode(304);
      Exit(True);
    end;
  end;

  LStream := TFileStream.Create(AFileName, fmShareDenyWrite);
  LMimeType := GetMimeType(AFileName);
  if System.StrUtils.StartsText('text/', Lowercase(LMimeType)) then
  begin
    SetLength(LBytes, Length(TEncoding.UTF8.GetPreamble));
    // Detect UTF-8 encoding, remove BOM and set content type
    if LStream.Read(LBytes[0], Length(LBytes)) = Length(LBytes) then
    begin
      LEncoding := nil;
      LEncodingLength := TEncoding.GetBufferEncoding(LBytes, LEncoding, TEncoding.ANSI);
      if (LEncodingLength > 0) and (LEncoding = TEncoding.UTF8) then
      begin
        if Pos('charset', Lowercase(LMimeType)) <= 0 then    // Do not localize
          LMimeType := LMimeType + '; charset=utf-8'; // Do not localize
        LStream.Position := 0;
        LStream := TSkipPreambleStream.Create(LStream, LEncodingLength);
      end;
    end
  end;
  LStream.Position := 0;

  try
    if IsGetRequest then
    begin
      SetContentStream(LStream);
      LStream := nil;
    end
    else
      SetContentLength(LStream.Size);
    FileAge(AFileName, LFileAge);
    SetLastModified(TTimeZone.Local.ToUniversalTime(LFileAge));
    SetContentType(LMimeType);
  finally
    LStream.Free;
  end;
  Result := True;
end;

function TDispatchFileRequest.DispatchFileRequest: Boolean;
var
  LFileName: string;
  LPathInfo: string;
begin
  Result := False;
  LPathInfo := GetRequestPathInfo;
  if (IsHeadRequest or IsGetRequest) and IsDispatchFileName(LPathInfo) then
  begin
    if GetDispatchFileName(LPathInfo, LFileName) and
       CanDispatchFileName(LFileName) then
    begin
      LFileName := QualifyFileName(LFileName);
      DoBeforeDispatch(LFileName, Result);
      if not Result then
      begin
        Result := SetResponse(LFileName);
      end;
      if Result and not GetResponseSent then
        DoAfterDispatch(LFileName, Result);
    end;
  end;
end;

function TDispatchFileRequest.GetDispatchFileName(
  const APathInfo: string; out AFileName: string): Boolean;
begin
  Result := True;
  if PathDelim <> '/' then
    AFileName := StringReplace(APathInfo, '/', PathDelim, [rfReplaceAll])
  else
    AFileName := APathInfo;
end;

procedure TDispatchFileRequest.UpdateExtensionMimeType;
var
  LItem: TWebFileExtensionItem;
  LLookupMimeType: string;
  I: Integer;
  LException: Exception;
begin
  if FProperties.FExtensionMimeType = nil then
  begin
    FProperties.FExtensionMimeType := TDictionary<string, string>.Create;
    for I := 0 to FProperties.FWebFileExtensions.Count - 1 do
    begin
      LItem := FProperties.FWebFileExtensions[I];
      EnumerateExtensions(Lowercase(LItem.Extensions), True,
        function(AExt: PChar; ALength: Integer): Boolean
        begin
          Result := True;
          if FProperties.FExtensionMimeType.TryGetValue(AExt, LLookupMimeType) then
          begin
            if LLookupMimeType <> Lowercase(LItem.MimeType) then
            begin
              LException := Exception(GetExceptionClass.Create);
              LException.Message := Format(sDuplicateMimeTypes, [AExt]);
              raise LException;
            end;
          end
          else
            FProperties.FExtensionMimeType.Add(AExt, Lowercase(LItem.MimeType));
        end
        );
    end;
  end;
end;

function TDispatchFileRequest.IsDispatchFileName(
  const APathInfo: string): Boolean;
begin
  UpdateExtensionMimeType;
  Result := FProperties.FExtensionMimeType.ContainsKey(Lowercase(ExtractFileExt(APathInfo)));
end;

{ TWebFileExtensionItem }

constructor TWebFileExtensionItem.Create(AOwner: TCollection; const AMimeType, AExtensions: string);
begin
  inherited Create(AOwner);
  FExtensions := AExtensions;
  FMimeType := AMimeType;
end;

function TWebFileExtensionItem.GetComponentState: TComponentState;
begin
  if Collection.Owner is TComponent then
    Result := TComponent(Collection.Owner).ComponentState
  else
    Result := [];
end;

function TWebFileExtensionItem.GetDisplayName: string;
begin
  Result := Format(sWebFileExtensionsItemDisplayName,
    [FMimeType, FExtensions]);
end;

procedure TWebFileExtensionItem.SetMimeType(const Value: String);
var
  LLookup: string;
  LLast: string;
begin
  LLast := FMimeType;
  FMimeType := Value;
  if (not (csLoading in ComponentState)) and
    (csDesigning in ComponentState) then
  begin
    if Assigned(FLookupExtensions) and Assigned(FLookupMimeType) then
      LLookup := FLookupExtensions(FMimeType);
    if LLookup <> '' then
      if (FExtensions = '') or SameText(FLookupMimeType(FExtensions), LLast) then
        FExtensions := LLookup;
  end;
end;

procedure TWebFileExtensionItem.SetExtensions(const Value: String);
var
  LLookup: string;
  LLast: string;
begin
  LLast := FExtensions;
  FExtensions := Value;
  if (not (csLoading in ComponentState)) and
    (csDesigning in ComponentState) then
  begin
    if Assigned(FLookupExtensions) and Assigned(FLookupMimeType) then
      LLookup := FLookupMimeType(FExtensions);
    if LLookup <> '' then
      if (FMimeType = '') or SameText(FLookupMimeType(LLast), FMimeType) then
        FMimeType := LLookup;
  end;
end;

{ TWebFileExtensions }

function TWebFileExtensions.Add: TWebFileExtensionItem;
begin
  Result := TWebFileExtensionItem(inherited Add);
end;

constructor TWebFileExtensions.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
  inherited Create(TWebFileExtensionItem);
  SetDefaultExtensions;
end;

procedure TWebFileExtensions.SetDefaultExtensions;
begin
  TWebFileExtensionItem.Create(Self, 'text/css', 'css');
  TWebFileExtensionItem.Create(Self, 'text/html', 'html;htm');
  TWebFileExtensionItem.Create(Self, 'text/javascript', 'js');
  TWebFileExtensionItem.Create(Self, 'image/jpeg', 'jpeg;jpg');
  TWebFileExtensionItem.Create(Self, 'image/x-png', 'png');
end;

function TWebFileExtensions.GetItem(Index: Integer): TWebFileExtensionItem;
begin
  Result := TWebFileExtensionItem(inherited GetItem(Index));
end;

procedure TWebFileExtensions.SetItem(Index: Integer;
  const Value: TWebFileExtensionItem);
begin
  inherited SetItem(Index,Value);
end;

function TWebFileExtensions.GetAttrCount: Integer;
begin
  Result := 2;
end;

function TWebFileExtensions.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sWebFileExtensionItemExtensions;
    1: Result := sWebFileExtensionItemMimeType;
  else
    Result := '';
  end;
end;

function TWebFileExtensions.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Items[ItemIndex].Extensions;
    1: Result := Items[ItemIndex].MimeType;
  else
    Result := '';
  end;
end;

function TWebFileExtensions.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TWebDirectoryItem }

constructor TWebDirectoryItem.Create(AOwner: TCollection; ADirectoryAction: TWebDirectoryAction; const ADirectoryMask: string);

begin
  inherited Create(AOwner);
  FDirectoryAction := ADirectoryAction;
  FDirectoryMask := ADirectoryMask;
end;

destructor TWebDirectoryItem.Destroy;
begin
  FMask.Free;
  inherited;
end;


function TWebDirectoryItem.GetDisplayName: string;
var
  LDirectoryAction: string;
begin
  case FDirectoryAction of
    dirInclude: LDirectoryAction := sWebDirectoryInclude;
    dirExclude: LDirectoryAction := sWebDirectoryInclude;
  end;
  Result := Format(sWebDirectoryItemDisplayName,
    [LDirectoryAction, FDirectoryMask]);
end;

procedure TWebDirectoryItem.SetDirectoryMask(const Value: String);
begin
  if Value <> FDirectoryMask then
  begin
    FDirectoryMask := Value;
    FreeAndNil(FMask);
  end;
end;


procedure TWebDirectoryItem.UpdateMask;
var
  S: string;
begin
  if FMask = nil then
  begin
      S := Trim(FDirectoryMask);
      if S <> '' then
      begin
        if S[Low(string)] <> PathDelim then
          // Force leading path delimiter
          S := PathDelim + S;
        FMask := TMask.Create(S);
      end;
  end;
end;

{ TWebDirectories }

function TWebDirectories.Add: TWebDirectoryItem;
begin
  Result := TWebDirectoryItem(inherited Add);
end;

constructor TWebDirectories.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
  inherited Create(TWebDirectoryItem);
  SetDefaultDirectories;
end;

procedure TWebDirectories.SetDefaultDirectories;
begin
  TWebDirectoryItem.Create(Self, TWebDirectoryAction.dirInclude, '*');
  TWebDirectoryItem.Create(Self, TWebDirectoryAction.dirExclude, '\templates\*');
end;

function TWebDirectories.GetItem(Index: Integer): TWebDirectoryItem;
begin
  Result := TWebDirectoryItem(inherited GetItem(Index));
end;

procedure TWebDirectories.SetItem(Index: Integer;
  const Value: TWebDirectoryItem);
begin
  inherited SetItem(Index,Value);
end;

function TWebDirectories.GetAttrCount: Integer;
begin
  Result := 2;
end;

function TWebDirectories.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sWebFileDirectoryItemAction;
    1: Result := sWebFileDirectoryItemMask;
  else
    Result := '';
  end;
end;

function TWebDirectories.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0:
    case Items[ItemIndex].DirectoryAction of
      dirInclude: Result := 'Include';
      dirExclude: Result := 'Exclude';
    end;
    1: Result := Items[ItemIndex].DirectoryMask;
  else
    Result := '';
  end;
end;

function TWebDirectories.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TWebFileDispatcherProperties }

constructor TWebFileDispatcherProperties.Create(AOwner: TComponent);
begin
  inherited;
  FWebFileExtensions := TWebFileExtensions.Create(AOwner);
  FWebDirectories := TWebDirectories.Create(AOwner);
end;

destructor TWebFileDispatcherProperties.Destroy;
begin
  inherited Destroy;
  FWebFileExtensions.Free;
  FWebDirectories.Free;
  FExtensionMimeType.Free;
end;

function TWebFileDispatcherProperties.GetRootDirectory: string;
begin
  if Trim(FRootDirectory) = '' then
    Result := '.'
  else
    Result := FRootDirectory;
end;

procedure TWebFileDispatcherProperties.SetWebFileExtension(
  const Value: TWebFileExtensions);
begin
  FWebFileExtensions.Assign(Value);
end;

procedure TWebFileDispatcherProperties.SetWebDirectories(
  const Value: TWebDirectories);
begin
  FWebDirectories.Assign(Value);
end;

{ TSkipPreambleStream }

constructor TSkipPreambleStream.Create(AStream: TStream;
  AEncodingLength: Integer);
begin
  FStream := AStream;
  FStream.Position := AEncodingLength;
  FEncodingLength := AEncodingLength;
end;

destructor TSkipPreambleStream.Destroy;
begin
  FStream.Free;
  inherited;
end;

function TSkipPreambleStream.GetSize: Int64;
begin
  Result := FStream.Size - FEncodingLength;
end;

function TSkipPreambleStream.Read(var Buffer; Count: Integer): Longint;
begin
  Result := FStream.Read(Buffer, Count);
end;

function TSkipPreambleStream.Seek(Offset: Integer; Origin: Word): Longint;
begin
  if Origin = soFromBeginning then
    Result := FStream.Seek(Offset + FEncodingLength, Origin) - FEncodingLength
  else
    Result := FStream.Seek(Offset, Origin) - FEncodingLength
end;

function TSkipPreambleStream.Seek(const Offset: Int64;
  Origin: TSeekOrigin): Int64;
begin
  if Origin = TSeekOrigin.soBeginning then
    Result := FStream.Seek(Offset + FEncodingLength, Origin) - FEncodingLength
  else
    Result := FStream.Seek(Offset, Origin) - FEncodingLength
end;

procedure TSkipPreambleStream.SetSize(NewSize: Integer);
begin
  FStream.Size := NewSize;
end;

procedure TSkipPreambleStream.SetSize(const NewSize: Int64);
begin
  FStream.Size := NewSize;
end;

function TSkipPreambleStream.Write(const Buffer; Count: Integer): Longint;
begin
  Result := FStream.Write(Buffer, Count);
end;

end.
