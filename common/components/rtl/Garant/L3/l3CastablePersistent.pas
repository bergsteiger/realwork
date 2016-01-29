unit l3CastablePersistent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3CastablePersistent.pas"
// �����: 30.01.2008 22:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CastablePersistent
//
// TPersistent � ������� QueryInterface.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes,
  l3Interfaces
  ;

type
 _l3Castable_Parent_ = TPersistent;
 {$Include ..\L3\l3Castable.imp.pas}
 Tl3CastablePersistent = {abstract} class(_l3Castable_)
  {* TPersistent � ������� QueryInterface. }
 end;//Tl3CastablePersistent

implementation

{$Include ..\L3\l3Castable.imp.pas}

end.