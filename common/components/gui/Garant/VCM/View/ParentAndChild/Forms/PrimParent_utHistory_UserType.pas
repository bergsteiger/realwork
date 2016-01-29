unit PrimParent_utHistory_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/Forms/PrimParent_utHistory_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::PrimParent::utHistory
//
// История навигации
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
   { Константы для типа формы utHistory }
  utHistoryName = 'utHistory';
   { Строковый идентификатор пользовательского типа "История навигации" }
  utHistory = TvcmUserType(0);
   { История навигации }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_utHistory = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utHistory }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utHistory
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_utHistory

class function Tkw_FormUserType_utHistory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utHistory';
end;//Tkw_FormUserType_utHistory.GetWordNameForRegister

function Tkw_FormUserType_utHistory.GetInteger: Integer;
 {-}
begin
 Result := utHistory;
end;//Tkw_FormUserType_utHistory.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utHistory
 Tkw_FormUserType_utHistory.RegisterInEngine;
{$IfEnd} //not NoScripts

end.