unit kwDEFAULT;
 {* Внутреннее слово для определения ветки по умолчанию в скомпилированном Case. Не предназначено для прямого вызова. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwDEFAULT.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "DEFAULT" MUID: (4DBAF3D60039)
// Имя типа: "TkwDEFAULT"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDEFAULT = class(TtfwRegisterableWord)
  {* Внутреннее слово для определения ветки по умолчанию в скомпилированном Case. Не предназначено для прямого вызова. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function IsDefaultBranch: Boolean; override;
 end;//TkwDEFAULT
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwDEFAULT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBAF3D60039_var*
//#UC END# *4DAEEDE10285_4DBAF3D60039_var*
begin
//#UC START# *4DAEEDE10285_4DBAF3D60039_impl*
 RunnerError('Слово DEFAULT не должно вызываться', aCtx);
//#UC END# *4DAEEDE10285_4DBAF3D60039_impl*
end;//TkwDEFAULT.DoDoIt

class function TkwDEFAULT.GetWordNameForRegister: AnsiString;
begin
 Result := 'DEFAULT';
end;//TkwDEFAULT.GetWordNameForRegister

function TkwDEFAULT.IsDefaultBranch: Boolean;
//#UC START# *4DBAF4630154_4DBAF3D60039_var*
//#UC END# *4DBAF4630154_4DBAF3D60039_var*
begin
//#UC START# *4DBAF4630154_4DBAF3D60039_impl*
 Result := true;
//#UC END# *4DBAF4630154_4DBAF3D60039_impl*
end;//TkwDEFAULT.IsDefaultBranch

initialization
 TkwDEFAULT.RegisterInEngine;
 {* Регистрация DEFAULT }
{$IfEnd} // NOT Defined(NoScripts)

end.
