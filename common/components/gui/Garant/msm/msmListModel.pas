unit msmListModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmListModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListModel" MUID: (57B317B00274)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmElementViews
 , msmModelElements
 , msmModel
;

type
 {$Include w:\common\components\gui\Garant\msm\msmListModel.imp.pas}
 TmsmListModel = class(_msmListModel_)
  public
   constructor Create(const anElementView: TmsmModelElementView); reintroduce;
   class function Make(const anElementView: TmsmModelElementView): ImsmListModel; reintroduce;
 end;//TmsmListModel

implementation

uses
 l3ImplUses
 , msmModelElementDir
 , msmModelElementRelationList
 , msmListAndTreeInterfaces
 //#UC START# *57B317B00274impl_uses*
 //#UC END# *57B317B00274impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmListModel.imp.pas}

constructor TmsmListModel.Create(const anElementView: TmsmModelElementView);
//#UC START# *57B326FD0285_57B317B00274_var*
//#UC END# *57B326FD0285_57B317B00274_var*
begin
//#UC START# *57B326FD0285_57B317B00274_impl*
 f_ElementView := anElementView;
 inherited Create;
 if (anElementView.rElement <> nil) then
  Set_List(TmsmModelElementDir.Make(anElementView.rElement.List[anElementView.rListName], anElementView.rTextName))
 else
  Set_List(nil);
//#UC END# *57B326FD0285_57B317B00274_impl*
end;//TmsmListModel.Create

class function TmsmListModel.Make(const anElementView: TmsmModelElementView): ImsmListModel;
var
 l_Inst : TmsmListModel;
begin
 l_Inst := Create(anElementView);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmListModel.Make

end.
