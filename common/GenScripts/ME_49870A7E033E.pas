{$IfNDef BaseDocument_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas"
// ���������: "VCMForm"

{$Define BaseDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _BaseDocument_ = {abstract} class(_BaseDocument_Parent_)
  {* ����������� ������������� �������� ��������� }
  protected
   sdsBaseDocument: IsdsBaseDocument;
    {* ������� ��������� ������ � ���������� }
 end;//_BaseDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_BaseDocument_ = _BaseDocument_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaseDocument_imp}

{$IfNDef BaseDocument_imp_impl}

{$Define BaseDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf BaseDocument_imp_impl}

{$EndIf BaseDocument_imp}

