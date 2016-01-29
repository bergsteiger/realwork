unit PrimConsultationMark_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Consultation/Forms/PrimConsultationMark_Form.pas"
// Начат: 27.01.2009 13:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Пользовательские сервисы::Consultation::View::Consultation::PrimConsultationMark
//
// Оценка консультации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes,
  bsTypes
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtPanel,
  ConsultationDomainInterfaces,
  eeMemoWithEditOperations,
  vtGroupBox,
  vtLabel,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vtRadioButton,
  PrimConsultationMark_utcmMain_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
  { Constants }
 c_TextCommentLen = 6000;

type
 TPrimConsultationMarkForm = {form} class(TvcmEntityForm)
  {* Оценка консультации }
 private
 // private fields
   f_gbMark : TvtGroupBox;
    {* Поле для свойства gbMark}
   f_rbNotSure : TvtRadioButton;
    {* Поле для свойства rbNotSure}
   f_rbTwo : TvtRadioButton;
    {* Поле для свойства rbTwo}
   f_rbThree : TvtRadioButton;
    {* Поле для свойства rbThree}
   f_rbFour : TvtRadioButton;
    {* Поле для свойства rbFour}
   f_rbFive : TvtRadioButton;
    {* Поле для свойства rbFive}
   f_pnlHelp : TvtPanel;
    {* Поле для свойства pnlHelp}
   f_lblHelp : TvtLabel;
    {* Поле для свойства lblHelp}
   f_gbComment : TvtGroupBox;
    {* Поле для свойства gbComment}
   f_mComment : TeeMemoWithEditOperations;
    {* Поле для свойства mComment}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure MakeControls; override;
 private
 // private methods
   procedure RbNotSureClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure RbFiveClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure RbFourClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure RbThreeClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure RbTwoClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure PlaceComponents;
     {* Сигнатура метода PlaceComponents }
   procedure ChangeMark(aMark: TbsConsultationMark);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   DSMark : IdsConsultationMark;
    {* Оценка консультации}
 public
 // public properties
   property gbMark: TvtGroupBox
     read f_gbMark;
     {* Оценка: }
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
   property pnlHelp: TvtPanel
     read f_pnlHelp;
   property lblHelp: TvtLabel
     read f_lblHelp;
     {* Данное окно предназначено для внесения комментария к оценке представленной консультации. Если Вам необходимы дополнительные  разъяснения по сути предоставленного ответа, просьба внести отдельный запрос в карточку запроса «Правовая поддержка онлайн». }
   property gbComment: TvtGroupBox
     read f_gbComment;
     {* Комментарий к Вашей оценке: }
   property mComment: TeeMemoWithEditOperations
     read f_mComment;
 end;//TPrimConsultationMarkForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  Types,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utcmMainLocalConstants }
  str_utcmMainCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utcmMainCaption'; rValue : 'Оценка ответа');
   { Заголовок пользовательского типа "Оценка ответа" }

// start class TPrimConsultationMarkForm

procedure TPrimConsultationMarkForm.RbNotSureClick(Sender: TObject);
//#UC START# *5176B3D003B4_497EDC5003D1_var*
//#UC END# *5176B3D003B4_497EDC5003D1_var*
begin
//#UC START# *5176B3D003B4_497EDC5003D1_impl*
 ChangeMark(bs_cmNotSure);
//#UC END# *5176B3D003B4_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.RbNotSureClick

procedure TPrimConsultationMarkForm.RbFiveClick(Sender: TObject);
//#UC START# *5176B3E200C1_497EDC5003D1_var*
//#UC END# *5176B3E200C1_497EDC5003D1_var*
begin
//#UC START# *5176B3E200C1_497EDC5003D1_impl*
 ChangeMark(bs_cmFive);
//#UC END# *5176B3E200C1_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.RbFiveClick

procedure TPrimConsultationMarkForm.RbFourClick(Sender: TObject);
//#UC START# *5176B3F200F4_497EDC5003D1_var*
//#UC END# *5176B3F200F4_497EDC5003D1_var*
begin
//#UC START# *5176B3F200F4_497EDC5003D1_impl*
 ChangeMark(bs_cmFour);
//#UC END# *5176B3F200F4_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.RbFourClick

procedure TPrimConsultationMarkForm.RbThreeClick(Sender: TObject);
//#UC START# *5176B3FD0292_497EDC5003D1_var*
//#UC END# *5176B3FD0292_497EDC5003D1_var*
begin
//#UC START# *5176B3FD0292_497EDC5003D1_impl*
 ChangeMark(bs_cmThree);
//#UC END# *5176B3FD0292_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.RbThreeClick

procedure TPrimConsultationMarkForm.RbTwoClick(Sender: TObject);
//#UC START# *5176B4060002_497EDC5003D1_var*
//#UC END# *5176B4060002_497EDC5003D1_var*
begin
//#UC START# *5176B4060002_497EDC5003D1_impl*
 ChangeMark(bs_cmTwo);
//#UC END# *5176B4060002_497EDC5003D1_impl*
end;//TPrimConsultationMarkForm.RbTwoClick

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

{$If not defined(NoVCM)}
procedure TPrimConsultationMarkForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimConsultationMarkForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  DSMark := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsConsultationMark, DSMark);
 end;//aDsNew = nil
end;

procedure TPrimConsultationMarkForm.MakeControls;
begin
 inherited;
 with AddUsertype(utcmMainName,
  str_utcmMainCaption,
  str_utcmMainCaption,
  false,
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
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utcmMainCaption
 str_utcmMainCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimConsultationMark
 TtfwClassRef.Register(TPrimConsultationMarkForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.