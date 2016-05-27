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
 {$If NOT Defined(NoVCM)}
 , vcmEntities
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
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TSelfInfoForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SelfInfo_ut_SelfInfo_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SelfInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_SelfInfoLocalConstants }
 str_ut_SelfInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_SelfInfoCaption'; rValue : 'Регистрационные данные');
  {* Заголовок пользовательского типа "Регистрационные данные" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TSelfInfoForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_SelfInfoName,
  str_ut_SelfInfoCaption,
  str_ut_SelfInfoCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_SelfInfoName
end;//TSelfInfoForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_SelfInfoCaption.Init;
 {* Инициализация str_ut_SelfInfoCaption }
 fm_SelfInfoForm.SetFactory(TSelfInfoForm.Make);
 {* Регистрация фабрики формы SelfInfo }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSelfInfoForm);
 {* Регистрация SelfInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
