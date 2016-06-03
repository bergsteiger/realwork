unit LegalDomain_DocumentNotifications_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LegalDomain_DocumentNotifications_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "DocumentNotifications" MUID: (4EAAE5A1005E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
 Op_Comment_Changed = {final} class
  {* ����� ��� ������ �������� Comment.Changed }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Comment.Changed � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Comment.Changed � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Comment.Changed � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Comment.Changed � ���������� }
   class procedure Broadcast;
    {* ����� �������� Comment.Changed � ���� ������������������ ��������� }
 end;//Op_Comment_Changed

const
 en_Comment = 'Comment';
 en_capComment = '';
 op_Changed = 'Changed';
 op_capChanged = '';

implementation

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

class function Op_Comment_Changed.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Comment.Changed � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Comment_Changed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Comment.Changed � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Comment_Changed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Comment.Changed � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Comment.Changed � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Comment_Changed.Call

class procedure Op_Comment_Changed.Broadcast;
 {* ����� �������� Comment.Changed � ���� ������������������ ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_Comment_Changed, l_Params);
 end//vcmDispatcher <> nil
end;//Op_Comment_Changed.Broadcast

end.
