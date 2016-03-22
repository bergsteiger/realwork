unit PrimDefineSearchDate_Form;
 {* Дата }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimDefineSearchDate_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimDefineSearchDate" MUID: (4AC6324502DA)
// Имя типа: "TPrimDefineSearchDateForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Classes
 , nsQueryInterfaces
 , vtPanel
 , vtLabel
 , vtDblClickDateEdit
 , vtRadioButton
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TTypeDate = (
  {* типы дат (точная дата, позже, раньше, диапазон дат) }
  tdD1EqD2
  , tdD1Only
  , tdD2Only
  , tdD1D2
 );//TTypeDate

 TPrimDefineSearchDateForm = class(TvcmEntityForm)
  {* Дата }
  private
   f_ButtonList: TList;
   f_DateReq: IqaDateReqDataHolder;
   f_Panel1: TvtPanel;
    {* Поле для свойства Panel1 }
   f_ElLabel1: TvtLabel;
    {* Поле для свойства ElLabel1 }
   f_ElLabel2: TvtLabel;
    {* Поле для свойства ElLabel2 }
   f_ElLabel3: TvtLabel;
    {* Поле для свойства ElLabel3 }
   f_dD1EqD2: TvtDblClickDateEdit;
    {* Поле для свойства dD1EqD2 }
   f_rbEq: TvtRadioButton;
    {* Поле для свойства rbEq }
   f_rbInt: TvtRadioButton;
    {* Поле для свойства rbInt }
   f_rbD2Only: TvtRadioButton;
    {* Поле для свойства rbD2Only }
   f_dD1Only: TvtDblClickDateEdit;
    {* Поле для свойства dD1Only }
   f_dD2Only: TvtDblClickDateEdit;
    {* Поле для свойства dD2Only }
   f_dD1: TvtDblClickDateEdit;
    {* Поле для свойства dD1 }
   f_rbD1Only: TvtRadioButton;
    {* Поле для свойства rbD1Only }
   f_dD2: TvtDblClickDateEdit;
    {* Поле для свойства dD2 }
   f_TypeDate: TTypeDate;
    {* Поле для свойства TypeDate }
  private
   procedure vcmEntityFormKeyDown(Sender: TObject;
    var Key: Word;
    Shift: TShiftState);
   procedure rbEqClick(Sender: TObject);
   procedure rbIntClick(Sender: TObject);
   procedure rbD2OnlyClick(Sender: TObject);
   procedure rbD1OnlyClick(Sender: TObject);
   procedure ChangeSelection(aControl: TWinControl;
    aForward: Boolean);
   procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  protected
   procedure pm_SetTypeDate(aValue: TTypeDate); virtual;
   function Save: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure GetDates(const aDateReq: IqaDateReqDataHolder);
   procedure SetDates(const aDateReq: IqaDateReqDataHolder);
   class function Make(const aData: IqaDateReqDataHolder): IvcmEntityForm; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property Panel1: TvtPanel
    read f_Panel1;
   property TypeDate: TTypeDate
    read f_TypeDate
    write pm_SetTypeDate;
 end;//TPrimDefineSearchDateForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Windows
 , l3String
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmGUI
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , l3Date
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vtCombo
 , DefineSearchDateUtils
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimDefineSearchDateForm.pm_SetTypeDate(aValue: TTypeDate);
//#UC START# *51B5AE3F0318_4AC6324502DAset_var*
//#UC END# *51B5AE3F0318_4AC6324502DAset_var*
begin
//#UC START# *51B5AE3F0318_4AC6324502DAset_impl*
 f_TypeDate := aValue;
 dD1EqD2.Enabled := f_TypeDate = tdD1EqD2;
 dD2Only.Enabled := f_TypeDate = tdD2Only;
 dD1Only.Enabled := f_TypeDate = tdD1Only;
 dD1.Enabled := f_TypeDate = tdD1D2;
 dD2.Enabled := f_TypeDate = tdD1D2;
//#UC END# *51B5AE3F0318_4AC6324502DAset_impl*
end;//TPrimDefineSearchDateForm.pm_SetTypeDate

procedure TPrimDefineSearchDateForm.vcmEntityFormKeyDown(Sender: TObject;
 var Key: Word;
 Shift: TShiftState);
//#UC START# *51B595AF0368_4AC6324502DA_var*
//#UC END# *51B595AF0368_4AC6324502DA_var*
begin
//#UC START# *51B595AF0368_4AC6324502DA_impl*
 if Shift = [] then
  case Key of
   VK_DOWN:
    begin
     ChangeSelection(ActiveControl, True);
     Key := 0;
    end;
   VK_UP:
    begin
     ChangeSelection(ActiveControl, False);
     Key := 0;
    end;
  end;
//#UC END# *51B595AF0368_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.vcmEntityFormKeyDown

procedure TPrimDefineSearchDateForm.rbEqClick(Sender: TObject);
//#UC START# *51B5AD6F03A2_4AC6324502DA_var*
//#UC END# *51B5AD6F03A2_4AC6324502DA_var*
begin
//#UC START# *51B5AD6F03A2_4AC6324502DA_impl*
 pm_SetTypeDate(tdD1EqD2);
//#UC END# *51B5AD6F03A2_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.rbEqClick

procedure TPrimDefineSearchDateForm.rbIntClick(Sender: TObject);
//#UC START# *51B5AD7D003D_4AC6324502DA_var*
//#UC END# *51B5AD7D003D_4AC6324502DA_var*
begin
//#UC START# *51B5AD7D003D_4AC6324502DA_impl*
 pm_SetTypeDate(tdD1D2);
//#UC END# *51B5AD7D003D_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.rbIntClick

procedure TPrimDefineSearchDateForm.rbD2OnlyClick(Sender: TObject);
//#UC START# *51B5AD8503C7_4AC6324502DA_var*
//#UC END# *51B5AD8503C7_4AC6324502DA_var*
begin
//#UC START# *51B5AD8503C7_4AC6324502DA_impl*
 pm_SetTypeDate(tdD2Only);
//#UC END# *51B5AD8503C7_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.rbD2OnlyClick

procedure TPrimDefineSearchDateForm.rbD1OnlyClick(Sender: TObject);
//#UC START# *51B5AD8E0071_4AC6324502DA_var*
//#UC END# *51B5AD8E0071_4AC6324502DA_var*
begin
//#UC START# *51B5AD8E0071_4AC6324502DA_impl*
 pm_SetTypeDate(tdD1Only);
//#UC END# *51B5AD8E0071_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.rbD1OnlyClick

function TPrimDefineSearchDateForm.Save: Boolean;
//#UC START# *51B5B4F6018C_4AC6324502DA_var*
 function CheckDate(aDate: TvtDblClickDateEdit; aMessage: TvcmMessageID) : Boolean;
 begin
  Result := True;
  if aDate.IsEmpty then
  begin
   vcmAsk(aMessage);
   aDate.SetFocus;
   Result := False;
  end;
 end;
//#UC END# *51B5B4F6018C_4AC6324502DA_var*
begin
//#UC START# *51B5B4F6018C_4AC6324502DA_impl*
 Result := False;
 case f_TypeDate of
  (* интервал дат *)
  tdD1D2:
  begin
   if not CheckDate(dD1, err_DateBeginNotDefined) then
    Exit;
   if not CheckDate(dD2, err_DateEndNotDefined) then
    Exit;
   if dD1.Date > dD2.Date then
   begin
    Say(err_StartDateMoreEnd, [nsDateToStr(dD1.Date), nsDateToStr(dD2.Date)]);
    dD1.SetFocus;
    Exit;
   end;
  end;
  (* точная дата *)
  tdD1EqD2:
   if not CheckDate(dD1EqD2, err_DateNotDefined) then
    Exit;
  (* раньше *)
  tdD2Only:
   if not CheckDate(dD2Only, err_DateNotDefined) then
    Exit;
  (* позже *)
  tdD1Only:
   if not CheckDate(dD1Only, err_DateNotDefined) then
    Exit;
 end;

 ModalResult := mrOk;
 Result := True;
//#UC END# *51B5B4F6018C_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.Save

procedure TPrimDefineSearchDateForm.ChangeSelection(aControl: TWinControl;
 aForward: Boolean);
//#UC START# *51B5B5D7014C_4AC6324502DA_var*
var
 l_Idx: Integer;
 l_ControlIdx: Integer;
//#UC END# *51B5B5D7014C_4AC6324502DA_var*
begin
//#UC START# *51B5B5D7014C_4AC6324502DA_impl*
 l_ControlIdx := -1;
 for l_Idx := 0 to f_ButtonList.Count-1 Do
  if TWinControl(f_ButtonList[l_Idx]).Tag = aControl.Tag then
  begin
   l_ControlIdx := l_Idx;
   break;
  end;
 if l_ControlIdx <> -1 then
 begin
  if aForward then
   Inc(l_ControlIdx)
  else
   Dec(l_ControlIdx);
  if l_ControlIdx < 0 then
   l_ControlIdx := f_ButtonList.Count-1;
  if l_ControlIdx >= f_ButtonList.Count then
   l_ControlIdx := 0;
 end;
 TWinControl(f_ButtonList[l_ControlIdx]).SetFocus;
 if f_ButtonList.indexof(aControl) = -1 then
  SelectNext(TWinControl(f_ButtonList[l_ControlIdx]), True, True);
//#UC END# *51B5B5D7014C_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.ChangeSelection

procedure TPrimDefineSearchDateForm.GetDates(const aDateReq: IqaDateReqDataHolder);
//#UC START# *51B5C31102B7_4AC6324502DA_var*
//#UC END# *51B5C31102B7_4AC6324502DA_var*
begin
//#UC START# *51B5C31102B7_4AC6324502DA_impl*
 case f_TypeDate of
  tdD1EqD2:
  begin
   aDateReq.StartDate := dD1EqD2.Date;
   aDateReq.EndDate := dD1EqD2.Date;
  end;
  tdD1Only:
  begin
    aDateReq.EndDate := NullDate;
    aDateReq.StartDate := dD1Only.Date;
  end;
  tdD2Only:
  begin
    aDateReq.StartDate := NullDate;
    aDateReq.EndDate := dD2Only.Date;
  end;
  tdD1D2:
  begin
   aDateReq.StartDate := dD1.Date;
   aDateReq.EndDate := dD2.Date;
  end;
 end;
 f_DateReq.IsOk := True;
//#UC END# *51B5C31102B7_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.GetDates

procedure TPrimDefineSearchDateForm.SetDates(const aDateReq: IqaDateReqDataHolder);
//#UC START# *51B5C3360189_4AC6324502DA_var*
//#UC END# *51B5C3360189_4AC6324502DA_var*
begin
//#UC START# *51B5C3360189_4AC6324502DA_impl*
 f_DateReq.IsOk := False;
 if not aDateReq.IsStartDateEmpty or not aDateReq.IsEndDateEmpty then
 begin
  { Раньше }
  if aDateReq.IsStartDateEmpty and not aDateReq.IsEndDateEmpty then
  begin
   pm_SetTypeDate(tdD2Only);
   rbD2Only.Checked := True;
   dD2Only.Date := aDateReq.EndDate;
   dD1EqD2.Date := dD2Only.Date;
   dD1.Date := dD2Only.Date;
   dD2.Date := dD2Only.Date;
   dD1Only.Date := dD2Only.Date;
  end
  { Позже }
  else if not aDateReq.IsStartDateEmpty and aDateReq.IsEndDateEmpty then
  begin
   pm_SetTypeDate(tdD1Only);
   rbD1Only.Checked := True;
   dD1Only.Date := aDateReq.StartDate;
   dD1EqD2.Date := dD1Only.Date;
   dD1.Date := dD1Only.Date;
   dD2.Date := dD1Only.Date;
   dD2Only.Date := dD1Only.Date;
  end
  { Точная дата }
  else
   if (not aDateReq.IsStartDateEmpty and not aDateReq.IsEndDateEmpty) and
     (aDateReq.StartDate = aDateReq.EndDate) then
   begin
    pm_SetTypeDate(tdD1EqD2);
    rbEq.Checked := True;
    dD1EqD2.Date := aDateReq.StartDate;
    dD1Only.Date := dD1EqD2.Date;
    dD1.Date := dD1EqD2.Date;
    dD2.Date := dD1EqD2.Date;
    dD2Only.Date := dD1EqD2.Date;
   end
  { Интервал дат }
  else
  begin
   pm_SetTypeDate(tdD1D2);
   rbInt.Checked := True;
   dD1.Date := aDateReq.StartDate;
   dD2.Date := aDateReq.EndDate;
   dD1Only.Date := dD1.Date;
   dD1EqD2.Date := dD1.Date;
   dD2Only.Date := dD2.Date;
  end;
 end;
//#UC END# *51B5C3360189_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.SetDates

class function TPrimDefineSearchDateForm.Make(const aData: IqaDateReqDataHolder): IvcmEntityForm;
var
 l_Inst : TPrimDefineSearchDateForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimDefineSearchDateForm.Make

procedure TPrimDefineSearchDateForm.CMDialogKey(var Message: TCMDialogKey);
//#UC START# *51B5B5FB0354_4AC6324502DA_var*
//#UC END# *51B5B5FB0354_4AC6324502DA_var*
begin
//#UC START# *51B5B5FB0354_4AC6324502DA_impl*
 if GetKeyState(VK_MENU) >= 0 then
  with Message do
   case CharCode of
    VK_LEFT: Result := 1;
    VK_UP: if ActiveControl <> nil then
           begin
            ChangeSelection(ActiveControl, False);
            Result := 1;
           end;
    VK_DOWN: if ActiveControl <> nil then
             begin
              ChangeSelection(ActiveControl, True);
              Result := 1;
             end;
   else
    inherited;
   end
 else
  inherited;
//#UC END# *51B5B5FB0354_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.CMDialogKey

procedure TPrimDefineSearchDateForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AC6324502DAexec_var*
//#UC END# *4A8AD46D0226_4AC6324502DAexec_var*
begin
//#UC START# *4A8AD46D0226_4AC6324502DAexec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC6324502DAexec_impl*
end;//TPrimDefineSearchDateForm.Result_Cancel_Execute

procedure TPrimDefineSearchDateForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC6324502DAexec_var*
//#UC END# *4A97EBE702F8_4AC6324502DAexec_var*
begin
//#UC START# *4A97EBE702F8_4AC6324502DAexec_impl*
 Assert(Assigned(f_DateReq));
 if Save then
  GetDates(f_DateReq);
//#UC END# *4A97EBE702F8_4AC6324502DAexec_impl*
end;//TPrimDefineSearchDateForm.Result_Ok_Execute

procedure TPrimDefineSearchDateForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AC6324502DA_var*
//#UC END# *479731C50290_4AC6324502DA_var*
begin
//#UC START# *479731C50290_4AC6324502DA_impl*
 f_DateReq := nil;
 FreeAndNil(f_ButtonList);
 inherited;
//#UC END# *479731C50290_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.Cleanup

procedure TPrimDefineSearchDateForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AC6324502DA_var*
var
 l_Idx: Integer;
 l_Delta: Integer;
//#UC END# *4A8E8F2E0195_4AC6324502DA_var*
begin
//#UC START# *4A8E8F2E0195_4AC6324502DA_impl*
 with Self do
 begin
  BorderIcons := [biSystemMenu];
  BorderStyle := bsSingle;
  ClientHeight := 170;
  ClientWidth := 411;
  KeyPreview := True;
  OnKeyDown := vcmEntityFormKeyDown;
 end;

 with Panel1 do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  BevelOuter := bvNone;
 end;

 with ElLabel1 do
 begin
  Left := 7;
  Top := 12;
 end;

 with ElLabel2 do
 begin
  Left := 118;
  Top := 74;
 end;

 with ElLabel3 do
 begin
  Left := 270;
  Top := 74;
 end;

 with rbEq do
 begin
  Left := 8;
  Top := 41;
  Width := 105;
  Checked := True;
  TabOrder := 0;
  TabStop := True;
  OnClick := rbEqClick;
 end;

 with dD1EqD2 do
 begin
  Left := 153;
  Top := 38;
  Width := 106;
  Style := csDropDown;
  TabOrder := 1;
 end;

 with rbInt do
 begin
  Tag := 1;
  Left := 8;
  Top := 74;
  Width := 108;
  TabOrder := 2;
  OnClick := rbIntClick;
 end;

 with dD1 do
 begin
  Tag := 1;
  Left := 153;
  Top := 70;
  Width := 106;
  Style := csDropDown;
  TabOrder := 3;
 end;

 with dD2 do
 begin
  Tag := 1;
  Left := 293;
  Top := 70;
  Width := 108;
  Style := csDropDown;
  TabOrder := 4;
 end;

 with rbD2Only do
 begin
  Tag := 2;
  Left := 8;
  Top := 107;
  Width := 97;
  TabOrder := 5;
  OnClick := rbD2OnlyClick;
 end;

 with dD2Only do
 begin
  Tag := 2;
  Left := 153;
  Top := 104;
  Width := 106;
  Style := csDropDown;
  TabOrder := 6;
 end;

 with rbD1Only do
 begin
  Tag := 3;
  Left := 8;
  Top := 140;
  Width := 97;
  TabOrder := 7;
  OnClick := rbD1OnlyClick;
 end;

 with dD1Only do
 begin
  Tag := 3;
  Left := 153;
  Top := 136;
  Width := 106;
  Style := csDropDown;
  TabOrder := 8;
 end;

 inherited;
 f_ButtonList := TList.Create;

 f_ButtonList.Add(rbEq);
 f_ButtonList.Add(rbInt);
 f_ButtonList.Add(rbD2Only);
 f_ButtonList.Add(rbD1Only);

 f_ButtonList.Sort(CompareButtons);

 dD1EqD2.Date := Now;
 dD1.Date := Now;
 dD2.Date := Now;
 dD1Only.Date := Now;
 dD2Only.Date := Now;
 pm_SetTypeDate(tdD1EqD2);

 for l_Idx := 0 to f_ButtonList.Count-1 do
  if TvtRadioButton(f_ButtonList[l_Idx]).Checked then
  begin
   ActiveControl := FindNextControl(f_ButtonList[l_Idx], True, True, False);
   Break;
  end;

 l_Delta := ElLabel2.Left + ElLabel2.Width + 8 - dD1EqD2.Left;
 if l_Delta > 0 then
 begin
  Width := Width + l_Delta;
  dD1EqD2.Left := dD1EqD2.Left + l_Delta;
  dD1.Left := dD1EqD2.Left;
  dD2Only.Left := dD1EqD2.Left;
  dD1Only.Left := dD1EqD2.Left;
  ElLabel3.Left := ElLabel3.Left + l_Delta;
  dD2.Left := dD2.Left + l_Delta;
 end;
//#UC END# *4A8E8F2E0195_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.InitControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDefineSearchDateForm);
 {* Регистрация PrimDefineSearchDate }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
