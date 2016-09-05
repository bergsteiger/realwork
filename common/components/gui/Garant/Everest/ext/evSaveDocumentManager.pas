unit evSaveDocumentManager;
{* Менеджер сохранения документа. }

{ Библиотека "Эверест"            }
{ Автор: Люлин А.В. ©             }
{ Модуль: evSaveDocumentManager - }
{ Начат: 17.12.2001 17:06         }
{ $Id: evSaveDocumentManager.pas,v 1.32 2016/07/15 13:18:46 lulin Exp $ }

// $Log: evSaveDocumentManager.pas,v $
// Revision 1.32  2016/07/15 13:18:46  lulin
// - собираем DesignTime.
//
// Revision 1.31  2015/08/18 12:15:36  lulin
// {RequestLink:604929290}
//
// Revision 1.30  2015/05/07 10:53:53  dinishev
// Недокоммител правки.
//
// Revision 1.29  2015/05/06 13:50:50  dinishev
// {Requestlink:590772837}
//
// Revision 1.28  2015/05/06 12:46:13  dinishev
// {Requestlink:590772837}
//
// Revision 1.27  2015/05/06 12:42:19  dinishev
// {Requestlink:590772837}
//
// Revision 1.26  2015/04/24 15:48:22  kostitsin
// no message
//
// Revision 1.25  2014/10/31 14:24:23  dinishev
// Дополнительный фильтр для PDF
//
// Revision 1.24  2014/10/21 13:25:34  dinishev
// {Requestlink:566807405}. Одинаковый с Немезисом набор фильтров, чтобы можно было быстрее отлаживать.
//
// Revision 1.23  2014/09/19 08:19:44  dinishev
// Поправил набор фильтров для Эвереста
//
// Revision 1.22  2014/08/29 10:59:16  dinishev
// {Requestlink:564248678}
//
// Revision 1.21  2014/02/06 13:23:07  dinishev
// {Requestlink:509085881}
//
// Revision 1.20  2013/12/13 10:06:17  dinishev
// {Requestlink:508822756}
//
// Revision 1.19  2012/11/01 09:41:42  lulin
// - забыл точку с запятой.
//
// Revision 1.18  2012/11/01 07:43:08  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.17  2008/05/16 15:28:40  lulin
// - new build.
//
// Revision 1.16  2008/03/11 07:10:06  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.15  2008/01/22 12:24:03  lulin
// - сделана возможность сохранять в xml.
//
// Revision 1.14  2007/12/04 12:47:41  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.10.32.5  2007/08/14 19:31:32  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.10.32.4  2007/01/24 10:21:44  oman
// - new: Локализация библиотек - ev (cq24078)
//
// Revision 1.10.32.3  2006/12/12 09:54:30  oman
// - fix: Перенос HiddenStyles c DocumentContainer на редактор.
//   Поддержка экспорта/клипборда/d'n'd (cq12564)
//
// Revision 1.10.32.2  2005/11/14 19:05:46  lulin
// - bug fix: не компилировалось.
//
// Revision 1.10.32.1  2005/07/21 13:00:40  lulin
// - писатель формата EVD переехал в папку EVD.
//
// Revision 1.10  2003/12/02 16:00:12  law
// - new behavior: если не было SaveDialog'а, то создаем его.
//
// Revision 1.9  2003/10/14 16:35:52  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.8  2002/09/24 15:09:41  law
// - rename unit: evTxtExp -> evTextFormatter.
//
// Revision 1.7  2002/04/03 13:52:20  law
// - new directive: evMakeBackupCopy.
//
// Revision 1.6  2002/01/10 13:17:53  law
// - new behavior: сделано создание bak-копий при сохранении документов.
//
// Revision 1.5  2002/01/08 12:44:12  law
// - new behavior: сделано отключение записи в cf_EverestTxt для EverestLite.
//
// Revision 1.4  2002/01/03 14:19:04  law
// - some cosmetics.
//
// Revision 1.3  2001/12/19 08:27:44  law
// - new behavior: сделана обработка ошибок в поисковых формулах.
//
// Revision 1.2  2001/12/18 14:08:11  law
// - cleanup.
//
// Revision 1.1  2001/12/18 14:06:34  law
// - new unit: evSaveDocumentManager.
//

{$I evDefine.inc }

{$Define evMakeBackupCopy}

interface

uses
  Windows,

  Classes,
  Dialogs,

  l3Types,
  l3Base,

  l3InterfacedComponent,

  k2Interfaces,

  evCustomTextSource
  ;

{$IfDef EverestLite}
 {$Undef evdNeedEverestTxt}
{$EndIf EverestLite}

type
  TevSaveFormat = (
                   {$IfDef evMyEditor}
                   ev_sfMy,
                   {$Else  evMyEditor}
                   ev_sfEVDBin,
                   {$IfDef evdNeedEverestTxt}
                   ev_sfEVDTxt,
                   {$EndIf evdNeedEverestTxt}
                   {$EndIf  evMyEditor}
                   ev_sfTxtOEM,
                   ev_sfTxtANSI,
                   ev_sfPlainTxtOEM,
                   ev_sfPlainTxtANSI,
                   {$IfNDef evExternalProduct}
                   ev_sfNSRC,
                   {$EndIf  evExternalProduct}
                   ev_sfRTF,
                   ev_sfHTM
                   {$IfDef evUseIStorage}
                   ,
                   ev_sfSEVDBin
                   {$IfDef evdNeedEverestTxt}
                   ,
                   ev_sfSEVDTxt
                   {$EndIf evdNeedEverestTxt}
                   {$EndIf evUseIStorage}
                   ,
                   ev_sfXML
                   ,
                   ev_sfPDF
                   );
   {* Доступные форматы записи. }

  TevCustomSaveDocumentManager = class(Tl3InterfacedComponent)
   {* Менеджер сохранения документа. }
    private
    // property fields
      f_SaveDialog  : TOpenDialog;
      f_FilterIndex : TevSaveFormat;
    private
      {$IFDEF EverestLite}
      procedure Try2SetExportDir(const aWriter: Ik2TagGenerator; const aExportDir: AnsiString);
       {-}
      {$ENDIF EverestLite}
    protected
    //internal methods
      procedure Notification(aComponent: TComponent; Operation: TOperation);
        override;
        {-}
      procedure FillDialog;
        {-}
      function  FormatByName(const aFileName: String): TevSaveFormat;
        {-}
      function  FormatFromDialog(out theFileName: String): TevSaveFormat;
        {-}
    public
    // public methods
      function Save(aTextSource: TevCustomTextSource; const aFilters: Ik2TagGenerator): String;
        {-}
    public
    // public properties
      property SaveDialog: TOpenDialog
        read f_SaveDialog
        write f_SaveDialog;
        {* - диалог запроса имени сохраняемого файла. }
  end;//TevCustomSaveDocumentManager

  TevSaveDocumentManager = class(TevCustomSaveDocumentManager)
   {* Менеджер сохранения документа. }
    published
    // published properties
      property SaveDialog;
        {-}
  end;//TevSaveDocumentManager

implementation

uses
  SysUtils,

  l3Filer,
  l3FileUtils,
  {$IfDef evUseIStorage}
  l3WindowsStorageFiler,
  {$EndIf evUseIStorage}

  k2TagGen,
  k2InternalInterfaces,

  evdStyles,
  evGeneratorUtils,
  evdXMLWriter,

  evTypes,

  {$If NOT Defined(DesignTimeLibrary)}
  evPDFWriter,
  {$IfEnd}
  evTextFormatter,
  evGeneratorsInterfaces,

  nevInternalInterfaces
  , k2Prim;

type
  TevSaveFormatDescriptor = record
   {* Описатель формата записи. }
    UserName        : String;
    Ext             : String;
    ClipboardFormat : Tl3ClipboardFormat;
    {$IfDef evUseIStorage}
    UseIStorage     : Bool;      
    {$EndIf evUseIStorage}
  end;//TevSaveFormatDescriptor
  TevSaveFormatDescriptors = packed array of TevSaveFormatDescriptor;
   {* Описатели форматов записи. }
  TevSaveFormats = packed object
    private
    // internal fields
      f_SaveFormatDescriptors : TevSaveFormatDescriptors;
    public
    // public methods
      procedure Init;
        {-}
      procedure Done;
        {-}
      procedure AddFormat(aFormat          : TevSaveFormat;
                          const aUserName  : String;
                          const anExt      : String;
                          aClipboardFormat : Tl3ClipboardFormat
                          {$IfDef evUseIStorage}
                          ;
                          aUseIStorage     : Bool = false
                          {$EndIf evUseIStorage}
                          );
        {-}
      function  GetFormat(anIndex: TevSaveFormat): TevSaveFormatDescriptor;
        {-}
  end;//TevSaveFormats

var
  evSaveFormats : TevSaveFormats;

// start class TevCustomSaveDocumentManager

procedure TevCustomSaveDocumentManager.Notification(aComponent: TComponent; Operation: TOperation);
  //override;
  {-}
begin
 inherited;
 if (Operation = opRemove) AND (aComponent = SaveDialog) then
  SaveDialog := nil;
end;

procedure TevCustomSaveDocumentManager.FillDialog;
  {-}
var
 l_Filter : String;
 l_Index  : TevSaveFormat;
begin
 for l_Index := Low(TevSaveFormat) to High(TevSaveFormat) do begin
  with evSaveFormats.GetFormat(l_Index) do begin
   if (l_Filter <> '') then
    l_Filter := l_Filter + '|';
   l_Filter := Format('%s%s (*.%s)|*.%s', [l_Filter, UserName, Ext, Ext]);
  end;//with evSaveFormats[l_Index]
 end;//for l_Index
 SaveDialog.Filter := l_Filter;
end;

function TevCustomSaveDocumentManager.FormatByName(const aFileName: String): TevSaveFormat;
  {-}
var
 l_Index : TevSaveFormat;
 l_Ext   : String;
begin
 Result := TevSaveFormat(0);
 l_Ext := ExtractFileExt(aFileName);
 for l_Index := Low(TevSaveFormat) to High(TevSaveFormat) do
  if (CompareText(l_Ext, '.' + evSaveFormats.GetFormat(l_Index).Ext) = 0) then begin
   Result := l_Index;
   break;
  end;//CompareText..
 // .. здесь что-то надо делать...
end;

function TevCustomSaveDocumentManager.FormatFromDialog(out theFileName: String): TevSaveFormat;
  {-}
var
 l_OldFilter : String;
begin
 Result := TevSaveFormat(0);
 l_OldFilter := SaveDialog.Filter;
 try
  FillDialog;
  with SaveDialog do
   if Execute then begin
    theFileName := FileName;
    Result := TevSaveFormat(Pred(FilterIndex));
   end else
    Exit;
 finally
  SaveDialog.Filter := l_OldFilter;
 end;//try..finally
end;

{$IFDEF EverestLite}
procedure TevCustomSaveDocumentManager.Try2SetExportDir(const aWriter: Ik2TagGenerator; const aExportDir: AnsiString);
{$IfNDef evExternalProduct}
var
 l_Gen    : Ik2TagGenerator;
 l_ExpInt : IevNSRCExport;
 {$EndIf  evExternalProduct}
begin
 {$IfNDef evExternalProduct}
 if (aExportDir <> '') and (f_FilterIndex = ev_sfNSRC) then
 begin
  l_Gen := aWriter;
  while l_Gen <> nil do
  begin
   if Supports(l_Gen, IevNSRCExport, l_ExpInt) then
   begin
    l_ExpInt.SetExportDirectory(aExportDir);
    l_ExpInt.SetExternalDocHandle(1); // Заглушка для EverestLite
    Break;
   end; // if Supports(l_Gen, IevNSRCExport, l_ExpInt) then
   l_Gen := l_Gen.NextGenerator;
  end; // while l_Gen <> nil do
 end; // if f_FilterIndex = ev_sfNSRC then
 {$EndIf  evExternalProduct}
end;
{$ENDIF EverestLite}

function TevCustomSaveDocumentManager.Save(aTextSource: TevCustomTextSource; const aFilters: Ik2TagGenerator): String;
  {-}
var
 l_FileName    : String;
 l_Writer      : Tk2TagGenerator;
 l_FilerSource : Ik2FilerSource;
 l_Filer       : Tl3CustomDOSFiler;
 {$IFDEF EverestLite}
 l_Folder      : String;
 {$ENDIF EverestLite}
 l_TmpFileName : String;
begin
 Result := '';
 if (SaveDialog = nil) then
  SaveDialog := TSaveDialog.Create(Self);
 if (SaveDialog <> nil) AND (aTextSource <> nil) then begin
  l_FileName := aTextSource.FileName;
  if (l_FileName = '') then
   f_FilterIndex := FormatFromDialog(l_FileName)
  else
   // - вычисляем FilterIndex по расширению
   f_FilterIndex := FormatByName(l_FileName);
  if (l_FileName = '') then Exit;
  InevDocumentContainerInternal(aTextSource.DocumentContainer.Internal).GetWriter(evSaveFormats.GetFormat(f_FilterIndex).ClipboardFormat, true, l_Writer, aFilters);
  try
   if (l_Writer = nil) then
   begin
    if (f_FilterIndex = ev_sfXML) then
     l_Writer := TevdXMLWriter.Create;
    if (f_FilterIndex = ev_sfPDF) then
    begin
     {$If NOT Defined(DesignTimeLibrary)}
     l_Writer := TevPDFWriter.Create;
     {$Else}
     l_Writer := nil;
     {$IfEnd}
     EvSetFilters4PDF(l_Writer, [-ev_saTechComment]);
    end; // if (f_FilterIndex = ev_sfPDF) then
   end;//l_Writer = nil
   if (l_Writer = nil) then Exit;
   if (f_FilterIndex in [ev_sfTxtOEM, ev_sfTxtANSI]) then
    (l_Writer As TevTextFormatter).FormatOrdinalParas := true;
   l_FileName := l3ChangeBlankExt(l_FileName, evSaveFormats.GetFormat(f_FilterIndex).Ext);
   if Supports(l_Writer, Ik2FilerSource, l_FilerSource) then
    try
     {$IfDef evMakeBackupCopy}
     l_TmpFileName := GetUniqFileName(ExtractFilePath(l_FileName), 'cpy', '.tmp');
     {$Else  evMakeBackupCopy}
     l_TmpFileName := l_FileName;
     {$EndIf evMakeBackupCopy}
     {$IfDef evUseIStorage}
     if evSaveFormats.GetFormat(f_FilterIndex).UseIStorage then
      l_Filer := Tl3CustomWindowsStorageFiler.Make(l_TmpFileName, l3_fmWrite, false)
     else
     {$EndIf evUseIStorage}
      l_Filer := Tl3CustomDOSFiler.Make(l_TmpFileName, l3_fmWrite, false);
     try
      l_FilerSource.Filer := l_Filer;
     finally
      l3Free(l_Filer);
     end;//try..finally
    finally
     l_FilerSource := nil;
    end;//try..finally
   {$IFDEF EverestLite}
   l_Folder := ExtractFilePath(SaveDialog.FileName);
   Try2SetExportDir(l_Writer, l_Folder);
   {$ENDIF EverestLite}
   aTextSource.Save(l_Writer, true);
   {$IfDef evMakeBackupCopy}
   RenameFileSafe(l_TmpFileName, l_FileName);
   {$EndIf evMakeBackupCopy}
   aTextSource.FileName := l_FileName;
  finally
   l3Free(l_Writer);
  end;//try..finally
  Result := l_FileName;
 end;//SaveDialog <> nil..
end;

// start object TevSaveFormats

procedure TevSaveFormats.Init;
  {-}
begin
 SetLength(f_SaveFormatDescriptors, Succ(Ord(High(TevSaveFormat))));
 l3FillChar(f_SaveFormatDescriptors[0],
          Length(f_SaveFormatDescriptors) * SizeOf(TevSaveFormatDescriptor), 0);
end;

procedure TevSaveFormats.Done;
  {-}
begin
 f_SaveFormatDescriptors := nil;
end;

function TevSaveFormats.GetFormat(anIndex: TevSaveFormat): TevSaveFormatDescriptor;
  {-}
begin
 {$IfDef Nemesis}
 {$ifndef DesignTimeLibrary}
 Assert(False,'STUB - не локализовано');
 {$endif}
 {$Endif Nemesis}
 Result := f_SaveFormatDescriptors[Ord(anIndex)];
end;

procedure TevSaveFormats.AddFormat(aFormat          : TevSaveFormat;
                                   const aUserName  : String;
                                   const anExt      : String;
                                   aClipboardFormat : Tl3ClipboardFormat
                                   {$IfDef evUseIStorage}
                                   ;
                                   aUseIStorage     : Bool = false
                                   {$EndIf evUseIStorage}
                                   );
  {-}
begin
 with f_SaveFormatDescriptors[Ord(aFormat)] do begin
  UserName := aUserName;
  Ext := anExt;
  ClipboardFormat := aClipboardFormat;
  {$IfDef evUseIStorage}
  UseIStorage := aUseIStorage;
  {$EndIf evUseIStorage}
 end;//with f_SaveFormatDescriptors[Ord(aFormat)]
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evSaveDocumentManager.pas initialization enter'); {$EndIf}
  with evSaveFormats do begin
   Init;
   {$IfDef evMyEditor}
   AddFormat(ev_sfMy,           'Документы Моего редактора', 'my', CF_EverestBin);
   {$Else  evMyEditor}
   AddFormat(ev_sfEVDBin,       'Документы Эверест двоичные', 'evd', CF_EverestBin);
   {$IfDef evdNeedEverestTxt}
   AddFormat(ev_sfEVDTxt,       'Документы Эверест текстовые', 'evd', CF_EverestTxt);
   {$EndIf evdNeedEverestTxt}
   {$EndIf evMyEditor}
   AddFormat(ev_sfTxtOEM,       'Текстовые файлы DOS', 'txt', CF_OEMText);
   AddFormat(ev_sfTxtANSI,      'Текстовые файлы Windows', 'txt', CF_Text);
   AddFormat(ev_sfPlainTxtOEM,  'Текстовые файлы DOS без разбиения', 'txt', CF_OEMText);
   AddFormat(ev_sfPlainTxtANSI, 'Текстовые файлы Windows без разбиения', 'txt', CF_Text);
   {$IfNDef evExternalProduct}
   AddFormat(ev_sfNSRC,         'Исходники Гаранта', 'nsr', CF_NSRC);
   {$EndIf evExternalProduct}
   AddFormat(ev_sfRTF,          'RTF-документ', 'rtf', CF_RTF);
   AddFormat(ev_sfHTM,          'HTML-страница', 'htm', CF_HTML);
   {$IfDef evUseIStorage}
   AddFormat(ev_sfSEVDBin,      'Структурированные документы Эверест двоичные', 'evd', CF_EverestBin, true);
   {$IfDef evdNeedEverestTxt}
   AddFormat(ev_sfSEVDTxt,      'Структурированные документы Эверест текстовые', 'evd', CF_EverestTxt, true);
   {$EndIf evdNeedEverestTxt}
   {$EndIf evUseIStorage}
   AddFormat(ev_sfXML,      'XML-документ', 'xml', CF_Locale);
 {$IFDEF EverestLite}                                         
   AddFormat(ev_sfPDF,      'PDF-документ', 'pdf', CF_Locale);
 {$ENDIF EverestLite}
  end;//with evSaveFormats

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evSaveDocumentManager.pas initialization leave'); {$EndIf}
finalization
  evSaveFormats.Done;

end.

