unit nscTreeViewRes;
 {* ������� ��� TnscTreeView }

// ������: "w:\common\components\gui\Garant\Nemesis\nscTreeViewRes.pas"
// ���������: "UtilityPack"
// ������� ������: "nscTreeViewRes" MUID: (4B97DC630378)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ nscMultiStroke }
 str_nsc_WrapHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_WrapHint'; rValue : '�������� ������� �� ������');
  {* '�������� ������� �� ������' }
 str_nsc_UnwrapHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_UnwrapHint'; rValue : '��������� ������� �� ������');
  {* '��������� ������� �� ������' }
 {* ����� �������������� �������������� ����� nscMultiStroke }
 nscMultiStrokeMap: array [Boolean] of Pl3StringIDEx = (
 @str_nsc_WrapHint
 , @str_nsc_UnwrapHint
 );
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_nsc_WrapHint.Init;
 {* ������������� str_nsc_WrapHint }
 str_nsc_UnwrapHint.Init;
 {* ������������� str_nsc_UnwrapHint }
{$IfEnd} // Defined(Nemesis)

end.
