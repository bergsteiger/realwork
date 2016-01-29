unit kwExportHelp;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwExportHelp.pas"
// Начат: 19.05.2011 19:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::TkwExportHelp
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwExportHelp = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwExportHelp
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmMainForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwExportHelp

procedure TkwExportHelp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DD530DD03D8_var*
var
 l_S : String;
//#UC END# *4DAEEDE10285_4DD530DD03D8_var*
begin
//#UC START# *4DAEEDE10285_4DD530DD03D8_impl*
 l_S := aCtx.rCaller.ResolveOutputFilePath(aCtx.rEngine.PopDelphiString);
 (vcmDispatcher.FormDispatcher.CurrentMainForm.VCLWinControl As TvcmMainForm).DoExportHelp(l_S, false);
 aCtx.rCaller.CheckWithEtalon(l_S, #0);
//#UC END# *4DAEEDE10285_4DD530DD03D8_impl*
end;//TkwExportHelp.DoDoIt

class function TkwExportHelp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:ExportHelp';
end;//TkwExportHelp.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwExportHelp
 TkwExportHelp.RegisterInEngine;
{$IfEnd} //not NoScripts

end.