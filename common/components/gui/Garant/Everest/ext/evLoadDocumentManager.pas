unit evLoadDocumentManager;
{* �������� �������� ���������. }

{ ���������� "�������"            }
{ �����: ����� �.�. �             }
{ ������: evLoadDocumentManager - }
{ �����: 27.03.2002 16:34         }
{ $Id: evLoadDocumentManager.pas,v 1.23 2015/04/24 15:48:22 kostitsin Exp $ }

// $Log: evLoadDocumentManager.pas,v $
// Revision 1.23  2015/04/24 15:48:22  kostitsin
// no message
//
// Revision 1.22  2014/09/25 10:50:10  dinishev
// ���� ����� ��� ��������.
//
// Revision 1.21  2013/12/25 09:38:52  dinishev
// {Requestlink:508826885}. �������������� ���������� � NSRCReader'�.
//
// Revision 1.20  2013/10/23 12:25:50  lulin
// - ������������� ������������ ���� ���� ���������� � ������.
//
// Revision 1.19  2013/05/31 06:24:35  lulin
// - ��������� ��� XE4.
//
// Revision 1.18  2013/03/15 11:24:01  dinishev
// ��������� docx � EverestLite
//
// Revision 1.17  2013/02/13 10:21:24  lulin
// - ������� ������ �����������.
//
// Revision 1.16  2012/11/01 09:41:42  lulin
// - ����� ����� � �������.
//
// Revision 1.15  2012/11/01 07:43:08  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.14  2012/08/30 14:25:09  lulin
// {RequestLink:390564295}
//
// Revision 1.13  2012/08/30 14:20:26  lulin
// {RequestLink:390564295}
//
// Revision 1.12  2008/09/25 07:05:22  dinishev
// ����������� ������� �������� doc-������
//
// Revision 1.11  2008/09/24 13:38:41  dinishev
// Bug fix: �� ��������� doc-����� � Everest'�
//
// Revision 1.10  2008/05/16 15:28:40  lulin
// - new build.
//
// Revision 1.9  2007/12/04 12:47:41  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.6.8.10  2007/10/04 15:46:59  lulin
// - ��������� ��������� ������.
//
// Revision 1.6.8.9  2007/08/30 13:20:55  lulin
// - cleanup.
//
// Revision 1.6.8.8  2007/08/14 19:31:32  lulin
// - ������������ ������� ������.
//
// Revision 1.6.8.7  2007/04/20 07:11:59  oman
// - fix: �� �������� �� ����������� ��� �������� EVD (���� ������
//  ���������._nsTest)
//
// Revision 1.6.8.6  2007/01/24 10:21:44  oman
// - new: ����������� ��������� - ev (cq24078)
//
// Revision 1.6.8.5  2006/11/24 15:48:05  lulin
// - �������� �������� XML � �������� EVD.
//
// Revision 1.6.8.4  2005/11/15 13:50:09  lulin
// - cleanup: ���������� ������ Reader ����� - �� ����������� ��� ���� Pool. ���������� ������ �������������� ������.
//
// Revision 1.6.8.3  2005/11/15 09:36:42  lulin
// - �� ���������� ��������� � �����������.
//
// Revision 1.6.8.2  2005/11/14 18:37:02  lulin
// - ������ ��� ������ � ����� ������ � ���� �������� ��������� ���������, � �� TextSource - ������ �������� ������ CQ OIT5-17870.
//
// Revision 1.6.8.1  2005/07/21 10:40:01  lulin
// - ��������� plain-������ �������� � ���������� �����.
//
// Revision 1.6  2005/03/03 17:28:22  lulin
// - ��������� �� ������� ���������� ���������� ���������.
//
// Revision 1.5  2003/12/02 15:33:28  law
// - bug fix: ��������� �� ������ ��� �����.
//
// Revision 1.4  2003/12/02 15:23:56  law
// - bug fix: ����� ��������� ������������ ��������� evNotNeedIStorage.
//
// Revision 1.3  2003/10/14 16:35:52  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.2  2003/03/17 15:34:12  law
// - bug fix: �� ��������, ����� �� ���� OpenDialog.
//
// Revision 1.1  2002/03/27 17:10:09  law
// - new unit: evLoadDocumentManager.
//

{$Include evDefine.inc }

interface

uses
  Windows,

  Classes,
  Dialogs,

  l3Types,
  l3Base,

  l3InterfacedComponent,

  k2Base,
  k2Reader,

  evCustomTextSource
  ;

type
  TevLoadFormat = (
                   {$IfDef evMyEditor}
                   ev_lfMy,
                   {$Else  evMyEditor}
                   ev_lfEVD,
                   {$EndIf  evMyEditor}
                   ev_lfTxt,
                   ev_lfTxtAsIs,
                   {$IfNDef evExternalProduct}
                   ev_lfNSRC,
                   {$EndIf  evExternalProduct}
                   ev_lfRTF,
                   {$IfNDef EverestLite}
                   ev_lfRTFLite,
                   {$EndIf  EverestLite}
                   ev_lfDoc,
                   ev_lfDocX,
                   ev_lfHTM,
                   ev_lfXML,
                   {$IFDEF EverestLite}
                   ev_lfPDF,
                   {$ENDIF EverestLite}
                   ev_lfAll
                   );
   {* ��������� ������� ������. }
   
  TevCustomLoadDocumentManager = class(Tl3InterfacedComponent)
   {* �������� ���������� ���������. }
    private
    // property fields
      f_OpenDialog  : TOpenDialog;
      f_FileName    : String;
      f_FilterIndex : TevLoadFormat;
    protected
    // property methods
      procedure pm_SetFileName(const aValue: String);
        {-}
    protected
    //internal methods
      procedure Notification(aComponent: TComponent; Operation: TOperation);
        override;
        {-}
      procedure FillDialog;
        {-}
      function  FormatByName(const aFileName: String): TevLoadFormat;
        {-}
      function  FormatFromDialog: Bool;
        {-}
    public
    // public methods
      function QueryName: Bool;
        {-}
      function GetReader(aTextSource: TevCustomTextSource): Tk2CustomReader;
        {-}
      function Load(aTextSource : TevCustomTextSource;
                    aType       : Tk2Type): String;
        {-}
    public
    // public properties
      property OpenDialog: TOpenDialog
        read f_OpenDialog
        write f_OpenDialog;
        {* - ������ ������� ����� ������������ �����. }
      property FileName: String
        read f_FileName
        write pm_SetFileName;
        {-}
  end;//TevCustomLoadDocumentManager

  TevLoadDocumentManager = class(TevCustomLoadDocumentManager)
   {* �������� ���������� ���������. }
    published
    // published properties
      property OpenDialog;
        {-}
  end;//TevLoadDocumentManager

implementation

uses
  SysUtils,

  l3String,
  l3Filer,
  {$IfNDef evExternalProduct}
  {$IfDef  evUseIStorage}
  l3WindowsStorageFiler,
  {$EndIf  evUseIStorage}
  {$EndIf  evExternalProduct}

  k2TagGen,
  k2InternalInterfaces,

  evdXMLReader,

  nevInternalInterfaces,
  
  evTypes,

  {$IFDEF EverestLite}
  ddNSRC_r,
  {$ENDIF EverestLite}

  {$IfNDef Nemesis}
  {$IfNDef NoZIP}
  ddDocReader,
  {$EndIf  NoZIP}
  {$EndIf  Nemesis}

  evTxtRd
  ;

type
  TevLoadFormatDescriptor = record
   {* ��������� ������� ��������. }
    UserName        : String;
    Ext             : String;
    ClipboardFormat : Tl3ClipboardFormat;
    {$IfNDef evExternalProduct}
    UseIStorage     : Bool;
    {$EndIf  evExternalProduct}
  end;//TevLoadFormatDescriptor
  TevLoadFormatDescriptors = packed array of TevLoadFormatDescriptor;
   {* ��������� �������� ��������. }
  TevLoadFormats = packed object
    private
    // internal fields
      f_LoadFormatDescriptors : TevLoadFormatDescriptors;
    public
    // public methods
      procedure Init;
        {-}
      procedure Done;
        {-}
      procedure AddFormat(aFormat          : TevLoadFormat;
                          const aUserName  : String;
                          const anExt      : String;
                          aClipboardFormat : Tl3ClipboardFormat
                          {$IfNDef evExternalProduct}
                          ;
                          aUseIStorage     : Bool = false
                          {$EndIf  evExternalProduct}
                          );
        {-}
      function  GetFormat(anIndex: TevLoadFormat): TevLoadFormatDescriptor;
        {-}
  end;//TevLoadFormats

var
  evLoadFormats : TevLoadFormats;

// start class TevCustomLoadDocumentManager

procedure TevCustomLoadDocumentManager.pm_SetFileName(const aValue: String);
  {-}
begin
 f_FileName := l3StripDoubleQuotes(aValue);
 f_FilterIndex := FormatByName(f_FileName);
end;

procedure TevCustomLoadDocumentManager.Notification(aComponent: TComponent; Operation: TOperation);
  //override;
  {-}
begin
 inherited;
 if (Operation = opRemove) AND (aComponent = OpenDialog) then
  OpenDialog := nil;
end;

procedure TevCustomLoadDocumentManager.FillDialog;
  {-}
var
 l_Filter : String;
 l_Index  : TevLoadFormat;
begin
 for l_Index := Low(TevLoadFormat) to High(TevLoadFormat) do
 begin
  with evLoadFormats.GetFormat(l_Index) do
  begin
   if (l_Filter <> '') then
    l_Filter := l_Filter + '|';
   l_Filter := Format('%s%s (*.%s)|*.%s', [l_Filter, UserName, Ext, Ext]);
  end;//with evLoadFormats[l_Index]
 end;//for l_Index
 //OpenDialog.InitialDir := ExtractFilePath(f_FileName);
 OpenDialog.InitialDir := f_FileName;
 OpenDialog.Filter := l_Filter;
end;

function TevCustomLoadDocumentManager.FormatByName(const aFileName: String): TevLoadFormat;
  {-}
var
 l_Index : TevLoadFormat;
 l_Ext   : String;
begin
 Result := TevLoadFormat(0);
 l_Ext := ExtractFileExt(aFileName);
 for l_Index := Low(TevLoadFormat) to High(TevLoadFormat) do
  if (CompareText(l_Ext, '.' + evLoadFormats.GetFormat(l_Index).Ext) = 0) then
  begin
   Result := l_Index;
   break;
  end;//CompareText..
 // .. ����� ���-�� ���� ������...
end;

function TevCustomLoadDocumentManager.FormatFromDialog: Bool;
  {-}
var
 l_OldFilter : String;
begin
 Result := false;
 if (OpenDialog = nil) then
  OpenDialog := TOpenDialog.Create(Self);
 l_OldFilter := OpenDialog.Filter;
 try
  FillDialog;
  with OpenDialog do
   if Execute then begin
    f_FileName := FileName;
    if (f_FileName = '') then
     Exit;
    f_FilterIndex := TevLoadFormat(Pred(FilterIndex));
    Result := true;
    if (f_FilterIndex = ev_lfAll) then
     f_FilterIndex := FormatByName(f_FileName);
   end else
    Exit;
 finally
  OpenDialog.Filter := l_OldFilter;
 end;//try..finally
end;

function TevCustomLoadDocumentManager.QueryName: Bool;
  {-}
begin
 Result := FormatFromDialog;
end;

function TevCustomLoadDocumentManager.GetReader(aTextSource: TevCustomTextSource): Tk2CustomReader;
  {-}
var
 l_Filer : Tl3CustomDOSFiler;
 l_D     : TevLoadFormatDescriptor;
begin
 Result := nil;
 if (f_FileName = '') then Exit;
 {$IfNDef evExternalProduct}
 {$IfDef  evUseIStorage}
 if evLoadFormats.GetFormat(f_FilterIndex).UseIStorage then
  l_Filer := Tl3CustomWindowsStorageFiler.Make(f_FileName, l3_fmRead, false)
 else
 {$EndIf  evUseIStorage}
 {$EndIf  evExternalProduct}
  l_Filer := Tl3CustomDOSFiler.Make(f_FileName,
                                    l3_fmRead,
                                    f_FilterIndex in [ev_lfTxt, ev_lfTxtAsIs]);
 try
  l_D := evLoadFormats.GetFormat(f_FilterIndex);
  if (l_D.ClipboardFormat = CF_Locale) then
  begin
   Case f_FilterIndex of
    ev_lfXML :
     Result := TevdXMLReader.Create;
    else
     Exit;
   end;//Case f_FilterIndex
   if (Result <> nil) then
    Tk2CustomFileReader(Result).Filer := l_Filer;
  end//l_D.ClipboardFormat = CF_Locale
  else
   InevDocumentContainerInternal(aTextSource.DocumentContainer.Internal).GetReader(evLoadFormats.GetFormat(f_FilterIndex).ClipboardFormat,
                        l_Filer As IStream,
                        Result,
                        false,
                        l_Filer.CodePage);
  if (Result = nil) then Exit;
  {$IfNDef Nemesis}
  {$IfNDef NoZIP}
  {$If declared(TddCustomDocReader)}
  if Result is TddCustomDocReader then
   (Result as Tk2CustomFileReader).Filer := l_Filer;
  {$IfEnd}
  {$EndIf  NoZIP}
  {$EndIf  Nemesis}
  {$IFDEF EverestLite}
  if f_FilterIndex = ev_lfNSRC then
   (Result As TCustomNSRCReader).WorkDir := ExtractFilePath(f_FileName);
  {$ENDIF EverestLite}
  if (f_FilterIndex  = ev_lfTxt) then
   (Result As TevCustomTxtReader).PlainText := true;
 finally
  l3Free(l_Filer);
 end;//try..finally
end;

function TevCustomLoadDocumentManager.Load(aTextSource : TevCustomTextSource;
                                           aType       : Tk2Type): String;
  {-}
var
 l_Reader : Tk2CustomReader;
begin
 Result := '';
 l_Reader := GetReader(aTextSource);
 try
  aTextSource.FileName := f_FileName;
  Result := f_FileName;
  if (l_Reader = nil) then
   aTextSource.New(aType)
  else
   aTextSource.Load(l_Reader);
 finally
  l3Free(l_Reader);
 end;//try..finally
end;

// start object TevLoadFormats

procedure TevLoadFormats.Init;
  {-}
begin
 SetLength(f_LoadFormatDescriptors, Succ(Ord(High(TevLoadFormat))));
 l3FillChar(f_LoadFormatDescriptors[0],
          Length(f_LoadFormatDescriptors) * SizeOf(TevLoadFormatDescriptor), 0);
end;

procedure TevLoadFormats.Done;
  {-}
begin
 f_LoadFormatDescriptors := nil;
end;

function TevLoadFormats.GetFormat(anIndex: TevLoadFormat): TevLoadFormatDescriptor;
  {-}
begin
 Result := f_LoadFormatDescriptors[Ord(anIndex)];
end;

procedure TevLoadFormats.AddFormat(aFormat          : TevLoadFormat;
                                   const aUserName  : String;
                                   const anExt      : String;
                                   aClipboardFormat : Tl3ClipboardFormat
                                   {$IfNDef evExternalProduct}
                                   ;
                                   aUseIStorage     : Bool = false
                                   {$EndIf  evExternalProduct}
                                   );
  {-}
begin
 with f_LoadFormatDescriptors[Ord(aFormat)] do begin
  UserName := aUserName;
  Ext := anExt;
  ClipboardFormat := aClipboardFormat;
  {$IfNDef evExternalProduct}
  UseIStorage := aUseIStorage;
  {$EndIf  evExternalProduct}
 end;//with f_LoadFormatDescriptors[Ord(aFormat)]
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evLoadDocumentManager.pas initialization enter'); {$EndIf}
 {$If Defined(Nemesis) and not Defined(nsTest)}
 {$ifndef DesignTimeLibrary}
 Assert(false, 'STUB - �� ������������');
 {$endif}
 {$IfEnd Defined(Nemesis) and not Defined(nsTest)}
  with evLoadFormats do begin
   Init;
   {$IfDef evMyEditor}
   AddFormat(ev_lfMy,           '��������� ����� ���������', 'my', CF_EverestBin);
   {$Else  evMyEditor}
   AddFormat(ev_lfEVD,          '��������� �������', 'evd', CF_EverestBin
             {$IfNDef evExternalProduct}
             ,
             true
             {$EndIf  evExternalProduct});
   {$EndIf evMyEditor}
   AddFormat(ev_lfTxt,          '��������� ����� � ���������������', 'txt', CF_Text);
   AddFormat(ev_lfTxtAsIs,      '��������� ����� As Is', 'txt', CF_Text);
   {$IfNDef evExternalProduct}
   AddFormat(ev_lfNSRC,         '��������� �������', 'nsr', CF_NSRC);
   {$EndIf evExternalProduct}
   {$IfDef EverestLite}
   AddFormat(ev_lfRTF,          'RTF-��������', 'rtf', CF_RTFLite);
   {$Else  EverestLite}
   AddFormat(ev_lfRTF,          'RTF-��������', 'rtf', CF_RTF);
   AddFormat(ev_lfRTFLite,      'RTF-�������� (��� ����������)', 'rtf', CF_RTFLite);
   {$EndIf EverestLite}
   {$IfNDef Nemesis}
   AddFormat(ev_lfDoc,          '��������� MS Word', 'doc', CF_Doc);
   AddFormat(ev_lfDocX,          '��������� MS Word 2007', 'docx', CF_Doc);
   {$EndIf  Nemesis}
   AddFormat(ev_lfHTM,          'HTML-��������', 'htm', CF_HTML);
   AddFormat(ev_lfXML,          'XML-��������', 'xml', CF_Locale);
   {$IFDEF EverestLite}
   AddFormat(ev_lfPDF,          'PDF-��������', 'pdf', CF_Locale);
   {$ENDIF EverestLite}
   AddFormat(ev_lfAll,          '��� �����', '*', CF_EverestBin);
  end;//with evLoadFormats

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evLoadDocumentManager.pas initialization leave'); {$EndIf}
finalization
  evLoadFormats.Done;

end.

