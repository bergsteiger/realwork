unit kwCheckEtalon;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCheckEtalon.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "CheckEtalon" MUID: (4DD547B70001)
// Имя типа: "TkwCheckEtalon"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCheckEtalon = class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCheckEtalon
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class function TkwCheckEtalon.GetWordNameForRegister: AnsiString;
begin
 Result := 'tests:CheckEtalon';
end;//TkwCheckEtalon.GetWordNameForRegister

procedure TkwCheckEtalon.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DD547B70001_var*
var
 l_H : AnsiString;
 l_S : AnsiString;
 l_Delim : AnsiChar;
//#UC END# *4DAEEDE10285_4DD547B70001_var*
begin
//#UC START# *4DAEEDE10285_4DD547B70001_impl*
 l_H := aCtx.rEngine.PopDelphiString;
 if (Length(l_H) > 0) then
  l_Delim := l_H[1]
 else
  l_Delim := #0; 
 l_S := aCtx.rCaller.ResolveOutputFilePath(aCtx.rEngine.PopDelphiString);
 RunnerAssert(Length(l_S) > 0, 'Имя файла не может быть пустым', aCtx);
 aCtx.rCaller.CheckWithEtalon(l_S, l_Delim);
//#UC END# *4DAEEDE10285_4DD547B70001_impl*
end;//TkwCheckEtalon.DoDoIt

initialization
 TkwCheckEtalon.RegisterInEngine;
 {* Регистрация CheckEtalon }
{$IfEnd} // NOT Defined(NoScripts)

end.
