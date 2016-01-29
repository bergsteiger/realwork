unit PrimTreeAttributeSelect_astNone_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelect_astNone_UserType.pas"
// Начат: 27.01.2009 11:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::PrimTreeAttributeSelect::astNone
//
// Поиск: Выбор реквизита
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
   { Константы для типа формы astNone }
  astNoneName = 'astNone';
   { Строковый идентификатор пользовательского типа "Поиск: Выбор реквизита" }
  astNone = TvcmUserType(0);
   { Поиск: Выбор реквизита }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_astNone = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы astNone }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_astNone
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_astNone

class function Tkw_FormUserType_astNone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::astNone';
end;//Tkw_FormUserType_astNone.GetWordNameForRegister

function Tkw_FormUserType_astNone.GetInteger: Integer;
 {-}
begin
 Result := astNone;
end;//Tkw_FormUserType_astNone.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_astNone
 Tkw_FormUserType_astNone.RegisterInEngine;
{$IfEnd} //not NoScripts

end.