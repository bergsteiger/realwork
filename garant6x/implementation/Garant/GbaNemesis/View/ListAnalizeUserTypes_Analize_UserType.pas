unit ListAnalizeUserTypes_Analize_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListAnalizeUserTypes_Analize_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListAnalizeUserTypes::Analize
//
// Анализ списка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
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
   { Константы для типа формы Analize }
  AnalizeName = 'Analize';
   { Строковый идентификатор пользовательского типа "Анализ списка" }
  Analize = TvcmUserType(0);
   { Анализ списка }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_Analize = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы Analize }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_Analize
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_Analize

class function Tkw_FormUserType_Analize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::Analize';
end;//Tkw_FormUserType_Analize.GetWordNameForRegister

function Tkw_FormUserType_Analize.GetInteger: Integer;
 {-}
begin
 Result := Analize;
end;//Tkw_FormUserType_Analize.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_Analize
 Tkw_FormUserType_Analize.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.