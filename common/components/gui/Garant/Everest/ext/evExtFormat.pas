unit evExtFormat;
{* Модуль для обработки дополнительных форматов. Для обработки форматов достаточно подключения данного модуля в секции uses. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evExtFormat - }
{ Начат: 28.08.2001 17:40 }
{ $Id: evExtFormat.pas,v 1.39 2016/07/15 13:18:46 lulin Exp $ }

// $Log: evExtFormat.pas,v $
// Revision 1.39  2016/07/15 13:18:46  lulin
// - собираем DesignTime.
//
// Revision 1.38  2015/11/23 12:55:19  dinishev
// {Requestlink:612100517}
//
// Revision 1.37  2015/10/08 11:15:46  dinishev
// {Requestlink:588548123}. Выставил флга для Немезиса.
//
// Revision 1.36  2015/10/08 05:45:16  dinishev
// But fix: не то закоммител.
//
// Revision 1.35  2015/10/08 05:40:30  dinishev
// {Requestlink:567555433}
//
// Revision 1.34  2015/05/06 13:50:50  dinishev
// {Requestlink:590772837}
//
// Revision 1.33  2015/05/06 12:42:13  dinishev
// {Requestlink:590772837}
//
// Revision 1.32  2015/05/05 14:43:48  dinishev
// {Requestlink:590772837}
//
// Revision 1.31  2015/03/04 12:34:22  dinishev
// Опция читать WMF, если есть вместо обычно картинки выставил по-умолчанию для EverestLite
//
// Revision 1.30  2014/10/24 09:49:50  dinishev
// {Requestlink:569237438}
//
// Revision 1.29  2014/08/29 12:24:45  lulin
// - вычищаем ненужную директиву.
//
// Revision 1.28  2013/08/23 09:23:35  dinishev
// Делаем чтение RTF как в Арчи.
//
// Revision 1.27  2013/04/05 12:02:19  lulin
// - портируем.
//
// Revision 1.26  2013/02/13 10:21:23  lulin
// - убираем лишние зависимости.
//
// Revision 1.25  2013/01/22 12:18:58  narry
// LightVersion -> LiteVersion
//
// Revision 1.24  2012/11/01 09:41:42  lulin
// - забыл точку с запятой.
//
// Revision 1.23  2012/11/01 07:43:08  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.22  2012/08/30 14:20:25  lulin
// {RequestLink:390564295}
//
// Revision 1.21  2012/07/05 12:47:57  lulin
// {RequestLink:373005769}
//
// Revision 1.20  2012/02/10 15:49:51  lulin
// {RequestLink:329646242}
//
// Revision 1.19  2011/02/08 09:08:07  dinishev
// [$252524029]
//
// Revision 1.18  2010/12/03 12:44:58  lulin
// {RequestLink:244195248}.
//
// Revision 1.17  2010/05/26 13:00:28  lulin
// {RequestLink:216072357}.
// - при выливке в NSRC выкидываем полностью объединённые строки таблиц.
//
// Revision 1.16  2009/09/03 12:39:21  dinishev
// Выливаем NSRC в EverestLite как и в Арчи
//
// Revision 1.15  2008/12/18 14:42:48  lulin
// - <K>: 132222370.
//
// Revision 1.14  2008/05/23 16:04:40  lulin
// - <K>: 91848978.
//
// Revision 1.13  2007/12/04 12:47:41  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.12.26.4  2007/03/16 13:56:51  lulin
// - переходим на собственную функцию форматирования строк.
//
// Revision 1.12.26.3  2005/12/08 13:29:46  lulin
// - cleanup.
//
// Revision 1.12.26.2  2005/11/15 09:36:42  lulin
// - от реализации переходим к интерфейсам.
//
// Revision 1.12.26.1  2005/11/14 18:37:02  lulin
// - теперь при заборе в буфер обмена в него кладется контейнер документа, а не TextSource - должно починить ошибку CQ OIT5-17870.
//
// Revision 1.12  2004/04/15 15:17:39  law
// - bug fix: не указываем "лишний" параметр.
//
// Revision 1.11  2003/12/11 16:24:06  law
// - new directive: evFullNSRC (для английского отдела).
//
// Revision 1.10  2003/10/14 16:35:52  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.9  2003/03/20 14:23:12  law
// - new behavior: по другому выливаем в кодировку DOS (теперь применяем CP_OEMLite).
//
// Revision 1.8  2002/09/24 15:09:41  law
// - rename unit: evTxtExp -> evTextFormatter.
//
// Revision 1.7  2002/07/08 09:46:27  law
// - new behavior: при EverestLite читаем RTF-Lite и из doc-файлов.
//
// Revision 1.6  2002/03/27 17:10:09  law
// - new unit: evLoadDocumentManager.
//
// Revision 1.5  2002/01/03 14:19:04  law
// - some cosmetics.
//
// Revision 1.4  2001/12/18 14:06:34  law
// - new unit: evSaveDocumentManager.
//
// Revision 1.3  2001/08/29 08:53:55  law
// - comments: xHelpGen.
//
// Revision 1.2  2001/08/28 15:25:05  law
// - new behavior: переделано получение фильтров чтения/записи.
//
// Revision 1.1  2001/08/28 14:01:42  law
// - new unit: evExtFormat.
//

{$Include evDefine.inc }

interface

implementation

uses
  l3Chars,
  l3Base,
  l3Interfaces,

  k2TagGen,
  k2Reader,
  
  evTypes,
  evdStyles,
  evTextSource,
  evTextFormatter,
  evPictureReader,
  evGeneratorUtils,
  evSimpleTextPainter,
  {$IfNDef evExternalProduct}
  evNSRWrt,
  {$IfDef evFullNSRC}
  ddNSRC_w,
  {$Else  evFullNSRC}
  evNSRCPlusWriter,
  {$EndIf evFullNSRC}
  {$EndIf  evExternalProduct}

  evdEmptyRowFilter,
  nevPersistentDocumentContainer,

  {$If NOT Defined(DesignTimeLibrary)}
  evPDFWriter,
  {$IfEnd}
  {$IfNDef evExternalProduct}
  ddNSRC_r,
  {$EndIf  evExternalProduct}
  ddHTML_r,
  {$IfDef Nemesis}
  evTabStopsFilter,
  {$ELSE}
  {$IfNDef NoZIP}
  ddDocReader,
  {$EndIf  NoZIP}
  {$EndIf  Nemesis}
  
  Readers,
  Writers,
  evEmptyTableEliminator,
  evdScriptHyperlinkEliminator,

  evdXMLWriter
  ;

procedure GetReader(Sender     : TObject;
                    Format     : TevFormat;
                    var theReader : Tk2CustomReader;
                    const aFileName: AnsiString = '');
var
 {$IFDEF Nemesis}
 l_TagGenerator : Tk2TagGenerator;
 {$ENDIF Nemesis}
 l_PictureReader: TevPictureReader;
begin
 if (theReader = nil) then
 begin
  if (Format = cf_HTML) then
  begin
   l3Free(theReader);
   theReader := TddHTMLReader.Create(nil);
  end//Format = cf_HTML
  else
  if (Format = cf_RTF) OR (Format = cf_RTFLite) then
  begin
   l3Free(theReader);
   theReader := TevRTFReader.Create(nil);
   {$IF Defined(EverestLite) or Defined(Archi)}
   TevRTFReader(theReader).LiteVersion := true;
   TevRTFReader(theReader).EnablePictures := true;
   {$IFDEF EverestLite}
   TevRTFReader(theReader).ReadWMFIfExists := True;
   {$ENDIF EverestLite}
   {$Else}
   TevRTFReader(theReader).LiteVersion := (Format = cf_RTFLite);
   {$IFEND}
   {$IFDEF Nemesis}
   TevRTFReader(theReader).IdenticalRowWidths := True;
   l_TagGenerator := nil;
   TevTabStopsFilter.SetTo(l_TagGenerator);
   try
    (theReader as Ik2TagGeneratorChainEnd).Link(l_TagGenerator);
   finally
    l3Free(l_TagGenerator);
   end;
   {$ENDIF Nemesis}
  end//Format = cf_RTF..
  {$IfNDef evExternalProduct}
  else
  if (Format = cf_NSRC) then
  begin
   l3Free(theReader);
   theReader := TCustomNSRCReader.Create(nil);
   TCustomNSRCReader(theReader).StrictFormat := false;
  end//Format = cf_NSRC
  {$EndIf evExternalProduct}
  {$IfNDef Nemesis}
  {$IfNDef NoZIP}
  else
  if (Format = cf_Doc) then
  begin
   l3Free(theReader);
   theReader := TddCustomDocReader.Create(nil);
   {$IfDef EverestLite}
   TddCustomDocReader(theReader).LiteVersion := true;
   {$EndIf EverestLite}
  end//Format = cf_Doc
  {$EndIf NoZIP}
  {$EndIf  Nemesis}
  else
  if (Format = CF_HDROP) and (aFileName <> '') then
  begin
   l3Free(theReader);
   l_PictureReader := TevPictureReader.Make(aFileName);
   if l_PictureReader.IsPicture then
    theReader := l_PictureReader
   else
    l3Free(l_PictureReader);
  end;
 end;//theReader = nil
end;

procedure GetWriter(Sender     : TObject;
                    Format     : TevFormat;
                    var Writer : Tk2TagGenerator);
{$IfNDef evExternalProduct}
var
 PTG : Tk2TagGenerator;
{$EndIf  evExternalProduct} 
begin
 if (Writer = nil) then
 begin
  if (Format = cf_HTML) then
  begin
   l3Free(Writer);
   Writer := TevHTMLWriter.Create;
  end{Format = cf_HTML}
  else
  if (Format = cf_PDF) then
  begin
   l3Free(Writer);
   Writer := TevPDFWriter.Create;
   evSetFilters4PDF(Writer, [-ev_saTechComment]);
  end // if (Format = cf_PDF) then
  else
  if (Format = cf_XML) then
  begin
   l3Free(Writer);
   Writer := TevdXMLWriter.Create;
  end{Format = cf_XML}
  else
  if (Format = cf_RTF) OR (Format = cf_RTFLite) then
  begin
   l3Free(Writer);
   Writer := TevRTFWriter.Create;
   TevdScriptHyperlinkEliminator.SetTo(Writer);
   //TevRTFWriter(Writer).LiteVersion := (Format = cf_RTFLite);
  end{Format = cf_RTF}
  {$IfNDef evExternalProduct}
  else
  if (Format = cf_NSRC) then
  begin
   l3Free(Writer);
   Writer := TevSimpleTextPainter.Create;
   {$IfDef evFullNSRC}
   PTG := TddNSRCGenerator.Create;
   {$Else  evFullNSRC}
   PTG := TevNSRCPlusWriter.Create;
   {$EndIf evFullNSRC}
   try
    {$IfNDef Archi}
    {$IfNDef EverestLite}
    TevCustomNSRCWriter(PTG).CodePage := CP_KeepExisting;
    {$ENDIF EverestLite}
    {$EndIf  Archi}
    with TevTextFormatter(Writer) do
    begin
     {$If defined(Archi) or defined(EverestLite)}
     CodePage := CP_OEMLite;
     {$ELSE}
     CodePage := CP_KeepExisting;
     {$IFEND}
     SBSDelimeter := '|';
     Generator := PTG;
     FormatOrdinalParas := true;
    end;{with TevTextFormatter(Writer)..}
    TevdEmptyRowFilter.SetTo(Writer);
    TevEmptyTableEliminator.SetTo(Writer);
   finally
    l3Free(PTG);
   end;{try..finally}
   {Format = cf_NSRC}
  end
  {$EndIf evExternalProduct}
  ;
 end;//Writer = nil
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evExtFormat.pas initialization enter'); {$EndIf}
 evGetReaderProc := GetReader;
 evGetWriterProc := GetWriter;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evExtFormat.pas initialization leave'); {$EndIf}
end.

