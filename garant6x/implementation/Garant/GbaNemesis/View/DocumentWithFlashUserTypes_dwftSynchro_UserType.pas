unit DocumentWithFlashUserTypes_dwftSynchro_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentWithFlashUserTypes_dwftSynchro_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentWithFlashUserTypes::dwftSynchro
//
// Схема (синхронный просмотр)
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
  ,
  DocumentWithFlashUserTypes_dwftMain_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dwftSynchro }
  dwftSynchroName = 'dwftSynchro';
   { Строковый идентификатор пользовательского типа "Схема (синхронный просмотр)" }
  dwftSynchro = TvcmUserType(dwftMain + 1);
   { Схема (синхронный просмотр) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dwftSynchro = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dwftSynchro }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dwftSynchro
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dwftSynchro

class function Tkw_FormUserType_dwftSynchro.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dwftSynchro';
end;//Tkw_FormUserType_dwftSynchro.GetWordNameForRegister

function Tkw_FormUserType_dwftSynchro.GetInteger: Integer;
 {-}
begin
 Result := dwftSynchro;
end;//Tkw_FormUserType_dwftSynchro.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dwftSynchro
 Tkw_FormUserType_dwftSynchro.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.