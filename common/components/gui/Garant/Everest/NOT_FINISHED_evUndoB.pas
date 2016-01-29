unit NOT_FINISHED_evUndoB;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evUndoB.pas"
// Начат: 05.06.1997 12:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Processors::evUndoB
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Variant
  ;

type
 TevCustomUndoBuffer = class(, Ik2UndoBuffer)
  {* Базовый класс для реализации Undo-буфера. }
 protected
 // realized methods
   function GetActiveObject(aSucc: Boolean): TObject;
   procedure ExecutedOperation(aContainer: TObject);
     {* нотификация буферу о новой пачке операций. }
   function Undo(const aProcessor: Ik2Processor): Boolean;
     {* отменить предыдущую операцию. }
   function Redo(const aProcessor: Ik2Processor): Boolean;
     {* вернуть отмененную операцию. }
   procedure Clear;
     {* Очистить буфер операций. }
   function pm_GetCanUndo: Boolean;
   function pm_GetCanRedo: Boolean;
   function Get_Last: TObject;
   function Get_Empty: Boolean;
   function Get_Disabled: Boolean;
   procedure Set_Disabled(aValue: Boolean);
 end;//TevCustomUndoBuffer

 TevUndoBuffer = class(TevCustomUndoBuffer)
  {* Класс для реализации Undo-буфера. }
 end;//TevUndoBuffer

implementation

uses
  Classes
  {$If defined(evNeedDisp)}
  ,
  evStandardActions
  {$IfEnd} //evNeedDisp
  
  ;

// start class TevCustomUndoBuffer

function TevCustomUndoBuffer.GetActiveObject(aSucc: Boolean): TObject;
//#UC START# *47C5B14F00F1_4F5C4EB20139_var*
//#UC END# *47C5B14F00F1_4F5C4EB20139_var*
begin
//#UC START# *47C5B14F00F1_4F5C4EB20139_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B14F00F1_4F5C4EB20139_impl*
end;//TevCustomUndoBuffer.GetActiveObject

procedure TevCustomUndoBuffer.ExecutedOperation(aContainer: TObject);
//#UC START# *47C5B15D0015_4F5C4EB20139_var*
//#UC END# *47C5B15D0015_4F5C4EB20139_var*
begin
//#UC START# *47C5B15D0015_4F5C4EB20139_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B15D0015_4F5C4EB20139_impl*
end;//TevCustomUndoBuffer.ExecutedOperation

function TevCustomUndoBuffer.Undo(const aProcessor: Ik2Processor): Boolean;
//#UC START# *47C5B16C010D_4F5C4EB20139_var*
//#UC END# *47C5B16C010D_4F5C4EB20139_var*
begin
//#UC START# *47C5B16C010D_4F5C4EB20139_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B16C010D_4F5C4EB20139_impl*
end;//TevCustomUndoBuffer.Undo

function TevCustomUndoBuffer.Redo(const aProcessor: Ik2Processor): Boolean;
//#UC START# *47C5B17B0053_4F5C4EB20139_var*
//#UC END# *47C5B17B0053_4F5C4EB20139_var*
begin
//#UC START# *47C5B17B0053_4F5C4EB20139_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B17B0053_4F5C4EB20139_impl*
end;//TevCustomUndoBuffer.Redo

procedure TevCustomUndoBuffer.Clear;
//#UC START# *47C5B18A0183_4F5C4EB20139_var*
//#UC END# *47C5B18A0183_4F5C4EB20139_var*
begin
//#UC START# *47C5B18A0183_4F5C4EB20139_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B18A0183_4F5C4EB20139_impl*
end;//TevCustomUndoBuffer.Clear

function TevCustomUndoBuffer.pm_GetCanUndo: Boolean;
//#UC START# *47C5B1A20200_4F5C4EB20139get_var*
//#UC END# *47C5B1A20200_4F5C4EB20139get_var*
begin
//#UC START# *47C5B1A20200_4F5C4EB20139get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B1A20200_4F5C4EB20139get_impl*
end;//TevCustomUndoBuffer.pm_GetCanUndo

function TevCustomUndoBuffer.pm_GetCanRedo: Boolean;
//#UC START# *47C5B1B30355_4F5C4EB20139get_var*
//#UC END# *47C5B1B30355_4F5C4EB20139get_var*
begin
//#UC START# *47C5B1B30355_4F5C4EB20139get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B1B30355_4F5C4EB20139get_impl*
end;//TevCustomUndoBuffer.pm_GetCanRedo

function TevCustomUndoBuffer.Get_Last: TObject;
//#UC START# *47C5B1C500AC_4F5C4EB20139get_var*
//#UC END# *47C5B1C500AC_4F5C4EB20139get_var*
begin
//#UC START# *47C5B1C500AC_4F5C4EB20139get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B1C500AC_4F5C4EB20139get_impl*
end;//TevCustomUndoBuffer.Get_Last

function TevCustomUndoBuffer.Get_Empty: Boolean;
//#UC START# *47C5B1D302B9_4F5C4EB20139get_var*
//#UC END# *47C5B1D302B9_4F5C4EB20139get_var*
begin
//#UC START# *47C5B1D302B9_4F5C4EB20139get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B1D302B9_4F5C4EB20139get_impl*
end;//TevCustomUndoBuffer.Get_Empty

function TevCustomUndoBuffer.Get_Disabled: Boolean;
//#UC START# *47C5B1E90326_4F5C4EB20139get_var*
//#UC END# *47C5B1E90326_4F5C4EB20139get_var*
begin
//#UC START# *47C5B1E90326_4F5C4EB20139get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B1E90326_4F5C4EB20139get_impl*
end;//TevCustomUndoBuffer.Get_Disabled

procedure TevCustomUndoBuffer.Set_Disabled(aValue: Boolean);
//#UC START# *47C5B1E90326_4F5C4EB20139set_var*
//#UC END# *47C5B1E90326_4F5C4EB20139set_var*
begin
//#UC START# *47C5B1E90326_4F5C4EB20139set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B1E90326_4F5C4EB20139set_impl*
end;//TevCustomUndoBuffer.Set_Disabled
end.