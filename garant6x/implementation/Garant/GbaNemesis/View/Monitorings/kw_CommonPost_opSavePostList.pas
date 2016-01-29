unit kw_CommonPost_opSavePostList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/kw_CommonPost_opSavePostList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Common For Shell And Monitoring::PostingOrder::View::Monitorings::Tkw_CommonPost_opSavePostList
//
// Слово словаря для вызова операции модуля CommonPost.SavePostList$Op (Файл Экспортировать все
// индивидуальные ленты в файл)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
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
{$IfEnd} //not Admin AND not NoScripts


implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}
type
 Tkw_CommonPost_opSavePostList = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля CommonPost.SavePostList$Op (Файл Экспортировать все индивидуальные ленты в файл) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_CommonPost_opSavePostList
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_CommonPost_opSavePostList

class function Tkw_CommonPost_opSavePostList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Файл_Экспортировать_все_индивидуальные_ленты_в_файл';
end;//Tkw_CommonPost_opSavePostList.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_CommonPost_opSavePostList.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_CommonPost_SavePostList;
end;//Tkw_CommonPost_opSavePostList.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_CommonPost_opSavePostList
 Tkw_CommonPost_opSavePostList.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.