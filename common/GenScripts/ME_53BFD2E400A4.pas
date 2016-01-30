unit DocumentUserTypes_dftChronology_UserType;
 {* Хронология судебного дела }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftChronology_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACContentsRight_UserType
 , DocumentUserTypes_dftRelatedDoc_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftChronology }
 dftChronologyName = 'dftChronology';
  {* Строковый идентификатор пользовательского типа "Хронология судебного дела" }
 dftChronology = TvcmUserType(dftAACContentsRight + 1);
  {* Хронология судебного дела }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftChronology = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftChronology }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftChronology
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftChronology.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftChronology';
end;//Tkw_FormUserType_dftChronology.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftChronology.GetInteger: Integer;
begin
 Result := dftChronology;
end;//Tkw_FormUserType_dftChronology.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftChronology.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftChronology }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
