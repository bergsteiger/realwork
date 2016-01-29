unit kw_Diction_opOpenDict;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/kw_Diction_opOpenDict.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Встроенные продукты::Diction::View::Diction::Tkw_Diction_opOpenDict
//
// Слово словаря для вызова операции модуля Diction.OpenDict (Толковый словарь Толковый словарь)
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
 Tkw_Diction_opOpenDict = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Diction.OpenDict (Толковый словарь Толковый словарь) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Diction_opOpenDict
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Diction_opOpenDict

class function Tkw_Diction_opOpenDict.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Толковый_словарь_Толковый_словарь';
end;//Tkw_Diction_opOpenDict.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Diction_opOpenDict.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Diction_OpenDict;
end;//Tkw_Diction_opOpenDict.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Diction_opOpenDict
 Tkw_Diction_opOpenDict.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.