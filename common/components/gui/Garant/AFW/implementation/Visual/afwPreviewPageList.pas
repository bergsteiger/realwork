unit afwPreviewPageList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwPreviewPageList.pas"
// �����: 19.03.2008
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::AFW::Draw::TafwPreviewPageList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwInterfaces,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IafwPreviewPage;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TafwPreviewPageList = class(_l3InterfaceRefList_)
 end;//TafwPreviewPageList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TafwPreviewPageList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.