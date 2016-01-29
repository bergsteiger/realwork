{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDCMap;

interface

uses
  Windows, Classes, gtObject, PDFont, gtTypes, PDCMapParser;

type

  TgtPDCMap = class
  private
    FcMapName: AnsiString;
    FCollection: AnsiString;
    FWMode: TgtWritingMode;
    FCMapStream: TStream;
    FUCSStream: TStream;
    FCMapParser: TgtPDCMapParser;
    FUCSParser: TgtPDCMapParser;
    constructor Create(const CMapFile: AnsiString; const aCollection: AnsiString;
      const acMapName: AnsiString);
  public
    class function MakeCMap(const aCollection, acMapName: AnsiString; acMapPath: AnsiString = ''): TgtPDCMap;

    destructor Destroy; override;

    function GetCID(const Str: WideString; Index: Integer; var Processed: Integer;
      IsEmbeded: Boolean): TgtCID;

    property Collection: AnsiString read FCollection;
    property cMapName: AnsiString read FcMapName;
    property WMode: TgtWritingMode read FWMode;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  SysUtils, gtMethods;

{ TgtPDCMap }

constructor TgtPDCMap.Create(const CMapFile, aCollection, acMapName: AnsiString);
var
  LUCSFilePath: AnsiString;
begin
  FCollection := aCollection;
  FcMapName := acMapName;

  if not (acMapName = 'Identity') and not (acMapName = 'Identity-H') and
    not (acMapName = 'Identity-V') then
  begin
    FCMapStream := TFileStream.Create(CMapFile, fmOpenRead + fmShareDenyNone);
    FCMapParser := TgtPDCMapParser.Create(FCMapStream);
    FWMode := TgtWritingMode(FCMapParser.WMode);

    LUCSFilePath := ExtractFilePath(CMapFile);
    LUCSFilePath := LUCSFilePath + FCMapParser.Registry + '-' +
      FCMapParser.Ordering + '-UCS2';

    if FileExists(LUCSFilePath) then
    begin
      FUCSStream := TFileStream.Create(LUCSFilePath, fmOpenRead + fmShareDenyNone);
      FUCSParser := TgtPDCMapParser.Create(FUCSStream);
    end;
  end
  else if aCollection <> '' then
  begin
    if FileExists(ExtractFilePath(CMapFile) + '\' + aCollection) then
    begin
      FUCSStream := TFileStream.Create(ExtractFilePath(CMapFile) + '\' +
        aCollection, fmOpenRead + fmShareDenyNone);
      FUCSParser := TgtPDCMapParser.Create(FUCSStream);
    end;
  end;
end;

class function TgtPDCMap.MakeCMap(const aCollection, acMapName: AnsiString;
  acMapPath: AnsiString): TgtPDCMap;

var
  CMapPath: AnsiString;
  {$IFDEF DLLPROJECT}
  LDLLPath: AnsiString;
  {$ENDIF}
begin
{$IFDEF DLLPROJECT}
  LDLLPath := GetModuleName(GetModuleHandle('gtpdf32.dll'));
  LDLLPath := ExtractFileDir(LDLLPath);
  CMapPath := LDLLPath + '\CMaps\' + acMapName;
{$ELSE}
  CMapPath := acMapPath + '\' + acMapName;
{$ENDIF}
  if not FileExists(CMapPath) or (acMapName = 'Identity-H') or
    (acMapName = 'Identity-V') or (acMapName = 'Identity') then
  begin
    if (acMapName = 'Identity') or (acMapName = 'Identity-H') then
    begin
      Result := TgtPDCMap.Create(CMapPath, aCollection, acMapName);
      Result.FWMode := wmHorizontal;
    end
    else if acMapName = 'Identity-V' then
    begin
      Result := TgtPDCMap.Create(CMapPath, aCollection, acMapName);
      Result.FWMode := wmVertical;
    end
    else
    begin
{$IFDEF DEBUG}
      Logger.LogError('Couldn''t find %s CMap file for %s collection',
        [acMapName, aCollection]);
{$ENDIF}
      Result := nil;
    end;
    Exit;
  end;

  Result := TgtPDCMap.Create(CMapPath, aCollection, acMapName);
end;

destructor TgtPDCMap.Destroy;
begin
  if Assigned(FCMapStream) then FCMapStream.Free;
  if Assigned(FUCSStream) then FUCSStream.Free;
  if Assigned(FCMapParser) then FCMapParser.Free;
  if Assigned(FUCSParser) then FUCSParser.Free;
  inherited;
end;

function TgtPDCMap.GetCID(const Str: WideString; Index: Integer;
  var Processed: Integer; IsEmbeded: Boolean): TgtCID;
begin
  if not Assigned(FCMapParser) then //Identity CMap
  begin
    Processed := 2;
    if (Length(Str) - (Index - 1)) < 2 then
    begin
      Result := Ord(Str[Index]);
      if not IsEmbeded and Assigned(FUCSParser) then
        Result := FUCSParser.Code[Result];
      Exit;
    end;
    Result := ((Ord(Str[Index]) and $FF) shl 8) + (Ord(Str[Index + 1]) and $FF);
    if (not IsEmbeded) and Assigned(FUCSParser) then
      Result := FUCSParser.Code[Result];
  end
  else
  begin
    Processed := 2;
    if (Length(Str) - (Index - 1)) < 2 then
    begin
      Result := Ord(Str[Index]);
      Result := FCMapParser.CID[Result];
      if not IsEmbeded then
        Result := FUCSParser.Code[Result];
      Exit;
    end;
    Result := ((Ord(Str[Index]) and $FF) shl 8) + (Ord(Str[Index + 1]) and $FF);
    Result := FCMapParser.CID[Result];

    if not IsEmbeded then
      Result := FUCSParser.Code[Result];
  end;
end;

end.
