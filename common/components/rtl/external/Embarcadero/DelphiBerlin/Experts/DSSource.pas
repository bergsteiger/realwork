{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSSource;

interface

uses Classes, SysUtils;
type

  TSourceIndex = (
                  stDSServerModuleTemplate,                           { DataModule Source }
                  stDSServerModuleTemplateIntf                           { DataModule Source }
                  );


  TSourceFlag = (sfDummyFlag);
  TSourceFlags = set of TSourceFlag;

function GetSourceFromTemplate(const APersonality: string; SourceIndex: TSourceIndex; Props: TStrings; Flags: TSourceFlags=[]): string;
function GetSourceFromTemplateFile(const FileName: string; Props: TStrings = nil; Flags: TSourceFlags=[]): string; forward;
function GetTemplateFileEncoding(const FileName: string): TEncoding; forward;

implementation

uses
  ExpertFilter, ToolsAPI;

const

  SourceTypeNames: array[TSourceIndex] of string = (
                  'DSServerModuleTemplate',
                  'DSServerModuleTemplateIntf'
                  );

function WebModFileName(const APersonality: string): string; forward;

function GetSourceFromTemplate(const APersonality: string; SourceIndex: TSourceIndex; Props: TStrings; Flags: TSourceFlags): string;
var
  S: TStrings;
begin
  S := TStringList.Create;
  try
    if Props <> nil then
      S.Assign(Props);
    S.Add(SourceTypeNames[SourceIndex] + '=TRUE'); // Do not localize;
    Result := GetSourceFromTemplateFile(WebModFileName(APersonality), S, Flags);
  finally
    S.Free;
  end;
end;

function ExtractStringValue(const S: string): string;
var
  P: Integer;
begin
  P := AnsiPos('=', S);
  if (P <> 0) and (Length(S) > P) then
    Result := Copy(S, P+1, MaxInt) else
    SetLength(Result, 0);
end;

function ExpandTemplateFileName(const FileName: string): string;
var
  TemplateDirectory: string;
begin
  if IsRelativePath(FileName) then
  begin
    TemplateDirectory := (BorlandIDEServices as IOTAServices).GetTemplateDirectory;
    if SameFileName(ExtractFileExt(FileName), '.cpp') or SameFileName(ExtractFileExt(FileName), '.h') then
      TemplateDirectory := TemplateDirectory + 'cpp\'; // Do not localize
    Result := TemplateDirectory + FileName;
  end
  else
    Result := FileName;

end;
function GetSourceFromTemplateFile(const FileName: string; Props: TStrings; Flags: TSourceFlags): string;
var
  Filter: IExpertFilter;
  I: Integer;
  TemplateFileName: string;
begin
  try
    Filter := CoExpertFilter.Create;
    if Props <> nil then
      for I := 0 to Props.Count - 1 do
        Filter.SetProperty(Props.Names[I], ExtractStringValue(Props[I]));
//    if sfRunDSServer in Flags then
//      Filter.SetProperty('RunDSServer', 'TRUE');
    TemplateFileName := ExpandTemplateFileName(FileName);
    Result := Filter.Filter(ExtractFileName(TemplateFileName), ExtractFilePath(TemplateFileName))
  except
    Result := '';
  end;
end;

function GetTemplateFileEncoding(const FileName: string): TEncoding;
var
  TemplateFileName: string;
begin
  Result := TEncoding.Default;
  try
//    TemplateDirectory := (BorlandIDEServices as IOTAServices).GetTemplateDirectory;
//    if SameFileName(ExtractFileExt(FileName), '.cpp') or SameFileName(ExtractFileExt(FileName), '.h') then
//      TemplateDirectory := TemplateDirectory + 'cpp\'; // Do not localize
//    TemplateFileName := GetLocaleFile(TemplateDirectory + FileName);
    TemplateFileName := GetLocaleFile(ExpandTemplateFileName(FileName));

    with TStreamReader.Create(TemplateFileName, TEncoding.Default, True) do
    try
      ReadLine;
      Result := CurrentEncoding;
    finally
      Free;
    end;
  except

  end;
end;


function WebModFileName(const APersonality: string): string;
begin
  if APersonality <> sCBuilderPersonality then
    Result := 'DataSnapModules.pas'
  else
    Result := 'DataSnapModules.cpp';
end;


end.
