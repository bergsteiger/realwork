unit QueryCard_Form;
 {* Карточка запросов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\QueryCard_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "QueryCard" MUID: (4AA9393C0164)
// Имя типа: "TenQueryCard"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCardOptions_Form
 , Search_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TenQueryCard = {final} class(TPrimQueryCardOptionsForm, QueryCardFormDef)
  {* Карточка запросов }
   Entities : TvcmEntities;
 end;//TenQueryCard
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , QueryCardKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_enQueryCard.SetFactory(TenQueryCard.Make);
 {* Регистрация фабрики формы QueryCard }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenQueryCard);
 {* Регистрация QueryCard }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
