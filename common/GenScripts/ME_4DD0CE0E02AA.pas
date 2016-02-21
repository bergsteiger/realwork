unit tfwSysUtilsWord;
 {* ��������� ���� �� SysUtils }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwSysUtilsWord.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
;

type
 _tfwSysUtilsWordUses_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSysUtilsWordUses.imp.pas}
 TtfwSysUtilsWord = {abstract} class(_tfwSysUtilsWordUses_)
  {* ��������� ���� �� SysUtils }
 end;//TtfwSysUtilsWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwSysUtilsWordUses.imp.pas}

initialization
 TtfwSysUtilsWord.RegisterClass;
 {* ����������� TtfwSysUtilsWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
