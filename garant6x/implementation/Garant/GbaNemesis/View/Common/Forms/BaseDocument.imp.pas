{$IfNDef BaseDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/BaseDocument.imp.pas"
// �����: 02.02.2009 18:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::BaseDocument
//
// ����������� ������������� �������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaseDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BaseDocument_ = {abstract form} class(_BaseDocument_Parent_)
  {* ����������� ������������� �������� ��������� }
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
 protected
 // protected fields
   sdsBaseDocument : IsdsBaseDocument;
    {* ������� ��������� ������ � ����������}
 end;//_BaseDocument_
{$Else}

 _BaseDocument_ = _BaseDocument_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaseDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _BaseDocument_

procedure _BaseDocument_.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  sdsBaseDocument := nil;
 end//aDsNew = nil
 else
 begin
  aDsNew.CastUCC(IsdsBaseDocument, sdsBaseDocument);
 end;//aDsNew = nil
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaseDocument_imp}
