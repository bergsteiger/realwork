unit kwCompiledProcedure;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedure.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwCompiledProcedure" MUID: (4F216D8D01A0)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWord
 , tfwScriptingInterfaces
;

type
 TkwCompiledProcedure = class(TkwCompiledWord)
  protected
   f_Modifiers: TtfwWordInfo;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoDoIt(const aCtx: TtfwContext); override;
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
   procedure SetResultTypeInfo(aValue: TtfwWordInfo;
    const aCtx: TtfwContext); override;
 end;//TkwCompiledProcedure
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassRef
 , tfwScriptingTypes
 , l3String
 , kwKeyValuesPack
 , kwCompiledProcedureWordsPack
 //#UC START# *4F216D8D01A0impl_uses*
 //#UC END# *4F216D8D01A0impl_uses*
;

procedure TkwCompiledProcedure.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F216D8D01A0_var*
//#UC END# *479731C50290_4F216D8D01A0_var*
begin
//#UC START# *479731C50290_4F216D8D01A0_impl*
 f_Modifiers := nil;
 inherited;
//#UC END# *479731C50290_4F216D8D01A0_impl*
end;//TkwCompiledProcedure.Cleanup

procedure TkwCompiledProcedure.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F216D8D01A0_var*
//#UC END# *4DAEEDE10285_4F216D8D01A0_var*
begin
//#UC START# *4DAEEDE10285_4F216D8D01A0_impl*
 try
  inherited;
 except
  on EtfwExit do
   ;
  on EtfwBreak do
   raise EtfwCodeFlowError.Create('BREAK не может пересекать границу процедуры');
  on EtfwContinue do
   raise EtfwCodeFlowError.Create('CONTINUE не может пересекать границу процедуры'); 
 end;//try..except
//#UC END# *4DAEEDE10285_4F216D8D01A0_impl*
end;//TkwCompiledProcedure.DoDoIt

function TkwCompiledProcedure.IsImmediate(const aCtx: TtfwContext): Boolean;
//#UC START# *4DB6D7F70155_4F216D8D01A0_var*
//#UC END# *4DB6D7F70155_4F216D8D01A0_var*
begin
//#UC START# *4DB6D7F70155_4F216D8D01A0_impl*
 Result := Self.ResultTypeInfo[aCtx].Has(tfw_wmImmediate);
 //Result := inherited IsImmediate(aCtx);
//#UC END# *4DB6D7F70155_4F216D8D01A0_impl*
end;//TkwCompiledProcedure.IsImmediate

function TkwCompiledProcedure.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_4F216D8D01A0get_var*
//#UC END# *52CFC11603C8_4F216D8D01A0get_var*
begin
//#UC START# *52CFC11603C8_4F216D8D01A0get_impl*
 Result := f_Modifiers; 
//#UC END# *52CFC11603C8_4F216D8D01A0get_impl*
end;//TkwCompiledProcedure.pm_GetResultTypeInfo

procedure TkwCompiledProcedure.SetResultTypeInfo(aValue: TtfwWordInfo;
 const aCtx: TtfwContext);
//#UC START# *52EA6A2C0111_4F216D8D01A0_var*
//#UC END# *52EA6A2C0111_4F216D8D01A0_var*
begin
//#UC START# *52EA6A2C0111_4F216D8D01A0_impl*
 CompilerAssert(aValue.ValueTypes.Empty OR aValue.ValueTypes.EQ(@tfw_tiVoid),
                'Неверный список модификаторов: ' + l3Str(aValue.ValueTypes.Name),
                aCtx);
 f_Modifiers := aValue.Clone;
//#UC END# *52EA6A2C0111_4F216D8D01A0_impl*
end;//TkwCompiledProcedure.SetResultTypeInfo

initialization
 TkwCompiledProcedure.RegisterClass;
 {* Регистрация TkwCompiledProcedure }
{$IfEnd} // NOT Defined(NoScripts)

end.
