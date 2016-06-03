unit PostingOrder_Strange_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PostingOrder_Strange_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Strange" MUID: (4C84EDB403D2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Op_SearchSupport_ActivatePostingsListForm = {final} class
  {* ����� ��� ������ �������� SearchSupport.ActivatePostingsListForm }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � ���������� }
   class procedure Broadcast;
    {* ����� �������� SearchSupport.ActivatePostingsListForm � ���� ������������������ ��������� }
 end;//Op_SearchSupport_ActivatePostingsListForm

const
 en_PostingToolBar = 'PostingToolBar';
 en_capPostingToolBar = '������ ��������';
 op_ptNewTheme = 'ptNewTheme';
 op_capptNewTheme = '';
 op_ptEditPosting = 'ptEditPosting';
 op_capptEditPosting = '';
 op_ptDeletePosting = 'ptDeletePosting';
 op_capptDeletePosting = '';
 op_SavePostList = 'SavePostList';
 op_capSavePostList = '';
 op_ExportSelected = 'ExportSelected';
 op_capExportSelected = '';
 en_SearchSupport = 'SearchSupport';
 en_capSearchSupport = '';
 op_ActivatePostingsListForm = 'ActivatePostingsListForm';
 op_capActivatePostingsListForm = '';
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchSupport_ActivatePostingsListForm, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchSupport_ActivatePostingsListForm, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class procedure Op_SearchSupport_ActivatePostingsListForm.Broadcast;
 {* ����� �������� SearchSupport.ActivatePostingsListForm � ���� ������������������ ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_SearchSupport_ActivatePostingsListForm, l_Params);
 end//vcmDispatcher <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Broadcast
{$IfEnd} // NOT Defined(Admin)

end.
