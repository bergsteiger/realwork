unit DocumentUserTypes_dftAACContentsRight_UserType;
 {* Правая часть оглавления Энциклопедии решений }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACContentsRight_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACContentsLeft_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftAACContentsRight }
 dftAACContentsRightName = 'dftAACContentsRight';
  {* Строковый идентификатор пользовательского типа "Правая часть оглавления Энциклопедии решений" }
 dftAACContentsRight = TvcmUserType(dftAACContentsLeft + 1);
  {* Правая часть оглавления Энциклопедии решений }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsRight = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAACContentsRight }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAACContentsRight
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAACContentsRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAACContentsRight';
end;//Tkw_FormUserType_dftAACContentsRight.GetWordNameForRegister

function Tkw_FormUserType_dftAACContentsRight.GetInteger: Integer;
begin
 Result := dftAACContentsRight;
end;//Tkw_FormUserType_dftAACContentsRight.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsRight.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAACContentsRight }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
