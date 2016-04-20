unit kw_Search_opStartENO;
 {* ����� ������� ��� ������ �������� ������ Search.StartENO (�����) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opStartENO.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Search_opStartENO" MUID: (9D7E6A64E65F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , tfwModuleOperationWord
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
type
 Tkw_Search_opStartENO = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.StartENO (�����) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opStartENO

class function Tkw_Search_opStartENO.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_StartENO';
end;//Tkw_Search_opStartENO.GetWordNameForRegister

class function Tkw_Search_opStartENO.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_StartENO;
end;//Tkw_Search_opStartENO.GetModuleOperationCode

initialization
 Tkw_Search_opStartENO.RegisterInEngine;
 {* ����������� Tkw_Search_opStartENO }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
