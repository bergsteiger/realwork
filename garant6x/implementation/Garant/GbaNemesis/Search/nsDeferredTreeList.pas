unit nsDeferredTreeList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Search"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsDeferredTreeList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::List::TnsDeferredTreeList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  FoldersDomainInterfaces
  {$IfEnd} //not Admin AND not Monitorings
  ,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _ItemType_ = InsDeferredTree;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsDeferredTreeList = class(_l3InterfaceRefList_)
 end;//TnsDeferredTreeList
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

type _Instance_R_ = TnsDeferredTreeList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}


{$IfEnd} //not Admin
end.