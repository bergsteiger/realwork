unit msmDrawingUseCase;

// Модуль: "w:\common\components\gui\Garant\msm\msmDrawingUseCase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmDrawingUseCase" MUID: (57D2A86F0082)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmUseCase
 , msmConcreteUseCases
 , msmConcreteModels
 , msmControllers
 , msmElementViews
;

type
 TmsmDrawingUseCase = class(TmsmUseCase, ImsmDrawingUseCase)
  private
   f_FloatingNavigator: ImsmTreeModel;
   f_MainList: ImsmListModel;
   f_Drawing: ImsmDrawingModel;
   f_Navigator: ImsmTreeModel;
   f_Caption: ImsmCaptionModel;
  protected
   function Get_MainList: ImsmListModel;
   function Get_Navigator: ImsmTreeModel;
   function Get_Drawing: ImsmDrawingModel;
   function Get_FloatingNavigator: ImsmTreeModel;
   function Get_Caption: ImsmCaptionModel;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoActivate; override;
   procedure ClearFields; override;
  public
   constructor Create(const aViewForTree: TmsmModelElementView;
    const aViewForList: TmsmModelElementView); reintroduce;
   class function Make(const aViewForTree: TmsmModelElementView;
    const aViewForList: TmsmModelElementView): ImsmDrawingUseCase; reintroduce;
  public
   property FloatingNavigator: ImsmTreeModel
    read f_FloatingNavigator;
   property MainList: ImsmListModel
    read f_MainList;
   property Drawing: ImsmDrawingModel
    read f_Drawing;
   property Navigator: ImsmTreeModel
    read f_Navigator;
   property Caption: ImsmCaptionModel
    read f_Caption;
 end;//TmsmDrawingUseCase

implementation

uses
 l3ImplUses
 , msmTreeModel
 , msmDrawingModel
 , msmListModel
 , msmCaptionModel
 , msmListOwnerNameToCaptionBinding
 , msmListOpener
 , msmListOwnerShowAsListBinding
 , msmCurrentElementSynchronizeBinding
 , msmCurrentElementShowAsListBinding
 , msmListOwnerToCurrentElementBinding
 //#UC START# *57D2A86F0082impl_uses*
 //#UC END# *57D2A86F0082impl_uses*
;

constructor TmsmDrawingUseCase.Create(const aViewForTree: TmsmModelElementView;
 const aViewForList: TmsmModelElementView);
//#UC START# *57D2A8F301D0_57D2A86F0082_var*
//#UC END# *57D2A8F301D0_57D2A86F0082_var*
begin
//#UC START# *57D2A8F301D0_57D2A86F0082_impl*
 inherited Create;
 f_Navigator := TmsmTreeModel.Make(aViewForTree);
 f_FloatingNavigator := TmsmTreeModel.Make(aViewForTree);
 f_MainList := TmsmListModel.MakeDir(aViewForList);
 f_Caption := TmsmCaptionModel.Make;
 f_Drawing := TmsmDrawingModel.Make(aViewForList.rElement);
 //f_Drawing := TmsmDrawingModel.Make(TmsmModelElementView_C(aViewForList.rElement, 'MainDiagram'));

 Bind(TmsmListOwnerNameToCaptionBinding.Make(MainList, Caption));
 // - показываем имя владельца списка в заголовке (формы)

 Bind(TmsmListOpener.Make(MainList, MainList));
 // - открываем новый список MainList -> MainList по ActionElement
 Bind(TmsmListOpener.Make(Drawing, MainList));
 // - открываем новый список Drawing -> MainList по ActionElement

 Bind(TmsmListOwnerShowAsListBinding.Make(MainList, Drawing));
 Bind(TmsmListOwnerShowAsListBinding.Make(Drawing, MainList));
 // - синхронизируем списки у MainList и Drawing в обе стороны

 Bind(TmsmCurrentElementSynchronizeBinding.Make(MainList, Drawing));
 Bind(TmsmCurrentElementSynchronizeBinding.Make(Drawing, MainList));
 // - синхронизируем текущий элемент у MainList и Drawing в обе стороны

 Bind(TmsmCurrentElementShowAsListBinding.Make(Navigator, MainList));
 // - синхронизируем текущий элемент из Navigator со списком MainList
 Bind(TmsmListOwnerToCurrentElementBinding.Make(MainList, Navigator));
 // - синхронизируем текущий список из MainList с текущим элементом в Navigator

 Bind(TmsmListOpener.Make(Navigator, MainList));
 // - открываем новый список Navigator -> MainList по ActionElement
 Bind(TmsmListOpener.Make(FloatingNavigator, MainList));
 // - открываем новый список FloatingNavigator -> MainList по ActionElement
//#UC END# *57D2A8F301D0_57D2A86F0082_impl*
end;//TmsmDrawingUseCase.Create

class function TmsmDrawingUseCase.Make(const aViewForTree: TmsmModelElementView;
 const aViewForList: TmsmModelElementView): ImsmDrawingUseCase;
var
 l_Inst : TmsmDrawingUseCase;
begin
 l_Inst := Create(aViewForTree, aViewForList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmDrawingUseCase.Make

function TmsmDrawingUseCase.Get_MainList: ImsmListModel;
//#UC START# *57D2D7C0039B_57D2A86F0082get_var*
//#UC END# *57D2D7C0039B_57D2A86F0082get_var*
begin
//#UC START# *57D2D7C0039B_57D2A86F0082get_impl*
 Result := Self.MainList;
//#UC END# *57D2D7C0039B_57D2A86F0082get_impl*
end;//TmsmDrawingUseCase.Get_MainList

function TmsmDrawingUseCase.Get_Navigator: ImsmTreeModel;
//#UC START# *57D2D7D00023_57D2A86F0082get_var*
//#UC END# *57D2D7D00023_57D2A86F0082get_var*
begin
//#UC START# *57D2D7D00023_57D2A86F0082get_impl*
 Result := Self.Navigator;
//#UC END# *57D2D7D00023_57D2A86F0082get_impl*
end;//TmsmDrawingUseCase.Get_Navigator

function TmsmDrawingUseCase.Get_Drawing: ImsmDrawingModel;
//#UC START# *57D2D7DB0283_57D2A86F0082get_var*
//#UC END# *57D2D7DB0283_57D2A86F0082get_var*
begin
//#UC START# *57D2D7DB0283_57D2A86F0082get_impl*
 Result := Self.Drawing;
//#UC END# *57D2D7DB0283_57D2A86F0082get_impl*
end;//TmsmDrawingUseCase.Get_Drawing

function TmsmDrawingUseCase.Get_FloatingNavigator: ImsmTreeModel;
//#UC START# *57D2D7E900D8_57D2A86F0082get_var*
//#UC END# *57D2D7E900D8_57D2A86F0082get_var*
begin
//#UC START# *57D2D7E900D8_57D2A86F0082get_impl*
 Result := Self.FloatingNavigator;
//#UC END# *57D2D7E900D8_57D2A86F0082get_impl*
end;//TmsmDrawingUseCase.Get_FloatingNavigator

function TmsmDrawingUseCase.Get_Caption: ImsmCaptionModel;
//#UC START# *57D2D7F40131_57D2A86F0082get_var*
//#UC END# *57D2D7F40131_57D2A86F0082get_var*
begin
//#UC START# *57D2D7F40131_57D2A86F0082get_impl*
 Result := Self.Caption;
//#UC END# *57D2D7F40131_57D2A86F0082get_impl*
end;//TmsmDrawingUseCase.Get_Caption

procedure TmsmDrawingUseCase.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D2A86F0082_var*
//#UC END# *479731C50290_57D2A86F0082_var*
begin
//#UC START# *479731C50290_57D2A86F0082_impl*
 f_FloatingNavigator := nil;
 f_MainList := nil;
 f_Drawing := nil;
 f_Navigator := nil;
 f_Caption := nil;
 inherited;
//#UC END# *479731C50290_57D2A86F0082_impl*
end;//TmsmDrawingUseCase.Cleanup

procedure TmsmDrawingUseCase.DoActivate;
//#UC START# *57D2B82102BD_57D2A86F0082_var*
//#UC END# *57D2B82102BD_57D2A86F0082_var*
begin
//#UC START# *57D2B82102BD_57D2A86F0082_impl*
 inherited;
 Assert(MainList.List <> nil);
 Navigator.CurrentElement := MainList.List.Owner;
 FloatingNavigator.CurrentElement := MainList.List.Owner;
//#UC END# *57D2B82102BD_57D2A86F0082_impl*
end;//TmsmDrawingUseCase.DoActivate

procedure TmsmDrawingUseCase.ClearFields;
begin
 f_FloatingNavigator := nil;
 f_MainList := nil;
 f_Drawing := nil;
 f_Navigator := nil;
 f_Caption := nil;
 inherited;
end;//TmsmDrawingUseCase.ClearFields

end.
