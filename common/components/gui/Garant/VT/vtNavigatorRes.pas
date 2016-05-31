unit vtNavigatorRes;

// ������: "w:\common\components\gui\Garant\VT\vtNavigatorRes.pas"
// ���������: "UtilityPack"
// ������� ������: "vtNavigatorRes" MUID: (4B8D2783018D)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ TvtNavigatorHints }
 str_vtAutoHideOffHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAutoHideOffHint'; rValue : '������������� ������ ���������');
  {* '������������� ������ ���������' }
 str_vtAutoHideOnHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAutoHideOnHint'; rValue : '����������� ������ ���������');
  {* '����������� ������ ���������' }
 str_vtMinimizedOnHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMinimizedOnHint'; rValue : '��������');
  {* '��������' }
 str_vtMinimizedOffHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMinimizedOffHint'; rValue : '����������');
  {* '����������' }
 str_vtBtnCloseHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtBtnCloseHint'; rValue : '���������� ���������');
  {* '���������� ���������' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

initialization
 str_vtAutoHideOffHint.Init;
 {* ������������� str_vtAutoHideOffHint }
 str_vtAutoHideOnHint.Init;
 {* ������������� str_vtAutoHideOnHint }
 str_vtMinimizedOnHint.Init;
 {* ������������� str_vtMinimizedOnHint }
 str_vtMinimizedOffHint.Init;
 {* ������������� str_vtMinimizedOffHint }
 str_vtBtnCloseHint.Init;
 {* ������������� str_vtBtnCloseHint }
{$IfEnd} // NOT Defined(NoVCM)

end.
