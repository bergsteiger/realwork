unit StartupTips_Form;
 {* Совет дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\Forms\StartupTips_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "StartupTips" MUID: (4AB9DA410090)
// Имя типа: "TefStartupTips"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimStartupTips_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efStartupTips: TvcmFormDescriptor = (rFormID : (rName : 'efStartupTips'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefStartupTips }

type
 TefStartupTips = class;

 StartupTipsFormDef = interface
  {* Идентификатор формы StartupTips }
  ['{69581B33-5C00-46C8-8723-A5DE81DDD577}']
 end;//StartupTipsFormDef

 TefStartupTips = {final} class(TPrimStartupTipsForm, StartupTipsFormDef)
  {* Совет дня }
 end;//TefStartupTips
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
 , StartupTipsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_StartupTipsLocalConstants }
 str_ut_StartupTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_StartupTipsCaption'; rValue : 'Совет дня');
  {* Заголовок пользовательского типа "Совет дня" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefStartupTips);
 {* Регистрация StartupTips }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efStartupTips.SetFactory(TefStartupTips.Make);
 {* Регистрация фабрики формы StartupTips }
 str_ut_StartupTipsCaption.Init;
 {* Инициализация str_ut_StartupTipsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
