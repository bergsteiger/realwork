unit kwPopClassInherits;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopClassInherits.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_class_Inherits" MUID: (53E0FC5E0100)
// Имя типа: "TkwPopClassInherits"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwPopClassInherits = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwPopClassInherits
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *53E0FC5E0100impl_uses*
 //#UC END# *53E0FC5E0100impl_uses*
;

class function TkwPopClassInherits.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:class:Inherits';
end;//TkwPopClassInherits.GetWordNameForRegister

procedure TkwPopClassInherits.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53E0FC5E0100_var*

 function IsInherits(anObject: TClass; const aClass: AnsiString): Boolean;
 begin//IsInherits
  if (anObject = nil) then
   Result := false
  else
  if AnsiSameText(anObject.ClassName, aClass) then
   Result := true
  else
   Result := IsInherits(anObject.ClassParent, aClass);
 end;//IsInherits

var
 l_A : TClass;
 l_B : TClass;
 l_C : ANSIString;
//#UC END# *4DAEEDE10285_53E0FC5E0100_var*
begin
//#UC START# *4DAEEDE10285_53E0FC5E0100_impl*
 l_A := aCtx.rEngine.PopClass;
 if aCtx.rEngine.IsTopClass then
 begin
  l_B := aCtx.rEngine.PopClass;
  if (l_A = nil) OR (l_B = nil) then
   aCtx.rEngine.PushBool(false)
  else
   aCtx.rEngine.PushBool(l_A.InheritsFrom(l_B));
 end//aCtx.rEngine.IsTopClass
 else
 begin
  l_C := aCtx.rEngine.PopDelphiString;
  if (l_A = nil) then
   aCtx.rEngine.PushBool(false)
  else
   aCtx.rEngine.PushBool(IsInherits(l_A, l_C));
 end;//aCtx.rEngine.IsTopClass
//#UC END# *4DAEEDE10285_53E0FC5E0100_impl*
end;//TkwPopClassInherits.DoDoIt

initialization
 TkwPopClassInherits.RegisterInEngine;
 {* Регистрация pop_class_Inherits }
{$IfEnd} // NOT Defined(NoScripts)

end.
