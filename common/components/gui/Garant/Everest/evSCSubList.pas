unit evSCSubList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evSCSubList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::SubCompare::TevSCSubList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3ProtoDataContainer,
  evSubCompareInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IevSCSub;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevSCSubList = class(_l3InterfaceRefList_)
 end;//TevSCSubList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TevSCSubList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.