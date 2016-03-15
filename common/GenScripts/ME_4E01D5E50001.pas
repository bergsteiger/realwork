{$IfNDef vcmUserInteractiveForm_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.imp.pas"
// Стереотип: "Impurity"

{$Define vcmUserInteractiveForm_imp}

{$If NOT Defined(NoVCM)}
 _vcmUserInteractiveForm_ = class(_vcmUserInteractiveForm_Parent_, IvcmUserInteraction)
  protected
   function MessageDlg(const aMsg: IvcmCString;
    const aKey: AnsiString;
    aDlgType: TMsgDlgType = Dialogs.mtCustom;
    aButtons: TMsgDlgButtons = Dialogs.[mbOK]): Integer; overload;
   function MessageDlg(const aMsg: TvcmMessageID): Integer; overload;
   procedure Say(const aMsg: TvcmMessageID); overload;
   procedure Say(const aMsg: TvcmMessageID;
    const aData: array of const); overload;
   function Ask(const aMsg: TvcmMessageID): Boolean; overload;
   function Ask(const aMsg: TvcmMessageID;
    const aData: array of const): Boolean; overload;
   function Ask(const aMsg: Tl3MessageID;
    const aData: array of const): Boolean; overload;
   function MessageDlg(const aMsg: Tl3MessageID;
    const aData: array of const): Integer; overload;
   function MessageDlg(const aMsg: Tl3MessageID): Integer; overload;
 end;//_vcmUserInteractiveForm_

{$Else NOT Defined(NoVCM)}

_vcmUserInteractiveForm_ = _vcmUserInteractiveForm_Parent_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmUserInteractiveForm_imp}

{$IfNDef vcmUserInteractiveForm_imp_impl}

{$Define vcmUserInteractiveForm_imp_impl}

{$If NOT Defined(NoVCM)}
function _vcmUserInteractiveForm_.MessageDlg(const aMsg: IvcmCString;
 const aKey: AnsiString;
 aDlgType: TMsgDlgType = Dialogs.mtCustom;
 aButtons: TMsgDlgButtons = Dialogs.[mbOK]): Integer;
//#UC START# *4993085402D8_4E01D5E50001_var*
//#UC END# *4993085402D8_4E01D5E50001_var*
begin
//#UC START# *4993085402D8_4E01D5E50001_impl*
 Result := vcmShowMessageDlg(Tl3Message_C(aMsg, aKey, aDlgType, aButtons));
//#UC END# *4993085402D8_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.MessageDlg

function _vcmUserInteractiveForm_.MessageDlg(const aMsg: TvcmMessageID): Integer;
//#UC START# *4993088901F8_4E01D5E50001_var*
//#UC END# *4993088901F8_4E01D5E50001_var*
begin
//#UC START# *4993088901F8_4E01D5E50001_impl*
 Result := vcmMessageDlg(aMsg);
//#UC END# *4993088901F8_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.MessageDlg

procedure _vcmUserInteractiveForm_.Say(const aMsg: TvcmMessageID);
//#UC START# *4993090C039C_4E01D5E50001_var*
//#UC END# *4993090C039C_4E01D5E50001_var*
begin
//#UC START# *4993090C039C_4E01D5E50001_impl*
 vcmSay(aMsg);
//#UC END# *4993090C039C_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.Say

procedure _vcmUserInteractiveForm_.Say(const aMsg: TvcmMessageID;
 const aData: array of const);
//#UC START# *499309240368_4E01D5E50001_var*
//#UC END# *499309240368_4E01D5E50001_var*
begin
//#UC START# *499309240368_4E01D5E50001_impl*
 vcmSay(aMsg, aData);
//#UC END# *499309240368_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.Say

function _vcmUserInteractiveForm_.Ask(const aMsg: TvcmMessageID): Boolean;
//#UC START# *4993093502E9_4E01D5E50001_var*
//#UC END# *4993093502E9_4E01D5E50001_var*
begin
//#UC START# *4993093502E9_4E01D5E50001_impl*
 Result := vcmAsk(aMsg);
//#UC END# *4993093502E9_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.Ask

function _vcmUserInteractiveForm_.Ask(const aMsg: TvcmMessageID;
 const aData: array of const): Boolean;
//#UC START# *49930942035E_4E01D5E50001_var*
//#UC END# *49930942035E_4E01D5E50001_var*
begin
//#UC START# *49930942035E_4E01D5E50001_impl*
 Result := vcmAsk(aMsg, aData);
//#UC END# *49930942035E_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.Ask

function _vcmUserInteractiveForm_.Ask(const aMsg: Tl3MessageID;
 const aData: array of const): Boolean;
//#UC START# *4E7CA605012E_4E01D5E50001_var*
//#UC END# *4E7CA605012E_4E01D5E50001_var*
begin
//#UC START# *4E7CA605012E_4E01D5E50001_impl*
 Result := vcmAsk(aMsg, aData);
//#UC END# *4E7CA605012E_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.Ask

function _vcmUserInteractiveForm_.MessageDlg(const aMsg: Tl3MessageID;
 const aData: array of const): Integer;
//#UC START# *4E9E89E9006D_4E01D5E50001_var*
//#UC END# *4E9E89E9006D_4E01D5E50001_var*
begin
//#UC START# *4E9E89E9006D_4E01D5E50001_impl*
 Result := vcmMessageDlg(aMsg, aData);
//#UC END# *4E9E89E9006D_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.MessageDlg

function _vcmUserInteractiveForm_.MessageDlg(const aMsg: Tl3MessageID): Integer;
//#UC START# *4F9AB5AF01F9_4E01D5E50001_var*
//#UC END# *4F9AB5AF01F9_4E01D5E50001_var*
begin
//#UC START# *4F9AB5AF01F9_4E01D5E50001_impl*
 Result := vcmMessageDlg(aMsg, []);
//#UC END# *4F9AB5AF01F9_4E01D5E50001_impl*
end;//_vcmUserInteractiveForm_.MessageDlg
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmUserInteractiveForm_imp_impl}

{$EndIf vcmUserInteractiveForm_imp}

