{$IfNDef CommonForTextAndFlashAndMedicFirmList_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CommonForTextAndFlashAndMedicFirmList.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "CommonForTextAndFlashAndMedicFirmList" MUID: (4986EB4D0179)
// Имя типа: "_CommonForTextAndFlashAndMedicFirmList_"

{$Define CommonForTextAndFlashAndMedicFirmList_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _CommonForTextAndFlashAndMedicFirmList_ = {abstract} class(_CommonForTextAndFlashAndMedicFirmList_Parent_)
  {* Общие операции для текста, флеш-схем и списков медфирм }
  protected
   sdsBaseDocumentWithAttributes: IsdsBaseDocumentWithAttributes;
  protected
   procedure OpenAttributesOpTest(const aParams: IvcmTestParamsPrim);
    {* Операция информация о документе. Тестирование }
   procedure OpenAttributesOpExecute;
    {* Операция информация о документе. Выполнение }
   function OpenAttributesOpCanBeClosed: Boolean;
    {* возможность закрытия вкладки информация о документе }
 end;//_CommonForTextAndFlashAndMedicFirmList_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_CommonForTextAndFlashAndMedicFirmList_ = _CommonForTextAndFlashAndMedicFirmList_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else CommonForTextAndFlashAndMedicFirmList_imp}

{$IfNDef CommonForTextAndFlashAndMedicFirmList_imp_impl}

{$Define CommonForTextAndFlashAndMedicFirmList_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpTest(const aParams: IvcmTestParamsPrim);
 {* Операция информация о документе. Тестирование }
//#UC START# *4986F55B0274_4986EB4D0179_var*
//#UC END# *4986F55B0274_4986EB4D0179_var*
begin
//#UC START# *4986F55B0274_4986EB4D0179_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (sdsBaseDocumentWithAttributes <> nil) and
                                   sdsBaseDocumentWithAttributes.HasAttributes;
//#UC END# *4986F55B0274_4986EB4D0179_impl*
end;//_CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpTest

procedure _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpExecute;
 {* Операция информация о документе. Выполнение }
//#UC START# *4986F8870069_4986EB4D0179_var*
//#UC END# *4986F8870069_4986EB4D0179_var*
begin
//#UC START# *4986F8870069_4986EB4D0179_impl*
 if (sdsBaseDocumentWithAttributes <> nil) then
  sdsBaseDocumentWithAttributes.OpenAttributes;
//#UC END# *4986F8870069_4986EB4D0179_impl*
end;//_CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpExecute

function _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpCanBeClosed: Boolean;
 {* возможность закрытия вкладки информация о документе }
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

