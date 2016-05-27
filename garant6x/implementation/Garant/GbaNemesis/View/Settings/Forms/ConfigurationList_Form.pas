unit ConfigurationList_Form;
 {* Конфигурации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\ConfigurationList_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "ConfigurationList" MUID: (4ABA146F00D4)
// Имя типа: "Ten_ConfigurationList"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimConfigurationList_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Ten_ConfigurationList = {final} class(TPrimConfigurationListForm, ConfigurationListFormDef)
  {* Конфигурации }
   Entities : TvcmEntities;
 end;//Ten_ConfigurationList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ConfigurationListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_en_ConfigurationList.SetFactory(Ten_ConfigurationList.Make);
 {* Регистрация фабрики формы ConfigurationList }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_ConfigurationList);
 {* Регистрация ConfigurationList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
