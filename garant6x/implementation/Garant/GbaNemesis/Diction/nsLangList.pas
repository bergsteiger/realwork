unit nsLangList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Diction"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/nsLangList.pas"
// �����: 07.11.2008 15:16
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Diction::Diction::Diction$Unit::TnsLangList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3SimpleDataContainer,
  bsTypes,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _ItemType_ = TbsLanguage;
 _l3EnumList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}
 TnsLangList = class(_l3EnumList_)
 end;//TnsLangList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TnsLangList;

{$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.