unit PrimChild_cutUsual_UserType;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutUsual_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "cutUsual" MUID: (4D9AE77A0246)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы cutUsual }
 cutUsualName = 'cutUsual';
  {* Строковый идентификатор пользовательского типа "" }
 cutUsual = TvcmUserType(0);

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_cutUsual = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cutUsual }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cutUsual
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cutUsual.GetInteger: Integer;
begin
 Result := cutUsual;
end;//Tkw_FormUserType_cutUsual.GetInteger

class function Tkw_FormUserType_cutUsual.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cutUsual';
end;//Tkw_FormUserType_cutUsual.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutUsual.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cutUsual }
{$IfEnd} // NOT Defined(NoScripts)

end.
