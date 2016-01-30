unit NOT_FINISHED_Logo_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\NOT_FINISHED_Logo_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

type
 TLogoForm = {final} class
 end;//TLogoForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , LogoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_LogoLocalConstants }
 str_ut_LogoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LogoCaption'; rValue : 'Logo');
  {* Заголовок пользовательского типа "Logo" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLogoForm);
 {* Регистрация Logo }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_LogoCaption.Init;
 {* Инициализация str_ut_LogoCaption }

end.
