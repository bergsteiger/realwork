unit PrimConsultationMark_utcmMain_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Consultation/Forms/PrimConsultationMark_utcmMain_UserType.pas"
// Начат: 27.01.2009 13:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Пользовательские сервисы::Consultation::View::Consultation::PrimConsultationMark::utcmMain
//
// Оценка ответа
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
   { Константы для типа формы utcmMain }
  utcmMainName = 'utcmMain';
   { Строковый идентификатор пользовательского типа "Оценка ответа" }
  utcmMain = TvcmUserType(0);
   { Оценка ответа }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utcmMain = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utcmMain }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utcmMain
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utcmMain

class function Tkw_FormUserType_utcmMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utcmMain';
end;//Tkw_FormUserType_utcmMain.GetWordNameForRegister

function Tkw_FormUserType_utcmMain.GetInteger: Integer;
 {-}
begin
 Result := utcmMain;
end;//Tkw_FormUserType_utcmMain.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utcmMain
 Tkw_FormUserType_utcmMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.