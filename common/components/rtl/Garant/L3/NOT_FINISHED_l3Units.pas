unit NOT_FINISHED_l3Units;
 {* ������ ����������� ������ � ���������� ��������� ���������. }

// ������: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Units.pas"
// ���������: "Interfaces"
// ������� ������: "l3Units" MUID: (472745450206)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tl3Point = {$IfDef XE4}record{$Else}object{$EndIf}
  {* ����� � ������������ � ������ (������� ����������). }
 end;//Tl3Point

 Tl3SPoint = {$IfDef XE4}record{$Else}object{$EndIf}
  {* ����� � ������������ � �������� (�� ������). }
 end;//Tl3SPoint

 Tl3Rect = {$IfDef XE4}record{$Else}object{$EndIf}
  {* ������������� � ������������ � ������ (������� ����������). }
 end;//Tl3Rect

 Tl3SRect = {$IfDef XE4}record{$Else}object{$EndIf}
  {* ������������� � ������������ � �������� (�� ������). }
 end;//Tl3SRect

implementation

uses
 l3ImplUses
;

end.
