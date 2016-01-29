unit NOT_FINISHED_k2Op;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/NOT_FINISHED_k2Op.pas"
// Начат: 07.12.1999 19:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::Operations::Tk2Op
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3CacheableBase,
  k2Prim
  ;

type
 Tk2Op = class(Tl3CacheableBase)
 protected
 // protected methods
   function CanJoinWith(anOperation: Tk2Op): Boolean; virtual;
   function DoJoin(anOperation: Tk2Op): Tk2Op; virtual;
     {* соединяет две операции и возвращает:
          nil  - соединение неудачно
          Self - соединение удачно и все поместилось в старую запись
          New  - распределена новая операция }
   procedure DoUndo(const Container: Ik2Op); virtual;
     {* отменить операцию }
   procedure DoRedo(const Container: Ik2Op); virtual;
     {* вернуть операцию }
 public
 // public methods
   function CompareWith(anOp: Tk2Op): Integer; virtual;
 end;//Tk2Op

implementation

uses
  k2NilOp
  ;

// start class Tk2Op

function Tk2Op.CompareWith(anOp: Tk2Op): Integer;
//#UC START# *4DF7856D027C_47E3C7030369_var*
//#UC END# *4DF7856D027C_47E3C7030369_var*
begin
//#UC START# *4DF7856D027C_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DF7856D027C_47E3C7030369_impl*
end;//Tk2Op.CompareWith

function Tk2Op.CanJoinWith(anOperation: Tk2Op): Boolean;
//#UC START# *47F107C80149_47E3C7030369_var*
//#UC END# *47F107C80149_47E3C7030369_var*
begin
//#UC START# *47F107C80149_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F107C80149_47E3C7030369_impl*
end;//Tk2Op.CanJoinWith

function Tk2Op.DoJoin(anOperation: Tk2Op): Tk2Op;
//#UC START# *47F107DF00E6_47E3C7030369_var*
//#UC END# *47F107DF00E6_47E3C7030369_var*
begin
//#UC START# *47F107DF00E6_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F107DF00E6_47E3C7030369_impl*
end;//Tk2Op.DoJoin

procedure Tk2Op.DoUndo(const Container: Ik2Op);
//#UC START# *47F1080F00E8_47E3C7030369_var*
//#UC END# *47F1080F00E8_47E3C7030369_var*
begin
//#UC START# *47F1080F00E8_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F1080F00E8_47E3C7030369_impl*
end;//Tk2Op.DoUndo

procedure Tk2Op.DoRedo(const Container: Ik2Op);
//#UC START# *47F1082B00D0_47E3C7030369_var*
//#UC END# *47F1082B00D0_47E3C7030369_var*
begin
//#UC START# *47F1082B00D0_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F1082B00D0_47E3C7030369_impl*
end;//Tk2Op.DoRedo

end.