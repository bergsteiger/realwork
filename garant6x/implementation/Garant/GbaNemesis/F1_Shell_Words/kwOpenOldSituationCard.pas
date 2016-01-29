unit kwOpenOldSituationCard;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwOpenOldSituationCard.pas"
// Начат: 31.01.2012 17:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwOpenOldSituationCard
//
// открыть ППС 5.х (Преемственная)
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
 TkwOpenOldSituationCard = {scriptword} class(TtfwRegisterableWord)
  {* открыть ППС 5.х (Преемственная) }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenOldSituationCard
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

// start class TkwOpenOldSituationCard

procedure TkwOpenOldSituationCard.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F27EB56012C_var*
//#UC END# *4DAEEDE10285_4F27EB56012C_var*
begin
//#UC START# *4DAEEDE10285_4F27EB56012C_impl*
 TdmStdRes.OpenOldSituationCard(nil, nil);
//#UC END# *4DAEEDE10285_4F27EB56012C_impl*
end;//TkwOpenOldSituationCard.DoDoIt

class function TkwOpenOldSituationCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ППС_Преемственная_Prim';
end;//TkwOpenOldSituationCard.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwOpenOldSituationCard
 TkwOpenOldSituationCard.RegisterInEngine;
{$IfEnd} //not NoScripts

end.