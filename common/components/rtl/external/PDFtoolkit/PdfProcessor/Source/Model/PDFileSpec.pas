{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDFileSpec;

interface

uses
  PDElement, PDBaseObject, Stream;

type

  TgtPDFileSystem = (fsNone, fsURL);

  TgtPDFileSpec = class(TgtPDElement)
  private
    FFileName: AnsiString;
    FIsVolatile: Boolean;
    FDescription: AnsiString;
    FIsEmbedded: Boolean;
    FEmbeddedStream: TgtStream;
    FEFObj: TgtPDBaseObject;
    FFileSystem: TgtPDFileSystem;

    function GetFileName: AnsiString;
    function GetIsVolatile: Boolean;
    function GetDescription: AnsiString;
    function GetIsEmbedded: Boolean;
    function GetEmbeddedFileStream: TgtStream;

    procedure SetFileName(Value: AnsiString);
    procedure SetIsVolatile(Value: Boolean);
    procedure SetDescription(Value: AnsiString);
    procedure SetIsEmbedded(Value: Boolean);
    function GetFileSystem: TgtPDFileSystem;
    procedure SetFileSystem(const Value: TgtPDFileSystem);
  public
    constructor Create(AFileSpecObj: TgtPDBaseObject); overload;
    constructor Create; overload;
    procedure Update; override;

    procedure SetEmbeddedFileStream(Value: TgtStream);

    property FileName: AnsiString read GetFileName write SetFileName;
    property IsVolatile: Boolean read GetIsVolatile write SetIsVolatile;
    property Description: AnsiString read GetDescription write SetDescription;
    property IsEmbedded: Boolean read GetIsEmbedded write SetIsEmbedded;
    property EmbeddedFileStream: TgtStream read GetEmbeddedFileStream;
    property FileSystem: TgtPDFileSystem read GetFileSystem write SetFileSystem;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtConstants, PDDictionary, PDBoolean, PDString, PDStream, PDName;

{ TgtPDFileSpec }

constructor TgtPDFileSpec.Create(AFileSpecObj: TgtPDBaseObject);
begin
  FBaseObject := AFileSpecObj;
  FParentDoc := nil;
  FParentElement := nil;
  FEmbeddedStream := nil;
  FDescription := '';
  FFileName := '';
  if Assigned(FBaseObject) then
    FEFObj := TgtPDDictionary(FBaseObject).LookUp(PDF_EF);
  FFileSystem := fsNone;
end;

constructor TgtPDFileSpec.Create;
begin
  FDescription := '';
  FFileName := '';
  FFileSystem := fsNone;
end;

function TgtPDFileSpec.GetDescription: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if FDescription = '' then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DESC);
      if Assigned(LObj) then
        FDescription := TgtPDString(LObj).Value;
    end;
  end;

  Result := FDescription;
end;

function TgtPDFileSpec.GetEmbeddedFileStream: TgtStream;
var
  LFObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FEmbeddedStream) then
    begin
      if Assigned(FEFObj) then
      begin
        LFObj := TgtPDDictionary(FEFObj).LookUp(PDF_F);
        if Assigned(LFObj) and LFObj.IsStream then
        begin
          FEmbeddedStream := TgtPDStream(LFObj).GetStream;
        end
        else
        begin
          Result := nil;
          {$IFDEF DEBUG}
          Logger.LogError('Stream Object expected for Embedded File Stream');
          {$ENDIF}
          Exit;
        end;
      end
      else
      begin
        Result := nil;
        {$IFDEF DEBUG}
        Logger.LogError('Stream Object expected for Embedded File Stream');
        {$ENDIF}
        Exit;
      end;
    end;
  end;

  Result := FEmbeddedStream;
end;

function TgtPDFileSpec.GetFileName: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) then
      FFileName := TgtPDString(LObj).Value;
  end;

  Result := FFileName;
end;

function TgtPDFileSpec.GetFileSystem: TgtPDFileSystem;
var
  LObj: TgtPDBaseObject;
  LFSys: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FS);
    if Assigned(LObj) and LObj.IsName then
    begin
      LFSys := TgtPDName(LObj).Value;
      if LFSys = PDF_URL then
        FFileSystem := fsURL;
    end;
  end;
  Result := FFileSystem;
end;

function TgtPDFileSpec.GetIsEmbedded: Boolean;
begin
  if Assigned(FBaseObject) then
  begin
    FIsEmbedded := Assigned(FEFObj);
  end;

  Result := FIsEmbedded;
end;

function TgtPDFileSpec.GetIsVolatile: Boolean;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_V);
    if Assigned(LObj) then
      FIsVolatile := TgtPDBoolean(LObj).Value;
  end;

  Result := FIsVolatile;
end;

procedure TgtPDFileSpec.SetDescription(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DESC);
    if Assigned(LObj) then
    begin
      TgtPDString(LObj).Value := Value;
    end
    else
    begin
      LObj := TgtPDString.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_DESC, LObj);
    end;
  end;

  FDescription := Value;
end;

procedure TgtPDFileSpec.SetEmbeddedFileStream(Value: TgtStream);
begin
  FEmbeddedStream := Value;
end;

procedure TgtPDFileSpec.SetFileName(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) then
    begin
      TgtPDString(LObj).Value := Value;
    end
    else
    begin
      LObj := TgtPDString.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_F, LObj);
    end;
  end;

  FFileName := Value;
end;

procedure TgtPDFileSpec.SetFileSystem(const Value: TgtPDFileSystem);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FS);
    if Assigned(LObj) and LObj.IsName then
    begin
      TgtPDName(LObj).Value := PDF_URL;
    end
    else
    begin
      LObj := TgtPDName.Create(PDF_URL);
      TgtPDDictionary(FBaseObject).Add(PDF_FS, LObj);
    end;
  end;
  FFileSystem := Value;
end;

procedure TgtPDFileSpec.SetIsEmbedded(Value: Boolean);
begin
  FIsEmbedded := Value;
end;

procedure TgtPDFileSpec.SetIsVolatile(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_V);
    if Assigned(LObj) then
    begin
      TgtPDBoolean(LObj).Value := Value;
    end
    else
    begin
      LObj := TgtPDBoolean.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_V, LObj);
    end;
  end;

  FIsVolatile := Value;
end;

procedure TgtPDFileSpec.Update;
begin
  inherited;

end;

end.
