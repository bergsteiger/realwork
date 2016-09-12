unit msmDrawingUseCaseView;

// Модуль: "w:\common\components\gui\Garant\msm\msmDrawingUseCaseView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmDrawingUseCaseView" MUID: (57D2DF7E00CE)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmUseCase
 , msmConcreteUseCases
 , msmControllers
;

type
 TmsmDrawingUseCaseView = class(TmsmUseCase, ImsmDrawingUseCaseView)
  private
   f_UseCase: ImsmDrawingUseCase;
  protected
   procedure DoActivate; override;
   procedure ClearFields; override;
  public
   constructor Create(const aUseCase: ImsmDrawingUseCase;
    const aMainZone: ImsmViewParent;
    const aChildZone: ImsmViewParent;
    const aLeftZone: ImsmViewParent;
    const aFloatingZone: ImsmViewParent); reintroduce;
   class function Make(const aUseCase: ImsmDrawingUseCase;
    const aMainZone: ImsmViewParent;
    const aChildZone: ImsmViewParent;
    const aLeftZone: ImsmViewParent;
    const aFloatingZone: ImsmViewParent): ImsmDrawingUseCaseView; reintroduce;
 end;//TmsmDrawingUseCaseView

implementation

uses
 l3ImplUses
 //#UC START# *57D2DF7E00CEimpl_uses*
 , msmConcreteModels
 , msmOpenInNewWindow
 , msmShowInNavigator
 , msmUpToParent
 , msmOperationsSeparator
 , msmListAndTreeInterfaces
 , msmListAndTreeViewUtils
 , msmCurrentElementShowAsListBinding
 , msmListOpener
 , msmListModel
 , msmListViewController
 , msmElementViews
 , msmDrawingViewController
 , msmTreeViewController
 //#UC END# *57D2DF7E00CEimpl_uses*
;

constructor TmsmDrawingUseCaseView.Create(const aUseCase: ImsmDrawingUseCase;
 const aMainZone: ImsmViewParent;
 const aChildZone: ImsmViewParent;
 const aLeftZone: ImsmViewParent;
 const aFloatingZone: ImsmViewParent);
//#UC START# *57D2DFA70064_57D2DF7E00CE_var*

 function AddListLikeOperations(const aController: ImsmController; const aModel: ImsmListLikeModel): ImsmController;
 begin//AddListLikeOperations
  Assert(aUseCase.FloatingNavigator <> nil);
  aController.AddOperation(TmsmOpenInNewWindow.Make('Open in new window', aModel));
  aController.AddOperation(TmsmShowInNavigator.Make('Show in navigator', aModel, aUseCase.FloatingNavigator));
  Result := aController;
 end;//AddListLikeOperations

 function AddListOperations(const aController: ImsmController; const aModel: ImsmListModel): ImsmController;
 begin//AddListOperations
  AddListLikeOperations(aController, aModel);
  Result := aController;
 end;//AddListOperations

 function AddMainListOperations(const aController: ImsmController; const aModel: ImsmListModel): ImsmController;
 begin//AddMainListOperations
  aController.AddOperation(TmsmUpToParent.Make('Up to parent', aModel));
  aController.AddOperation(TmsmOperationsSeparator.Make);
  AddListOperations(aController, aModel);
  Result := aController;
 end;//AddMainListOperations

 function AddDiagramOperations(const aController: ImsmController; const aModel: ImsmDrawingModel): ImsmController;
 begin//AddDiagramOperations
  aController.AddOperation(TmsmUpToParent.Make('Parent diagram', aModel));
  aController.AddOperation(TmsmOperationsSeparator.Make);
  AddListOperations(aController, aModel);
  Result := aController;
 end;//AddDiagramOperations

 function DisableActionElementEvent(const aController: ImsmController): ImsmController;
 begin//DisableActionElementEvent
  aController.DisableEvent(ActionElementEvent.Instance);
  Result := aController;
 end;//DisableActionElementEvent

 procedure AddChildView(const aChildModel: ImsmListModel; const aParent: ImsmViewParent; const aContext: TmsmListViewtInitContext);
 begin//AddChildView
  Bind(TmsmCurrentElementShowAsListBinding.Make(aUseCase.MainList, aChildModel));
  Bind(TmsmCurrentElementShowAsListBinding.Make(aUseCase.Drawing, aChildModel));
  Bind(TmsmListOpener.Make(aChildModel, aUseCase.MainList));

  AddController(
   AddListOperations
   (
    DisableActionElementEvent
    (
     TmsmListViewController.Make(aChildModel, aParent, aContext)
    )
    , aChildModel
   )
  );
 end;//AddChildView

 procedure AddChildViews(const aNames: array of String; const aParent: ImsmViewParent; const aContext: TmsmListViewtInitContext);
 var
  l_Index : Integer;
 begin//AddChildViews
  for l_Index := Low(aNames) to High(aNames) do
   AddChildView(TmsmListModel.MakeList(TmsmModelElementView_C(aNames[l_Index])), aParent, aContext);
 end;//AddChildViews
 
var
 l_ListContext : TmsmListViewtInitContext;
//#UC END# *57D2DFA70064_57D2DF7E00CE_var*
begin
//#UC START# *57D2DFA70064_57D2DF7E00CE_impl*
 inherited Create;
 f_UseCase := aUseCase;
(* f_UseCase.AddController(
  TmsmMainFormController.Make(Self, aUseCase.Caption)
 );*)

 AddController(
  AddMainListOperations
  (
   DisableActionElementEvent
   (
    TmsmListViewController.Make(aUseCase.MainList, aMainZone)
   )
   , aUseCase.MainList
  )
 );

 AddController(
  AddDiagramOperations
  (
   TmsmDrawingViewController.Make(aUseCase.Drawing, aMainZone)
   , aUseCase.Drawing
  )
 );

 AddController(
  AddMainListOperations
  (
   DisableActionElementEvent
   (
    TmsmListViewController.Make(aUseCase.Drawing, aMainZone)
   )
   , aUseCase.Drawing
  )
 );

 AddController(
  AddListLikeOperations
  (
   TmsmTreeViewController.Make(aUseCase.Navigator, aLeftZone)
   , aUseCase.Navigator
  )
 );

 l_ListContext := TmsmListViewtInitContext_C;
 AddChildViews(['Depends', 'Inherits', 'Implements', 'Inner', 'Children', 'Constants', 'Attributes', 'Operations', 'Implemented', 'Overridden', 'Dependencies'],
               aChildZone,
               l_ListContext
               );
 AddChildView(TmsmListModel.MakeList(TmsmModelElementView_C('UpList', 'UpText')),
              aChildZone,
              l_ListContext);
 l_ListContext.rMultiStrokeItem := true;
 AddChildView(TmsmListModel.MakeList(TmsmModelElementView_C('SelfList', 'DocumentationNotEmpty')),
              aChildZone,
              l_ListContext);

 AddController(
  TmsmTreeViewController.Make(aUseCase.FloatingNavigator, aFloatingZone)
 );
//#UC END# *57D2DFA70064_57D2DF7E00CE_impl*
end;//TmsmDrawingUseCaseView.Create

class function TmsmDrawingUseCaseView.Make(const aUseCase: ImsmDrawingUseCase;
 const aMainZone: ImsmViewParent;
 const aChildZone: ImsmViewParent;
 const aLeftZone: ImsmViewParent;
 const aFloatingZone: ImsmViewParent): ImsmDrawingUseCaseView;
var
 l_Inst : TmsmDrawingUseCaseView;
begin
 l_Inst := Create(aUseCase, aMainZone, aChildZone, aLeftZone, aFloatingZone);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmDrawingUseCaseView.Make

procedure TmsmDrawingUseCaseView.DoActivate;
//#UC START# *57D2B82102BD_57D2DF7E00CE_var*
//#UC END# *57D2B82102BD_57D2DF7E00CE_var*
begin
//#UC START# *57D2B82102BD_57D2DF7E00CE_impl*
 inherited;
 f_UseCase.Activate;
//#UC END# *57D2B82102BD_57D2DF7E00CE_impl*
end;//TmsmDrawingUseCaseView.DoActivate

procedure TmsmDrawingUseCaseView.ClearFields;
begin
 f_UseCase := nil;
 inherited;
end;//TmsmDrawingUseCaseView.ClearFields

end.
