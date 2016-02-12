{$IfNDef BaseDocumentForDocumentModule_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseDocumentForDocumentModule.imp.pas"
// Стереотип: "VCMForm"

{$Define BaseDocumentForDocumentModule_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _BaseDocument_Parent_ = _BaseDocumentForDocumentModule_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 _BaseDocumentForDocumentModule_ = {abstract} class(_BaseDocument_)
  {* Форма для работы с документом }
 end;//_BaseDocumentForDocumentModule_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_BaseDocument_Parent_ = _BaseDocumentForDocumentModule_Parent_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
_BaseDocumentForDocumentModule_ = _BaseDocument_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaseDocumentForDocumentModule_imp}

{$IfNDef BaseDocumentForDocumentModule_imp_impl}

{$Define BaseDocumentForDocumentModule_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf BaseDocumentForDocumentModule_imp_impl}

{$EndIf BaseDocumentForDocumentModule_imp}

