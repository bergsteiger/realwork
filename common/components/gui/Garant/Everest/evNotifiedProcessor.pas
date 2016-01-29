unit evNotifiedProcessor;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evNotifiedProcessor - }
{ Начат: 01.12.2005 06:21 }
{ $Id: evNotifiedProcessor.pas,v 1.22 2014/04/08 17:13:19 lulin Exp $ }

// $Log: evNotifiedProcessor.pas,v $
// Revision 1.22  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.21  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.20  2014/03/26 15:51:56  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.19  2014/03/25 13:03:40  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2014/03/25 11:53:27  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.17  2014/03/21 12:39:22  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.16  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.14  2009/07/23 17:28:50  lulin
// - убираем ненужный запрос интерфейса.
// - правим наследование у SomeDataContainer.
//
// Revision 1.13  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.12  2009/07/22 12:29:50  lulin
// - пытаемся оптимизировать установку атомарных тегов.
//
// Revision 1.11  2009/07/21 18:23:09  lulin
// - подготавливаемся к уменьшению преобразования типов при записи атрибутов.
//
// Revision 1.10  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.9  2009/03/04 13:32:46  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.8  2008/11/10 15:42:50  lulin
// - <K>: 114459503. Теперь и превью и контейнер документа обладают списком разрывов разделов.
//
// Revision 1.7  2008/07/02 12:32:21  lulin
// - <K>: 91848911.
//
// Revision 1.6  2008/05/16 14:01:10  lulin
// - переносим на модель.
//
// Revision 1.5  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.4  2008/01/24 07:58:23  dinishev
// Bug fix: портился параграф после изменения стиля и размера шрифта
//
// Revision 1.3  2007/12/25 12:55:52  lulin
// - удален ненужный модуль.
//
// Revision 1.2  2007/12/05 12:35:06  lulin
// - вычищен условный код, составлявший разницу ветки и Head'а.
//
// Revision 1.1  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.16  2007/09/04 18:06:16  lulin
// - cleanup.
//
// Revision 1.15  2007/09/03 11:39:29  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.14  2007/09/03 10:46:41  lulin
// - уменьшаем число параметров.
//
// Revision 1.13  2007/08/02 16:08:46  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.12  2006/11/03 10:59:46  lulin
// - объединил с веткой 6.4.
//
// Revision 1.11.4.2  2006/10/26 12:03:53  lulin
// - спрятаны ненужные теги.
//
// Revision 1.11.4.1  2006/10/23 09:59:22  lulin
// - убираем лишние данные с визуальной точки.
//
// Revision 1.11  2006/08/02 10:51:48  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.10.16.1  2006/07/28 14:11:11  lulin
// - убрана функция переформатирования параграфа.
//
// Revision 1.10  2006/01/27 09:40:57  lulin
// - bug fix: при вставке/удалении параграфов не переформатировались таблицы.
//
// Revision 1.9  2006/01/11 12:39:42  lulin
// - bug fix: при построении _Preview неправильно считалось число параграфов.
//
// Revision 1.8  2005/12/15 08:06:24  lulin
// - new behavior: при вставке/удалении комментария сигнализируем о необходимости открытия оглавления (CQ OIT5-18640).
//
// Revision 1.7  2005/12/05 12:41:48  lulin
// - bug fix: при чтении из потока неправильно считалась высота документа.
//
// Revision 1.6  2005/12/02 22:38:05  lulin
// - нотификация о добавлении параграфов в процессе загрузки теперь посылается через процессор, а не через обработчики сообщений.
//
// Revision 1.5  2005/12/02 22:03:43  lulin
// - запрос валидности операции посылается теперь через базовые объекты, а не шаманскими методами.
//
// Revision 1.4  2005/12/02 20:04:01  lulin
// - bug fix: асинхронное удаление параграфа портило Undo-буфер.
//
// Revision 1.3  2005/12/02 18:23:24  lulin
// - обрабока нотфификации об удалении/добавлении параграфа практически полностью перенесена на процессор.
//
// Revision 1.2  2005/12/01 11:55:16  lulin
// - нотификация об изменении состава детей тега разложена по уровням Processor -> DocumentContainer.
//
// Revision 1.1  2005/12/01 05:27:39  lulin
// - нотификация об изменении атрибута тега разложена по уровням Processor -> DocumentContainer -> TextSource.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Variant,
  
  k2Interfaces,
  
  evOpProc,

  nevTools,

  k2Base,
  k2BaseStruct
  ;

type
  TevNotifiedProcessor = class(TevCustomUndoProcessor)
    protected
    // internal methods
   procedure NotifyPropChanged(aProp: TObject;
    const aValues;
    const anOp: Ik2Op); override;
      procedure PropChanged(Prop     : Tk2CustomPropertyPrim;
                            const V        : Tk2Values;
                            const anOpPack : Ik2Op);
        {-}
      procedure ChildAdded(aList    : Tl3Variant;
                           aProp    : Tk2ArrayProperty;
                           aChild   : Tl3Variant;
                           anIndex        : Integer;
                           const anOpPack : InevOp);
        virtual;
        {-}
      procedure ChildDeleted(aList    : Tl3Variant;
                             aProp    : Tk2ArrayProperty;
                             aChild   : Tl3Variant;
                             anIndex        : Integer;
                             const anOpPack : InevOp);
        {-}
      procedure NotifyInsert(aList    : Tl3Variant;
                             aProp    : TObject;
                             aChild   : Tl3Variant;
                             anIndex        : Integer;
                             const anOpPack : InevOp);
        override;
        {-}
      procedure NotifyDelete(aList    : Tl3Variant;
                             aProp    : TObject;
                             aChild   : Tl3Variant;
                             anIndex        : Integer;
                             const anOpPack : InevOp);
        override;
        {-}
  end;//TevNotifiedProcessor

implementation

uses
  l3Types,
  l3Tree_TLB,
  
  k2Tags,
  k2PropertyOperation,
  k2ChildOperation,

  nevBase,
  evBseOp,

  ParaList_Const,
  SegmentsLayer_Const,
  Block_Const
  ;

// start class TevNotifiedProcessor

procedure TevNotifiedProcessor.NotifyPropChanged(aProp: TObject;
 const aValues;
 const anOp: Ik2Op);
begin
 PropChanged(aProp As Tk2CustomPropertyPrim, Tk2Values(aValues), anOp);
end;

procedure TevNotifiedProcessor.PropChanged(Prop     : Tk2CustomPropertyPrim;
                                           const V        : Tk2Values;
                                           const anOpPack : Ik2Op);
  {-}
var
 l_Pack     : InevOp;
 l_OldValue : Tl3Variant;
begin
 l_Pack := anOpPack;
 if (l_Pack = nil) then
  l_Pack := StartOp;
 if (l_Pack <> nil) then
 try
  if l_Pack.SaveUndo then
  begin
   l_OldValue := V.rOld;
   if (l_OldValue = nil) OR l_OldValue.IsNull then
   begin
    if (V.rNew <> nil) and not V.IsNull then
     Ok2AddProp.ToUndo(l_Pack, V.rTag, Prop, l_OldValue, V.rNew);
   end//l_OldValue.IsNull
   else
   begin
    if (V.rNew = nil) or V.IsNull then
     Ok2DelProp.ToUndo(l_Pack, V.rTag, Prop, l_OldValue, V.rNew)
    else
     Ok2ModifyProp.ToUndo(l_Pack, V.rTag, Prop, l_OldValue, V.rNew);
   end;//l_OldValue.IsNull
  end;//l_Pack.SaveUndo
  if not l_Pack.InIOProcess AND (Document <> nil) then
   Document.PropChanged(Tk2Prop(Prop), V, l_Pack);
 finally
  l_Pack := nil;
 end;//try..finally
end;

procedure TevNotifiedProcessor.ChildAdded(aList    : Tl3Variant;
                                          aProp    : Tk2ArrayProperty;
                                          aChild   : Tl3Variant;
                                          anIndex        : Integer;
                                          const anOpPack : InevOp);
  {-}
var
 l_IsList : Boolean;
 //l_Para   : InevPara;
begin
 if (anOpPack <> nil) then
 begin
  if not anOpPack.InIOProcess then
  begin
   l_IsList := aList.IsKindOf(k2_typParaList);
   if anOpPack.SaveUndo then
   begin
    if l_IsList then
     OevInsertPara.ToUndo(anOpPack, aList, Succ(anIndex), aChild)
    else
     Ok2AddChild.ToUndo(anOpPack, aList, aProp, aChild, anIndex);
   end;//anOpPack.SaveUndo
   if l_IsList then
   begin
    ParaOp(aList, aChild, l3_opInsert);
(*    if aList.QT(InevPara, l_Para, Self) then
     try
      l_Para.Shape.Unformat;
      if l_Para.IsKindOf(k2_typTableCell) then
       with l_Para.OwnerPara do
       begin
        Shape.Unformat;
        OwnerPara.Shape.Unformat;
       end;//l_Para.OwnerPara
     finally
      l_Para := nil;
     end//try..finally
    else
     Assert(false);*) // <stub>
    if (Document <> nil) then
     Document.ViewArea.Invalidate;
   end//aList.IsKindOf(k2_typParaList)
   else
    if aList.IsKindOf(k2_typSegmentsLayer) then
    begin
     if (Document <> nil) then
      Document.ViewArea.Changed(nev_cpView);
   end;//if aList.IsKindOf(k2_typSegmentsLayer) then
  end;//not anOpPack.InIOProcess
 end;//(anOpPack <> nil)
 if (Document <> nil) then
  Document.ChildAdded(aList, aProp, aChild, anIndex, anOpPack);
end;

procedure TevNotifiedProcessor.ChildDeleted(aList    : Tl3Variant;
                                            aProp    : Tk2ArrayProperty;
                                            aChild   : Tl3Variant;
                                            anIndex        : Integer;
                                            const anOpPack : InevOp);
  {-}
var
 l_IsList      : Boolean;
 l_AnchorIndex : IevAnchorIndex;
 //l_Para        : InevPara;
begin
 if (anOpPack <> nil) then
 begin
  if not anOpPack.InIOProcess then
  begin
   if (anIndex >= 0) then
   //- избегаем паразитных параграфов в Undo после вставки из буфера обмена
   begin
    l_IsList := aList.IsKindOf(k2_typParaList);
    if anOpPack.SaveUndo then
    begin
     if l_IsList then
      OevDeletePara.ToUndo(anOpPack, aList, Succ(anIndex), aChild)
     else
      Ok2DeleteChild.ToUndo(anOpPack, aList, aProp, aChild, anIndex);
    end;//anOpPack.SaveUndo
    if l_IsList then
    begin
     ParaOp(aList, aChild, l3_opDelete);
     if aChild.IsKindOf(k2_typBlock) then
     begin
      if aList.QT(IevAnchorIndex, l_AnchorIndex, Self) then
       try
        l_AnchorIndex.Delete(aChild.IntA[k2_tiLayerID], aChild.IntA[k2_tiHandle]);
       finally
        l_AnchorIndex := nil;
       end;//try..finally
     end;//aChild.IsKindOf(k2_typBlock)
(*     if aList.QT(InevPara, l_Para, Self) then
      try
       l_Para.Shape.Unformat;
       if l_Para.IsKindOf(k2_typTableCell) then
        with l_Para.OwnerPara do
        begin
         Shape.Unformat;
         OwnerPara.Shape.Unformat;
        end;//l_Para.OwnerPara
      finally
       l_Para := nil;
      end//try..finally
     else
      Assert(false);*) // <stub>
     if (Document <> nil) then
     begin
      with Document do
      begin
       SubCache.ClearSubs;
       ViewArea.Invalidate;
      end;//with Document
     end;//Document <> nil
    end//l_IsList
    else
     if aList.IsKindOf(k2_typSegmentsLayer) then
     begin
      if (Document <> nil) then
       Document.ViewArea.Changed(nev_cpView);
    end;//if aList.IsKindOf(k2_typSegmentsLayer) then
   end;//anIndex >= 0
  end;//not anOpPack.InIOProcess
  if (Document <> nil) then
   Document.ChildDeleted(aList, aProp, aChild, anIndex, anOpPack);
 end;//OpPack <> nil
end;

procedure TevNotifiedProcessor.NotifyInsert(aList    : Tl3Variant;
                                            aProp    : TObject;
                                            aChild   : Tl3Variant;
                                            anIndex        : Integer;
                                            const anOpPack : InevOp);
  //override;
  {-}
begin
 inherited;
 ChildAdded(aList, aProp As Tk2ArrayProperty, aChild, anIndex, anOpPack);
end;

procedure TevNotifiedProcessor.NotifyDelete(aList    : Tl3Variant;
                                            aProp    : TObject;
                                            aChild   : Tl3Variant;
                                            anIndex        : Integer;
                                            const anOpPack : InevOp);
  //override;
  {-}
begin
 inherited;
 ChildDeleted(aList, aProp As Tk2ArrayProperty, aChild, anIndex, anOpPack);
end;

end.

