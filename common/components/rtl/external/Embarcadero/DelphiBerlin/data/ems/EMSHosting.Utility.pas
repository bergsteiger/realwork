{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.Utility;

interface

uses
  System.Classes;

function ParseURLPath(const AURL: string): TStrings;

implementation

uses
  System.SysUtils;

function ParseURLPath(const AURL: string): TStrings;
const
  REQUEST_DELIMITER = '/';
var
  LIndex, LSlashPos: Integer;
  LMoreSegments: Boolean;
  LSegment: string;
begin
  LIndex := 0;
  Result := TStringList.Create;
  LSlashPos := AURL.IndexOf(REQUEST_DELIMITER);
  LMoreSegments := LSlashPos >= 0;
  if not LMoreSegments and (AURL <> '') then
    Result.Add(AURL);
  while LMoreSegments do
  begin
    LSegment := AURL.SubString(LIndex, LSlashPos-LIndex+1);
    Result.Add(LSegment);
    LIndex := LSlashPos+1;
    LMoreSegments := LIndex < AURL.Length;
    if LMoreSegments then
    begin
      LSlashPos := AURL.IndexOf(REQUEST_DELIMITER, LIndex);
      if LSlashPos < 0 then
        LSlashPos := AURL.Length - 1;
    end;
  end;
end;

end.
