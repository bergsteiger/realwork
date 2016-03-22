unit kwCloseBracket;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCloseBracket.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "CloseBracket" MUID: (52D6AC0F0186)
// Имя типа: "TkwCloseBracket"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCloseBracket = {abstract} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
   function IsCloseBracket: Boolean; override;
 end;//TkwCloseBracket
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
;

procedure TkwCloseBracket.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52D6AC0F0186_var*
//#UC END# *4DAEEDE10285_52D6AC0F0186_var*
begin
//#UC START# *4DAEEDE10285_52D6AC0F0186_impl*
 if (Self.ClassType = aCtx.rWordCompilingNow.GetEndBracket(aCtx, false)) then
  PtfwContext(@aCtx)^.rWasCloseBracket := true
 else
  CompilerAssert(false, 'Непарная закрывающаяся скобка', aCtx);
//#UC END# *4DAEEDE10285_52D6AC0F0186_impl*
end;//TkwCloseBracket.DoDoIt

function TkwCloseBracket.IsImmediate(const aCtx: TtfwContext): Boolean;
begin
 Result := True;
end;//TkwCloseBracket.IsImmediate

function TkwCloseBracket.IsCloseBracket: Boolean;
//#UC START# *52D6ABCB0026_52D6AC0F0186_var*
//#UC END# *52D6ABCB0026_52D6AC0F0186_var*
begin
//#UC START# *52D6ABCB0026_52D6AC0F0186_impl*
 Result := true;
//#UC END# *52D6ABCB0026_52D6AC0F0186_impl*
end;//TkwCloseBracket.IsCloseBracket

initialization
 TkwCloseBracket.RegisterClass;
 {* Регистрация CloseBracket }
{$IfEnd} // NOT Defined(NoScripts)

end.
