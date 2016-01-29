unit kw_Monitorings_opOpenLegislationReview;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/kw_Monitorings_opOpenLegislationReview.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::Tkw_Monitorings_opOpenLegislationReview
//
// Слово словаря для вызова операции модуля Monitorings.OpenLegislationReview (Мониторинги Обзор
// изменений законодательства)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  tfwModuleOperationWord
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts


implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
 Tkw_Monitorings_opOpenLegislationReview = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Monitorings.OpenLegislationReview (Мониторинги Обзор изменений законодательства) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Monitorings_opOpenLegislationReview
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Monitorings_opOpenLegislationReview

class function Tkw_Monitorings_opOpenLegislationReview.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Мониторинги_Обзор_изменений_законодательства';
end;//Tkw_Monitorings_opOpenLegislationReview.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Monitorings_opOpenLegislationReview.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Monitorings_OpenLegislationReview;
end;//Tkw_Monitorings_opOpenLegislationReview.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Monitorings_opOpenLegislationReview
 Tkw_Monitorings_opOpenLegislationReview.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.