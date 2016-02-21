unit AACContainerPrim_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_Form.pas"
// Стереотип: "VCMContainer"

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
 , vtPanel
 , vtScrollBar
 , vtSizeablePanel
 , evCustomEditorWindow
;

type
 // Left

 // Right

 TAACContainerPrimForm = class
  private
   f_TabCaption: IvcmCString;
   f_pnBack: TvtProportionalPanel;
    {* Поле для свойства pnBack }
   f_pnRightEx: TvtPanel;
    {* Поле для свойства pnRightEx }
   f_pnRightForScroll: TvtPanel;
    {* Поле для свойства pnRightForScroll }
   f_pnRight: TvtPanel;
    {* Поле для свойства pnRight }
   f_pnlRightTop: TvtPanel;
    {* Поле для свойства pnlRightTop }
   f_scrRight: TvtScrollBar;
    {* Поле для свойства scrRight }
   f_pnLeftEx: TvtSizeablePanel;
    {* Поле для свойства pnLeftEx }
   f_pnLeftForScroll: TvtPanel;
    {* Поле для свойства pnLeftForScroll }
   f_pnlLeftTop: TvtPanel;
    {* Поле для свойства pnlLeftTop }
   f_pnLeft: TvtPanel;
    {* Поле для свойства pnLeft }
   f_scrLeft: TvtScrollBar;
    {* Поле для свойства scrLeft }
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
  public
   function GetVScrollBar: TvtScrollBar; override;
   procedure SetJumpTo; override;
  public
   property pnBack: TvtProportionalPanel
    read f_pnBack;
 end;//TAACContainerPrimForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsConst
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки AACContainerLocalConstants }
 str_AACContainerCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACContainerCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Локализуемые строки AACContentsContainerLocalConstants }
 str_AACContentsContainerCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACContentsContainerCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }

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

function TAACContainerPrimForm.GetVScrollBar: TvtScrollBar;
//#UC START# *5005237D0210_4FF2E935019A_var*
//#UC END# *5005237D0210_4FF2E935019A_var*
begin
//#UC START# *5005237D0210_4FF2E935019A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5005237D0210_4FF2E935019A_impl*
end;//TAACContainerPrimForm.GetVScrollBar

procedure TAACContainerPrimForm.SetJumpTo;
//#UC START# *5006ED2300F9_4FF2E935019A_var*
//#UC END# *5006ED2300F9_4FF2E935019A_var*
begin
//#UC START# *5006ED2300F9_4FF2E935019A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5006ED2300F9_4FF2E935019A_impl*
end;//TAACContainerPrimForm.SetJumpTo

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TAACContainerPrimForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4FF2E935019A_var*
//#UC END# *53F1C6EF02C9_4FF2E935019A_var*
begin
//#UC START# *53F1C6EF02C9_4FF2E935019A_impl*
 Result := f_TabCaption;
//#UC END# *53F1C6EF02C9_4FF2E935019A_impl*
end;//TAACContainerPrimForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_AACContainerCaption.Init;
 {* Инициализация str_AACContainerCaption }
 str_AACContentsContainerCaption.Init;
 {* Инициализация str_AACContentsContainerCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAACContainerPrimForm);
 {* Регистрация AACContainerPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
