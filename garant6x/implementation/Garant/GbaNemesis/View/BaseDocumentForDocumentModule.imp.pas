{$IfNDef BaseDocumentForDocumentModule_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseDocumentForDocumentModule.imp.pas"
// �����: 27.01.2009 17:04
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 ������ � ���������� � ������� ����������::Document::View::BaseDocument::BaseDocumentForDocumentModule
//
// ����� ��� ������ � ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaseDocumentForDocumentModule_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BaseDocument_Parent_ = _BaseDocumentForDocumentModule_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 _BaseDocumentForDocumentModule_ = {abstract form} class(_BaseDocument_)
  {* ����� ��� ������ � ���������� }
 end;//_BaseDocumentForDocumentModule_
{$Else}

 _BaseDocument_Parent_ = _BaseDocumentForDocumentModule_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 _BaseDocumentForDocumentModule_ = _BaseDocument_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaseDocumentForDocumentModule_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}


{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaseDocumentForDocumentModule_imp}
