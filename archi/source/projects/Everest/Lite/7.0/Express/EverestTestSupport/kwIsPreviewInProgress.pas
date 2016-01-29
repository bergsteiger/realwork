unit kwIsPreviewInProgress;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestTestSupport"
// Модуль: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/kwIsPreviewInProgress.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::IsPreviewInProgress
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWord
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TkwIsPreviewInProgress = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
    {$If not defined(NoScripts)}
   procedure DoDoIt(const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts
 protected
 // overridden protected methods
   {$If not defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} //not NoScripts
 end;//TkwIsPreviewInProgress
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  EverestLiteAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TkwIsPreviewInProgress

{$If not defined(NoScripts)}
procedure TkwIsPreviewInProgress.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5321724703A5_var*
//#UC END# *4DAEEDE10285_5321724703A5_var*
begin
//#UC START# *4DAEEDE10285_5321724703A5_impl*
 aCtx.rEngine.PushBool(IsPreviewInProcess);
//#UC END# *4DAEEDE10285_5321724703A5_impl*
end;//TkwIsPreviewInProgress.DoDoIt
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function TkwIsPreviewInProgress.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsPreviewInProgress';
end;//TkwIsPreviewInProgress.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$IfEnd} //InsiderTest AND nsTest

initialization
{$If defined(InsiderTest) AND defined(nsTest)}
// Регистрация IsPreviewInProgress
 TkwIsPreviewInProgress.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest

end.