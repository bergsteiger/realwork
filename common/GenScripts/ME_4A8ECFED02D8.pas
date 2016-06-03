unit Autoreferat_InternalOperations_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Autoreferat_InternalOperations_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "InternalOperations" MUID: (4A8ECFED02D8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 Op_DateInterval_OpenInt = {final} class
  {* ����� ��� ������ �������� DateInterval.OpenInt }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� DateInterval.OpenInt � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� DateInterval.OpenInt � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� DateInterval.OpenInt � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� DateInterval.OpenInt � ���������� }
 end;//Op_DateInterval_OpenInt

const
 en_DateInterval = 'DateInterval';
 en_capDateInterval = '';
 op_OpenInt = 'OpenInt';
 op_capOpenInt = '';
 en_NewsThemes = 'NewsThemes';
 en_capNewsThemes = '';
 op_SelectCurrent = 'SelectCurrent';
 op_capSelectCurrent = '';
 op_Open = 'Open';
 op_capOpen = '';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� DateInterval.OpenInt � �������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_DateInterval_OpenInt, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� DateInterval.OpenInt � ��������� }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_DateInterval_OpenInt, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� DateInterval.OpenInt � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� DateInterval.OpenInt � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_DateInterval_OpenInt.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
