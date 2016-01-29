unit segHyperLinkList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/segHyperLinkList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::NSRCReaderCore::TsegHyperLinkList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3ProtoDataContainer,
  ddNSRCSegments,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TsegHyperLink;
 _l3NotSortedObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas}
 TsegHyperLinkList = class(_l3NotSortedObjectRefList_)
 end;//TsegHyperLinkList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TsegHyperLinkList;

{$Include w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas}

end.