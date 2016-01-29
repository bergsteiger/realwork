unit PrimDefineSearchDate_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimDefineSearchDate_Form.pas"
// �����: 02.10.2009 21:03
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 �������� ����������::Search::View::Search::PrimDefineSearchDate
//
// ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsQueryInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  vtPanel
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  vtDblClickDateEdit,
  vtLabel,
  vtRadioButton,
  vcmExternalInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TTypeDate = (
  {* ���� ��� (������ ����, �����, ������, �������� ���) }
   tdD1EqD2
 , tdD1Only
 , tdD2Only
 , tdD1D2
 );//TTypeDate

 TPrimDefineSearchDateForm = {form} class(TvcmEntityForm)
  {* ���� }
 private
 // private fields
   f_ButtonList : TList;
   f_DateReq : IqaDateReqDataHolder;
   f_Panel1 : TvtPanel;
    {* ���� ��� �������� Panel1}
   f_ElLabel1 : TvtLabel;
    {* ���� ��� �������� ElLabel1}
   f_ElLabel2 : TvtLabel;
    {* ���� ��� �������� ElLabel2}
   f_ElLabel3 : TvtLabel;
    {* ���� ��� �������� ElLabel3}
   f_dD1EqD2 : TvtDblClickDateEdit;
    {* ���� ��� �������� dD1EqD2}
   f_rbEq : TvtRadioButton;
    {* ���� ��� �������� rbEq}
   f_rbInt : TvtRadioButton;
    {* ���� ��� �������� rbInt}
   f_rbD2Only : TvtRadioButton;
    {* ���� ��� �������� rbD2Only}
   f_dD1Only : TvtDblClickDateEdit;
    {* ���� ��� �������� dD1Only}
   f_dD2Only : TvtDblClickDateEdit;
    {* ���� ��� �������� dD2Only}
   f_dD1 : TvtDblClickDateEdit;
    {* ���� ��� �������� dD1}
   f_rbD1Only : TvtRadioButton;
    {* ���� ��� �������� rbD1Only}
   f_dD2 : TvtDblClickDateEdit;
    {* ���� ��� �������� dD2}
   f_TypeDate : TTypeDate;
    {* ���� ��� �������� TypeDate}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure VcmEntityFormKeyDown(Sender: TObject;
     var Key: Word;
     Shift: TShiftState);
   procedure RbEqClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure RbIntClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure RbD2OnlyClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure RbD1OnlyClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure ChangeSelection(aControl: TWinControl;
     aForward: Boolean);
   procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
 protected
 // property methods
   procedure pm_SetTypeDate(aValue: TTypeDate); virtual;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������ }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function Save: Boolean;
 public
 // public methods
   procedure GetDates(const aDateReq: IqaDateReqDataHolder);
   procedure SetDates(const aDateReq: IqaDateReqDataHolder);
   class function Make(const aData: IqaDateReqDataHolder;
     const aParams : IvcmMakeParams = nil;
     aZoneType     : TvcmZoneType = vcm_ztAny;
     aUserType     : TvcmEffectiveUserType = 0;
     aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property Panel1: TvtPanel
     read f_Panel1;
   property ElLabel1: TvtLabel
     read f_ElLabel1;
     {* �������� ��� ���������: }
   property ElLabel2: TvtLabel
     read f_ElLabel2;
     {* � }
   property ElLabel3: TvtLabel
     read f_ElLabel3;
     {* �� }
   property dD1EqD2: TvtDblClickDateEdit
     read f_dD1EqD2;
   property rbEq: TvtRadioButton
     read f_rbEq;
     {* ������ ����: }
   property rbInt: TvtRadioButton
     read f_rbInt;
     {* �������� ���: }
   property rbD2Only: TvtRadioButton
     read f_rbD2Only;
     {* ������: }
   property dD1Only: TvtDblClickDateEdit
     read f_dD1Only;
   property dD2Only: TvtDblClickDateEdit
     read f_dD2Only;
   property dD1: TvtDblClickDateEdit
     read f_dD1;
   property rbD1Only: TvtRadioButton
     read f_rbD1Only;
     {* �����: }
   property dD2: TvtDblClickDateEdit
     read f_dD2;
   property TypeDate: TTypeDate
     read f_TypeDate
     write pm_SetTypeDate;
 end;//TPrimDefineSearchDateForm

 TvcmEntityFormRef = TPrimDefineSearchDateForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Windows,
  l3String,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmGUI
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  nsUtils,
  l3Date
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vtCombo,
  DefineSearchDateUtils,
  l3Base
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimDefineSearchDateForm

procedure TPrimDefineSearchDateForm.VcmEntityFormKeyDown(Sender: TObject;
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
end;//TPrimDefineSearchDateForm.VcmEntityFormKeyDown

procedure TPrimDefineSearchDateForm.RbEqClick(Sender: TObject);
//#UC START# *51B5AD6F03A2_4AC6324502DA_var*
//#UC END# *51B5AD6F03A2_4AC6324502DA_var*
begin
//#UC START# *51B5AD6F03A2_4AC6324502DA_impl*
 pm_SetTypeDate(tdD1EqD2);
//#UC END# *51B5AD6F03A2_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.RbEqClick

procedure TPrimDefineSearchDateForm.RbIntClick(Sender: TObject);
//#UC START# *51B5AD7D003D_4AC6324502DA_var*
//#UC END# *51B5AD7D003D_4AC6324502DA_var*
begin
//#UC START# *51B5AD7D003D_4AC6324502DA_impl*
 pm_SetTypeDate(tdD1D2);
//#UC END# *51B5AD7D003D_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.RbIntClick

procedure TPrimDefineSearchDateForm.RbD2OnlyClick(Sender: TObject);
//#UC START# *51B5AD8503C7_4AC6324502DA_var*
//#UC END# *51B5AD8503C7_4AC6324502DA_var*
begin
//#UC START# *51B5AD8503C7_4AC6324502DA_impl*
 pm_SetTypeDate(tdD2Only);
//#UC END# *51B5AD8503C7_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.RbD2OnlyClick

procedure TPrimDefineSearchDateForm.RbD1OnlyClick(Sender: TObject);
//#UC START# *51B5AD8E0071_4AC6324502DA_var*
//#UC END# *51B5AD8E0071_4AC6324502DA_var*
begin
//#UC START# *51B5AD8E0071_4AC6324502DA_impl*
 pm_SetTypeDate(tdD1Only);
//#UC END# *51B5AD8E0071_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.RbD1OnlyClick

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
  (* �������� ��� *)
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
  (* ������ ���� *)
  tdD1EqD2:
   if not CheckDate(dD1EqD2, err_DateNotDefined) then
    Exit;
  (* ������ *)
  tdD2Only:
   if not CheckDate(dD2Only, err_DateNotDefined) then
    Exit;
  (* ����� *)
  tdD1Only:
   if not CheckDate(dD1Only, err_DateNotDefined) then
    Exit;
 end;

 ModalResult := mrOk;
 Result := True;
//#UC END# *51B5B4F6018C_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.Save

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
  { ������ }
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
  { ����� }
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
  { ������ ���� }
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
  { �������� ��� }
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

class function TPrimDefineSearchDateForm.Make(const aData: IqaDateReqDataHolder;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimDefineSearchDateForm);
 begin
  with aForm do
  begin
//#UC START# *51B6D069027B_4AC6324502DA_impl*
   f_DateReq := aData;
   Assert(Assigned(f_DateReq));
   SetDates(f_DateReq);
   if not l3IsNil(f_DateReq.ReqCaption) then
    CCaption := f_DateReq.ReqCaption;
   Position := poScreenCenter;
//#UC END# *51B6D069027B_4AC6324502DA_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

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

{$If not defined(NoVCM)}
procedure TPrimDefineSearchDateForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4AC6324502DAexec_var*
//#UC END# *4A8AD46D0226_4AC6324502DAexec_var*
begin
//#UC START# *4A8AD46D0226_4AC6324502DAexec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC6324502DAexec_impl*
end;//TPrimDefineSearchDateForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimDefineSearchDateForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AC6324502DAexec_var*
//#UC END# *4A97EBE702F8_4AC6324502DAexec_var*
begin
//#UC START# *4A97EBE702F8_4AC6324502DAexec_impl*
 Assert(Assigned(f_DateReq));
 if Save then
  GetDates(f_DateReq);
//#UC END# *4A97EBE702F8_4AC6324502DAexec_impl*
end;//TPrimDefineSearchDateForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TPrimDefineSearchDateForm.Cleanup;
//#UC START# *479731C50290_4AC6324502DA_var*
//#UC END# *479731C50290_4AC6324502DA_var*
begin
//#UC START# *479731C50290_4AC6324502DA_impl*
 f_DateReq := nil;
 FreeAndNil(f_ButtonList);
 inherited;
//#UC END# *479731C50290_4AC6324502DA_impl*
end;//TPrimDefineSearchDateForm.Cleanup

{$If not defined(NoVCM)}
procedure TPrimDefineSearchDateForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimDefineSearchDateForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, true);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Ok, true);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TPrimDefineSearchDateForm.MakeControls;
begin
 inherited;
 f_Panel1 := TvtPanel.Create(Self);
 f_Panel1.Name := 'Panel1';
 f_Panel1.Parent := Self;
 f_ElLabel1 := TvtLabel.Create(Self);
 f_ElLabel1.Name := 'ElLabel1';
 f_ElLabel1.Parent := Panel1;
 f_ElLabel1.Caption := '�������� ��� ���������:';
 f_ElLabel2 := TvtLabel.Create(Self);
 f_ElLabel2.Name := 'ElLabel2';
 f_ElLabel2.Parent := Panel1;
 f_ElLabel2.Caption := '�';
 f_ElLabel3 := TvtLabel.Create(Self);
 f_ElLabel3.Name := 'ElLabel3';
 f_ElLabel3.Parent := Panel1;
 f_ElLabel3.Caption := '��';
 f_dD1EqD2 := TvtDblClickDateEdit.Create(Self);
 f_dD1EqD2.Name := 'dD1EqD2';
 f_dD1EqD2.Parent := Panel1;
 f_rbEq := TvtRadioButton.Create(Self);
 f_rbEq.Name := 'rbEq';
 f_rbEq.Parent := Panel1;
 f_rbEq.Caption := '������ ����:';
 f_rbInt := TvtRadioButton.Create(Self);
 f_rbInt.Name := 'rbInt';
 f_rbInt.Parent := Panel1;
 f_rbInt.Caption := '�������� ���:';
 f_rbD2Only := TvtRadioButton.Create(Self);
 f_rbD2Only.Name := 'rbD2Only';
 f_rbD2Only.Parent := Panel1;
 f_rbD2Only.Caption := '������:';
 f_dD1Only := TvtDblClickDateEdit.Create(Self);
 f_dD1Only.Name := 'dD1Only';
 f_dD1Only.Parent := Panel1;
 f_dD2Only := TvtDblClickDateEdit.Create(Self);
 f_dD2Only.Name := 'dD2Only';
 f_dD2Only.Parent := Panel1;
 f_dD1 := TvtDblClickDateEdit.Create(Self);
 f_dD1.Name := 'dD1';
 f_dD1.Parent := Panel1;
 f_rbD1Only := TvtRadioButton.Create(Self);
 f_rbD1Only.Name := 'rbD1Only';
 f_rbD1Only.Parent := Panel1;
 f_rbD1Only.Caption := '�����:';
 f_dD2 := TvtDblClickDateEdit.Create(Self);
 f_dD2.Name := 'dD2';
 f_dD2.Parent := Panel1;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� PrimDefineSearchDate
 TtfwClassRef.Register(TPrimDefineSearchDateForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.