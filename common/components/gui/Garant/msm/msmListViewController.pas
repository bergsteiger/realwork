unit msmListViewController;

// Модуль: "w:\common\components\gui\Garant\msm\msmListViewController.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListViewController" MUID: (57AAF18F0065)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListView
 , msmConcreteModels
 , msmListAndTreeViewUtils
 , l3TreeInterfaces
 , msmControllers
 , msmParentedViewController
 , msmModels
 , msmEvents
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 _OwnViewClass_ = TmsmListView;
 _ConcreteModel_ = ImsmListModel;
 _InitContext_ = TmsmListViewtInitContext;
 {$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}
 _msmMEListViewController_Parent_ = _msmConcreteModelOwnViewController_;
 {$Include w:\common\components\gui\Garant\msm\msmMEListViewController.imp.pas}
 TmsmListViewController = class(_msmMEListViewController_)
  protected
   procedure DoGetTotal(Sender: TObject); virtual;
   procedure DoGetNode(aSender: TObject;
    anIndex: Integer;
    var theNode: Il3SimpleNode); virtual;
   procedure CallDropDrawPoints; override;
   procedure InitOwnView; override;
   procedure InitViewContext(var theContext: TmsmViewContext); override;
 end;//TmsmListViewController

implementation

uses
 l3ImplUses
 , vtLister
 , SysUtils
 , msmViewControllersUtils
 , msmListAndTreeInterfaces
 , msmModelElements
 , vtStdRes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , msmWaitCursor
 , msmImages
 , msmMEImages
 //#UC START# *57AAF18F0065impl_uses*
 , Graphics
 , l3Base
 , l3String
 , msmModelElementNode
 , msmElementViews
 //#UC END# *57AAF18F0065impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmConcreteModelOwnViewController.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmMEListViewController.imp.pas}

procedure TmsmListViewController.DoGetTotal(Sender: TObject);
//#UC START# *57E56BDF005B_57AAF18F0065_var*
//#UC END# *57E56BDF005B_57AAF18F0065_var*
begin
//#UC START# *57E56BDF005B_57AAF18F0065_impl*
 if (OwnView.Parent <> nil) then
  if (Self.Model.List <> nil) then
   OwnView.Total := Self.Model.List.Count;
//#UC END# *57E56BDF005B_57AAF18F0065_impl*
end;//TmsmListViewController.DoGetTotal

procedure TmsmListViewController.DoGetNode(aSender: TObject;
 anIndex: Integer;
 var theNode: Il3SimpleNode);
//#UC START# *57EAE5C500B3_57AAF18F0065_var*
//#UC END# *57EAE5C500B3_57AAF18F0065_var*
begin
//#UC START# *57EAE5C500B3_57AAF18F0065_impl*
 if (Self.Model = nil) then
  Exit;
 theNode := TmsmModelElementNode.Make(TmsmModelElementView_C(Self.Model.List[anIndex]), -1);
//#UC END# *57EAE5C500B3_57AAF18F0065_impl*
end;//TmsmListViewController.DoGetNode

procedure TmsmListViewController.CallDropDrawPoints;
//#UC START# *57B6C9A5037B_57AAF18F0065_var*
//#UC END# *57B6C9A5037B_57AAF18F0065_var*
begin
//#UC START# *57B6C9A5037B_57AAF18F0065_impl*
 inherited;
 OwnView.CallDropDrawPoints;
//#UC END# *57B6C9A5037B_57AAF18F0065_impl*
end;//TmsmListViewController.CallDropDrawPoints

procedure TmsmListViewController.InitOwnView;
//#UC START# *57ADFB33027D_57AAF18F0065_var*
//#UC END# *57ADFB33027D_57AAF18F0065_var*
begin
//#UC START# *57ADFB33027D_57AAF18F0065_impl*
 inherited;
 OwnView.OnGetTotal := Self.DoGetTotal;
 OwnView.OnGetNode := Self.DoGetNode;
//#UC END# *57ADFB33027D_57AAF18F0065_impl*
end;//TmsmListViewController.InitOwnView

procedure TmsmListViewController.InitViewContext(var theContext: TmsmViewContext);
//#UC START# *57B490B60385_57AAF18F0065_var*
//#UC END# *57B490B60385_57AAF18F0065_var*
begin
//#UC START# *57B490B60385_57AAF18F0065_impl*
 inherited;
 theContext.rCaptionModel := Self.Model;
//#UC END# *57B490B60385_57AAF18F0065_impl*
end;//TmsmListViewController.InitViewContext

end.
