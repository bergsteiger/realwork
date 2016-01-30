unit kwF1BaseDate;
 {* Кладёт на стек дату базы в строковом формате }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwF1BaseDate.pas"
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
 TkwF1BaseDate = class(TtfwRegisterableWord)
  {* Кладёт на стек дату базы в строковом формате }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1BaseDate
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , bsUtils
;

procedure TkwF1BaseDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EC134690154_var*
//#UC END# *4DAEEDE10285_4EC134690154_var*
begin
//#UC START# *4DAEEDE10285_4EC134690154_impl*
 aCtx.rEngine.PushString(bsBaseDateStr);
//#UC END# *4DAEEDE10285_4EC134690154_impl*
end;//TkwF1BaseDate.DoDoIt

class function TkwF1BaseDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1:BaseDate';
end;//TkwF1BaseDate.GetWordNameForRegister

initialization
 TkwF1BaseDate.RegisterInEngine;
 {* Регистрация f1_BaseDate }
{$IfEnd} // NOT Defined(NoScripts)

end.
