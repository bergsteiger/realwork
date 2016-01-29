unit dsAnnotation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsAnnotation.pas"
// �����: 2005/11/25 09:45:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::DocumentAndList::TdsAnnotation
//
// ��������� � ���������
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
  dsChildDocument,
  afwInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsAnnotation = {vac} class(TdsChildDocument)
  {* ��������� � ��������� }
 protected
 // overridden protected methods
   function DoGetPreviewCaleeArea: TafwPreviewCaleeArea; override;
 end;//TdsAnnotation
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsAnnotation

function TdsAnnotation.DoGetPreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_493D4783035C_var*
//#UC END# *49589999029F_493D4783035C_var*
begin
//#UC START# *49589999029F_493D4783035C_impl*
 Result := afw_pcaAnnotation;
//#UC END# *49589999029F_493D4783035C_impl*
end;//TdsAnnotation.DoGetPreviewCaleeArea

{$IfEnd} //not Admin AND not Monitorings

end.