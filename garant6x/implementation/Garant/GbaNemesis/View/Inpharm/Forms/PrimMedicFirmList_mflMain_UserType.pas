unit PrimMedicFirmList_mflMain_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/PrimMedicFirmList_mflMain_UserType.pas"
// Начат: 27.01.2009 13:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::PrimMedicFirmList::mflMain
//
// Фармацевтические фирмы (полный список)
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
   { Константы для типа формы mflMain }
  mflMainName = 'mflMain';
   { Строковый идентификатор пользовательского типа "Фармацевтические фирмы (полный список)" }
  mflMain = TvcmUserType(0);
   { Фармацевтические фирмы (полный список) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_mflMain = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы mflMain }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_mflMain
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_mflMain

class function Tkw_FormUserType_mflMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::mflMain';
end;//Tkw_FormUserType_mflMain.GetWordNameForRegister

function Tkw_FormUserType_mflMain.GetInteger: Integer;
 {-}
begin
 Result := mflMain;
end;//Tkw_FormUserType_mflMain.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_mflMain
 Tkw_FormUserType_mflMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.