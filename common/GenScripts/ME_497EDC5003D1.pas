unit PrimConsultationMark_Form;
 {* Оценка консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMark_Form.pas"
// Стереотип: "VCMForm"

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
 , vtRadioButton
 , vtPanel
 , vtLabel
 , eeMemoWithEditOperations
 , bsTypes
;

const
 c_TextCommentLen = 6000;

type
 TPrimConsultationMarkForm = class(TvcmEntityForm)
  {* Оценка консультации }
  private
   f_gbMark: TvtGroupBox;
    {* Поле для свойства gbMark }
   f_rbNotSure: TvtRadioButton;
    {* Поле для свойства rbNotSure }
   f_rbTwo: TvtRadioButton;
    {* Поле для свойства rbTwo }
   f_rbThree: TvtRadioButton;
    {* Поле для свойства rbThree }
   f_rbFour: TvtRadioButton;
    {* Поле для свойства rbFour }
   f_rbFive: TvtRadioButton;
    {* Поле для свойства rbFive }
   f_pnlHelp: TvtPanel;
    {* Поле для свойства pnlHelp }
   f_lblHelp: TvtLabel;
    {* Поле для свойства lblHelp }
   f_gbComment: TvtGroupBox;
    {* Поле для свойства gbComment }
   f_mComment: TeeMemoWithEditOperations;
    {* Поле для свойства mComment }
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
  public
   property gbMark: TvtGroupBox
    read f_gbMark;
    {* Оценка: }
   property pnlHelp: TvtPanel
    read f_pnlHelp;
   property gbComment: TvtGroupBox
    read f_gbComment;
    {* Комментарий к Вашей оценке: }
 end;//TPrimConsultationMarkForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utcmMainLocalConstants }
 str_utcmMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utcmMainCaption'; rValue : 'Оценка ответа');
  {* Заголовок пользовательского типа "Оценка ответа" }

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

initialization
 str_utcmMainCaption.Init;
 {* Инициализация str_utcmMainCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimConsultationMarkForm);
 {* Регистрация PrimConsultationMark }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
