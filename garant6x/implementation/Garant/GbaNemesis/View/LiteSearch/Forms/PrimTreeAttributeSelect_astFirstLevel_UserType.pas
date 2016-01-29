unit PrimTreeAttributeSelect_astFirstLevel_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelect_astFirstLevel_UserType.pas"
// Начат: 27.01.2009 11:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::PrimTreeAttributeSelect::astFirstLevel
//
// Ситуации первого уровня
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
  ,
  PrimTreeAttributeSelect_astOneLevel_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы astFirstLevel }
  astFirstLevelName = 'astFirstLevel';
   { Строковый идентификатор пользовательского типа "Ситуации первого уровня" }
  astFirstLevel = TvcmUserType(astOneLevel + 1);
   { Ситуации первого уровня }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_astFirstLevel = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы astFirstLevel }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_astFirstLevel
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_astFirstLevel

class function Tkw_FormUserType_astFirstLevel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::astFirstLevel';
end;//Tkw_FormUserType_astFirstLevel.GetWordNameForRegister

function Tkw_FormUserType_astFirstLevel.GetInteger: Integer;
 {-}
begin
 Result := astFirstLevel;
end;//Tkw_FormUserType_astFirstLevel.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_astFirstLevel
 Tkw_FormUserType_astFirstLevel.RegisterInEngine;
{$IfEnd} //not NoScripts

end.