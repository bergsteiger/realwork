unit AACContainerPrim_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/Forms/AACContainerPrim_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACContainerPrim
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  evCustomEditorWindow
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  AACContainerPrim_AACContainer_UserType,
  Base_Operations_AAC_Controls,
  vtScrollBar,
  AACContainerPrim_AACContentsContainer_UserType,
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmContainerForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TAACContainerPrimForm = {form} class(TvcmContainerForm)
 private
 // private fields
   f_TabCaption : IvcmCString;
   f_pnBack : TvtProportionalPanel;
    {* Поле для свойства pnBack}
   f_pnRightEx : TvtPanel;
    {* Поле для свойства pnRightEx}
   f_pnRightForScroll : TvtPanel;
    {* Поле для свойства pnRightForScroll}
   f_pnRight : TvtPanel;
    {* Поле для свойства pnRight}
   f_pnlRightTop : TvtPanel;
    {* Поле для свойства pnlRightTop}
   f_scrRight : TvtScrollBar;
    {* Поле для свойства scrRight}
   f_pnLeftEx : TvtSizeablePanel;
    {* Поле для свойства pnLeftEx}
   f_pnLeftForScroll : TvtPanel;
    {* Поле для свойства pnLeftForScroll}
   f_pnlLeftTop : TvtPanel;
    {* Поле для свойства pnlLeftTop}
   f_pnLeft : TvtPanel;
    {* Поле для свойства pnLeft}
   f_scrLeft : TvtScrollBar;
    {* Поле для свойства scrLeft}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   function AACTextContainer_GetVScrollBar_Execute(aLeft: Boolean): TvtScrollBar;
   procedure AACTextContainer_GetVScrollBar(const aParams: IvcmExecuteParams);
   procedure AACTextContainer_SetJumpTo_Execute(aJumpTo: TevJumpToEvent);
   procedure AACTextContainer_SetJumpTo(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure SetTabCaption(const aTabCaption: IvcmCString); override;
    {$IfEnd} //not NoVCM
 protected
 // protected methods
   function DoGetVScrollBar(aLeft: Boolean): TvtScrollBar; virtual;
   procedure DoSetJumpTo(aJumpTo: TevJumpToEvent); virtual;
 public
 // public properties
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

 TvcmContainerFormRef = TAACContainerPrimForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsConst,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки AACContainerLocalConstants }
  str_AACContainerCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACContainerCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

var
   { Локализуемые строки AACContentsContainerLocalConstants }
  str_AACContentsContainerCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACContentsContainerCaption'; rValue : '');
   { Заголовок пользовательского типа "" }

// start class TAACContainerPrimForm

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
 with (aParams.Data As IAACTextContainer_GetVScrollBar_Params) do
  ResultValue := AACTextContainer_GetVScrollBar_Execute(Left);
end;

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
 with (aParams.Data As IAACTextContainer_SetJumpTo_Params) do
  AACTextContainer_SetJumpTo_Execute(JumpTo);
end;

{$If not defined(NoVCM)}
procedure TAACContainerPrimForm.InitControls;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TAACContainerPrimForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4FF2E935019A_var*
//#UC END# *53F1C6EF02C9_4FF2E935019A_var*
begin
//#UC START# *53F1C6EF02C9_4FF2E935019A_impl*
 Result := f_TabCaption;
//#UC END# *53F1C6EF02C9_4FF2E935019A_impl*
end;//TAACContainerPrimForm.DoGetTabCaption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

procedure TAACContainerPrimForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_AACTextContainer, nil);
  PublishOpWithResult(en_AACTextContainer, op_GetVScrollBar, AACTextContainer_GetVScrollBar, nil, nil);
  PublishOpWithResult(en_AACTextContainer, op_SetJumpTo, AACTextContainer_SetJumpTo, nil, nil);
 end;//with Entities.Entities
end;

procedure TAACContainerPrimForm.MakeControls;
begin
 inherited;
 with AddUsertype(AACContainerName,
  str_AACContainerCaption,
  str_AACContainerCaption,
  true,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(AACContainerName
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
 with DefineZone(vcm_ztMain, f_pnRight) do
 begin
 end;//with DefineZone(vcm_ztMain, f_pnRight)
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
 with DefineZone(vcm_ztChild, f_pnLeft) do
 begin
 end;//with DefineZone(vcm_ztChild, f_pnLeft)
 f_scrLeft := TvtScrollBar.Create(Self);
 f_scrLeft.Name := 'scrLeft';
 f_scrLeft.Parent := pnLeftEx;
 with AddUsertype(AACContentsContainerName,
  str_AACContentsContainerCaption,
  str_AACContentsContainerCaption,
  true,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(AACContentsContainerName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_AACContainerCaption
 str_AACContainerCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_AACContentsContainerCaption
 str_AACContentsContainerCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerPrim
 TtfwClassRef.Register(TAACContainerPrimForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.