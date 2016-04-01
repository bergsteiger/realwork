unit npControlsList;
 {* ������ ����������� �� �����, �� ������� ���� ����������� ����������. }

// ������: "w:\common\components\gui\Garant\VT\npControlsList.pas"
// ���������: "SimpleClass"
// ������� ������: "TnpControlsList" MUID: (4F61DE580121)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , npControlsListPrim
;

type
 TnpControlsList = class(TnpControlsListPrim)
  {* ������ ����������� �� �����, �� ������� ���� ����������� ����������. }
  public
   class function Instance: TnpControlsList;
    {* ����� ��������� ���������� ���������� TnpControlsList }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnpControlsList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnpControlsList: TnpControlsList = nil;
 {* ��������� ���������� TnpControlsList }

procedure TnpControlsListFree;
 {* ����� ������������ ���������� ���������� TnpControlsList }
begin
 l3Free(g_TnpControlsList);
end;//TnpControlsListFree

class function TnpControlsList.Instance: TnpControlsList;
 {* ����� ��������� ���������� ���������� TnpControlsList }
begin
 if (g_TnpControlsList = nil) then
 begin
  l3System.AddExitProc(TnpControlsListFree);
  g_TnpControlsList := Create;
 end;
 Result := g_TnpControlsList;
end;//TnpControlsList.Instance

class function TnpControlsList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnpControlsList <> nil;
end;//TnpControlsList.Exists
{$IfEnd} // NOT Defined(NoVCM)

end.
