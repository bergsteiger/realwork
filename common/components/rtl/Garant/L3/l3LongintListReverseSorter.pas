unit l3LongintListReverseSorter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3LongintListReverseSorter.pas"
// �����: 08.06.2011 22:32
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Containers::Tl3LongintListReverseSorter
//
// ������ ������, ������� ��������� �������� ������ � �������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3CustomLongintListView,
  l3PureMixIns
  ;

type
 Tl3LongintListReverseSorter = class(Tl3CustomLongintListView)
  {* ������ ������, ������� ��������� �������� ������ � �������� ������� }
 protected
 // realized methods
   function CompareData(const anItem1: _ItemType_;
     const anItem2: _ItemType_): Integer; override;
 end;//Tl3LongintListReverseSorter

implementation

// start class Tl3LongintListReverseSorter

function Tl3LongintListReverseSorter.CompareData(const anItem1: _ItemType_;
  const anItem2: _ItemType_): Integer;
//#UC START# *4DEFB2D90167_4DEFC02E01CF_var*
//#UC END# *4DEFB2D90167_4DEFC02E01CF_var*
begin
//#UC START# *4DEFB2D90167_4DEFC02E01CF_impl*
 Result := (anItem2 - anItem1);
//#UC END# *4DEFB2D90167_4DEFC02E01CF_impl*
end;//Tl3LongintListReverseSorter.CompareData

end.