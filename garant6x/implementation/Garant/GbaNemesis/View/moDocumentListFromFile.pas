unit moDocumentListFromFile;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moDocumentListFromFile.pas"
// �����: 12.04.2011 16:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 ������������ ��������::DocumentListFromFile::DocumentListFromFile
//
// ������ ���������� �� �����
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
  PrimDocumentListFromFile_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_DocumentListFromFile = {final formspack} class(TPrimDocumentListFromFileModule)
 {* ������ ���������� �� ����� }
end;//Tmo_DocumentListFromFile
{$IfEnd} //not Admin AND not Monitorings

implementation

end.