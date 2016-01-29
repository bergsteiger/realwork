unit dd_lcDocImageConverter;
{$I ddDefine.inc}

{ $Id: dd_lcDocImageConverter.pas,v 1.17 2015/06/15 10:24:27 fireton Exp $ }

// $Log: dd_lcDocImageConverter.pas,v $
// Revision 1.17  2015/06/15 10:24:27  fireton
// - при сохранении образа сохраняем и RTF
//
// Revision 1.16  2014/08/05 06:29:42  lukyanets
// {Requestlink:558466572}. Правильные Define
//
// Revision 1.15  2014/02/24 05:42:31  fireton
// - не собирался gzPrj
//
// Revision 1.14  2013/12/11 10:40:41  fireton
// - мелкие доработки
//
// Revision 1.13  2013/10/25 09:20:24  fireton
// - переделки под изменения в k2
//
// Revision 1.12  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.11  2013/03/15 08:10:52  fireton
// - выделяем процедуру преобразования документа
//
// Revision 1.10  2013/01/22 12:42:58  narry
// LightVersion -> LiteVersion
//
// Revision 1.9  2012/11/09 08:52:29  narry
// Скрытый текст в исходных файлах (407750788)
//
// Revision 1.8  2012/09/04 09:56:13  fireton
// - динамическая загрузка конвертеров DOC и DOCX
//
// Revision 1.7  2012/08/29 10:23:59  fireton
// - выделяем определение формата в отдельный модуль
//
// Revision 1.6  2012/08/28 06:57:31  fireton
// - распознаём и конвертируем DOCX (K 388859425)
//
// Revision 1.5  2012/08/17 09:56:17  fireton
// - распознаём форматы и пишем в лог
//
// Revision 1.4  2012/07/18 10:21:58  fireton
// - не выливался номер документа
//
// Revision 1.3  2012/07/17 11:10:13  fireton
// - записываем образ документа (doc или rtf)
//
// Revision 1.2  2012/07/06 08:57:08  fireton
// - прогресс
//
// Revision 1.1  2012/05/03 06:10:19  fireton
// - initial commit
//

interface
uses
 Classes,

 l3Types,

 k2Interfaces,
 k2Prim,
 k2Types,
 k2TagFilter,

 ddRTFReader;

type
 TlcDocImageConvertFilter = class(Tk2TagFilter)
 private
  f_BaseImageName: AnsiString;
  f_ImageDir: AnsiString;
  f_RTFReader: TddRTFReader;
  f_SaveImage: Boolean;
  function pm_GetRTFReader: TddRTFReader;
  procedure TranslateImage(const aStream: TStream);
 protected
  procedure Cleanup; override;
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  property RTFReader: TddRTFReader read pm_GetRTFReader;
 public
  property BaseImageName: AnsiString read f_BaseImageName write f_BaseImageName;
  property ImageDir: AnsiString read f_ImageDir write f_ImageDir;
  property SaveImage: Boolean read f_SaveImage write f_SaveImage;
 end;

procedure ddTranslateImage(const aStream: TStream; const aGenerator: Ik2TagGenerator; aRTFReader: TddRTFReader = nil); 

implementation

{.$DEFINE SaveRTF}

uses
 Windows,
 SysUtils,

 l3Base,
 l3Memory,
 l3Base64,
 l3FileUtils,
 l3Stream,

 k2Tags,

 ddFileFormats,
 ddDoc2Rtf,
 ddUtils,

 Document_Const,

 ZipForge;

procedure TlcDocImageConvertFilter.Cleanup;
begin
 l3Free(f_RTFReader);
 inherited;
end;

procedure TlcDocImageConvertFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if (AtomIndex = k2_tiData) and CurrentType.IsKindOf(k2_typDocument) then
 begin
  if Value.AsStream <> nil then
   TranslateImage(Value.AsStream);
 end
 else
  inherited;
end;

function TlcDocImageConvertFilter.pm_GetRTFReader: TddRTFReader;
begin
 if f_RTFReader = nil then
 begin
  f_RTFReader := TddRTFReader.Create(nil);
  f_RTFReader.LiteVersion := False{True};
 end;
 Result := f_RTFReader;
end;

procedure TlcDocImageConvertFilter.TranslateImage(const aStream: TStream);
var
 l_Type        : TddFileFormat;
 l_FinStream   : TStream;
 l_IsConverted : Boolean;
 l_FS: Tl3FileStream;
 l_ImageFN: AnsiString;
 l_Ext: AnsiString;
 l_ImgCount: Integer;
 l_IsAvail: Boolean;
 l_RTFHandle   : THandle;
 l_RTFSize     : Integer;
begin
 l_Type := ddGetFileFormat(aStream);
 if l_Type in [ffDOC, ffDOCX, ffRTF] then
 begin
  if SaveImage and (f_BaseImageName <> '') then
  begin
   case l_Type of
    ffDoc : l_Ext := '.doc';
    ffDocx: l_Ext := '.docx';
    ffRTF : l_Ext := '.rtf';
   end;
   (* 
   l_FS := Tl3FileStream.Create('m:\temp\sud\' + BaseImageName + l_Ext, l3_fmWrite);
   aStream.Seek(0, soFromBeginning);
   l_FS.CopyFrom(aStream, aStream.Size);
   FreeAndNil(l_FS);
   aStream.Seek(0, soFromBeginning);
   (* *)
   l_ImageFN := ConcatDirName(f_ImageDir, f_BaseImageName + l_Ext);
   l_ImgCount := 1;
   while FileExists(l_ImageFN) do
   begin
    Inc(l_ImgCount);
    l_ImageFN := ConcatDirName(f_ImageDir, Format('%s_%d%s',[f_BaseImageName, l_ImgCount, l_Ext]));
   end;
   l_FS := Tl3FileStream.Create(l_ImageFN, l3_fmWrite);
   try
    l_FS.CopyFrom(aStream, aStream.Size);
   finally
    FreeAndNil(l_FS);
   end;
   aStream.Seek(0, soFromBeginning);
  end;

  l_IsConverted := False;
  if l_Type in [ffDoc, ffDocx] then
  begin
   case l_Type of
    ffDoc  : l_IsAvail := IsDocConvertAvailable;
    ffDocx : l_IsAvail := IsDocxConvertAvailable;
   end;

   if l_IsAvail then
   begin
    case l_Type of
     ffDoc  : l_RTFHandle := ConvertDocFromStream(aStream);
     ffDocx : l_RTFHandle := ConvertDocxFromStream(aStream)
    end;
   end
   else
    l_RTFHandle := 0;

   if l_RTFHandle = 0 then
   begin
    l3System.Msg2Log('Не удалось сконвертировать %s образ документа!', [c_SFileFormat[l_Type]]);
    Exit;
   end;

   l_FinStream := Tl3HMemoryStream.Create(l_RTFHandle);
   l_IsConverted := True;
  end
  else
   l_FinStream := aStream;
  try
   if SaveImage and (l_Type <> ffRTF) then
   begin
    // Сохраняем RTF
    l_FS := Tl3FileStream.Create(ChangeFileExt(l_ImageFN, '.rtf'), l3_fmWrite);
    try
     l_FinStream.Seek(0, soFromBeginning);
     l_FS.CopyFrom(l_FinStream, l_FinStream.Size);
    finally
     FreeAndNil(l_FS);
     l_FinStream.Seek(0, soFromBeginning);
    end;
   end;
   RTFReader.Filer.Stream := l_FinStream;
   RTFReader.Generator := Generator;
   RTFReader.Start;
   try
    try
     RTFReader.Read;
    except
     on E: Exception do
     begin
      {$IFDEF SaveRTF}
      // Сохраняем оригинал
      if l_Type <> ffRTF then
      begin
       l_FS := Tl3FileStream.Create(GetAppFolderFileName(f_BaseImageName+l_ext), l3_fmWrite);
       try
        aStream.Seek(0, soFromBeginning);
        l_FS.CopyFrom(aStream, aStream.Size);
       finally
        FreeAndNil(l_FS);
        aStream.Seek(0, soFromBeginning);
       end;
      end;
      // Сохраняем RTF
      l_FS := Tl3FileStream.Create(GetAppFolderFileName(f_BaseImageName+'.rtf'), l3_fmWrite);
      try
       l_FinStream.Seek(0, soFromBeginning);
       l_FS.CopyFrom(l_FinStream, l_FinStream.Size);
      finally
       FreeAndNil(l_FS);
       l_FinStream.Seek(0, soFromBeginning);
      end; 
      {$ENDIF SaveRTF}
      //raise;
     end;
    end;
   finally
    RTFReader.Finish;
   end;
   RTFReader.Filer.Stream := nil;
  finally
   if l_IsConverted then
   begin
    FreeAndNil(l_FinStream);
    GlobalFree(l_RTFHandle);
   end;
  end;
 end
 else
  l3System.Msg2Log('Образ документа формата %s - не преобразован!', [c_SFileFormat[l_Type]]);
end;


{.$DEFINE DEBUG_IMAGE_CONVERSION}

procedure ddTranslateImage(const aStream: TStream; const aGenerator: Ik2TagGenerator; aRTFReader: TddRTFReader = nil);
var
 l_Type        : TddFileFormat;
 l_FinStream   : TStream;
 l_IsConverted : Boolean;
 l_ImgCount: Integer;
 l_IsAvail: Boolean;
 l_OwnRTFReader: Boolean;
 l_RTFHandle   : THandle;
 l_RTFSize     : Integer;
 {$IFDEF DEBUG_IMAGE_CONVERSION}
 l_FS          : Tl3FileStream;
 {$ENDIF}
begin

 {$IFDEF DEBUG_IMAGE_CONVERSION}
 l_FS := Tl3FileStream.Create('c:\temp\image.doc', l3_fmWrite);
 aStream.Seek(0, soFromBeginning);
 l_FS.CopyFrom(aStream, aStream.Size);
 FreeAndNil(l_FS);
 aStream.Seek(0, soFromBeginning);
 {$ENDIF}

 l_Type := ddGetFileFormat(aStream);
 if l_Type in [ffDOC, ffDOCX, ffRTF] then
 begin
  l_OwnRTFReader := aRTFReader = nil;
  if l_OwnRTFReader then
  begin
   aRTFReader := TddRTFReader.Create(nil);
   aRTFReader.LiteVersion := False;
  end;
  try                                    
   l_IsConverted := False;
   if l_Type in [ffDoc, ffDocx] then
   begin
    case l_Type of
     ffDoc  : l_IsAvail := IsDocConvertAvailable;
     ffDocx : l_IsAvail := IsDocxConvertAvailable;
    end;
 
    if l_IsAvail then
    begin
     case l_Type of
      ffDoc  : l_RTFHandle := ConvertDocFromStream(aStream);
      ffDocx : l_RTFHandle := ConvertDocxFromStream(aStream)
     end;
    end
    else
     l_RTFHandle := 0;
 
    if l_RTFHandle = 0 then
    begin
     l3System.Msg2Log('Не удалось сконвертировать %s образ документа!', [c_SFileFormat[l_Type]]);
     Exit;
    end;
 
    l_FinStream := Tl3HMemoryStream.Create(l_RTFHandle);
    l_IsConverted := True;
   end
   else
    l_FinStream := aStream;
   try
    aRTFReader.Filer.Stream := l_FinStream;
    aRTFReader.Generator := aGenerator;
    //aRTFReader.Start;
    try
     aRTFReader.Read;
    finally
     //aRTFReader.Finish;
    end;
    aRTFReader.Filer.Stream := nil;
    aRTFReader.Filer := nil;
   finally
    if l_IsConverted then
    begin
     FreeAndNil(l_FinStream);
     GlobalFree(l_RTFHandle);
    end;
   end;
  finally
   if l_OwnRTFReader then
    FreeAndNil(aRTFReader);
  end;
 end
 else
  l3System.Msg2Log('Образ документа формата %s - не преобразован!', [c_SFileFormat[l_Type]]);
end;

end.
