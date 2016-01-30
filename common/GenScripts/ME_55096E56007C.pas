unit NOT_FINISHED_ChromeLikeTabSetStyles;

// ������: "w:\common\components\gui\Garant\ChromeLikeControls\NOT_FINISHED_ChromeLikeTabSetStyles.pas"
// ���������: "UtilityPack"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
;

type
 TChromeLikeTabSetStyles = class
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TChromeLikeTabSetStyles;
    {* ����� ��������� ���������� ���������� TChromeLikeTabSetStyles }
 end;//TChromeLikeTabSetStyles
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , GDIPUTIL
 , GDIPAPI
 , GDIPOBJ
 , SysUtils
 , l3Base
;

var g_TChromeLikeTabSetStyles: TChromeLikeTabSetStyles = nil;
 {* ��������� ���������� TChromeLikeTabSetStyles }

procedure TChromeLikeTabSetStylesFree;
 {* ����� ������������ ���������� ���������� TChromeLikeTabSetStyles }
begin
 l3Free(g_TChromeLikeTabSetStyles);
end;//TChromeLikeTabSetStylesFree

class function TChromeLikeTabSetStyles.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TChromeLikeTabSetStyles <> nil;
end;//TChromeLikeTabSetStyles.Exists

class function TChromeLikeTabSetStyles.Instance: TChromeLikeTabSetStyles;
 {* ����� ��������� ���������� ���������� TChromeLikeTabSetStyles }
begin
 if (g_TChromeLikeTabSetStyles = nil) then
 begin
  l3System.AddExitProc(TChromeLikeTabSetStylesFree);
  g_TChromeLikeTabSetStyles := Create;
 end;
 Result := g_TChromeLikeTabSetStyles;
end;//TChromeLikeTabSetStyles.Instance
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
