unit DefineSearchDate_Form;
 {* Дата }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\DefineSearchDate_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "DefineSearchDate" MUID: (4AB8CAF1009C)
// Имя типа: "Ten_DefineSearchDate"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDefineSearchDate_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_en_DefineSearchDate: TvcmFormDescriptor = (rFormID : (rName : 'en_DefineSearchDate'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_DefineSearchDate }

type
 Ten_DefineSearchDate = class;

 DefineSearchDateFormDef = interface
  {* Идентификатор формы DefineSearchDate }
  ['{95B053C2-B5BB-4EE7-9D05-E6333C48DF52}']
 end;//DefineSearchDateFormDef

 Ten_DefineSearchDate = {final} class(TPrimDefineSearchDateForm, DefineSearchDateFormDef)
  {* Дата }
 end;//Ten_DefineSearchDate
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
 , DefineSearchDateKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_DefineSearchDateLocalConstants }
 str_ut_DefineSearchDateCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DefineSearchDateCaption'; rValue : 'Дата');
  {* Заголовок пользовательского типа "Дата" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_DefineSearchDate);
 {* Регистрация DefineSearchDate }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_DefineSearchDateCaption.Init;
 {* Инициализация str_ut_DefineSearchDateCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
