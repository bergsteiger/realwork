unit l3StringList1;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3StringList1.pas"
// �����: 18.02.2008 21:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3StringList1
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3StringListPrim,
  l3Interfaces,
  l3Types
  ;

type
 _l3DelphiStringSearcher_Parent_ = Tl3StringListPrim;
 {$Include ..\L3\l3DelphiStringSearcher.imp.pas}
 Tl3StringList1 = class(_l3DelphiStringSearcher_)
 end;//Tl3StringList1

implementation

uses
  l3String
  ;

type _Instance_R_ = Tl3StringList1;

{$Include ..\L3\l3DelphiStringSearcher.imp.pas}

end.