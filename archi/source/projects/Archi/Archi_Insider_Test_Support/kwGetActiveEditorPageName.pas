unit kwGetActiveEditorPageName;
 {* *Формат:* main_form:GetActivePageName
*Описание:* Помещает в стек номер активной вкладки в окне редактирования документа.
*Примечания:*
 Константы с номерами вкладок находятся в файле:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\ArchiControls.script"
[code] }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwGetActiveEditorPageName.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwGetActiveEditorPageName" MUID: (4E60CB00004F)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwGetActiveEditorPageName = class(TtfwRegisterableWord)
  {* *Формат:* main_form:GetActivePageName
*Описание:* Помещает в стек номер активной вкладки в окне редактирования документа.
*Примечания:*
 Константы с номерами вкладок находятся в файле:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\ArchiControls.script"
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwGetActiveEditorPageName
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(AppClientSide)}
 , Editwin
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , Main
 {$IfEnd} // Defined(AppClientSide)
;

class function TkwGetActiveEditorPageName.GetWordNameForRegister: AnsiString;
begin
 Result := 'main_form:GetActivePageName';
end;//TkwGetActiveEditorPageName.GetWordNameForRegister

procedure TkwGetActiveEditorPageName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E60CB00004F_var*
//#UC END# *4DAEEDE10285_4E60CB00004F_var*
begin
//#UC START# *4DAEEDE10285_4E60CB00004F_impl*
 aCtx.rEngine.PushString((MainForm.ActiveMDIChild as TDocEditorWindow).nbkDocPages.ActivePageName);
//#UC END# *4DAEEDE10285_4E60CB00004F_impl*
end;//TkwGetActiveEditorPageName.DoDoIt

initialization
 TkwGetActiveEditorPageName.RegisterInEngine;
 {* Регистрация TkwGetActiveEditorPageName }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
