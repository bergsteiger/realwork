unit l3ProtoObjectComparable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3ProtoObjectComparable.pas"
// �����: 16.02.2011 19:17
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::OVP::Tl3ProtoObjectComparable
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject
  ;

type
 Tl3ProtoObjectComparable = class(Tl3ProtoObject)
 public
 // public methods
   function CompareWith(anOther: Tl3ProtoObjectComparable): Integer; virtual; abstract;
 end;//Tl3ProtoObjectComparable

implementation

end.