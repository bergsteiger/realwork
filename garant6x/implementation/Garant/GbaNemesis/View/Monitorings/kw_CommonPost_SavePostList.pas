unit kw_CommonPost_SavePostList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/kw_CommonPost_SavePostList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Утилита Прайм::NewsLineTuning::View::Monitorings::Tkw_CommonPost_SavePostList
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

{$If defined(Monitorings) AND not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Monitorings AND not Admin

{$If defined(Monitorings) AND not defined(Admin)}
type
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}
 Tkw_CommonPost_SavePostList = class(_tfwModuleOperationWord_)
  {* Слово словаря для вызова операции модуля CommonPost.SavePostList$Op (Файл Экспортировать все индивидуальные ленты в файл) }
 protected
 // overridden protected methods
   {$If not defined(NoScripts)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts
 public
 // overridden public methods
   {$If not defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} //not NoScripts
 end;//Tkw_CommonPost_SavePostList
{$IfEnd} //Monitorings AND not Admin

implementation

{$If defined(Monitorings) AND not defined(Admin)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwAutoregisteredDiction
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngine,
  kwString,
  l3Except
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Monitorings AND not Admin

{$If defined(Monitorings) AND not defined(Admin)}

type _Instance_R_ = Tkw_CommonPost_SavePostList;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}

// start class Tkw_CommonPost_SavePostList

{$If not defined(NoScripts)}
class function Tkw_CommonPost_SavePostList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Файл_Экспортировать_все_индивидуальные_ленты_в_файл';
end;//Tkw_CommonPost_SavePostList.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function Tkw_CommonPost_SavePostList.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_CommonPost_SavePostList;
end;//Tkw_CommonPost_SavePostList.GetModuleOperationCode
{$IfEnd} //not NoScripts

{$IfEnd} //Monitorings AND not Admin

initialization
{$If defined(Monitorings) AND not defined(Admin)}
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}
{$IfEnd} //Monitorings AND not Admin

end.