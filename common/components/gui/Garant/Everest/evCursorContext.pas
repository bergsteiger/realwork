unit evCursorContext;
{* Контект операций для обработки движения курсоров. }

{ Библиотека "Эверест"      }
{ Автор: Люлин А.В. ©       }
{ Модуль: evCursorContext - }
{ Начат: 15.05.2001 16:57   }
{ $Id: evCursorContext.pas,v 1.32 2014/04/30 11:23:52 lulin Exp $ }

// $Log: evCursorContext.pas,v $
// Revision 1.32  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.31  2014/04/10 15:26:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.30  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.29  2009/07/23 08:14:38  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.28  2009/07/14 14:56:25  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.27  2009/07/13 12:31:36  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.26  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.25  2009/04/09 14:12:36  lulin
// [$140837386]. №15.
//
// Revision 1.24  2008/08/25 15:14:47  lulin
// - <K>: 100011305.
//
// Revision 1.23  2008/03/21 16:54:07  lulin
// - типизируем элементы списка курсоров.
//
// Revision 1.22  2008/03/21 16:41:30  lulin
// - удалён ненужный параметр.
//
// Revision 1.21  2008/03/21 16:14:49  lulin
// - сохранённый курсор выделен в отдельный файл.
//
// Revision 1.20  2008/03/21 15:41:37  lulin
// - <K>: 87591144.
//
// Revision 1.19  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.18  2008/02/19 11:05:47  lulin
// - восстановил всякие экзотические поиски в списках объектов.
//
// Revision 1.17  2008/02/12 10:31:18  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.16  2008/02/05 09:57:37  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.15  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.14.2.9  2007/08/21 12:43:17  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.14.2.8  2007/06/22 19:18:56  lulin
// - cleanup.
//
// Revision 1.14.2.7  2005/11/11 21:52:13  lulin
// - bug fix: убраны утечки объектов документа, связанные с неправильным владением Undo-буфером.
//
// Revision 1.14.2.6  2005/11/09 15:28:23  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.14.2.5  2005/07/21 06:46:11  lulin
// - модификация состояния курсора и его связей с другими курсорами разнесены на два разных интерфейса.
//
// Revision 1.14.2.4  2005/07/21 06:05:47  lulin
// - в процедуре поиска модифицируемый курсор заменен на немодифицируемый.
//
// Revision 1.14.2.3  2005/07/20 18:36:11  lulin
// - модуль переименован в сответствии с названием интерфейса.
//
// Revision 1.14.2.2  2005/06/01 16:22:24  lulin
// - remove unit: evIntf.
//
// Revision 1.14.2.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.12.2.2  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.12.2.1  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.12.4.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.14  2005/05/16 15:31:11  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.12  2005/03/16 09:50:10  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.11  2004/11/17 17:32:03  lulin
// - окончательно починена синхронизация вставки/удаления комментариев, отъехавшая в связи с переходом на блоки.
//
// Revision 1.10  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.9  2004/06/01 16:51:18  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.8  2003/10/02 16:33:23  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.7  2002/02/07 15:05:24  law
// - rename class: IevCursor -> _TevCursor, для того чтобы не путать его с интерфейсом.
//
// Revision 1.6  2001/10/23 08:14:21  law
// - debug info: вставлен отладочный вывод для ловли AV при сохранении курсоров.
//
// Revision 1.5  2001/09/11 17:45:28  law
// - cleanup.
//
// Revision 1.4  2001/07/24 12:30:24  law
// - comments: xHelpGen.
//
// Revision 1.3  2001/05/29 10:37:32  law
// - cleanup.
//
// Revision 1.2  2001/05/28 14:06:35  law
// - cleanup: убраны ненужные зависимости между модулями.
//
// Revision 1.1  2001/05/15 13:11:20  law
// - new unit: добавлен модуль evCursorContext - в него переехал класс TevCursorContext.
//

{$Include evDefine.inc }

interface

uses
{$IfDef evUseVisibleCursors}
  l3Interfaces,
  l3Types,
  l3Base,
  l3InternalInterfaces,
  l3ObjectRefList1,

  k2Context,
  k2OpRefList,

  evInternalInterfaces,
  evSavedCursorListPrim,

  nevTools
{$Else  evUseVisibleCursors}
  l3Op
{$EndIf evUseVisibleCursors}
  ;

{$IfDef evUseVisibleCursors}

type
  TevSavedCursorList = class(TevSavedCursorListPrim)
   {* Список сохраненных курсоров. }
    public
    // public methods
      function  IndexOf(const aCursor: InevBasePoint): Long;
        reintroduce;
        {-}
      procedure RecordCursor(const aCursor: InevBasePoint);
        {* - начать запись курсора. }
      procedure StopRecord;
        {* - закончить записб курсоров. }
      procedure Undo;
        {* - вернуть старые значения курсоров. }
      procedure Redo;
        {* - вернуть новые значения курсоров. }
      function  JoinWith(P: evSavedCursorListPrim._l3TypedListPrim_): Long;
        override;
        {-}
  end;{TevSavedCursorList}

  TevCursorContext = class(Tk2Context, IevCursorContext)
   {* Контект операций для обработки движения курсоров. }
    private
    {internal fields}
      f_SavedCursors : TevSavedCursorList;
    protected
    {internal methods}
      function  DoUndo(const aProcessor: InevProcessor): Long;
        override;
        {* - откатывает все операции и возвращает их количество. }
      function  DoRedo(const aProcessor: InevProcessor): Long;
        override;
        {* - возвращает все операции и возвращает их количество. }
      function  GetEmpty: Bool;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      function JoinWith(P: k2OpRefList._l3TypedListPrim_): Long;
        override;
        {-соединяет Self с anOperation и возвращает true если это возможно
          иначе - возвращает false}
      procedure Clear;
        override;
        {-}
      procedure RecordCursor(const aCursor: InevBasePoint);
        {* - начать запись курсора. }
      procedure StopRecord;
        {* - закончить запись курсоров. }
    public
    // public properties
      property SavedCursors: TevSavedCursorList
        read f_SavedCursors;
        {* - список сохраненных курсоров. }
  end;{TevCursorContext}

{$Else evUseVisibleCursors}

type
  TevCursorContext = Tl3OperationContainer;

{$EndIf evUseVisibleCursors}

implementation

{$IfDef evUseVisibleCursors}

uses
  SysUtils,

  evSavedCursor
  ;

// start class TevSavedCursorList

function  TevSavedCursorList.IndexOf(const aCursor: InevBasePoint): Long;
  {-}
var
 i : Long;
begin
 i := 0;
 while (i < Count) do
 begin
  if (Items[i].Cursor = aCursor) then
  begin
   Result := i;
   Exit;
  end;
  Inc(i);
 end;
 Result := -1;
end;

procedure TevSavedCursorList.RecordCursor(const aCursor: InevBasePoint);
  {-}
var
 SC  : TevSavedCursor;
 OC  : IevSavedCursor;
 l_C : InevBasePoint;
begin
 if (aCursor <> nil) then
 begin
  l_C := aCursor.TopParentPoint;
  if (l_C <> nil) AND (IndexOf(l_C) < 0) then
  begin
   if l_C.Obj.AsObject.QT(IevSavedCursor, OC) then
    try
     OC.Store(l_C);
     SC := TevSavedCursor.Create(l_C, OC, nil);
     try
      Add(SC);
     finally
      l3Free(SC);
     end;{try..finally}
    finally
     OC := nil;
    end;{try..finally}
  end;//IndexOf(l_C) < 0
 end;//aCursor <> nil
end;

function __RecordNew(SC: Pointer; Index: Long): Bool; 
var
 NC : IevSavedCursor;
begin
 Result := true;
 if PevSavedCursor(SC)^.Cursor.Obj.AsObject.QT(IevSavedCursor, NC) then
  try
   NC.Store(PevSavedCursor(SC)^.Cursor);
   PevSavedCursor(SC)^.New := NC;
  finally
   NC := nil;
  end;{try..finally}
end;

procedure TevSavedCursorList.StopRecord;
  {-}

begin
 IterateAll(__RecordNew);
end;

procedure TevSavedCursorList.Undo;
  {-}
var
 i  : Long;
 SC : TevSavedCursor;
begin
 if (Self <> nil) then
 begin
  i := Hi;
  while (i >= 0) do
  begin
   SC := Items[i];
   with SC do
   begin
    Old.Load(Cursor);
    Cursor.Refresh
   end;//with SC
   Dec(i);
  end;
 end;//Self <> nil
end;

procedure TevSavedCursorList.Redo;
  {-}
var
 i  : Long;
 SC : TevSavedCursor;
begin
 if (Self <> nil) then
 begin
  i := 0;
  while (i < Count) do
  begin
   SC := Items[i];
   with SC do
   begin
    if (New <> nil) then
     New.Load(Cursor);
    Cursor.Refresh;
   end;//with SC
   Inc(i);
  end;
 end;//Self <> nil
end;

function TevSavedCursorList.JoinWith(P: evSavedCursorListPrim._l3TypedListPrim_): Long;
  {override;}
  {-}
var
 aSavedCursors : TevSavedCursorList absolute P;
 i             : Long;
 j             : Long;
 SC            : TevSavedCursor;
begin
 i := 0;
 if (P Is TevSavedCursorList) then
 begin
  Result := Count;
  while (i < aSavedCursors.Count) do
  begin
   SC := aSavedCursors.Items[i];
   j := IndexOf(SC.Cursor);
   if (j < 0) then
    Add(SC)
   else
    Items[j].New := SC.New;
   Inc(i);
  end;{while i..}
 end else
  Result := -1;
end;

// start class TevCursorContext 

procedure TevCursorContext.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_SavedCursors);
 inherited;
end;

function TevCursorContext.DoUndo(const aProcessor: InevProcessor): Long;
  {override;}
  {-откатывает все операции и возвращает их количество}
begin
 Result := inherited DoUndo(aProcessor);
 f_SavedCursors.Undo;
end;

function TevCursorContext.DoRedo(const aProcessor: InevProcessor): Long;
  {override;}
  {-возвращает все операции и возвращает их количество}
begin
 Result := inherited DoRedo(aProcessor);
 f_SavedCursors.Redo;
end;

function  TevCursorContext.GetEmpty: Bool;
  {override;}
  {-}
begin
 Result := f_SavedCursors.Empty AND inherited GetEmpty;
end;

procedure TevCursorContext.Clear;
  {override;}
  {-}
begin
 l3Free(f_SavedCursors);
 inherited;
end;

procedure TevCursorContext.RecordCursor(const aCursor: InevBasePoint);
  {-}
begin
 if Get_SaveUndo then
 begin
  if (f_SavedCursors = nil) then
   f_SavedCursors := TevSavedCursorList.Make;
  f_SavedCursors.RecordCursor(aCursor);
 end;//SaveUndo
end;

procedure TevCursorContext.StopRecord;
  {-}
begin
 if Get_SaveUndo AND (f_SavedCursors <> nil) then
  f_SavedCursors.StopRecord;
end;

function TevCursorContext.JoinWith(P: k2OpRefList._l3TypedListPrim_): Long;
  {override;}
  {-соединяет Self с anOperation и возвращает true если это возможно
    иначе - возвращает false}
begin
 if (P Is TevCursorContext) then begin
  if (TevCursorContext(P).f_SavedCursors <> nil) then begin
   if (f_SavedCursors = nil) then
    f_SavedCursors := TevSavedCursorList.Make;
   f_SavedCursors.JoinWith(TevCursorContext(P).f_SavedCursors);
  end;{TevCursorContext(P).f_SavedCursors <> nil}
 end;
 Result := inherited JoinWith(P);
end;

{$EndIf evUseVisibleCursors}

end.

