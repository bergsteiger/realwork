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
 , msmUseCase
 , msmListViewController
 , msmMainFormController
 , msmTreeToListBinding
 , msmListModel
 , msmTreeModel
 , msmListToListBinding
 , msmMultiPanelViewParent
 , msmSingleViewParent
 , msmListAndTreeViewUtils
 , msmTabbedViewParent
 , msmNavigatorForm
 {$If Defined(seThreadSafe)}
 , msmModelLoadingThread
 {$IfEnd} // Defined(seThreadSafe)
 , msmListAndTreeInterfaces
 , msmListToTreeBinding
 , msmListToCaptionBinding
 , msmCaptionModel
 , msmListOpener
 , msmOperation
 , msmListToTreeOperation
 , msmShowInNavigator
 , msmOpenInNewWindow
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
 f_ChildPanel := TmsmSizeablePanel.Create(f_ClientPanel);
 f_ChildPanel.Name := 'ChildPanel';
 f_ChildPanel.Parent := f_ClientPanel;
 f_ChildPanel.Align := alBottom;
 f_ChildPanel.Height := 200;
 f_ChildPanel.SizeableSides := [szTop];
 f_ChildPanel.SplitterBevel := bvRaised;
 f_MainPanel := TmsmPanel.Create(f_ClientPanel);
 f_MainPanel.Name := 'MainPanel';
 f_MainPanel.Parent := f_ClientPanel;
 f_MainPanel.Align := alClient;
//#UC END# *57A9C19A01CE_57A9C16601B9_impl*
end;//TmsmMainForm.Init

class procedure TmsmMainForm.Run;
//#UC START# *57A9C3B40133_57A9C16601B9_var*
const
 cModelRoot = 'M:\NewSchool\Scripts\Models\';
var
 l_Element : ImsmModelElement;
//#UC END# *57A9C3B40133_57A9C16601B9_var*
begin
//#UC START# *57A9C3B40133_57A9C16601B9_impl*
 //l3System.ShowObjectsWindow := false;
 TtfwParserService.Instance.AddIncludePath(cModelRoot);
 l_Element := TmsmModelLoader.LoadFromFile(cModelRoot + 'garant.ms.model.script');
 RunWith(l_Element, l_Element);
//#UC END# *57A9C3B40133_57A9C16601B9_impl*
end;//TmsmMainForm.Run

procedure TmsmMainForm.LoadModel(const anElementForTree: ImsmModelElement;
 const anElementForList: ImsmModelElement);
//#UC START# *57A9D7D8039C_57A9C16601B9_var*

var
 l_NavigatorTreeModel : ImsmTreeModel;
 
 procedure AddListOperations(const aList: ImsmController; const aListModel: ImsmListLikeModel);
 begin//AddListOperations
  Assert(l_NavigatorTreeModel <> nil);
  aList.AddOperation(TmsmOpenInNewWindow.Make('Open in new window', aListModel));
  aList.AddOperation(TmsmShowInNavigator.Make('Show in navigator', aListModel, l_NavigatorTreeModel));
 end;//AddListOperations

 procedure AddChildView(const aChildModel: ImsmListModel; const aParent: ImsmViewParent; const aMainModel: ImsmListModel; const aContext: TmsmListViewtInitContext);
 var
  l_List : ImsmController;
  l_ListToList : ImsmController;
 begin//AddChildView
  l_List := TmsmListViewController.Make(aChildModel, aParent, aContext);
  l_List.DisableEvent(ActionElementEvent.Instance);
  AddListOperations(l_List, aChildModel.As_ImsmListLikeModel);
  f_UseCase.AddController(l_List);
  l_ListToList := TmsmListToListBinding.Make(aMainModel, aChildModel);
  l_ListToList.DisableEvent(ActionElementEvent.Instance);
  f_UseCase.AddController(l_ListToList);
  //l_ListToList := TmsmListToListBinding.Make(aChildModel, aMainModel);
  l_ListToList := TmsmListOpener.Make(aChildModel.As_ImsmListLikeModel, aMainModel);
  l_ListToList.DisableEvent(CurrentElementChangedEvent.Instance);
  f_UseCase.AddController(l_ListToList);
 end;//AddChildView

 procedure AddChildViews(const aNames: array of String; const aParent: ImsmViewParent; const aMainModel: ImsmListModel; const aContext: TmsmListViewtInitContext);
 var
  l_Index : Integer;
 begin//AddChildViews
  for l_Index := Low(aNames) to High(aNames) do
   AddChildView(TmsmListModel.Make(TmsmModelElementView_C(aNames[l_Index])), aParent, aMainModel, aContext);
 end;//AddChildViews

var
 l_TreeModel : ImsmTreeModel;
 l_CaptionModel : ImsmCaptionModel;
 l_MainListModel : ImsmListModel;
 l_ViewForTree : TmsmModelElementView;
 l_ViewForList : TmsmModelElementView;
 l_ChildPanel : ImsmViewParent;
 l_ListContext : TmsmListViewtInitContext;
 l_Navigator : TmsmNavigatorForm;
 l_TreeToList : ImsmController;
 l_Tree : ImsmController;
 l_List : ImsmController;
//#UC END# *57A9D7D8039C_57A9C16601B9_var*
begin
//#UC START# *57A9D7D8039C_57A9C16601B9_impl*
 f_UseCase := TmsmUseCase.Make;

 l_ViewForTree := TmsmModelElementView_C(anElementForTree);
 l_ViewForList := TmsmModelElementView_C(anElementForList);
 l_MainListModel := TmsmListModel.Make(l_ViewForList);
 l_CaptionModel := TmsmCaptionModel.Make;
 l_TreeModel := TmsmTreeModel.Make(l_ViewForTree);
 l_NavigatorTreeModel := TmsmTreeModel.Make(l_ViewForTree);
 f_UseCase.AddController(TmsmMainFormController.Make(Self, l_CaptionModel));
 f_UseCase.AddController(TmsmListToCaptionBinding.Make(l_MainListModel, l_CaptionModel));
 l_List := TmsmListViewController.Make(l_MainListModel, TmsmSingleViewParent.Make(f_MainPanel));
 l_List.DisableEvent(ActionElementEvent.Instance);
 AddListOperations(l_List, l_MainListModel.As_ImsmListLikeModel);
 f_UseCase.AddController(l_List);
 f_UseCase.AddController(TmsmListOpener.Make(l_MainListModel.As_ImsmListLikeModel, l_MainListModel));
 l_Tree := TmsmTreeViewController.Make(l_TreeModel, TmsmSingleViewParent.Make(f_LeftPanel));
 f_UseCase.AddController(l_Tree);
 AddListOperations(l_Tree, l_TreeModel.As_ImsmListLikeModel);
 l_TreeToList := TmsmTreeToListBinding.Make(l_TreeModel, l_MainListModel);
 l_TreeToList.DisableEvent(ActionElementEvent.Instance);
 f_UseCase.AddController(l_TreeToList);
 l_TreeToList := TmsmListOpener.Make(l_TreeModel.As_ImsmListLikeModel, l_MainListModel);
 l_TreeToList.DisableEvent(CurrentElementChangedEvent.Instance);
 f_UseCase.AddController(l_TreeToList);
 f_UseCase.AddController(TmsmListToTreeBinding.Make(l_MainListModel, l_TreeModel));

 l_Navigator := TmsmNavigatorForm.Create(Self);
 l_Navigator.Caption := 'Navigator';
 l_Navigator.Height := 600;
 l_Navigator.Show;
 f_UseCase.AddController(TmsmTreeViewController.Make(l_NavigatorTreeModel, TmsmSingleViewParent.Make(l_Navigator)));
 //l_TreeToList := TmsmTreeToListBinding.Make(l_NavigatorTreeModel, l_MainListModel);
 l_TreeToList := TmsmListOpener.Make(l_NavigatorTreeModel.As_ImsmListLikeModel, l_MainListModel);
 l_TreeToList.DisableEvent(CurrentElementChangedEvent.Instance);
 f_UseCase.AddController(l_TreeToList);

 l_ChildPanel := TmsmTabbedViewParent.Make(f_ChildPanel);
 //l_ChildPanel := TmsmMultiPanelViewParent.Make(f_ChildPanel);
 l_ListContext := TmsmListViewtInitContext_C;
 AddChildViews(['Depends', 'Inherits', 'Implements', 'Inner', 'Children', 'Constants', 'Attributes', 'Operations', 'Implemented', 'Overridden', 'Dependencies'],
               l_ChildPanel,
               l_MainListModel,
               l_ListContext
               );
 AddChildView(TmsmListModel.Make(TmsmModelElementView_C('UpList', 'UpText')),
              l_ChildPanel,
              l_MainListModel,
              l_ListContext);
 l_ListContext.rMultiStrokeItem := true;
 AddChildView(TmsmListModel.Make(TmsmModelElementView_C('SelfList', 'DocumentationNotEmpty')),
              l_ChildPanel,
              l_MainListModel,
              l_ListContext);

 f_UseCase.Activate;
 l_TreeModel.CurrentElement := anElementForList;
 l_NavigatorTreeModel.CurrentElement := anElementForList;

 Application.ProcessMessages;
 
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
