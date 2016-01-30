unit vcmCommandIDsList;

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsList.pas"
// ���������: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmCommandIDsListPrim
;

type
 TvcmCommandIDsList = {final} class(TvcmCommandIDsListPrim)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TvcmCommandIDsList;
    {* ����� ��������� ���������� ���������� TvcmCommandIDsList }
 end;//TvcmCommandIDsList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TvcmCommandIDsList: TvcmCommandIDsList = nil;
 {* ��������� ���������� TvcmCommandIDsList }

procedure TvcmCommandIDsListFree;
 {* ����� ������������ ���������� ���������� TvcmCommandIDsList }
begin
 l3Free(g_TvcmCommandIDsList);
end;//TvcmCommandIDsListFree

class function TvcmCommandIDsList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmCommandIDsList <> nil;
end;//TvcmCommandIDsList.Exists

class function TvcmCommandIDsList.Instance: TvcmCommandIDsList;
 {* ����� ��������� ���������� ���������� TvcmCommandIDsList }
begin
 if (g_TvcmCommandIDsList = nil) then
 begin
  l3System.AddExitProc(TvcmCommandIDsListFree);
  g_TvcmCommandIDsList := Create;
 end;
 Result := g_TvcmCommandIDsList;
end;//TvcmCommandIDsList.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
