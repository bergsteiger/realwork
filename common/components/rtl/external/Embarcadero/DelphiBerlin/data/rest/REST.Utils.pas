{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$HPPEMIT LINKUNIT}
unit REST.Utils;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Character;

type
  TRESTFindDefaultComponent = class
  public
    class function FindDefaultT<T: TComponent>(AComp: TComponent): T;
    class function FindDefaultIntfT<T: IInterface>(AComp: TComponent): T;
    class procedure FindAllT<T: TComponent>(AComp: TComponent; ACallback: TProc<T>); overload;
  end;


//This URIEncode variant implements an encoding as specified by OAuth mechanisms
function URIEncode(const S: string): string;
function iif(const ACondition: boolean; const BranchTRUE, BranchFALSE: string): string;

procedure ExtractURLSegmentNames(const AString: string; AList: TStrings);
procedure ExtractGetParams(const AUrl: string; var VParams: TStrings);

function RESTComponentIsDesigning(AComp: TComponent): boolean;

implementation

uses System.TypInfo;

const
  URL_UNRESERVED_CHARS = ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '_', '.', '~'];

var
  GURLUnreservedChars: array of Char;

procedure InitUnreservedChars;
var
  c: Char;
  i: integer;
begin
  SetLength(GURLUnreservedChars, 1024);
  i := 0;
  for c in URL_UNRESERVED_CHARS do
  begin
    inc(i);
    GURLUnreservedChars[i] := c;
  end;
  SetLength(GURLUnreservedChars, i);
end;

function URIEncode(const S: string): string;
var
  c: Char;
begin
  result := '';
  for c in S do
    if c.IsInArray(GURLUnreservedChars) then
      result := result + WideChar(c)
    else
      result := result + '%' + IntToHex(Ord(c), 2);
end;

function iif(const ACondition: boolean; const BranchTRUE, BranchFALSE: string): string;
begin
  if ACondition then
    result := BranchTRUE
  else
    result := BranchFALSE;
end;

function RESTComponentIsDesigning(AComp: TComponent): boolean;
begin
  result := ([csDesigning, csLoading] * AComp.ComponentState = [csDesigning]) and
    ((AComp.Owner = nil) or ([csDesigning, csLoading] * AComp.Owner.ComponentState = [csDesigning]));
end;

procedure ExtractURLSegmentNames(const AString: string; AList: TStrings);
var
  LIndex: integer;
  LResource: string;
  LName: string;
begin
  LResource := AString;
  LIndex := LResource.IndexOf('{');
  while (LIndex >= 0) do
  begin
    LResource := LResource.Substring(LIndex + 1);
    LIndex := LResource.IndexOf('}');
    if (LIndex >= 0) then
    begin
      LName := LResource.Substring(0, LIndex);
      if (LName <> '') and (AList.IndexOf(LName) < 0) then
        AList.Add(LName);
      LResource := LResource.Substring(LIndex + 1);
      LIndex := LResource.IndexOf('{');
    end;
  end;
end;

procedure ExtractGetParams(const AUrl: string; var VParams: TStrings);
var
  LTokenPos: integer;
  LURI: string;
  LParams: string;
begin
  LURI := AUrl;
  LParams := LURI;

  LTokenPos := Pos('://', LURI); { Do not Localize }
  if LTokenPos > 0 then
  begin
    // absolute URI
    // remove the protocol
    Delete(LURI, 1, LTokenPos + 2);
    // separate the path from the parameters
    LTokenPos := Pos('?', LURI); { Do not Localize }
    if LTokenPos > 0 then
    begin
      LParams := Copy(LURI, LTokenPos + 1, MaxInt);
      // separate the bookmark from the parameters
      LTokenPos := Pos('#', LParams); { Do not Localize }
      if LTokenPos > 0 then
      begin
        LParams := Copy(LParams, 1, LTokenPos - 1);
      end;
    end;

  end
  else
  begin
    // received an absolute path, not an URI
    LTokenPos := Pos('?', LURI); { Do not Localize }
    if LTokenPos > 0 then
    begin // The case when there is parameters after the document name
      LParams := Copy(LURI, LTokenPos + 1, MaxInt);
      // separate the bookmark from the parameters
      LTokenPos := Pos('#', LParams); { Do not Localize }
      if LTokenPos > 0 then
      begin
        LParams := Copy(LParams, 1, LTokenPos - 1);
      end;
    end
    else
    begin
      // separate the bookmark from the path
      LTokenPos := Pos('#', LURI); { Do not Localize }
      if LTokenPos > 0 then
      begin // The case when there is a bookmark after the document name
        LParams := Copy(LURI, 1, LTokenPos - 1);
      end;
    end;
  end;

  VParams:= TStringList.Create;
  VParams.NameValueSeparator := '=';
  VParams.Text := LParams;
end;


class function TRESTFindDefaultComponent.FindDefaultT<T>(AComp: TComponent): T;
var
  I: Integer;
  LRoot: TComponent;
begin
  Result := nil;
  LRoot := AComp;
  if (LRoot <> nil) and (LRoot.Owner <> nil) then
    LRoot := LRoot.Owner;
  if LRoot <> nil then
    for I := 0 to LRoot.ComponentCount - 1 do
      if LRoot.Components[I] is T then
        if not Assigned(Result) then
          Result := T(LRoot.Components[I])
        else
          Exit(nil);
end;

class function TRESTFindDefaultComponent.FindDefaultIntfT<T>(AComp: TComponent): T;
var
  I: Integer;
  LRoot: TComponent;
  LGuid: TGuid;
  LIntf: T;
begin
  LGuid := GetTypeData(TypeInfo(T)).Guid;
  Result := nil;
  LRoot := AComp;
  if (LRoot <> nil) and (LRoot.Owner <> nil) then
    LRoot := LRoot.Owner;
  if LRoot <> nil then
    for I := 0 to LRoot.ComponentCount - 1 do
      if Supports(LRoot.Components[I], LGuid, LIntf) then
        if not Assigned(Result) then
          Result := LIntf
        else
          Exit(nil);
end;

class procedure TRESTFindDefaultComponent.FindAllT<T>(AComp: TComponent; ACallback: TProc<T>);
var
  I: Integer;
  LRoot: TComponent;
begin
  LRoot := AComp;
  if (LRoot <> nil) and (LRoot.Owner <> nil) then
    LRoot := LRoot.Owner;
  if LRoot <> nil then
    for I := 0 to LRoot.ComponentCount - 1 do
      if LRoot.Components[I] is T then
        ACallback(T(LRoot.Components[I]));
end;

initialization

InitUnreservedChars;

end.
