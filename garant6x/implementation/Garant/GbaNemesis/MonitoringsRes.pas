unit MonitoringsRes;
 {* ����������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\MonitoringsRes.pas"
// ���������: "VCMApplication"
// ������� ������: "Monitorings" MUID: (4AA9038C0387)
// ��� ����: "TMonitoringsRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3IntfUses
 , ShellAndMonitoringsRes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchUnit
 , l3StringIDEx
;

const
 {* ������������ ������ MonitoringTitle }
 str_MonitoringTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MonitoringTitle'; rValue : '������ ����');
  {* '������ ����' }

type
 TMonitoringsRes = {final} class(TShellAndMonitoringsRes)
  {* ����������� }
  protected
   class procedure DoRun(var theSplash: IUnknown); override;
  public
   class function mod_opcode_CommonPost_SavePostList: TvcmMOPID;
   class function OpenPostingOrder(const aQuery: IQuery;
    const aContainer: IvcmContainer = nil): IvcmEntityForm;
   class procedure SavePostingList;
   class procedure CheckHistory;
    {* ������� ������������ �� �������, ���� ������� ����� ���������������� ��������� }
   class function StartOpen(const aContainer: IvcmContainer;
    aNewTab: Boolean): IvcmEntityForm;
   class procedure SavePostList;
    {* ��������� �������������� ����� � ���� }
   class function CanSavePostList: Boolean;
    {* ����� �� ��������� �������������� ����� � ���� }
 end;//TMonitoringsRes
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3ImplUses
 , moCommonPost
 , CommonPost_Module
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimMonitoringsMain_Form
 , MonitoringsMain_Form
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AA9038C0387impl_uses*
 , Forms
 //#UC END# *4AA9038C0387impl_uses*
;

class function TMonitoringsRes.mod_opcode_CommonPost_SavePostList: TvcmMOPID;
begin
 Result := g_module_opcode_CommonPost_SavePostList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;//TMonitoringsRes.mod_opcode_CommonPost_SavePostList

class function TMonitoringsRes.OpenPostingOrder(const aQuery: IQuery;
 const aContainer: IvcmContainer = nil): IvcmEntityForm;
begin
 Result := TCommonPostModule.OpenPostingOrder(aQuery, aContainer);
end;//TMonitoringsRes.OpenPostingOrder

class procedure TMonitoringsRes.SavePostingList;
begin
 TCommonPostModule.SavePostingList;
end;//TMonitoringsRes.SavePostingList

class procedure TMonitoringsRes.CheckHistory;
 {* ������� ������������ �� �������, ���� ������� ����� ���������������� ��������� }
begin
 TCommonPostModule.CheckHistory;
end;//TMonitoringsRes.CheckHistory

class function TMonitoringsRes.StartOpen(const aContainer: IvcmContainer;
 aNewTab: Boolean): IvcmEntityForm;
begin
 Result := TCommonPostModule.StartOpen(aContainer, aNewTab);
end;//TMonitoringsRes.StartOpen

class procedure TMonitoringsRes.SavePostList;
 {* ��������� �������������� ����� � ���� }
begin
 TCommonPostModule.SavePostList;
end;//TMonitoringsRes.SavePostList

class function TMonitoringsRes.CanSavePostList: Boolean;
 {* ����� �� ��������� �������������� ����� � ���� }
begin
 Result := TCommonPostModule.CanSavePostList;
end;//TMonitoringsRes.CanSavePostList

class procedure TMonitoringsRes.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4AA9038C0387_var*
var
 l_Main : TMonitoringsMainForm;
//#UC END# *4AA7E4DC0047_4AA9038C0387_var*
begin
//#UC START# *4AA7E4DC0047_4AA9038C0387_impl*
 inherited;
 Application.CreateForm(TMonitoringsMainForm, l_Main);
//#UC END# *4AA7E4DC0047_4AA9038C0387_impl*
end;//TMonitoringsRes.DoRun

initialization
 str_MonitoringTitle.Init;
 {* ������������� str_MonitoringTitle }
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

end.
