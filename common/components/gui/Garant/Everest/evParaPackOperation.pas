unit evParaPackOperation;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В.       }
{ Модуль: evParaPackOperation - }
{ Начат: 18.10.2005 14:58 }
{ $Id: evParaPackOperation.pas,v 1.20 2015/01/19 18:36:36 lulin Exp $ }

// $Log: evParaPackOperation.pas,v $
// Revision 1.20  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.19  2014/04/09 13:12:03  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.17  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.16  2014/03/21 12:39:22  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.15  2014/03/07 14:53:48  lulin
// - перетряхиваем списки тегов.
//
// Revision 1.14  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.13  2009/07/23 08:14:39  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.12  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.11  2009/04/14 18:11:54  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.10  2009/03/31 12:04:36  lulin
// [$140286997].
//
// Revision 1.9  2008/05/08 16:10:55  lulin
// - изменения в рамках <K>: 90442475.
//
// Revision 1.8  2008/03/04 08:45:05  dinishev
// Bug fix: убираем лишнюю типизацию
//
// Revision 1.7  2008/02/08 19:58:22  lulin
// - <TDN>: 55.
//
// Revision 1.6  2008/02/05 09:57:38  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.5  2008/01/31 20:09:51  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.4  2008/01/31 18:53:27  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.3  2007/12/04 12:47:03  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.9  2006/11/21 12:09:53  lulin
// - cleanup.
//
// Revision 1.1.2.8  2006/01/16 12:19:37  lulin
// - не склеиваем в пачки операции вставки пачки параграфов (CQ OIT5-19080).
//
// Revision 1.1.2.7  2006/01/16 11:31:03  lulin
// - убран метод удаления параграфа, т.к. для этих целей полностью подходит метод удаления тега.
//
// Revision 1.1.2.6  2006/01/13 12:59:05  lulin
// - bug fix: в Undo-буфер попадала лишняя запись (CQ OIT5-19077).
//
// Revision 1.1.2.5  2005/12/03 14:46:53  lulin
// - избавляемся от хитросплетений методов TextSource и контейнера документа.
//
// Revision 1.1.2.4  2005/12/02 20:04:04  lulin
// - bug fix: асинхронное удаление параграфа портило Undo-буфер.
//
// Revision 1.1.2.3  2005/12/02 18:23:28  lulin
// - обрабока нотфификации об удалении/добавлении параграфа практически полностью перенесена на процессор.
//
// Revision 1.1.2.2  2005/11/07 14:08:32  lulin
// - от безликих тегов переходим к параграфам.
//
// Revision 1.1.2.1  2005/10/18 11:26:06  lulin
// - реализация Undo-записи удаления/добавления пачки параграфов, перенесена в правильное место.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Variant,
  
  k2Interfaces,
  k2AtomOperation,
  k2Op,
  k2SimpleTagList
  ;

type  
  Ok2AddChildren = class(Tk2AtomOperation)
    private
    // internal fields
      f_Deleted : Tk2SimpleTagList;
      f_Index   : Long;
    protected
    // internal methods
      procedure DoUndo(const Container: Ik2Op);
        override;
        {-отменить операцию}
      procedure DoRedo(const Container: Ik2Op);
        override;
        {-повторить операцию}
      function CanJoinWith(anOperation: Tk2Op): Boolean;
        override;
        {-}
      {$IfDef Nemesis}
      function  RestrictJoin: Boolean;
        override;
        {-}
      {$EndIf Nemesis}
    public
    // public methods
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        override;
        {-соединяет две операции и возвращает:
          nil  - соединение неудачно
          Self - соединение удачно и все поместилось в старую запись
          New  - распределена новая операция }
      function  SetParam(List : Tl3Variant;
                         const Prop : Tk2CustomPropertyPrim;
                         Index      : Long): Ok2AddChildren;
        reintroduce;                 
        {-}
      procedure Clear;
        override;
        {-}
    public
    // public properties
      property Deleted: Tk2SimpleTagList
        read f_Deleted{
        write f_Deleted};
        {-}
  end;//Ok2AddChildren

  Ok2DeleteChildren = class(Ok2AddChildren)
    protected
    // internal methods
      procedure DoUndo(const Container: Ik2Op);
        override;
        {-отменить операцию}
      procedure DoRedo(const Container: Ik2Op);
        override;
        {-повторить операцию}
      function CanJoinWith(anOperation: Tk2Op): Boolean;
        override;
        {-}
  end;//Ok2DeleteChildren

implementation

{$IfNDef k2ForEditor}
//  !!! Ошибка: не определена директива k2ForEditor.
{$EndIf  k2ForEditor}

uses
  k2OpMisc,
  k2Base,
  k2InternalInterfaces,

  evBseOp,
  evInternalInterfaces,

  nevTools
  ;

// start class Ok2AddChildren 

procedure Ok2AddChildren.DoUndo(const Container: Ik2Op);
  {override;}
  {-отменить операцию}
var
 i          : Long;
 l_List     : Tl3Variant;
 l_DelIndex : Integer;
begin
 i := 0;
 l_List := Atom;
 l_DelIndex := f_Index;
 while (i < f_Deleted.Count) do
 begin
  if not l_List.DeleteChild(l_DelIndex, Container) then
   Inc(l_DelIndex);
  Inc(i);
 end;//while (i < f_Deleted.Count)
end;

procedure Ok2AddChildren.DoRedo(const Container: Ik2Op);
  {override;}
  {-повторить операцию}
var
 l_Index : Long;
 l_PL    : InevParaListModify;
 l_PL1   : InevParaList;
begin
 l_Index := 0;
 if Atom.QT(InevParaList, l_PL1, k2Proc(Container)) then
  try
   l_PL := l_PL1.Modify;
   try
    while (l_Index < f_Deleted.Count) do
    begin
     l_PL.InsertPara(f_Index + l_Index, f_Deleted.Items[l_Index], Container);
     Inc(l_Index);
    end;//while (l_Index < f_Deleted.Count)
   finally
    l_PL := nil;
   end;//try..finally 
   l_PL1.Invalidate([]);
  finally
   l_PL1 := nil;
  end;//try..finally
end;

function Ok2AddChildren.DoJoin(anOperation: Tk2Op): Tk2Op;
  {override;}
  {-соединяет две операции и возвращает:
    nil  - соединение неудачно
    Self - соединение удачно и все поместилось в старую запись
    New  - распределена новая операция }
var
 l_PID : Long;
begin
 if (anOperation Is OevInsertPara) AND (ofInsert in anOperation.Flags) AND
    (Atom.IsSame(OevInsertPara(anOperation).TagInst)) then
 begin
  l_PID := Pred(OevInsertPara(anOperation).PID - f_Index);
  if (l_PID >= 0) AND (l_PID <= f_Deleted.Count) then begin
   with f_Deleted do
    Insert(l_PID, OevInsertPara(anOperation).DeletedPara);
   Result := Self;
  end
  else
   Result := nil;
 end
 else
  Result := nil;
end;

function Ok2AddChildren.CanJoinWith(anOperation: Tk2Op): Boolean;
  {override;}
  {-}
begin
 Result := True;
end;

{$IfDef Nemesis}
function Ok2AddChildren.RestrictJoin: Boolean;
  //override;
  {-}
begin
 Result := True;
end;
{$EndIf Nemesis}

function Ok2AddChildren.SetParam(List : Tl3Variant;
                                 const Prop : Tk2CustomPropertyPrim;
                                  Index     : Long): Ok2AddChildren;
  {-}
begin
 inherited SetParam(List, Prop);
 f_Deleted := Tk2SimpleTagList.Make;
 f_Index := Index;
 Result := Self;
end;

procedure Ok2AddChildren.Clear;
  {override;}
  {-}
begin
 l3Free(f_Deleted);
 inherited;
end;

// start class Ok2DeleteChildren 

procedure Ok2DeleteChildren.DoUndo(const Container: Ik2Op);
  {override;}
  {-отменить операцию}
begin
 inherited DoRedo(Container);
end;

procedure Ok2DeleteChildren.DoRedo(const Container: Ik2Op);
  {override;}
  {-повторить операцию}
begin
 inherited DoUndo(Container);
end;

function Ok2DeleteChildren.CanJoinWith(anOperation: Tk2Op): Boolean;
  {override;}
  {-}
begin
 Result := False;
end;

end.

