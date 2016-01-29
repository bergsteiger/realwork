unit PrimRubricator_utRubricatorList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Rubricator/Forms/PrimRubricator_utRubricatorList_UserType.pas"
// Начат: 08.09.2009 20:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Rubricator::View::Rubricator::PrimRubricator::utRubricatorList
//
// Правовой навигатор (линейное представление)
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
   { Константы для типа формы utRubricatorList }
  utRubricatorListName = 'utRubricatorList';
   { Строковый идентификатор пользовательского типа "Правовой навигатор (линейное представление)" }
  utRubricatorList = TvcmUserType(0);
   { Правовой навигатор (линейное представление) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utRubricatorList = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utRubricatorList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utRubricatorList
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utRubricatorList

class function Tkw_FormUserType_utRubricatorList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utRubricatorList';
end;//Tkw_FormUserType_utRubricatorList.GetWordNameForRegister

function Tkw_FormUserType_utRubricatorList.GetInteger: Integer;
 {-}
begin
 Result := utRubricatorList;
end;//Tkw_FormUserType_utRubricatorList.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utRubricatorList
 Tkw_FormUserType_utRubricatorList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.