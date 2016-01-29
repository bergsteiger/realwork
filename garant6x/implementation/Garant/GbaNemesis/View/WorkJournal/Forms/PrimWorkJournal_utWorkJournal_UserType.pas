unit PrimWorkJournal_utWorkJournal_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal/Forms/PrimWorkJournal_utWorkJournal_UserType.pas"
// Начат: 27.04.2010 16:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::WorkJournal::View::WorkJournal::PrimWorkJournal::utWorkJournal
//
// Журнал работы
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
   { Константы для типа формы utWorkJournal }
  utWorkJournalName = 'utWorkJournal';
   { Строковый идентификатор пользовательского типа "Журнал работы" }
  utWorkJournal = TvcmUserType(0);
   { Журнал работы }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utWorkJournal = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utWorkJournal }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utWorkJournal
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utWorkJournal

class function Tkw_FormUserType_utWorkJournal.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utWorkJournal';
end;//Tkw_FormUserType_utWorkJournal.GetWordNameForRegister

function Tkw_FormUserType_utWorkJournal.GetInteger: Integer;
 {-}
begin
 Result := utWorkJournal;
end;//Tkw_FormUserType_utWorkJournal.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utWorkJournal
 Tkw_FormUserType_utWorkJournal.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.