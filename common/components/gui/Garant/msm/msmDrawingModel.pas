unit msmDrawingModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmDrawingModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmDrawingModel" MUID: (57D27E6802A5)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListModel
 , msmConcreteModels
 , msmElementViews
;

type
 TmsmDrawingModel = class(TmsmListModel, ImsmDrawingModel)
  public
   class function Make(const anElementView: TmsmModelElementView): ImsmDrawingModel; reintroduce;
 end;//TmsmDrawingModel

implementation

uses
 l3ImplUses
 //#UC START# *57D27E6802A5impl_uses*
 //#UC END# *57D27E6802A5impl_uses*
;

class function TmsmDrawingModel.Make(const anElementView: TmsmModelElementView): ImsmDrawingModel;
var
 l_Inst : TmsmDrawingModel;
begin
 l_Inst := CreateList(anElementView);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmDrawingModel.Make

end.
