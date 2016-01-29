program xmldocid;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,

  l3Types,
  l3Interfaces,
  l3ProtoObject,
  l3Filer,
  l3String,

  ddXMLParser;

type
 TDocIDExtractor = class(Tl3ProtoObject)
 private
  f_Filename: string;
  f_OutFiler: Tl3DOSFiler;
  f_Parser: TddXMLParser;
  procedure DoOnStartTag(const aStr: Il3CString);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aFileName: string);
  procedure Run;
 end;

constructor TDocIDExtractor.Create(const aFileName: string);
begin
 inherited Create;
 f_Parser := TddXMLParser.Create;
 f_Parser.NeedAttributes := True;
 f_Parser.OnStartTag := DoOnStartTag;
 f_Filename := aFileName;
end;

procedure TDocIDExtractor.Cleanup;
begin
 inherited;
 FreeAndNil(f_Parser);
end;

procedure TDocIDExtractor.DoOnStartTag(const aStr: Il3CString);
var
 l_Str: Il3CString;
begin
 l_Str := f_Parser.Attributes['garant'];
 if not l3IsNil(l_Str) then
  f_OutFiler.WriteLn(l_Str.AsWStr);
end;

procedure TDocIDExtractor.Run;
var
 l_InStream: TFileStream;
begin
 if FileExists(f_Filename) then
 begin
  l_InStream := TFileStream.Create(f_Filename, fmOpenRead);
  try
   f_OutFiler := Tl3DOSFiler.Make(ChangeFileExt(f_Filename, '.docid.txt'), l3_fmWrite);
   try
    f_OutFiler.Open;
    f_Parser.ParseStream(l_InStream);
   finally
    FreeAndNil(f_OutFiler);
   end;
  finally
   FreeAndNil(l_InStream);
  end;
 end
 else
  Writeln(Format('ERROR: file %s not found!', [f_Filename]));
end;

var
 l_Extractor: TDocIDExtractor;

begin
 if ParamCount > 0 then
 begin
  l_Extractor := TDocIDExtractor.Create(ParamStr(1));
  try
   l_Extractor.Run;
  finally
   FreeAndNil(l_Extractor);
  end;
 end
 else
  Writeln('USAGE: xmldocid <xml file name>');
end.
