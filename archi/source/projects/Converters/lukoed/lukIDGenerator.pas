unit lukIDGenerator;
{ Генератор номеров документов для документов ЛУКойла }


interface

uses
 l3Base, l3ValLst;

type
 TlukGetSelfID = procedure (out NewID: Integer) of Object;
 TlukGetLinkID = procedure (const aFileName: String; out NewID: Integer) of Object;
 TlukIDGenerator = class(Tl3Base)
 private
  f_CurDocID: Integer;
  f_Files: Tl3ValueList;
  f_NextDocID: Integer;
  f_SegmentID: Integer;
  function ConvertFileNameToID(const aFileName: String): Integer;
  function GetFileName(const aFileName: String): string;
  function pm_GetNextDocID: Integer;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure AddFileName(const aFileName: String);
  procedure GetLinkID(const aFileName: String; out NewID: Integer);
  function GetRelID: Integer;
  procedure GetSelfID(out NewID: Integer);
  property NextDocID: Integer read pm_GetNextDocID write f_NextDocID;
  property SegmentID: Integer read f_SegmentID write f_SegmentID;
 end;

implementation

uses SysUtils, StrUtils;

constructor TlukIDGenerator.Create;
begin
 inherited Create;
 f_Files := Tl3ValueList.Create();
end;

procedure TlukIDGenerator.Cleanup;
begin
 FreeAndNil(f_Files);
 inherited Cleanup;
end;

procedure TlukIDGenerator.AddFileName(const aFileName: String);
// сюда приходит полный путь
var
 l_FileName: String;
begin
 l_FileName:= Format('\%d\%s', [f_SegmentID, ChangeFileExt(ExtractFileName(aFileName), '.sdf')]);
 f_CurDocID:= ConvertFileNameToID(l_FileName);
end;

function TlukIDGenerator.ConvertFileNameToID(const aFileName: String): Integer;
begin
 Result:= StrToIntDef(f_Files.Values[AnsiUpperCase(aFileName)], 0);
 if Result = 0 then
 begin
  Result:= NextDocID;
  f_Files.Values[AnsiUpperCase(aFileName)]:= IntToStr(Result);
 end;
end;

function TlukIDGenerator.GetFileName(const aFileName: String): string;
begin
 Result := ChangeFileExt(ExtractFileName(aFileName), '.sdf');
end;

procedure TlukIDGenerator.GetLinkID(const aFileName: String; out NewID: Integer);
// Сюда приходит "огрызок" - /segment/file
var
 l_FileName: String;
begin
 l_FileName:= AnsiReplaceStr(aFileName , '/', '\');
 if ExtractFileExt(l_FileName) = '' then
  l_FileName:= ChangeFileExt(l_FileName, '.sdf');
 NewID:= ConvertFileNameToID(l_FileName);
end;

function TlukIDGenerator.GetRelID: Integer;
begin
 Result := NextDocID;
end;

procedure TlukIDGenerator.GetSelfID(out NewID: Integer);
begin
 NewID:= f_CurDocID;
end;

function TlukIDGenerator.pm_GetNextDocID: Integer;
begin
 Result := f_NextDocID;
 Inc(f_NextDocID);
end;


end.
