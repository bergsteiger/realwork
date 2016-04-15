unit LongProcess_Form;
 {* Информация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LongProcess_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "LongProcess" MUID: (4A93DDCC03E3)
// Имя типа: "TLongProcessForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimLongProcess_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_LongProcessForm: TvcmFormDescriptor = (rFormID : (rName : 'LongProcessForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TLongProcessForm }

type
 TLongProcessForm = class;

 LongProcessFormDef = interface
  {* Идентификатор формы LongProcess }
  ['{D21B6517-D901-4E98-8A54-287D092EED98}']
 end;//LongProcessFormDef

 TLongProcessForm = {final} class(TPrimLongProcessForm, LongProcessFormDef)
  {* Информация }
 end;//TLongProcessForm

implementation

uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , LongProcessKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , LongProcess_ut_LongProcess_UserType
;

const
 {* Локализуемые строки ut_LongProcessLocalConstants }
 str_ut_LongProcessCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LongProcessCaption'; rValue : 'Информация');
  {* Заголовок пользовательского типа "Информация" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLongProcessForm);
 {* Регистрация LongProcess }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_LongProcessCaption.Init;
 {* Инициализация str_ut_LongProcessCaption }

end.
