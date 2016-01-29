unit ddArbitralCourtReader;

interface

Uses
 k2Reader,
 ddLawCaseXMLReader,
 dt_Types, classes, k2TagGen, ddTypes;

type
 TLiteArbitralCourtReader = class(Tk2CustomFileReader)
 private
  f_Dictionary: TStrings;
  f_DictionaryFileName: AnsiString;
  f_FromGZ: Boolean;
  f_ImageFolder: AnsiString;
  f_OldFormat: Boolean;
  f_OnError: TddErrorEvent;
  f_OnEmptyDocument: TNotifyEvent;
  f_OnNewDocument: TlcNewDocumentEvent;
  f_QuarantineFolder: AnsiString;
  f_SaveImage: Boolean;
  f_SourceFileName: AnsiString;
  f_Sources: TStrings;
  procedure CheckStreamCoding(var aStream: TStream);
  procedure ExtractStream(var aStream: TStream);
  procedure pm_SetDictionaryFileName(const Value: AnsiString);
  procedure pm_SetSourceFileName(const aValue: AnsiString);
 protected
  procedure cleanup; override;
  procedure Read; override;
 public
  constructor Create;
  property DictionaryFileName: AnsiString read f_DictionaryFileName write pm_SetDictionaryFileName;
  property FromGZ: Boolean read f_FromGZ write f_FromGZ;
  property ImageFolder: AnsiString read f_ImageFolder write f_ImageFolder;
  property OldFormat: Boolean read f_OldFormat write f_OldFormat;
  property QuarantineFolder: AnsiString read f_QuarantineFolder write f_QuarantineFolder;
  property SaveImage: Boolean read f_SaveImage write f_SaveImage;
  property SourceFileName: AnsiString read f_SourceFileName write pm_SetSourceFileName;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
  property OnNewDocument: TlcNewDocumentEvent
   read f_OnNewDocument
   write f_OnNewDocument;
  property OnEmptyDocument: TNotifyEvent read f_OnEmptyDocument write
      f_OnEmptyDocument;
 end;

implementation
Uses
 l3GZipStream, l3Filer,
 l3Base, l3TempMemoryStream, evNestedDocumentEliminator, SysUtils, l3FileUtils,
 ddLawCaseNameGenerator, ddSpaceTrimmer,
 dd_lcTextFormatter, TextPara_Const, dd_lcXMLReader, l3baseStream, l3Stream, JclBase,
 JclStringConversions, JclCompression, Forms, jclStreams;

constructor TLiteArbitralCourtReader.Create;
begin
 inherited Create;
 f_Dictionary := TStringList.Create;
end;

procedure TLiteArbitralCourtReader.CheckStreamCoding(var aStream: TStream);
var
 l_Stream, l_Stream2, l_Stream3: TStream;
 l_Word: Word;
 l_UTFChar: UCS4;
 l_Char: AnsiChar;
 Buffer: AnsiString;
 CharCount: Longint;
begin
 aStream.Seek(0, soFromBeginning);
 aStream.Read(l_Word, SizeOf(l_Word));
 if Hi(l_Word) = 0 then
 begin
  l3System.Msg2Log('Перекодирование потока UTF16->Ansi');
  aStream.Seek(0, soFromBeginning);
  l_Stream2:= TJclUTF16Stream.Create(AStream, False);
  try
   l_Stream3:= Tl3TempMemoryStream.Create;
   try
    SetLength(Buffer, 32*1024);
    repeat
      CharCount := TjclStringStream(l_Stream2).ReadString(Buffer, 1, 32*1024);
      CharCount := l_Stream3.Write(Buffer[1], CharCount);
    until CharCount = 0;
    FreeAndNil(aStream);
    aStream:= Tl3TempMemoryStream.Create;
    l_Stream3.Seek(0, soFromBeginning);
    aStream.CopyFrom(l_Stream3, l_Stream3.Size);
   finally
    FreeAndNil(l_Stream3);
   end;
  finally
   FreeAndNil(l_Stream2);
  end;
  l3System.Msg2Log('Перекодирование завершено');
 end; // Hi(l_Word) = 0
 aStream.Seek(0, soFromBeginning);
end;

procedure TLiteArbitralCourtReader.cleanup;
begin
 inherited;
 FreeAndNil(f_Sources);
 FreeAndNil(f_Dictionary);
end;

procedure TLiteArbitralCourtReader.ExtractStream(var aStream: TStream);
var
 l_S: Tl3FilerStream;
 l_In: Tl3Stream;
begin
 l_S:= Tl3FilerStream.Create(Filer);
 try
  if FromGZ then
  begin
   l_In:= Tl3GZipStream.Create(l_S);
   try
    aStream.CopyFrom(l_In, l_In.Size);
   finally
    FreeAndNil(l_In);
   end;
  end
  else
   aStream.CopyFrom(l_S, l_S.Size);
  aStream.Seek(0, soFromBeginning);
 finally
  FreeAndNil(l_S);
 end;
end;

procedure TLiteArbitralCourtReader.pm_SetDictionaryFileName(const Value: AnsiString);
begin
 f_DictionaryFileName := Value;
 if f_Dictionary = nil then
 begin
  f_Dictionary:= TStringList.Create;
  f_Dictionary.NameValueSeparator:= '=';
 end;
 if FileExists(f_DictionaryFileName) then
  f_Dictionary.LoadFromFile(f_DictionaryFileName);
end;

procedure TLiteArbitralCourtReader.pm_SetSourceFileName(const aValue: AnsiString);
begin
 f_SourceFileName := aValue;
 if f_Sources = nil then
 begin
  f_Sources:= TStringList.Create;
  f_Sources.NameValueSeparator:= ';';
 end;
 if FileExists(f_SourceFileName) then
  f_Sources.LoadFromFile(f_SourceFileName);
end;

procedure TLiteArbitralCourtReader.Read;
var
 l_S : Tl3FilerStream;
 l_In: TStream;
 l_Mem: TStream;
 l_Filer: Tl3CustomFiler;
 l_Lawcase: TLawCaseXMLReader;
 l_Eliminator: TevNestedDocumentEliminator;
 l_XML: TlcXMLReader;
begin
 l_S := Tl3FilerStream.Create(Filer);
 try
 l_Mem:= Tl3TempMemoryStream.Create;
 try
  try
    if FromGZ then
     //l_In:= Tl3GZipStream.Create(l_S)
    begin
     l_In:= TJclGZIPDecompressionStream.Create(l_S);
     try
      TJclGZIPDecompressionStream(l_IN).SaveToStream(l_MEM);
     finally
      FreeAndNil(l_IN);
     end;
    end
    else
    begin
     l_In:= Tl3FilerStream.Create(Filer);
     try
      l_Mem.CopyFrom(l_In, l_In.Size);
     finally
      FreeAndNil(l_In);
     end;
    end;
    CheckStreamCoding(l_MEM);
    l_Mem.Seek(0, soFromBeginning);

   l_Filer:= Tl3CustomFiler.Create;
   try
    l_Filer.Stream:= l_Mem;
    begin
     l_XML:= TlcXMLReader.Create;
     try
      l_Eliminator:= TevNestedDocumentEliminator.Create;
      try
       l_XML.Generator:= l_Eliminator;
       l_Eliminator.Generator:= Generator;
       l_XML.Filer:= l_Filer;
       l_XML.Dictionary:= f_Dictionary;
       l_XML.SetReaderParams(f_Sources, ImageFolder, f_OnError, SaveImage);
       if Filer is Tl3DOSFiler then
        l_XML.FileName:= Tl3DOSFiler(Filer).FileName;
       l_XML.Execute;
      finally
       l3Free(l_Eliminator);
      end;
     finally
      FreeAndNil(l_XML);
     end;
    end;
   finally
    l3Free(l_Filer);
   end;
  except
   on E: Exception do
   begin
    l3System.Msg2Log(E.Message);
    if Assigned(f_OnEmptyDocument) then
     f_OnEmptyDocument(Self);
   end;
  end;
 finally
  l3Free(l_Mem);
 end;
 finally
  l3Free(l_S);
 end;//try..finally
end;

end.
