//..........................................................................................................................................................................................................................................................
Unit ddNSRCPipeBend;

{ $Id: ddNSRCPipeBend.pas,v 1.58 2015/07/02 07:36:05 lukyanets Exp $ }

// $Log: ddNSRCPipeBend.pas,v $
// Revision 1.58  2015/07/02 07:36:05  lukyanets
// Описываем словари
//
// Revision 1.57  2014/05/27 07:29:53  fireton
// - принудительно приводим блокнейм к OEM для objtopic'ов
//
// Revision 1.56  2014/03/28 06:13:17  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.55  2014/03/04 14:44:09  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.54  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.53  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.52  2013/10/18 15:39:01  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.51  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.50  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.49  2010/02/25 13:48:31  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.48  2010/02/24 18:34:47  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.47  2009/07/23 08:15:11  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.46  2009/04/09 15:08:19  lulin
// [$140280550]. Выкидываем мусор.
//
// Revision 1.45  2009/03/04 16:25:56  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.44  2008/06/23 08:27:57  narry
// - не собиралось
//
// Revision 1.43  2007/08/09 18:05:21  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.42  2007/08/09 17:17:05  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.41  2007/08/09 11:19:17  lulin
// - cleanup.
//
// Revision 1.40  2007/04/25 09:30:55  fireton
// - Рефакторинг DT. Все типы переехали в DT_Types, а константы - в DT_Const
//
// Revision 1.39  2005/07/14 15:52:51  narry
// - bug fix: путаница имен и групп доступа
//
// Revision 1.38  2005/06/02 14:27:00  narry
// - bug fix: в исходный документ не добовлялся специальный абзац
//
// Revision 1.37  2005/05/12 08:57:38  narry
// - bug fix: дублирование объектных топиков для вложенных блоков
//
// Revision 1.36  2005/05/04 14:13:33  narry
// - bug fix: Main попадал в Belongs
//
// Revision 1.35  2005/04/28 12:58:28  narry
// - update
//
// Revision 1.34  2005/04/26 09:17:39  narry
// - cleanup: избавление от лишнего объекта
//
// Revision 1.33  2005/04/14 14:11:52  narry
// - bug fix: грязь в группах документов
//
// Revision 1.32  2005/03/28 14:37:56  narry
// - update:
//
// Revision 1.31  2005/03/28 11:32:17  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.30  2005/03/24 09:51:19  narry
// - bug fix: выливалась лишняя команда OBJTOPIC при отсутствии у документа BELONGS
//
// Revision 1.29  2005/03/23 11:38:10  narry
// - bug fix: Неправильный BELONGS
//
// Revision 1.28  2005/03/23 11:01:49  narry
// - логирование исключения
//
// Revision 1.27  2005/03/22 14:05:53  narry
// - bug fix: AV
//
// Revision 1.26  2005/03/22 09:11:42  narry
// - не компилировалось
//
// Revision 1.25  2005/03/21 17:02:27  lulin
// - используем правильный тип описателя свойства.
//
// Revision 1.24  2005/03/21 12:47:32  narry
// - bug fix: один тип для всех блоков документа, очистка списка
//
// Revision 1.23  2005/03/21 10:04:55  lulin
// - new interface: _Ik2Type.
//
// Revision 1.22  2005/03/18 16:24:55  narry
// - update: динамический список внешних объектов
//
// Revision 1.21  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.20  2004/11/05 14:34:41  narry
// - bug fix: один BELONGS для всех OBJTOPICов выборки
//
// Revision 1.19  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.18  2004/09/14 15:58:03  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.17  2004/09/13 14:21:49  lulin
// - избавился от зависимости от RX.
//
// Revision 1.16  2004/06/04 09:28:47  narry
// - update: запись !CONTENTS  с нулем
// - update: различные типы objtopic
//
// Revision 1.15  2004/06/02 16:42:32  law
// - удален класс Tl3VList.
//
// Revision 1.14  2004/06/02 15:19:23  narry
// - bug fix: ошибка создания файла comment.txt
//
// Revision 1.13  2004/06/01 14:10:50  narry
// - update: расширение списка параметров задания на экспорт
//
// Revision 1.12  2004/05/14 16:58:35  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.11  2004/05/14 14:48:50  law
// - исправлены префиксы у констант.
//
// Revision 1.10  2004/05/14 14:28:54  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.9  2004/04/15 14:38:39  narry
// - new property: _OneStep - генерация внешних форматов в один проход
//
// Revision 1.8  2003/12/02 08:18:24  voba
// no message
//
// Revision 1.7  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.6  2002/09/18 08:06:12  voba
// - cleanup: удален параметр IsDefault.
//
// Revision 1.5  2002/04/27 14:22:27  narry
// - bug fix: перезаписывание objtopic
//
// Revision 1.4  2002/04/16 16:27:58  narry
// - bug fix: не закрывались файлы с ObjTopic и комментарием
//
// Revision 1.3  2002/01/22 12:53:27  narry
// - bug fix: выливался BELONGS KSE в OBJTOPIC
//
// Revision 1.2  2001/09/04 13:58:59  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.1  2001/05/07 10:45:15  narry
// First upload - изменено имя модуля
//
// Revision 1.38  2001/04/27 07:52:44  narry
// Update - добавлен метод CloseStream
//
// Revision 1.37  2001/03/28 13:46:02  narry
// Добавлен флажок, управляющий выливкой RTF файл
//
// Revision 1.36  2001/03/14 13:24:53  law
// - some cleaup and tuning.
//
// Revision 1.35  2001/03/05 14:34:59  narry
// Add empty paragraph after rtf-block
//
// Revision 1.34  2001/02/05 13:41:28  narry
// Coding for Block Name
//
// Revision 1.33  2000/12/19 16:05:18  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.32  2000/12/19 15:06:26  law
// - #13#10 -> cc_EOL.
//
// Revision 1.31  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$Include ddDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Filer,
  l3Variant,

  k2Types,
  k2TagGen,
  k2TagFilter,
  k2Prim,

  ddRTFwriter, ddExternalObjects,

  daTypes,
  dt_Types,
  dt_AttrSchema
  ;

type
  TddPipeBend = class(Tk2TagFilter)
  private
    FExternalObj: TddExternalObject;
    FObjTopicFilename: AnsiString;
    f_ObjFiler: TevDOSFiler;
    f_AdditionalFile: TevDOSFiler;
    f_ExportDir: AnsiString;
    f_DictRecType: TdaDictionaryType;
    f_Belongs: Tl3String;
    f_BlockName: Tl3String;
    f_BlockNo: Integer;
    f_ExtNum: Integer;
    f_ParagraphAdded: Boolean;
    f_SubDir : AnsiString;
    f_SeparateFiles: Boolean;
    f_WriteRTFBody : Boolean;
    procedure CheckBlockName;
    function GetBlockType: Integer;
    function RTFFileName: AnsiString;
    procedure SetBlockType(const Value: Integer);
    procedure WriteAdditionalFile;
    procedure WriteName(aName: AnsiString);
    procedure AddSpecialParagraph;
  protected
    procedure Cleanup; override;
    procedure CloseStructure(NeedUndo: Bool); override;
    property BlockType: Integer read GetBlockType write SetBlockType;
  public
    constructor Create(anOwner: Tk2TagGeneratorOwner); override;

    procedure StartChild(TypeID: Tl3VariantDef); override;
      {-}
    procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
      {-}
    property ExportDir: AnsiString
      read f_ExportDir
      write f_ExportDir;
    property ObjTopicFilename: AnsiString
      read FObjTopicFilename
      write FObjTopicFilename;
    property SeparateFiles: Boolean
      read f_SeparateFiles
      write f_SeparateFiles;
    property WriteRTFBody : Boolean
      read f_WriteRTFBody
      write f_WriteRTFBody;
  end;

implementation

uses
  SysUtils,
  l3Stream, l3Bits, l3Chars, l3FileUtils,
  k2Interfaces,
  k2Tags,
  k2Base,
  {evdSegmentsListConst,} evdStyles,
  ddNSRC_w
  , evdTypes,

  TextPara_Const,
  Document_Const,
  Block_Const,
  DictRec_const,
  SegmentsLayer_Const,
  Hyperlink_Const,
  Address_Const
  ;


{  TddPipeBend }

constructor TddPipeBend.Create(anOwner: Tk2TagGeneratorOwner);
begin
  inherited;
  f_Belongs:= Tl3String.Create;
  f_ObjFiler:= TevDOSFiler.Create(nil);
  f_WriteRTFBody:= False;
end;

procedure TddPipeBend.Cleanup;
begin
  l3Free(f_Belongs);
  l3Free(f_ObjFiler);
  inherited;
end;


procedure TddPipeBend.StartChild(TypeID: Tl3VariantDef);
var
 l_Type : Tk2Type;
begin
 l_Type := Tk2Type(TypeID);
 if l_Type.IsKindOf(k2_typTextPara) then
 begin
  if (f_ExtNum > 0) then
   AddSpecialParagraph;
 end;
  inherited;
  if CurrentType.IsKindOf(k2_typDocument) then
  begin
   if TopType[1] <> nil then
   // - учитываем вложенные документы
    Exit;
   f_Belongs.Clear;
  end
  else
  if CurrentType.IsKindOf(k2_typBlock) then
  begin
   if (f_ExtNum > 0) then
   begin
    AddSpecialParagraph;
    WriteAdditionalFile;
   end; // f_ExtNum > 0
   f_BlockNo := 0;
   BlockType := 0;
   f_ExtNum := -1;
   f_ParagraphAdded := False;
  end;
  If CurrentType.IsKindOf(k2_typDictRec) and (TopObject[1].isProp) then
  Begin
   if TopObject[1].AsProp.TagIndex = k2_tiGroups then
    if f_DictRecType <> da_dlBases then
    begin
     f_Belongs.Clear;
     f_DictRecType:= da_dlBases;
    end;
  end;
end;
  {-}

procedure TddPipeBend.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
  i: Integer;
begin
  inherited;
  if CurrentType.IsKindOf(k2_typDocument) then
  begin
   if TopType[1] <> nil then // - учитываем вложенные документы
    Exit;
   if (AtomIndex = k2_tiExternalHandle) then
    f_SubDir:= IntToStr(Value.AsInteger)
  end
  else
  if CurrentType.IsKindOf(k2_typBlock) and not CurrentType.IsKindOf(k2_typDocument) then
  begin
   case AtomIndex of
    k2_tiHandle : f_BlockNo:= Value.AsInteger;
    k2_tiType   : BlockType:= Value.AsInteger;
    k2_tiExternalHandle : f_ExtNum:= Value.AsInteger;
    k2_tiShortName   :
     begin
      if f_BlockName <> nil then
       l3Free(f_BlockName);
      f_BlockName:= Tl3String.Make(Tl3String(Value.AsString));
     end;
   end;
  end
  else
  If CurrentType.IsKindOf(k2_typDictRec) and not CurrentType.IsKindOf(k2_typBlock) and
     not CurrentType.IsKindOf(k2_typDocument) then {заполнение записи: элемент словаря}
  Begin
    If (AtomIndex = k2_tiShortName) and ((TopObject[1].IsProp) and
    (TopObject[1].AsProp.TagIndex = k2_tiGroups)) then
     If (Value.Kind=k2_vkString) then
     begin
      if (f_DictRecType = da_dlBases) and (Value.AsString.AsString <> 'KSE') then
      begin
       if not f_Belongs.Empty then
        f_Belongs.Append('\');
       f_Belongs.JoinWith(Value.AsString);
      end;
     end
     else
      ConvertErrorEx(Value.Kind);
  end;
end;

procedure TddPipeBend.CheckBlockName;
begin
 if f_BlockName = nil then
 begin
  f_BlockName:= Tl3String.Create;
  f_BlockName.AsString:= Format('Блок N %d', [f_ExtNum]);
  f_BlockName.CodePage:= cp_OEM;
 end; // f_BlockName = nil
end;


procedure TddPipeBend.CloseStructure(NeedUndo: Bool);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  if TopType[1] <> nil then // - учитываем вложенные документы
   Exit;
  if (f_ExtNum <> -1) and CurrentType.IsKindOf(k2_typBlock)
     and not CurrentType.IsKindOf(k2_typDocument) then
  begin
   AddSpecialParagraph;
   WriteAdditionalFile;
   f_ExtNum := -1;
   l3Free(f_BlockName);
  end;
 if CurrentType.IsKindOf(k2_typBlock) and not CurrentType.IsKindOf(k2_typDocument) then
  l3Free(f_BlockName);
 inherited;
end;

function TddPipeBend.GetBlockType: Integer;
begin
  Result := FExternalObj.Handle
end;

function TddPipeBend.RTFFileName: AnsiString;
begin
  Result := Format('%d.%s', [f_ExtNum, FExternalObj.TypeExtension]);
end;

procedure TddPipeBend.SetBlockType(const Value: Integer);
begin
 FExternalObj := ExtObjManager.Objects[Value];
end;

procedure TddPipeBend.WriteAdditionalFile;
var
 S: Tl3String;
 St, St2 : AnsiString;
begin
 S:= Tl3String.Create;
 try
  S.CodePage:= cp_OEM;
  try
   if not f_ObjFiler.Opened then
   begin
    f_ObjFiler.FileName:= ConcatDirName(ExportDir, ObjTopicFileName);
    f_ObjFiler.Mode:= l3_fmAppend;
    f_ObjFiler.CodePage:= cp_OEM;
    f_ObjFiler.Open;
   end; // not f_ObjFiler.Opened

   S.AsString:= Format(';!BLOCK %d'+cc_EOL, [f_BlockNo]);
   f_ObjFiler.Write(S);

   CheckBlockName;
   f_BlockName.CodePage:= cp_OEM; // принудительно приводим к OEM
   st2 := f_BlockName.AsString;

   f_BlockName.CodePage:= cp_Ansi;
   f_BlockName.MakeUpper;
   f_BlockName.CodePage:= cp_OEM;

   if f_BlockName.Len > 70 then
    St:= System.Copy(f_BlockName.AsString, 1, 70)+'...'
   else
    St:= f_BlockName.AsString;
   S.AsString:= Format('!OBJTOPIC %d %s'+cc_EOL, [f_ExtNum, St]);
   f_ObjFiler.Write(S);
   WriteName(st2);
   if not f_Belongs.Empty then
   begin
    S.AsString:= Format('!BELONGS %s'+cc_EOL, [f_Belongs.AsString]);
    f_ObjFiler.Write(S);
   end; // not f_Belongs.Empty
   S.AsString:= SysUtils.Format('!OBJTYPE %s'+cc_EOL, [FExternalObj.TypeExtension]);
   f_ObjFiler.Write(S);
   S.AsString:= Format('!OBJPATH %s'+cc_EOL+cc_EOL, [ConcatDirName(f_SubDir, RTFFileName)]);
   f_ObjFiler.Write(S);

   f_ObjFiler.Close;
   f_AdditionalFile.Close;
  except
   on E: Exception do
   begin
    l3System.msg2Log('Ошибка выливки файла с объектными топиками');
    l3System.Exception2Log(E);
   end;
  end;{ Filer }
 finally
  l3Free(S);
 end;
end;

procedure TddPipeBend.WriteName(aName: AnsiString);
var
  S: AnsiString;
  i,j: Integer;
begin
 if aName = '' then
  exit;
 i:= 1;
 s:= '';
 j:= 0;
 if Length(aName) > 73 then
  while i < Length(aName) do
  begin
   while (j <= 73) and (i <= Length(aName)) do
   begin
    S:= S + aName[i];
    inc(i); inc(j);
   end; // while (j <= 73) and (i <= Length(aName))

   if (i < Length(aName)) and (aName[i] <> ' ') then
   begin
    while (S[Length(S)] <> ' ') do
    begin
     dec(i);
     Delete(s, length(S), 1);
    end;
    end
    else
     inc(i);
    f_ObjFiler.Write(Format('!NAME %s'+cc_EOL, [S]));
    S:= '';
    j:= 0;
   end
 else
  f_ObjFiler.Write(Format('!NAME %s'+cc_EOL, [aName]));
end;


procedure TddPipeBend.AddSpecialParagraph;
begin
 if not f_ParagraphAdded then
 begin
  f_ParagraphAdded := True;
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddBoolAtom(k2_tiVisible, False);
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtComment);
   { Сгенерить ссылки }
   Generator.StartTag(k2_tiSegments);
   try
    Generator.StartChild(k2_typSegmentsLayer);
    try
     Generator.AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperlinks));
     Generator.StartChild(k2_typHyperlink);
     try
      Generator.AddIntegerAtom(k2_tiHandle, 1); {<-- Это все на всякий случай }
      Generator.AddIntegerAtom(k2_tiStart, 12); // некрасиво, конечно, но что делать...
      Generator.AddIntegerAtom(k2_tiFinish, 16);
      Generator.StartChild(k2_typAddress);
      try
       Generator.AddIntegerAtom(k2_tiDocID, f_ExtNum);
      finally
       Generator.Finish;
      end; { k2_idAddress}
     finally
      Generator.Finish;
     end; { k2_Hyperlink }
    finally
     Generator.Finish;
    end; { k2_idSegmentsLayer }
   finally
    Generator.Finish;
   end; { k2_tiSegments }
   Generator.AddStringAtom(k2_tiText, FExternalObj.FullSeeAlsoText);
  finally
    Generator.Finish;
  end; { k2_idTextPara }
  Generator.StartChild(k2_typTextPara);
  Generator.Finish;
 end; // not Added
end;

end.
