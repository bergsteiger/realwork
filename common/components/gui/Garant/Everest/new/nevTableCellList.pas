unit nevTableCellList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevTableCellList.pas"
// �����: 25.03.2008 16:53
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::nevUtils::TnevTableCellList
//
// ������ InevTableCell.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevTools,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = InevTableCell;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevTableCellList = class(_l3InterfaceRefList_)
  {* ������ InevTableCell. }
 end;//TnevTableCellList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TnevTableCellList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.