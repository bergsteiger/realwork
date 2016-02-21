unit kwCompiledIfElse;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIfElse.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledIF
 , tfwScriptingInterfaces
;

type
 TkwCompiledIfElse = class(TkwCompiledIF)
  private
   f_Condition: TtfwWord;
    {* Поле для свойства Condition }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   constructor Create(aCondition: TtfwWord;
    anIf: TtfwWord;
    anElse: TtfwWord;
    const aCtx: TtfwContext); reintroduce;
   procedure SetElse(anElse: TtfwWord);
  public
   property Condition: TtfwWord
    read f_Condition;
 end;//TkwCompiledIfElse
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TkwCompiledIfElse.Create(aCondition: TtfwWord;
 anIf: TtfwWord;
 anElse: TtfwWord;
 const aCtx: TtfwContext);
//#UC START# *5284EED900B6_5284E9510053_var*
//#UC END# *5284EED900B6_5284E9510053_var*
begin
//#UC START# *5284EED900B6_5284E9510053_impl*
 inherited Create(anIf, anElse, aCtx);
 aCondition.SetRefTo(f_Condition);
//#UC END# *5284EED900B6_5284E9510053_impl*
end;//TkwCompiledIfElse.Create

procedure TkwCompiledIfElse.SetElse(anElse: TtfwWord);
//#UC START# *5284FE8F025F_5284E9510053_var*
//#UC END# *5284FE8F025F_5284E9510053_var*
begin
//#UC START# *5284FE8F025F_5284E9510053_impl*
 if (f_ElseBranch Is TkwCompiledIfElse) then
  TkwCompiledIfElse(f_ElseBranch).SetElse(anElse)
 else
 begin
  Assert(f_ElseBranch = nil);
  anElse.SetRefTo(f_ElseBranch);
 end;//f_Else Is TkwCompiledIfElse
//#UC END# *5284FE8F025F_5284E9510053_impl*
end;//TkwCompiledIfElse.SetElse

procedure TkwCompiledIfElse.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5284E9510053_var*
//#UC END# *479731C50290_5284E9510053_var*
begin
//#UC START# *479731C50290_5284E9510053_impl*
 FreeAndNil(f_Condition);
 inherited;
//#UC END# *479731C50290_5284E9510053_impl*
end;//TkwCompiledIfElse.Cleanup

procedure TkwCompiledIfElse.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5284E9510053_var*
//#UC END# *4DAEEDE10285_5284E9510053_var*
begin
//#UC START# *4DAEEDE10285_5284E9510053_impl*
 f_Condition.DoIt(aCtx);
 inherited;
//#UC END# *4DAEEDE10285_5284E9510053_impl*
end;//TkwCompiledIfElse.DoDoIt

initialization
 TkwCompiledIfElse.RegisterClass;
 {* Регистрация TkwCompiledIfElse }
{$IfEnd} // NOT Defined(NoScripts)

end.
