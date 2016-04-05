unit ListAnalizer_Form;
 {* Анализ списка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalizer_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "ListAnalizer" MUID: (4AA0CE0E02C4)
// Имя типа: "TListAnalizerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListAnalizer_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ListAnalizerForm: TvcmFormDescriptor = (rFormID : (rName : 'ListAnalizerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TListAnalizerForm }

type
 TListAnalizerForm = class;

 ListAnalizerFormDef = interface
  {* Идентификатор формы ListAnalizer }
  ['{534B1ADF-ACC6-4DD9-AF54-C92914E3CBA4}']
 end;//ListAnalizerFormDef

 TListAnalizerForm = {final} class(TPrimListAnalizerForm, ListAnalizerFormDef)
  {* Анализ списка }
 end;//TListAnalizerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListAnalizerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TListAnalizerForm);
 {* Регистрация ListAnalizer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
