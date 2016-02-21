unit FoldersChangeUserInteraction;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersChangeUserInteraction.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , FoldersDomainInterfaces
;

type
 TFoldersChangeUserInteraction = class
  public
   class function AskAllowMerge: TnsListMergeKind;
   class procedure SayChildNodeDuplicated;
 end;//TFoldersChangeUserInteraction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsQuestionsWithChoices
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

class function TFoldersChangeUserInteraction.AskAllowMerge: TnsListMergeKind;
//#UC START# *51F65ADD01D0_51F65A1A03D3_var*
//#UC END# *51F65ADD01D0_51F65A1A03D3_var*
begin
//#UC START# *51F65ADD01D0_51F65A1A03D3_impl*
 Result := lmkDeny;
 case vcmMessageDlg(str_DropListToList, []) of
  -1:
   Result := lmkAllow;
  mrCancel:
   Result := lmkAbort;
 end;//case MessageDlg(str_DropListToList)

//#UC END# *51F65ADD01D0_51F65A1A03D3_impl*
end;//TFoldersChangeUserInteraction.AskAllowMerge

class procedure TFoldersChangeUserInteraction.SayChildNodeDuplicated;
//#UC START# *51F65B500160_51F65A1A03D3_var*
//#UC END# *51F65B500160_51F65A1A03D3_var*
begin
//#UC START# *51F65B500160_51F65A1A03D3_impl*
 vcmSay(err_DuplicateNameError);
//#UC END# *51F65B500160_51F65A1A03D3_impl*
end;//TFoldersChangeUserInteraction.SayChildNodeDuplicated
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
