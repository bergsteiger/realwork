unit l3MemorySizeUtils;

// ������: "w:\common\components\rtl\Garant\L3\l3MemorySizeUtils.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3MemorySizeUtilsPrim
;

type
 PMem = PANSIChar;

{$If NOT Defined(XE)}
var l3MemorySize: Tl3MemorySizeFunc = l3MemorySizeDelphi7;
 {* ������� ��� ��������� ������� ����� ������ }
{$IfEnd} // NOT Defined(XE)
{$If Defined(XE)}
var l3MemorySize: Tl3MemorySizeFunc = l3MemorySizeXE;
 {* ������� ��� ��������� ������� ����� ������ }
{$IfEnd} // Defined(XE)

implementation

uses
 l3ImplUses
;

end.
