unit l3MemorySizeUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Basic Concepts"
// ������: "l3MemorySizeUtils.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: UtilityPack::Class Shared Delphi ���������� � �������������� �����������::L3$Basic Concepts::MemoryUtils::l3MemorySizeUtils
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\L3\l3Define.inc}

interface

uses
  l3MemorySizeUtilsPrim
  ;

type
 PMem = System.PANSIChar;

{$If not defined(XE)}
var l3MemorySize : Tl3MemorySizeFunc = L3MemorySizeDelphi7;
 {* ������� ��� ��������� ������� ����� ������}
{$IfEnd} //not XE

{$If defined(XE)}
var l3MemorySize : Tl3MemorySizeFunc = L3MemorySizeXE;
 {* ������� ��� ��������� ������� ����� ������}
{$IfEnd} //XE

implementation

end.