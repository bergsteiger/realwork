unit NOT_FINISHED_l3Units;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Domain"
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Units.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi ���������� � �������������� �����������::L3$Domain::l3Units
//
// ������ ����������� ������ � ���������� ��������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

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

end.