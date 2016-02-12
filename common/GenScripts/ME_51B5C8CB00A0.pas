unit NOT_FINISHED_vtCombo;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtCombo.pas"
// Стереотип: "UtilityPack"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Mask
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , l3PureMixIns
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 _l3Unknown_Parent_ = TCustomMaskEdit;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvtSimpleCustomCombo = class(_l3Unknown_)
  protected
   procedure DoCloseUp(Accept: Boolean); virtual;
   function ProcessCommand(Cmd: Tl3OperationCode;
    aForce: Boolean;
    aCount: Integer): Boolean; virtual;
   {$If Defined(Delphi7)}
   procedure UpdateButtonPosition; virtual;
   {$IfEnd} // Defined(Delphi7)
  public
   procedure DropDown; virtual;
   procedure CloseUp(Accept: Boolean); virtual;
 end;//TvtSimpleCustomCombo

 TvtCustomCombo = class(TvtSimpleCustomCombo)
  protected
   function GetDropDownContainer: TWinControl; virtual; abstract;
 end;//TvtCustomCombo

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

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

{$If Defined(Delphi7)}
procedure TvtSimpleCustomCombo.UpdateButtonPosition;
//#UC START# *554CBBA3004E_52A9AD5F0269_var*
//#UC END# *554CBBA3004E_52A9AD5F0269_var*
begin
//#UC START# *554CBBA3004E_52A9AD5F0269_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBBA3004E_52A9AD5F0269_impl*
end;//TvtSimpleCustomCombo.UpdateButtonPosition
{$IfEnd} // Defined(Delphi7)

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
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtSimpleCustomCombo);
 {* Регистрация TvtSimpleCustomCombo }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomCombo);
 {* Регистрация TvtCustomCombo }
{$IfEnd} // NOT Defined(NoScripts)

end.
