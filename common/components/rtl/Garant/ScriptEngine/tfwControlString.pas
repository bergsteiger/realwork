unit tfwControlString;
 {* ����� ��� ����������� �������� � ��� ������ }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwControlString.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwControlString" MUID: (508527F30183)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwString
;

type
 TtfwControlString = {abstract} class(TtfwString)
  {* ����� ��� ����������� �������� � ��� ������ }
 end;//TtfwControlString
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3Except
 , tfwClassRef
 , SysUtils
 , StrUtils
 //#UC START# *508527F30183impl_uses*
 //#UC END# *508527F30183impl_uses*
;

initialization
 TtfwControlString.RegisterClass;
 {* ����������� TtfwControlString }
{$IfEnd} // NOT Defined(NoScripts)

end.
