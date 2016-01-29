unit k2ChildOperation;

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2ChildOperation - }
{ Начат: 18.10.2005 14:33 }
{ $Id: k2ChildOperation.pas,v 1.9 2014/03/25 11:53:36 lulin Exp $ }

// $Log: k2ChildOperation.pas,v $
// Revision 1.9  2014/03/25 11:53:36  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.8  2014/03/21 12:39:25  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.7  2009/07/23 13:42:34  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.6  2009/07/22 17:16:40  lulin
// - оптимизируем использование счётчика ссылок и преобразование к интерфейсам при установке атрибутов тегов.
//
// Revision 1.5  2009/07/17 13:47:23  lulin
// - bug fix: неправильно обрабатывали удаление дочерних тегов.
//
// Revision 1.4  2009/07/07 08:58:27  lulin
// - вычищаем ненужное.
//
// Revision 1.3  2009/07/06 13:32:12  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.2  2007/09/04 14:24:59  lulin
// - убран ненужный параметр.
//
// Revision 1.1  2005/10/18 10:48:29  lulin
// - реализация базовой Undo-записи удаления/добавления тегов, перенесена в правильное место.
//

{$Include k2Define.inc }

interface

uses
  l3Types,
  l3Variant,
  
  k2Interfaces,
  k2AtomOperation,
  k2Op,
  k2Base
  ;

type  
  Ok2AddChild = class(Tk2AtomOperation)
    private
    // internal fields
      f_Child     : Tl3Variant;
      f_Index     : Long;
    protected
    // internal methods
      procedure DoUndo(const Container: Ik2Op);
        override;
        {-отменить операцию}
      procedure DoRedo(const Container: Ik2Op);
        override;
        {-повторить операцию}
    public
    // public methods
      class procedure ToUndo(const anOpPack : Ik2Op;
                             aList    : Tl3Variant;
                             const aProp    : Tk2Prop;
                             aChild   : Tl3Variant;
                             anIndex        : Long);
        reintroduce;                     
        {-}
      function  SetParam(List   : Tl3Variant;
                         const Prop   : Tk2Prop;
                         aChild : Tl3Variant;
                         Index        : Long): Ok2AddChild;
        reintroduce;
        {-}
      procedure Clear;
        override;
        {-}
      function CanJoinWith(anOperation: Tk2Op): Bool;
        override;
        {-}
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        override;
        {-соединяет две операции и возвращает:
          nil  - соединение неудачно
          Self - соединение удачно и все поместилось в старую запись
          New  - распределена новая операция }
      function CanLinkTo(anOp: Ok2AddChild): Tk2Op;
        virtual;
        {-}
    public
    // public properties
      property Index: Long
        read f_Index;
        {-}
      property Child: Tl3Variant
        read f_Child;
        {-}
  end;//Ok2AddChild

  Ok2DeleteChild = class(Ok2AddChild)
    protected
    // internal methods
      procedure DoUndo(const Container: Ik2Op);
        override;
        {-отменить операцию}
      procedure DoRedo(const Container: Ik2Op);
        override;
        {-повторить операцию}
  end;//Ok2DeleteChild

implementation

uses
  SysUtils,
  
  l3Base
  ;

// start class Ok2AddChild 

class procedure Ok2AddChild.ToUndo(const anOpPack : Ik2Op;
                                   aList    : Tl3Variant;
                                   const aProp    : Tk2Prop;
                                   aChild   : Tl3Variant;
                                   anIndex        : Long);
  {-}
var
 l_Op : Tk2Op;
begin
 if (anOpPack <> nil) then
 begin
  l_Op := Create.SetParam(aList, aProp, aChild, anIndex);
  try
   l_Op.Put(anOpPack);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

function Ok2AddChild.SetParam(List   : Tl3Variant;
                              const Prop   : Tk2Prop;
                              aChild : Tl3Variant;
                              Index        : Long): Ok2AddChild;
  {-}
begin
 inherited SetParam(List.AsObject, Prop);
 aChild.SetRef(f_Child);
 f_Index := Index;
 Result := Self;
end;

function Ok2AddChild.CanJoinWith(anOperation: Tk2Op): Bool;
  //override;
  {-}
begin
 Result := true;
end;

function Ok2AddChild.DoJoin(anOperation: Tk2Op): Tk2Op;
  //override;
  {-соединяет две операции и возвращает:
    nil  - соединение неудачно
    Self - соединение удачно и все поместилось в старую запись
    New  - распределена новая операция }
begin
 if (anOperation Is Ok2AddChild) then
  Result := Ok2AddChild(anOperation).CanLinkTo(Self)
 else
  Result := nil;
end;

function Ok2AddChild.CanLinkTo(anOp: Ok2AddChild): Tk2Op;
  //virtual;
  {-}
begin
 Result := nil; 
end;
  
procedure Ok2AddChild.Clear;
  {override;}
  {-}
begin
 FreeAndNil(f_Child);
 inherited;
end;

procedure Ok2AddChild.DoUndo(const Container: Ik2Op);
  {override;}
  {-отменить операцию}
begin
 if Child.IsValid then
  Atom.DeleteChild(Child, Container)
 else
  Atom.DeleteChild(f_Index, Container);
 //Tk2ArrayProperty(f_Prop).DeleteChild(Atom, f_Index, Child, Container);
end;

procedure Ok2AddChild.DoRedo(const Container: Ik2Op);
  {override;}
  {-повторить операцию}
var
 l_Child : Tl3Variant;  
begin
 l_Child := Child;
 f_Index := Atom.AddChild(l_Child, Container);
end;

// start class Ok2DeleteChild

procedure Ok2DeleteChild.DoUndo(const Container: Ik2Op);
  {override;}
  {-отменить операцию}
var
 l_Child : Tl3Variant;
begin
 l_Child := Child;
 f_Index := Atom.AddChild(l_Child, Container);
end;

procedure Ok2DeleteChild.DoRedo(const Container: Ik2Op);
  {override;}
  {-повторить операцию}
begin
 if Child.IsValid then
  Atom.DeleteChild(Child, Container)
 else
  Atom.DeleteChild(f_Index, Container);
 //Tk2ArrayProperty(f_Prop).DeleteChild(Atom, f_Index, Child, Container);
end;

end.

