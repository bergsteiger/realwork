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
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
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
   procedure ClearZones;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure DoClose(var Action: TCloseAction); override;
   {$IfEnd} // NOT Defined(NoVCL)
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
 , l3Interfaces
 , tfwParserProgressService
 , afwInterfaces
 , l3Core
 , l3Filer
 , msmModelElementSelectService
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
 , msmModelService
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , msmSelectElementForm
 //#UC START# *57A9C16601B9impl_uses*
 , Windows
 , Controls
 , Menus
 //, Forms
 , msmViewController
 , msmElementViews
 //, msmConcreteModels
 , tfwParserService
 , msmControllers
 , msmConcreteUseCases
 , vtSizeablePanel
 , msmChangedElements
 , msmWordsManaging
 , msmModelElement
 , tfwScriptingInterfaces
 , l3String
 , afwFacade
 , afwLongProcessVisualizer
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

 //#UC START# *57EE7F1302F9ci*
 //#UC END# *57EE7F1302F9ci*
 //#UC START# *57EE7F1302F9cit*
 //#UC END# *57EE7F1302F9cit*
 TmsmParserProgressServiceImpl = {final} class(Tl3ProtoObject, Il3Meter, ItfwParserProgressService)
  private
   f_Progress: IafwLongProcessVisualizer;
  protected
   procedure ProgressProc(aState: Byte;
    aValue: Integer;
    const aMsg: Il3CString);
   procedure FreeNotification(AComponent: TComponent);
   procedure RemoveFreeNotification(AComponent: TComponent);
   procedure ClearFields; override;
  public
   procedure TuneFiler(aFiler: Tl3CustomFiler);
   class function Instance: TmsmParserProgressServiceImpl;
    {* Метод получения экземпляра синглетона TmsmParserProgressServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 //#UC START# *57EE7F1302F9publ*
  private
   f_ProgressCount : Integer;
 //#UC END# *57EE7F1302F9publ*
 end;//TmsmParserProgressServiceImpl

 TmsmModelElementSelectServiceImp = {final} class(Tl3ProtoObject, ImsmModelElementSelectService)
  public
   procedure SelectElement(const aSelector: ImsmElementSelector);
   class function Instance: TmsmModelElementSelectServiceImp;
    {* Метод получения экземпляра синглетона TmsmModelElementSelectServiceImp }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmModelElementSelectServiceImp

var g_TmsmOpenServiceImpl: TmsmOpenServiceImpl = nil;
 {* Экземпляр синглетона TmsmOpenServiceImpl }
var g_TmsmParserProgressServiceImpl: TmsmParserProgressServiceImpl = nil;
 {* Экземпляр синглетона TmsmParserProgressServiceImpl }
var g_TmsmModelElementSelectServiceImp: TmsmModelElementSelectServiceImp = nil;
 {* Экземпляр синглетона TmsmModelElementSelectServiceImp }

procedure TmsmOpenServiceImplFree;
 {* Метод освобождения экземпляра синглетона TmsmOpenServiceImpl }
begin
 l3Free(g_TmsmOpenServiceImpl);
end;//TmsmOpenServiceImplFree

procedure TmsmParserProgressServiceImplFree;
 {* Метод освобождения экземпляра синглетона TmsmParserProgressServiceImpl }
begin
 l3Free(g_TmsmParserProgressServiceImpl);
end;//TmsmParserProgressServiceImplFree

procedure TmsmModelElementSelectServiceImpFree;
 {* Метод освобождения экземпляра синглетона TmsmModelElementSelectServiceImp }
begin
 l3Free(g_TmsmModelElementSelectServiceImp);
end;//TmsmModelElementSelectServiceImpFree

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

procedure TmsmParserProgressServiceImpl.ProgressProc(aState: Byte;
 aValue: Integer;
 const aMsg: Il3CString);
//#UC START# *46A5A5430315_57EE7F1302F9_var*
var
 l_S : Il3CString;
//#UC END# *46A5A5430315_57EE7F1302F9_var*
begin
//#UC START# *46A5A5430315_57EE7F1302F9_impl*
 Case aState of
  piStart:
  begin
   Inc(f_ProgressCount);
   if (f_Progress = nil) then
   begin
    if l3IsNil(aMsg) then
     l_S := TtfwCStringFactory.C('Загрузка')
    else
     l_S := aMsg;
    if (afw.Application = nil) then
     f_Progress := TafwLongProcessVisualizer.Make(l_S)
    else
     f_Progress := afw.Application.MakeLongProcessVisualizer(l_S);
   end;//f_Progress = nil
  end;//piStart
  piCurrent:
   ;
  piEnd:
  begin
   Dec(f_ProgressCount);
   if (f_ProgressCount < 0) then
    f_ProgressCount := 0;
   if (f_ProgressCount = 0) then
    f_Progress := nil;
  end;//piEnd
 end;//Case aState
//#UC END# *46A5A5430315_57EE7F1302F9_impl*
end;//TmsmParserProgressServiceImpl.ProgressProc

procedure TmsmParserProgressServiceImpl.FreeNotification(AComponent: TComponent);
//#UC START# *46A5A5DE01FF_57EE7F1302F9_var*
//#UC END# *46A5A5DE01FF_57EE7F1302F9_var*
begin
//#UC START# *46A5A5DE01FF_57EE7F1302F9_impl*
 //Assert(false);
//#UC END# *46A5A5DE01FF_57EE7F1302F9_impl*
end;//TmsmParserProgressServiceImpl.FreeNotification

procedure TmsmParserProgressServiceImpl.RemoveFreeNotification(AComponent: TComponent);
//#UC START# *46A5A5F0010B_57EE7F1302F9_var*
//#UC END# *46A5A5F0010B_57EE7F1302F9_var*
begin
//#UC START# *46A5A5F0010B_57EE7F1302F9_impl*
 //Assert(false);
//#UC END# *46A5A5F0010B_57EE7F1302F9_impl*
end;//TmsmParserProgressServiceImpl.RemoveFreeNotification

procedure TmsmParserProgressServiceImpl.TuneFiler(aFiler: Tl3CustomFiler);
//#UC START# *D5EA2D973852_57EE7F1302F9_var*
//#UC END# *D5EA2D973852_57EE7F1302F9_var*
begin
//#UC START# *D5EA2D973852_57EE7F1302F9_impl*
 if (aFiler <> nil) then
 begin
  if (GetCurrentThreadID = MainThreadID) then
  begin
   aFiler.Indicator.NeedProgressProc := true;
   aFiler.Indicator.Meter := Self;
  end;//GetCurrentThreadID = MainThreadID
 end;//aFiler <> nil
//#UC END# *D5EA2D973852_57EE7F1302F9_impl*
end;//TmsmParserProgressServiceImpl.TuneFiler

class function TmsmParserProgressServiceImpl.Instance: TmsmParserProgressServiceImpl;
 {* Метод получения экземпляра синглетона TmsmParserProgressServiceImpl }
begin
 if (g_TmsmParserProgressServiceImpl = nil) then
 begin
  l3System.AddExitProc(TmsmParserProgressServiceImplFree);
  g_TmsmParserProgressServiceImpl := Create;
 end;
 Result := g_TmsmParserProgressServiceImpl;
end;//TmsmParserProgressServiceImpl.Instance

class function TmsmParserProgressServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmParserProgressServiceImpl <> nil;
end;//TmsmParserProgressServiceImpl.Exists

procedure TmsmParserProgressServiceImpl.ClearFields;
begin
 f_Progress := nil;
 inherited;
end;//TmsmParserProgressServiceImpl.ClearFields

//#UC START# *57EE7F1302F9impl*
//#UC END# *57EE7F1302F9impl*

procedure TmsmModelElementSelectServiceImp.SelectElement(const aSelector: ImsmElementSelector);
//#UC START# *BBCBB8731EE0_57F50B110031_var*
//#UC END# *BBCBB8731EE0_57F50B110031_var*
begin
//#UC START# *BBCBB8731EE0_57F50B110031_impl*
 TmsmSelectElementForm.SelectElement(aSelector);
//#UC END# *BBCBB8731EE0_57F50B110031_impl*
end;//TmsmModelElementSelectServiceImp.SelectElement

class function TmsmModelElementSelectServiceImp.Instance: TmsmModelElementSelectServiceImp;
 {* Метод получения экземпляра синглетона TmsmModelElementSelectServiceImp }
begin
 if (g_TmsmModelElementSelectServiceImp = nil) then
 begin
  l3System.AddExitProc(TmsmModelElementSelectServiceImpFree);
  g_TmsmModelElementSelectServiceImp := Create;
 end;
 Result := g_TmsmModelElementSelectServiceImp;
end;//TmsmModelElementSelectServiceImp.Instance

class function TmsmModelElementSelectServiceImp.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmModelElementSelectServiceImp <> nil;
end;//TmsmModelElementSelectServiceImp.Exists

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

 if true{false} then
 // - вкладки снизу
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
var
 l_ModelName : AnsiString; 
//#UC END# *57A9C3B40133_57A9C16601B9_var*
begin
//#UC START# *57A9C3B40133_57A9C16601B9_impl*
 //l3System.ShowObjectsWindow := false;
 TmsmModelService.Instance.SetModelRoot(cModelRoot);
 TtfwParserService.Instance.AddIncludePath(cModelRoot);
 //RunWithList(TmsmModelLoader.LoadFromFile(cModelRoot + 'garant.ms.model.script'));
 //RunWithList(TmsmModelLoader.LoadFromFile(cModelRoot + '4ABCC25A0322.ms.model.script'));
 if (ParamCount >= 1) then
  l_ModelName := l3StripDoubleQuotes(ParamStr(1));
 if (l_ModelName = '') then
  l_ModelName := 'Shared Delphi SandBoxNew';
  //l_ModelName := 'garant';
  //l_ModelName := 'Shared Delphi Low Level';
  //l_ModelName := 'Shared Delphi$SandBox';
  //l_ModelName := 'L3';
 RunWithList(
  TmsmModelElement.MakeFromWord(
   TmsmWordsManaging.FindWord(
    TtfwCStringFactory.C(
     l_ModelName
    )
   )
  )
 );
//#UC END# *57A9C3B40133_57A9C16601B9_impl*
end;//TmsmMainForm.Run

procedure TmsmMainForm.LoadModel(const anElementForTree: ImsmModelElement;
 const anElementForList: ImsmModelElement);
//#UC START# *57A9D7D8039C_57A9C16601B9_var*
var
 l_Navigator : TmsmNavigatorForm;
 l_MainZone : ImsmViewParent;
 l_ChildZone : ImsmViewParent;
 l_LeftZone : ImsmViewParent;
 l_NavigatorZone : ImsmViewParent;
 l_TopZone : ImsmViewParent;
 l_Caption : ImsmCaptionModel;
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

 l_Caption := TmsmCaptionModel.Make; 

 l_MainZone :=
  //TmsmMultiPanelViewParent.Make(f_MainPanel);
  TmsmTabbedViewParent.Make(f_MainPanel);

 l_TopZone := TmsmMultiPanelViewParent.Make(f_TopPanel);
 
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

 f_UseCase := TmsmDrawingUseCaseView.Make(
  TmsmDrawingUseCase.Make(
   TmsmModelElementView_C(anElementForTree),
   TmsmModelElementView_C(anElementForList),
   l_Caption
  ),
  l_MainZone,
  l_ChildZone,
  l_LeftZone,
  l_NavigatorZone,
  l_TopZone
 );
 f_UseCase.AddController(
  TmsmMainFormController.Make(Self, l_Caption)
 );
 //Self.DisableAlign;
 try
  f_UseCase.Activate;
 finally
  //Self.EnableAlign;
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

procedure TmsmMainForm.ClearZones;
//#UC START# *57EBC65F0320_57A9C16601B9_var*
//#UC END# *57EBC65F0320_57A9C16601B9_var*
begin
//#UC START# *57EBC65F0320_57A9C16601B9_impl*
 // nothing
//#UC END# *57EBC65F0320_57A9C16601B9_impl*
end;//TmsmMainForm.ClearZones

procedure TmsmMainForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57A9C16601B9_var*
//#UC END# *479731C50290_57A9C16601B9_var*
begin
//#UC START# *479731C50290_57A9C16601B9_impl*
 inherited;
 ClearZones;
 f_UseCase := nil;
 if (Application.MainForm = Self)
    OR (Application.MainForm = nil)
    then
  l3System.CheckClipboard;
//#UC END# *479731C50290_57A9C16601B9_impl*
end;//TmsmMainForm.Cleanup

{$If NOT Defined(NoVCL)}
procedure TmsmMainForm.DoClose(var Action: TCloseAction);
//#UC START# *5576E05C0204_57A9C16601B9_var*
var
 l_Res : Integer;
//#UC END# *5576E05C0204_57A9C16601B9_var*
begin
//#UC START# *5576E05C0204_57A9C16601B9_impl*
 Action := caFree;
 inherited DoClose(Action);
 Assert(Action <> caHide);
 if (Action <> caFree) then
  Exit;
 if (Application.MainForm = Self)
    OR (Application.MainForm = nil)
    then
 begin
  if TmsmChangedElements.Exists then
   if not TmsmChangedElements.Instance.Empty then
   begin
    l_Res := MessageBox(0,
                        'Model changed. Save it?',
                        'Warning',
                        MB_ICONQUESTION OR MB_YesNoCancel);
    Case l_Res of
     IDYes:
      TmsmChangedElements.Instance.Save;
     IDNo:
     begin
     end;//IDNo
     IDCancel:
     begin
      Action := caNone;
      Exit;
     end;//IDCancel
     else
      Assert(false);
    end;//Case l_Res
   end;//not TmsmChangedElements.Instance.Empty
  if (l3System.CheckClipboard = IDCancel) then
  begin
   Action := caNone;
   Exit;
  end;//l3System.CheckClipboard = IDCancel
 end;//Application.MainForm = Self
 ClearZones;
 f_UseCase := nil;
//#UC END# *5576E05C0204_57A9C16601B9_impl*
end;//TmsmMainForm.DoClose
{$IfEnd} // NOT Defined(NoVCL)

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
 TtfwParserProgressService.Instance.Alien := TmsmParserProgressServiceImpl.Instance;
 {* Регистрация TmsmParserProgressServiceImpl }
 TmsmModelElementSelectService.Instance.Alien := TmsmModelElementSelectServiceImp.Instance;
 {* Регистрация TmsmModelElementSelectServiceImp }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmMainForm);
 {* Регистрация TmsmMainForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
