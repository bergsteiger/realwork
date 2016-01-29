{$IfNDef CommonForTextAndFlashOperations_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/CommonForTextAndFlashOperations.imp.pas"
// Начат: 13.11.2010 15:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::CommonForDocumentAndFlash::CommonForTextAndFlashOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define CommonForTextAndFlashOperations_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _CommonForTextAndFlash_Parent_ = _CommonForTextAndFlashOperations_Parent_;
 {$Include ..\View\CommonForTextAndFlash.imp.pas}
 _CommonForTextAndFlashOperations_ = {abstract form} class(_CommonForTextAndFlash_)
 protected
  procedure InitEntities; override;
 end;//_CommonForTextAndFlashOperations_
{$Else}

 _CommonForTextAndFlash_Parent_ = _CommonForTextAndFlashOperations_Parent_;
 {$Include ..\View\CommonForTextAndFlash.imp.pas}
 _CommonForTextAndFlashOperations_ = _CommonForTextAndFlash_;

{$IfEnd} //not Admin AND not Monitorings

{$Else CommonForTextAndFlashOperations_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include ..\View\CommonForTextAndFlash.imp.pas}

// start class _CommonForTextAndFlashOperations_

procedure _CommonForTextAndFlashOperations_.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  
  ShowInContextMenu(en_Document, op_MakeHyperlinkToDocument, false);
  ShowInToolbar(en_Document, op_MakeHyperlinkToDocument, false);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf CommonForTextAndFlashOperations_imp}
