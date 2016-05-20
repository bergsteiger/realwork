unit MemoryUsage_Form;
 {* Используемые ресурсы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsage_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "MemoryUsage" MUID: (4F882096008A)
// Имя типа: "TMemoryUsageForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MemoryUsagePrim_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_MemoryUsageForm: TvcmFormDescriptor = (rFormID : (rName : 'MemoryUsageForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TMemoryUsageForm }

type
 TMemoryUsageForm = class;

 MemoryUsageFormDef = interface
  {* Идентификатор формы MemoryUsage }
  ['{239C1E38-C6A8-4737-8D22-0F6E2D5E4762}']
 end;//MemoryUsageFormDef

 TMemoryUsageForm = {final} class(TMemoryUsagePrimForm, MemoryUsageFormDef)
  {* Используемые ресурсы }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TMemoryUsageForm
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
 , MemoryUsage_ut_MemoryUsage_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MemoryUsageKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_MemoryUsageLocalConstants }
 str_ut_MemoryUsageCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MemoryUsageCaption'; rValue : 'Используемые ресурсы');
  {* Заголовок пользовательского типа "Используемые ресурсы" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TMemoryUsageForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_MemoryUsageName,
  str_ut_MemoryUsageCaption,
  str_ut_MemoryUsageCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_MemoryUsageName
end;//TMemoryUsageForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMemoryUsageForm);
 {* Регистрация MemoryUsage }
{$IfEnd} // NOT Defined(NoScripts)
 fm_MemoryUsageForm.SetFactory(TMemoryUsageForm.Make);
 {* Регистрация фабрики формы MemoryUsage }
 str_ut_MemoryUsageCaption.Init;
 {* Инициализация str_ut_MemoryUsageCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
