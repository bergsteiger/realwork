unit evSearcherList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/evSearcherList.pas"
// �����: 24.03.2008 18:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::nevUtils::TevSearcherList
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
 _ItemType_ = IevSearcher;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevSearcherList = class(_l3InterfaceRefList_)
 end;//TevSearcherList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TevSearcherList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.