unit dsDocumentListCRToPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Document"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Document/dsDocumentListCRToPart.pas"
// �����: 26.11.2008 19:25
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ���������� ������ � ���������� � ����������� ������� ���������::F1 Document Processing::Document::Document::TdsDocumentListCRToPart
//
// ��� � ���������
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
  dsDocumentListCR
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsDocumentListCRToPart = {vac} class(TdsDocumentListCR)
  {* ��� � ��������� }
 protected
 // overridden protected methods
   function ToPart: Boolean; override;
 end;//TdsDocumentListCRToPart
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsDocumentListCRToPart

function TdsDocumentListCRToPart.ToPart: Boolean;
//#UC START# *492D797E007F_492D78650003_var*
//#UC END# *492D797E007F_492D78650003_var*
begin
//#UC START# *492D797E007F_492D78650003_impl*
 Result := true;
//#UC END# *492D797E007F_492D78650003_impl*
end;//TdsDocumentListCRToPart.ToPart

{$IfEnd} //not Admin AND not Monitorings

end.