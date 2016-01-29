unit NOT_FINISHED_TB97;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "tb97"
// Модуль: "w:/common/components/rtl/external/tb97/NOT_FINISHED_TB97.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::tb97::tb97utils::TB97
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\tb97\TB97VER.INC}

interface

{$If not defined(NoTB97)}
uses
  tb97Control
  ;

type
 TCustomToolWindow97 = class(Ttb97Control)
 protected
 // protected methods
   procedure UpdateEmpty(aUpdateVisibility: Boolean = True); virtual;
   function NeedActivateMainForm: Boolean; virtual;
   procedure ActivateMainForm; virtual;
     {* Сигнатура метода ActivateMainForm }
 public
 // public methods
   procedure BeginUpdate; virtual;
     {* Сигнатура метода BeginUpdate }
   procedure EndUpdate; virtual;
     {* Сигнатура метода EndUpdate }
 end;//TCustomToolWindow97

 TDock97 = class(Ttb97Control)
 protected
 // protected methods
   function SizeGripWidth: Integer; virtual;
 end;//TDock97
{$IfEnd} //not NoTB97

implementation

{$If not defined(NoTB97)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TCustomToolWindow97

procedure TCustomToolWindow97.UpdateEmpty(aUpdateVisibility: Boolean = True);
//#UC START# *5028A1220383_50288A3D023C_var*
//#UC END# *5028A1220383_50288A3D023C_var*
begin
//#UC START# *5028A1220383_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A1220383_50288A3D023C_impl*
end;//TCustomToolWindow97.UpdateEmpty

procedure TCustomToolWindow97.BeginUpdate;
//#UC START# *5028A78000B6_50288A3D023C_var*
//#UC END# *5028A78000B6_50288A3D023C_var*
begin
//#UC START# *5028A78000B6_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A78000B6_50288A3D023C_impl*
end;//TCustomToolWindow97.BeginUpdate

procedure TCustomToolWindow97.EndUpdate;
//#UC START# *5028A78B015A_50288A3D023C_var*
//#UC END# *5028A78B015A_50288A3D023C_var*
begin
//#UC START# *5028A78B015A_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A78B015A_50288A3D023C_impl*
end;//TCustomToolWindow97.EndUpdate

function TCustomToolWindow97.NeedActivateMainForm: Boolean;
//#UC START# *552E0FD5016D_50288A3D023C_var*
//#UC END# *552E0FD5016D_50288A3D023C_var*
begin
//#UC START# *552E0FD5016D_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *552E0FD5016D_50288A3D023C_impl*
end;//TCustomToolWindow97.NeedActivateMainForm

procedure TCustomToolWindow97.ActivateMainForm;
//#UC START# *552E10010067_50288A3D023C_var*
//#UC END# *552E10010067_50288A3D023C_var*
begin
//#UC START# *552E10010067_50288A3D023C_impl*
 !!! Needs to be implemented !!!
//#UC END# *552E10010067_50288A3D023C_impl*
end;//TCustomToolWindow97.ActivateMainForm
// start class TDock97

function TDock97.SizeGripWidth: Integer;
//#UC START# *5028DD25024B_5028DD12007F_var*
//#UC END# *5028DD25024B_5028DD12007F_var*
begin
//#UC START# *5028DD25024B_5028DD12007F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028DD25024B_5028DD12007F_impl*
end;//TDock97.SizeGripWidth
{$IfEnd} //not NoTB97

initialization
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TCustomToolWindow97
 TtfwClassRef.Register(TCustomToolWindow97);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация TDock97
 TtfwClassRef.Register(TDock97);
{$IfEnd} //not NoScripts AND not NoTB97

end.