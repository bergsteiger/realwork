unit kwPushTextSearchDlg;
 {* Кладет в стек указатель на окно поиска. Сделано специально, т.к. окно глобальное и найти его не всегда можно. }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPushTextSearchDlg.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "push_TextSearchDlg" MUID: (57E0CD600059)
// Имя типа: "TkwPushTextSearchDlg"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwPushTextSearchDlg = {final} class(TtfwRegisterableWord)
  {* Кладет в стек указатель на окно поиска. Сделано специально, т.к. окно глобальное и найти его не всегда можно. }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwPushTextSearchDlg
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , D_TxSrch
 //#UC START# *57E0CD600059impl_uses*
 //#UC END# *57E0CD600059impl_uses*
;

class function TkwPushTextSearchDlg.GetWordNameForRegister: AnsiString;
begin
 Result := 'push:TextSearchDlg';
end;//TkwPushTextSearchDlg.GetWordNameForRegister

procedure TkwPushTextSearchDlg.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_57E0CD600059_var*
//#UC END# *4DAEEDE10285_57E0CD600059_var*
begin
//#UC START# *4DAEEDE10285_57E0CD600059_impl*
 Assert(g_TextSearchDlg <> nil);
 aCtx.rEngine.PushObj(g_TextSearchDlg);
//#UC END# *4DAEEDE10285_57E0CD600059_impl*
end;//TkwPushTextSearchDlg.DoDoIt

initialization
 TkwPushTextSearchDlg.RegisterInEngine;
 {* Регистрация push_TextSearchDlg }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
