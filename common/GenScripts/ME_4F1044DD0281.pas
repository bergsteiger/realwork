{$IfNDef HyperlinkOperations_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkOperations.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "HyperlinkOperations" MUID: (4F1044DD0281)
// Имя типа: "_HyperlinkOperations_"

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
   procedure HyperLink_Delete_Test(const aParams: IvcmTestParamsPrim);
   procedure HyperLink_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure HyperLink_Open_Test(const aParams: IvcmTestParamsPrim);
   procedure HyperLink_Open_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure HyperLink_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure HyperLink_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure HyperLink_NextHyperLink_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure HyperLink_PrevHyperLink_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure HyperLink_OpenInNewTab_Test(const aParams: IvcmTestParamsPrim);
   procedure HyperLink_OpenInNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure HyperLink_OpenScriptHyperLink_Test(const aParams: IvcmTestParamsPrim);
   procedure HyperLink_OpenScriptHyperLink_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure HyperLink_NavigateInternetHyperlink_Test(const aParams: IvcmTestParamsPrim);
    {* Перейти по гиперссылке }
   procedure HyperLink_NavigateInternetHyperlink_Execute(const aParams: IvcmExecuteParamsPrim);
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

procedure _HyperlinkOperations_.HyperLink_Delete_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3C758C0183_4F1044DD0281test_var*
var
 l_Hyperlink : IevHyperlink;
 l_TempPara  : IeePara;
 l_TextPara  : IeeTextPara;
 l_Selection : InevSelection;
//#UC END# *4C3C758C0183_4F1044DD0281test_var*
begin
//#UC START# *4C3C758C0183_4F1044DD0281test_impl*
 if (aParams.Control Is TevCustomEditor) then
 begin
  l_Selection := TevCustomEditor(aParams.Control).Selection;
  if (l_Selection <> nil) then
  begin
   if Supports(l_Selection, IevHyperlink, l_Hyperlink) and l_Hyperlink.Exists then
    try
     l_TempPara := TeePara.Make(l_Hyperlink.Para.AsObject, aParams.Control As IeeDocumentEx);
     try
      if Supports(l_TempPara, IeeTextPara, l_TextPara) then
       try
        if not l_TextPara.IsUserComment then
         aParams.Op.Flag[vcm_ofEnabled] := false;
       finally
        l_TextPara := nil;
       end//try..finally
      else
       aParams.Op.Flag[vcm_ofEnabled] := false;
     finally
      l_TempPara := nil;
     end;
   finally
    l_Hyperlink := nil;
   end//try..finally
   else
    aParams.Op.Flag[vcm_ofEnabled] := false;
  end
  else
   aParams.Op.Flag[vcm_ofEnabled] := false;

  if (aParams.Control is TevEditorWithOperations) and aParams.Op.Flag[vcm_ofEnabled] then
   aParams.Op.Flag[vcm_ofEnabled] :=
    not TevEditorWithOperations(aParams.Control).IsReadOnlyTarget(aParams.Target);
 end//aParams.Control Is TevCustomEditor
 else
  aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *4C3C758C0183_4F1044DD0281test_impl*
end;//_HyperlinkOperations_.HyperLink_Delete_Test

procedure _HyperlinkOperations_.HyperLink_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3C758C0183_4F1044DD0281exec_var*
var
 l_HyperLink: IevHyperLink;
//#UC END# *4C3C758C0183_4F1044DD0281exec_var*
begin
//#UC START# *4C3C758C0183_4F1044DD0281exec_impl*
 if Supports(Text.Selection, IevHyperlink, l_HyperLink) then
  l_HyperLink.Delete;
//#UC END# *4C3C758C0183_4F1044DD0281exec_impl*
end;//_HyperlinkOperations_.HyperLink_Delete_Execute

procedure _HyperlinkOperations_.HyperLink_Open_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F8B870162_4F1044DD0281test_var*
var
 l_HyperLink: IevHyperLink;
//#UC END# *4C7F8B870162_4F1044DD0281test_var*
begin
//#UC START# *4C7F8B870162_4F1044DD0281test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Supports(Text.Selection, IevHyperlink, l_HyperLink)
  and l_HyperLink.Exists;
//#UC END# *4C7F8B870162_4F1044DD0281test_impl*
end;//_HyperlinkOperations_.HyperLink_Open_Test

procedure _HyperlinkOperations_.HyperLink_Open_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F8B870162_4F1044DD0281exec_var*
//#UC END# *4C7F8B870162_4F1044DD0281exec_var*
begin
//#UC START# *4C7F8B870162_4F1044DD0281exec_impl*
 OpenHyperLink;
//#UC END# *4C7F8B870162_4F1044DD0281exec_impl*
end;//_HyperlinkOperations_.HyperLink_Open_Execute

procedure _HyperlinkOperations_.HyperLink_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F8BBB01B2_4F1044DD0281test_var*
var
 l_Hyperlink: IevHyperlink;
 l_LinkType: Integer;
 l_LinkKind: TevLinkViewKind;
//#UC END# *4C7F8BBB01B2_4F1044DD0281test_var*
begin
//#UC START# *4C7F8BBB01B2_4F1044DD0281test_impl*
 if Supports(Text.Selection, IevHyperlink, l_HyperLink) AND
    l_HyperLink.Exists then
 begin
  l_LinkType := l_HyperLink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID;
  l_LinkKind := l_HyperLink.Kind;
  aParams.Op.Flag[vcm_ofEnabled] := (l_LinkType <> CI_ExternalOperation) AND
                                    (l_LinkType <> CI_SCRIPT) AND
                                    (l_LinkType <> CI_BLOB) AND
                                    (l_LinkType <> CI_REF) AND
                                    (l_LinkKind <> ev_lvkExternal);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=562612351,
  //   http://mdp.garant.ru/pages/viewpage.action?pageId=564992086,
  //   http://mdp.garant.ru/pages/viewpage.action?pageId=564993682
 end
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C7F8BBB01B2_4F1044DD0281test_impl*
end;//_HyperlinkOperations_.HyperLink_OpenNewWindow_Test

procedure _HyperlinkOperations_.HyperLink_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F8BBB01B2_4F1044DD0281exec_var*
var
 l_HyperLink: IevHyperLink;
//#UC END# *4C7F8BBB01B2_4F1044DD0281exec_var*
begin
//#UC START# *4C7F8BBB01B2_4F1044DD0281exec_impl*
 if Supports(Text.Selection, IevHyperlink, l_HyperLink) then
  nsProcessHyperLink(l_HyperLink, True, Self, Aggregate, _Instance_R_(Self).Document);
//#UC END# *4C7F8BBB01B2_4F1044DD0281exec_impl*
end;//_HyperlinkOperations_.HyperLink_OpenNewWindow_Execute

procedure _HyperlinkOperations_.HyperLink_NextHyperLink_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F8BD80114_4F1044DD0281exec_var*
//#UC END# *4C7F8BD80114_4F1044DD0281exec_var*
begin
//#UC START# *4C7F8BD80114_4F1044DD0281exec_impl*
 Text.NextHyperlink(False);
//#UC END# *4C7F8BD80114_4F1044DD0281exec_impl*
end;//_HyperlinkOperations_.HyperLink_NextHyperLink_Execute

procedure _HyperlinkOperations_.HyperLink_PrevHyperLink_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F8BEA01B2_4F1044DD0281exec_var*
//#UC END# *4C7F8BEA01B2_4F1044DD0281exec_var*
begin
//#UC START# *4C7F8BEA01B2_4F1044DD0281exec_impl*
 Text.PrevHyperlink(False);
//#UC END# *4C7F8BEA01B2_4F1044DD0281exec_impl*
end;//_HyperlinkOperations_.HyperLink_PrevHyperLink_Execute

procedure _HyperlinkOperations_.HyperLink_OpenInNewTab_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *53DF186601F1_4F1044DD0281test_var*
//#UC END# *53DF186601F1_4F1044DD0281test_var*
begin
//#UC START# *53DF186601F1_4F1044DD0281test_impl*
 HyperLink_OpenNewWindow_Test(aParams);
//#UC END# *53DF186601F1_4F1044DD0281test_impl*
end;//_HyperlinkOperations_.HyperLink_OpenInNewTab_Test

procedure _HyperlinkOperations_.HyperLink_OpenInNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *53DF186601F1_4F1044DD0281exec_var*
var
 l_HyperLink: IevHyperLink;
//#UC END# *53DF186601F1_4F1044DD0281exec_var*
begin
//#UC START# *53DF186601F1_4F1044DD0281exec_impl*
 if Supports(Text.Selection, IevHyperlink, l_HyperLink) then
 begin
  nsProcessHyperLink(l_HyperLink, phbInNewTabNoActivate, Self, Aggregate,
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=567553873
   _Instance_R_(Self).Document);
  Container.SetFocusToMainObjectForm; // http://mdp.garant.ru/x/KcvtIQ
  AfterOpenHyperlinkInNewTab;
 end;
//#UC END# *53DF186601F1_4F1044DD0281exec_impl*
end;//_HyperlinkOperations_.HyperLink_OpenInNewTab_Execute

procedure _HyperlinkOperations_.HyperLink_OpenScriptHyperLink_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *53F5887E03A1_4F1044DD0281test_var*
var
 l_HyperLink: IevHyperLink;
//#UC END# *53F5887E03A1_4F1044DD0281test_var*
begin
//#UC START# *53F5887E03A1_4F1044DD0281test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := IsHyperlinkOfKind(ev_lvkScript);
//#UC END# *53F5887E03A1_4F1044DD0281test_impl*
end;//_HyperlinkOperations_.HyperLink_OpenScriptHyperLink_Test

procedure _HyperlinkOperations_.HyperLink_OpenScriptHyperLink_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *53F5887E03A1_4F1044DD0281exec_var*
//#UC END# *53F5887E03A1_4F1044DD0281exec_var*
begin
//#UC START# *53F5887E03A1_4F1044DD0281exec_impl*
 OpenHyperlink;
//#UC END# *53F5887E03A1_4F1044DD0281exec_impl*
end;//_HyperlinkOperations_.HyperLink_OpenScriptHyperLink_Execute

procedure _HyperlinkOperations_.HyperLink_NavigateInternetHyperlink_Test(const aParams: IvcmTestParamsPrim);
 {* Перейти по гиперссылке }
//#UC START# *5460A4DD0349_4F1044DD0281test_var*
//#UC END# *5460A4DD0349_4F1044DD0281test_var*
begin
//#UC START# *5460A4DD0349_4F1044DD0281test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := IsHyperlinkOfKind(ev_lvkExternal);
//#UC END# *5460A4DD0349_4F1044DD0281test_impl*
end;//_HyperlinkOperations_.HyperLink_NavigateInternetHyperlink_Test

procedure _HyperlinkOperations_.HyperLink_NavigateInternetHyperlink_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Перейти по гиперссылке }
//#UC START# *5460A4DD0349_4F1044DD0281exec_var*
//#UC END# *5460A4DD0349_4F1044DD0281exec_var*
begin
//#UC START# *5460A4DD0349_4F1044DD0281exec_impl*
 OpenHyperLink;
//#UC END# *5460A4DD0349_4F1044DD0281exec_impl*
end;//_HyperlinkOperations_.HyperLink_NavigateInternetHyperlink_Execute
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf HyperlinkOperations_imp_impl}

{$EndIf HyperlinkOperations_imp}

