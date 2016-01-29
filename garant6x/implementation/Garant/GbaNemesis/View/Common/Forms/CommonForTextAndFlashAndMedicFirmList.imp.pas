{$IfNDef CommonForTextAndFlashAndMedicFirmList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/CommonForTextAndFlashAndMedicFirmList.imp.pas"
// Начат: 02.02.2009 15:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::CommonForTextAndFlashAndMedicFirmList
//
// Общие операции для текста, флеш-схем и списков медфирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define CommonForTextAndFlashAndMedicFirmList_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _CommonForTextAndFlashAndMedicFirmList_ = {abstract form} class(_CommonForTextAndFlashAndMedicFirmList_Parent_)
  {* Общие операции для текста, флеш-схем и списков медфирм }
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
 protected
 // protected fields
   sdsBaseDocumentWithAttributes : IsdsBaseDocumentWithAttributes;
 protected
 // protected methods
   procedure OpenAttributesOpTest(const aParams: IvcmTestParamsPrim);
     {* Операция информация о документе. Тестирование }
   procedure OpenAttributesOpExecute;
     {* Операция информация о документе. Выполнение }
   function OpenAttributesOpCanBeClosed: Boolean;
     {* возможность закрытия вкладки информация о документе }
 end;//_CommonForTextAndFlashAndMedicFirmList_
{$Else}

 _CommonForTextAndFlashAndMedicFirmList_ = _CommonForTextAndFlashAndMedicFirmList_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else CommonForTextAndFlashAndMedicFirmList_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _CommonForTextAndFlashAndMedicFirmList_

procedure _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4986F55B0274_4986EB4D0179_var*
//#UC END# *4986F55B0274_4986EB4D0179_var*
begin
//#UC START# *4986F55B0274_4986EB4D0179_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (sdsBaseDocumentWithAttributes <> nil) and
                                   sdsBaseDocumentWithAttributes.HasAttributes;
//#UC END# *4986F55B0274_4986EB4D0179_impl*
end;//_CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpTest

procedure _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpExecute;
//#UC START# *4986F8870069_4986EB4D0179_var*
//#UC END# *4986F8870069_4986EB4D0179_var*
begin
//#UC START# *4986F8870069_4986EB4D0179_impl*
 if (sdsBaseDocumentWithAttributes <> nil) then
  sdsBaseDocumentWithAttributes.OpenAttributes;
//#UC END# *4986F8870069_4986EB4D0179_impl*
end;//_CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpExecute

function _CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpCanBeClosed: Boolean;
//#UC START# *4986FA1D003E_4986EB4D0179_var*
//#UC END# *4986FA1D003E_4986EB4D0179_var*
begin
//#UC START# *4986FA1D003E_4986EB4D0179_impl*
 Result := (sdsBaseDocumentWithAttributes <> nil) and
           sdsBaseDocumentWithAttributes.dsAttributesRef.CanBeClosed;
//#UC END# *4986FA1D003E_4986EB4D0179_impl*
end;//_CommonForTextAndFlashAndMedicFirmList_.OpenAttributesOpCanBeClosed

procedure _CommonForTextAndFlashAndMedicFirmList_.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  sdsBaseDocumentWithAttributes := nil;
 end//aDsNew = nil
 else
 begin
  aDsNew.CastUCC(IsdsBaseDocumentWithAttributes, sdsBaseDocumentWithAttributes);
 end;//aDsNew = nil
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf CommonForTextAndFlashAndMedicFirmList_imp}
