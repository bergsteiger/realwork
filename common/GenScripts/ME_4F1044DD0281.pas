{$IfNDef HyperlinkOperations_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkOperations.imp.pas"
// Стереотип: "VCMForm"

{$Define HyperlinkOperations_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _HyperlinkOperations_ = {abstract} class(_HyperlinkOperations_Parent_)
  protected
   procedure OpenHyperLink; virtual;
    {* Открывает текущую ссылку на которой стоит выделение }
   procedure AfterOpenHyperlinkInNewTab; virtual;
   function IsHyperlinkOfType(aLinkType: Integer): Boolean;
   function IsHyperlinkOfKind(aLinkKind: TevLinkViewKind): Boolean;
  public
   procedure Delete; override;
   procedure Open; override;
   procedure OpenNewWindow; override;
   procedure NextHyperLink; override;
   procedure PrevHyperLink; override;
   procedure OpenInNewTab; override;
   procedure OpenScriptHyperLink; override;
   procedure NavigateInternetHyperlink; override;
    {* Перейти по гиперссылке }
 end;//_HyperlinkOperations_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_HyperlinkOperations_ = _HyperlinkOperations_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else HyperlinkOperations_imp}

{$IfNDef HyperlinkOperations_imp_impl}

{$Define HyperlinkOperations_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _HyperlinkOperations_.OpenHyperLink;
 {* Открывает текущую ссылку на которой стоит выделение }
//#UC START# *502D447F03D5_4F1044DD0281_var*
var
 l_HyperLink: IevHyperLink;
//#UC END# *502D447F03D5_4F1044DD0281_var*
begin
//#UC START# *502D447F03D5_4F1044DD0281_impl*
 if Supports(Text.Selection, IevHyperlink, l_HyperLink) then
  nsProcessHyperLink(l_HyperLink, False, Self, Aggregate, _Instance_R_(Self).Document);
//#UC END# *502D447F03D5_4F1044DD0281_impl*
end;//_HyperlinkOperations_.OpenHyperLink

procedure _HyperlinkOperations_.AfterOpenHyperlinkInNewTab;
//#UC START# *544E049F00F7_4F1044DD0281_var*
//#UC END# *544E049F00F7_4F1044DD0281_var*
begin
//#UC START# *544E049F00F7_4F1044DD0281_impl*
 
//#UC END# *544E049F00F7_4F1044DD0281_impl*
end;//_HyperlinkOperations_.AfterOpenHyperlinkInNewTab

function _HyperlinkOperations_.IsHyperlinkOfType(aLinkType: Integer): Boolean;
//#UC START# *5460AA9C02B3_4F1044DD0281_var*
var
 l_Hyperlink: IevHyperlink;
//#UC END# *5460AA9C02B3_4F1044DD0281_var*
begin
//#UC START# *5460AA9C02B3_4F1044DD0281_impl*
 if Supports(Text.Selection, IevHyperlink, l_HyperLink) AND
    l_HyperLink.Exists then
  Result := (l_HyperLink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID = aLinkType)
 else
  Result := False;
//#UC END# *5460AA9C02B3_4F1044DD0281_impl*
end;//_HyperlinkOperations_.IsHyperlinkOfType

function _HyperlinkOperations_.IsHyperlinkOfKind(aLinkKind: TevLinkViewKind): Boolean;
//#UC START# *5514FDE2017B_4F1044DD0281_var*
var
 l_HyperLink: IevHyperLink;
//#UC END# *5514FDE2017B_4F1044DD0281_var*
begin
//#UC START# *5514FDE2017B_4F1044DD0281_impl*
 if Supports(Text.Selection, IevHyperlink, l_HyperLink) AND
    l_HyperLink.Exists then
  Result := (l_HyperLink.Kind = aLinkKind)
 else
  Result := False;
//#UC END# *5514FDE2017B_4F1044DD0281_impl*
end;//_HyperlinkOperations_.IsHyperlinkOfKind

procedure _HyperlinkOperations_.Delete;
//#UC START# *4C3C758C0183_4F1044DD0281_var*
//#UC END# *4C3C758C0183_4F1044DD0281_var*
begin
//#UC START# *4C3C758C0183_4F1044DD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C758C0183_4F1044DD0281_impl*
end;//_HyperlinkOperations_.Delete

procedure _HyperlinkOperations_.Open;
//#UC START# *4C7F8B870162_4F1044DD0281_var*
//#UC END# *4C7F8B870162_4F1044DD0281_var*
begin
//#UC START# *4C7F8B870162_4F1044DD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F8B870162_4F1044DD0281_impl*
end;//_HyperlinkOperations_.Open

procedure _HyperlinkOperations_.OpenNewWindow;
//#UC START# *4C7F8BBB01B2_4F1044DD0281_var*
//#UC END# *4C7F8BBB01B2_4F1044DD0281_var*
begin
//#UC START# *4C7F8BBB01B2_4F1044DD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F8BBB01B2_4F1044DD0281_impl*
end;//_HyperlinkOperations_.OpenNewWindow

procedure _HyperlinkOperations_.NextHyperLink;
//#UC START# *4C7F8BD80114_4F1044DD0281_var*
//#UC END# *4C7F8BD80114_4F1044DD0281_var*
begin
//#UC START# *4C7F8BD80114_4F1044DD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F8BD80114_4F1044DD0281_impl*
end;//_HyperlinkOperations_.NextHyperLink

procedure _HyperlinkOperations_.PrevHyperLink;
//#UC START# *4C7F8BEA01B2_4F1044DD0281_var*
//#UC END# *4C7F8BEA01B2_4F1044DD0281_var*
begin
//#UC START# *4C7F8BEA01B2_4F1044DD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F8BEA01B2_4F1044DD0281_impl*
end;//_HyperlinkOperations_.PrevHyperLink

procedure _HyperlinkOperations_.OpenInNewTab;
//#UC START# *53DF186601F1_4F1044DD0281_var*
//#UC END# *53DF186601F1_4F1044DD0281_var*
begin
//#UC START# *53DF186601F1_4F1044DD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *53DF186601F1_4F1044DD0281_impl*
end;//_HyperlinkOperations_.OpenInNewTab

procedure _HyperlinkOperations_.OpenScriptHyperLink;
//#UC START# *53F5887E03A1_4F1044DD0281_var*
//#UC END# *53F5887E03A1_4F1044DD0281_var*
begin
//#UC START# *53F5887E03A1_4F1044DD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *53F5887E03A1_4F1044DD0281_impl*
end;//_HyperlinkOperations_.OpenScriptHyperLink

procedure _HyperlinkOperations_.NavigateInternetHyperlink;
 {* Перейти по гиперссылке }
//#UC START# *5460A4DD0349_4F1044DD0281_var*
//#UC END# *5460A4DD0349_4F1044DD0281_var*
begin
//#UC START# *5460A4DD0349_4F1044DD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *5460A4DD0349_4F1044DD0281_impl*
end;//_HyperlinkOperations_.NavigateInternetHyperlink
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf HyperlinkOperations_imp_impl}

{$EndIf HyperlinkOperations_imp}

