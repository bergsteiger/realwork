unit evTextParaPartFilter;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evTextParaPartFilter - }
{ Начат: 16.03.2004 14:21 }
{ $Id: evTextParaPartFilter.pas,v 1.39 2014/04/11 15:30:29 lulin Exp $ }

// $Log: evTextParaPartFilter.pas,v $
// Revision 1.39  2014/04/11 15:30:29  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.38  2014/04/09 14:19:24  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.37  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.36  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.35  2014/03/27 14:19:58  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.34  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.33  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.32  2013/10/18 14:11:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.31  2009/06/02 17:23:16  lulin
// - удалены ненужные интерфейсы и переопределения типов.
//
// Revision 1.30  2009/03/04 13:32:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.29  2009/02/26 10:22:17  lulin
// - <K>: 137465982. №1
//
// Revision 1.27  2008/02/19 14:58:43  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.26  2008/02/05 12:49:10  lulin
// - упрощаем базовые объекты.
//
// Revision 1.25  2007/12/04 12:47:06  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.17.4.11  2007/09/14 13:26:07  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.17.4.10.2.1  2007/09/12 16:14:08  lulin
// - убран ненужный параметр по-умолчанию.
//
// Revision 1.17.4.10  2007/08/10 18:27:16  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.17.4.9  2007/08/09 12:38:15  lulin
// - убираем замороченную логику с присвоением таблицы тегов.
//
// Revision 1.17.4.8  2007/08/09 11:19:13  lulin
// - cleanup.
//
// Revision 1.17.4.7  2005/10/18 07:19:40  lulin
// - new behavior: теперь методы вставки и добавления дочерних тегов могут подменять вставляемые теги.
//
// Revision 1.17.4.6  2005/09/15 15:17:59  lulin
// - bug fix: в документе в виде дерева в буфур обмена не забирались абзацы нецеликом.
//
// Revision 1.17.4.5  2005/09/14 12:12:54  lulin
// - bug fix: часть строчки в кодировке Unicode неправильно забиралась в Clipboard.
//
// Revision 1.17.4.4  2005/06/22 17:53:03  lulin
// - типы переименованы в соответствии с названием библиотеки.
//
// Revision 1.17.4.3  2005/06/22 17:34:09  lulin
// - генератор документа в памяти перенесен в "правильную" библиотеку.
//
// Revision 1.17.4.2  2005/05/18 15:53:54  lulin
// - объединил с HEAD.
//
// Revision 1.17.4.1  2005/05/18 12:42:48  lulin
// - отвел новую ветку.
//
// Revision 1.15.2.2  2005/05/18 12:32:10  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.15.2.1  2005/04/28 09:18:30  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.16.2.1  2005/04/21 15:36:40  lulin
// - окончательно избавился от необходимости обертки.
//
// Revision 1.16  2005/04/20 14:19:44  lulin
// - убираем прямое обращение к тегу.
//
// Revision 1.18  2005/05/18 15:24:02  lulin
// - cleanup.
//
// Revision 1.17  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.16.2.1  2005/04/21 15:36:40  lulin
// - окончательно избавился от необходимости обертки.
//
// Revision 1.16  2005/04/20 14:19:44  lulin
// - убираем прямое обращение к тегу.
//
// Revision 1.15  2005/03/30 17:39:29  lulin
// - исправлен префикс у типов.
//
// Revision 1.14  2005/03/30 10:14:53  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.13  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.12  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.11  2005/03/21 10:04:50  lulin
// - new interface: _Ik2Type.
//
// Revision 1.10  2005/03/18 16:11:22  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.9  2005/03/16 19:21:53  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.8  2004/06/09 09:53:36  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.7  2004/05/14 16:58:27  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.6  2004/05/14 15:16:53  law
// - remove unit: evTypesE.
//
// Revision 1.5  2004/05/14 14:48:47  law
// - исправлены префиксы у констант.
//
// Revision 1.4  2004/05/14 14:08:50  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.3  2004/03/16 14:42:17  law
// - new behavior: сохраняем кусочки параграфа при мультивыделении (! пока дла не первого кусочка, не сохраняется оформление!).
//
// Revision 1.2  2004/03/16 12:41:54  law
// - new method: TevTextParaPartFilter._WriteAtom.
//
// Revision 1.1  2004/03/16 11:49:07  law
// - new unit: evTextParaPartFilter.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Variant,

  k2BaseTypes,
  k2Types,
  k2Tags,
  k2Interfaces,
  k2TagGen,
  k2TagTerminator,
  k2DocumentGenerator,

  nevTools
  ;

type
  TevTextParaPartFilter = class(Tk2TagTerminator)
    private
    // internal fields
      f_Sel           : TevPair;
      f_SelOffset     : Long;
      f_SideGenerator : Tk2DocumentGenerator;
    protected
    // internal methods
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-вызывается на закрывающуюся скобку}
      function DoFinishAtom(G        : Tk2DocumentGenerator;
                            var Atom : Tk2StackAtom): Bool;
        {-}
    public
    // public methods
      constructor Create(const aSel : TevPair;
                         aSelOffset : Long = 0);
        reintroduce;                 
        {-}
      class procedure WriteAtom(const aGen      : Ik2TagGenerator;
                                anAtom    : Tl3Variant;
                                const aSel      : TevPair;
                                aFlags          : Tk2StorePropertyFlags = l3_spfAll;
                                const anExclude : TByteSet = [k2_tiSubs];
                                aSelOffset      : Long = 0);
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
  end;//TevTextParaPartFilter

implementation

uses
  l3Interfaces,
  l3Base,
  l3String,

  k2Base,

  Segment_Const
  ;

// start class TevTextParaPartFilter

constructor TevTextParaPartFilter.Create(const aSel : TevPair;
                                         aSelOffset : Long = 0);
  {-}
begin
 inherited Create;
 f_Sel := aSel;
 f_SelOffset := aSelOffset;
end;

class procedure TevTextParaPartFilter.WriteAtom(const aGen      : Ik2TagGenerator;
                                                anAtom    : Tl3Variant;
                                                const aSel      : TevPair;
                                                aFlags          : Tk2StorePropertyFlags = l3_spfAll;
                                                const anExclude : TByteSet = [k2_tiSubs];
                                                aSelOffset      : Long = 0);
  {-}
var  
 l_TPPF : TevTextParaPartFilter;
begin
 l_TPPF := Create(aSel, aSelOffset);
 {-создаем фильтр учитывающий изменение системы координат}
 try
  l_TPPF.Start;
  try
   l_TPPF.Generator := aGen;
   try
    anAtom.WriteTag(l_TPPF, aFlags, anExclude);
   finally
    l_TPPF.Generator := nil;
   end;{try..finally}
  finally
   l_TPPF.Finish;
  end;{try..finally}
 finally
  l3Free(l_TPPF);
 end;{try..finally}
end;
  
procedure TevTextParaPartFilter.StartTag(TagID: Long);
  {override;}
  {-}
begin
 inherited;
 if (f_SideGenerator = nil) then
  Generator.StartTag(TagID)
 else
  f_SideGenerator.StartTag(TagID);
end;

procedure TevTextParaPartFilter.StartChild(TypeID: Tl3VariantDef);
  {override;}
  {-}
begin
 inherited;
 if (f_SideGenerator = nil) then
 begin
  if CurrentType.IsKindOf(k2_typSegment) then
  begin
   f_SideGenerator := Tk2DocumentGenerator.Create;
   f_SideGenerator.OnFinishAtom := DoFinishAtom;
   f_SideGenerator.Start;
   f_SideGenerator.StartChild(TypeID);
  end//CurrentType.IsKindOf(k2_typSegment)
  else
   Generator.StartChild(TypeID);
 end//f_SideGenerator = nil
 else
  f_SideGenerator.StartChild(TypeID);
end;

procedure TevTextParaPartFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  {override;}
  {-}
var
 l_Old : Tl3PrimString;
 l_New : Tl3PrimString;
 l_OS  : Tl3WString;
begin
 if (f_SideGenerator = nil) then
 begin
  if (AtomIndex = k2_tiText) then
  begin
   if (Value.Kind = k2_vkString) then
   begin
    l_Old := Value.AsString;
    l_New := l_Old.Clone;
    try
     l_OS := l_Old.AsWStr;
     if (l_OS.SCodePage = CP_Unicode) then
      l_New.AsWStr := l3PCharLen(PWideChar(l_OS.S) + f_Sel.rStart, f_Sel.rFinish - f_Sel.rStart)
     else
      l_New.AsWStr := l3PCharLen(@l_OS.S[f_Sel.rStart], f_Sel.rFinish - f_Sel.rStart, l_OS.SCodePage);
     Generator.AddAtom(k2_tiText, l_New);
    finally
     l3Free(l_New);
    end;{try..finally}
   end else
    ConvertErrorEx(Value.Kind);
  end else
   Generator.AddAtomEx(AtomIndex, Value)
 end else
  f_SideGenerator.AddAtomEx(AtomIndex, Value);
end;

procedure TevTextParaPartFilter.CloseStructure(NeedUndo: Bool);
  {override;}
  {-вызывается на закрывающуюся скобку}
begin
 if (f_SideGenerator = nil) then
  Generator.Finish(NeedUndo)
 else begin
  f_SideGenerator.Finish(NeedUndo);
  if CurrentType.IsKindOf(k2_typSegment) then
  begin
   f_SideGenerator.Finish(NeedUndo);
   l3Free(f_SideGenerator);
  end;//..k2_idSegment..
 end;//f_SideGenerator = nil
 inherited;
end;

function TevTextParaPartFilter.DoFinishAtom(G        : Tk2DocumentGenerator;
                                            var Atom : Tk2StackAtom): Bool;
  {-}
var
 SS, SF : Long;
begin
 Result := true;
 if Atom.IsKindOf(k2_typSegment) then
 begin
  SS := Atom.Box.IntA[k2_tiStart];
  SF := Atom.Box.IntA[k2_tiFinish];
  if (SF >= f_Sel.rStart) then
  begin
   if (SS <= f_Sel.rFinish) then
   begin
    if (SS <= f_Sel.rStart) then
     SS := Succ(f_Sel.rStart);
    if (SF > f_Sel.rFinish) then
     SF := f_Sel.rFinish;
    Dec(SS, f_Sel.rStart);
    Dec(SF, f_Sel.rStart);
    Inc(SS, f_SelOffset);
    Inc(SF, f_SelOffset);
    Atom.Box.IntA[k2_tiStart] := SS;
    Atom.Box.IntA[k2_tiFinish] := SF;
    Generator.StartChild(Atom.TagType);
    try
     Atom.Box.WriteTag(Generator);
    finally
     Generator.Finish;
    end;//try..finally
   end;//SS <= f_Sel.rFinish
  end;//SF >= f_Sel.rStart
 end;//..k2_idSegment..
end;

end.

