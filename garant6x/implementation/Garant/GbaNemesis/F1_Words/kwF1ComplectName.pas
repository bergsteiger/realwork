unit kwF1ComplectName;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwF1ComplectName.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::f1_ComplectName
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
 TkwF1ComplectName = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ComplectName
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  bsUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwF1ComplectName

procedure TkwF1ComplectName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50237E1C0249_var*
//#UC END# *4DAEEDE10285_50237E1C0249_var*
begin
//#UC START# *4DAEEDE10285_50237E1C0249_impl*
 aCtx.rEngine.PushString(bsComplectName);
//#UC END# *4DAEEDE10285_50237E1C0249_impl*
end;//TkwF1ComplectName.DoDoIt

class function TkwF1ComplectName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'f1:ComplectName';
end;//TkwF1ComplectName.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация f1_ComplectName
 TkwF1ComplectName.RegisterInEngine;
{$IfEnd} //not NoScripts

end.