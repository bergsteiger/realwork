unit NOT_FINISHED_vtCombo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtCombo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT::Combos::vtCombo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3Interfaces
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Mask
  {$IfEnd} //not NoVCL
  ,
  l3PureMixIns
  ;

type
 _l3Unknown_Parent_ = TCustomMaskEdit;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvtSimpleCustomCombo = class(_l3Unknown_)
 protected
 // protected methods
   procedure DoCloseUp(Accept: Boolean); virtual;
   function ProcessCommand(Cmd: Tl3OperationCode;
     aForce: Boolean;
     aCount: Integer): Boolean; virtual;
    {$If defined(Delphi7)}
   procedure UpdateButtonPosition; virtual;
     {* Сигнатура метода UpdateButtonPosition }
    {$IfEnd} //Delphi7
 public
 // public methods
   procedure DropDown; virtual;
     {* Сигнатура метода DropDown }
   procedure CloseUp(Accept: Boolean); virtual;
 end;//TvtSimpleCustomCombo

 TvtCustomCombo = class(TvtSimpleCustomCombo)
 protected
 // protected methods
   function GetDropDownContainer: TWinControl; virtual; abstract;
 end;//TvtCustomCombo

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

// start class TvtSimpleCustomCombo

procedure TvtSimpleCustomCombo.DoCloseUp(Accept: Boolean);
//#UC START# *52A9AF500143_52A9AD5F0269_var*
//#UC END# *52A9AF500143_52A9AD5F0269_var*
begin
//#UC START# *52A9AF500143_52A9AD5F0269_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A9AF500143_52A9AD5F0269_impl*
end;//TvtSimpleCustomCombo.DoCloseUp

function TvtSimpleCustomCombo.ProcessCommand(Cmd: Tl3OperationCode;
  aForce: Boolean;
  aCount: Integer): Boolean;
//#UC START# *554CA18500FB_52A9AD5F0269_var*
//#UC END# *554CA18500FB_52A9AD5F0269_var*
begin
//#UC START# *554CA18500FB_52A9AD5F0269_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA18500FB_52A9AD5F0269_impl*
end;//TvtSimpleCustomCombo.ProcessCommand

{$If defined(Delphi7)}
procedure TvtSimpleCustomCombo.UpdateButtonPosition;
//#UC START# *554CBBA3004E_52A9AD5F0269_var*
//#UC END# *554CBBA3004E_52A9AD5F0269_var*
begin
//#UC START# *554CBBA3004E_52A9AD5F0269_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBBA3004E_52A9AD5F0269_impl*
end;//TvtSimpleCustomCombo.UpdateButtonPosition
{$IfEnd} //Delphi7

procedure TvtSimpleCustomCombo.DropDown;
//#UC START# *554CBC32006E_52A9AD5F0269_var*
//#UC END# *554CBC32006E_52A9AD5F0269_var*
begin
//#UC START# *554CBC32006E_52A9AD5F0269_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBC32006E_52A9AD5F0269_impl*
end;//TvtSimpleCustomCombo.DropDown

procedure TvtSimpleCustomCombo.CloseUp(Accept: Boolean);
//#UC START# *554CBC4500ED_52A9AD5F0269_var*
//#UC END# *554CBC4500ED_52A9AD5F0269_var*
begin
//#UC START# *554CBC4500ED_52A9AD5F0269_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBC4500ED_52A9AD5F0269_impl*
end;//TvtSimpleCustomCombo.CloseUp

initialization
{$If not defined(NoScripts)}
// Регистрация TvtSimpleCustomCombo
 TtfwClassRef.Register(TvtSimpleCustomCombo);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TvtCustomCombo
 TtfwClassRef.Register(TvtCustomCombo);
{$IfEnd} //not NoScripts

end.