unit l3CBTListenersList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3CBTListenersList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Listeners::Tl3CBTListenersList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Il3CBTListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3InterfacePtrList.imp.pas}
 Tl3CBTListenersList = class(_l3InterfacePtrList_)
 end;//Tl3CBTListenersList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3CBTListenersList;

{$Include ..\L3\l3InterfacePtrList.imp.pas}

end.