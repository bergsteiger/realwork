unit PrimMedicListSynchroView_mlsfMedicFirm_UserType;
 {* Описание }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfMedicFirm_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "mlsfMedicFirm" MUID: (4BD6C85300DB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicListSynchroView_mlsfDrugList_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки mlsfMedicFirmLocalConstants }
 str_mlsfMedicFirmCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mlsfMedicFirmCaption'; rValue : 'Описание');
  {* Заголовок пользовательского типа "Описание" }
 {* Константы для типа формы mlsfMedicFirm }
 mlsfMedicFirmName = 'mlsfMedicFirm';
  {* Строковый идентификатор пользовательского типа "Описание" }
 mlsfMedicFirm = TvcmUserType(mlsfDrugList + 1);
  {* Описание }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_mlsfMedicFirm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы mlsfMedicFirm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_mlsfMedicFirm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_mlsfMedicFirm.GetInteger: Integer;
begin
 Result := mlsfMedicFirm;
end;//Tkw_FormUserType_mlsfMedicFirm.GetInteger

class function Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::mlsfMedicFirm';
end;//Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_mlsfMedicFirmCaption.Init;
 {* Инициализация str_mlsfMedicFirmCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfMedicFirm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_mlsfMedicFirm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
