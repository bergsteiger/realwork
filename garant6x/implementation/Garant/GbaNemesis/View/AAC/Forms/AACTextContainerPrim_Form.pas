unit AACTextContainerPrim_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/Forms/AACTextContainerPrim_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACTextContainerPrim
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
  afwInterfaces,
  Classes,
  evCustomEditorWindow
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  nevGUIInterfaces,
  vtPanel,
  vtLabel,
  l3StringIDEx,
  nscSimpleEditorForDialogs,
  AACContainerPrim_Form
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
  { Константы для ААК }
 LeftIndentDeltaForAACRight = 26;

type
 TAACTextContainerPrimForm = {form} class(TAACContainerPrimForm {$If not defined(DesignTimeLibrary)}, IafwStyleTableSpy{$IfEnd} //not DesignTimeLibrary
 )
 private
 // private fields
   f_EdWriteToUsBufferAlreadyAssigned : Boolean;
   f_InSetupWriteToUsEditor : Boolean;
   f_pnWriteToUs : TvtPanel;
    {* Поле для свойства pnWriteToUs}
   f_edWriteToUs : TnscSimpleEditorForDialogs;
    {* Поле для свойства edWriteToUs}
   f_pnSeeAlso : TvtPanel;
    {* Поле для свойства pnSeeAlso}
   f_lblSeeAlso : TvtLabel;
    {* Поле для свойства lblSeeAlso}
   f_pnLinkToContent : TvtPanel;
    {* Поле для свойства pnLinkToContent}
   f_pbLinkToContent : TPaintBox;
    {* Поле для свойства pbLinkToContent}
 protected
  procedure MakeControls; override;
 private
 // private methods
   procedure SetupWriteToUsEditor;
     {* Сигнатура метода SetupWriteToUsEditor }
   procedure LblLinkToContentClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure PbLinkToContentPaint(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure PnWriteToUsResize(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
 protected
 // realized methods
   {$If not defined(DesignTimeLibrary)}
   procedure StyleTableChanged;
     {* таблица стилей изменилась. }
   {$IfEnd} //not DesignTimeLibrary
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure DoSetJumpTo(aJumpTo: TevJumpToEvent); override;
 protected
 // protected methods
   procedure EdWriteToUsGetHotSpotInfo(Sender: TObject;
     const aHotSpot: IevHotSpot;
     const aKeys: TafwCursorState;
     var theInfo: TafwCursorInfo);
 public
 // public properties



   property pnWriteToUs: TvtPanel
     read f_pnWriteToUs;
   property edWriteToUs: TnscSimpleEditorForDialogs
     read f_edWriteToUs;
   property pnSeeAlso: TvtPanel
     read f_pnSeeAlso;
   property lblSeeAlso: TvtLabel
     read f_lblSeeAlso;
     {* См. также }


   property pnLinkToContent: TvtPanel
     read f_pnLinkToContent;
   property pbLinkToContent: TPaintBox
     read f_pbLinkToContent;
 end;//TAACTextContainerPrimForm

 TvcmContainerFormRef = TAACTextContainerPrimForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  bsHyperLinkProcessorPrim,
  vtPngImgList
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  ,
  Graphics,
  vtScrollBar
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsUtils,
  bsTypesNew,
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
   { Локализуемые строки Local }
  str_WriteToUsDoc : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WriteToUsDoc'; rValue : '{justification:ev_itCenter}'#$D#$A +
's#69. Есть предложения и пожелания? [Напишите нам|' +
'script:''http://www.garant.ru/company/about/feedback/?typemessage=offer&thememessage=eos&docid='' ' +
'контрол::Text textform:GetDocumentID IntToStr Cat ' +
'''&messageid=1&complect_id='' Cat GetEncryptedComplectId Cat browse]'#$D#$A +
'{/justification}');
   { '[justification:ev_itCenter]'#$D#$A +
's#69. Есть предложения и пожелания? [Напишите нам|' +
'script:''http://www.garant.ru/company/about/feedback/?typemessage=offer&thememessage=eos&docid='' ' +
'контрол::Text textform:GetDocumentID IntToStr Cat ' +
'''&messageid=1&complect_id='' Cat GetEncryptedComplectId Cat browse]'#$D#$A +
'[/justification]' }

// start class TAACTextContainerPrimForm

procedure TAACTextContainerPrimForm.SetupWriteToUsEditor;
//#UC START# *5006F8AA0374_500406E901E5_var*
//#UC END# *5006F8AA0374_500406E901E5_var*
begin
//#UC START# *5006F8AA0374_500406E901E5_impl*
 if f_InSetupWriteToUsEditor then Exit;
 f_InSetupWriteToUsEditor := True;
 try
  with edWriteToUs do
  begin
   SetBounds(LeftIndentDeltaForAACRight, 5, pnWriteToUs.ClientWidth - 2 * LeftIndentDeltaForAACRight + 15, 65); //  [$384075297]
                                                                                                     //^^ ~ширина скроллера
   if not f_EdWriteToUsBufferAlreadyAssigned then
   begin
    Buffer := str_WriteToUsDoc.AsWStr;
    f_EdWriteToUsBufferAlreadyAssigned := True;
   end;
   AdjustHeightByText;
   OnGetHotspotInfo := Self.EdWriteToUsGetHotSpotInfo;
  end;//with edWriteToUs
  with pnWriteToUs do
   SetBounds(Left, pnRightForScroll.ClientHeight - pnWriteToUs.Height, Width, edWriteToUs.Height + 20);
 finally
  f_InSetupWriteToUsEditor := False;
 end;
//#UC END# *5006F8AA0374_500406E901E5_impl*
end;//TAACTextContainerPrimForm.SetupWriteToUsEditor

procedure TAACTextContainerPrimForm.LblLinkToContentClick(Sender: TObject);
//#UC START# *502A7459031B_500406E901E5_var*
//#UC END# *502A7459031B_500406E901E5_var*
begin
//#UC START# *502A7459031B_500406E901E5_impl*
 //TbsHyperLinkProcessorPrim.RunScript('57970000 Открыть');
 nsOpenLink(57970000, 0, dptNone);
//#UC END# *502A7459031B_500406E901E5_impl*
end;//TAACTextContainerPrimForm.LblLinkToContentClick

procedure TAACTextContainerPrimForm.PbLinkToContentPaint(Sender: TObject);
//#UC START# *502B5F09037C_500406E901E5_var*
//#UC END# *502B5F09037C_500406E901E5_var*
begin
//#UC START# *502B5F09037C_500406E901E5_impl*
// pbLinkToContent.Canvas.Pen.Color := clRed;
// pbLinkToContent.Canvas.Rectangle(pbLinkToContent.Canvas.ClipRect);
 dmStdRes.AACImageList.DrawGlyphSpecified(0,
     pbLinkToContent.Canvas,
     dmStdRes.AACImageList.CurBPP,
     0, 0,
     True,
     False);

//#UC END# *502B5F09037C_500406E901E5_impl*
end;//TAACTextContainerPrimForm.PbLinkToContentPaint

procedure TAACTextContainerPrimForm.PnWriteToUsResize(Sender: TObject);
//#UC START# *50375C820252_500406E901E5_var*
//#UC END# *50375C820252_500406E901E5_var*
begin
//#UC START# *50375C820252_500406E901E5_impl*
 SetupWriteToUsEditor;
//#UC END# *50375C820252_500406E901E5_impl*
end;//TAACTextContainerPrimForm.PnWriteToUsResize

procedure TAACTextContainerPrimForm.EdWriteToUsGetHotSpotInfo(Sender: TObject;
  const aHotSpot: IevHotSpot;
  const aKeys: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *5049C7C0027F_500406E901E5_var*
//#UC END# *5049C7C0027F_500406E901E5_var*
begin
//#UC START# *5049C7C0027F_500406E901E5_impl*
 theInfo.rHint := nil; // не показываем хинт:  http://mdp.garant.ru/pages/viewpage.action?pageId=390583477
//#UC END# *5049C7C0027F_500406E901E5_impl*
end;//TAACTextContainerPrimForm.EdWriteToUsGetHotSpotInfo

{$If not defined(DesignTimeLibrary)}
procedure TAACTextContainerPrimForm.StyleTableChanged;
//#UC START# *467D2CB10135_500406E901E5_var*
//#UC END# *467D2CB10135_500406E901E5_var*
begin
//#UC START# *467D2CB10135_500406E901E5_impl*
 f_EdWriteToUsBufferAlreadyAssigned := False;
 SetupWriteToUsEditor;
//#UC END# *467D2CB10135_500406E901E5_impl*
end;//TAACTextContainerPrimForm.StyleTableChanged
{$IfEnd} //not DesignTimeLibrary

procedure TAACTextContainerPrimForm.Cleanup;
//#UC START# *479731C50290_500406E901E5_var*
//#UC END# *479731C50290_500406E901E5_var*
begin
//#UC START# *479731C50290_500406E901E5_impl*
 f_EdWriteToUsBufferAlreadyAssigned := False;
 f_InSetupWriteToUsEditor := False;
 EvDelStyleTableSpy(Self);
 inherited;
//#UC END# *479731C50290_500406E901E5_impl*
end;//TAACTextContainerPrimForm.Cleanup

{$If not defined(NoVCM)}
procedure TAACTextContainerPrimForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_500406E901E5_var*
//#UC END# *497469C90140_500406E901E5_var*
begin
//#UC START# *497469C90140_500406E901E5_impl*
 inherited;
 f_EdWriteToUsBufferAlreadyAssigned := False;
 if aNew <> nil then
  SetupWriteToUsEditor;
//#UC END# *497469C90140_500406E901E5_impl*
end;//TAACTextContainerPrimForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TAACTextContainerPrimForm.InitControls;
//#UC START# *4A8E8F2E0195_500406E901E5_var*
//#UC END# *4A8E8F2E0195_500406E901E5_var*
begin
//#UC START# *4A8E8F2E0195_500406E901E5_impl*
 with pnBack do
 begin
  BevelOuter := bvNone;
 end;
 with pnLeftForScroll do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with pbLinkToContent do
 begin
  SetBounds(0, 0, dmStdRes.AACImageList.Width, dmStdRes.AACImageList.Height);
         // ^ - http://mdp.garant.ru/pages/viewpage.action?pageId=474592908&focusedCommentId=476057993#comment-476057993
  OnPaint := PbLinkToContentPaint;
  OnClick := LblLinkToContentClick;
  Cursor := crHandPoint;
 end;
 with pnLinkToContent do
 begin
  Align := alTop;
  Height := dmStdRes.AACImageList.Height + 6;
  Color := clWhite;
  BevelOuter := bvNone;
 end;
 with pnSeeAlso do
 begin
  Align := alTop;
  Height := 30;
  BevelOuter := bvNone;
  Color := clWhite;
  Visible := False;
 end;
 with lblSeeAlso do
 begin
  Top := (pnSeeAlso.Height - Height) div 2;
  Left := LeftIndentDeltaForAACRight;
  Visible := False; ////// http://mdp.garant.ru/pages/viewpage.action?pageId=387088696
 end;
 inherited;
 with pnLeftEx do
 begin
  Width := Self.ClientWidth div 2;
//  SizeableSides := [szRight];
//  SplitterBevel := bvRaised;
  TabOrder := 0;
  Align := alLeft;
  BevelOuter := bvNone;
 end;//with pnLeftEx
 with pnRightEx do
 begin
  Width := Self.ClientWidth div 2;
  TabOrder := 1;
  Align := alClient;
  BevelOuter := bvNone;
 end;//with pnRightEx
 with pnLeft do
 begin
  BevelOuter := bvNone;
//  SizeableSides := [];
  Align := alClient;
 end;//with pnLeft
 with pnRightForScroll do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;//with pnRightForScroll
 with pnRight do
 begin
  BevelOuter := bvNone;
  Align := alClient;
 end;//with pnRight
 with pnWriteToUs do
 begin
  Align := alBottom;
  Height := 60;
  Color := clWhite;
  BevelOuter := bvNone;
  OnResize := PnWriteToUsResize;
 end;//with pnWriteToUs
 SetupWriteToUsEditor;
 EvAddStyleTableSpy(Self);
 with scrRight do
 begin
  Align := sbalRight;
  TabStop := False;
 end;//with scrRight
 with scrLeft do
 begin
  Align := sbalRight;
  TabStop := False;
 end;//with scrLeft
 pnlLeftTop.Visible := False;
 pnlRightTop.Visible := False;
//#UC END# *4A8E8F2E0195_500406E901E5_impl*
end;//TAACTextContainerPrimForm.InitControls
{$IfEnd} //not NoVCM

procedure TAACTextContainerPrimForm.DoSetJumpTo(aJumpTo: TevJumpToEvent);
//#UC START# *503CE3500038_500406E901E5_var*
//#UC END# *503CE3500038_500406E901E5_var*
begin
//#UC START# *503CE3500038_500406E901E5_impl*
 edWriteToUs.OnJumpTo := aJumpTo;
//#UC END# *503CE3500038_500406E901E5_impl*
end;//TAACTextContainerPrimForm.DoSetJumpTo

procedure TAACTextContainerPrimForm.MakeControls;
begin
 inherited;
 pnBack.Parent := Self;
 pnRightEx.Parent := pnBack;
 scrRight.Parent := pnRightEx;
 pnRightForScroll.Parent := pnRightEx;
 f_pnWriteToUs := TvtPanel.Create(Self);
 f_pnWriteToUs.Name := 'pnWriteToUs';
 f_pnWriteToUs.Parent := pnRightForScroll;
 f_edWriteToUs := TnscSimpleEditorForDialogs.Create(Self);
 f_edWriteToUs.Name := 'edWriteToUs';
 f_edWriteToUs.Parent := pnWriteToUs;
 pnRight.Parent := pnRightForScroll;
 f_pnSeeAlso := TvtPanel.Create(Self);
 f_pnSeeAlso.Name := 'pnSeeAlso';
 f_pnSeeAlso.Parent := pnRightForScroll;
 f_lblSeeAlso := TvtLabel.Create(Self);
 f_lblSeeAlso.Name := 'lblSeeAlso';
 f_lblSeeAlso.Parent := pnSeeAlso;
 f_lblSeeAlso.Caption := 'См. также';
 pnLeftEx.Parent := pnBack;
 scrLeft.Parent := pnLeftEx;
 pnLeftForScroll.Parent := pnLeftEx;
 f_pnLinkToContent := TvtPanel.Create(Self);
 f_pnLinkToContent.Name := 'pnLinkToContent';
 f_pnLinkToContent.Parent := pnLeftForScroll;
 f_pbLinkToContent := TPaintBox.Create(Self);
 f_pbLinkToContent.Name := 'pbLinkToContent';
 f_pbLinkToContent.Parent := pnLinkToContent;
 pnLeft.Parent := pnLeftForScroll;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_WriteToUsDoc
 str_WriteToUsDoc.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACTextContainerPrim
 TtfwClassRef.Register(TAACTextContainerPrimForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.