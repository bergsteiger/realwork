unit kwStyleTableChanging;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableChanging.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "StyleTable_Changing" MUID: (4E68CC1B01C9)
// Имя типа: "TkwStyleTableChanging"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwStyleTableChanging = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwStyleTableChanging
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
;

procedure TkwStyleTableChanging.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68CC1B01C9_var*
//#UC END# *4DAEEDE10285_4E68CC1B01C9_var*
begin
//#UC START# *4DAEEDE10285_4E68CC1B01C9_impl*
 EvNotifyStyleTableChanging;
//#UC END# *4DAEEDE10285_4E68CC1B01C9_impl*
end;//TkwStyleTableChanging.DoDoIt

class function TkwStyleTableChanging.GetWordNameForRegister: AnsiString;
begin
 Result := 'StyleTable:Changing';
end;//TkwStyleTableChanging.GetWordNameForRegister

initialization
 TkwStyleTableChanging.RegisterInEngine;
 {* Регистрация StyleTable_Changing }
{$IfEnd} // NOT Defined(NoScripts)

end.
