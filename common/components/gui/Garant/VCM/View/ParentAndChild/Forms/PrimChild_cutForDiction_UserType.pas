unit PrimChild_cutForDiction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/Forms/PrimChild_cutForDiction_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::PrimChild::cutForDiction
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
  ,
  PrimChild_cutUsual_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы cutForDiction }
  cutForDictionName = 'cutForDiction';
   { Строковый идентификатор пользовательского типа "" }
  cutForDiction = TvcmUserType(cutUsual + 1);

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_cutForDiction = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы cutForDiction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cutForDiction
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_cutForDiction

class function Tkw_FormUserType_cutForDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::cutForDiction';
end;//Tkw_FormUserType_cutForDiction.GetWordNameForRegister

function Tkw_FormUserType_cutForDiction.GetInteger: Integer;
 {-}
begin
 Result := cutForDiction;
end;//Tkw_FormUserType_cutForDiction.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_cutForDiction
 Tkw_FormUserType_cutForDiction.RegisterInEngine;
{$IfEnd} //not NoScripts

end.