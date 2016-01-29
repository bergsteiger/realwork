unit kwF1ComplectOwner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwF1ComplectOwner.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::f1_ComplectOwner
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
 TkwF1ComplectOwner = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ComplectOwner
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  bsUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwF1ComplectOwner

procedure TkwF1ComplectOwner.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50237E3A03A5_var*
//#UC END# *4DAEEDE10285_50237E3A03A5_var*
begin
//#UC START# *4DAEEDE10285_50237E3A03A5_impl*
 aCtx.rEngine.PushString(bsComplectOwner);
//#UC END# *4DAEEDE10285_50237E3A03A5_impl*
end;//TkwF1ComplectOwner.DoDoIt

class function TkwF1ComplectOwner.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'f1:ComplectOwner';
end;//TkwF1ComplectOwner.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация f1_ComplectOwner
 TkwF1ComplectOwner.RegisterInEngine;
{$IfEnd} //not NoScripts

end.