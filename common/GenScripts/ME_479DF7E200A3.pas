unit l3BaseRecList;

// ������: "w:\common\components\rtl\Garant\L3\l3BaseRecList.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoPtrRecList
;

type
 Tl3BaseRecList = class(Tl3ProtoPtrRecList)
  protected
   function DoCompare(const A;
    const B;
    DataSize: Cardinal): Integer; override;
    {* ���������� ��������. }
  public
   function CompareItem(A: Integer;
    const B;
    aDataSize: Cardinal): Integer;
    {* aDataSize - ������ ������������ ����� ������, ���� 0, �� ��� ������ }
 end;//Tl3BaseRecList

implementation

uses
 l3ImplUses
 , m2MemLib
;

function Tl3BaseRecList.CompareItem(A: Integer;
 const B;
 aDataSize: Cardinal): Integer;
 {* aDataSize - ������ ������������ ����� ������, ���� 0, �� ��� ������ }
//#UC START# *47BF07D000E6_479DF7E200A3_var*
//#UC END# *47BF07D000E6_479DF7E200A3_var*
begin
//#UC START# *47BF07D000E6_479DF7E200A3_impl*
 Result := DoCompare(ItemSlot(A)^, B, aDataSize);
//#UC END# *47BF07D000E6_479DF7E200A3_impl*
end;//Tl3BaseRecList.CompareItem

function Tl3BaseRecList.DoCompare(const A;
 const B;
 DataSize: Cardinal): Integer;
 {* ���������� ��������. }
//#UC START# *47BC677E02B1_479DF7E200A3_var*
//#UC END# *47BC677E02B1_479DF7E200A3_var*
begin
//#UC START# *47BC677E02B1_479DF7E200A3_impl*
 if DataSize = 0 then
  DataSize := ItemSize;
 Result := m2MEMCompare(@A, @B, DataSize);
//#UC END# *47BC677E02B1_479DF7E200A3_impl*
end;//Tl3BaseRecList.DoCompare

end.
