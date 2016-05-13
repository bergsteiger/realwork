unit kwDialogsLockDocumentSetSkipMode;
 {* Устанавливает режим работы с диалогом о залочке документа:
[code]
  ar_AsUsual // Показывать диалог и проверять его результат.
  ar_OpenDocument // Если есть залоченный - все равно открывать.
  ar_NotOpen // Если есть залоченный - не открывать.
[code]
Формат:
[code]
aMode dialogs:LockDocument:SetSkipMode
[code] }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDialogsLockDocumentSetSkipMode.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "dialogs_LockDocument_SetSkipMode" MUID: (54255FED0328)
// Имя типа: "TkwDialogsLockDocumentSetSkipMode"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDialogsLockDocumentSetSkipMode = {final} class(TtfwRegisterableWord)
  {* Устанавливает режим работы с диалогом о залочке документа:
[code]
  ar_AsUsual // Показывать диалог и проверять его результат.
  ar_OpenDocument // Если есть залоченный - все равно открывать.
  ar_NotOpen // Если есть залоченный - не открывать.
[code]
Формат:
[code]
aMode dialogs:LockDocument:SetSkipMode
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwDialogsLockDocumentSetSkipMode
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

class function TkwDialogsLockDocumentSetSkipMode.GetWordNameForRegister: AnsiString;
begin
 Result := 'dialogs:LockDocument:SetSkipMode';
end;//TkwDialogsLockDocumentSetSkipMode.GetWordNameForRegister

procedure TkwDialogsLockDocumentSetSkipMode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54255FED0328_var*
//#UC END# *4DAEEDE10285_54255FED0328_var*
begin
//#UC START# *4DAEEDE10285_54255FED0328_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, 'Не задан режим показа диалога!', aCtx);
 TarTestConfig.Instance.SkipLockDialog := TarSkipDialog(aCtx.rEngine.PopInt);
//#UC END# *4DAEEDE10285_54255FED0328_impl*
end;//TkwDialogsLockDocumentSetSkipMode.DoDoIt

initialization
 TkwDialogsLockDocumentSetSkipMode.RegisterInEngine;
 {* Регистрация dialogs_LockDocument_SetSkipMode }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
