unit kwIntegrationOpenLink;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwIntegrationOpenLink.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Integration::integration_OpenLink
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
 TkwIntegrationOpenLink = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIntegrationOpenLink
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsIntegrationSupport
  {$IfEnd} //not Admin AND not Monitorings
  
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsIntegrationModelPart
  {$IfEnd} //not Admin AND not Monitorings
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwIntegrationOpenLink

procedure TkwIntegrationOpenLink.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5135F0090070_var*
var
 l_Link: ansistring;
//#UC END# *4DAEEDE10285_5135F0090070_var*
begin
//#UC START# *4DAEEDE10285_5135F0090070_impl*
 l_Link := aCtx.rEngine.PopDelphiString;
 GarantShowLink(PAnsiChar(l_Link), False, 500);
//#UC END# *4DAEEDE10285_5135F0090070_impl*
end;//TkwIntegrationOpenLink.DoDoIt

class function TkwIntegrationOpenLink.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'integration:OpenLink';
end;//TkwIntegrationOpenLink.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация integration_OpenLink
 TkwIntegrationOpenLink.RegisterInEngine;
{$IfEnd} //not NoScripts

end.