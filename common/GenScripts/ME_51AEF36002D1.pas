unit kwGetEncryptedComplectId;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwGetEncryptedComplectId.pas"
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
 TkwGetEncryptedComplectId = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwGetEncryptedComplectId
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
 , IOUnit
 , nsTypes
;

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
begin
 Result := 'GetEncryptedComplectId';
end;//TkwGetEncryptedComplectId.GetWordNameForRegister

initialization
 TkwGetEncryptedComplectId.RegisterInEngine;
 {* Регистрация GetEncryptedComplectId }
{$IfEnd} // NOT Defined(NoScripts)

end.
