unit k2Facade;
{* Интерфейсы библиотеки K2, предназначенные для унифицированного общения с таблицами тегов. }

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2Facade -      }
{ Начат: 01.04.2005 17:36 }
{ $Id: k2Facade.pas,v 1.36 2015/02/26 09:29:00 kostitsin Exp $ }

// $Log: k2Facade.pas,v $
// Revision 1.36  2015/02/26 09:29:00  kostitsin
// List*ner -> Listener
//
// Revision 1.35  2015/02/25 13:53:20  kostitsin
// List*ner -> Listener
//
// Revision 1.34  2014/07/22 13:52:54  lulin
// - готовимся к рисованию фабрик.
//
// Revision 1.33  2014/04/30 11:24:07  lulin
// - выпрямляем зависимости.
//
// Revision 1.32  2014/04/07 17:57:11  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.31  2014/03/27 14:20:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.30  2014/03/14 14:22:40  lulin
// - удаляем ненужный интерфейс.
//
// Revision 1.29  2013/10/23 12:26:04  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.28  2013/10/17 15:52:42  lulin
// - работа по избавлению от ненужного Enum.
//
// Revision 1.27  2013/04/09 17:40:13  lulin
// - пытаемся отладиться под XE.
//
// Revision 1.26  2012/10/26 17:42:53  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.25  2009/07/06 15:46:29  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.24  2009/07/06 15:36:19  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.23  2009/04/14 18:12:01  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.22  2009/03/24 18:45:04  lulin
// - вставляем проверку на ноль, т.к. своими глазами наблюдал падение - [$140282354].
//
// Revision 1.21  2009/03/05 16:20:42  lulin
// - <K>: 137470629. Убрана ненужная ссылка на тип по идентификатору.
//
// Revision 1.20  2008/06/18 08:49:52  lulin
// - обеспечиваем автоматическое связывание с указанной таблицей тегов.
//
// Revision 1.19  2008/06/10 14:38:40  lulin
// - храним ссылки на типы в полях таблицы тегов.
//
// Revision 1.18  2008/03/20 09:48:38  lulin
// - cleanup.
//
// Revision 1.17  2008/02/07 14:44:43  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.16  2007/12/24 15:25:30  lulin
// - удалены ненужные файлы.
//
// Revision 1.15  2006/01/30 09:49:49  lulin
// - убран ненужный параметр.
//
// Revision 1.14  2006/01/18 16:37:06  lulin
// - не зовем нотификации для типов без ID.
//
// Revision 1.13  2006/01/18 16:31:47  lulin
// - cleanup.
//
// Revision 1.12  2006/01/18 16:12:15  lulin
// - не регистрируем Listener'ов для типов без ID.
//
// Revision 1.11  2005/06/30 16:38:22  lulin
// - выключено кеширование атрибутов тегов, как вредное и приводящее к лишней нотификации и в силу этого к замедлению при загрузке документа.
//
// Revision 1.10  2005/04/28 15:04:09  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.9.2.3  2005/04/23 16:07:35  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.9.2.2  2005/04/22 11:04:30  lulin
// - bug fix: была ошибка при присваивании шрифта.
//
// Revision 1.9.2.1  2005/04/21 14:47:02  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.9  2005/04/15 08:59:57  lulin
// - теперь держим ссылку на тег, а не собственно тег.
//
// CVS XXX
// Revision 1.8  2005/04/12 09:53:09  lulin
// - объединил с веткой - в попытках починить List Index Out Of Bounds.
//
// Revision 1.7.2.1  2005/04/08 12:00:38  lulin
// - _Processor стал обязательным параметром.
//
// Revision 1.7  2005/04/05 16:07:07  lulin
// - new behavior: теперь иструменты имеют возможность получать нотификацию об изменении атрибутов.
//
// Revision 1.6  2005/04/04 06:44:07  lulin
// - в связи с появлением механизма событий и фасада библиотеки K-2, удалены глобальные "заплатки" связанные с созданием/уничтожением таблицы тегов.
//
// Revision 1.5  2005/04/01 16:58:43  lulin
// - удалено дублирование кода заполнения структуры.
//
// Revision 1.4  2005/04/01 16:56:00  lulin
// - new behavior: теперь все инструменты, которыми в данный момент пользуются, получают сообщения о событиях происходящих с тегами.
//
// Revision 1.3  2005/04/01 16:18:42  lulin
// - new behavior: теперь рассылаем всем объектам извещение о том, что таблица тегов сейчас уничтожится.
//
// Revision 1.2  2005/04/01 14:35:25  lulin
// - переходим от перебора курсоров к посылке сообщений.
//
// Revision 1.1  2005/04/01 13:53:43  lulin
// - new unit: k2Facade.
//

{$Include k2Define.inc }

interface

uses
  k2Interfaces,
  k2Base
  ;

type
  Tk2Sender = TObject;
  Tk2 = class
    public
    // public methods
      class procedure SignalEvent(const aSender : Tk2Sender;
                                  const anID    : Tk2EventID;
                                  aTag    : Tl3Variant = nil;
                                  const anOp    : Ik2Op = nil;
                                  aPoint        : Integer = 0;
                                  aLen          : Integer = 0;
                                  aTotal        : Integer = High(Integer));
        virtual;
        {* - рассылает сообщения всем заинтересованным лицам. }
      class procedure AddListener(const aListener: Ik2TagListener);
        overload;
        {* - добавляет объект, слушающий события библиотеки. }
      class procedure RemoveListener(const aListener: Ik2TagListener);
        overload;
        {* - удаляет объект, слушающий события библиотеки. }
      class procedure AddListener(const aListener: Ik2Listener);
        overload;
        {* - добавляет объект, слушающий события библиотеки. }
      class procedure RemoveListener(const aListener: Ik2Listener);
        overload;
        {* - удаляет объект, слушающий события библиотеки. }
      class function  TypeTable: Tk2TypeTable;
        {* - стандартная таблица тегов. }
  end;//Tk2
  Rk2 = class of Tk2;

var
 k2 : Rk2 = Tk2;

implementation

uses
  SysUtils,

  l3Types,
  l3IID,
  l3Base,
  l3LongintList,

  k2Tags,
  k2TagTool,
  k2InterfaceFactory
  ;

// start class Tk2

var
 g_Listeners : array [Tk2EffTypeID] of Tl3LongintList;
 g_GlobalListeners : Tl3LongintList;

class procedure Tk2.SignalEvent(const aSender : Tk2Sender;
                                const anID    : Tk2EventID;
                                aTag    : Tl3Variant = nil;
                                const anOp    : Ik2Op = nil;
                                aPoint        : Integer = 0;
                                aLen          : Integer = 0;
                                aTotal        : Integer = High(Integer));
  //virtual;                          
  {* - рассылает сообщения всем заинтересованным лицам. }
  
var
 l_Event       : Tk2Event;
 l_EventInited : Boolean;

  procedure CheckEvent;
  begin
   if not l_EventInited then
   begin
    //l_Event.Sender := aSender;
    l_Event.ID := anID;
    l_Event.Point := aPoint;
    l_Event.Len := aLen;
    l_Event.Total := aTotal;
    l_EventInited := true;
   end;//not l_EventInited
  end;

  procedure CallOld;

   function _ModifyCursor(PLC: PObject; Index: Long): Bool;
   begin//_ModifyCursor
    Result := true;
    CheckEvent;
    Ik2TagListener(Tk2TagPointer(PLC^)).Fire(l_Event, anOp);
   end;//_ModifyCursor

  var
   l_CursorCache : Tk2InterfaceFactory;
   l_IA          : Tl3IteratorAction;
  begin//CallOld
   l_CursorCache := Tk2Type(aTag.TagType).InterfaceFactory;
   if (l_CursorCache <> nil) then
   begin
    l_IA := l3L2IA(@_ModifyCursor);
    try
     l_CursorCache.Iterate(aTag.AsObject, l_IA);
    finally
     l3FreeIA(l_IA);
    end;//try..finally
   end;//l_CursorCache <> nil
  end;//CallOld

  procedure CallOldGlobal;

   function _ModifyCursor(PLC: PObject; Index: Long): Bool;
   begin//_ModifyCursor
    Result := true;
    CheckEvent;
    Ik2TagListener(Tk2TagPointer(PLC^)).Fire(l_Event, anOp);
   end;//_ModifyCursor

  var
   l_IA    : Tl3IteratorAction;
   l_Index : Tk2EffTypeID;
   l_Type  : Tk2Type;
  begin//CallOldGlobal
   l_IA := l3L2IA(@_ModifyCursor);
   try
    for l_Index := Low(Tk2EffTypeID) to High(Tk2EffTypeID) do
    begin
     l_Type := Tk2TypeTable(aSender).TypeByHandle[Ord(l_Index)];
     if (l_Type <> nil) AND (l_Type.InterfaceFactory <> nil) then
      l_Type.InterfaceFactory.IterateCursors(l_IA);
    end;//for l_Index
   finally
    l3FreeIA(l_IA);
   end;//try..finally
  end;//CallOldGlobal

  function CallListener(pListener: PIUnknown; Index: Long): Bool;
  begin//CallListener
   Result := true;
   CheckEvent;
   if (pListener^ = nil) then
   begin
    l3System.Msg2Log(IntToStr(Index));
    Exit;
   end;
   Assert(pListener^ <> nil);
   Ik2TagListener(pListener^).Fire(l_Event, anOp);
  end;//CallListener

  function CallGlobalListener(pListener: PIUnknown; Index: Long): Bool;
  begin//CallGlobalListener
   Result := true;
   CheckEvent;
   Ik2Listener(pListener^).Fire(l_Event, anOp);
  end;//CallGlobalListener

  function CallTagListener(pListener: PIUnknown; Index: Long): Bool;
  begin//CallTagListener
   Result := true;
   if (pListener^ <> nil) AND
      not (anID in Ik2TagListener(pListener^).ExcludeEvents) AND
      (Ik2TagListener(pListener^).AsObject.IsSame(aTag)) then
   begin
    CheckEvent;
    Ik2TagListener(pListener^).Fire(l_Event, anOp);
   end;//not (anID in Ik2TagListener(pListener^).ExcludeEvents)..
  end;//CallTagListener

var
 l_Type  : Integer;
 l_Index : Tk2EffTypeID;
begin
 l_EventInited := false;
 if (aTag <> nil) then
 begin
  if (anID = k2_eidAttrChanged) then
   Exit;
  l_Type := Tk2Type(aTag.TagType).ID;
  if (l_Type >= Low(Tk2EffTypeID)) AND (l_Type <= High(Tk2EffTypeID)) then
  begin
   if (anID <> k2_eidAttrChanged) then
    CallOld;
   if (g_Listeners[l_Type] <> nil) then
    g_Listeners[l_Type].IterateAllF(l3L2IA(@CallTagListener));
  end;//l_Type >= Low(Tk2EffTypeID)..
 end//aTag <> nil
 else
 begin
  Case anID of
   k2_eidTypeTableWillBeDestroyed :
   begin
    if (aSender <> nil) then
    begin
     CallOldGlobal;
     for l_Index := Low(Tk2EffTypeID) to High(Tk2EffTypeID) do
      if (g_Listeners[l_Index] <> nil) then
       g_Listeners[l_Index].IterateAllF(l3L2IA(@CallListener));
     if (g_GlobalListeners <> nil) then
      g_GlobalListeners.IterateAllF(l3L2IA(@CallGlobalListener));
     for l_Index := Low(Tk2EffTypeID) to High(Tk2EffTypeID) do
      FreeAndNil(g_Listeners[l_Index]);
     FreeAndNil(g_GlobalListeners);
    end;//aSender <> nil
   end;//k2_eidTypeTableWillBeDestroyed
  end;//Case anID
 end;//aTag <> nil
end;

class procedure Tk2.AddListener(const aListener: Ik2TagListener);
  {-}
var
 l_T : Tk2TypePrim;
 l_Type : Integer;
 l_Index : Integer;
begin
 if (aListener <> nil) then
 begin
  l_T := Tk2Type(aListener.AsObject.TagType);
  if (l_T = nil) then
   Exit;
  l_Type := l_T.ID;
  if (l_Type >= Low(Tk2EffTypeID)) AND (l_Type <= High(Tk2EffTypeID)) then
  begin
   if (g_Listeners[l_Type] = nil) then
    g_Listeners[l_Type] := Tl3LongintList.MakeSorted;
   try
    assert(g_Listeners[l_Type].IndexOf(0) < 0);
   except
    l3System.Msg2Log(IntToStr(g_Listeners[l_Type].Count));
   end;
   if (g_Listeners[l_Type].Count = 780) then
    l_Index := g_Listeners[l_Type].Add(Integer(aListener))
   else
    l_Index := g_Listeners[l_Type].Add(Integer(aListener));
   try
    assert(g_Listeners[l_Type].IndexOf(0) < 0);
   except
    l3System.Msg2Log(IntToStr(g_Listeners[l_Type].Count));
   end;
  end;//l_Type >= Low(Tk2EffTypeID)..
 end;//aListener <> nil
end;

class procedure Tk2.RemoveListener(const aListener: Ik2TagListener);
  {-}
var
 l_T : Tk2TypePrim;
 l_Type : Integer;
 l_Index : Integer;
begin
 if (aListener <> nil) then
 begin
  l_T := Tk2Type(aListener.AsObject.TagType);
  if (l_T = nil) then
   Exit;
  l_Type := l_T.ID;
  if (l_Type >= Low(Tk2EffTypeID)) AND (l_Type <= High(Tk2EffTypeID)) then
  begin
   if (g_Listeners[l_Type] <> nil) then
   begin
    try
     assert((g_Listeners[l_Type].Count <= 3) OR (g_Listeners[l_Type][3] <> 0));
     assert((g_Listeners[l_Type].Count <= 2) OR (g_Listeners[l_Type][2] <> 0));
     assert((g_Listeners[l_Type].Count <= 1) OR (g_Listeners[l_Type][1] <> 0));
     assert((g_Listeners[l_Type].Count = 0) OR (g_Listeners[l_Type].First <> 0));
     assert(g_Listeners[l_Type].IndexOf(0) < 0);
    except
     l3System.Msg2Log(IntToStr(g_Listeners[l_Type].Count));
    end;
    l_Index := g_Listeners[l_Type].Remove(Integer(aListener));
    try
     assert((g_Listeners[l_Type].Count <= 2) OR (g_Listeners[l_Type][2] <> 0));
     assert((g_Listeners[l_Type].Count <= 1) OR (g_Listeners[l_Type][1] <> 0));
     assert((g_Listeners[l_Type].Count = 0) OR (g_Listeners[l_Type].First <> 0));
     assert(g_Listeners[l_Type].IndexOf(0) < 0);
    except
     l3System.Msg2Log(IntToStr(l_Index));
     l3System.Msg2Log(IntToStr(g_Listeners[l_Type].Count));
    end;
   end;//g_Listeners[l_Type] <> nil
  end;//l_Type >= Low(Tk2EffTypeID)..
 end;//aListener <> nil
end;

class procedure Tk2.AddListener(const aListener: Ik2Listener);
  //overload;
  {-}
begin
 Assert(aListener <> nil);
 if (g_GlobalListeners = nil) then
  g_GlobalListeners := Tl3LongintList.MakeSorted;
 g_GlobalListeners.Add(Integer(aListener));
end;

class procedure Tk2.RemoveListener(const aListener: Ik2Listener);
  //overload;
  {-}
begin
 Assert(aListener <> nil);
 if (g_GlobalListeners <> nil) then
  g_GlobalListeners.Remove(Integer(aListener));
end;

class function Tk2.TypeTable: Tk2TypeTable;
  //virtual;
  {-}
begin
 Result := Tk2TypeTable.GetInstance;
end;

end.

