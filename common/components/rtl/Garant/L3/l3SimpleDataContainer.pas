unit l3SimpleDataContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3SimpleDataContainer.pas"
// �����: 20.02.2008 17:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3SimpleDataContainer
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleObject
  ;

type
 _l3DataContainer_Parent_ = Tl3SimpleObject;
 {$Include ..\L3\l3DataContainer.imp.pas}
 Tl3SimpleDataContainer = {abstract} class(_l3DataContainer_)
 end;//Tl3SimpleDataContainer

implementation

{$Include ..\L3\l3DataContainer.imp.pas}

end.