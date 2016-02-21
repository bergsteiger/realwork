unit kwDialogsLockDocumentGetSkipMode;
 {* Возращает установленный режим работы с диалогом о залочке документа:
[code]
  ar_AsUsual // Показывать диалог и проверять его результат.
  ar_OpenDocument // Если есть залоченный - все равно открывать.
  ar_NotOpen // Если есть залоченный - не открывать.
[code] }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDialogsLockDocumentGetSkipMode.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDialogsLockDocumentGetSkipMode = {final} class(TtfwRegisterableWord)
  {* Возращает установленный режим работы с диалогом о залочке документа:
[code]
  ar_AsUsual // Показывать диалог и проверять его результат.
  ar_OpenDocument // Если есть залоченный - все равно открывать.
  ar_NotOpen // Если есть залоченный - не открывать.
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDialogsLockDocumentGetSkipMode
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

procedure TkwDialogsLockDocumentGetSkipMode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54255ED703B9_var*
//#UC END# *4DAEEDE10285_54255ED703B9_var*
begin
//#UC START# *4DAEEDE10285_54255ED703B9_impl*
 aCtx.rEngine.PushInt(Ord(TarTestConfig.Instance.SkipLockDialog));
//#UC END# *4DAEEDE10285_54255ED703B9_impl*
end;//TkwDialogsLockDocumentGetSkipMode.DoDoIt

class function TkwDialogsLockDocumentGetSkipMode.GetWordNameForRegister: AnsiString;
begin
 Result := 'dialogs:LockDocument:GetSkipMode';
end;//TkwDialogsLockDocumentGetSkipMode.GetWordNameForRegister

initialization
 TkwDialogsLockDocumentGetSkipMode.RegisterInEngine;
 {* Регистрация dialogs_LockDocument_GetSkipMode }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
