unit ForbidAutoregistration_Form;
 {* Запретить авторегистрацию }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\ForbidAutoregistration_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "ForbidAutoregistration" MUID: (4AA8E405032A)
// Имя типа: "TefForbidAutoregistration"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimForbidAutoregistrationOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efForbidAutoregistration: TvcmFormDescriptor = (rFormID : (rName : 'efForbidAutoregistration'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefForbidAutoregistration }

type
 TefForbidAutoregistration = class;

 ForbidAutoregistrationFormDef = interface
  {* Идентификатор формы ForbidAutoregistration }
  ['{5D4153F1-D087-4AF8-A4ED-39411EB7A1A3}']
 end;//ForbidAutoregistrationFormDef

 TefForbidAutoregistration = {final} class(TPrimForbidAutoregistrationOptionsForm, ForbidAutoregistrationFormDef)
  {* Запретить авторегистрацию }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TefForbidAutoregistration
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , ForbidAutoregistration_ut_ForbidAutoregistration_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ForbidAutoregistrationKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_ForbidAutoregistrationLocalConstants }
 str_ut_ForbidAutoregistrationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_ForbidAutoregistrationCaption'; rValue : 'Запретить авторегистрацию');
  {* Заголовок пользовательского типа "Запретить авторегистрацию" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TefForbidAutoregistration.MakeControls;
begin
 inherited;
 with AddUsertype(ut_ForbidAutoregistrationName,
  str_ut_ForbidAutoregistrationCaption,
  str_ut_ForbidAutoregistrationCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_ForbidAutoregistrationName
end;//TefForbidAutoregistration.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefForbidAutoregistration);
 {* Регистрация ForbidAutoregistration }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_ForbidAutoregistrationCaption.Init;
 {* Инициализация str_ut_ForbidAutoregistrationCaption }
{$IfEnd} // Defined(Admin)

end.
