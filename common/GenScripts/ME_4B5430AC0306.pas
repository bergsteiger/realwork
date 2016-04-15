unit SelfInfo_Form;
 {* Регистрационные данные }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SelfInfo_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "SelfInfo" MUID: (4B5430AC0306)
// Имя типа: "TSelfInfoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSelfInfo_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_SelfInfoForm: TvcmFormDescriptor = (rFormID : (rName : 'SelfInfoForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TSelfInfoForm }

type
 TSelfInfoForm = class;

 SelfInfoFormDef = interface
  {* Идентификатор формы SelfInfo }
  ['{58609172-F191-4A45-BABF-5983A3CBE791}']
 end;//SelfInfoFormDef

 TSelfInfoForm = {final} class(TPrimSelfInfoForm, SelfInfoFormDef)
  {* Регистрационные данные }
 end;//TSelfInfoForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , SelfInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SelfInfo_ut_SelfInfo_UserType
;

const
 {* Локализуемые строки ut_SelfInfoLocalConstants }
 str_ut_SelfInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_SelfInfoCaption'; rValue : 'Регистрационные данные');
  {* Заголовок пользовательского типа "Регистрационные данные" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSelfInfoForm);
 {* Регистрация SelfInfo }
{$IfEnd} // NOT Defined(NoScripts)
 fm_SelfInfoForm.SetFactory(TSelfInfoForm.Make);
 {* Регистрация фабрики формы SelfInfo }
 str_ut_SelfInfoCaption.Init;
 {* Инициализация str_ut_SelfInfoCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
