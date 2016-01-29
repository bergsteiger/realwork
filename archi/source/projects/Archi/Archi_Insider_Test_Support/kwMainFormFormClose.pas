unit kwMainFormFormClose;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwMainFormFormClose.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::MainForm_FormClose
//
// Эмулирует выполнение FormClose главной формы, возращая после выполнения все в исходное состояние.
// Формат:
// {code}
// MainForm:FormClose
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwMainFormFormClose = {final scriptword} class(TtfwRegisterableWord)
  {* Эмулирует выполнение FormClose главной формы, возращая после выполнения все в исходное состояние.
Формат: 
[code]
MainForm:FormClose
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMainFormFormClose
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwMainFormFormClose

procedure TkwMainFormFormClose.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53EB19070285_var*
//#UC END# *4DAEEDE10285_53EB19070285_var*
begin
//#UC START# *4DAEEDE10285_53EB19070285_impl*
 AcMainFormFormClose;
//#UC END# *4DAEEDE10285_53EB19070285_impl*
end;//TkwMainFormFormClose.DoDoIt

class function TkwMainFormFormClose.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'MainForm:FormClose';
end;//TkwMainFormFormClose.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация MainForm_FormClose
 TkwMainFormFormClose.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.