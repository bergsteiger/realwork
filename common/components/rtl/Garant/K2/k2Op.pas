unit k2Op;
{* Реализация операции и пачки операций. }

{ Библиотека "L3 (Low Level Library)" }
{ Автор: Люлин А.В. ©                 }
{ Модуль: l3Op -                      }
{ Начат: 07.12.1999 19:05             }
{ $Id: k2Op.pas,v 1.22 2014/02/18 16:31:25 lulin Exp $ }

// $Log: k2Op.pas,v $
// Revision 1.22  2014/02/18 16:31:25  lulin
// - подготавливаемся к обобщению словарей.
//
// Revision 1.21  2013/12/27 06:48:49  lulin
// - выпрямляем кривизну.
//
// Revision 1.20  2012/10/26 19:41:55  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.19  2011/06/14 16:11:43  lulin
// {RequestLink:269066487}.
//
// Revision 1.18  2011/05/19 13:33:25  lulin
// {RequestLink:266409354}.
//
// Revision 1.17  2011/05/19 12:23:39  lulin
// {RequestLink:266409354}.
//
// Revision 1.16  2011/05/19 10:36:01  lulin
// {RequestLink:266409354}.
//
// Revision 1.15  2011/05/18 17:45:49  lulin
// {RequestLink:266409354}.
//
// Revision 1.14  2010/11/24 20:16:32  lulin
// {RequestLink:238945411}.
//
// Revision 1.13  2010/03/18 14:15:38  lulin
// {RequestLink:197951943}.
//
// Revision 1.12  2009/07/23 13:42:34  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.80  2009/07/21 15:10:18  lulin
// - bug fix: не собирался и не работал Архивариус в ветке.
//
// Revision 1.79  2009/07/20 11:22:19  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.78  2008/03/21 15:41:42  lulin
// - <K>: 87591144.
//
// Revision 1.77  2008/02/21 18:37:23  lulin
// - вычищен ненужный параметр.
//
// Revision 1.76  2008/02/21 18:13:28  lulin
// - избавляемся от ненужных типов.
//
// Revision 1.75  2008/02/14 17:09:15  lulin
// - cleanup.
//
// Revision 1.74  2008/02/12 10:31:25  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.73  2008/02/05 09:58:12  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.72  2008/02/01 15:14:54  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.71  2007/12/24 15:25:32  lulin
// - удалены ненужные файлы.
//
// Revision 1.70  2007/09/07 14:47:45  lulin
// - добавлено удаление последнего элемента списка.
//
// Revision 1.69  2007/02/12 18:06:19  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.68  2007/02/12 16:40:36  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.67  2007/01/22 15:20:13  oman
// - new: Локализация библиотек - l3 (cq24078)
//
// Revision 1.66  2006/11/17 14:23:09  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.65.12.1  2006/11/17 14:16:12  oman
// warning fix - функция не возвращала результат
//
// Revision 1.65  2006/05/18 08:08:16  lulin
// - cleanup.
//
// Revision 1.64  2006/01/12 13:16:51  lulin
// - bug fix: не склеиваем операции в пачки, т.к. на дереве есть проблемы с удалением.
//
// Revision 1.63  2005/12/26 13:26:57  lulin
// - bug fix: не всегда отображалось изменение комментариев (CQ OIT5-18865).
//
// Revision 1.62  2005/12/09 14:12:51  lulin
// - bug fix: не вызывалась нотификация об изменении содержимого контейнера.
//
// Revision 1.61  2005/12/07 07:46:25  lulin
// - bug fix: неправильно выставляли процессор операций после Undo - в результате был AV при вставке комментариев при наличии выделения (CQ OIT5-18513).
//
// Revision 1.60  2005/12/05 04:46:46  lulin
// - cleanup.
//
// Revision 1.59  2005/12/03 14:46:59  lulin
// - избавляемся от хитросплетений методов TextSource и контейнера документа.
//
// Revision 1.58  2005/12/02 18:23:38  lulin
// - обрабока нотфификации об удалении/добавлении параграфа практически полностью перенесена на процессор.
//
// Revision 1.57  2005/11/18 15:13:36  lulin
// - доделано сохранение комментариев.
//
// Revision 1.56  2005/11/11 22:23:23  lulin
// - избавляемся от управления свойством модифицированности документа путем посылки сообщений.
//
// Revision 1.55  2005/11/11 21:52:19  lulin
// - bug fix: убраны утечки объектов документа, связанные с неправильным владением Undo-буфером.
//
// Revision 1.54  2005/11/09 12:56:46  lulin
// - спрятан внутренний интерфейс.
//
// Revision 1.53  2005/04/28 15:04:11  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.52.2.2  2005/04/26 14:30:57  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.52.2.1  2005/04/26 08:10:05  lulin
// - уменьшено количество вызовов QueryInterface.
//
// Revision 1.52  2005/04/19 16:26:00  lulin
// - cleanup.
//
// Revision 1.51  2005/04/01 08:35:32  lulin
// - remove proc: evDir_InsertPara (пользуйтесь инструментом InevParaList).
//
// Revision 1.50  2005/02/03 15:25:36  lulin
// - Undo-записи сделаны кешируемыми.
//
// Revision 1.49  2005/02/03 15:05:58  lulin
// - bug fix: вставка строки не взводила флажок модифицированности.
//
// Revision 1.48  2005/02/03 14:33:45  lulin
// - для Undo-записей используем фабричные методы ToUndo, вместо конструкторов.
//
// Revision 1.47  2005/02/03 13:29:15  lulin
// - new interface: _Il3OpPackInternal.
//
// Revision 1.46  2005/02/03 13:10:41  lulin
// - new method: _Tl3Op._Put.
//
// Revision 1.45  2005/02/03 08:30:21  lulin
// - bug fix: после перехода на шаблон _Unknow_ не все операции попадали в буфер Undo.
//
// Revision 1.44  2005/02/02 18:24:44  lulin
// - класс _Tl3_CBase переведен на шаблон _Unknown_.
//
// Revision 1.43  2004/10/15 12:40:47  lulin
// - bug fix: не сохранялись комментарии, т.к. текст не метился как модифицированный.
//
// Revision 1.42  2004/09/20 12:42:58  lulin
// - оптимизация - путем перемещения части объектов в пул, время загрузки ГК (до показа оглавления) уменьшено с 3.5 сек до 2.6 сек.
//
// Revision 1.41  2004/06/02 16:42:39  law
// - удален класс Tl3VList.
//
// Revision 1.40  2003/02/13 18:25:55  law
// - change: Сделать _Lock/Unlock процессору операций и пачке операций (№114).
//
// Revision 1.39  2003/02/13 13:08:56  law
// - cleanup.
//
// Revision 1.38  2003/01/24 16:12:53  law
// - new interface: Il3OpPackMode.
// - new methods: Il3OpPack.Undo, Redo, Clear.
//
// Revision 1.37  2002/10/07 11:19:23  law
// - cleanup.
//
// Revision 1.36  2002/07/18 12:32:15  law
// - comments.
//
// Revision 1.35  2002/07/18 11:59:15  law
// - new unit: l3Message.
//
// Revision 1.34  2002/06/04 16:34:56  narry
// - bug fix: не очищалась ссылка на _l3NilOp.
//
// Revision 1.33  2002/05/14 08:37:32  law
// - new methods: Tl3VList: LoadFromStream, LoadFromFile, SaveToStream, SaveToFile.
//
// Revision 1.32  2001/11/20 10:21:18  law
// - comments: xHelpGen.
//
// Revision 1.31  2001/09/26 14:24:22  law
// - new behavior: объединение операций теперь делается в _Tl3OperationContainer._Add, а не в _Put.
//
// Revision 1.30  2001/09/26 14:06:59  law
// - cleanup: l3NilObject заменен на _l3NilOp.
//
// Revision 1.29  2001/09/26 13:03:05  law
// - optimize: уменьшение размера Undo-буфера.
//
// Revision 1.28  2001/06/18 14:32:50  law
// - cleanup.
//
// Revision 1.27  2001/05/31 11:16:52  law
// - cleanup: убрана работа с сообщениями em_* за ненадобностью.
//
// Revision 1.26  2001/03/23 17:45:22  law
// - интерфейсу Il3OpPack добавлено свойство Processor.
//
// Revision 1.25  2001/03/13 18:44:34  law
// - some cleaning, tuning & comments.
//
// Revision 1.24  2001/01/31 10:37:32  law
// - оптимизировано использование QueryInterface.
//
// Revision 1.23  2000/12/15 15:19:01  law
// - вставлены директивы Log.
//

{$Include l3Define.inc }

interface

uses
  Messages,
  Classes,

  l3Types,
  l3Interfaces,
  l3Base,
  l3InternalInterfaces,
  l3Msg,
  l3Except,
  l3CacheableBase,
  l3CProtoObject,

  k2Prim
  ;

type
  Tk2Op = class(Tl3CProtoObject)
   {* Базовый класс для реализация операции. }
    protected
    {internal methods}
      procedure DoUndo(const Container: Ik2Op);
        virtual;
        {* - отменить операцию. Для перекрытия в потомках. }
      procedure DoRedo(const Container: Ik2Op);
        virtual;
        {* -повторить операцию. Для перекрытия в потомках. }
      function CanJoinWith(anOperation: Tk2Op): Bool;
        virtual;
        {* - можно ли объединить с другой операцией? Для перекрытия в потомках. }
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        virtual;
        {* - соединяет две операции и возвращает:
             |<br>
             |<b>nil</b>  - соединение неудачно.<br>
             |<b>Self</b> - соединение удачно и все поместилось в старую запись.<br>
             |<b>New</b>  - распределена новая операция.<br>
             |<b>l3NilOp</b> - операции анигилировали. }
    protected
    // property methods
      function pm_GetFlags: Tl3OperationFlags;
        virtual;
        {* - метод для чтения свойства Flags. Для перекрытия в потомках. }
    public
    // public methods
      class procedure ToUndo(const anOpPack : Ik2Op);
        {-}
      procedure Put(const anOpPack : Ik2Op;
                    Modify         : Boolean = false);
        {-}
      function Undo(const Container: Ik2Op): Bool;
        {* - отменить операцию. }
      function Redo(const Container: Ik2Op): Bool;
        {* - повторить операцию. }
      function CanLinkWith(anOperation: Tk2Op): Bool;
        virtual;
        {* - можно ли сцепить с другой операцией? Для перекрытия в потомках. }
      function JoinWith(P: Tk2Op; const Container: Ik2Op = nil): Long;
        virtual;
        {* - соединяет Self с P и возвращает 0 если это возможно
          иначе - возвращает -1. Может поднимать El3NewOperation, если создана новая операция. }
      function  CompareWith(anOp: Tk2Op): Integer;
        virtual;
        {-}
      function  RestrictJoin: Boolean;
        virtual;
        {-}  
    public
    // public properties
      property Flags: Tl3OperationFlags
        read pm_GetFlags;
        {* - флаги операции. }
  end;//Tk2Op

  El3NewOperation = class(El3Warning)
   {* Исключительная ситуация, сигнализирующая о создании новой операции. }
    public
    // public fields
      Op : Tk2Op;
        {* - вновь созданная операция. }
  end;//El3NewOperation

implementation

uses
  SysUtils,

  l3Const,
  l3Message,
  l3InterfacesMisc,
  l3IntegerValueMapManager,
  l3String,

  k2NilOp,
  k2OperationContainer
  ;

// start class Tk2Op 

procedure Tk2Op.DoUndo(const Container: Ik2Op);
  {virtual;}
  {-отменить операцию}
begin
end;

procedure Tk2Op.DoRedo(const Container: Ik2Op);
  {virtual;}
  {-повторить операцию}
begin
end;

function Tk2Op.CanJoinWith(anOperation: Tk2Op): Bool;
  {virtual;}
  {-}
begin
 Result := false;
end;

function Tk2Op.DoJoin(anOperation: Tk2Op): Tk2Op;
  {virtual;}
  {-соединяет две операции и возвращает:
    nil  - соединение неудачно
    Self - соединение удачно и все поместилось в старую запись
    New  - распределена новая операция }
  {-}
begin
 Result := nil;
end;

function Tk2Op.pm_GetFlags: Tl3OperationFlags;
  {virtual;}
  {-}
begin
 Result := [ofCanUndo, ofCanRedo];
end;

class procedure Tk2Op.ToUndo(const anOpPack : Ik2Op);
  {-}
var
 l_Op : Tk2Op;
begin
 if (anOpPack <> nil) then
 begin
  l_Op := Create;
  try
   l_Op.Put(anOpPack);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

procedure Tk2Op.Put(const anOpPack : Ik2Op;
                    Modify         : Boolean = false);
  {-}
var
 l_Op : Ik2OpPackInternal;
begin
 if (anOpPack <> nil) then
  if Supports(anOpPack, Ik2OpPackInternal, l_Op) then
   try
    l_Op.Put(Self, Modify);
   finally
    l_Op := nil;
   end;//try..finally
end;
  
function Tk2Op.Undo(const Container: Ik2Op): Bool;
  {-отменить операцию}
begin
 Result := true;
 if (ofCanUndo in Flags) then
  DoUndo(Container)
 else
  Result := false;
end;

function Tk2Op.Redo(const Container: Ik2Op): Bool;
  {-повторить операцию}
begin
 Result := true;
 if (ofCanRedo in Flags) then
  DoRedo(Container)
 else
  Result := false;
end;

function Tk2Op.CanLinkWith(anOperation: Tk2Op): Bool;
  {virtual;}
  {-}
begin
 Result := (anOperation Is ClassType);
end;

function Tk2Op.JoinWith(P: Tk2Op; const Container: Ik2Op = nil): Long;
  {override;}
  {-соединяет Self с anOperation и возвращает true если это возможно
    иначе - возвращает false}
var
 Res : Tk2Op;
 E   : El3NewOperation;
begin
 if CanJoinWith(P) then
 begin
  Res := DoJoin(P);
  if (Res = nil) then
   Result := -1
  else
  if (Res = Self) then
   Result := 0
  else
  begin
   if (Res = Tk2NilOp.Instance) then
   begin
    E := El3NewOperation.Create('');
    E.Op := Res.Use;
   end//Res = Tk2NilOp.Instance
   else
   begin
    E := El3NewOperation.CreateFmt(l3_MesNewUndoOperation, [Res.ClassName]);
    E.Op := Res;
   end;//Res = Tk2NilOp.Instance
   raise E;
  end;//Res = Self
 end//CanJoinWith(P)
 else
  Result := -1;
end;

function Tk2Op.CompareWith(anOp: Tk2Op): Integer;
  //override;
  {-}
begin
 Result := Integer(Self) - Integer(anOp);
 //Assert(false, 'Зачем операции сортировать?');
 // - а вот зачем - http://mdp.garant.ru/pages/viewpage.action?pageId=269066487
 //   не сортировать, а искать.
end;

function Tk2Op.RestrictJoin: Boolean;
  //virtual;
  {-}
begin
 Result := false;
end;

end.

