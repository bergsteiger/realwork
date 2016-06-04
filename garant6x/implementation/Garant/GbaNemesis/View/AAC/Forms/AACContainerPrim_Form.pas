unit AACContainerPrim_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "AACContainerPrim" MUID: (4FF2E935019A)
// Имя типа: "TAACContainerPrimForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Base_Operations_AAC_Controls
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , vtProportionalPanel
 , vtScrollBar
 , vtPanel
 , vtSizeablePanel
 , evCustomEditorWindow
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TAACContainerPrimForm = class({$If NOT Defined(NoVCM)}
 TvcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_TabCaption: IvcmCString;
   f_pnBack: TvtProportionalPanel;
   f_pnRightEx: TvtPanel;
   f_pnRightForScroll: TvtPanel;
   f_pnRight: TvtPanel;
   f_pnlRightTop: TvtPanel;
   f_scrRight: TvtScrollBar;
   f_pnLeftEx: TvtSizeablePanel;
   f_pnLeftForScroll: TvtPanel;
   f_pnlLeftTop: TvtPanel;
   f_pnLeft: TvtPanel;
   f_scrLeft: TvtScrollBar;
  protected
   function DoGetVScrollBar(aLeft: Boolean): TvtScrollBar; virtual;
   procedure DoSetJumpTo(aJumpTo: TevJumpToEvent); virtual;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetTabCaption(const aTabCaption: IvcmCString); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function AACTextContainer_GetVScrollBar_Execute(aLeft: Boolean): TvtScrollBar;
   procedure AACTextContainer_GetVScrollBar(const aParams: IvcmExecuteParams);
   procedure AACTextContainer_SetJumpTo_Execute(aJumpTo: TevJumpToEvent);
   procedure AACTextContainer_SetJumpTo(const aParams: IvcmExecuteParams);
  public
   property pnBack: TvtProportionalPanel
    read f_pnBack;
   property pnRightEx: TvtPanel
    read f_pnRightEx;
   property pnRightForScroll: TvtPanel
    read f_pnRightForScroll;
   property pnRight: TvtPanel
    read f_pnRight;
   property pnlRightTop: TvtPanel
    read f_pnlRightTop;
   property scrRight: TvtScrollBar
    read f_scrRight;
   property pnLeftEx: TvtSizeablePanel
    read f_pnLeftEx;
   property pnLeftForScroll: TvtPanel
    read f_pnLeftForScroll;
   property pnlLeftTop: TvtPanel
    read f_pnlLeftTop;
   property pnLeft: TvtPanel
    read f_pnLeft;
   property scrLeft: TvtScrollBar
    read f_scrLeft;
 end;//TAACContainerPrimForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsConst
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , AACContainerPrim_AACContainer_UserType
 , AACContainerPrim_AACContentsContainer_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4FF2E935019Aimpl_uses*
 //#UC END# *4FF2E935019Aimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TAACContainerPrimForm.DoGetVScrollBar(aLeft: Boolean): TvtScrollBar;
//#UC START# *503CE2E2021B_4FF2E935019A_var*
//#UC END# *503CE2E2021B_4FF2E935019A_var*
begin
//#UC START# *503CE2E2021B_4FF2E935019A_impl*
 if aLeft
  then Result := scrLeft
  else Result := scrRight;
//#UC END# *503CE2E2021B_4FF2E935019A_impl*
end;//TAACContainerPrimForm.DoGetVScrollBar

procedure TAACContainerPrimForm.DoSetJumpTo(aJumpTo: TevJumpToEvent);
//#UC START# *503CE3500038_4FF2E935019A_var*
//#UC END# *503CE3500038_4FF2E935019A_var*
begin
//#UC START# *503CE3500038_4FF2E935019A_impl*
 Assert(False, 'Мы сюда не должны были прийти');
//#UC END# *503CE3500038_4FF2E935019A_impl*
end;//TAACContainerPrimForm.DoSetJumpTo

function TAACContainerPrimForm.AACTextContainer_GetVScrollBar_Execute(aLeft: Boolean): TvtScrollBar;
//#UC START# *5005237D0210_4FF2E935019Aexec_var*
//#UC END# *5005237D0210_4FF2E935019Aexec_var*
begin
//#UC START# *5005237D0210_4FF2E935019Aexec_impl*
 Result := DoGetVScrollBar(aLeft);
//#UC END# *5005237D0210_4FF2E935019Aexec_impl*
end;//TAACContainerPrimForm.AACTextContainer_GetVScrollBar_Execute

procedure TAACContainerPrimForm.AACTextContainer_GetVScrollBar(const aParams: IvcmExecuteParams);
begin
 with IAACTextContainer_GetVScrollBar_Params(aParams.Data) do
  ResultValue := Self.AACTextContainer_GetVScrollBar_Execute(Left);
end;//TAACContainerPrimForm.AACTextContainer_GetVScrollBar

procedure TAACContainerPrimForm.AACTextContainer_SetJumpTo_Execute(aJumpTo: TevJumpToEvent);
//#UC START# *5006ED2300F9_4FF2E935019Aexec_var*
//#UC END# *5006ED2300F9_4FF2E935019Aexec_var*
begin
//#UC START# *5006ED2300F9_4FF2E935019Aexec_impl*
 DoSetJumpTo(aJumpTo);
//#UC END# *5006ED2300F9_4FF2E935019Aexec_impl*
end;//TAACContainerPrimForm.AACTextContainer_SetJumpTo_Execute

procedure TAACContainerPrimForm.AACTextContainer_SetJumpTo(const aParams: IvcmExecuteParams);
begin
 with IAACTextContainer_SetJumpTo_Params(aParams.Data) do
  Self.AACTextContainer_SetJumpTo_Execute(JumpTo);
end;//TAACContainerPrimForm.AACTextContainer_SetJumpTo

procedure TAACContainerPrimForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4FF2E935019A_var*
//#UC END# *4A8E8F2E0195_4FF2E935019A_var*
begin
//#UC START# *4A8E8F2E0195_4FF2E935019A_impl*
 with pnBack do
 begin
  BevelOuter := bvNone;
 end;
 with pnLeftEx do
 begin
  Width := Self.ClientWidth div 2;
  SizeableSides := [szRight];
  SplitterBevel := bvRaised;
  TabOrder := 0;
  Align := alLeft;
  BevelOuter := bvNone;
  Constraints.MinWidth := 200;
  OuterConstraints.MinWidth := 200;
 end;
 with scrLeft do
  Align := sbalRight;
 with pnLeftForScroll do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with pnLeft do
 begin
  TabOrder := 0;
  Align := alClient;
  BevelOuter := bvNone;
 end;//with pnLeft
 with pnlLeftTop do
 begin
  Align := alTop;   // http://mdp.garant.ru/pages/viewpage.action?pageId=388860126
  Height := 50; // http://mdp.garant.ru/pages/viewpage.action?pageId=602009846
  Color := cAACContentsBackColor;
  BevelOuter := bvNone;
 end;
 with pnRightEx do
 begin
  Width := Self.ClientWidth div 2;
  TabOrder := 1;
  Align := alClient;
  BevelOuter := bvNone;
  //Constraints.MinWidth := 200;
 end;
 with scrRight do
  Align := sbalRight;
 with pnRightForScroll do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with pnRight do
 begin
  Width := Self.ClientWidth div 2;
  TabOrder := 0;
  Align := alClient;
  BevelOuter := bvNone;
 end;//with pnRight
 with pnlRightTop do
 begin
  Align := alTop;   // http://mdp.garant.ru/pages/viewpage.action?pageId=388860126
  Height := 30; // http://mdp.garant.ru/pages/viewpage.action?pageId=602009846&focusedCommentId=605156996#comment-605156996
  Color := $00FFFFFF; // clWhite
  BevelOuter := bvNone;
 end;
 Self.ActiveControl := pnRight;
 inherited;
//#UC END# *4A8E8F2E0195_4FF2E935019A_impl*
end;//TAACContainerPrimForm.InitControls

function TAACContainerPrimForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4FF2E935019A_var*
//#UC END# *53F1C6EF02C9_4FF2E935019A_var*
begin
//#UC START# *53F1C6EF02C9_4FF2E935019A_impl*
 Result := f_TabCaption;
//#UC END# *53F1C6EF02C9_4FF2E935019A_impl*
end;//TAACContainerPrimForm.DoGetTabCaption

procedure TAACContainerPrimForm.SetTabCaption(const aTabCaption: IvcmCString);
//#UC START# *542A6DA20026_4FF2E935019A_var*
var
 l_Caption: IvcmCString;
//#UC END# *542A6DA20026_4FF2E935019A_var*
begin
//#UC START# *542A6DA20026_4FF2E935019A_impl*
 f_TabCaption := aTabCaption;
 NotifyContainerCaptionChanged;
 // - Костыли
 // http://mdp.garant.ru/pages/viewpage.action?pageId=565492823
//#UC END# *542A6DA20026_4FF2E935019A_impl*
end;//TAACContainerPrimForm.SetTabCaption

procedure TAACContainerPrimForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_AACTextContainer, nil);
  PublishOpWithResult(en_AACTextContainer, op_GetVScrollBar, AACTextContainer_GetVScrollBar, nil, nil);
  PublishOpWithResult(en_AACTextContainer, op_SetJumpTo, AACTextContainer_SetJumpTo, nil, nil);
 end;//with Entities.Entities
end;//TAACContainerPrimForm.InitEntities

procedure TAACContainerPrimForm.MakeControls;
begin
 inherited;
 with AddUsertype(AACContainerName,
  str_AACContainerCaption,
  str_AACContainerCaption,
  True,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(AACContainerName
 with AddUsertype(AACContentsContainerName,
  str_AACContentsContainerCaption,
  str_AACContentsContainerCaption,
  True,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(AACContentsContainerName
 f_pnBack := TvtProportionalPanel.Create(Self);
 f_pnBack.Name := 'pnBack';
 f_pnBack.Parent := Self;
 f_pnRightEx := TvtPanel.Create(Self);
 f_pnRightEx.Name := 'pnRightEx';
 f_pnRightEx.Parent := pnBack;
 f_pnRightForScroll := TvtPanel.Create(Self);
 f_pnRightForScroll.Name := 'pnRightForScroll';
 f_pnRightForScroll.Parent := pnRightEx;
 f_pnRight := TvtPanel.Create(Self);
 f_pnRight.Name := 'pnRight';
 f_pnRight.Parent := pnRightForScroll;
 with DefineZone(vcm_ztMain, pnRight) do
 begin
 end;//with DefineZone(vcm_ztMain
 f_pnlRightTop := TvtPanel.Create(Self);
 f_pnlRightTop.Name := 'pnlRightTop';
 f_pnlRightTop.Parent := pnRightForScroll;
 f_scrRight := TvtScrollBar.Create(Self);
 f_scrRight.Name := 'scrRight';
 f_scrRight.Parent := pnRightEx;
 f_pnLeftEx := TvtSizeablePanel.Create(Self);
 f_pnLeftEx.Name := 'pnLeftEx';
 f_pnLeftEx.Parent := pnBack;
 f_pnLeftForScroll := TvtPanel.Create(Self);
 f_pnLeftForScroll.Name := 'pnLeftForScroll';
 f_pnLeftForScroll.Parent := pnLeftEx;
 f_pnlLeftTop := TvtPanel.Create(Self);
 f_pnlLeftTop.Name := 'pnlLeftTop';
 f_pnlLeftTop.Parent := pnLeftForScroll;
 f_pnLeft := TvtPanel.Create(Self);
 f_pnLeft.Name := 'pnLeft';
 f_pnLeft.Parent := pnLeftForScroll;
 with DefineZone(vcm_ztChild, pnLeft) do
 begin
 end;//with DefineZone(vcm_ztChild
 f_scrLeft := TvtScrollBar.Create(Self);
 f_scrLeft.Name := 'scrLeft';
 f_scrLeft.Parent := pnLeftEx;
end;//TAACContainerPrimForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAACContainerPrimForm);
 {* Регистрация AACContainerPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
