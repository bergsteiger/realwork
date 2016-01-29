unit kwOpenSituationCard;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwOpenSituationCard.pas"
// Начат: 31.01.2012 17:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwOpenSituationCard
//
// открыть ППС 6.х (Стандартная)
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
 TkwOpenSituationCard = {scriptword} class(TtfwRegisterableWord)
  {* открыть ППС 6.х (Стандартная) }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenSituationCard
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwOpenSituationCard

procedure TkwOpenSituationCard.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F27EAF200E5_var*
//#UC END# *4DAEEDE10285_4F27EAF200E5_var*
begin
//#UC START# *4DAEEDE10285_4F27EAF200E5_impl*
 TdmStdRes.OpenSituationCard(nil);
//#UC END# *4DAEEDE10285_4F27EAF200E5_impl*
end;//TkwOpenSituationCard.DoDoIt

class function TkwOpenSituationCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ППС_Стандартная_Prim';
end;//TkwOpenSituationCard.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwOpenSituationCard
 TkwOpenSituationCard.RegisterInEngine;
{$IfEnd} //not NoScripts

end.