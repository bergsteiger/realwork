unit NOT_COMPLETED_ShellAndMonitoringsRes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_COMPLETED_ShellAndMonitoringsRes.pas"
// ���������: "VCMApplication"
// ������� ������: "ShellAndMonitorings" MUID: (4AAA42BF0267)
// ��� ����: "TShellAndMonitoringsRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimF1Res
;

type
 TShellAndMonitoringsRes = {abstract} class(TPrimF1Res)
  protected
   procedure Loaded; override;
 end;//TShellAndMonitoringsRes
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , moCommonSearch
 , tasSaveLoadRealization
 , ShellAndMonitoringsMain_Form
 , evExtFormat
;

procedure TShellAndMonitoringsRes.Loaded;
begin
 inherited;
end;//TShellAndMonitoringsRes.Loaded
{$IfEnd} // NOT Defined(Admin)

end.
