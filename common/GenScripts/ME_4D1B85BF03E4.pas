unit BaseDocumentWithAttributesInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\BaseDocumentWithAttributesInterfaces.pas"
// ���������: "ControllerInterfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , DocumentUnit
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Types
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IsdsBaseDocumentWithAttributes = interface(IsdsBaseDocument)
  {* �������� � ���������� }
  ['{22FB504D-14F4-47E7-9954-AAE03A834F76}']
  function pm_GetdsAttributes: IdsAttributes;
  function pm_GetHasAttributes: Boolean;
  procedure OpenAttributes;
   {* �������� }
  property dsAttributes: IdsAttributes
   read pm_GetdsAttributes;
   {* �������� ��������� }
  property HasAttributes: Boolean
   read pm_GetHasAttributes;
   {* ���������� ��� ���� ������ ��� "�������� ���������" }
 end;//IsdsBaseDocumentWithAttributes

 IdBaseDocumentWithAttributes = interface(IdBaseDocument)
  {* ������ ��������� � ����������. }
  ['{86850BCB-4E5D-4473-B0C0-CD5481B863E4}']
  function pm_GetdsAttributesRef: IvcmFormDataSourceRef;
  function pm_GetHasAttributes: Tl3Bool;
  procedure pm_SetHasAttributes(aValue: Tl3Bool);
  procedure ResetBooleans;
   {* �������� ���������� ���� }
  property dsAttributesRef: IvcmFormDataSourceRef
   read pm_GetdsAttributesRef;
   {* ������ �� "�������� ���������" }
  property HasAttributes: Tl3Bool
   read pm_GetHasAttributes
   write pm_SetHasAttributes;
   {* ���� �� "�������� ���������" }
 end;//IdBaseDocumentWithAttributes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
