{$IfNDef HyperlinkProcessorWithOwnLocalLink_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/HyperlinkProcessorWithOwnLocalLink.imp.pas"
// Начат: 18.08.2009 19:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Navigation::HyperlinkProcessorWithOwnLocalLink
//
// Обработчик ссылок с собственной обработкой локальных ссылок (сейчас пустой)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define HyperlinkProcessorWithOwnLocalLink_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _HyperlinkProcessor_Parent_ = _HyperlinkProcessorWithOwnLocalLink_Parent_;
 {$Include ..\View\HyperlinkProcessor.imp.pas}
 _HyperlinkProcessorWithOwnLocalLink_ = {abstract form} class(_HyperlinkProcessor_)
  {* Обработчик ссылок с собственной обработкой локальных ссылок (сейчас пустой) }
 protected
 // realized methods
   function DoProcessExternalOperation(const anOperation: IExternalOperation): Boolean; override;
     {* Обработчик внешней операции }
   procedure OpenRedactionLocalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
     {* Открывает локальную ссылку на другую редакцию }
 end;//_HyperlinkProcessorWithOwnLocalLink_
{$Else}

 _HyperlinkProcessor_Parent_ = _HyperlinkProcessorWithOwnLocalLink_Parent_;
 {$Include ..\View\HyperlinkProcessor.imp.pas}
 _HyperlinkProcessorWithOwnLocalLink_ = _HyperlinkProcessor_;

{$IfEnd} //not Admin AND not Monitorings

{$Else HyperlinkProcessorWithOwnLocalLink_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\View\HyperlinkProcessor.imp.pas}

// start class _HyperlinkProcessorWithOwnLocalLink_

function _HyperlinkProcessorWithOwnLocalLink_.DoProcessExternalOperation(const anOperation: IExternalOperation): Boolean;
//#UC START# *4A815E860391_4A8AC2DB0210_var*
//#UC END# *4A815E860391_4A8AC2DB0210_var*
begin
//#UC START# *4A815E860391_4A8AC2DB0210_impl*
 Result := false;
//#UC END# *4A815E860391_4A8AC2DB0210_impl*
end;//_HyperlinkProcessorWithOwnLocalLink_.DoProcessExternalOperation

procedure _HyperlinkProcessorWithOwnLocalLink_.OpenRedactionLocalLink(const aDocument: IDocument;
  aSub: Cardinal;
  aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *4A81650B014A_4A8AC2DB0210_var*
var
 l_Container: IvcmContainer;
//#UC END# *4A81650B014A_4A8AC2DB0210_var*
begin
//#UC START# *4A81650B014A_4A8AC2DB0210_impl*
 l_Container := MakeContainerForBehaviour(aBehaviour);
 TdmStdRes.OpenDocument(MakeLinkDocInfo(aDocument, dptSub, aSub), l_Container);
//#UC END# *4A81650B014A_4A8AC2DB0210_impl*
end;//_HyperlinkProcessorWithOwnLocalLink_.OpenRedactionLocalLink

{$IfEnd} //not Admin AND not Monitorings

{$EndIf HyperlinkProcessorWithOwnLocalLink_imp}
