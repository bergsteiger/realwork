unit PrimConsultationMark_Form;
 {* Оценка консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMark_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimConsultationMark" MUID: (497EDC5003D1)
// Имя типа: "TPrimConsultationMarkForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , ConsultationDomainInterfaces
 , vtGroupBox
 , vtPanel
 , vtRadioButton
 , vtLabel
 , eeMemoWithEditOperations
 , bsTypes
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 c_TextCommentLen = 6000;

type
 TPrimConsultationMarkForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Оценка консультации }
  private
   f_gbMark: TvtGroupBox;
    {* Оценка: }
   f_pnlHelp: TvtPanel;
   f_gbComment: TvtGroupBox;
    {* Комментарий к Вашей оценке: }
   f_rbNotSure: TvtRadioButton;
    {* Затрудняюсь ответить (оценка 0) }
   f_rbTwo: TvtRadioButton;
    {* Плохо (оценка 2) }
   f_rbThree: TvtRadioButton;
    {* Удовлетворительно (оценка 3) }
   f_rbFour: TvtRadioButton;
    {* Хорошо (оценка 4) }
   f_rbFive: TvtRadioButton;
    {* Отлично (оценка 5) }
   f_lblHelp: TvtLabel;
    {* Данное окно предназначено для внесения комментария к оценке представленной консультации. Если Вам необходимы дополнительные  разъяснения по сути предоставленного ответа, просьба внести отдельный запрос в карточку запроса «Правовая поддержка онлайн». }
   f_mComment: TeeMemoWithEditOperations;
  protected
   DSMark: IdsConsultationMark;
    {* Оценка консультации }
  private
   procedure rbNotSureClick(Sender: TObject);
   procedure rbFiveClick(Sender: TObject);
   procedure rbFourClick(Sender: TObject);
   procedure rbThreeClick(Sender: TObject);
   procedure rbTwoClick(Sender: TObject);
   procedure PlaceComponents;
   procedure ChangeMark(aMark: TbsConsultationMark);
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property gbMark: TvtGroupBox
    read f_gbMark;
    {* Оценка: }
   property pnlHelp: TvtPanel
    read f_pnlHelp;
   property gbComment: TvtGroupBox
    read f_gbComment;
    {* Комментарий к Вашей оценке: }
   property rbNotSure: TvtRadioButton
    read f_rbNotSure;
    {* Затрудняюсь ответить (оценка 0) }
   property rbTwo: TvtRadioButton
    read f_rbTwo;
    {* Плохо (оценка 2) }
   property rbThree: TvtRadioButton
    read f_rbThree;
    {* Удовлетворительно (оценка 3) }
   property rbFour: TvtRadioButton
    read f_rbFour;
    {* Хорошо (оценка 4) }
   property rbFive: TvtRadioButton
    read f_rbFive;
    {* Отлично (оценка 5) }
   property lblHelp: TvtLabel
    read f_lblHelp;
    {* Данное окно предназначено для внесения комментария к оценке представленной консультации. Если Вам необходимы дополнительные  разъяснения по сути предоставленного ответа, просьба внести отдельный запрос в карточку запроса «Правовая поддержка онлайн». }
   property mComment: TeeMemoWithEditOperations
    read f_mComment;
 end;//TPrimConsultationMarkForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
 {$If NOT Defined(NoScripts)}
 , ConsultationWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimConsultationMark_utcmMain_UserType
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *497EDC5003D1impl_uses*
 //#UC END# *497EDC5003D1impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimConsultationMarkForm.rbNotSureClick(Sender: TObject);
//#UC START# *5176B3D003B4_497EDC5003D1_var*
//#UC END# *5176B3D003B4_497EDC5003D1_var*
begin
//#UC START# *5176B3D003B4_497EDC5003D1_impl*
 ChangeMark(bs_cmNotSure);
//#UC END# *5176B3D003B4_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.rbNotSureClick

procedure TPrimConsultationMarkForm.rbFiveClick(Sender: TObject);
//#UC START# *5176B3E200C1_497EDC5003D1_var*
//#UC END# *5176B3E200C1_497EDC5003D1_var*
begin
//#UC START# *5176B3E200C1_497EDC5003D1_impl*
 ChangeMark(bs_cmFive);
//#UC END# *5176B3E200C1_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.rbFiveClick

procedure TPrimConsultationMarkForm.rbFourClick(Sender: TObject);
//#UC START# *5176B3F200F4_497EDC5003D1_var*
//#UC END# *5176B3F200F4_497EDC5003D1_var*
begin
//#UC START# *5176B3F200F4_497EDC5003D1_impl*
 ChangeMark(bs_cmFour);
//#UC END# *5176B3F200F4_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.rbFourClick

procedure TPrimConsultationMarkForm.rbThreeClick(Sender: TObject);
//#UC START# *5176B3FD0292_497EDC5003D1_var*
//#UC END# *5176B3FD0292_497EDC5003D1_var*
begin
//#UC START# *5176B3FD0292_497EDC5003D1_impl*
 ChangeMark(bs_cmThree);
//#UC END# *5176B3FD0292_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.rbThreeClick

procedure TPrimConsultationMarkForm.rbTwoClick(Sender: TObject);
//#UC START# *5176B4060002_497EDC5003D1_var*
//#UC END# *5176B4060002_497EDC5003D1_var*
begin
//#UC START# *5176B4060002_497EDC5003D1_impl*
 ChangeMark(bs_cmTwo);
//#UC END# *5176B4060002_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.rbTwoClick

procedure TPrimConsultationMarkForm.PlaceComponents;
//#UC START# *5176B4200040_497EDC5003D1_var*
const
 c_Indent = 10;
var
 l_Rect: TRect;
//#UC END# *5176B4200040_497EDC5003D1_var*
begin
//#UC START# *5176B4200040_497EDC5003D1_impl*
 l_Rect := ClientRect;
 AlignControls(nil, l_Rect);
 
 mComment.Left := c_Indent;
 mComment.Top := c_Indent * 2;
 mComment.Width := gbComment.Width - mComment.Left - c_Indent;
 mComment.Height := gbComment.Height - mComment.Top - c_Indent;

 lblHelp.Left := (pnlHelp.Width - lblHelp.Width) div 2;
 lblHelp.Top := (pnlHelp.Height - lblHelp.Height) div 2;
//#UC END# *5176B4200040_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.PlaceComponents

procedure TPrimConsultationMarkForm.ChangeMark(aMark: TbsConsultationMark);
//#UC START# *5176B42C0279_497EDC5003D1_var*
//#UC END# *5176B42C0279_497EDC5003D1_var*
begin
//#UC START# *5176B42C0279_497EDC5003D1_impl*
 if Assigned(dsMark) then
  dsMark.Mark := aMark;
//#UC END# *5176B42C0279_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.ChangeMark

procedure TPrimConsultationMarkForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_497EDC5003D1_var*
//#UC END# *4A8E8F2E0195_497EDC5003D1_var*
begin
//#UC START# *4A8E8F2E0195_497EDC5003D1_impl*
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 ClientHeight := 225;
 ClientWidth := 613;

 with gbMark do
 begin
  Align := alLeft;
  Width := 238;
  TabOrder := 0;
 end;
 
 with rbFive do
 begin
  Left := 8;
  Top := 17;
  Width := 222;
  Height := 14;
  TabOrder := 0;
  OnClick := rbFiveClick;
 end;
 with rbFour do
 begin
  Left := 8;
  Top := 43;
  Width := 222;
  Height := 14;
  TabOrder := 1;
  OnClick := rbFourClick;
 end;
 with rbThree do
 begin
  Left := 8;
  Top := 68;
  Width := 222;
  Height := 14;
  TabOrder := 2;
  OnClick := rbThreeClick;
 end;
 with rbTwo do
 begin
  Left := 8;
  Top := 94;
  Width := 222;
  Height := 14;
  TabOrder := 3;
  OnClick := rbTwoClick;
 end;
 with rbNotSure do
 begin
  Left := 8;
  Top := 120;
  Width := 222;
  Height := 14;
  TabOrder := 4;
  OnClick := rbNotSureClick;
 end;

 with pnlHelp do
 begin
  Align := alTop;
  BevelOuter := bvNone;
  Height := 73;
  TabOrder := 1;
 end;
 with lblHelp do
 begin
  WordWrap := True;
  Left := 20;
  Top := 6;
  Width := 560;
  Height := 64;
 end;

 with gbComment do
 begin
  Align := alClient;
  TabOrder := 2;
 end;
 with mComment do
 begin
  Left := 13;
  Top := 20;
  Width := 352;
  Height := 121;
  AutoSelect := False;
  BorderStyle := bsSingle;
  TabOrder := 0;
  TabStop := True;
 end;

 PlaceComponents;
 mComment.TextSource;
 if mComment.HasDocument then
  mComment.TextSource.DocumentContainer.DocumentLimits.BruttoCharLimit := c_TextCommentLen;
//#UC END# *4A8E8F2E0195_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.InitControls

procedure TPrimConsultationMarkForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  DSMark := nil;
 end//aNew = nil
 else
 begin
  Supports(aNew, IdsConsultationMark, DSMark);
 end;//aNew = nil
end;//TPrimConsultationMarkForm.SignalDataSourceChanged

procedure TPrimConsultationMarkForm.MakeControls;
begin
 inherited;
 with AddUsertype(utcmMainName,
  str_utcmMainCaption,
  str_utcmMainCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utcmMainName
 f_gbMark := TvtGroupBox.Create(Self);
 f_gbMark.Name := 'gbMark';
 f_gbMark.Parent := Self;
 f_gbMark.Caption := 'Оценка:';
 f_rbNotSure := TvtRadioButton.Create(Self);
 f_rbNotSure.Name := 'rbNotSure';
 f_rbNotSure.Parent := gbMark;
 f_rbNotSure.Caption := 'Затрудняюсь ответить (оценка 0)';
 f_rbTwo := TvtRadioButton.Create(Self);
 f_rbTwo.Name := 'rbTwo';
 f_rbTwo.Parent := gbMark;
 f_rbTwo.Caption := 'Плохо (оценка 2)';
 f_rbThree := TvtRadioButton.Create(Self);
 f_rbThree.Name := 'rbThree';
 f_rbThree.Parent := gbMark;
 f_rbThree.Caption := 'Удовлетворительно (оценка 3)';
 f_rbFour := TvtRadioButton.Create(Self);
 f_rbFour.Name := 'rbFour';
 f_rbFour.Parent := gbMark;
 f_rbFour.Caption := 'Хорошо (оценка 4)';
 f_rbFive := TvtRadioButton.Create(Self);
 f_rbFive.Name := 'rbFive';
 f_rbFive.Parent := gbMark;
 f_rbFive.Caption := 'Отлично (оценка 5)';
 f_pnlHelp := TvtPanel.Create(Self);
 f_pnlHelp.Name := 'pnlHelp';
 f_pnlHelp.Parent := Self;
 f_lblHelp := TvtLabel.Create(Self);
 f_lblHelp.Name := 'lblHelp';
 f_lblHelp.Parent := pnlHelp;
 f_lblHelp.Caption := 'Данное окно предназначено для внесения комментария к оценке представленной консультации. Если Вам необходимы дополнительные  разъяснения по сути предоставленного ответа, просьба внести отдельный запрос в карточку запроса «Правовая поддержка онлайн».';
 f_gbComment := TvtGroupBox.Create(Self);
 f_gbComment.Name := 'gbComment';
 f_gbComment.Parent := Self;
 f_gbComment.Caption := 'Комментарий к Вашей оценке:';
 f_mComment := TeeMemoWithEditOperations.Create(Self);
 f_mComment.Name := 'mComment';
 f_mComment.Parent := gbComment;
end;//TPrimConsultationMarkForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimConsultationMarkForm);
 {* Регистрация PrimConsultationMark }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
