unit kwExportHelp;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwExportHelp.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwExportHelp = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwExportHelp
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

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
begin
 Result := 'vcm:ExportHelp';
end;//TkwExportHelp.GetWordNameForRegister

initialization
 TkwExportHelp.RegisterInEngine;
 {* Регистрация TkwExportHelp }
{$IfEnd} // NOT Defined(NoScripts)

end.
