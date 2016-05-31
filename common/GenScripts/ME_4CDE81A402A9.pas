{$IfNDef CommonForTextAndFlashOperations_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlashOperations.imp.pas"
// ���������: "VCMForm"
// ������� ������: "CommonForTextAndFlashOperations" MUID: (4CDE81A402A9)
// ��� ����: "_CommonForTextAndFlashOperations_"

{$Define CommonForTextAndFlashOperations_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _CommonForTextAndFlash_Parent_ = _CommonForTextAndFlashOperations_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlash.imp.pas}
 _CommonForTextAndFlashOperations_ = {abstract} class(_CommonForTextAndFlash_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_CommonForTextAndFlashOperations_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_CommonForTextAndFlash_Parent_ = _CommonForTextAndFlashOperations_Parent_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlash.imp.pas}
_CommonForTextAndFlashOperations_ = _CommonForTextAndFlash_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else CommonForTextAndFlashOperations_imp}

{$IfNDef CommonForTextAndFlashOperations_imp_impl}

{$Define CommonForTextAndFlashOperations_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlash.imp.pas}

{$If NOT Defined(NoVCM)}
procedure _CommonForTextAndFlashOperations_.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_Document, op_MakeHyperlinkToDocument, False);
  ShowInToolbar(en_Document, op_MakeHyperlinkToDocument, False);
 end;//with Entities.Entities
end;//_CommonForTextAndFlashOperations_.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf CommonForTextAndFlashOperations_imp_impl}

{$EndIf CommonForTextAndFlashOperations_imp}

