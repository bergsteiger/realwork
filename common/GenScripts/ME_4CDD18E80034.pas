{$IfNDef HyperlinkToDocumentProducer_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\HyperlinkToDocumentProducer.imp.pas"
// Стереотип: "VCMForm"

{$Define HyperlinkToDocumentProducer_imp}

 _HyperlinkToDocumentProducer_ = {abstract} class(_HyperlinkToDocumentProducer_Parent_)
  {* Изготовитель ссылок на документы }
  protected
   function pm_GetHyperlinkDocID: Integer; virtual; abstract;
   function pm_GetHyperlinkDocumentName: Il3CString; virtual; abstract;
   function pm_GetHyperlinkSubID: Integer; virtual;
   function NeedMakeHyperlinkToDocument: Boolean; virtual;
  public
   procedure MakeHyperlinkToDocument; override;
    {* Создать ссылку на документ }
   procedure MakeHyperlinkToDocument; override;
    {* Создать ссылку на документ }
   procedure MakeHyperlinkToDocument; override;
    {* Создать ссылку на документ }
  protected
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

{$IfNDef HyperlinkToDocumentProducer_imp_impl}

{$Define HyperlinkToDocumentProducer_imp_impl}

function _HyperlinkToDocumentProducer_.pm_GetHyperlinkSubID: Integer;
//#UC START# *4CE41B300315_4CDD18E80034get_var*
//#UC END# *4CE41B300315_4CDD18E80034get_var*
begin
//#UC START# *4CE41B300315_4CDD18E80034get_impl*
 Result := 0;
//#UC END# *4CE41B300315_4CDD18E80034get_impl*
end;//_HyperlinkToDocumentProducer_.pm_GetHyperlinkSubID

function _HyperlinkToDocumentProducer_.NeedMakeHyperlinkToDocument: Boolean;
//#UC START# *53EB17EF0306_4CDD18E80034_var*
//#UC END# *53EB17EF0306_4CDD18E80034_var*
begin
//#UC START# *53EB17EF0306_4CDD18E80034_impl*
 Result := True;
//#UC END# *53EB17EF0306_4CDD18E80034_impl*
end;//_HyperlinkToDocumentProducer_.NeedMakeHyperlinkToDocument

procedure _HyperlinkToDocumentProducer_.MakeHyperlinkToDocument;
 {* Создать ссылку на документ }
//#UC START# *4CDD18A20143_4CDD18E80034_var*
//#UC END# *4CDD18A20143_4CDD18E80034_var*
begin
//#UC START# *4CDD18A20143_4CDD18E80034_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDD18A20143_4CDD18E80034_impl*
end;//_HyperlinkToDocumentProducer_.MakeHyperlinkToDocument

procedure _HyperlinkToDocumentProducer_.MakeHyperlinkToDocument;
 {* Создать ссылку на документ }
//#UC START# *4CDD5C3901E0_4CDD18E80034_var*
//#UC END# *4CDD5C3901E0_4CDD18E80034_var*
begin
//#UC START# *4CDD5C3901E0_4CDD18E80034_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDD5C3901E0_4CDD18E80034_impl*
end;//_HyperlinkToDocumentProducer_.MakeHyperlinkToDocument

procedure _HyperlinkToDocumentProducer_.MakeHyperlinkToDocument;
 {* Создать ссылку на документ }
//#UC START# *4CDE7C2C0258_4CDD18E80034_var*
//#UC END# *4CDE7C2C0258_4CDD18E80034_var*
begin
//#UC START# *4CDE7C2C0258_4CDD18E80034_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDE7C2C0258_4CDD18E80034_impl*
end;//_HyperlinkToDocumentProducer_.MakeHyperlinkToDocument

{$EndIf HyperlinkToDocumentProducer_imp_impl}

{$EndIf HyperlinkToDocumentProducer_imp}

