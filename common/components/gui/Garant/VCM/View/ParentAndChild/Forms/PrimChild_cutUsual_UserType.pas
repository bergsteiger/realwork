unit PrimChild_cutUsual_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/Forms/PrimChild_cutUsual_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::PrimChild::cutUsual
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы cutUsual }
  cutUsualName = 'cutUsual';
   { Строковый идентификатор пользовательского типа "" }
  cutUsual = TvcmUserType(0);

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_cutUsual = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы cutUsual }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cutUsual
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_cutUsual

class function Tkw_FormUserType_cutUsual.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::cutUsual';
end;//Tkw_FormUserType_cutUsual.GetWordNameForRegister

function Tkw_FormUserType_cutUsual.GetInteger: Integer;
 {-}
begin
 Result := cutUsual;
end;//Tkw_FormUserType_cutUsual.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_cutUsual
 Tkw_FormUserType_cutUsual.RegisterInEngine;
{$IfEnd} //not NoScripts

end.