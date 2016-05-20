unit List_Form;
 {* Список }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\List_Form.pas"
// Стереотип: "VCMFinalContainer"
// Элемент модели: "List" MUID: (4A8921960298)
// Имя типа: "TefList"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TefList = {final} class(TPrimListOptionsForm, ListFormDef)
  {* Список }
   Entities : TvcmEntities;
 end;//TefList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PresentationInterfaces
 , resWarnImages
 , Base_Operations_Strange_Controls
 , Search_Strange_Controls
 , WorkWithList_ListOperations_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefList);
 {* Регистрация List }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efList.SetFactory(TefList.Make);
 {* Регистрация фабрики формы List }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
