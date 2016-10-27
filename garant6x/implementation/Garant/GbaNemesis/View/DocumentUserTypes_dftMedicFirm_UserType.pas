unit DocumentUserTypes_dftMedicFirm_UserType;
 {* Описание фирмы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirm_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftMedicFirm" MUID: (4B041062003C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDrug_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки dftMedicFirmLocalConstants }
 str_dftMedicFirmCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmCaption'; rValue : 'Описание фирмы');
  {* Заголовок пользовательского типа "Описание фирмы" }
 {* Константы для типа формы dftMedicFirm }
 dftMedicFirmName = 'dftMedicFirm';
  {* Строковый идентификатор пользовательского типа "Описание фирмы" }
 dftMedicFirm = TvcmUserType(dftDrug + 1);
  {* Описание фирмы }
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
 Tkw_FormUserType_dftMedicFirm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftMedicFirm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftMedicFirm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftMedicFirm.GetInteger: Integer;
begin
 Result := dftMedicFirm;
end;//Tkw_FormUserType_dftMedicFirm.GetInteger

class function Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftMedicFirm';
end;//Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftMedicFirmCaption.Init;
 {* Инициализация str_dftMedicFirmCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftMedicFirm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
