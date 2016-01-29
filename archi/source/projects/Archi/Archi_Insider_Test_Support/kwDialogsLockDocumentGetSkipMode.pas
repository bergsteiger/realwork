unit kwDialogsLockDocumentGetSkipMode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwDialogsLockDocumentGetSkipMode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::dialogs_LockDocument_GetSkipMode
//
// Возращает установленный режим работы с диалогом о залочке документа:
// {code}
// ar_AsUsual // Показывать диалог и проверять его результат.
// ar_OpenDocument // Если есть залоченный - все равно открывать.
// ar_NotOpen // Если есть залоченный - не открывать.
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
 TkwDialogsLockDocumentGetSkipMode = {final scriptword} class(TtfwRegisterableWord)
  {* Возращает установленный режим работы с диалогом о залочке документа:
[code]
  ar_AsUsual // Показывать диалог и проверять его результат.
  ar_OpenDocument // Если есть залоченный - все равно открывать.
  ar_NotOpen // Если есть залоченный - не открывать.
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDialogsLockDocumentGetSkipMode
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwDialogsLockDocumentGetSkipMode

procedure TkwDialogsLockDocumentGetSkipMode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54255ED703B9_var*
//#UC END# *4DAEEDE10285_54255ED703B9_var*
begin
//#UC START# *4DAEEDE10285_54255ED703B9_impl*
 aCtx.rEngine.PushInt(Ord(TarTestConfig.Instance.SkipLockDialog));
//#UC END# *4DAEEDE10285_54255ED703B9_impl*
end;//TkwDialogsLockDocumentGetSkipMode.DoDoIt

class function TkwDialogsLockDocumentGetSkipMode.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'dialogs:LockDocument:GetSkipMode';
end;//TkwDialogsLockDocumentGetSkipMode.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация dialogs_LockDocument_GetSkipMode
 TkwDialogsLockDocumentGetSkipMode.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.