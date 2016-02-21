unit kwIniRecGetZoom;
 {* IniRec:GetZoom }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwIniRecGetZoom.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwIniRecGetZoom = class(TtfwRegisterableWord)
  {* IniRec:GetZoom }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIniRecGetZoom
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwIniRecGetZoom.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E8307CE0359_var*
//#UC END# *4DAEEDE10285_4E8307CE0359_var*
begin
//#UC START# *4DAEEDE10285_4E8307CE0359_impl*
 aCtx.rEngine.PushInt(ArIniRecGetZoom);
//#UC END# *4DAEEDE10285_4E8307CE0359_impl*
end;//TkwIniRecGetZoom.DoDoIt

class function TkwIniRecGetZoom.GetWordNameForRegister: AnsiString;
begin
 Result := 'IniRec:GetZoom';
end;//TkwIniRecGetZoom.GetWordNameForRegister

initialization
 TkwIniRecGetZoom.RegisterInEngine;
 {* Регистрация TkwIniRecGetZoom }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
