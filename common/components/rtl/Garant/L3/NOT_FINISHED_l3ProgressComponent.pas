unit NOT_FINISHED_l3ProgressComponent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В. ©
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3ProgressComponent.pas"
// Начат: 18.05.2000 14:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ProgressComponent
//
// Базовый класс компонентов, имеющих индикатор прогресса.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3InterfacedComponent
  ;

type
 Tl3ProgressComponent = class(Tl3InterfacedComponent, Il3Progress)
  {* Базовый класс компонентов, имеющих индикатор прогресса. }
 protected
 // realized methods
   procedure Start(Count: Integer;
    const aMsg: Il3CString); overload; 
     {* начать процесс. }
   procedure Start(Count: Large;
    const aMsg: Il3CString); overload; 
     {* начать процесс. }
   procedure Finish;
     {* закончить процесс. }
   procedure Progress(Current: Integer); overload; 
     {* изменить текущее состояние. }
   procedure Progress(Current: Large); overload; 
     {* изменить текущее состояние. }
   procedure ProgressEx(Current: Integer;
    const aMsg: Il3CString);
   procedure ChangeIO(Start: Boolean);
     {* изменить флаг InIO. }
   function InIO: Boolean;
     {* в процессе ввода/вывода? }
   function InUse: Boolean;
 end;//Tl3ProgressComponent

implementation

// start class Tl3ProgressComponent

procedure Tl3ProgressComponent.Start(Count: Integer;
  const aMsg: Il3CString);
//#UC START# *476F75DE01E9_4754200F029E_var*
//#UC END# *476F75DE01E9_4754200F029E_var*
begin
//#UC START# *476F75DE01E9_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.Start not implemented');
//#UC END# *476F75DE01E9_4754200F029E_impl*
end;//Tl3ProgressComponent.Start

procedure Tl3ProgressComponent.Start(Count: Large;
  const aMsg: Il3CString);
//#UC START# *476F75F60302_4754200F029E_var*
//#UC END# *476F75F60302_4754200F029E_var*
begin
//#UC START# *476F75F60302_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.Start not implemented');
//#UC END# *476F75F60302_4754200F029E_impl*
end;//Tl3ProgressComponent.Start

procedure Tl3ProgressComponent.Finish;
//#UC START# *476F7608002D_4754200F029E_var*
//#UC END# *476F7608002D_4754200F029E_var*
begin
//#UC START# *476F7608002D_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.Finish not implemented');
//#UC END# *476F7608002D_4754200F029E_impl*
end;//Tl3ProgressComponent.Finish

procedure Tl3ProgressComponent.Progress(Current: Integer);
//#UC START# *476F76160143_4754200F029E_var*
//#UC END# *476F76160143_4754200F029E_var*
begin
//#UC START# *476F76160143_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.Progress not implemented');
//#UC END# *476F76160143_4754200F029E_impl*
end;//Tl3ProgressComponent.Progress

procedure Tl3ProgressComponent.Progress(Current: Large);
//#UC START# *476F7637011A_4754200F029E_var*
//#UC END# *476F7637011A_4754200F029E_var*
begin
//#UC START# *476F7637011A_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.Progress not implemented');
//#UC END# *476F7637011A_4754200F029E_impl*
end;//Tl3ProgressComponent.Progress

procedure Tl3ProgressComponent.ProgressEx(Current: Integer;
  const aMsg: Il3CString);
//#UC START# *476F76450378_4754200F029E_var*
//#UC END# *476F76450378_4754200F029E_var*
begin
//#UC START# *476F76450378_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.ProgressEx not implemented');
//#UC END# *476F76450378_4754200F029E_impl*
end;//Tl3ProgressComponent.ProgressEx

procedure Tl3ProgressComponent.ChangeIO(Start: Boolean);
//#UC START# *476F76550369_4754200F029E_var*
//#UC END# *476F76550369_4754200F029E_var*
begin
//#UC START# *476F76550369_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.ChangeIO not implemented');
//#UC END# *476F76550369_4754200F029E_impl*
end;//Tl3ProgressComponent.ChangeIO

function Tl3ProgressComponent.InIO: Boolean;
//#UC START# *476F76660313_4754200F029E_var*
//#UC END# *476F76660313_4754200F029E_var*
begin
//#UC START# *476F76660313_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.InIO not implemented');
//#UC END# *476F76660313_4754200F029E_impl*
end;//Tl3ProgressComponent.InIO

function Tl3ProgressComponent.InUse: Boolean;
//#UC START# *476F767601FC_4754200F029E_var*
//#UC END# *476F767601FC_4754200F029E_var*
begin
//#UC START# *476F767601FC_4754200F029E_impl*
 assert(false, 'Tl3ProgressComponent.InUse not implemented');
//#UC END# *476F767601FC_4754200F029E_impl*
end;//Tl3ProgressComponent.InUse

end.