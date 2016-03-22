{$IfNDef CommonForTextAndFlashAndMedicFirmList_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CommonForTextAndFlashAndMedicFirmList.imp.pas"
// ���������: "VCMForm"
// ������� ������: "CommonForTextAndFlashAndMedicFirmList" MUID: (4986EB4D0179)
// ��� ����: "_CommonForTextAndFlashAndMedicFirmList_"

{$Define CommonForTextAndFlashAndMedicFirmList_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _CommonForTextAndFlashAndMedicFirmList_ = {abstract} class(_CommonForTextAndFlashAndMedicFirmList_Parent_)
  {* ����� �������� ��� ������, ����-���� � ������� ������� }
  protected
   sdsBaseDocumentWithAttributes: IsdsBaseDocumentWithAttributes;
  protected
   procedure OpenAttributesOpTest(const aParams: IvcmTestParamsPrim);
    {* �������� ���������� � ���������. ������������ }
   procedure OpenAttributesOpExecute;
    {* �������� ���������� � ���������. ���������� }
   function OpenAttributesOpCanBeClosed: Boolean;
    {* ����������� �������� ������� ���������� � ��������� }
 end;//_CommonForTextAndFlashAndMedicFirmList_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_CommonForTextAndFlashAndMedicFirmList_ = _CommonForTextAndFlashAndMedicFirmList_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else CommonForTextAndFlashAndMedicFirmList_imp}

{$IfNDef CommonForTextAndFlashAndMedicFirmList_imp_impl}

{$Define CommonForTextAndFlashAndMedicFirmList_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpTest(const aParams: IvcmTestParamsPrim);
 {* �������� ���������� � ���������. ������������ }
//#UC START# *4986F55B0274_4986EB4D0179_var*
//#UC END# *4986F55B0274_4986EB4D0179_var*
begin
//#UC START# *4986F55B0274_4986EB4D0179_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (sdsBaseDocumentWithAttributes <> nil) and
                                   sdsBaseDocumentWithAttributes.HasAttributes;
//#UC END# *4986F55B0274_4986EB4D0179_impl*
end;//_CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpTest

procedure _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpExecute;
 {* �������� ���������� � ���������. ���������� }
//#UC START# *4986F8870069_4986EB4D0179_var*
//#UC END# *4986F8870069_4986EB4D0179_var*
begin
//#UC START# *4986F8870069_4986EB4D0179_impl*
 if (sdsBaseDocumentWithAttributes <> nil) then
  sdsBaseDocumentWithAttributes.OpenAttributes;
//#UC END# *4986F8870069_4986EB4D0179_impl*
end;//_CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpExecute

function _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpCanBeClosed: Boolean;
 {* ����������� �������� ������� ���������� � ��������� }
//#UC START# *4986FA1D003E_4986EB4D0179_var*
//#UC END# *4986FA1D003E_4986EB4D0179_var*
begin
//#UC START# *4986FA1D003E_4986EB4D0179_impl*
 Result := (sdsBaseDocumentWithAttributes <> nil) and
           sdsBaseDocumentWithAttributes.dsAttributesRef.CanBeClosed;
//#UC END# *4986FA1D003E_4986EB4D0179_impl*
end;//_CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpCanBeClosed
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf CommonForTextAndFlashAndMedicFirmList_imp_impl}

{$EndIf CommonForTextAndFlashAndMedicFirmList_imp}

