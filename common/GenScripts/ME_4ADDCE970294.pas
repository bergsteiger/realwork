unit OfficeLikeRes;

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeRes.pas"
// Стереотип: "VCMApplication"

{$Include sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmApplication
 , vcmMainForm
 , OfficeLike_Usual_Controls
 , vcmExternalInterfaces
 , Classes
;

type
 TOfficeLikeMainForm = class(TvcmMainForm)
  protected
   procedure DoBack(const aParams: IvcmExecuteParamsPrim); virtual;
   procedure DoForward(const aParams: IvcmExecuteParamsPrim); virtual;
   function NeedTerminateOnExit: Boolean; virtual;
   function AskMayExit: Boolean; virtual;
  public
   procedure Exit; override;
   procedure Back; override;
    {* Назад }
   procedure Forward; override;
    {* Вперёд }
   constructor Create(AOwner: TComponent); override;
 end;//TOfficeLikeMainForm

 TOfficeLikeRes = {abstract} class(TvcmApplication)
 end;//TOfficeLikeRes
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , moToolbarMenu
 , vcmBaseOperationsCollectionItem
 , vcmUserControls
 , Windows
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TOfficeLikeMainForm.DoBack(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDE6B01A6_4ADDD3030251_var*
//#UC END# *4C8DDE6B01A6_4ADDD3030251_var*
begin
//#UC START# *4C8DDE6B01A6_4ADDD3030251_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8DDE6B01A6_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.DoBack

procedure TOfficeLikeMainForm.DoForward(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDEA5007E_4ADDD3030251_var*
//#UC END# *4C8DDEA5007E_4ADDD3030251_var*
begin
//#UC START# *4C8DDEA5007E_4ADDD3030251_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8DDEA5007E_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.DoForward

function TOfficeLikeMainForm.NeedTerminateOnExit: Boolean;
//#UC START# *4ADDD31E0091_4ADDD3030251_var*
//#UC END# *4ADDD31E0091_4ADDD3030251_var*
begin
//#UC START# *4ADDD31E0091_4ADDD3030251_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDD31E0091_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.NeedTerminateOnExit

function TOfficeLikeMainForm.AskMayExit: Boolean;
//#UC START# *4ADDD5A30139_4ADDD3030251_var*
//#UC END# *4ADDD5A30139_4ADDD3030251_var*
begin
//#UC START# *4ADDD5A30139_4ADDD3030251_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDD5A30139_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.AskMayExit

procedure TOfficeLikeMainForm.Exit;
//#UC START# *4ADDD377028F_4ADDD3030251_var*
//#UC END# *4ADDD377028F_4ADDD3030251_var*
begin
//#UC START# *4ADDD377028F_4ADDD3030251_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDD377028F_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.Exit

procedure TOfficeLikeMainForm.Back;
 {* Назад }
//#UC START# *4ADDDC550118_4ADDD3030251_var*
//#UC END# *4ADDDC550118_4ADDD3030251_var*
begin
//#UC START# *4ADDDC550118_4ADDD3030251_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDDC550118_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.Back

procedure TOfficeLikeMainForm.Forward;
 {* Вперёд }
//#UC START# *4ADDDC630097_4ADDD3030251_var*
//#UC END# *4ADDDC630097_4ADDD3030251_var*
begin
//#UC START# *4ADDDC630097_4ADDD3030251_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDDC630097_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.Forward

constructor TOfficeLikeMainForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4ADDD3030251_var*
//#UC END# *47D1602000C6_4ADDD3030251_var*
begin
//#UC START# *47D1602000C6_4ADDD3030251_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D1602000C6_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOfficeLikeMainForm);
 {* Регистрация OfficeLikeMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
