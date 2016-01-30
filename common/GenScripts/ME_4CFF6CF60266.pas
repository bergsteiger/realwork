unit nscSimpleEditor;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscSimpleEditor.pas"
// Стереотип: "GuiControl"

{$Include nscDefine.inc}

interface

uses
 l3IntfUses
 , evCustomMemo
 , evEditorWithOperations
 , Classes
 , Messages
 , nevBase
;

type
 TBreakingParaEvent = procedure(aSender: TObject;
  out aHandled: Boolean) of object;

 //#UC START# *4CFF6CF60266ci*
 //#UC END# *4CFF6CF60266ci*
 //#UC START# *4CFF6CF60266cit*
 //#UC END# *4CFF6CF60266cit*
 TnscSimpleEditor = class(TevCustomMemo)
  private
   f_OnBreakingPara: TBreakingParaEvent;
   f_DisableMouseWheelProcessing: Boolean;
    {* Поле для свойства DisableMouseWheelProcessing }
  protected
   function pm_GetDisableMouseWheelProcessing: Boolean; virtual;
   procedure pm_SetDisableMouseWheelProcessing(aValue: Boolean); virtual;
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   function AllowDrawDocumentEdge: Boolean; override;
   function DoBreakPara(aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
    {* Какие операции публикуются компонентом. }
   function SelectWhenUnfocused: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property DisableMouseWheelProcessing: Boolean
    read pm_GetDisableMouseWheelProcessing
    write pm_SetDisableMouseWheelProcessing;
 //#UC START# *4CFF6CF60266publ*
 published
  property Align;
  property TabOrder;
  property TextSource;
  property IsStaticText;
  property ScrollStyle;// default ssNone;
  property OnGetHotSpotInfo;
  property OnJumpTo;
  property OnMouseAction;
  property Visible;
  property AutoHeightByText default True;
  property OnBreakingPara: TBreakingParaEvent read f_OnBreakingPara write f_OnBreakingPara;
  property AutoHideSelection default True;
  property AfterAdjustHeight;
 //#UC END# *4CFF6CF60266publ*
 end;//TnscSimpleEditor

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TnscSimpleEditor.pm_GetDisableMouseWheelProcessing: Boolean;
//#UC START# *530B25360303_4CFF6CF60266get_var*
//#UC END# *530B25360303_4CFF6CF60266get_var*
begin
//#UC START# *530B25360303_4CFF6CF60266get_impl*
 Result := f_DisableMouseWheelProcessing;
//#UC END# *530B25360303_4CFF6CF60266get_impl*
end;//TnscSimpleEditor.pm_GetDisableMouseWheelProcessing

procedure TnscSimpleEditor.pm_SetDisableMouseWheelProcessing(aValue: Boolean);
//#UC START# *530B25360303_4CFF6CF60266set_var*
//#UC END# *530B25360303_4CFF6CF60266set_var*
begin
//#UC START# *530B25360303_4CFF6CF60266set_impl*
 f_DisableMouseWheelProcessing := aValue;
//#UC END# *530B25360303_4CFF6CF60266set_impl*
end;//TnscSimpleEditor.pm_SetDisableMouseWheelProcessing

constructor TnscSimpleEditor.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4CFF6CF60266_var*
//#UC END# *47D1602000C6_4CFF6CF60266_var*
begin
//#UC START# *47D1602000C6_4CFF6CF60266_impl*
 inherited;
 ParentFont := False;
 AutoHeightByText := True;
 AutoHideSelection := True;
 PlainText := False;
 KeepAllFormatting := True;
 ScrollStyle := ssNone;
//#UC END# *47D1602000C6_4CFF6CF60266_impl*
end;//TnscSimpleEditor.Create

{$If NOT Defined(NoVCL)}
procedure TnscSimpleEditor.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_4CFF6CF60266_var*

  function lp_GetParentForm: TCustomForm;
  var
   l_Control: TControl;
  begin
   Result := nil;
   l_Control := Parent;
   while (l_Control <> nil) and (not (l_Control is TCustomForm)) do
   begin
    l_Control := l_Control.Parent;
   end;
   if (l_Control is TCustomForm) then
    Result := TCustomForm(l_Control);
  end;//lp_GetParentForm

var
 l_Form: TCustomForm;
//#UC END# *47E136A80191_4CFF6CF60266_var*
begin
//#UC START# *47E136A80191_4CFF6CF60266_impl*
 //http://mdp.garant.ru/pages/viewpage.action?pageId=294584542
 if f_DisableMouseWheelProcessing and (Message.Msg = WM_MOUSEWHEEL) then
 begin
  l_Form := lp_GetParentForm;
  if (l_Form <> nil) then
   l_Form.MouseWheelHandler(Message)
  else
   inherited;
 end
 else
  inherited;
//#UC END# *47E136A80191_4CFF6CF60266_impl*
end;//TnscSimpleEditor.WndProc
{$IfEnd} // NOT Defined(NoVCL)

function TnscSimpleEditor.AllowDrawDocumentEdge: Boolean;
//#UC START# *482BFBEE00D5_4CFF6CF60266_var*
//#UC END# *482BFBEE00D5_4CFF6CF60266_var*
begin
//#UC START# *482BFBEE00D5_4CFF6CF60266_impl*
 Result := False;
//#UC END# *482BFBEE00D5_4CFF6CF60266_impl*
end;//TnscSimpleEditor.AllowDrawDocumentEdge

function TnscSimpleEditor.DoBreakPara(aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *482BFCBF01F0_4CFF6CF60266_var*
//#UC END# *482BFCBF01F0_4CFF6CF60266_var*
begin
//#UC START# *482BFCBF01F0_4CFF6CF60266_impl*
 if Assigned(f_OnBreakingPara) then
 begin
  f_OnBreakingPara(Self, Result);
  if Result then 
   Exit;
 end;
 Result := inherited DoBreakPara(aDrawLines,anOp);
//#UC END# *482BFCBF01F0_4CFF6CF60266_impl*
end;//TnscSimpleEditor.DoBreakPara

function TnscSimpleEditor.DefineProvideOperations: TevEditorProvideOperationTypes;
 {* Какие операции публикуются компонентом. }
//#UC START# *48735C4A03C3_4CFF6CF60266_var*
//#UC END# *48735C4A03C3_4CFF6CF60266_var*
begin
//#UC START# *48735C4A03C3_4CFF6CF60266_impl*
 Result := [];
//#UC END# *48735C4A03C3_4CFF6CF60266_impl*
end;//TnscSimpleEditor.DefineProvideOperations

function TnscSimpleEditor.SelectWhenUnfocused: Boolean;
//#UC START# *48E22AD302CE_4CFF6CF60266_var*
//#UC END# *48E22AD302CE_4CFF6CF60266_var*
begin
//#UC START# *48E22AD302CE_4CFF6CF60266_impl*
 Result := True; 
//#UC END# *48E22AD302CE_4CFF6CF60266_impl*
end;//TnscSimpleEditor.SelectWhenUnfocused

//#UC START# *4CFF6CF60266impl*
//#UC END# *4CFF6CF60266impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscSimpleEditor);
 {* Регистрация TnscSimpleEditor }
{$IfEnd} // NOT Defined(NoScripts)

end.
