unit kwKeyValues;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwKeyValues.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledProcedure
 , tfwScriptingInterfaces
;

type
 TkwKeyValues = class(TkwCompiledProcedure)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwKeyValues
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwKeyValuesPack
;

procedure TkwKeyValues.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_567ACBF70376_var*
//#UC END# *4DAEEDE10285_567ACBF70376_var*
begin
//#UC START# *4DAEEDE10285_567ACBF70376_impl*
 aCtx.rEngine.PushObj(Self);
//#UC END# *4DAEEDE10285_567ACBF70376_impl*
end;//TkwKeyValues.DoDoIt

initialization
 TkwKeyValues.RegisterClass;
 {* ����������� TkwKeyValues }
{$IfEnd} // NOT Defined(NoScripts)

end.
