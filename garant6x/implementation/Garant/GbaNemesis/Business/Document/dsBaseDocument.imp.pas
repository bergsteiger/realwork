{$IfNDef dsBaseDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsBaseDocument.imp.pas"
// �����: 21.11.2008 17:53
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::BaseDocument::dsBaseDocument
//
// ���, ������� ��� ����������� � ����������. ���������� �������� ��������� ������-�������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsBaseDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _FormDataSourceType_ = IdsBaseDocument;
 {$Include ..\Document\dsBaseDocumentPrim.imp.pas}
 _dsBaseDocument_ = {abstract vac} class(_dsBaseDocumentPrim_)
  {* ���, ������� ��� ����������� � ����������. ���������� �������� ��������� ������-������� }
 end;//_dsBaseDocument_
{$Else}

 {$Include ..\Document\dsBaseDocumentPrim.imp.pas}
 _dsBaseDocument_ = _dsBaseDocumentPrim_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dsBaseDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\Document\dsBaseDocumentPrim.imp.pas}


{$IfEnd} //not Admin AND not Monitorings

{$EndIf dsBaseDocument_imp}
