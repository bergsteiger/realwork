unit vtPopupForm;

// ћодуль: "w:\common\components\gui\Garant\VT\vtPopupForm.pas"
// —тереотип: "GuiControl"
// Ёлемент модели: "TvtPopupForm" MUID: (4D90583503C2)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vg_scene
 , vg_controls
 , vg_layouts
 , Classes
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , Types
;

type
 TvtTailPosition = (
  vtTailTop
  , vtTailLeft
  , vtTailBottom
  , vtTailRight
 );//TvtTailPosition

 TvtCurrentBounds = array [TvtTailPosition] of TRect;

 TvtPopupForm = class(TCustomForm)
  private
   f_Scene: TvgScene;
   f_Background: TvgBackground;
   f_CalloutPanel: TvgCalloutPanel;
   f_CloseButton: TvgCloseButton;
   f_NonVGLayout: TvgNonVGLayout;
   f_CurrentBounds: TvtCurrentBounds;
   f_AfterBaloonHidden: TNotifyEvent;
   f_TailPosition: TvtTailPosition;
   f_Panel: TvtPanel;
  private
   procedure PanelGetSiteInfo(Sender: TObject;
    DockClient: TControl;
    var InfluenceRect: TRect;
    MousePos: TPoint;
    var CanDock: Boolean);
   procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
  protected
   procedure pm_SetTailPosition(aValue: TvtTailPosition);
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   class procedure AdjustBalloonSize(const a_TailPosition: TvtTailPosition;
    a_FontSize: Integer;
    a_WidthIn: Integer;
    a_HeightIn: Integer;
    out a_WidthOut: Integer;
    out a_HeightOut: Integer);
    {* ѕо ширине и высоте вдоченного редактора высчитываем ширину и высоту всего баллона. }
   {$If NOT Defined(NoVCL)}
   constructor CreateNew(AOwner: TComponent;
    Dummy: Integer = 0); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property AfterBaloonHidden: TNotifyEvent
    read f_AfterBaloonHidden
    write f_AfterBaloonHidden;
   property TailPosition: TvtTailPosition
    read f_TailPosition
    write pm_SetTailPosition;
   property Panel: TvtPanel
    read f_Panel;
 end;//TvtPopupForm
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , l3Defaults
 , vg_objects
 , Windows
 , afwFacade
 , vgTypes
 , vtVGSceneRes
 {$If NOT Defined(NoVCM)}
 , vcmDockTree
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCL)}
type
 THackWinControl = class(TWinControl)
 end;//THackWinControl

const
 cIndentHMul = 0.2;
  {* отступы от краев по горизонтали }
 cIndentTopMul = 1.0;
  {* отступ от верхнего кра€ }
 cIndentBottomMul = 1.0;
  {* отступ от нижнего кра€ }
 cTailMul = 1.5;
  {* длина хвостика }
 cBtnWidthMul = 1.4;
  {* ширина-высота кнопки }
 cBtnIndentMul = 0.5;
  {* отступ кнопки от кра€ }

procedure TvtPopupForm.pm_SetTailPosition(aValue: TvtTailPosition);
//#UC START# *4FC768990140_4D90583503C2set_var*
//#UC END# *4FC768990140_4D90583503C2set_var*
begin
//#UC START# *4FC768990140_4D90583503C2set_impl*
 if (f_CalloutPanel <> nil) and (f_TailPosition <> aValue) then
 begin
  f_TailPosition := aValue;
  case f_TailPosition of
    vtTailTop    : f_CalloutPanel.CalloutPosition := vgCalloutTop;
    vtTailLeft   : f_CalloutPanel.CalloutPosition := vgCalloutLeft;
    vtTailBottom : f_CalloutPanel.CalloutPosition := vgCalloutBottom;
    vtTailRight  : f_CalloutPanel.CalloutPosition := vgCalloutRight;
  end;
  with f_CurrentBounds[f_TailPosition] do
   SetBounds(Left, Top, Right, Bottom);
 end;
//#UC END# *4FC768990140_4D90583503C2set_impl*
end;//TvtPopupForm.pm_SetTailPosition

class procedure TvtPopupForm.AdjustBalloonSize(const a_TailPosition: TvtTailPosition;
 a_FontSize: Integer;
 a_WidthIn: Integer;
 a_HeightIn: Integer;
 out a_WidthOut: Integer;
 out a_HeightOut: Integer);
 {* ѕо ширине и высоте вдоченного редактора высчитываем ширину и высоту всего баллона. }
//#UC START# *4FC7711F014B_4D90583503C2_var*
//#UC END# *4FC7711F014B_4D90583503C2_var*
begin
//#UC START# *4FC7711F014B_4D90583503C2_impl*
 a_WidthOut  := a_WidthIn;
 a_HeightOut := a_HeightIn;
 case a_TailPosition of
  vtTailLeft,
  vtTailRight:
   begin
    Inc(a_WidthOut, Round(a_FontSize * (cTailMul + cBtnWidthMul + cIndentHMul * 2 + cBtnIndentMul * 3)));
    Inc(a_HeightOut, Round(a_FontSize * (cIndentTopMul + cIndentBottomMul)));
   end;
  vtTailTop,
  vtTailBottom:
   begin
    Inc(a_WidthOut, Round(a_FontSize * (cBtnWidthMul + cIndentHMul * 2 + cBtnIndentMul * 3)));
    Inc(a_HeightOut, Round(a_FontSize * (cTailMul + cIndentTopMul + cIndentBottomMul)));
   end;
 end;
 //Inc(a_WidthOut, 10);
//#UC END# *4FC7711F014B_4D90583503C2_impl*
end;//TvtPopupForm.AdjustBalloonSize

procedure TvtPopupForm.PanelGetSiteInfo(Sender: TObject;
 DockClient: TControl;
 var InfluenceRect: TRect;
 MousePos: TPoint;
 var CanDock: Boolean);
//#UC START# *4FC87D8002D6_4D90583503C2_var*
//#UC END# *4FC87D8002D6_4D90583503C2_var*
begin
//#UC START# *4FC87D8002D6_4D90583503C2_impl*
 CanDock := false;
//#UC END# *4FC87D8002D6_4D90583503C2_impl*
end;//TvtPopupForm.PanelGetSiteInfo

procedure TvtPopupForm.CMVisibleChanged(var Message: TMessage);
//#UC START# *4FC7694303B7_4D90583503C2_var*
//#UC END# *4FC7694303B7_4D90583503C2_var*
begin
//#UC START# *4FC7694303B7_4D90583503C2_impl*
 inherited;
 if not Visible then
  if Assigned(f_AfterBaloonHidden) then
   f_AfterBaloonHidden(Self);

 // костыль дл€ http://mdp.garant.ru/pages/viewpage.action?pageId=326773126
 if Visible then
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
//#UC END# *4FC7694303B7_4D90583503C2_impl*
end;//TvtPopupForm.CMVisibleChanged

procedure TvtPopupForm.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4D90583503C2_var*
//#UC END# *48C7925A02E5_4D90583503C2_var*
begin
//#UC START# *48C7925A02E5_4D90583503C2_impl*
 inherited;
 {$IfDef vtLayeredFormIsForm}
 Params.ExStyle := Params.ExStyle and not(WS_EX_APPWINDOW) or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
 {$EndIf vtLayeredFormIsForm}
//#UC END# *48C7925A02E5_4D90583503C2_impl*
end;//TvtPopupForm.CreateParams

procedure TvtPopupForm.SetBounds(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer);
//#UC START# *4F2A599E0283_4D90583503C2_var*
var
 l_FontSize: Integer;
//#UC END# *4F2A599E0283_4D90583503C2_var*
begin
//#UC START# *4F2A599E0283_4D90583503C2_impl*
 // сохран€ем Bounds до корректировки
 f_CurrentBounds[f_TailPosition] := Rect(ALeft, ATop, AWidth, AHeight);

 Inc(afwFacade.g_DisableMessageHook);
 try
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if (f_Scene <> nil) then
  begin
   l_FontSize := Abs(f_Panel.Font.Size);
   f_Scene.RealignRoot;
   with f_CalloutPanel do
   begin
    CalloutWidth  := l_FontSize * cTailMul;
    CalloutLength := l_FontSize * cTailMul;
   end;//with f_CalloutPanel
   with f_NonVGLayout do
   begin
    case (f_TailPosition) of
      vtTailLeft,
      vtTailRight  :
       begin
        if f_TailPosition = vtTailLeft then
         Position.X := l_FontSize * (cIndentHMul + cTailMul)
        else
         Position.X := l_FontSize * cIndentHMul;
        Position.Y := l_FontSize * cIndentTopMul;
        Width  := f_CalloutPanel.Width  - l_FontSize * (cTailMul + cBtnWidthMul + cIndentHMul * 2 + cBtnIndentMul);
        Height := f_CalloutPanel.Height - l_FontSize * (cIndentTopMul + cIndentBottomMul);
       end;
      vtTailTop,
      vtTailBottom :
       begin
        Position.X := l_FontSize * cIndentHMul;
        if f_TailPosition = vtTailTop then
         Position.Y := l_FontSize * (cTailMul + cIndentTopMul)
        else
         Position.Y := l_FontSize * cIndentTopMul;
        Width  := f_CalloutPanel.Width  - l_FontSize * (cBtnWidthMul + cIndentHMul * 2 + cBtnIndentMul);
        Height := f_CalloutPanel.Height - l_FontSize * (cTailMul + cIndentTopMul + cIndentBottomMul);
       end;
    end;
    Realign;
   end;//with f_NonVGLayout
   with f_CloseButton do
   begin
    if f_TailPosition = vtTailRight then
     Position.X := f_CalloutPanel.Width - l_FontSize * (cBtnWidthMul + cBtnIndentMul + cTailMul)
    else
     Position.X := f_CalloutPanel.Width - l_FontSize * (cBtnWidthMul + cBtnIndentMul);
    if f_TailPosition = vtTailTop then
     Position.Y := l_FontSize * (cTailMul + cBtnIndentMul)
    else
     Position.Y := l_FontSize * (cBtnIndentMul);
    Width  := l_FontSize * cBtnWidthMul;
    Height := l_FontSize * cBtnWidthMul;
   end;//with f_CloseButton
  end;//Assigned(f_Scene)
 finally
  Dec(afwFacade.g_DisableMessageHook);
 end;//try..finally
//#UC END# *4F2A599E0283_4D90583503C2_impl*
end;//TvtPopupForm.SetBounds

constructor TvtPopupForm.CreateNew(AOwner: TComponent;
 Dummy: Integer = 0);
//#UC START# *4F9007B20376_4D90583503C2_var*
{$IfDef IsVCMProject}
var
 l_DockTree : TvcmDockTree;
{$EndIf IsVCMProject}
//#UC END# *4F9007B20376_4D90583503C2_var*
begin
//#UC START# *4F9007B20376_4D90583503C2_impl*
 f_TailPosition := vtTailLeft;
 inherited CreateNew(AOwner);
 BorderStyle := bsNone;

 f_BackGround := TvgBackGround.Create(Self);
 with f_BackGround do
 begin
  Align := vaClient;
 end;//with f_BackGround

 f_Scene := TvgScene.Create(Self);
 with f_Scene do
 begin
  Parent := Self;
  AddObject(f_BackGround);
  ControlStyle := ControlStyle + [csAcceptsControls];
  Align := alClient;
  Style := vtVGSceneResources.vgResources;
  Transparency := True;
 end;//with f_Scene

 f_CalloutPanel := TvgCalloutPanel.Create(Self);
 with f_CalloutPanel do
 begin
  Parent := f_BackGround;
  Align  := vaClient;
  CalloutPosition := vgCalloutLeft;
  Resource := cCalloutPanelWarningStyleLayoutName;
 end;//with f_CalloutPanel

 f_CloseButton := TvgCloseButton.Create(Self);
 with f_CloseButton do
 begin
  Name := 'CloseButton';
  Parent := f_CalloutPanel;
  CloseForm := True;
 end;//with f_CloseButton

 f_Panel := TvtPanel.Create(Self);
 with f_Panel do
 begin
  Color :=  cWarningMessageColor;
  Bevelouter := bvNone;
  Parent := f_Scene;
  DockSite := True;
  OnGetSiteInfo := PanelGetSiteInfo; // http://mdp.garant.ru/pages/viewpage.action?pageId=317263132
  TabStop := false;
 end;//with f_Panel

{$IfDef IsVCMProject}
 l_DockTree := TvcmDockTree.Create(TWinControl(f_Panel));
 //l_DockTree.CanUndock := CanUndock;
 //l_DockTree.CanClose := CanClose;
 THackWinControl(f_Panel).DockManager := l_DockTree;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=259170982&focusedCommentId=259170984&#comment-259170984
{$EndIf IsVCMProject}

 f_NonVGLayout := TvgNonVGLayout.Create(Self);
 with f_NonVGLayout do
 begin
  Parent := f_CalloutPanel;
  NonVGControl := f_Panel;
 end;//with f_NonVGLayout
//#UC END# *4F9007B20376_4D90583503C2_impl*
end;//TvtPopupForm.CreateNew

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtPopupForm);
 {* –егистраци€ TvtPopupForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(NoVGScene)
end.
