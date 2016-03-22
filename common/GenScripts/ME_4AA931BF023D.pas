unit SaveLoad_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\SaveLoad_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "SaveLoad" MUID: (4AA931BF023D)
// Имя типа: "TcfSaveLoad"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadOptionsWithUserTypes_Form
 , Search_FormDefinitions_Controls
;

type
 TcfSaveLoad = {final} class(TPrimSaveLoadOptionsWithUserTypesForm, SaveLoadFormDef)
 end;//TcfSaveLoad
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SaveLoadKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfSaveLoad);
 {* Регистрация SaveLoad }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfSaveLoad.SetFactory(TcfSaveLoad.Make);
 {* Регистрация фабрики формы SaveLoad }
{$IfEnd} // NOT Defined(Admin)

end.
