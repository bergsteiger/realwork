unit EULA_Form;
 {* Условия использования }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\EULA_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "EULA" MUID: (4A93FB8C0121)
// Имя типа: "TefEULA"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimEULA_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efEULA: TvcmFormDescriptor = (rFormID : (rName : 'efEULA'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefEULA }

type
 EULAFormDef = interface
  {* Идентификатор формы EULA }
  ['{DF5FBE77-74EC-44AD-8636-CBFDE4947FC7}']
 end;//EULAFormDef

 TefEULA = {final} class(TPrimEULAForm, EULAFormDef)
  {* Условия использования }
 end;//TefEULA
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
 , EULAKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_EULALocalConstants }
 str_ut_EULACaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_EULACaption'; rValue : 'Условия использования');
  {* Заголовок пользовательского типа "Условия использования" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefEULA);
 {* Регистрация EULA }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efEULA.SetFactory(TefEULA.Make);
 {* Регистрация фабрики формы EULA }
 str_ut_EULACaption.Init;
 {* Инициализация str_ut_EULACaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
