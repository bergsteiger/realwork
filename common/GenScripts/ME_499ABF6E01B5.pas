unit NOT_FINISHED_ElPgCtl;

// Модуль: "w:\common\components\gui\Garant\VT\elClone\Source\NOT_FINISHED_ElPgCtl.pas"
// Стереотип: "UtilityPack"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , ElXPThemedControl
;

type
 TElTabPosition = (
 );//TElTabPosition

 TElTabSheet = class
 end;//TElTabSheet

 TElCustomPageControl = class(TElXPThemedControl)
  protected
   procedure RequestTabPosition; virtual;
  public
   procedure DoActivePrevPage; virtual;
 end;//TElCustomPageControl

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PageControlWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TElCustomPageControl.RequestTabPosition;
//#UC START# *52B9A7B2027D_4E36C0C3014B_var*
//#UC END# *52B9A7B2027D_4E36C0C3014B_var*
begin
//#UC START# *52B9A7B2027D_4E36C0C3014B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52B9A7B2027D_4E36C0C3014B_impl*
end;//TElCustomPageControl.RequestTabPosition

procedure TElCustomPageControl.DoActivePrevPage;
//#UC START# *52B9A85201C2_4E36C0C3014B_var*
//#UC END# *52B9A85201C2_4E36C0C3014B_var*
begin
//#UC START# *52B9A85201C2_4E36C0C3014B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52B9A85201C2_4E36C0C3014B_impl*
end;//TElCustomPageControl.DoActivePrevPage

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TElCustomPageControl);
 {* Регистрация TElCustomPageControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
