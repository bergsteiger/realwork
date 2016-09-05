unit kwCompiledProcedureWithStackChecking;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWithStackChecking.pas"
// ���������: "SimpleClass"
// ������� ������: "TkwCompiledProcedureWithStackChecking" MUID: (528F655002C2)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledProcedure
 , tfwScriptingInterfaces
;

type
 _tfwStackChecking_Parent_ = TkwCompiledProcedure;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwStackChecking.imp.pas}
 TkwCompiledProcedureWithStackChecking = class(_tfwStackChecking_)
 end;//TkwCompiledProcedureWithStackChecking
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *528F655002C2impl_uses*
 //#UC END# *528F655002C2impl_uses*
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwStackChecking.imp.pas}

initialization
 TkwCompiledProcedureWithStackChecking.RegisterClass;
 {* ����������� TkwCompiledProcedureWithStackChecking }
{$IfEnd} // NOT Defined(NoScripts)

end.
