unit kwMainFormFindDocuments;
 {* Вызывает поиск документов. }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMainFormFindDocuments.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "MainForm_FindDocuments" MUID: (4F8D503400FD)
// Имя типа: "TkwMainFormFindDocuments"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMainFormFindDocuments = {final} class(TtfwRegisterableWord)
  {* Вызывает поиск документов. }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwMainFormFindDocuments
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Main
;

class function TkwMainFormFindDocuments.GetWordNameForRegister: AnsiString;
begin
 Result := 'MainForm:FindDocuments';
end;//TkwMainFormFindDocuments.GetWordNameForRegister

procedure TkwMainFormFindDocuments.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F8D503400FD_var*
//#UC END# *4DAEEDE10285_4F8D503400FD_var*
begin
//#UC START# *4DAEEDE10285_4F8D503400FD_impl*
 Assert(MainForm <> nil);
 MainForm.acFindDoc.Execute;
//#UC END# *4DAEEDE10285_4F8D503400FD_impl*
end;//TkwMainFormFindDocuments.DoDoIt

initialization
 TkwMainFormFindDocuments.RegisterInEngine;
 {* Регистрация MainForm_FindDocuments }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
