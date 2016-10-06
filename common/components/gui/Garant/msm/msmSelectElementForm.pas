unit msmSelectElementForm;

// Модуль: "w:\common\components\gui\Garant\msm\msmSelectElementForm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSelectElementForm" MUID: (57F50ED80120)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmForm
 , msmUseCases
 , msmConcreteModels
 , msmListAndTreeViewUtils
 , msmModelElementSelectService
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *57F50ED80120intf_uses*
 , StdCtrls
 , evEdit
 , msmPanel
 //#UC END# *57F50ED80120intf_uses*
;

type
 //#UC START# *57F50ED80120ci*
 //#UC END# *57F50ED80120ci*
 //#UC START# *57F50ED80120cit*
 //#UC END# *57F50ED80120cit*
 TmsmSelectElementForm = class(TmsmForm)
  private
   f_UseCase: ImsmUseCase;
  protected
   {$If NOT Defined(NoVCL)}
   function CloseQuery: Boolean; override;
    {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure DoClose(var Action: TCloseAction); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   class procedure SelectElement(const aList: ImsmListModel;
    const aListContext: TmsmListViewtInitContext;
    const aSelector: ImsmElementSelector);
   destructor Destroy; override;
   {$If NOT Defined(NoVCL)}
   function ShowModal: Integer; override;
   {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *57F50ED80120publ*
  private
   f_Selector : ImsmElementSelector;
   f_List : ImsmListModel;
   f_Edit : TevEdit;
   f_BottomPanel : TmsmPanel;
   f_OkButton : TButton;
   f_CancelButton : TButton;
 //#UC END# *57F50ED80120publ*
 end;//TmsmSelectElementForm

implementation

uses
 l3ImplUses
 , msmListControllerWithExternalView
 , msmEvents
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , msmListAndTreeInterfaces
 //#UC START# *57F50ED80120impl_uses*
 , SysUtils
 , Controls
 //, Forms
 , msmUseCase
 , msmListViewController
 , msmSingleViewParent
 , msmControllers
 //, msmListAndTreeInterfaces
 //#UC END# *57F50ED80120impl_uses*
;

type
 TmsmElementSelectBinding = class(TmsmListControllerWithExternalView)
  protected
   procedure DoActionElementEvent(anEvent: TmsmEvent);
   procedure LinkEventHandlers; override;
 end;//TmsmElementSelectBinding

procedure TmsmElementSelectBinding.DoActionElementEvent(anEvent: TmsmEvent);
//#UC START# *57F51FDF012B_57B2B0C602DF_57F51FDF012B_var*
//#UC END# *57F51FDF012B_57B2B0C602DF_57F51FDF012B_var*
begin
//#UC START# *57F51FDF012B_57B2B0C602DF_57F51FDF012B_impl*
 (View As TmsmSelectElementForm).ModalResult := mrOk;
//#UC END# *57F51FDF012B_57B2B0C602DF_57F51FDF012B_impl*
end;//TmsmElementSelectBinding.DoActionElementEvent

procedure TmsmElementSelectBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ActionElementEvent.Instance, DoActionElementEvent);
end;//TmsmElementSelectBinding.LinkEventHandlers

class procedure TmsmSelectElementForm.SelectElement(const aList: ImsmListModel;
 const aListContext: TmsmListViewtInitContext;
 const aSelector: ImsmElementSelector);
//#UC START# *57F50F400051_57F50ED80120_var*

 function DisableActionElementEvent(const aController: ImsmController): ImsmController;
 begin//DisableActionElementEvent
  aController.DisableEvent(ActionElementEvent.Instance);
  Result := aController;
 end;//DisableActionElementEvent

var
 l_F : TmsmSelectElementForm;

 procedure SetupUseCase;
 begin//SetupUseCase
  l_F.f_UseCase := TmsmUseCase.Make;
  l_F.f_UseCase.AddController(
   DisableActionElementEvent
   (
    TmsmListViewController.Make(aList, TmsmSingleViewParent.Make(l_F), aListContext)
   )
  );
  l_F.f_UseCase.Bind(TmsmElementSelectBinding.Make(l_F, aList));
  l_F.f_UseCase.Activate;
 end;//SetupUseCase

//#UC END# *57F50F400051_57F50ED80120_var*
begin
//#UC START# *57F50F400051_57F50ED80120_impl*
 l_F := TmsmSelectElementForm.Create(Application);
 try
  l_F.Width := 800;
  l_F.Height := 700;
  l_F.Position := poScreenCenter;
  l_F.Caption := 'Select element';
  l_F.f_Edit := TevEdit.Create(l_F);
  l_F.f_Edit.Align := alTop;
  l_F.f_Edit.Parent := l_F;
  l_F.f_Edit.Text := 'NewElement';

  l_F.f_BottomPanel := TmsmPanel.Create(l_F);
  l_F.f_BottomPanel.Height := 40;
  l_F.f_BottomPanel.Align := alBottom;
  l_F.f_BottomPanel.Parent := l_F;

  l_F.f_OkButton := TButton.Create(l_F);
  l_F.f_OkButton.Caption := 'Ok';
  l_F.f_OkButton.Left := 10;
  l_F.f_OkButton.Top := (l_F.f_BottomPanel.Height - l_F.f_OkButton.Height) div 2;
  l_F.f_OkButton.Parent := l_F.f_BottomPanel;
  l_F.f_OkButton.ModalResult := mrOk;
  
  l_F.f_CancelButton := TButton.Create(l_F);
  l_F.f_CancelButton.Caption := 'Cancel';
  l_F.f_CancelButton.Left := l_F.f_OkButton.Left + l_F.f_OkButton.Width + 10;
  l_F.f_CancelButton.Top := l_F.f_OkButton.Top;
  l_F.f_CancelButton.Parent := l_F.f_BottomPanel;
  l_F.f_CancelButton.ModalResult := mrCancel;

  l_F.f_Selector := aSelector;
  l_F.f_List := aList;

  SetupUseCase;
  l_F.ShowModal;
  l_F.f_UseCase := nil;
  l_F.f_Selector := nil;
  l_F.f_List := nil;
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *57F50F400051_57F50ED80120_impl*
end;//TmsmSelectElementForm.SelectElement

destructor TmsmSelectElementForm.Destroy;
//#UC START# *48077504027E_57F50ED80120_var*
//#UC END# *48077504027E_57F50ED80120_var*
begin
//#UC START# *48077504027E_57F50ED80120_impl*
 f_UseCase := nil;
 f_Selector := nil;
 inherited;
//#UC END# *48077504027E_57F50ED80120_impl*
end;//TmsmSelectElementForm.Destroy

{$If NOT Defined(NoVCL)}
function TmsmSelectElementForm.CloseQuery: Boolean;
 {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
//#UC START# *4980403E021E_57F50ED80120_var*
//#UC END# *4980403E021E_57F50ED80120_var*
begin
//#UC START# *4980403E021E_57F50ED80120_impl*
 Result := inherited CloseQuery;
 if Result then
 begin
  if (ModalResult = mrOK) then
  begin
   if (f_Edit.Text = '') then
   begin
    Result := false;
    Exit;
   end;//f_Edit.Text = ''
   if (f_List.CurrentElement = nil) then
   begin
    Result := false;
    Exit;
   end;//f_List.CurrentElement = nil
  end;//ModalResult = mrOK
 end;//Result
//#UC END# *4980403E021E_57F50ED80120_impl*
end;//TmsmSelectElementForm.CloseQuery
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
function TmsmSelectElementForm.ShowModal: Integer;
//#UC START# *520B42AF0115_57F50ED80120_var*
//#UC END# *520B42AF0115_57F50ED80120_var*
begin
//#UC START# *520B42AF0115_57F50ED80120_impl*
 Assert(f_Edit <> nil);
 Assert(f_Selector <> nil);
 Assert(f_List <> nil);
 Result := inherited ShowModal;
 if (Result = mrOk) then
 begin
  f_Selector.SelectElement(f_Edit.Text, f_List.CurrentElement);
 end;//Result = mrOk
//#UC END# *520B42AF0115_57F50ED80120_impl*
end;//TmsmSelectElementForm.ShowModal
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TmsmSelectElementForm.DoClose(var Action: TCloseAction);
//#UC START# *5576E05C0204_57F50ED80120_var*
//#UC END# *5576E05C0204_57F50ED80120_var*
begin
//#UC START# *5576E05C0204_57F50ED80120_impl*
 inherited;
//#UC END# *5576E05C0204_57F50ED80120_impl*
end;//TmsmSelectElementForm.DoClose
{$IfEnd} // NOT Defined(NoVCL)

//#UC START# *57F50ED80120impl*
{$R *.dfm}
//#UC END# *57F50ED80120impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmSelectElementForm);
 {* Регистрация TmsmSelectElementForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
