unit kwCompiledProcedureWithStackChecking;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWithStackChecking.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledProcedure
 , tfwScriptingInterfaces
;

type
 _tfwStackChecking_Parent_ = TkwCompiledProcedure;
 {$Include tfwStackChecking.imp.pas}
 TkwCompiledProcedureWithStackChecking = class(_tfwStackChecking_)
 end;//TkwCompiledProcedureWithStackChecking
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$Include tfwStackChecking.imp.pas}

initialization
 TkwCompiledProcedureWithStackChecking.RegisterClass;
 {* ����������� TkwCompiledProcedureWithStackChecking }
{$IfEnd} // NOT Defined(NoScripts)

end.
