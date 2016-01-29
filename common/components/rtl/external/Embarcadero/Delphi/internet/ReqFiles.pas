{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Web server application components               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit ReqFiles;

interface

uses System.SysUtils, System.Classes, System.Contnrs, Web.HTTPApp;

type

{ TWebRequestFile }

  TWebRequestFile = class(TAbstractWebRequestFile)
  private
    FFieldName: AnsiString;
    FFileName: AnsiString;
    FStream: TStream;
    FContentType: AnsiString;
  protected
    function GetFieldName: AnsiString; override;
    function GetFileName: AnsiString; override;
    function GetStream: TStream; override;
    function GetContentType: AnsiString; override;
  public
    constructor Create(const AFieldName, AFileName, AContentType: AnsiString;
  AContent: Pointer; AContentLength: Integer);
    destructor Destroy; override;
  end;

{ TWebRequestFiles }

  TWebRequestFiles = class(TAbstractWebRequestFiles)
  private
    FList: TObjectList;
  protected
    function GetCount: Integer; override;
    function GetItem(I: Integer): TAbstractWebRequestFile; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const AName, AFileName, AContentType: AnsiString; AContent: Pointer; AContentLength: Integer); overload;
    procedure Add(AFile: TWebRequestFile); overload;
  end;

  TWebRequestFileStream = class(TCustomMemoryStream)
  public
    constructor Create(ABuffer: Pointer; Size: Integer);
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

implementation

uses Web.WebConst, WebComp, Web.BrkrConst;

{ TWebRequestFiles }

procedure TWebRequestFiles.Add(const AName, AFileName, AContentType: AnsiString;
  AContent: Pointer; AContentLength: Integer);
begin
  Add(TWebRequestFile.Create(AName, AFileName, AContentType,
    AContent, AContentLength));
end;

procedure TWebRequestFiles.Add(AFile: TWebRequestFile);
begin
  FList.Add(AFile);
end;

constructor TWebRequestFiles.Create;
begin
  FList := TObjectList.Create(True {Owned});
  inherited Create;
end;

destructor TWebRequestFiles.Destroy;
begin
  inherited;
  FList.Free;
end;

function TWebRequestFiles.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TWebRequestFiles.GetItem(I: Integer): TAbstractWebRequestFile;
begin
  Result := FList[I] as TAbstractWebRequestFile;
end;

{ TWebRequestFile }

constructor TWebRequestFile.Create(const AFieldName, AFileName, AContentType: AnsiString;
  AContent: Pointer; AContentLength: Integer);
begin
  FFieldName := AFieldName;
  FFileName := AFileName;
  FContentType := AContentType;
  FStream := TWebRequestFileStream.Create(AContent, AContentLength);
  inherited Create;
end;

destructor TWebRequestFile.Destroy;
begin
  inherited;
  FStream.Free;
end;

function TWebRequestFile.GetContentType: AnsiString;
begin
  Result := FContentType;
end;

function TWebRequestFile.GetFieldName: AnsiString;
begin
  Result := FFieldName;
end;

function TWebRequestFile.GetFileName: AnsiString;
begin
  Result := FFileName;
end;

function TWebRequestFile.GetStream: TStream;
begin
  Result := FStream;
end;

{ TWebRequestFileStream }

constructor TWebRequestFileStream.Create(ABuffer: Pointer; Size: Integer);
begin
  SetPointer(ABuffer, Size);
  inherited Create;
end;

function TWebRequestFileStream.Write(const Buffer;
  Count: Integer): Longint;
begin
  // Write not supported
  Assert(False);
  Result := 0;
end;

end.
