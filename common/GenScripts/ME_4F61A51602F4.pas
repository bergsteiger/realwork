unit vtNavigatorFormList;

// ������: "w:\common\components\gui\Garant\VT\vtNavigatorFormList.pas"
// ���������: "SimpleClass"
// ������� ������: "TvtNavigatorFormList" MUID: (4F61A51602F4)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vtNavigatorFormListPrim
;

type
 TvtNavigatorFormList = class(TvtNavigatorFormListPrim)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TvtNavigatorFormList;
    {* ����� ��������� ���������� ���������� TvtNavigatorFormList }
 end;//TvtNavigatorFormList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TvtNavigatorFormList: TvtNavigatorFormList = nil;
 {* ��������� ���������� TvtNavigatorFormList }

procedure TvtNavigatorFormListFree;
 {* ����� ������������ ���������� ���������� TvtNavigatorFormList }
begin
 l3Free(g_TvtNavigatorFormList);
end;//TvtNavigatorFormListFree

class function TvtNavigatorFormList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvtNavigatorFormList <> nil;
end;//TvtNavigatorFormList.Exists

class function TvtNavigatorFormList.Instance: TvtNavigatorFormList;
 {* ����� ��������� ���������� ���������� TvtNavigatorFormList }
begin
 if (g_TvtNavigatorFormList = nil) then
 begin
  l3System.AddExitProc(TvtNavigatorFormListFree);
  g_TvtNavigatorFormList := Create;
 end;
 Result := g_TvtNavigatorFormList;
end;//TvtNavigatorFormList.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
