unit nsWindowsList;
 {* ����� ����������� ������� ���� }

// ������: "w:\common\components\gui\Garant\VCM\UserInteraction\nsWindowsList.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsWindowsList" MUID: (4ADC5175035B)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , nsWindowsListPrim
;

type
 TnsWindowsList = class(TnsWindowsListPrim)
  {* ����� ����������� ������� ���� }
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsWindowsList;
    {* ����� ��������� ���������� ���������� TnsWindowsList }
 end;//TnsWindowsList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsWindowsList: TnsWindowsList = nil;
 {* ��������� ���������� TnsWindowsList }

procedure TnsWindowsListFree;
 {* ����� ������������ ���������� ���������� TnsWindowsList }
begin
 l3Free(g_TnsWindowsList);
end;//TnsWindowsListFree

class function TnsWindowsList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsWindowsList <> nil;
end;//TnsWindowsList.Exists

class function TnsWindowsList.Instance: TnsWindowsList;
 {* ����� ��������� ���������� ���������� TnsWindowsList }
begin
 if (g_TnsWindowsList = nil) then
 begin
  l3System.AddExitProc(TnsWindowsListFree);
  g_TnsWindowsList := Create;
 end;
 Result := g_TnsWindowsList;
end;//TnsWindowsList.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
