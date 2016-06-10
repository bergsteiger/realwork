Unit ddHTMLAnno;
{ $Id: ddHTMLAnno.pas,v 1.36 2016/05/13 10:47:24 dinishev Exp $ }

// $Log: ddHTMLAnno.pas,v $
// Revision 1.36  2016/05/13 10:47:24  dinishev
// {Requestlink:623067981}
//
// Revision 1.35  2015/11/19 14:57:55  fireton
// - выкинул ненужные модули из implementation
//
// Revision 1.34  2015/10/13 12:55:56  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.33  2014/09/08 12:27:51  fireton
// - не выливаем в Прайм комментарии юристов
//
// Revision 1.32  2014/04/08 17:13:31  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.31  2014/04/04 07:14:48  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.30  2014/03/28 06:53:33  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.29  2014/03/18 17:40:30  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.28  2014/03/04 16:44:58  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.27  2014/02/14 15:33:56  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.26  2013/10/21 15:43:19  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.25  2013/10/21 10:31:07  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.24  2013/10/18 16:01:28  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.23  2013/07/18 09:55:52  fireton
// - убираем технические комментарии из аннотаций Прайма (K 443842668)
//
// Revision 1.22  2013/04/15 05:59:22  narry
// Не собиралось
//
// Revision 1.21  2013/04/11 16:46:52  lulin
// - отлаживаем под XE3.
//
// Revision 1.20  2013/04/09 12:30:23  narry
// Не компилировалось
//
// Revision 1.19  2011/05/03 11:22:39  narry
// Расширение функциональности (265394281)
//
// Revision 1.18  2011/04/28 12:36:11  narry
// Расширение функциональности (265394281)
//
// Revision 1.17  2010/06/16 14:05:18  narry
// - K206078273
//
// Revision 1.16  2009/03/13 15:12:11  narry
// - рефакторинг
//
// Revision 1.15  2009/02/17 12:53:19  narry
// - толстая линия, отделяющая документ от справки
//
// Revision 1.14  2008/06/23 11:21:24  narry
// - не собиралось
//
// Revision 1.13  2008/03/04 11:44:40  narry
// - выделение отдельного модуля для экспорта доков ФНС
//
// Revision 1.12  2008/02/06 09:27:38  narry
// - не компилировалось
//
// Revision 1.11  2007/11/16 08:51:15  narry
// - новый объект - TFNSExportPipe
//
// Revision 1.10  2007/09/18 09:04:30  voba
// - change _rAtom to Attr
//
// Revision 1.9  2007/08/22 13:27:25  narry
// - не компилировалось
//
// Revision 1.8  2007/08/09 18:05:25  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.7  2007/07/04 09:21:07  narry
// - обновление
//
// Revision 1.6  2007/04/05 09:29:29  narry
// - ошибка чтения несуществующего файла
// - динамическое вычисление текущего года
//
// Revision 1.5  2007/01/10 14:44:42  narry
// - пополнение вместо перезаписи файла списка документов
//
// Revision 1.4  2006/11/27 15:57:12  narry
// - экспорт в XML для nalog.ru
//
// Revision 1.3  2006/07/18 14:06:14  narry
// - обновление: удаление временного файла по окончании работы
//
// Revision 1.2  2006/05/06 13:37:11  narry
// - заточки под Прайм, починка таблиц
//
// Revision 1.1  2006/04/12 10:55:20  narry
// - новый модуль: Экспорт документов в HTML в один файл вместе со справкой
//



interface

Uses
  l3Types, l3Base, l3Filer, l3TempMemoryStream, l3Variant,
  k2Types,
  k2Prim,
  k2TagGen,
  k2TagTerminator,
  k2DocumentBuffer,
  k2ForkGenerator,
  ddDocTypeDetector, SewerPipe, ddXMLAnnoWriter,
  Classes,
  ht_Const,
  dt_Sab, k2TagFilter, ddPipeOutInterfaces;


type
 TddHTMLAnnoFileName = procedure (aFileName: AnsiString) of object;
 TddHTMLAnnotationFilter = class(Tk2TagTerminator)
 private
  f_Buffer: Tk2DocumentBuffer;
  f_DocTag: Integer;
  f_DocType: Integer;
  f_ExTopicNo: Integer;
  f_Filtered: Boolean;
  f_IsAnno: Boolean;
  f_OnNewFileName: TddHTMLAnnoFileName;
  f_RelExTopicNo: Integer;
  f_TopicList: TStrings;
  f_TopicListFileName: AnsiString;
  procedure CheckBuffer(aTopicNo: Longint);
  procedure ExtractName;
  procedure WriteFirstPara;
  procedure WriteReferenceMark;
 protected
  procedure Cleanup; override;
  procedure CloseStream(NeedUndo: Boolean); override;
    {internal methods}
  procedure OpenStream; override;
  procedure WriteBuffer(InnerDoc: Boolean);
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner); override;
      {-}
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
      {-}
  procedure CloseStructure(NeedUndo: Bool); override;
  procedure NewDocDetected(Sender: TObject; TopicNo: Longint; aDocPart: TddExportDocPart; MainGroup: ShortString);
  procedure StartChild(TypeID: Tl3VariantDef); override;
      {-}
  procedure StartTag(TagID: Long); override;
  property TopicList: TStrings read f_TopicList;
  property TopicListFileName: AnsiString read f_TopicListFileName write f_TopicListFileName;
  property OnNewFileName: TddHTMLAnnoFileName read f_OnNewFileName write f_OnNewFileName;
 end;

 TddHTMLAnnotationPipe = class(Tl3Base)
 private
   FFileName: AnsiString;
   FFiler: Tl3DOSFiler;
   FG: Tk2TagGenerator;
   FPipe: TSewerPipe;
   f_FNSExport: Boolean;
   f_Fork: Tk2ForkGenerator;
   f_OnNewDocument: TNewDocumentEvent;
   f_XMLFiler: Tl3CustomFiler;
   f_XMLGen: Tk2TagGenerator;
   f_XMLStream: Tl3TempMemoryStream;
   procedure OnNewFileName(AFileName: AnsiString);
   procedure WriteDocListFile;
 protected
   procedure Cleanup; override;
 public
   constructor Create(DocListFileName: AnsiString); reintroduce;
   function Execute: Boolean;
   property FNSExport: Boolean read f_FNSExport write f_FNSExport;
   property Pipe: TSewerPipe read FPipe;
 end;

type
 TddHTMLAnnotationPipe1 = class(Tl3Base)
 private
   FFileName: AnsiString;
   FFiler: Tl3DOSFiler;
   FG: Tk2TagGenerator;
   FPipe: TSewerPipe;
   f_NamesList: TStrings;
   f_MissedNamesList: TStrings;
   f_OnNewDocument: TNewDocumentEvent;
 protected
   procedure AnnoNameFound(aDocID: Integer; const aName: AnsiString);
   procedure Cleanup; override;
 public
   constructor Create(DocListFileName: AnsiString); reintroduce;
   function Execute: Boolean;
   procedure NewDocDetected(Sender: TObject; TopicNo: Longint; aDocPart: TddExportDocPart; MainGroup: ShortString);
   property NamesList: TStrings read f_NamesList write f_NamesList;
   property MissedNamesList: TStrings read f_MissedNamesList write
       f_MissedNamesList;
   property Pipe: TSewerPipe read FPipe;
 end;

implementation

Uses
 StrUtils,
 k2Tags, k2Interfaces, k2Base,
 l3FileUtils, l3String, l3Stream, l3Date, l3Chars,
 dt_Const, dt_Types, dt_Serv, ht_Dll, dt_Hyper,
 ddHTMLWriter,
 evdTypes, evHiddenFilter, evdStyles,
 SysUtils, Forms,
 Document_Const, TextPara_Const, SegmentsLayer_Const, Hyperlink_Const, Address_Const, Sub_Const,
 ddPrimeHTMLWriter;

resourcestring
 sStartStream = '<?xml version="1.0" encoding="windows-1251"?>'#13#10'<list>'#13#10;
 sFinishStream = '</list>'#13#10;


constructor TddHTMLAnnotationFilter.Create(anOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(anOwner);
 f_Buffer:= Tk2DocumentBuffer.Create(nil);
 f_Buffer.Start;
 f_Filtered:= False;
 f_TopicList := TStringList.Create;
end;

procedure TddHTMLAnnotationFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  if not TopType[1].IsNull then // - учитываем вложенные документы
   Exit
  else
  begin
   case AtomIndex of
    k2_tiType             : f_DocType:= Value.AsInteger;
    k2_tiExternalHandle   : f_ExTopicNo:= Value.AsInteger;
    k2_tiRelExternalHandle: f_RelExTopicNo:= Value.AsInteger;
   end;{case}
  end;
 //if AtomIndex = k2_tiText then
 // Value.AsString.RTrim;
 if f_Filtered then
  f_Buffer.AddAtomEx(AtomIndex, Value)
 else
 if Generator <> nil then
  Generator.AddAtomEx(AtomIndex, Value);
end;

procedure TddHTMLAnnotationFilter.CheckBuffer(aTopicNo: Longint);
begin
 if f_Buffer.Root <> nil then
  if not f_Buffer.Root.Attr[k2_tiRelExternalHandle].IsNull then
   if f_Buffer.Root.IntA[k2_tiRelExternalHandle] <> aTopicNo then
    WriteBuffer(False);
end;

procedure TddHTMLAnnotationFilter.Cleanup;
begin
 l3Free(f_TopicList);
 f_Buffer.Finish;
 l3Free(f_Buffer);
 inherited;
end;

procedure TddHTMLAnnotationFilter.CloseStream(NeedUndo: Boolean);
begin
 WriteBuffer(False);
 if TopicListFileName <> '' then
  f_TopicList.SaveToFile(TopicListFileName);
 inherited;
end;

procedure TddHTMLAnnotationFilter.CloseStructure(NeedUndo: Bool);
  {override;}
  {-}
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  if not TopType[1].IsNull then // - учитываем вложенные документы
  begin
   inherited;
   Exit;
  end;
 if f_Filtered then
 begin
  f_Buffer.Finish(NeedUndo);
 end
 else
 if Generator <> nil then
 begin
  if CurrentType.IsKindOf(k2_typDocument) and (f_DocType = Ord(dtRelText)) then
   WriteBuffer(True);
  Generator.Finish(NeedUndo);
 end;
 inherited;
end;

procedure TddHTMLAnnotationFilter.ExtractName;
var
 l_S: AnsiString;
 l_TopicNo: Integer;
 l_Name: AnsiString;
begin
 if f_Buffer.Root <> nil then
 with f_Buffer.Root do
 begin
  if not Attr[k2_tiExternalHandle].IsNull then                                
   l_TopicNo := IntA[k2_tiExternalHandle]
  else
   l_TopicNo := -1;
  if not Attr[k2_tiName].IsNull then
   l_Name:= l3ReplaceNonReadable(PCharLenA[k2_tiName]).S
  else
  if not Attr[k2_tiShortName].IsNull then
   l_Name:= l3ReplaceNonReadable(PCharLenA[k2_tiShortName]).S
  else
   l_Name:= '';
  if l_TopicNo <> -1 then
  begin
   l_S:= Format('%d'#9'%s', [l_TopicNo, l_Name]);
   f_TopicList.Add(l_S);
  end;
 end; // f_Buffer.Root <> nil
end;

procedure TddHTMLAnnotationFilter.NewDocDetected(Sender: TObject; TopicNo: Longint; aDocPart: TddExportDocPart;
 MainGroup: ShortString);
begin
 case aDocPart of
  edpDocument: // Document - начинаем накопление. Если есть что-то накопленное, выливаем
   begin
    WriteBuffer(False);
    if (TopicNo <> f_ExTopicNo) and Assigned(f_OnNewFileName) then
     f_OnNewFileName(Format('%d.html', [TopicNo]));
    f_Filtered := True;
    f_IsAnno := False;
   end;
  edpReference: // Related  - если справка не от накопленного документа, выливаем его
   begin
    CheckBuffer(TopicNo);
    if (TopicNo <> f_RelExTopicNo) and Assigned(f_OnNewFileName) then
     f_OnNewFileName(Format('%d.html', [TopicNo]));
    f_Filtered := False;
    f_IsAnno := False;
   end;
  edpAnnotation: // Annotation - Если есть что-то накопленное, выливаем
   begin
    WriteBuffer(False);
    f_Filtered := False;
    f_IsAnno := True;
    if (TopicNo <> f_ExTopicNo) and Assigned(f_OnNewFileName) then
     f_OnNewFileName(Format('%d.html', [TopicNo]));
   end;
 end;
end;

// start class Tk2TagTerminator

procedure TddHTMLAnnotationFilter.OpenStream;
  {override;}
  {-}
begin
 inherited;
 f_ExTopicNo := 0;
 f_RelExTopicNo := 0;
 f_TopicList.Clear;
end;

procedure TddHTMLAnnotationFilter.StartChild(TypeID: Tl3VariantDef);
var
 TT, l_Type: Tk2Type;

begin
 l_Type := Tk2Type(TypeID);
 if l_Type.IsKindOf(k2_typDocument) then
  if not CurrentType.IsNull then // - учитываем вложенные документы
  begin
   inherited;
   Exit;
  end;
 inherited;
 TT:= CurrentType;
 if TT.IsKindOf(k2_typDocument) then
 begin
  f_DocType:= Ord(dtNone);
  //f_Filtered:= True;
  f_DocTag := Tk2Type(TypeID).ID;
 end; // TT.IsKindOf(k2_typDocument)
 if f_Filtered then
  f_Buffer.StartChild(TypeID)
 else
 if Generator <> nil then
 begin
  Generator.StartChild(TypeID);
  if TT.IsKindOf(k2_typDocument) then
  begin
   if not f_IsAnno then
    WriteFirstPara;
   WriteBuffer(True);
   if not f_IsAnno then
    WriteReferenceMark;
  end;
 end;
end;

procedure TddHTMLAnnotationFilter.StartTag(TagID: Long);
begin
 inherited;
 if f_Filtered then
  f_Buffer.StartTag(TagID)
 else
 if Generator <> nil then
  Generator.StartTag(TagID);
end;

procedure TddHTMLAnnotationFilter.WriteBuffer(InnerDoc: Boolean);
begin
 if (Generator <> nil) then
 begin
  if (f_Buffer.Root <> nil) and f_Buffer.Root.IsValid then
  begin
   ExtractName;
   if not InnerDoc then
    Generator.StartChild(f_Buffer.Root.TagType);
   f_Buffer.Root.WriteTag(Generator{, l3_spfAll});
   if not InnerDoc then
    Generator.Finish;
  end; // (f_Buffer.Root <> nil) and f_Buffer.Root.IsValid
 end; // (Generator <> nil)
 f_Buffer.Root := nil;
end;

procedure TddHTMLAnnotationFilter.WriteFirstPara;
begin
 Generator.AddIntegerAtom(k2_tiExternalHandle, f_ExTopicNo);
 Generator.StartChild(k2_typTextPara);
 try
  // добавить ссылку на спец.метку с номером f_ExTopicNo
  Generator.StartTag(k2_tiSegments);
  try
   Generator.StartChild(k2_typSegmentsLayer);
   try
    Generator.AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperlinks));
    Generator.StartChild(k2_typHyperlink);
    try
     Generator.AddIntegerAtom(k2_tiStart, 1);
     Generator.AddIntegerAtom(k2_tiFinish, 7);
     Generator.StartChild(k2_typAddress);
     try
      Generator.AddIntegerAtom(k2_tiDocID, f_ExTopicNo);
      Generator.AddIntegerAtom(k2_tiSubID, f_ExTopicNo);
     finally
      Generator.Finish;
     end; // idAddress
    finally
     Generator.Finish;
    end; // Hyperlink
   finally
    Generator.Finish;
   end; // SegmentsLayer
  finally
   Generator.Finish;
  end; // Segments

  Generator.AddStringAtom(k2_tiText, 'Справка');
 finally
  Generator.Finish;
 end; // TextPara
end;

procedure TddHTMLAnnotationFilter.WriteReferenceMark;
begin
 // добавить спец.метку
 Generator.StartChild(k2_typTextPara);
 try
  Generator.StartTag(k2_tiSubs);
  try
   Generator.StartChild(k2_typSub);
   try
    Generator.AddIntegerAtom(k2_tiHandle, f_ExTopicNo);
   finally
    Generator.Finish;
   end; // Sub
  finally
   Generator.Finish;
  end; // Subs
  Generator.StartTag(k2_tiFrame);
  try
   Generator.StartTag(k2_tiFrameUp);
   try
    Generator.AddIntegerAtom(k2_tiWidth, 20);
   finally
    Generator.Finish();
   end; // FrameUp
  finally
   Generator.Finish;
  end; // Frame
 finally
  Generator.Finish;
 end;
end;

constructor TddHTMLAnnotationPipe.Create(DocListFileName: AnsiString);
var
 l_HTMLGen: TddHTMLGenerator;
begin
  inherited Create;
  FPipe := TSewerPipe.Create;
  FPipe.Convert2OEM := False;
  FPipe.SpecialAnnotation := False;
  FPipe.ExportDocument := True;
  FPipe.ExportAnnotation:= False;
  FFiler := Tl3DOSFiler.Create;
  f_XMLFiler:= Tl3CustomFiler.Create(nil);
  f_XMLStream:= Tl3TempMemoryStream.Create;
  f_XMLFiler.Stream := f_XMLStream;
  f_XMLGen:= TddXMLAnnoWriter.Create;
  TddXMLAnnoWriter(f_XMLGen).Filer:= f_XMLFiler;
  FG := TddHTMLGenerator.Create;
  l_HTMLGen := TddHTMLGenerator(FG);
  l_HTMLGen.Filer := FFiler;
  l_HTMLGen.HTMLOptions := l_HTMLGen.HTMLOptions + [dd_hwoIsPrime];
  Tk2ForkGenerator.SetTo(FG, f_XMLGen);
  f_XMLGen := Tk2ForkGenerator(FG).Generator2;
  TddHTMLAnnotationFilter.SetTo(FG);
  FPipe.OnNewDocument := TddHTMLAnnotationFilter(FG).NewDocDetected;
  TddHTMLAnnotationFilter(FG).OnNewFileName := OnNewFileName;
  if DocListFileName <> '' then
  begin
   FFileName := ConcatDirName(Pipe.ExportDirectory, DocListFileName);
   TddHTMLAnnotationFilter(FG).TopicListFileName := ChangeFileExt(FFileName, '.lst');
  end
  else
  begin
   FFileName := '';
   TddHTMLAnnotationFilter(FG).TopicListFileName := '';
  end;
  //TevHiddenFilter.SetTo([Abs(ev_saANSIDOS), Abs(ev_saContents)], FG);
  TevHiddenFilter.SetTo([Abs(ev_saTechComment), Abs(ev_saTxtComment)], False, FG);
  FPipe.Writer := FG;
end;

procedure TddHTMLAnnotationPipe.Cleanup;
begin
 l3Free(FG);
 l3Free(FFiler);
 l3Free(FPipe);
 //l3Free(f_XMLGen);
 l3Free(f_XMLFiler);
 l3Free(f_XMLStream);
 inherited;
end;

function TddHTMLAnnotationPipe.Execute: Boolean;
var
 l_TempName: AnsiString;
begin
 FPipe.SpecialFiler := FFiler;
 fFiler.Mode := l3_fmWrite;
 fFiler.CodePage := cp_Ansi;
 l_TempName:= ConcatDirname(ExtractFilePath(Application.ExeName), 'can_be_deleted.txt');
 fFiler.FileName := l_TempName;
 if FNSExport then
  FPipe.ExportAnnotation:= True;
 Result := FPipe.Execute;
 FFiler.Close;
 DeleteFile(l_TempName);
 if FNSExport then
  WriteDocListFile;
end;

procedure TddHTMLAnnotationPipe.OnNewFileName(AFileName: AnsiString);
begin
 FFiler.Close;
 FFiler.FileName := ConcatDirName(Pipe.ExportDirectory, aFileName);
 FFiler.Open;
end;


procedure TddHTMLAnnotationPipe.WriteDocListFile;
var
 l_Stream, l_OldStream: TStream;
 l_LstStream: Tl3TextStream;
 l_S, l_NumS, l_Name: AnsiString;
 l_Num: Integer;
begin
 if FFileName <> '' then
 begin
  l_OldStream:= Tl3TempMemoryStream.Create;
  try
   // Прочитать файл с номерами, выяснить уникальные и записать в поток
   l_LstStream := Tl3TextStream.Create(ChangeFileExt(FFileName, '.lst'), l3_fmRead);
   try
    while not l_LstStream.IsEof do
    begin
     l_S:= l_LstStream.GetLine;
     l_NumS:= Copy(l_S, 1, Pred(Pos(#9, l_S)));
     l_Name := Copy(l_S, Succ(Pos(#9, l_S)), MaxInt);
     l_Num:= StrToIntDef(l_NumS, 0);
     if (l_Num <> 0) and (TddXMLAnnoWriter(f_XMLGen).TopicList.IndexOf(l_Num) = -1) then
     begin
      l_S := Format('<items ID="%d" YEAR="%d">'#13#10+
                    '<TOPIC><![CDATA[%s]]></TOPIC>'#13#10+
                    '<TEXT></TEXT>'#13#10+
                    '</items>'#13#10, [l_Num, CurrentYear, l_Name]);
      l_OldStream.write(l_S[1], Length(l_S));
     end;
    end; // while not l_LstStream.IsEof
   finally
    l3Free(l_LstStream);
   end;
   DeleteFile(ChangeFileExt(FFileName, '.lst'));
   if FileExists(FFileName) then
   begin
    l_Stream := Tl3FileStream.Create(FFileName, l3_fmRead);
    try
      l_Stream.Seek(Length(sStartStream), soFromBeginning);
      l_OldStream.CopyFrom(l_Stream, l_Stream.Size-Length(SFinishStream)-Length(sStartStream));
      f_XMLStream.Seek(0, 0);
      l_OldStream.CopyFrom(f_XMLStream, f_XMLStream.Size);
    finally
     l3Free(l_Stream);
    end;
   end;
   l_Stream := Tl3FileStream.Create(FFileName, l3_fmWrite);
   try
    l_Stream.Write(sStartStream[1], Length(sStartStream));
    l_OldStream.Seek(0, 0);
    l_Stream.CopyFrom(l_OldStream, l_OldStream.Size);
    l_Stream.Write(SFinishStream[1], Length(SFinishStream));
   finally
    l3Free(l_Stream);
   end;
  finally
   l3Free(l_OldStream);
  end;
 end; // FFileName <> ''
end;

constructor TddHTMLAnnotationPipe1.Create(DocListFileName: AnsiString);
begin
  inherited Create;
  FPipe := TSewerPipe.Create;
  FPipe.Convert2OEM := False;
  FPipe.SpecialAnnotation := False;
  FPipe.ExportDocument := False;
  FPipe.ExportAnnotation:= True;
  FFiler := Tl3DOSFiler.Create;
  FG := nil;
//TddAnnoNameExtractor.SetTo(FG);
//TddAnnoNameExtractor(FG).OnAnnoNameFound:= AnnoNameFound;
  TddPrimeHTMLWriter.SetTo(FG);
  TddPrimeHTMLWriter(FG).Filer := FFiler;
  TddPrimeHTMLWriter(FG).OnAnnoNameFound:= AnnoNameFound;
  TddPrimeHTMLWriter(FG).IsPrime := True;
  TevHiddenFilter.SetTo([Abs(ev_saTechComment), Abs(ev_saTxtComment)], False, FG);
  FPipe.OnNewDocument := NewDocDetected;
  FPipe.Writer := FG;
end;

procedure TddHTMLAnnotationPipe1.AnnoNameFound(aDocID: Integer; const aName: AnsiString);
var
 i: Integer;
 l_StrID: AnsiString;
 l_Found: Boolean;
begin
 l_StrID:= IntToStr(aDocID);
 l_Found:= False;
 for i:= 0 to Pred(f_NamesList.Count) do
  if AnsiStartsStr(l_StrID, f_NamesList[i]) and not AnsiContainsStr(f_NamesList[i], '<<<>>>') then
  begin
   f_NamesList[i]:= f_NamesList[i] + '<<<>>>' + aName;
   l_Found:= True;
   break;
  end;
 if not l_Found then
  // Документа нет в списке, нужно сохранить название аннотации на будущее
  f_MissedNamesList.Add(l_StrID + '=' + aName);
end;

procedure TddHTMLAnnotationPipe1.Cleanup;
begin
 l3Free(FG);
 l3Free(FFiler);
 l3Free(FPipe);
 inherited;
end;

function TddHTMLAnnotationPipe1.Execute: Boolean;
var
 l_TempName: AnsiString;
begin
 FPipe.SpecialFiler := FFiler;
 fFiler.Mode := l3_fmWrite;
 fFiler.CodePage := cp_Ansi;
 l_TempName:= ConcatDirname(ExtractFilePath(Application.ExeName), 'can_be_deleted.txt');
 fFiler.FileName := l_TempName;
 FPipe.ExportAnnotation:= True;
 Result := FPipe.Execute;
 FFiler.Close;
 DeleteFile(l_TempName);
end;

procedure TddHTMLAnnotationPipe1.NewDocDetected(Sender: TObject; TopicNo: Longint; aDocPart: TddExportDocPart;
    MainGroup: ShortString);
begin
 if aDocPart = edpAnnotation then
 begin
  FFiler.Close;
  FFiler.FileName := ConcatDirName(Pipe.ExportDirectory, Format('%d_head.html', [TopicNo]));
  FFiler.Open;
 end;
end;





end.