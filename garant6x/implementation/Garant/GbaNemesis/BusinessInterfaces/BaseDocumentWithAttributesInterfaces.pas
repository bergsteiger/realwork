unit BaseDocumentWithAttributesInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "BusinessInterfaces"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/BusinessInterfaces/BaseDocumentWithAttributesInterfaces.pas"
// �����: 29.12.2010 22:02
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::BusinessInterfaces::BaseDocumentWithAttributesInterfaces
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
  l3Types,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmInterfaces {a}
  ;

type
 IsdsBaseDocumentWithAttributes = interface(IsdsBaseDocument)
  {* �������� � ���������� }
   ['{22FB504D-14F4-47E7-9954-AAE03A834F76}']
   function pm_GetDsAttributes: IdsAttributes;
   function pm_GetdsAttributesRef: IvcmViewAreaControllerRef;
   procedure OpenAttributes;
     {* �������� }
   function pm_GetHasAttributes: Boolean;
   property dsAttributes: IdsAttributes
     read pm_GetDsAttributes;
     {* �������� ��������� }
   property dsAttributesRef: IvcmViewAreaControllerRef
     read pm_GetdsAttributesRef;
     {* ������ �� "�������� ���������" }
   property HasAttributes: Boolean
     read pm_GetHasAttributes;
     {* ���������� ��� ���� ������ ��� "�������� ���������" }
 end;//IsdsBaseDocumentWithAttributes

 IdBaseDocumentWithAttributes = interface(IdBaseDocument)
  {* ������ ��������� � ����������. }
   ['{86850BCB-4E5D-4473-B0C0-CD5481B863E4}']
   procedure ResetBooleans;
     {* �������� ���������� ���� }
   function pm_GetDsAttributesRef: IvcmFormDataSourceRef;
   function pm_GetHasAttributes: Tl3Bool;
   procedure pm_SetHasAttributes(aValue: Tl3Bool);
   property dsAttributesRef: IvcmFormDataSourceRef
     read pm_GetDsAttributesRef;
     {* ������ �� "�������� ���������" }
   property HasAttributes: Tl3Bool
     read pm_GetHasAttributes
     write pm_SetHasAttributes;
     {* ���� �� "�������� ���������" }
 end;//IdBaseDocumentWithAttributes
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

end.