unit ddTiffProcessor;

{ $Id: ddTiffProcessor.pas,v 1.2 2014/08/01 11:15:13 fireton Exp $ }

interface
uses
 Classes,
 l3Interfaces,
 l3BaseStream,
 l3ProtoObject,
 l3DataPtrList,
 l3Except;

type
 TddTIFFHeader = packed record
  rOrder    : Word;
  rID       : Word;
  rFirstIFD : LongWord;
 end;

 PddTIFFTag = ^TddTIFFTag;
 TddTIFFTag = packed record
  rTag   : Word;
  rType  : Word;
  rCount : LongWord;
  rValue : LongWord;
 end;

 PddTagArray = ^TddTagArray;
 TddTagArray = array[0..MaxInt div 16] of TddTIFFTag;

 PddIFD = ^TddIFD;
 TddIFD = packed record
  rTagCount: Word;
  rTags    : PddTagArray;
  rNextIFD : LongWord;
 end;
 

type
 TddTiffProcessor = class(Tl3ProtoObject)
 private
  f_Header: TddTIFFHeader;
  f_IFDList: Tl3DataPtrList;
  f_IsLittleEndian: Boolean;
  f_Stream: Tl3Stream;
  f_StreamBase: Int64;
  procedure FreeIFD(aIFD: PddIFD);
  function CloneIFD(const aIFD: PddIFD): PddIFD;
  function FindTag(aIFD: PddIFD; aTagID: Word): PddTIFFTag;
  procedure ReadHeader;
  function N(const aWord: Word): Word; overload;
  function N(const aLongWord: LongWord): LongWord; overload;
  function pm_GetPageCount: Integer;
  procedure PutIFDDataToStream(aIFD: PddIFD; const aOutStream: TStream; aBasePos: Int64);
  procedure PutIFDToStream(aIFD: PddIFD; const aOutStream: TStream; aBasePos: Int64; var theNextIFDLinkPos: LongWord);
  procedure ReadFileDirectories;
  function ReadIFD: PddIFD;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aStream: Tl3Stream); overload;
  constructor Create(aFileName: AnsiString); overload;
  procedure ExtractPages(const aOutStream: TStream; aPages: array of Integer); overload;
  procedure ExtractPages(const aOutFileName: AnsiString; aPages: array of Integer); overload;
  procedure ExtractPages(const aOutFileName: AnsiString; aRM: Il3RangeManager); overload;
  property PageCount: Integer read pm_GetPageCount;
 end;

type
 EddTIFFError = class(El3Error);

function EnumPagesInTIFF(aStream: TStream): Integer; overload;
function EnumPagesInTIFF(aFileName: AnsiString): Integer; overload;

implementation
uses
 SysUtils,
 l3Types,
 l3Base,
 l3Stream;

const
 cs_InvalidTIFF   = 'Невалидный файл TIFF';
 cs_CorruptedTIFF = 'Файл TIFF испорчен';

const                            //    1  2  3  4  5  6  7  8  9 10 11 12
 cDataSize: array[1..12] of Integer = (1, 1, 2, 4, 8, 1, 1, 2, 4, 8, 4, 8); // длины разных типов данных в тегах

const
 ttStripOffsets    = 273;
 ttStripByteCounts = 279;
 ttTileOffsets     = 324;
 ttTileByteCounts  = 325;

const
 dtSHORT = 3;
 dtLONG  = 4;

type
 PLongWordArray = ^TLongWordArray;
 TLongWordArray = array[0..MaxInt div 16] of LongWord;


function SwapWord(aWord: Word):Word; assembler;
asm
	ror ax,8
end;

function SwapDWord(aDWord:LongWord):LongWord;
begin
	asm
 	mov EAX, aDWord
 	bswap EAX
  mov @result,EAX
 end;
end;

function _NW(const aWord: Word; aSwap: Boolean): Word;
begin
 if aSwap then
  Result := SwapWord(aWord)
 else
  Result := aWord;
end;

function _NLW(const aLongWord: LongWord; aSwap: Boolean): LongWord;
begin
 if aSwap then
  Result := SwapDWord(aLongWord)
 else
  Result := aLongWord;
end;

constructor TddTiffProcessor.Create(aStream: Tl3Stream);
begin
 inherited Create;
 f_IFDList := Tl3DataPtrList.Make;
 f_Stream := aStream.Use;
 f_StreamBase := aStream.Position;
 ReadHeader;
 ReadFileDirectories;
end;

constructor TddTiffProcessor.Create(aFileName: AnsiString);
var
 l_FS: Tl3FileStream;
begin
 l_FS := Tl3FileStream.Create(aFileName, l3_fmRead);
 try
  Create(l_FS);
 finally
  FreeAndNil(l_FS);
 end;
end;

procedure TddTiffProcessor.Cleanup;
var
 I: Integer;
begin
 for I := 0 to Pred(f_IFDList.Count) do
  FreeIFD(f_IFDList[I]);
 FreeAndNil(f_IFDList);
 FreeAndNil(f_Stream);
 inherited;
end;

function TddTiffProcessor.CloneIFD(const aIFD: PddIFD): PddIFD;
var
 l_Size: LongWord;
begin
 l3System.GetLocalMem(Result, SizeOf(TddIFD));
 l3FillChar(Result^, SizeOf(TddIFD));
 Result^.rTagCount := aIFD^.rTagCount;
 l_Size := N(aIFD^.rTagCount) * SizeOf(TddTIFFTag);
 l3System.GetLocalMem(Result^.rTags, l_Size);
 l3Move(aIFD^.rTags^, Result^.rTags^, l_Size);
 Result^.rNextIFD := aIFD^.rNextIFD;
end;

procedure TddTiffProcessor.ExtractPages(const aOutStream: TStream; aPages: array of Integer);
var
 I: Integer;
 l_NextIFDLinkPos: LongWord;
 l_OBase: Int64;
 l_WIFD: PddIFD;
const
 cZero: LongWord = 0;
begin
 l_OBase := aOutStream.Position;
 aOutStream.Write(f_Header, SizeOf(TddTIFFHeader));
 l_NextIFDLinkPos := SizeOf(TddTIFFHeader) - 4;
 for I := 0 to High(aPages) do
 begin
  l_WIFD := CloneIFD(f_IFDList[aPages[I]]);
  try
   PutIFDDataToStream(l_WIFD, aOutStream, l_OBase);
   PutIFDToStream(l_WIFD, aOutStream, l_OBase, l_NextIFDLinkPos);
  finally
   FreeIFD(l_WIFD);
  end;
 end;
 // теперь надо записать 4 нуля - обязательных после последнего IFD
 aOutStream.Write(cZero, 4);
end;

procedure TddTiffProcessor.ExtractPages(const aOutFileName: AnsiString; aPages: array of Integer);
var
 l_FS: Tl3FileStream;
begin
 l_FS := Tl3FileStream.Create(aOutFileName, l3_fmWrite);
 try
  ExtractPages(l_FS, aPages);
 finally
  FreeAndNil(l_FS);
 end;
end;

procedure TddTiffProcessor.ExtractPages(const aOutFileName: AnsiString; aRM: Il3RangeManager);
var
 l_Arr: array of Integer;
 I: Integer;
begin
 SetLength(l_Arr, aRM.Count);
 for I := 1 to aRM.Count do
  l_Arr[I-1] := aRM.Pages[I] - 1; // в TIFF страницы нумеруются с 0
 ExtractPages(aOutFileName, l_Arr); 
end;

function TddTiffProcessor.FindTag(aIFD: PddIFD; aTagID: Word): PddTIFFTag;
var
 I: Integer;
 l_MaxN: Integer;
begin
 Result := nil;
 l_MaxN := N(aIFD^.rTagCount) - 1;
 for I := 0 to l_MaxN do
  if N(aIFD^.rTags^[I].rTag) = aTagID then
  begin
   Result := @(aIFD^.rTags^[I]);
   Break;
  end;
end;

procedure TddTiffProcessor.FreeIFD(aIFD: PddIFD);
begin
 if aIFD^.rTags <> nil then
  l3System.FreeLocalMem(aIFD^.rTags);
 l3System.FreeLocalMem(aIFD);
end;

function TddTiffProcessor.N(const aWord: Word): Word;
begin
 Result := _NW(aWord, not f_IsLittleEndian);
end;

function TddTiffProcessor.N(const aLongWord: LongWord): LongWord;
begin
 Result := _NLW(aLongWord, not f_IsLittleEndian);
end;

function TddTiffProcessor.pm_GetPageCount: Integer;
begin
 Result := f_IFDList.Count;
end;

procedure TddTiffProcessor.PutIFDDataToStream(aIFD: PddIFD; const aOutStream: TStream; aBasePos: Int64);
var
 I: Integer;
 l_Count: Integer;
 l_DataPos: LongWord;
 l_DSize: LongWord;
 l_Type: Word;
 l_DLen: Word;
 l_Buf: Pointer;
 l_Chunk: LongWord;
 l_PicOffsets: Pointer;
 l_PicOffsetsLen: LongWord;
 l_IDataTag: Word;
 l_Tag: Word;
const
 cBufSize = 1024 * 100; // 100 кб

 function ReadTagData(const aTag: PddTIFFTag; var theDataType: Word; var theLen: Longword): Pointer;
 begin
  theDataType := N(aTag^.rType);
  theLen      := N(aTag^.rCount) * cDataSize[theDataType];
  l3System.GetLocalMem(Result, theLen);
  if theLen > 4 then
  begin
   f_Stream.Seek(f_StreamBase + N(aTag^.rValue), soFromBeginning);
   f_Stream.Read(Result^, theLen);
  end
  else
   l3Move(aTag^.rValue, Result^, theLen);
 end;

 procedure CopyImageData;
 var
  I: Integer;
  l_DataLenTag: PddTIFFTag;
  l_DataTag: PddTIFFTag;
  l_DataType: Word;
  l_PicLens: Pointer;
  l_DataLenType: Word;
  l_TmpLW: LongWord;
  l_TmpW: LongWord;
  l_NumOfChunks: Integer;
  l_Pos: Longword;
  l_Len: LongWord;
  l_CLen: LongWord;
 begin
  // ищем в исходном файле данные изображения и копируем их в целевой файл, попутно готовя файлы для тега
  // данных изображения
  l_DataTag := FindTag(aIFD, ttStripOffsets);
  if l_DataTag = nil then
   l_DataTag := FindTag(aIFD, ttTileOffsets);
  if l_DataTag = nil then
   raise EddTIFFError.Create(cs_CorruptedTIFF);
  l_IDataTag := N(l_DataTag^.rTag);
  if l_IDataTag = ttStripOffsets then
   l_DataLenTag := FindTag(aIFD, ttStripByteCounts)
  else
   l_DataLenTag := FindTag(aIFD, ttTileByteCounts);
  if l_DataLenTag = nil then
   raise EddTIFFError.Create(cs_CorruptedTIFF);
  l_PicOffsets := ReadTagData(l_DataTag, l_DataType, l_PicOffsetsLen);
  l_PicLens    := ReadTagData(l_DataLenTag, l_DataLenType, l_TmpLW);
  try
   l_NumOfChunks := l_PicOffsetsLen div cDataSize[l_DataType];
   for I := 0 to l_NumOfChunks-1 do
   begin
    if l_DataType = dtSHORT then
     l_Pos := N(PWordArray(l_PicOffsets)^[I])
    else
     l_Pos := N(PLongWordArray(l_PicOffsets)^[I]);
    if l_DataLenType = dtSHORT then
     l_Len := N(PWordArray(l_PicLens)^[I])
    else
     l_Len := N(PLongWordArray(l_PicLens)^[I]);
    // запоминаем позицию в новом файле как позицию куска данных для тега
    if l_DataType = dtSHORT then
    begin
     l_TmpW := aOutStream.Position - aBasePos;
     PWordArray(l_PicOffsets)^[I] := N(l_TmpW)
    end
    else
    begin
     l_TmpLW := aOutStream.Position - aBasePos;
     PLongWordArray(l_PicOffsets)^[I] := N(l_TmpLW);
    end;
    f_Stream.Seek(f_StreamBase + l_Pos, soFromBeginning);
    while l_Len > 0 do
    begin
     if l_Len > cBufSize then
      l_CLen := cBufSize
     else
      l_CLen := l_Len;
     f_Stream.Read(l_Buf^, l_CLen);
     aOutStream.Write(l_Buf^, l_CLen);
     l_Len := l_Len - l_CLen;  
    end;
   end;
  finally
   l3System.FreeLocalMem(l_PicLens);
  end;
 end;

begin
 l_Count := N(aIFD^.rTagCount);
 l3System.GetLocalMem(l_Buf, cBufSize);
 try
  CopyImageData;
  try
   for I := 0 to Pred(l_Count) do
   begin
    l_Tag := N(aIFD^.rTags^[I].rTag);
    if l_Tag = l_IDataTag then // это тег со смещениями данных в файле, с ним надо обращаться особо
    begin
     if l_PicOffsetsLen > 4 then
     begin
      l_DataPos := aOutStream.Position - aBasePos; // запоминаем позицию данных в целевом файле, чтобы потом записать в тег
      aOutStream.Write(l_PicOffsets^, l_PicOffsetsLen);
      aIFD^.rTags^[I].rValue := N(l_DataPos); // записываем позицию данных в новом файле в тег
     end
     else
      l3Move(l_PicOffsets^, aIFD^.rTags^[I].rValue, l_PicOffsetsLen);
    end
    else
    begin
     l_Type := N(aIFD^.rTags^[I].rType);
     if (l_Type <= 12) and (l_Type > 0) then
      l_DLen := cDataSize[l_Type]
     else
      l_DLen := 1; // для неизвестных типов данных длина одного элемента - 1 байт
     l_DSize := N(aIFD^.rTags^[I].rCount) * l_DLen; // вычисляем общую длину данных
     if l_DSize <= 4 then // если общая длина данных укладывается в 4 байта - то данные содержатся в самом теге
      Continue;           // значит, можно их не переносить в файл, вернее, они запишутся позже, вместе с IFD
     // данные в файле, начинаем перенос
     l_DataPos := aOutStream.Position - aBasePos; // запоминаем позицию данных в целевом файле, чтобы потом записать в тег
     f_Stream.Seek(f_StreamBase + N(aIFD^.rTags^[I].rValue), soFromBeginning);
     while l_DSize > 0 do
     begin
      if l_DSize > cBufSize then
       l_Chunk := cBufSize
      else
       l_Chunk := l_DSize;
      f_Stream.Read(l_Buf^, l_Chunk);
      aOutStream.Write(l_Buf^, l_Chunk);
      l_DSize := l_DSize - l_Chunk;
     end;
     aIFD^.rTags^[I].rValue := N(l_DataPos); // записываем позицию данных в новом файле в тег
    end;
   end;
  finally
   l3System.FreeLocalMem(l_PicOffsets);
  end;
 finally
  l3System.FreeLocalMem(l_Buf);
 end;
end;

procedure TddTiffProcessor.PutIFDToStream(aIFD: PddIFD; const aOutStream: TStream; aBasePos: Int64;
                                          var theNextIFDLinkPos: LongWord);
const
 cZeroLongWord: LongWord = 0;
var
 l_Count: Word;
 l_NewIFDPos: LongWord;
 l_Temp: LongWord;
begin
 // выравниваем позицию в целевом файле по word boundary
 if (aOutStream.Position - aBasePos) and 1 = 1 then
  aOutStream.Write(cZeroLongWord, 1);
 l_NewIFDPos := aOutStream.Position - aBasePos; // позиция нового IFD, чтобы прилинковать к предыдущему
 aOutStream.Seek(aBasePos + theNextIFDLinkPos, soFromBeginning); // линкуем к предыдущему
 l_Temp := N(l_NewIFDPos);
 aOutStream.Write(l_Temp, 4);
 aOutStream.Seek(aBasePos + l_NewIFDPos, soFromBeginning); // возвращаемся назад и пишем IFD
 aOutStream.Write(aIFD^.rTagCount, SizeOf(Word));
 aOutStream.Write(aIFD^.rTags^, SizeOf(TddTIFFTag) * N(aIFD^.rTagCount));
 aOutStream.Write(cZeroLongWord, 4); // в линк на следующий пишем пока нули
 theNextIFDLinkPos := aOutStream.Position - aBasePos - 4; // вычисляем новую позицию для линка
end;

procedure TddTiffProcessor.ReadFileDirectories;
var
 l_IFD: PddIFD;
 l_SPos: LongWord;
begin
 l_SPos := N(f_Header.rFirstIFD);
 while l_SPos <> 0 do
 begin
  f_Stream.Seek(f_StreamBase + l_SPos, soFromBeginning);
  l_IFD := ReadIFD;
  if l_IFD = nil then
   raise EddTIFFError.Create(cs_CorruptedTIFF);
  f_IFDList.Add(l_IFD);
  l_SPos := N(l_IFD^.rNextIFD);
 end;
end;

procedure TddTiffProcessor.ReadHeader;
begin
 f_Stream.Read(f_Header, SizeOf(TddTIFFHeader));
 if (f_Header.rOrder <> $4949) and (f_Header.rOrder <> $4D4D) then
  raise EddTIFFError.Create(cs_InvalidTIFF);
 f_IsLittleEndian := f_Header.rOrder = $4949;
 if N(f_Header.rID) <> 42 then
  raise EddTIFFError.Create(cs_InvalidTIFF);
end;

function TddTiffProcessor.ReadIFD: PddIFD;
var
 l_Count: Word;
begin
 l3System.GetLocalMem(Result, SizeOf(TddIFD));
 try
  l3FillChar(Result^, SizeOf(TddIFD));
  f_Stream.Read(Result^.rTagCount, SizeOf(Word));
  l_Count := N(Result^.rTagCount);
  l3System.GetLocalMem(Result^.rTags, SizeOf(TddTIFFTag) * l_Count);
  f_Stream.Read(Result^.rTags^, SizeOf(TddTIFFTag) * l_Count);
  f_Stream.Read(Result^.rNextIFD, SizeOf(LongWord));
 except
  FreeIFD(Result);
  Result := nil;
 end;
end;

function EnumPagesInTIFF(aStream: TStream): Integer;
var
 l_Header: TddTIFFHeader;
 l_IsBigEndian: Boolean;
 l_Pos: LongWord;
 l_StreamBase: Int64;
 l_TagCount: Word;
begin
 Result := 0;
 l_StreamBase := aStream.Position;
 try
  aStream.Read(l_Header, SizeOf(TddTIFFHeader));
  if (l_Header.rOrder <> $4949) and (l_Header.rOrder <> $4D4D) then
   Exit;
  l_IsBigEndian := l_Header.rOrder = $4D4D;
  if _NW(l_Header.rID, l_IsBigEndian) <> 42 then
   Exit;
  l_Pos := _NLW(l_Header.rFirstIFD, l_IsBigEndian); // получаем из заголовка смещение первого IFD
  while l_Pos <> 0 do
  begin
   Inc(Result);
   aStream.Seek(l_StreamBase + l_Pos, soFromBeginning); // переходим на позицию очередного IFD
   aStream.Read(l_TagCount, SizeOf(Word)); // пропускаем теги
   aStream.Seek(_NW(l_TagCount, l_IsBigEndian) * SizeOf(TddTIFFTag), soFromCurrent);
   aStream.Read(l_Pos, SizeOf(LongWord)); // читаем позицию следующего IFD
   l_Pos := _NLW(l_Pos, l_IsBigEndian);
  end;
 finally
  aStream.Seek(l_StreamBase, soFromBeginning); // возвращаем поток в исходное состояние
 end;
end;

function EnumPagesInTIFF(aFileName: AnsiString): Integer;
var
 l_FS: Tl3FileStream;
begin
 l_FS := Tl3FileStream.Create(aFileName, l3_fmRead);
 try
  Result := EnumPagesInTIFF(l_FS);
 finally
  FreeAndNil(l_FS);
 end;
end;


end.