{$IfNDef Scripter_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\Scripter.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "Scripter" MUID: (4DAEEA2B029A)
// Имя типа: "_Scripter_"

{$Define Scripter_imp}

{$If NOT Defined(NoScripts)}
 _Scripter_ = {abstract} class(_Scripter_Parent_)
  {* Парень умеющий выполнять скрипты }
  protected
   procedure Script(const aString: AnsiString);
   procedure ScriptFromFile(const aFileName: AnsiString);
   function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString; virtual;
 end;//_Scripter_

{$Else NOT Defined(NoScripts)}

_Scripter_ = _Scripter_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else Scripter_imp}

{$IfNDef Scripter_imp_impl}

{$Define Scripter_imp_impl}

{$If NOT Defined(NoScripts)}
procedure _Scripter_.Script(const aString: AnsiString);
//#UC START# *4DAEEE87019A_4DAEEA2B029A_var*
//#UC END# *4DAEEE87019A_4DAEEA2B029A_var*
begin
//#UC START# *4DAEEE87019A_4DAEEA2B029A_impl*
 TtfwScriptEngine.Script(aString, _Instance_R_(Self));
//#UC END# *4DAEEE87019A_4DAEEA2B029A_impl*
end;//_Scripter_.Script

procedure _Scripter_.ScriptFromFile(const aFileName: AnsiString);
//#UC START# *4DB02B310185_4DAEEA2B029A_var*
//#UC END# *4DB02B310185_4DAEEA2B029A_var*
begin
//#UC START# *4DB02B310185_4DAEEA2B029A_impl*
 TtfwScriptEngine.ScriptFromFile(ResolveScriptFilePath(aFileName), _Instance_R_(Self));
//#UC END# *4DB02B310185_4DAEEA2B029A_impl*
end;//_Scripter_.ScriptFromFile

function _Scripter_.ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
//#UC START# *4DB03121022B_4DAEEA2B029A_var*
//#UC END# *4DB03121022B_4DAEEA2B029A_var*
begin
//#UC START# *4DB03121022B_4DAEEA2B029A_impl*
 Result := aFileName;
//#UC END# *4DB03121022B_4DAEEA2B029A_impl*
end;//_Scripter_.ResolveScriptFilePath
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf Scripter_imp_impl}

{$EndIf Scripter_imp}

