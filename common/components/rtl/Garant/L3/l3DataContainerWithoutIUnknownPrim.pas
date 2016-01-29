unit l3DataContainerWithoutIUnknownPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3DataContainerWithoutIUnknownPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3DataContainerWithoutIUnknownPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3CastablePersistent,
  l3PureMixIns,
  l3IID,
  l3Interfaces
  ;

 {$Define l3Unknown_NoIUnknown}

 {$Undef l3Unknown_NoMultiThread}

type
 _l3Unknown_Parent_ = Tl3CastablePersistent;
 {$Include ..\L3\l3Unknown.imp.pas}
 _l3DataContainer_Parent_ = _l3Unknown_;
 {$Include ..\L3\l3DataContainer.imp.pas}
 _l3COMQueryInterface_Parent_ = _l3DataContainer_;
 {$Include ..\L3\l3COMQueryInterface.imp.pas}
 Tl3DataContainerWithoutIUnknownPrim = {abstract} class(_l3COMQueryInterface_)
 end;//Tl3DataContainerWithoutIUnknownPrim

implementation

uses
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  Classes,
  l3MemUtils,
  l3Interlocked,
  l3InterfacesMisc
  ;

{$Include ..\L3\l3Unknown.imp.pas}

{$Include ..\L3\l3DataContainer.imp.pas}

{$Include ..\L3\l3COMQueryInterface.imp.pas}

end.