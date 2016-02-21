unit kwMainFormFormClose;
 {* Ёмулирует выполнение FormClose главной формы, возраща€ после выполнени€ все в исходное состо€ние.
‘ормат: 
[code]
MainForm:FormClose
[code] }

// ћодуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMainFormFormClose.pas"
// —тереотип: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMainFormFormClose = {final} class(TtfwRegisterableWord)
  {* Ёмулирует выполнение FormClose главной формы, возраща€ после выполнени€ все в исходное состо€ние.
‘ормат: 
[code]
MainForm:FormClose
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMainFormFormClose
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwMainFormFormClose.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53EB19070285_var*
//#UC END# *4DAEEDE10285_53EB19070285_var*
begin
//#UC START# *4DAEEDE10285_53EB19070285_impl*
 AcMainFormFormClose;
//#UC END# *4DAEEDE10285_53EB19070285_impl*
end;//TkwMainFormFormClose.DoDoIt

class function TkwMainFormFormClose.GetWordNameForRegister: AnsiString;
begin
 Result := 'MainForm:FormClose';
end;//TkwMainFormFormClose.GetWordNameForRegister

initialization
 TkwMainFormFormClose.RegisterInEngine;
 {* –егистраци€ MainForm_FormClose }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
