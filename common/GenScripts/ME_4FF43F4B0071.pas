unit DocumentUserTypes_dftAACContentsLeft_UserType;
 {* Левая часть оглавления Энциклопедии решений }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACContentsLeft_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACRight_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы dftAACContentsLeft }
 dftAACContentsLeftName = 'dftAACContentsLeft';
  {* Строковый идентификатор пользовательского типа "Левая часть оглавления Энциклопедии решений" }
 dftAACContentsLeft = TvcmUserType(dftAACRight + 1);
  {* Левая часть оглавления Энциклопедии решений }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsLeft = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAACContentsLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAACContentsLeft
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAACContentsLeft';
end;//Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister

function Tkw_FormUserType_dftAACContentsLeft.GetInteger: Integer;
begin
 Result := dftAACContentsLeft;
end;//Tkw_FormUserType_dftAACContentsLeft.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsLeft.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAACContentsLeft }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
