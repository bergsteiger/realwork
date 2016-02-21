unit DictionInterfacesPrim;
 {* ������� ���������� ��� ������ � �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\DictionInterfacesPrim.pas"
// ���������: "ControllerInterfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
;

type
 IdsDictionDocument = interface(IdsBaseDocument)
  {* �������� ��������� ������� }
  ['{CED6AA8A-309F-467B-9C4C-D6444BBAF67D}']
  function pm_GetIsMainDiction: Boolean;
  procedure OpenLiteratureList;
   {* ������� ������ ���������� ��� ��������� ������� }
  property IsMainDiction: Boolean
   read pm_GetIsMainDiction;
   {* ���������� �������� ��������, ��� ����� �� ��������� }
 end;//IdsDictionDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
