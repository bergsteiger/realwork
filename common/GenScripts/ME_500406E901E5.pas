unit AACTextContainerPrim_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACTextContainerPrim_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACContainerPrim_Form
 , afwInterfaces
 , vtPanel
 , nscSimpleEditorForDialogs
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , nevGUIInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
 , l3StringIDEx
;

const
 LeftIndentDeltaForAACRight = 26;

type
 TAACTextContainerPrimForm = class(TAACContainerPrimForm{$If NOT Defined(DesignTimeLibrary)}
 , IafwStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 )
  private
   f_EdWriteToUsBufferAlreadyAssigned: Boolean;
   f_InSetupWriteToUsEditor: Boolean;
   f_pnWriteToUs: TvtPanel;
    {* Поле для свойства pnWriteToUs }
   f_edWriteToUs: TnscSimpleEditorForDialogs;
    {* Поле для свойства edWriteToUs }
   f_pnSeeAlso: TvtPanel;
    {* Поле для свойства pnSeeAlso }
   f_lblSeeAlso: TvtLabel;
    {* Поле для свойства lblSeeAlso }
   f_pnLinkToContent: TvtPanel;
    {* Поле для свойства pnLinkToContent }
   f_pbLinkToContent: TPaintBox;
    {* Поле для свойства pbLinkToContent }
  private
   procedure SetupWriteToUsEditor;
   procedure lblLinkToContentClick(Sender: TObject);
   procedure pbLinkToContentPaint(Sender: TObject);
   procedure pnWriteToUsResize(Sender: TObject);
  protected
   procedure edWriteToUsGetHotSpotInfo(Sender: TObject;
    const aHotSpot: IevHotSpot;
    const aKeys: TafwCursorState;
    var theInfo: TafwCursorInfo);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure StyleTableChanged;
    {* таблица стилей изменилась. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoSetJumpTo(aJumpTo: TevJumpToEvent); override;
 end;//TAACTextContainerPrimForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , Classes
 , Graphics
 , vtScrollBar
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , bsTypesNew
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
 , bsHyperLinkProcessorPrim
 , vtPngImgList
;

const
 {* Локализуемые строки Local }
 str_WriteToUsDoc: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WriteToUsDoc'; rValue : '{justification:ev_itCenter}'#$D#$A +
's#69. Есть предложения и пожелания? [Напишите нам|' +
'script:''http://www.garant.ru/company/about/feedback/?typemessage=offer&thememessage=eos&docid='' ' +
'контрол::Text textform:GetDocumentID IntToStr Cat ' +
'''&messageid=1&complect_id='' Cat GetEncryptedComplectId Cat browse]'#$D#$A +
'{/justification}');
  {* '[justification:ev_itCenter]'#$D#$A +
's#69. Есть предложения и пожелания? [Напишите нам|' +
'script:''http://www.garant.ru/company/about/feedback/?typemessage=offer&thememessage=eos&docid='' ' +
'контрол::Text textform:GetDocumentID IntToStr Cat ' +
'''&messageid=1&complect_id='' Cat GetEncryptedComplectId Cat browse]'#$D#$A +
'[/justification]' }

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

procedure TAACTextContainerPrimForm.lblLinkToContentClick(Sender: TObject);
//#UC START# *502A7459031B_500406E901E5_var*
//#UC END# *502A7459031B_500406E901E5_var*
begin
//#UC START# *502A7459031B_500406E901E5_impl*
 //TbsHyperLinkProcessorPrim.RunScript('57970000 Открыть');
 nsOpenLink(57970000, 0, dptNone);
//#UC END# *502A7459031B_500406E901E5_impl*
end;//TAACTextContainerPrimForm.lblLinkToContentClick

procedure TAACTextContainerPrimForm.pbLinkToContentPaint(Sender: TObject);
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
end;//TAACTextContainerPrimForm.pbLinkToContentPaint

procedure TAACTextContainerPrimForm.pnWriteToUsResize(Sender: TObject);
//#UC START# *50375C820252_500406E901E5_var*
//#UC END# *50375C820252_500406E901E5_var*
begin
//#UC START# *50375C820252_500406E901E5_impl*
 SetupWriteToUsEditor;
//#UC END# *50375C820252_500406E901E5_impl*
end;//TAACTextContainerPrimForm.pnWriteToUsResize

procedure TAACTextContainerPrimForm.edWriteToUsGetHotSpotInfo(Sender: TObject;
 const aHotSpot: IevHotSpot;
 const aKeys: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *5049C7C0027F_500406E901E5_var*
//#UC END# *5049C7C0027F_500406E901E5_var*
begin
//#UC START# *5049C7C0027F_500406E901E5_impl*
 theInfo.rHint := nil; // не показываем хинт:  http://mdp.garant.ru/pages/viewpage.action?pageId=390583477
//#UC END# *5049C7C0027F_500406E901E5_impl*
end;//TAACTextContainerPrimForm.edWriteToUsGetHotSpotInfo

{$If NOT Defined(DesignTimeLibrary)}
procedure TAACTextContainerPrimForm.StyleTableChanged;
 {* таблица стилей изменилась. }
//#UC START# *467D2CB10135_500406E901E5_var*
//#UC END# *467D2CB10135_500406E901E5_var*
begin
//#UC START# *467D2CB10135_500406E901E5_impl*
 f_EdWriteToUsBufferAlreadyAssigned := False;
 SetupWriteToUsEditor;
//#UC END# *467D2CB10135_500406E901E5_impl*
end;//TAACTextContainerPrimForm.StyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TAACTextContainerPrimForm.Cleanup;
 {* Функция очистки полей объекта. }
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

{$If NOT Defined(NoVCM)}
procedure TAACTextContainerPrimForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TAACTextContainerPrimForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

procedure TAACTextContainerPrimForm.DoSetJumpTo(aJumpTo: TevJumpToEvent);
//#UC START# *503CE3500038_500406E901E5_var*
//#UC END# *503CE3500038_500406E901E5_var*
begin
//#UC START# *503CE3500038_500406E901E5_impl*
 edWriteToUs.OnJumpTo := aJumpTo;
//#UC END# *503CE3500038_500406E901E5_impl*
end;//TAACTextContainerPrimForm.DoSetJumpTo

initialization
 str_WriteToUsDoc.Init;
 {* Инициализация str_WriteToUsDoc }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAACTextContainerPrimForm);
 {* Регистрация AACTextContainerPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
