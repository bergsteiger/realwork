unit l3ProtoDataContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3ProtoDataContainer.pas"
// �����: 08.07.2009 21:55
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ProtoDataContainer
//
// ����� ����������� ��������� ������
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
 _l3DataContainer_Parent_ = Tl3ProtoObject;
 {$Include ..\L3\l3DataContainer.imp.pas}
 Tl3ProtoDataContainer = {abstract} class(_l3DataContainer_)
  {* ����� ����������� ��������� ������ }
 end;//Tl3ProtoDataContainer

implementation

{$Include ..\L3\l3DataContainer.imp.pas}

end.