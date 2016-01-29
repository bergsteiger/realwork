unit evCommentParaAdder;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evCommentParaAdder - }
{ Начат: 26.11.2004 11:50 }
{ $Id: evCommentParaAdder.pas,v 1.19 2014/03/27 14:19:58 lulin Exp $ }

// $Log: evCommentParaAdder.pas,v $
// Revision 1.19  2014/03/27 14:19:58  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2014/03/04 13:08:19  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.17  2013/10/21 15:42:57  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.16  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2013/10/18 14:11:22  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.14  2009/03/04 13:32:45  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.13  2008/06/09 12:16:49  lulin
// - bug fix: не собирался Немезис.
//
// Revision 1.12  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.9.8.7  2007/08/09 18:26:18  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.9.8.6  2007/08/09 11:19:12  lulin
// - cleanup.
//
// Revision 1.9.8.5  2006/11/29 11:33:35  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.9.8.4.16.2  2006/11/29 11:30:40  oman
// Комментарий
//
// Revision 1.9.8.4.16.1  2006/11/29 11:29:33  oman
// - fix: Фильтр на комментарии ставим всегда и всегда делаем
//  оборачивающий тэг - если буфер начинается с комментария и
//  продолжается после него имеем проблемы (cq23768)
//
// Revision 1.9.8.4  2006/04/18 08:39:07  lulin
// - bug fix: не пишем сообщения в лог о незакрытых скобках при попытке вставки комментариев, т.к. поднятие исключения - это штатная ситуация.
//
// Revision 1.9.8.3  2005/07/19 17:23:46  lulin
// - убран косвенный доступ к списку Sub'ов документа - теперь он получается непосредственно от параграфа.
//
// Revision 1.9.8.2  2005/07/19 12:50:06  lulin
// - часть базовых интерфейсов переехала в модуль nevTools.
//
// Revision 1.9.8.1  2005/07/14 10:24:25  lulin
// - реализация интерфейса IevSubList спущена с TextSource, на DocumentContainer.
//
// Revision 1.9  2005/03/29 14:48:55  lulin
// - свойство Ik2TagGenerator.Generator переименовано в NextGenerator - во избежании путаницы в старых операторах with.
//
// Revision 1.8  2005/03/28 14:29:59  lulin
// - от класса генераторов переходим к интерфейсу.
//
// Revision 1.7  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.6  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.5  2005/01/31 14:15:15  lulin
// - bug fix: пытались завернуть документ в комментарий - соответственно была ошибка при вставке целого документа в качестве комментария (CQ OIT5-11998).
//
// Revision 1.4  2004/11/26 15:06:10  lulin
// - bug fix: картинки из Clipboard'а не заворачивались в комментарий.
//
// Revision 1.3  2004/11/26 12:41:42  lulin
// - new behavior: избавляемся, от дублирующихся идентификаторов комментариев.
//
// Revision 1.2  2004/11/26 12:04:08  lulin
// - new behavior: запрещена вставка вложенных комментариев.
//
// Revision 1.1  2004/11/26 10:14:04  lulin
// - new behavior: при вставке текста "мимо" комментария - "оборачиваем" его в комментарий.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Variant,

  k2Types,
  k2Prim,
  k2TagGen,
  k2TagFilter,

  nevTools
  ;

type
  TevCommentParaAdder = class(Tk2TagFilter)
    private
    // internal fields
      f_WasComment       : Boolean;
      f_SubList          : InevSubList;
    protected
    // internal methods
      procedure OpenStream;
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure CloseStructure(NeedUndo: Boolean);
        override;
        {-вызывается на закрывающуюся скобку}
      procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aSubList   : InevSubList);
        reintroduce;
        {-}
      class function SetTo(const aSubList   : InevSubList;
                           var theGenerator : Tk2TagGenerator): Pointer;
        {-}
  end;//TevCommentParaAdder

implementation

uses
  k2Tags,
  k2Interfaces,
  k2Base,

  evdTypes,
  
  evCommentsEliminator,

  Document_Const,
  Para_Const,
  CommentPara_Const
  ;

// start class TevCommentParaAdder

constructor TevCommentParaAdder.Create(const aSubList   : InevSubList);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_SubList := aSubList;
end;

class function TevCommentParaAdder.SetTo(const aSubList   : InevSubList;
                                         var theGenerator : Tk2TagGenerator): Pointer;
  {-}
var
 l_Filter : TevCommentParaAdder;
begin
 l_Filter := Create(aSubList);
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
  // ФИльтр надо ставить сразу: если в клипборде лежит кусок начинающийся
  // с комментария, после которого идет еще текст,
  // то на вставке этого дела имели проблемы
  TevCommentsEliminator.SetTo(theGenerator);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TevCommentParaAdder.Cleanup;
  //override;
  {-}
begin
 f_SubList := nil;
 inherited;
end;

procedure TevCommentParaAdder.OpenStream;
  //override;
  {-}
begin
 f_WasComment := false;
 inherited;
end;

procedure TevCommentParaAdder.StartChild(TypeID: Tl3VariantDef);
  //override;
  {-}
var
 l_Type      : Tk2Type;
begin
 l_Type := Tk2Type(TypeID);
 if not f_WasComment AND not l_Type.IsKindOf(k2_typDocument) AND
    l_Type.IsKindOf(k2_typPara) then
 begin
  f_WasComment := true;
  Assert(not l_Type.IsKindOf(k2_typCommentPara));
  inherited StartChild(k2_typCommentPara);
 end;//not f_WasComment..
 inherited;
end;

procedure TevCommentParaAdder.CloseStructure(NeedUndo: Boolean);
  //override;
  {-вызывается на закрывающуюся скобку}
begin
 inherited;
 if (CurrentStartLevel = OpenStreamLevel) and f_WasComment then
  Finish(NeedUndo);
end;

procedure TevCommentParaAdder.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
begin
 if (AtomIndex = k2_tiHandle) AND
    CurrentType.IsKindOf(k2_typCommentPara) AND
    (f_SubList <> nil) then
 begin
  if f_SubList.SubEx[VariantAsInteger(AtomIndex, Value), Ord(ev_sbtMark)].Exists then
   Exit;
   // - не пускаем Handle - т.к. такой комментарий уже есть
 end;//AtomIndex = k2_tiHandle
 inherited;
end;

end.

