unit moSettings;
 {* ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moSettings.pas"
// ���������: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Settings_Module
;

type
 Tmo_Settings = {final} class(TSettingsModule)
  {* ��������� }
 end;//Tmo_Settings
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
