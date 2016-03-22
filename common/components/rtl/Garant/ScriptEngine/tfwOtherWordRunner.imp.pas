{$IfNDef tfwOtherWordRunner_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwOtherWordRunner.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "tfwOtherWordRunner" MUID: (556305F800A9)
// Имя типа: "_tfwOtherWordRunner_"

{$Define tfwOtherWordRunner_imp}

{$If NOT Defined(NoScripts)}
 _tfwOtherWordRunner_ = {abstract} class(_tfwOtherWordRunner_Parent_)
  protected
   procedure RunOther(const aCtx: TtfwContext);
   function GetWordToRun: TtfwAnonimousWord; virtual; abstract;
 end;//_tfwOtherWordRunner_

{$Else NOT Defined(NoScripts)}

_tfwOtherWordRunner_ = _tfwOtherWordRunner_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else tfwOtherWordRunner_imp}

{$IfNDef tfwOtherWordRunner_imp_impl}

{$Define tfwOtherWordRunner_imp_impl}

{$If NOT Defined(NoScripts)}
procedure _tfwOtherWordRunner_.RunOther(const aCtx: TtfwContext);
//#UC START# *5563064D0054_556305F800A9_var*
//#UC END# *5563064D0054_556305F800A9_var*
begin
//#UC START# *5563064D0054_556305F800A9_impl*
 GetWordToRun.DoRun(aCtx);
//#UC END# *5563064D0054_556305F800A9_impl*
end;//_tfwOtherWordRunner_.RunOther
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf tfwOtherWordRunner_imp_impl}

{$EndIf tfwOtherWordRunner_imp}

