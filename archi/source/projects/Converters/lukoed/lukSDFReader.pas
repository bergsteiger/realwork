unit lukSDFReader;
{ Формирование документа и заполнение атрибутов }

// $Id: lukSDFReader.pas,v 1.23 2015/02/12 06:06:21 dinishev Exp $

// $Log: lukSDFReader.pas,v $
// Revision 1.23  2015/02/12 06:06:21  dinishev
// {Requestlink:588037744}. Извожу создание из TddTextSegment - это теперь базовый класс.
//
// Revision 1.22  2011/10/04 12:20:02  narry
// Причесывание документов
//
// Revision 1.21  2011/09/20 09:58:00  narry
// 65. Разнообразие в шапках недействующих документов (286228951)
//
// Revision 1.20  2011/09/09 12:56:02  narry
// 64. Оформление Протоколов - 5 (281529046)
//
// Revision 1.19  2011/09/09 10:24:34  narry
// 47. Тип по умолчанию (281524894)
//
// Revision 1.18  2011/09/09 09:09:33  narry
// 59. Преобразование источника "Правление Компании" (281528131)
//
// Revision 1.17  2011/09/09 05:45:02  narry
// 44. Не сбрасывается номер справки (281524878)
//
// Revision 1.16  2011/09/01 08:08:06  narry
// 35. Стирается пробел перед ссылкой (внимание на между "от" и датой) (278839514)
//
// Revision 1.15  2011/08/30 12:27:36  narry
// 43. Пересечение сегментов (281511735)
//
// Revision 1.14  2011/08/12 11:27:14  narry
// 32. Ограничение на преобразование (278839289)
//
// Revision 1.13  2011/08/12 07:50:34  narry
// 29. Добавлять VINCLUDED (278839275)
//
// Revision 1.12  2011/08/10 13:14:46  narry
// 26. Необходимые правки в оформлении текста (278836218)
//
// Revision 1.11  2011/07/26 13:40:08  narry
// Нужны имена блокам (275780426)
//
// Revision 1.10  2011/07/26 10:13:34  narry
// Заполнение атрибута Группа Документов (274844606)
//
// Revision 1.9  2011/07/22 11:22:35  narry
// Ошибки компиляции (274844549)
//
// Revision 1.8  2011/07/21 11:48:32  narry
// Пустые справки (274844570)
//
// Revision 1.7  2011/07/19 10:17:00  narry
// Директивы CVS
//

interface

uses
 ddSimpleHTMLReader, ddHTML_r, k2TagGen, l3Interfaces, l3Base, k2Reader, ddBase, l3ValLst,
 l3VCLStrings, lukIDGenerator, ddHTMLWriter;

type
 TlukHTMLReader = class(TddHTMLReader)
 private
  f_HyperLink: TddTextSegment;
  f_IDGenerator: TlukIDGenerator;
  f_SubIDs: Tl3Strings;
  procedure WorkupA(aTag: THTMLTag);
  procedure WorkupHR;
 protected
  procedure Cleanup; override;
  function GetDocID: Integer;
  function GetLinkDocID(const AFileName: String): Integer;
  function GetLinkSubID(const aSubName: String): Integer;
  function GetNewLinkSubID(const aSubName: String): Integer;
  procedure WorkupTag(aTag: THTMLTag); override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner = nil); override;
  procedure Read; override;
 published
  property IDGenerator: TlukIDGenerator Read f_IDGenerator write f_IDGenerator;
 end;


 TlukSDFReader = class(TlukHTMLReader)
 private
  f_DocClass: string;
  f_DocDate: Integer;
  f_DocGroup: string;
  f_DocNumber: string;
  f_DocType: string;
  f_Note: Tl3String;
  f_RelDocID: Integer;
  procedure AddDateNumbers;
  procedure AddDocName(const aText: String);
  procedure AddDocType(const aText: String);
  procedure AddDocSource(const aText: String);
  procedure AddDocStatus(const aText: String);
  procedure AddDocDate(const aText: String);
  procedure AddDocNumber(const aText: String);
  procedure AddDocNote(const aText: String);
  procedure AddDocNorm(const aText: String);
  procedure AddGroupsBelongs;
  procedure AddWarning(aID: Integer);
  procedure GenerateDocHeader;
  procedure GenerateDocNote;
  procedure WorkupIMG(aTag: THTMLTag);
  procedure WorkupMeta(aTag: THTMLTag);
 protected
  procedure Cleanup; override;
  function GetRelID: Integer;
  procedure WorkupTag(aTag: THTMLTag); override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner = nil); override;
  procedure Read; override;
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; const aFileName: String; aIDGen:
      TlukIDGenerator): Tk2CustomFileReader; overload;
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aIDGen:
      TlukIDGenerator): Tk2CustomFileReader; overload;
  property DocClass: string read f_DocClass write f_DocClass;
  property DocGroup: string read f_DocGroup write f_DocGroup;
  property DocType: string read f_DocType write f_DocType;
 published
 end;


implementation

uses
 StrUtils, SysUtils, l3ObjectRefList1, IniFiles, Document_Const, ddUtils, l3FileUtils, Classes,
 k2Tags, DictItem_Const, l3Stream, l3Types, imageenio,  BitmapPara_Const,
  ExtDataPara_Const, DT_Const, ActiveInterval_Const, l3Date, m0DTFlib, NumAndDate_Const,
  DT_Types, l3Memory, l3Chars, lukRelIDGenerator, k2Prim, l3CustomString,
  l3StringListPrim, l3StringList, logRecord_Const, l3String, ddDocument, ddHyperlink,
  ddHTMLTags;

{ TddSimpleHTMLReader }
{
******************************** TddHTMLReader *********************************
}
constructor TlukSDFReader.Create(aOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 Lite:= False;
 f_Note:= Tl3String.Create;
 ScaleCellWidth:= False;
end;

procedure TlukSDFReader.AddDateNumbers;
begin
 Generator.StartTag(k2_tiNumAndDates);
 try
   Generator.StartChild(k2_idNumAndDate);
   try
    Generator.AddIntegerAtom(k2_tiType, ord(dnPublish));
    Generator.AddIntegerAtom(k2_tiStart, f_DocDate);
    Generator.AddStringAtom(k2_tiNumber, f_DocNumber);
   finally
    Generator.Finish;
   end;
 finally
   Generator.Finish;
 end;
 Generator.StartTag(k2_tiLogRecords);
 try
  Generator.StartChild(k2_idLogRecord);
  try
   Generator.AddIntegerAtom(k2_tiType, Ord(acIncluded));
   Generator.AddIntegerAtom(k2_tiStart, StDateToDemon(CurrentDate));
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TlukSDFReader.AddDocName(const aText: String);
begin
 Generator.AddStringAtom(k2_tiName, aText);
end;

procedure TlukSDFReader.AddDocType(const aText: String);
begin
 if aText <> '' then
 begin
  Generator.StartTag(k2_tiTypes);
  try
   Generator.StartChild(k2_idDictItem);
   try
    if aText = '' then
     Generator.AddStringAtom(k2_tiName, DocType)
    else
     Generator.AddStringAtom(k2_tiName, aText);
   finally
    Generator.Finish;
   end;
  finally
   Generator.Finish;
  end;
 end; // aText <> ''
end;

procedure TlukSDFReader.AddDocSource(const aText: String);
begin
 if aText <> '' then
 begin
  Generator.StartTag(k2_tiSources);
  try
   Generator.StartChild(k2_idDictItem);
   try
    if AnsiSameText(aText, 'Правление компании') then
     Generator.AddStringAtom(k2_tiName, 'Правление')
    else
     Generator.AddStringAtom(k2_tiName, aText);
   finally
    Generator.Finish;
   end;
  finally
   Generator.Finish;
  end;
 end; // atext <> '' 
end;

procedure TlukSDFReader.AddDocStatus(const aText: String);
var
 l_DocStatus: Integer;
 l_Start, l_Finish: Integer;
begin
 l_DocStatus:= StrToIntDef(aText, 1);
 case l_DocStatus of
  2: AddWarning(19);
  3: AddWarning(31);
 end; 
 Generator.StartTag(k2_tiActiveIntervals);
 try
  Generator.StartChild(k2_idActiveInterval);
  try
   { Действует    - maxActiveDate
     Не действует - minActiveDate
     Отменен      - minActiveDate, в комментарий добавляем Отменен }
   case l_DocStatus of
    2: begin
        l_Start:= minActiveDate;
        l_Finish:= minActiveDate;
       end;
    3: begin
        l_Start:= minActiveDate;
        l_Finish:= minActiveDate;
        Generator.AddStringAtom(k2_tiComment, 'Отменен');
       end;
    else
     begin
      l_Start:= minActiveDate;
      l_Finish:= maxActiveDate;
     end;
   end; // case
   Generator.AddIntegerAtom(k2_tiStart, l_Start);
   Generator.AddIntegerAtom(k2_tiFinish, l_Finish);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TlukSDFReader.AddDocDate(const aText: String);
var
 l_DS: Char;
 l_SDF: String;
begin
 if aText <> '' then
 begin
  l_DS:= DateSeparator;
  l_SDF:= ShortDateFormat;
  DateSeparator := '.';
  ShortDateFormat := 'DD.MM.YYYY';
  f_DocDate:= DateTimeToDtDate(StrToDate(aText));
  DateSeparator := l_DS;
  ShortDateFormat := l_SDF;
 end; // aText <> ''
end;

procedure TlukSDFReader.AddDocNumber(const aText: String);
begin
 f_DocNumber:= aText;
end;

procedure TlukSDFReader.AddDocNote(const aText: String);
begin
 // Текст справки нужно запомнить и вывалить по окончании разбора
 if aText <> '' then
  f_Note.AsString:= aText
 else
  f_Note.AsString:= '<P>Справка к документу</P>';
end;

procedure TlukSDFReader.AddDocNorm(const aText: String);
begin
 Generator.StartTag(k2_tiNorm);
 try
  Generator.StartChild(k2_idDictItem);
  try
   Generator.AddStringAtom(k2_tiName, IfThen(aText = '1', 'Общие', 'Индивидуальные'));
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TlukSDFReader.AddGroupsBelongs;
begin
 Generator.StartTag(k2_tiGroups);
 try
  Generator.StartChild(k2_idDictItem);
  try
   Generator.AddStringAtom(k2_tiShortName, DocGroup);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
 Generator.StartTag(k2_tiPrefix);
 try
  Generator.StartChild(k2_idDictItem);
  try
   Generator.AddStringAtom(k2_tiName, 'Документы ЛУКОЙЛ');
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
 Generator.StartTag(k2_tiClasses);
 try
  Generator.StartChild(k2_idDictItem);
  try
   Generator.AddStringAtom(k2_tiName, DocClass);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TlukSDFReader.AddWarning(aID: Integer);
begin
  Generator.StartTag(k2_tiWarnings);
  try
    Generator.StartChild(k2_idDictItem);
    try
     Generator.AddIntegerAtom(k2_tiHandle, aID);
    finally
     Generator.Finish;
    end;
  finally
    Generator.Finish;
  end;
end;

procedure TlukSDFReader.Read;
begin
 f_RelDocID:= 0;
 inherited;
 if f_RelDocID <> 0 then
  GenerateDocNote;
end;

procedure TlukSDFReader.Cleanup;
begin
 inherited;
 FreeAndNil(f_Note);
end;

procedure TlukSDFReader.GenerateDocHeader;
begin
 Generator.AddIntegerAtom(k2_tiUserType, Ord(utDoc));
 Generator.AddIntegerAtom(k2_tiExternalHandle, GetDocID);
 f_RelDocID:= GetRelID;
 Generator.AddIntegerAtom(k2_tiRelExternalHandle, f_RelDocID);
end;

procedure TlukSDFReader.GenerateDocNote;
var
 l_LineStream : Tl3StringStream;
 l_G: Tk2TagGenerator;
begin
 { У нас есть запомненный текст справки, который представляет собой один абзац, оформленный html.
   То есть его нужно пропустить через читалку html }
 l_LineStream := Tl3StringStream.Create;
 try
  l_LineStream._String := f_Note;
  l_G:= nil;
  try
   TlukRelIDGenertor.SetTo(l_G, f_RelDocID);
   TlukRelIDGenertor(l_G).Generator:= Generator;
   TlukHTMLReader.SetTo(l_G, l_LineStream);
   TlukHTMLReader(l_G).IDGenerator:= IDGenerator;
   TlukHTMLReader(l_G).Start;
   try
    TlukHTMLReader(l_G).Read;
   finally
    TlukHTMLReader(l_G).Finish;
   end;
  finally
   FreeAndNil(l_G);
  end;
 finally
  FreeAndNil(l_LineStream);
 end;
end;

function TlukSDFReader.GetRelID: Integer;
begin
 Result := f_IDGenerator.GetRelID;
end;

class function TlukSDFReader.SetTo(var theGenerator: Tk2TagGenerator; const aFileName: String;
    aIDGen: TlukIDGenerator): Tk2CustomFileReader;
begin
 SetTo(theGenerator, aFileName);
 Result := theGenerator As Tk2CustomFileReader;
 TlukSDFReader(theGenerator).IDGenerator:= aIDGen;
end;

class function TlukSDFReader.SetTo(var theGenerator: Tk2TagGenerator; aIDGen:
    TlukIDGenerator): Tk2CustomFileReader;
begin
 SetTo(theGenerator);
 Result := theGenerator As Tk2CustomFileReader;
 TlukSDFReader(theGenerator).IDGenerator:= aIDGen;
end;

procedure TlukSDFReader.WorkupIMG(aTag: THTMLTag);
var
 i: Integer;
 l_FileName: String;
 l_Width, l_Height: Integer;
 l_Param: ThtmlParam;
 l_Stream: TStream;
 l_Pic: TddPicture;
begin
// <img src="logo.gif" width="" height="" alt="description" longdesc="long description" />
 l_FileName:= '';
 l_Height:= 0;
 l_Width:= 0;
 for i:= 0 to Pred(atag.ParamCount) do
 begin
  l_Param:= aTag.Params[i];
  if l_Param.Key = 'SRC' then
   l_FileName:= AnsiReplaceStr(l_Param.Value, '/', '\')
  else
  if l_param.Key = 'WIDTH' then
   l_Width:= l_Param.IntValue
  else
  if l_param.Key = 'HEIGHT' then
   l_Height:= l_Param.IntValue;
 end; // for i
 CloseParagraph();
 if FileExists(l_FileName) then
 try
  l_Pic:= TddPicture.Create(nil);
  try
   l_Pic.ExternalPath:= ExtractFileName(l_FileName);
   l_Pic.ExternalHandle:= GetDocID;
   l_Stream := Tl3FileStream.Create(l_FileName, l3_fmRead);
   try
    l_Pic.Stream:= l_Stream;
    l_pic.Width:= l_Width*96;
    l_Pic.Height:= l_Height*96;
   finally
    FreeAndNil(l_Stream);
   end;
   Document.AddDocumentAtom(l_pic);
  finally
   FreeAndNil(l_Pic);
  end;
 finally
  OpenParagraph;
 end; 
end;

procedure TlukSDFReader.WorkupMeta(aTag: THTMLTag);
var
 i: integer;
 l_Attr: TCustomIniFile;
 l_Param: THTMLParam;
 l_Strings: TStrings;
 l_TempFile: String;
begin
 for i:= 0 to Pred(aTag.ParamCount) do
 begin
  l_Param:= aTag.Params[i];
  if AnsiSameText(l_Param.Key, 'Content') then
  begin
   GenerateDocHeader;
   l_Strings:= TStringList.Create;
   try
    l_Strings.Text:= l_Param.Value;
    l_TempFile:= GetUniqFileName(GetWindowsTempFolder, 'sdf', 'evd');
    l_Strings.SaveToFile(l_TempFile);
    l_Attr:= TMemIniFile.Create(l_TempFile);
    try
     AddDocName(l_Attr.ReadString('DocName', 'Value1', ''));
     AddDocType(l_Attr.ReadString('DocType', 'Value1', DocType));
     AddDocSource(l_Attr.ReadString('DocLobby', 'Value1', ''));
     AddDocStatus(l_Attr.ReadString('DocStatus', 'Value1', ''));
     AddDocNorm(l_Attr.ReadString('DocNorm', 'Value1', ''));
     AddDocDate(l_Attr.ReadString('DocDate', 'Value1', ''));
     AddDocNumber(l_Attr.ReadString('DocNumber', 'Value1', ''));
     AddDocNote(l_Attr.ReadString('DocNote', 'Value1', ''));
    finally
     FreeAndNil(l_attr);
    end;
   finally
    DeleteFile(l_TempFile);
    FreeAndNil(l_Strings);
   end;
   AddDateNumbers;
   AddGroupsBelongs;
  end // AnsiSameText(l_Param.Key, 'Content')
 end; // for i
end;

procedure TlukSDFReader.WorkupTag(aTag: THTMLTag);
begin
 case aTag.tagID of
  tidMETA: WorkupMeta(aTag);
  tidIMG:  WorkupIMG(aTag);
 else
  inherited
 end; 
end;

{ TddSimpleHTMLReader }
{
******************************** TddHTMLReader *********************************
}
constructor TlukHTMLReader.Create(aOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_SubIDs:= Tl3Strings.Create;
end;

procedure TlukHTMLReader.Read;
begin
 f_SubIDs.Clear;
 inherited Read;
end;

procedure TlukHTMLReader.Cleanup;
begin
 inherited;
 if f_HyperLink <> nil then
  l3System.Msg2Log('Незакрытая ссылка');
 FreeAndNil(f_Hyperlink);
 FreeAndNil(f_SubIDs);
end;

function TlukHTMLReader.GetDocID: Integer;
begin
 f_IDGenerator.GetSelfID(Result);
end;

function TlukHTMLReader.GetLinkDocID(const AFileName: String): Integer;
begin
 f_IDGenerator.GetLinkID(aFileName, Result);
end;

function TlukHTMLReader.GetLinkSubID(const aSubName: String): Integer;
begin
 Result:= f_SubIDS.IndexOf(aSubName);
 if Result = -1 then
  Result:= Succ(f_SubIDs.Add(aSubName));
end;

function TlukHTMLReader.GetNewLinkSubID(const aSubName: String): Integer;
begin
 Result:= f_SubIDS.IndexOf(aSubName);
 if Result = -1 then
  Result:= Succ(f_SubIDs.Add(aSubName))
 else
  Result:= Succ(f_SubIDs.Add(aSubName+IntToStr(f_SubIDs.Count)));
end;

procedure TlukHTMLReader.WorkupA(aTag: THTMLTag);
var
 i, l_pos: Integer;
 l_Param: ThtmlParam;
 l_File: String;
begin
 // <a href=""></a> - ссылка с # ведет на метку внутри текущего документа иначе - на внешний
 // <a name=""></a> - метка в документе
 if aTag.IsClosed and (f_HyperLink <> nil) then
 begin
  f_HyperLink.Stop:= Document.LastPara.Text.Len;
  Document.LastPara.AddSegment(f_HyperLink);
  FreeAndNil(f_HyperLink);
 end
 else
 for i:= 0 to Pred(atag.ParamCount) do
 begin
  l_Param:= aTag.Params[i];
  if AnsiSameText(l_Param.Key, 'href') then
  begin
   if f_HyperLink <> nil then
   begin
    l3System.Msg2Log('Незакрытая ссылка');
    FreeAndNil(f_HyperLink);
   end;
   f_HyperLink:= TddHyperlink.Create;
   f_HyperLink.Start:= Document.LastPara.Text.Len+1;
   if AnsiStartsStr('#', l_Param.Value) then
    f_HyperLink.AddTarget(GetDocID, GetLinkSubID(Copy(l_Param.Value, 2, MaxInt)), 0)
   else
   begin
    l_File:= l_Param.Value;
    l_Pos:= Pos('#', l_File);
    if l_Pos > 0 then
     Delete(l_File, l_Pos, MaxInt);
    f_HyperLink.AddTarget(GetLinkDocID(l_File), 0, 0)
   end;
  end
 end; // for i
end;

procedure TlukHTMLReader.WorkupHR;
var
 l_PAP: TddParagraphProperty;
begin
 l_PAP:= Document.LastPara.PAP;
 // Добавляем в текст горизонтальную линию
 Document.AddParagraph;
 Document.Lastpara.AddText(DupeString(cc_HLine, 72), CP_OEM);
 Document.AddParagraph;
 Document.LastPara.PAP:= l_PAP;
end;

procedure TlukHTMLReader.WorkupTag(aTag: THTMLTag);
begin
 case aTag.TagID of
  tidA: WorkupA(aTag);
  tidHR: WorkupHR;
 else
  inherited
 end;
end;

end.

