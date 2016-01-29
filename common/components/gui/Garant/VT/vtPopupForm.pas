unit vtPopupForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vtPopupForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Rem::Reminders::TvtPopupForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
uses
  Types,
  Messages,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  vg_controls,
  vg_scene,
  vg_layouts
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
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
 // private fields
   f_Scene : TvgScene;
   f_Background : TvgBackground;
   f_CalloutPanel : TvgCalloutPanel;
   f_CloseButton : TvgCloseButton;
   f_NonVGLayout : TvgNonVGLayout;
   f_CurrentBounds : TvtCurrentBounds;
   f_AfterBaloonHidden : TNotifyEvent;
    {* Поле для свойства AfterBaloonHidden}
   f_TailPosition : TvtTailPosition;
    {* Поле для свойства TailPosition}
   f_Panel : TvtPanel;
    {* Поле для свойства Panel}
 private
 // private methods
   procedure PanelGetSiteInfo(Sender: TObject;
     DockClient: TControl;
     var InfluenceRect: TRect;
     MousePos: TPoint;
     var CanDock: Boolean);
   procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
 protected
 // property methods
   procedure pm_SetTailPosition(aValue: TvtTailPosition);
 protected
 // overridden protected methods
   {$If not defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
     ATop: Integer;
     AWidth: Integer;
     AHeight: Integer); override;
    {$IfEnd} //not NoVCL
 public
 // overridden public methods
   {$If not defined(NoVCL)}
   constructor CreateNew(AOwner: TComponent;
    Dummy: Integer = 0); override;
   {$IfEnd} //not NoVCL
 public
 // public methods
   class procedure AdjustBalloonSize(const a_TailPosition: TvtTailPosition;
     a_FontSize: Integer;
     a_WidthIn: Integer;
     a_HeightIn: Integer;
     out a_WidthOut: Integer;
     out a_HeightOut: Integer);
     {* По ширине и высоте вдоченного редактора высчитываем ширину и высоту всего баллона. }
 public
 // public properties
   property AfterBaloonHidden: TNotifyEvent
     read f_AfterBaloonHidden
     write f_AfterBaloonHidden;
   property TailPosition: TvtTailPosition
     read f_TailPosition
     write pm_SetTailPosition;
   property Panel: TvtPanel
     read f_Panel;
 end;//TvtPopupForm
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  l3Defaults,
  vg_objects,
  Windows,
  afwFacade,
  vgTypes,
  vtVGSceneRes
  {$If not defined(NoVCM)}
  ,
  vcmDockTree
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

const
   { TvtPopupForm_Constants }
  cIndentHMul = 0.2;
   { отступы от краев по горизонтали }
  cIndentTopMul = 1.0;
   { отступ от верхнего края }
  cIndentBottomMul = 1.0;
   { отступ от нижнего края }
  cTailMul = 1.5;
   { длина хвостика }
  cBtnWidthMul = 1.4;
   { ширина-высота кнопки }
  cBtnIndentMul = 0.5;
   { отступ кнопки от края }

type
  THackWinControl = class(TWinControl)
  end;//THackWinControl

// start class TvtPopupForm

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

class procedure TvtPopupForm.AdjustBalloonSize(const a_TailPosition: TvtTailPosition;
  a_FontSize: Integer;
  a_WidthIn: Integer;
  a_HeightIn: Integer;
  out a_WidthOut: Integer;
  out a_HeightOut: Integer);
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

procedure TvtPopupForm.CMVisibleChanged(var Message: TMessage);
//#UC START# *4FC7694303B7_4D90583503C2_var*
//#UC END# *4FC7694303B7_4D90583503C2_var*
begin
//#UC START# *4FC7694303B7_4D90583503C2_impl*
 inherited;
 if not Visible then
  if Assigned(f_AfterBaloonHidden) then
   f_AfterBaloonHidden(Self);

 // костыль для http://mdp.garant.ru/pages/viewpage.action?pageId=326773126
 if Visible then
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
//#UC END# *4FC7694303B7_4D90583503C2_impl*
end;//TvtPopupForm.CMVisibleChanged

{$If not defined(NoVCL)}
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
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
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
 // сохраняем Bounds до корректировки
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
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
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
{$IfEnd} //not NoVCL

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvtPopupForm
 TtfwClassRef.Register(TvtPopupForm);
{$IfEnd} //not NoScripts AND not NoVGScene

end.