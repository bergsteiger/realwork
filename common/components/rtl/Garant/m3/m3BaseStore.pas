unit m3BaseStore;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3"
// ������: "w:/common/components/rtl/Garant/m3/m3BaseStore.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3BaseStore
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3CProtoObject,
  m3StorageInterfaces,
  m2InternalInterfaces
  ;

type
 _m3BaseStore_Parent_ = Tl3CProtoObject;
 {$Include ..\m3\m3BaseStore.imp.pas}
 Tm3BaseStore = {abstract} class(_m3BaseStore_)
 end;//Tm3BaseStore

implementation

uses
  ActiveX
  ;

{$Include ..\m3\m3BaseStore.imp.pas}

end.