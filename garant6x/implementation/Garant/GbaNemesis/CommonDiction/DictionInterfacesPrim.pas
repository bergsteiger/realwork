unit DictionInterfacesPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "CommonDiction"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/DictionInterfacesPrim.pas"
// �����: 29.09.2009 20:41
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::CommonDiction::DictionInterfacesPrim
//
// ������� ���������� ��� ������ � �������� �������
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
  DocumentAndListInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

end.