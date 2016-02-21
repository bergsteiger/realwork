unit OfficeLikeMain_Form;

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeMain_Form.pas"
// Стереотип: "VCMMainForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
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
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , Windows
 , vcmBaseOperationsCollectionItem
 , vcmUserControls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TOfficeLikeMainForm.DoBack(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDE6B01A6_4ADDD3030251_var*
//#UC END# *4C8DDE6B01A6_4ADDD3030251_var*
begin
//#UC START# *4C8DDE6B01A6_4ADDD3030251_impl*
 Self.History.Back(aParams);
//#UC END# *4C8DDE6B01A6_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.DoBack

procedure TOfficeLikeMainForm.DoForward(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDEA5007E_4ADDD3030251_var*
//#UC END# *4C8DDEA5007E_4ADDD3030251_var*
begin
//#UC START# *4C8DDEA5007E_4ADDD3030251_impl*
 Self.History.Forward(aParams);
//#UC END# *4C8DDEA5007E_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.DoForward

function TOfficeLikeMainForm.NeedTerminateOnExit: Boolean;
//#UC START# *4ADDD31E0091_4ADDD3030251_var*
//#UC END# *4ADDD31E0091_4ADDD3030251_var*
begin
//#UC START# *4ADDD31E0091_4ADDD3030251_impl*
 Result := false;
//#UC END# *4ADDD31E0091_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.NeedTerminateOnExit

function TOfficeLikeMainForm.AskMayExit: Boolean;
//#UC START# *4ADDD5A30139_4ADDD3030251_var*
//#UC END# *4ADDD5A30139_4ADDD3030251_var*
begin
//#UC START# *4ADDD5A30139_4ADDD3030251_impl*
 Result := true;
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
 // http://mdp.garant.ru/pages/viewpage.action?pageId=470847610
{$If defined(Admin)}
 with dmStdRes.MenuManager.GetItemByName('enHistory') do
 begin
  with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opBack')) do
   Options := Options - [vcm_ooShowInMainMenu, vcm_ooShowInMainToolbar];
  with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opForward')) do
   Options := Options - [vcm_ooShowInMainMenu, vcm_ooShowInMainToolbar];
 end;
{$IfEnd defined(Admin)}
 inherited;
//#UC END# *47D1602000C6_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOfficeLikeMainForm);
 {* Регистрация OfficeLikeMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
