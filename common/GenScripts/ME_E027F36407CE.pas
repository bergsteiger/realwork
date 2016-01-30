unit CustomizeToolsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� CustomizeTools }

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\CustomizeToolsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include sdoDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimToolbarMenu_Module
 , tfwControlString
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , TtfwClassRef_Proxy
;

type
 Tkw_Form_CustomizeTools = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� CustomizeTools
----
*������ �������������*:
[code]
'aControl' �����::CustomizeTools TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Form_CustomizeTools

class function Tkw_Form_CustomizeTools.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::CustomizeTools';
end;//Tkw_Form_CustomizeTools.GetWordNameForRegister

function Tkw_Form_CustomizeTools.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9A898DB9E71E_var*
//#UC END# *4DDFD2EA0116_9A898DB9E71E_var*
begin
//#UC START# *4DDFD2EA0116_9A898DB9E71E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9A898DB9E71E_impl*
end;//Tkw_Form_CustomizeTools.GetString

class procedure Tkw_Form_CustomizeTools.RegisterInEngine;
//#UC START# *52A086150180_9A898DB9E71E_var*
//#UC END# *52A086150180_9A898DB9E71E_var*
begin
//#UC START# *52A086150180_9A898DB9E71E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9A898DB9E71E_impl*
end;//Tkw_Form_CustomizeTools.RegisterInEngine

initialization
 Tkw_Form_CustomizeTools.RegisterInEngine;
 {* ����������� Tkw_Form_CustomizeTools }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
