unit nsMedicFirmsSubscribersList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Medic"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsMedicFirmsSubscribersList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Inpharm::Medic::Medic$Unit::TnsMedicFirmsSubscribersList
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
  bsInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _ItemType_ = InsMedicFirmsTreeNotifyRecipient;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsMedicFirmsSubscribersList = class(_l3InterfacePtrList_)
 end;//TnsMedicFirmsSubscribersList
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

type _Instance_R_ = TnsMedicFirmsSubscribersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.