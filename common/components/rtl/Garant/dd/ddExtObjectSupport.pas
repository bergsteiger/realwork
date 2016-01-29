unit ddExtObjectSupport;
{* Читает/пишет содержимое объектов из/в хранилища }

{ $Id: ddExtObjectSupport.pas,v 1.23 2015/03/13 11:55:47 voba Exp $ }

// $Log: ddExtObjectSupport.pas,v $
// Revision 1.23  2015/03/13 11:55:47  voba
// - локальное автосохранение документов
//
// Revision 1.22  2014/04/09 14:19:33  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.21  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.20  2014/04/07 06:53:33  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.19  2014/04/04 06:58:30  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.18  2014/02/18 11:33:20  lulin
// {RequestLink:517479550}
//
// Revision 1.17  2013/11/08 07:57:29  fireton
// - не экспортировался объектный топик из EVD-потока
//
// Revision 1.16  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.14  2013/10/18 15:39:01  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.13  2013/02/20 09:22:39  dinishev
// {Requestlink:431360596}
//
// Revision 1.12  2011/10/05 11:16:48  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.11  2011/01/13 12:32:15  narry
// K250086012: записывался неправильный InternalHandle
//
// Revision 1.10  2011/01/13 11:58:49  narry
// K250086012: записывался неправильный InternalHandle
//
// Revision 1.9  2011/01/13 11:13:36  narry
// K250086012: Запрет чтения данных из документа 0
//
// Revision 1.8  2011/01/13 11:08:21  narry
// K250086012: Запрет записи данных в документ 0, получение номера документа в SetTo
//
// Revision 1.7  2009/09/07 10:17:46  voba
// - opt. Убрали ненужную буфферизацию бинарных данных
//
// Revision 1.6  2009/09/02 14:31:33  lulin
// {RequestLink:161122154}.
//
// Revision 1.5  2009/07/07 09:09:45  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.4  2009/06/25 07:49:50  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.3  2009/03/04 16:25:56  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.2  2008/05/08 14:04:08  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.1.2.10  2008/03/14 15:21:56  fireton
// - _Ik2RawData: IsStreamModified -> IsModified
//
// Revision 1.1.2.9  2008/03/14 11:31:01  lulin
// - <K>: 87196160.
//
// Revision 1.1.2.8  2008/03/14 09:35:06  fireton
// - выносим proxy поток в отдельный модуль
// - пытаемся избавиться от повторной прогрузки и перезаписи прокси
//
// Revision 1.1.2.7  2008/03/12 16:11:02  fireton
// MERGE с HEAD
//
// Revision 1.1.2.6  2007/09/26 06:05:36  fireton
// - починен импорт и экспорт embedded объектов
//
// Revision 1.1.2.5  2007/09/19 15:28:26  fireton
// - экспорт документов со встроенными объектами
//
// Revision 1.1.2.4  2007/09/17 14:58:18  fireton
// - поломан импорт/экспорт объектов (промежуточное сохранение)
//
// Revision 1.1.2.3  2007/03/09 12:43:16  narry
// - промежуточное обновление
//
// Revision 1.1.2.2  2007/03/06 10:10:22  narry
// - промежуточное обновление
//
// Revision 1.1.2.1  2007/03/02 12:31:20  narry
// - промежуточное обновление
//

interface
Uses
 l3Types,
 k2FileGenerator, k2Tags, k2Types, k2TagFilter, k2Interfaces,
 evdBufferedFilter,
 Classes, k2Reader, k2TagGen;

type
 // базовый объект для обработки объектов в документах
 TddExtObjectMachine = class(TevdBufferedFilter)
 private
  f_DocID: Integer;
 protected
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator{; aDocID: Integer}): Pointer; overload;
  //property DocID: Integer read f_DocID write f_DocID;
 end;

 // вставляет в EVD-поток объект из потока хранилища
 TddExtObjInserter = class(TddExtObjectMachine)
 protected
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
 end;

 // выковыривает объект из EVD-потока и кладет его в поток хранилища
 TddExtObjExtractor = class(TddExtObjectMachine)
 protected
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 end;

 {ddImageHandleInsert

 }

implementation
Uses
 SysUtils,

 l3Base,
 {$IFDEF nsTest}
 l3BaseStream,
 {$ENDIF nsTest} 
 l3Stream,
 l3Filer,

 k2Base,

 m3StorageInterfaces,

 dt_Const,
 dt_Serv,

 Document_Const,
 ExtDataPara_Const,
 BitmapPara_Const
 ;

procedure TddExtObjectMachine.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  {override;}
  {-}
begin
 if (AtomIndex = k2_tiInternalHandle) and CurrentType.IsKindOf(k2_typDocument) then
  f_DocID := Value.AsInteger;
 inherited;
end;

function TddExtObjectMachine.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
begin
 Result := (aTagID = -k2_idExtDataPara) or (aTagID = -k2_idBitmapPara);
end;

function TddExtObjectMachine.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := (aID = -k2_idExtDataPara) or (aID = -k2_idBitmapPara);
end;

class function TddExtObjectMachine.SetTo(var theGenerator: Tk2TagGenerator{; aDocID: Integer}):
    Pointer;
  {-}
var
 l_Filter : TddExtObjectMachine;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  //l_Filter.DocID:= aDocID;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TddExtObjInserter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
// l_Prop : Tk2CustomPropertyPrim;
 l_Index: Integer;
 l_IStr : IStream;
 l_TStr : TStream;
begin
 assert(f_DocID <> 0);
 if not aLeaf.Attr[k2_tiData].IsValid then // если данные находятся в потоке хранилища, а не в EVD
 begin
  l_Index := aLeaf.IntA[k2_tiInternalHandle]; // Это порядковый номер картинки в документе
  l_IStr := dtGetObjectStream(CurrentFamily, f_DocId, l_Index, m3_saRead);
  try
   l3IStream2Stream(l_IStr, l_TStr);
   try
    Assert(aTagId < 0);
    Generator.StartChild(TypeTable.TypeByHandle[-aTagId]);
    try
     aLeaf.AsObject.WriteTag(Generator);
     {$IfDef nsTest}
     Dec(g_IStreamCopyTo_Guard);
     try
     {$EndIf nsTest}
     Generator.AddStreamAtom(k2_tiData, l_TStr);
     {$IfDef nsTest}
     finally
      Inc(g_IStreamCopyTo_Guard);
     end;
     {$EndIf nsTest}
     Exit;
    finally
     if aNeedCloseBracket then
      Generator.Finish;
    end;//try..finally
   finally
    l3Free(l_TStr);
   end;//try..finally
  finally
   l_IStr := nil;
  end;//try..finally
 end;// then // если данные находятся в потоке хранилища, а не в EVD
 inherited;
end;


procedure TddExtObjExtractor.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_Index          : Integer;
 l_SStr           : IStream;
 l_EVDStr         : IStream;
 l_Proxy          : Ik2RawData;
 T1, T2           : Int64;
 l_NeedSaveObject : Boolean;
 l_Leaf           : Tl3Variant;
begin
 if (AtomIndex = k2_tiData) {and (f_DocID <> 0)} then
  if (SkipLevel = 2) then
  begin
   assert(f_DocID <> 0);
   Assert(Value.Kind = k2_vkStream);
   l_EVDStr := l3Stream2IStream(Value.AsStream);
   try
    l_NeedSaveObject := True;
    if Supports(l_EVDStr, Ik2RawData, l_Proxy) then
    try
     l_NeedSaveObject := l_Proxy.IsModified;
    finally
     l_Proxy := nil;
    end;//try..finally
    if l_NeedSaveObject then
    begin
     l_Leaf := f_Buffer.Tags.Top.Box;
     if not l_Leaf.Attr[k2_tiInternalHandle].IsValid then
      l_Index := -1 // будет назначен новый свободный
     else
      l_Index := l_Leaf.IntA[k2_tiInternalHandle];
     l_SStr := dtGetObjectStream(CurrentFamily, f_DocId, l_Index, m3_saCreate);
     try
      l_Leaf.IntW[k2_tiInternalHandle, Context] := l_Index; // а вдруг поменялся (был назначен новый)
      l_EVDStr.CopyTo(l_SStr, MaxInt, T1, T2)
     finally
      l_SStr := nil;
     end;//try..finally
    end;//l_NeedSaveObject
   finally
    l_EVDStr := nil;
   end;//try..finally
   StopBufferingAndFlush(false, TopObject[0], false);
   Exit;
  end;//SkipLevel = 2
 inherited;
end;

procedure TddExtObjExtractor.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
(*var
 l_Index: Integer;
 l_SStr   : IStream;
 l_EVDStr : IStream;
 l_Proxy  : Ik2RawData;
 T1, T2: Int64;
 l_NeedSaveObject: Boolean;*)
begin
(* if aLeaf.Attr[k2_tiData].IsStream(l_EVDStr) then
 try
  l_NeedSaveObject := True;
  if Supports(l_EVDStr, Ik2RawData, l_Proxy) then
  try
   l_NeedSaveObject := l_Proxy.IsModified;
  finally
   l_Proxy := nil;
  end;

  if l_NeedSaveObject then
  begin
   if not aLeaf.Attr[k2_tiInternalHandle].IsValid then
    l_Index := -1 // будет назначен новый свободный
   else
    l_Index := aLeaf.IntA[k2_tiInternalHandle];
   l_SStr := dtGetObjectStream(CurrentFamily, f_DocId, l_Index, m3_saCreate);
   try
    aLeaf.IntW[k2_tiInternalHandle, Context] := l_Index; // а вдруг поменялся (был назначен новый)
    l_EVDStr.CopyTo(l_SStr, MaxInt, T1, T2)
   finally
    l_SStr := nil;
   end;
  end;

 finally
  l_EVDStr := nil;
 end;

 aLeaf.AttrW[k2_tiData, Context] := nil;
*)
 inherited;
end;

end.
