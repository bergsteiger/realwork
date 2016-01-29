{$IfNDef BaseDocumentForDocumentModule_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseDocumentForDocumentModule.imp.pas"
// Начат: 27.01.2009 17:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::BaseDocument::BaseDocumentForDocumentModule
//
// Форма для работы с документом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaseDocumentForDocumentModule_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BaseDocument_Parent_ = _BaseDocumentForDocumentModule_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 _BaseDocumentForDocumentModule_ = {abstract form} class(_BaseDocument_)
  {* Форма для работы с документом }
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
