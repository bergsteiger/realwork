unit kwClearTemplateStorage;
 {* Очищает данные для 'Текстового шаблона' }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearTemplateStorage.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "ClearTemplateStorage" MUID: (53B647A9029B)
// Имя типа: "TkwClearTemplateStorage"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwClearTemplateStorage = {final} class(TtfwRegisterableWord)
  {* Очищает данные для 'Текстового шаблона' }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwClearTemplateStorage
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

class function TkwClearTemplateStorage.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearTemplateStorage';
end;//TkwClearTemplateStorage.GetWordNameForRegister

procedure TkwClearTemplateStorage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B647A9029B_var*
//#UC END# *4DAEEDE10285_53B647A9029B_var*
begin
//#UC START# *4DAEEDE10285_53B647A9029B_impl*
 ArClearTemplateStorage;
//#UC END# *4DAEEDE10285_53B647A9029B_impl*
end;//TkwClearTemplateStorage.DoDoIt

initialization
 TkwClearTemplateStorage.RegisterInEngine;
 {* Регистрация ClearTemplateStorage }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
