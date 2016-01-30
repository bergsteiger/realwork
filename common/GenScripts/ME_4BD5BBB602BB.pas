unit PrimSaveLoadUserTypes_slqtPublishSource_UserType;
 {* Поиск: По источнику опубликования }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtPublishSource_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtOldKW_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы slqtPublishSource }
 slqtPublishSourceName = 'slqtPublishSource';
  {* Строковый идентификатор пользовательского типа "Поиск: По источнику опубликования" }
 slqtPublishSource = TvcmUserType(slqtOldKW + 1);
  {* Поиск: По источнику опубликования }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtPublishSource = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtPublishSource }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtPublishSource
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtPublishSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtPublishSource';
end;//Tkw_FormUserType_slqtPublishSource.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtPublishSource.GetInteger: Integer;
begin
 Result := slqtPublishSource;
end;//Tkw_FormUserType_slqtPublishSource.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtPublishSource.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtPublishSource }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
