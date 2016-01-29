unit PrimAttributeSelect_utAttributeSelect_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimAttributeSelect_utAttributeSelect_UserType.pas"
// Начат: 27.01.2009 15:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::PrimAttributeSelect::utAttributeSelect
//
// Выбор значения атрибута
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
   { Константы для типа формы utAttributeSelect }
  utAttributeSelectName = 'utAttributeSelect';
   { Строковый идентификатор пользовательского типа "Выбор значения атрибута" }
  utAttributeSelect = TvcmUserType(0);
   { Выбор значения атрибута }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_utAttributeSelect = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utAttributeSelect }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utAttributeSelect
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_utAttributeSelect

class function Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utAttributeSelect';
end;//Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister

function Tkw_FormUserType_utAttributeSelect.GetInteger: Integer;
 {-}
begin
 Result := utAttributeSelect;
end;//Tkw_FormUserType_utAttributeSelect.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utAttributeSelect
 Tkw_FormUserType_utAttributeSelect.RegisterInEngine;
{$IfEnd} //not NoScripts

end.