unit l3ProtoObjectWithCOMQI;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3ProtoObjectWithCOMQI.pas"
// �����: 17.05.2011 16:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ProtoObjectWithCOMQI
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject,
  l3IID,
  l3Interfaces
  ;

type
 _l3COMQueryInterface_Parent_ = Tl3ProtoObject;
 {$Include ..\L3\l3COMQueryInterface.imp.pas}
 Tl3ProtoObjectWithCOMQI = class(_l3COMQueryInterface_)
 end;//Tl3ProtoObjectWithCOMQI

implementation

uses
  l3InterfacesMisc
  ;

{$Include ..\L3\l3COMQueryInterface.imp.pas}

end.