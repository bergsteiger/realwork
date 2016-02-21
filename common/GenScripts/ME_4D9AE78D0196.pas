unit PrimChild_cutForDiction_UserType;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutForDiction_UserType.pas"
// Стереотип: "UserType"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , PrimChild_cutUsual_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы cutForDiction }
 cutForDictionName = 'cutForDiction';
  {* Строковый идентификатор пользовательского типа "" }
 cutForDiction = TvcmUserType(cutUsual + 1);

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutForDiction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cutForDiction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_cutForDiction
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_cutForDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cutForDiction';
end;//Tkw_FormUserType_cutForDiction.GetWordNameForRegister

function Tkw_FormUserType_cutForDiction.GetInteger: Integer;
begin
 Result := cutForDiction;
end;//Tkw_FormUserType_cutForDiction.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutForDiction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cutForDiction }
{$IfEnd} // NOT Defined(NoScripts)

end.
