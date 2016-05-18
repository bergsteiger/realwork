unit NOT_FINISHED_Logo_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\NOT_FINISHED_Logo_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "Logo" MUID: (4AA7E32D0252)
// Имя типа: "TLogoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 TLogoForm = {final} class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
 end;//TLogoForm

implementation

uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , Logo_ut_Logo_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LogoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки ut_LogoLocalConstants }
 str_ut_LogoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LogoCaption'; rValue : 'Logo');
  {* Заголовок пользовательского типа "Logo" }

initialization
 str_ut_LogoCaption.Init;
 {* Инициализация str_ut_LogoCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLogoForm);
 {* Регистрация Logo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
