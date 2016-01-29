unit ChatTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Chat"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/ChatTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 ���������� ��������::Chat::Chat::ChatTypes
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
  BaseTypesUnit,
  SecurityUnit
  ;

type
 TnsContactType = (
  {* ��� ���������� �������� }
   ctActive // ���������
 , ctInactive // ���������
 );//TnsContactType

 TContactListFilterTypes = (
  {* ��� ������� ������ ��������� }
   clftNone // ��� ��������
 , clftActive // ������ ������������
 );//TContactListFilterTypes

 TbsUserID = BaseTypesUnit.TUid;
  {* ID ������������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

end.