unit PrimMedicFirmList_mflMain_UserType;
 {* Фармацевтические фирмы (полный список) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicFirmList_mflMain_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "mflMain" MUID: (4BD6DE050133)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы mflMain }
 mflMainName = 'mflMain';
  {* Строковый идентификатор пользовательского типа "Фармацевтические фирмы (полный список)" }
 mflMain = TvcmUserType(0);
  {* Фармацевтические фирмы (полный список) }
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
 Tkw_FormUserType_mflMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы mflMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_mflMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_mflMain.GetInteger: Integer;
begin
 Result := mflMain;
end;//Tkw_FormUserType_mflMain.GetInteger

class function Tkw_FormUserType_mflMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::mflMain';
end;//Tkw_FormUserType_mflMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mflMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_mflMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
