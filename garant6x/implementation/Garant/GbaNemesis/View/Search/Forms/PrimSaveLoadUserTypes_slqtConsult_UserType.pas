unit PrimSaveLoadUserTypes_slqtConsult_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtConsult_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtConsult
//
// Правовая поддержка онлайн
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimSaveLoadUserTypes_slqtPostingOrder_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы slqtConsult }
  slqtConsultName = 'slqtConsult';
   { Строковый идентификатор пользовательского типа "Правовая поддержка онлайн" }
  slqtConsult = TvcmUserType(slqtPostingOrder + 1);
   { Правовая поддержка онлайн }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtConsult = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtConsult }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtConsult
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtConsult

class function Tkw_FormUserType_slqtConsult.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtConsult';
end;//Tkw_FormUserType_slqtConsult.GetWordNameForRegister

function Tkw_FormUserType_slqtConsult.GetInteger: Integer;
 {-}
begin
 Result := slqtConsult;
end;//Tkw_FormUserType_slqtConsult.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtConsult
 Tkw_FormUserType_slqtConsult.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.