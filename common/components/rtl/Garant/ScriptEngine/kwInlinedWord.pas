unit kwInlinedWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwInlinedWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwInlinedWord" MUID: (53ED9C3B01F3)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWord
 , tfwScriptingInterfaces
;

type
 TkwInlinedWord = class(TkwCompiledWord)
  protected
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   procedure SetResultTypeInfo(aValue: TtfwWordInfo;
    const aCtx: TtfwContext); override;
 end;//TkwInlinedWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *53ED9C3B01F3impl_uses*
 //#UC END# *53ED9C3B01F3impl_uses*
;

function TkwInlinedWord.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_53ED9C3B01F3get_var*
//#UC END# *52CFC11603C8_53ED9C3B01F3get_var*
begin
//#UC START# *52CFC11603C8_53ED9C3B01F3get_impl*
 Result := TtfwWordInfo.Make(nil, [tfw_wmInline], tfw_atNone, tfw_ltNone);
//#UC END# *52CFC11603C8_53ED9C3B01F3get_impl*
end;//TkwInlinedWord.pm_GetResultTypeInfo

procedure TkwInlinedWord.SetResultTypeInfo(aValue: TtfwWordInfo;
 const aCtx: TtfwContext);
//#UC START# *52EA6A2C0111_53ED9C3B01F3_var*
//#UC END# *52EA6A2C0111_53ED9C3B01F3_var*
begin
//#UC START# *52EA6A2C0111_53ED9C3B01F3_impl*
 CompilerAssert(aValue.EQwm([tfw_wmInline]), 'Неверный список модификаторов', aCtx);
//#UC END# *52EA6A2C0111_53ED9C3B01F3_impl*
end;//TkwInlinedWord.SetResultTypeInfo

initialization
 TkwInlinedWord.RegisterClass;
 {* Регистрация TkwInlinedWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
