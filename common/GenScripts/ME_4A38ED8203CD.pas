unit evCursorConst;
 {* ��������� ��� ������ � �������� }

// ������: "w:\common\components\gui\Garant\Everest\evCursorConst.pas"
// ���������: "UtilityPack"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
;

const
 ev_cpTop = -1;
 ev_cpBottom = -2;
 ev_cpNull = -3;
 ev_cpAtEnd = High(Integer);
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
