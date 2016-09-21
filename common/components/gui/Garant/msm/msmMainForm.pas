unit msmMainForm;

// Модуль: "w:\common\components\gui\Garant\msm\msmMainForm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMainForm" MUID: (57A9C16601B9)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmAppForm
 , msmPanel
 , msmSizeablePanel
 , msmUseCases
 , msmModelElements
 //#UC START# *57A9C16601B9intf_uses*
 //#UC END# *57A9C16601B9intf_uses*
;

type
 //#UC START# *57A9C16601B9ci*
 //#UC END# *57A9C16601B9ci*
 //#UC START# *57A9C16601B9cit*
 //#UC END# *57A9C16601B9cit*
 TmsmMainForm = class(TmsmAppForm)
  private
   f_MainPanel: TmsmPanel;
   f_ChildPanel: TmsmSizeablePanel;
   f_UseCase: ImsmUseCase;
  private
   procedure LoadModel(const anElementForTree: ImsmModelElement;
    const anElementForList: ImsmModelElement);
  protected
   procedure Init;
   class procedure RunWith(const anElementForTree: ImsmModelElement;
    const anElementForList: ImsmModelElement);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   class procedure Run;
   class procedure RunWithList(const anElementForList: ImsmModelElement);
 //#UC START# *57A9C16601B9publ*
  private
   f_LeftPanel : TmsmSizeablePanel;
   f_ClientPanel : TmsmPanel;
   f_BottomPanel : TmsmPanel;
   f_TopPanel : TmsmPanel;
 //#UC END# *57A9C16601B9publ*
 end;//TmsmMainForm

implementation

uses
 l3ImplUses
 , l3ProtoObject
 , msmOpenService
 , msmModelLoader
 , msmTreeViewController
 , msmListViewController
 , msmMainFormController
 , msmCurrentElementShowAsListBinding
 , msmListModel
 , msmTreeModel
 , msmMultiPanelViewParent
 , msmSingleViewParent
 , msmListAndTreeViewUtils
 , msmTabbedViewParent
 , msmNavigatorForm
 {$If Defined(seThreadSafe)}
 , msmModelLoadingThread
 {$IfEnd} // Defined(seThreadSafe)
 , msmListAndTreeInterfaces
 , msmListOwnerToCurrentElementBinding
 , msmListOwnerNameToCaptionBinding
 , msmCaptionModel
 , msmListOpener
 , msmOperation
 , msmListToTreeOperation
 , msmShowInNavigator
 , msmOpenInNewWindow
 , msmDrawingViewController
 , msmCurrentElementSynchronizeBinding
 , msmUpToParent
 , msmOperationsSeparator
 , msmDrawingModel
 , msmListOwnerShowAsListBinding
 , msmDrawingUseCase
 , msmDrawingUseCaseView
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 //#UC START# *57A9C16601B9impl_uses*
 , Controls
 , Menus
 , Forms
 , vtPanel
 , vtSizeablePanel
 , msmViewController
 , msmElementViews
 , msmConcreteModels
 , tfwParserService
 , msmControllers
 , msmConcreteUseCases
 //#UC END# *57A9C16601B9impl_uses*
;

type
 TmsmOpenServiceImpl = {final} class(Tl3ProtoObject, ImsmOpenService)
  public
   procedure OpenListInNewWindow(const anElementForList: ImsmModelElement);
   class function Instance: TmsmOpenServiceImpl;
    {* Метод получения экземпляра синглетона TmsmOpenServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmOpenServiceImpl

var g_TmsmOpenServiceImpl: TmsmOpenServiceImpl = nil;
 {* Экземпляр синглетона TmsmOpenServiceImpl }

procedure TmsmOpenServiceImplFree;
 {* Метод освобождения экземпляра синглетона TmsmOpenServiceImpl }
begin
 l3Free(g_TmsmOpenServiceImpl);
end;//TmsmOpenServiceImplFree

procedure TmsmOpenServiceImpl.OpenListInNewWindow(const anElementForList: ImsmModelElement);
//#UC START# *5077A5E39FAB_57CED5100343_var*
//#UC END# *5077A5E39FAB_57CED5100343_var*
begin
//#UC START# *5077A5E39FAB_57CED5100343_impl*
 TmsmMainForm.RunWithList(anElementForList);
//#UC END# *5077A5E39FAB_57CED5100343_impl*
end;//TmsmOpenServiceImpl.OpenListInNewWindow

class function TmsmOpenServiceImpl.Instance: TmsmOpenServiceImpl;
 {* Метод получения экземпляра синглетона TmsmOpenServiceImpl }
begin
 if (g_TmsmOpenServiceImpl = nil) then
 begin
  l3System.AddExitProc(TmsmOpenServiceImplFree);
  g_TmsmOpenServiceImpl := Create;
 end;
 Result := g_TmsmOpenServiceImpl;
end;//TmsmOpenServiceImpl.Instance

class function TmsmOpenServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmOpenServiceImpl <> nil;
end;//TmsmOpenServiceImpl.Exists

procedure TmsmMainForm.Init;
//#UC START# *57A9C19A01CE_57A9C16601B9_var*
var
 l_Menu : TMainMenu;
//#UC END# *57A9C19A01CE_57A9C16601B9_var*
begin
//#UC START# *57A9C19A01CE_57A9C16601B9_impl*
 //l_Menu := TMainMenu.Create(Self);
 Width := 1100;
 Height := 800;
 Position := poScreenCenter;
 f_TopPanel := TmsmPanel.Create(Self);
 f_TopPanel.Parent := Self;
 f_TopPanel.Height := 30;
 f_TopPanel.Align := alTop;
 f_BottomPanel := TmsmPanel.Create(Self);
 f_BottomPanel.Parent := Self;
 f_BottomPanel.Height := 20;
 f_BottomPanel.Align := alBottom;
 f_LeftPanel := TmsmSizeablePanel.Create(Self);
 f_LeftPanel.Name := 'LeftPanel';
 f_LeftPanel.Parent := Self;
 f_LeftPanel.Width := 400;
 f_LeftPanel.Align := alLeft;
 f_LeftPanel.SizeableSides := [szRight];
 f_LeftPanel.SplitterBevel := bvRaised;
 f_ClientPanel := TmsmPanel.Create(Self);
 f_ClientPanel.Parent := Self;
 f_ClientPanel.Align := alClient;

 if false then
 begin
  f_ChildPanel := TmsmSizeablePanel.Create(f_ClientPanel);
  f_ChildPanel.Name := 'ChildPanel';
  f_ChildPanel.Parent := f_ClientPanel;
  f_ChildPanel.Align := alBottom;
  f_ChildPanel.Height := 200;
  f_ChildPanel.SizeableSides := [szTop];
  f_ChildPanel.SplitterBevel := bvRaised;
 end
 else
  f_ChildPanel := nil;
  
 f_MainPanel := TmsmPanel.Create(f_ClientPanel);
 f_MainPanel.Name := 'MainPanel';
 f_MainPanel.Parent := f_ClientPanel;
 f_MainPanel.Align := alClient;
//#UC END# *57A9C19A01CE_57A9C16601B9_impl*
end;//TmsmMainForm.Init

class procedure TmsmMainForm.Run;
//#UC START# *57A9C3B40133_57A9C16601B9_var*
const
 cModelRoot = 'W:\shared\models\NewSchool\Scripts\Models\';
 //cModelRoot = 'M:\NewSchool\Scripts\Models\';
//#UC END# *57A9C3B40133_57A9C16601B9_var*
begin
//#UC START# *57A9C3B40133_57A9C16601B9_impl*
 //l3System.ShowObjectsWindow := false;
 TtfwParserService.Instance.AddIncludePath(cModelRoot);
 RunWithList(TmsmModelLoader.LoadFromFile(cModelRoot + 'garant.ms.model.script'));
//#UC END# *57A9C3B40133_57A9C16601B9_impl*
end;//TmsmMainForm.Run

procedure TmsmMainForm.LoadModel(const anElementForTree: ImsmModelElement;
 const anElementForList: ImsmModelElement);
//#UC START# *57A9D7D8039C_57A9C16601B9_var*
var
 l_UseCase : ImsmDrawingUseCase;
 l_Navigator : TmsmNavigatorForm;
 l_MainZone : ImsmViewParent;
 l_ChildZone : ImsmViewParent;
 l_LeftZone : ImsmViewParent;
 l_NavigatorZone : ImsmViewParent;
//#UC END# *57A9D7D8039C_57A9C16601B9_var*
begin
//#UC START# *57A9D7D8039C_57A9C16601B9_impl*
 if false then
 begin
  l_Navigator := TmsmNavigatorForm.Create(Self);
  l_Navigator.Caption := 'Navigator';
  l_Navigator.Height := 600;
 end
 else
  l_Navigator := nil;

 l_UseCase := TmsmDrawingUseCase.Make(
  TmsmModelElementView_C(anElementForTree),
  TmsmModelElementView_C(anElementForList)
 );

 l_MainZone :=
  //TmsmMultiPanelViewParent.Make(f_MainPanel);
  TmsmTabbedViewParent.Make(f_MainPanel);

 if (f_ChildPanel = nil) then
  l_ChildZone := nil
 else
  l_ChildZone :=
   TmsmTabbedViewParent.Make(f_ChildPanel);

 if (l_Navigator = nil) then
 begin
  l_LeftZone := nil;
  l_NavigatorZone := TmsmTabbedViewParent.Make(f_LeftPanel);
 end//l_Navigator = nil
 else
 begin
  l_LeftZone :=
   TmsmTabbedViewParent.Make(f_LeftPanel);
   //TmsmSingleViewParent.Make(f_LeftPanel);

  l_NavigatorZone :=
   TmsmTabbedViewParent.Make(l_Navigator);
   //TmsmSingleViewParent.Make(l_Navigator);
 end;//l_Navigator = nil

 try
  f_UseCase := TmsmDrawingUseCaseView.Make(
   l_UseCase,
   l_MainZone,
   l_ChildZone,
   l_LeftZone,
   l_NavigatorZone
  );
  f_UseCase.AddController(
   TmsmMainFormController.Make(Self, l_UseCase.Caption)
  );
  f_UseCase.Activate;
 finally
  l_UseCase := nil;
 end;//try..finally
 if (l_Navigator <> nil) then
  l_Navigator.Show;
 {$IfDef seThreadSafe}
 TmsmModelLoadingThread.CreateManaged(anElementForTree.MainWord, 'LoadInner');
 {$EndIf seThreadSafe}
//#UC END# *57A9D7D8039C_57A9C16601B9_impl*
end;//TmsmMainForm.LoadModel

class procedure TmsmMainForm.RunWith(const anElementForTree: ImsmModelElement;
 const anElementForList: ImsmModelElement);
//#UC START# *57CD4BC0034E_57A9C16601B9_var*
var
 l_F : TmsmMainForm;
//#UC END# *57CD4BC0034E_57A9C16601B9_var*
begin
//#UC START# *57CD4BC0034E_57A9C16601B9_impl*
 Application.CreateForm(TmsmMainForm, l_F);
 l_F.Init;
 l_F.Show;
 l_F.LoadModel(anElementForTree, anElementForList);
//#UC END# *57CD4BC0034E_57A9C16601B9_impl*
end;//TmsmMainForm.RunWith

class procedure TmsmMainForm.RunWithList(const anElementForList: ImsmModelElement);
//#UC START# *57CD5AAF0193_57A9C16601B9_var*
var
 l_E : ImsmModelElement;
//#UC END# *57CD5AAF0193_57A9C16601B9_var*
begin
//#UC START# *57CD5AAF0193_57A9C16601B9_impl*
 if (anElementForList = nil) then
  Exit;
 Assert(anElementForList <> nil);
 l_E := anElementForList;
 while true do
 begin
  if (l_E.Parent = nil) then
  begin
   RunWith(l_E, anElementForList);
   Exit;
  end//(l_E.Parent = nil)
  else
   l_E := l_E.Parent;
 end;//while true
//#UC END# *57CD5AAF0193_57A9C16601B9_impl*
end;//TmsmMainForm.RunWithList

procedure TmsmMainForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57A9C16601B9_var*
//#UC END# *479731C50290_57A9C16601B9_var*
begin
//#UC START# *479731C50290_57A9C16601B9_impl*
 inherited;
 f_UseCase := nil;
 if (Application.MainForm = Self)
    OR (Application.MainForm = nil)
    then
  l3System.CheckClipboard;
//#UC END# *479731C50290_57A9C16601B9_impl*
end;//TmsmMainForm.Cleanup

procedure TmsmMainForm.ClearFields;
begin
 f_UseCase := nil;
 inherited;
end;//TmsmMainForm.ClearFields

//#UC START# *57A9C16601B9impl*
{$R *.dfm}
//#UC END# *57A9C16601B9impl*

initialization
 TmsmOpenService.Instance.Alien := TmsmOpenServiceImpl.Instance;
 {* Регистрация TmsmOpenServiceImpl }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmMainForm);
 {* Регистрация TmsmMainForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
