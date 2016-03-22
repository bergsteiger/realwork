unit kwSearchWinSaveDocumentList;
 {* Формат: 
[code]
aFileName SearchWin:SaveDocumentList
[code]
Сохраняет список документов в файл aFileName. Аналоична команде "Сохранить как..." в окне выборке. Окно выборки должно быть активно. }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwSearchWinSaveDocumentList.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "SearchWin_SaveDocumentList" MUID: (537076040297)
// Имя типа: "TkwSearchWinSaveDocumentList"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwSearchWinSaveDocumentList = {final} class(TtfwRegisterableWord)
  {* Формат: 
[code]
aFileName SearchWin:SaveDocumentList
[code]
Сохраняет список документов в файл aFileName. Аналоична команде "Сохранить как..." в окне выборке. Окно выборки должно быть активно. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSearchWinSaveDocumentList
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwSearchWinSaveDocumentList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_537076040297_var*
var
 l_FileName: AnsiString;
//#UC END# *4DAEEDE10285_537076040297_var*
begin
//#UC START# *4DAEEDE10285_537076040297_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано расширение!', aCtx);
 l_FileName := aCtx.rEngine.PopDelphiString;
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 AcSaveDocAs(l_FileName);
//#UC END# *4DAEEDE10285_537076040297_impl*
end;//TkwSearchWinSaveDocumentList.DoDoIt

class function TkwSearchWinSaveDocumentList.GetWordNameForRegister: AnsiString;
begin
 Result := 'SearchWin:SaveDocumentList';
end;//TkwSearchWinSaveDocumentList.GetWordNameForRegister

initialization
 TkwSearchWinSaveDocumentList.RegisterInEngine;
 {* Регистрация SearchWin_SaveDocumentList }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
