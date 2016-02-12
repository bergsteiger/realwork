unit DocumentUserTypes_dftAACRight_UserType;
 {* Правая часть Энциклопедии решений }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACRight_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACLeft_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftAACRight }
 dftAACRightName = 'dftAACRight';
  {* Строковый идентификатор пользовательского типа "Правая часть Энциклопедии решений" }
 dftAACRight = TvcmUserType(dftAACLeft + 1);
  {* Правая часть Энциклопедии решений }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACRight = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAACRight }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAACRight
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAACRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAACRight';
end;//Tkw_FormUserType_dftAACRight.GetWordNameForRegister

function Tkw_FormUserType_dftAACRight.GetInteger: Integer;
begin
 Result := dftAACRight;
end;//Tkw_FormUserType_dftAACRight.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACRight.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAACRight }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
