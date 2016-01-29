{$IfNDef HyperlinkToDocumentProducer_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "LinksToGarant"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/LinksToGarant/HyperlinkToDocumentProducer.imp.pas"
// Начат: 12.11.2010 13:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Aspects::Hypertext::LinksToGarant::Forms::HyperlinkToDocumentProducer
//
// Изготовитель ссылок на документы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define HyperlinkToDocumentProducer_imp}
 _HyperlinkToDocumentProducer_ = {abstract form} class(_HyperlinkToDocumentProducer_Parent_)
  {* Изготовитель ссылок на документы }
 protected
  procedure InitEntities; override;
 protected
 // property methods
   function pm_GetHyperlinkDocID: Integer; virtual; abstract;
   function pm_GetHyperlinkDocumentName: Il3CString; virtual; abstract;
   function pm_GetHyperlinkSubID: Integer; virtual;
 protected
 // realized methods
   procedure File_MakeHyperlinkToDocument_Test(const aParams: IvcmTestParamsPrim);
     {* Создать ссылку на документ }
   procedure File_MakeHyperlinkToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Создать ссылку на документ }
   procedure Text_MakeHyperlinkToDocument_Test(const aParams: IvcmTestParamsPrim);
     {* Создать ссылку на документ }
   procedure Text_MakeHyperlinkToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Создать ссылку на документ }
   procedure Document_MakeHyperlinkToDocument_Test(const aParams: IvcmTestParamsPrim);
     {* Создать ссылку на документ }
   procedure Document_MakeHyperlinkToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Создать ссылку на документ }
 protected
 // protected methods
   function NeedMakeHyperlinkToDocument: Boolean; virtual;
 protected
 // protected properties
   property HyperlinkDocID: Integer
     read pm_GetHyperlinkDocID;
     {* Идентификато документа на который надо ставить ссылку }
   property HyperlinkDocumentName: Il3CString
     read pm_GetHyperlinkDocumentName;
     {* Имя документа на который надо ставить ссылку }
   property HyperlinkSubID: Integer
     read pm_GetHyperlinkSubID;
 end;//_HyperlinkToDocumentProducer_

{$Else HyperlinkToDocumentProducer_imp}

// start class _HyperlinkToDocumentProducer_

function _HyperlinkToDocumentProducer_.NeedMakeHyperlinkToDocument: Boolean;
//#UC START# *53EB17EF0306_4CDD18E80034_var*
//#UC END# *53EB17EF0306_4CDD18E80034_var*
begin
//#UC START# *53EB17EF0306_4CDD18E80034_impl*
 Result := True;
//#UC END# *53EB17EF0306_4CDD18E80034_impl*
end;//_HyperlinkToDocumentProducer_.NeedMakeHyperlinkToDocument

function _HyperlinkToDocumentProducer_.pm_GetHyperlinkSubID: Integer;
//#UC START# *4CE41B300315_4CDD18E80034get_var*
//#UC END# *4CE41B300315_4CDD18E80034get_var*
begin
//#UC START# *4CE41B300315_4CDD18E80034get_impl*
 Result := 0;
//#UC END# *4CE41B300315_4CDD18E80034get_impl*
end;//_HyperlinkToDocumentProducer_.pm_GetHyperlinkSubID

procedure _HyperlinkToDocumentProducer_.File_MakeHyperlinkToDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4CDD18A20143_4CDD18E80034test_var*
//#UC END# *4CDD18A20143_4CDD18E80034test_var*
begin
//#UC START# *4CDD18A20143_4CDD18E80034test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (HyperlinkDocID > 0) AND
  (not l3IsNil(HyperlinkDocumentName)) AND
  NeedMakeHyperlinkToDocument;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=561019302
//#UC END# *4CDD18A20143_4CDD18E80034test_impl*
end;//_HyperlinkToDocumentProducer_.File_MakeHyperlinkToDocument_Test

procedure _HyperlinkToDocumentProducer_.File_MakeHyperlinkToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4CDD18A20143_4CDD18E80034exec_var*
//#UC END# *4CDD18A20143_4CDD18E80034exec_var*
begin
//#UC START# *4CDD18A20143_4CDD18E80034exec_impl*
 l3System.SetClipboardData(
  TevConstStringData.Make(
   TevdHyperlinkInfo.Make(HyperlinkDocumentName,
                          TevAddress_C(HyperlinkDocID, HyperlinkSubID){$IfDef XE4}.rTafwAddress{$EndIf},
                          str_HyperlinkToDocumentProducerAppInfo.AsCStr),
                          nil));
 Say(inf_HyperlinkToDocumentProducerLinkMade);                         
//#UC END# *4CDD18A20143_4CDD18E80034exec_impl*
end;//_HyperlinkToDocumentProducer_.File_MakeHyperlinkToDocument_Execute

procedure _HyperlinkToDocumentProducer_.Text_MakeHyperlinkToDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4CDD5C3901E0_4CDD18E80034test_var*
//#UC END# *4CDD5C3901E0_4CDD18E80034test_var*
begin
//#UC START# *4CDD5C3901E0_4CDD18E80034test_impl*
 File_MakeHyperlinkToDocument_Test(aParams);
//#UC END# *4CDD5C3901E0_4CDD18E80034test_impl*
end;//_HyperlinkToDocumentProducer_.Text_MakeHyperlinkToDocument_Test

procedure _HyperlinkToDocumentProducer_.Text_MakeHyperlinkToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4CDD5C3901E0_4CDD18E80034exec_var*
//#UC END# *4CDD5C3901E0_4CDD18E80034exec_var*
begin
//#UC START# *4CDD5C3901E0_4CDD18E80034exec_impl*
 File_MakeHyperlinkToDocument_Execute(aParams);
//#UC END# *4CDD5C3901E0_4CDD18E80034exec_impl*
end;//_HyperlinkToDocumentProducer_.Text_MakeHyperlinkToDocument_Execute

procedure _HyperlinkToDocumentProducer_.Document_MakeHyperlinkToDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4CDE7C2C0258_4CDD18E80034test_var*
//#UC END# *4CDE7C2C0258_4CDD18E80034test_var*
begin
//#UC START# *4CDE7C2C0258_4CDD18E80034test_impl*
 File_MakeHyperlinkToDocument_Test(aParams);
//#UC END# *4CDE7C2C0258_4CDD18E80034test_impl*
end;//_HyperlinkToDocumentProducer_.Document_MakeHyperlinkToDocument_Test

procedure _HyperlinkToDocumentProducer_.Document_MakeHyperlinkToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4CDE7C2C0258_4CDD18E80034exec_var*
//#UC END# *4CDE7C2C0258_4CDD18E80034exec_var*
begin
//#UC START# *4CDE7C2C0258_4CDD18E80034exec_impl*
 File_MakeHyperlinkToDocument_Execute(aParams);
//#UC END# *4CDE7C2C0258_4CDD18E80034exec_impl*
end;//_HyperlinkToDocumentProducer_.Document_MakeHyperlinkToDocument_Execute

procedure _HyperlinkToDocumentProducer_.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Text, nil);
  PublishFormEntity(en_Document, nil);
  PublishOp(en_File, op_MakeHyperlinkToDocument, File_MakeHyperlinkToDocument_Execute, File_MakeHyperlinkToDocument_Test, nil);
  ShowInContextMenu(en_File, op_MakeHyperlinkToDocument, false);
  ShowInToolbar(en_File, op_MakeHyperlinkToDocument, false);
  PublishOp(en_Text, op_MakeHyperlinkToDocument, Text_MakeHyperlinkToDocument_Execute, Text_MakeHyperlinkToDocument_Test, nil);
  ShowInContextMenu(en_Text, op_MakeHyperlinkToDocument, true);
  ShowInToolbar(en_Text, op_MakeHyperlinkToDocument, false);
  PublishOp(en_Document, op_MakeHyperlinkToDocument, Document_MakeHyperlinkToDocument_Execute, Document_MakeHyperlinkToDocument_Test, nil);
  ShowInContextMenu(en_Document, op_MakeHyperlinkToDocument, true);
  ShowInToolbar(en_Document, op_MakeHyperlinkToDocument, false);
 end;//with Entities.Entities
end;

{$EndIf HyperlinkToDocumentProducer_imp}
