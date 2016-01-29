unit kwGetEncryptedComplectId;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwGetEncryptedComplectId.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::GetEncryptedComplectId
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
 TkwGetEncryptedComplectId = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwGetEncryptedComplectId
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter,
  IOUnit,
  nsTypes
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwGetEncryptedComplectId

procedure TkwGetEncryptedComplectId.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_51AEF36002D1_var*
var
 l_Id: IString;
//#UC END# *4DAEEDE10285_51AEF36002D1_var*
begin
//#UC START# *4DAEEDE10285_51AEF36002D1_impl*
 DefDataAdapter.CommonInterfaces.GetEncryptedComplectId(l_Id);
 aCtx.rEngine.PushString(nsCStr(l_Id));
//#UC END# *4DAEEDE10285_51AEF36002D1_impl*
end;//TkwGetEncryptedComplectId.DoDoIt

class function TkwGetEncryptedComplectId.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'GetEncryptedComplectId';
end;//TkwGetEncryptedComplectId.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация GetEncryptedComplectId
 TkwGetEncryptedComplectId.RegisterInEngine;
{$IfEnd} //not NoScripts

end.