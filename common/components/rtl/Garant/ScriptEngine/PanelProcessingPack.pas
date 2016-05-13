unit PanelProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\PanelProcessingPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "PanelProcessingPack" MUID: (54F5D17A03B9)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ExtCtrls
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

initialization
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPanel));
 {* ����������� ���� TPanel }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
