unit kw_Folders_opUnderControlOpenFrmAct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/kw_Folders_opUnderControlOpenFrmAct.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Основные прецеденты::Folders::View::Folders::Tkw_Folders_opUnderControlOpenFrmAct
//
// Слово словаря для вызова операции модуля Folders.UnderControlOpenFrmAct (Папки Документы на
// контроле)
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
 Tkw_Folders_opUnderControlOpenFrmAct = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Folders.UnderControlOpenFrmAct (Папки Документы на контроле) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Folders_opUnderControlOpenFrmAct
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Folders_opUnderControlOpenFrmAct

class function Tkw_Folders_opUnderControlOpenFrmAct.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Папки_Документы_на_контроле';
end;//Tkw_Folders_opUnderControlOpenFrmAct.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Folders_opUnderControlOpenFrmAct.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Folders_UnderControlOpenFrmAct;
end;//Tkw_Folders_opUnderControlOpenFrmAct.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Folders_opUnderControlOpenFrmAct
 Tkw_Folders_opUnderControlOpenFrmAct.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.