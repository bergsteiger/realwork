{$IfNDef HyperlinkProcessorWithOwnLocalLink_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas"
// Стереотип: "VCMForm"

{$Define HyperlinkProcessorWithOwnLocalLink_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _HyperlinkProcessor_Parent_ = _HyperlinkProcessorWithOwnLocalLink_Parent_;
 {$Include HyperlinkProcessor.imp.pas}
 _HyperlinkProcessorWithOwnLocalLink_ = {abstract} class(_HyperlinkProcessor_)
  {* Обработчик ссылок с собственной обработкой локальных ссылок (сейчас пустой) }
  protected
   function DoProcessExternalOperation(const anOperation: IExternalOperation): Boolean; override;
    {* Обработчик внешней операции }
   procedure OpenRedactionLocalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
    {* Открывает локальную ссылку на другую редакцию }
 end;//_HyperlinkProcessorWithOwnLocalLink_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_HyperlinkProcessor_Parent_ = _HyperlinkProcessorWithOwnLocalLink_Parent_;
{$Include HyperlinkProcessor.imp.pas}
_HyperlinkProcessorWithOwnLocalLink_ = _HyperlinkProcessor_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else HyperlinkProcessorWithOwnLocalLink_imp}

{$IfNDef HyperlinkProcessorWithOwnLocalLink_imp_impl}

{$Define HyperlinkProcessorWithOwnLocalLink_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
type _Instance_R_ = _HyperlinkProcessorWithOwnLocalLink_;

{$Include HyperlinkProcessor.imp.pas}

function _HyperlinkProcessorWithOwnLocalLink_.DoProcessExternalOperation(const anOperation: IExternalOperation): Boolean;
 {* Обработчик внешней операции }
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
 {* Открывает локальную ссылку на другую редакцию }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf HyperlinkProcessorWithOwnLocalLink_imp_impl}

{$EndIf HyperlinkProcessorWithOwnLocalLink_imp}

