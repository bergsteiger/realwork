unit evUndoB;
{* Реализация Undo-буфера. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В.       }
{ Модуль: evUndoB - описание Undo буфера}
{ Начат: 05.06.1997 12:07 }
{ $Id: evUndoB.pas,v 1.37 2014/03/25 14:31:45 lulin Exp $ }

// $Log: evUndoB.pas,v $
// Revision 1.37  2014/03/25 14:31:45  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.36  2012/02/03 17:09:11  lulin
// {RequestLink:333548940}
// - рисуем изменения Жени на модели.
//
// Revision 1.35  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.34  2011/05/18 17:45:16  lulin
// {RequestLink:266409354}.
//
// Revision 1.33  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.32  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.31  2008/11/11 09:01:44  lulin
// - <K>: 114459503.
// - F1 не собиралась.
//
// Revision 1.30  2008/11/10 15:42:50  lulin
// - <K>: 114459503. Теперь и превью и контейнер документа обладают списком разрывов разделов.
//
// Revision 1.29  2008/08/25 15:14:47  lulin
// - <K>: 100011305.
//
// Revision 1.28  2008/03/21 15:41:37  lulin
// - <K>: 87591144.
//
// Revision 1.27  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.26  2008/03/03 13:20:27  lulin
// - nevTools перенесён на модель. Теперь всё компилируется.
//
// Revision 1.25  2008/02/12 10:31:18  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.24  2008/02/07 09:32:56  lulin
// - подготавливаемся к переносу списка целых на модель.
//
// Revision 1.23  2008/02/05 09:57:38  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.22  2007/12/04 12:47:07  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.19.24.10  2007/11/28 13:24:28  dinishev
// Совместимость с Арчи
//
// Revision 1.19.24.9  2007/09/07 12:52:52  lulin
// - удален ненужный параметр.
//
// Revision 1.19.24.8  2007/04/20 11:07:19  lulin
// - убираем ненужную функциональность.
//
// Revision 1.19.24.7  2006/01/12 13:16:48  lulin
// - bug fix: не склеиваем операции в пачки, т.к. на дереве есть проблемы с удалением.
//
// Revision 1.19.24.6  2006/01/12 11:57:41  lulin
// - cleanup.
//
// Revision 1.19.24.5  2005/11/18 13:26:24  lulin
// - в процедуру конца модификации теперь можно подавать пачку операций.
//
// Revision 1.19.24.4  2005/11/11 22:23:15  lulin
// - избавляемся от управления свойством модифицированности документа путем посылки сообщений.
//
// Revision 1.19.24.3  2005/11/11 21:52:13  lulin
// - bug fix: убраны утечки объектов документа, связанные с неправильным владением Undo-буфером.
//
// Revision 1.19.24.2  2005/11/11 18:04:07  lulin
// - выделен интерфейс Undo-буфера.
//
// Revision 1.19.24.1  2005/11/09 15:28:25  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.19  2004/06/01 16:51:19  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.18  2003/03/19 10:47:33  law
// - new directives: evForEE, _evNeedDisp, _evNotNeedDisp.
//
// Revision 1.17  2002/12/26 12:58:23  law
// - new dll: собрана pe.dll без _evDisp.
//
// Revision 1.16  2001/10/15 15:02:36  law
// - bug fix: вызов событий при удалении.
//
// Revision 1.15  2001/09/26 14:06:59  law
// - cleanup: l3NilObject заменен на _l3NilOp.
//
// Revision 1.14  2001/06/01 08:41:40  law
// - comments: добавлены комментарии для xHepGen.
//
// Revision 1.13  2001/06/01 08:11:07  law
// - cleanup: убрана работа с ненужными сообщениями, а также ненужные зависимости между модулями.
//
// Revision 1.12  2001/05/31 11:16:52  law
// - cleanup: убрана работа с сообщениями em_* за ненадобностью.
//
// Revision 1.11  2000/12/15 15:10:39  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Classes,
  Messages,

  l3Interfaces,
  l3Base,
  l3Types,
  l3Msg,
  l3Variant,

  k2Prim,
  k2OperationContainerRefList,

  nevTools
  ;

type
  TevCustomUndoBuffer = class(Tk2OperationContainerRefList, Ik2UndoBuffer)
   {* Базовый класс для реализации Undo-буфера. }
    private
    // internal fields
      f_Active   : Long;
      f_InClear  : Boolean;
      f_Disabled : Boolean;
    protected
    // property methods
      function  pm_GetCanUndo: Bool;
        {-}
      function  pm_GetCanRedo: Bool;
        {-}
      function  Get_Last: TObject;
        {-}
      function Get_Empty: Boolean;
        {-}
      function Get_Disabled: Bool;
        {-}
      procedure Set_Disabled(Value: Bool);
        {-}
    protected
    // internal methods
      procedure DoCanUndoChange;
        {-}
      procedure DoCanRedoChange;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class function Make: Ik2UndoBuffer;
        reintroduce;
        {-}
      procedure Clear;
        override;
        {-}
      function  GetActiveObject(aSucc: Boolean): TObject;
        {-}
      procedure ExecutedOperation(aContainer : TObject);
        {* - нотификация буферу о новой пачке операций. }
      function  Undo(const aProcessor: InevProcessor): Boolean;
        {* - отменить предыдущую операцию. }
      function  Redo(const aProcessor: InevProcessor): Boolean;
        {* - вернуть отмененную операцию. }
    public
    // public properties
      property Active: Long
        read f_Active;
        {* - индекс текущей операции. }
      property Disabled: Bool
        read Get_Disabled
        write Set_Disabled
        default false;
        {* - запрещено ли сохранение операций? }
      property CanUndo: Bool
        read pm_GetCanUndo;
        {* - можно ли отменить операцию? }
      property CanRedo: Bool
        read pm_GetCanRedo;
        {* - можно ли вернуть операцию? }
  end;//TevCustomUndoBuffer

  TevUndoBuffer = class(TevCustomUndoBuffer)
   {*! Класс для реализации Undo-буфера. }
  end;//TevUndoBuffer

implementation

uses
  l3Const,
  
  k2OperationContainer,
  k2Op,
  k2NilOp

  {$IfDef evUseVisibleCursors}
  ,
  evInternalInterfaces
  {$EndIf evUseVisibleCursors}
  {$IfDef evNeedDisp}
  ,
  evDisp,
  evStandardActions
  {$EndIf evNeedDisp}
  ;

// start class TevUndoBuffer

class function TevCustomUndoBuffer.Make: Ik2UndoBuffer;
  //reintroduce;
  {-}
var
 l_Buf : TevCustomUndoBuffer;
begin
 l_Buf := Create;
 try
  Result := l_Buf;
 finally
  l3Free(l_Buf);
 end;//try..finally
end;

procedure TevCustomUndoBuffer.Cleanup;
  //override;
  {-}
begin
 Clear;
 inherited;
end;

procedure TevCustomUndoBuffer.DoCanUndoChange;
  {-}
begin
 {$IfDef evNeedDisp}
 evOperationDispatcher.OperationEnabled[ev_ccUndo] := CanUndo;
 {$EndIf evNeedDisp}
end;

procedure TevCustomUndoBuffer.DoCanRedoChange;
  {-}
begin
 {$IfDef evNeedDisp}
 evOperationDispatcher.OperationEnabled[ev_ccRedo] := CanRedo;
 {$EndIf evNeedDisp}
end;

function TevCustomUndoBuffer.pm_GetCanUndo: Bool;
  {-}
begin
 Result := ((Self <> nil) AND (Count > 0) AND (f_Active >= 0));
end;

function TevCustomUndoBuffer.pm_GetCanRedo: Bool;
  {-}
begin
 Result := ((Self <> nil) AND (Count > 0) AND (Succ(f_Active) < Count));
end;

function TevCustomUndoBuffer.Get_Last: TObject;
  {-}
begin
 Result := Last;
end;

procedure TevCustomUndoBuffer.Clear;
  {override;}
  {-}
begin
 if not f_InClear then
 begin
  f_InClear := true;
  try
   inherited;
  finally
   f_InClear := false;
  end;//try..finally
 end;//not f_InClear
end;

function TevCustomUndoBuffer.GetActiveObject(aSucc: Boolean): TObject;
  {-}
begin
 if aSucc then
  Result := Items[Succ(Active)]
 else
  Result := Items[Active];
end;

type
  Tk2OperationContainerHack = class(Tk2OperationContainer);

procedure TevCustomUndoBuffer.ExecutedOperation(aContainer : TObject);
  {-}
var
 PC        : Tk2OperationContainer;
 Container : Tk2OperationContainer;

 procedure DoJoin;
 begin//DoJoin
  PC.JoinWith(Container);
  Container.Clear;
  //Changed;
 end;//DoJoin

var
 OCU : Bool;
 OCR : Bool;
 Res : Long;
 I0  : Tk2Op;
 IHi : Tk2Op;
 {$IfDef evUseVisibleCursors}
 l_CursorContext : IevCursorContext;
 {$EndIf evUseVisibleCursors}
begin
 if (Self <> nil) then
 begin
  Container := aContainer As Tk2OperationContainer;
  if Il3OpPack(Container).SaveUndo AND not f_InClear AND not f_Disabled then
  begin
   //Container.Owner := Self;
   // - это специально закомментированно, т.к. приводило к неудалению процессора
   {$IfDef evUseVisibleCursors}
   if (Container <> nil) AND
      l3IOk(Container.QueryInterface(IevCursorContext, l_CursorContext)) then
    try
     l_CursorContext.StopRecord;
    finally
     l_CursorContext := nil;
    end;//try..finally
   {$EndIf evUseVisibleCursors}
   if not Container.Empty then
   begin
    OCU := CanUndo;
    OCR := CanRedo;
    f_InClear := true;
    try
     while (Succ(f_Active) < Count) do
      Delete(Succ(f_Active));
    finally
     f_InClear := false;
    end;{try..finally}
    if (Count > 0) then
    begin
     PC := Items[f_Active];
     if (Container.Count > 0) then
      I0 := Container.Items[0]
     else
      I0 := nil;
     if (PC.Count > 0) then
      IHi := PC.Items[PC.Hi]
     else
      IHi := nil;
     if (IHi = nil) then
     begin
      if (PC.Code = Container.Code) then
       DoJoin;
     end//IHi = nil
     else
     begin
      try
       Res := IHi.JoinWith(I0, nil);
       if (Res = l3NilLong) then
       begin
        Container.Delete(0);
        PC.Delete(PC.Hi);
        if PC.Empty then
        begin
         Delete(f_Active);
         Dec(f_Active);
         if (f_Active < 0) then
          PC := nil
         else
          PC := Items[f_Active];
        end;{PC.Empty}
        if (PC <> nil) then
         DoJoin;
       end//Res = l3NilLong
       else
       if (Res >= 0) then
       begin
        Container.Delete(0);
        DoJoin;
       end//Res >= 0
       else
       if IHi.CanLinkWith(I0) then
        DoJoin
       else
       if (PC.Code = Container.Code) then
        if not IHi.RestrictJoin AND ((I0 = nil) OR not I0.RestrictJoin) then
         DoJoin;
      except
       on E : El3NewOperation do
       begin
        if (E.Op = Tk2NilOp.Instance) then
         PC.Delete(PC.Hi)
        else
         PC.Items[PC.Hi] := E.Op;
        l3Free(E.Op);
        Container.Delete(0);
        DoJoin;
        if PC.Empty then
        begin
         Delete(f_Active);
         Dec(f_Active);
        end;//PC.Empty
       end;//El3NewOperation
      end;//try..except
     end;//IHi = nil
    end;//Count > 0..
    if not Container.Empty then
     f_Active := Add(Container);
    Tk2OperationContainerHack(Container).DoSetOwner(nil);
    if (OCU <> CanUndo) then
     DoCanUndoChange;
    if (OCR <> CanRedo) then
     DoCanRedoChange;
   end;//not Container.Empty
  end;//Op <> nil..
 end;//Self <> nil
end;

function TevCustomUndoBuffer.Undo(const aProcessor: InevProcessor): Boolean;
  {-}
var
 OCR : Bool;
begin
 if CanUndo then
 begin
  Assert(aProcessor <> nil);
  Result := true;
  OCR := CanRedo;
  Il3OpPack(Tk2OperationContainer(Items[f_Active])).Undo(aProcessor);
  Dec(f_Active);
  if not CanUndo then
   DoCanUndoChange;
  if (OCR <> CanRedo) then
   DoCanRedoChange;
 end//CanUndo
 else
  Result := false;
end;

function TevCustomUndoBuffer.Redo(const aProcessor: InevProcessor): Boolean;
  {-}
var
 OCU : Bool;
begin
 if CanRedo then
 begin
  Assert(aProcessor <> nil);
  Result := true;
  OCU := CanUndo;
  Inc(f_Active);
  Il3OpPack(Tk2OperationContainer(Items[f_Active])).Redo(aProcessor);
  if (OCU <> CanUndo) then
   DoCanUndoChange;
  if not CanRedo then
   DoCanRedoChange;
 end//CanRedo
 else
  Result := false;
end;

function TevCustomUndoBuffer.Get_Empty: Boolean;
  {-}
begin
 Result := Empty;
end;

function TevCustomUndoBuffer.Get_Disabled: Bool;
begin
 Result := f_Disabled;
end;

procedure TevCustomUndoBuffer.Set_Disabled(Value: Bool);
begin
 f_Disabled := Value;
end;

end.

