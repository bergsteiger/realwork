unit dsRelatedDoc;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsRelatedDoc.pas"
// �����: 08.12.2008 19:08
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::DocumentAndList::TdsRelatedDoc
//
// �������
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
 TdsRelatedDoc = {vac} class(TdsChildDocument)
  {* ������� }
 protected
 // overridden protected methods
   function DoGetPreviewCaleeArea: TafwPreviewCaleeArea; override;
 end;//TdsRelatedDoc
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsRelatedDoc

function TdsRelatedDoc.DoGetPreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_495898900070_var*
//#UC END# *49589999029F_495898900070_var*
begin
//#UC START# *49589999029F_495898900070_impl*
 Result := afw_pcaReference;
//#UC END# *49589999029F_495898900070_impl*
end;//TdsRelatedDoc.DoGetPreviewCaleeArea

{$IfEnd} //not Admin AND not Monitorings

end.