{$IfNDef tfwStackChecking_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStackChecking.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "tfwStackChecking" MUID: (528F7DDA02BF)
// Имя типа: "_tfwStackChecking_"

{$Define tfwStackChecking_imp}

{$If NOT Defined(NoScripts)}
 _tfwStackChecking_ = class(_tfwStackChecking_Parent_)
  protected
   function StackCheckingMessage: AnsiString; virtual;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//_tfwStackChecking_

{$Else NOT Defined(NoScripts)}

_tfwStackChecking_ = _tfwStackChecking_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else tfwStackChecking_imp}

{$IfNDef tfwStackChecking_imp_impl}

{$Define tfwStackChecking_imp_impl}

{$If NOT Defined(NoScripts)}
function _tfwStackChecking_.StackCheckingMessage: AnsiString;
//#UC START# *528F7301033E_528F7DDA02BF_var*
//#UC END# *528F7301033E_528F7DDA02BF_var*
begin
//#UC START# *528F7301033E_528F7DDA02BF_impl*
 Result := 'Процедура не может возвращать значения через стек';
//#UC END# *528F7301033E_528F7DDA02BF_impl*
end;//_tfwStackChecking_.StackCheckingMessage

procedure _tfwStackChecking_.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_528F7DDA02BF_var*
var
 l_StackCount : Integer;
 l_ParamCount : Integer;
//#UC END# *4DAEEDE10285_528F7DDA02BF_var*
begin
//#UC START# *4DAEEDE10285_528F7DDA02BF_impl*
 l_StackCount := aCtx.rEngine.ValuesCount;
 l_ParamCount := Self.GetAllParamsCount(aCtx);
 inherited;
 l_StackCount := aCtx.rEngine.ValuesCount - (l_StackCount - l_ParamCount);
 if (l_StackCount > 0) then
 begin
  while (l_StackCount > 0) do
  // - чистим мусор, чтобы он не достался остальным
  begin
   aCtx.rEngine.Drop;
   Dec(l_StackCount);
  end;//while (l_StackCount > 0)
  RunnerError(StackCheckingMessage, aCtx);
 end//l_StackCount > 0
 else
 if (l_StackCount < 0) then
 begin
  RunnerAssertFmt(false, 'Со стека забрали больше значений: %d, чем описано параметров: %d', [l_ParamCount-l_StackCount, l_ParamCount], aCtx);
 end;//l_StackCount < 0
//#UC END# *4DAEEDE10285_528F7DDA02BF_impl*
end;//_tfwStackChecking_.DoDoIt
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf tfwStackChecking_imp_impl}

{$EndIf tfwStackChecking_imp}

