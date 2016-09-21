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
 , msmModelElements
;

type
 TmsmDrawingModel = class(TmsmListModel, ImsmDrawingModel)
  public
   constructor Create(const anElement: ImsmModelElement); reintroduce;
   class function Make(const anElement: ImsmModelElement): ImsmDrawingModel; reintroduce;
 end;//TmsmDrawingModel

implementation

uses
 l3ImplUses
 //#UC START# *57D27E6802A5impl_uses*
 , msmElementViews
 //#UC END# *57D27E6802A5impl_uses*
;

constructor TmsmDrawingModel.Create(const anElement: ImsmModelElement);
//#UC START# *57E297C403B4_57D27E6802A5_var*
//#UC END# *57E297C403B4_57D27E6802A5_var*
begin
//#UC START# *57E297C403B4_57D27E6802A5_impl*
 CreateSubElementList(TmsmModelElementView_C(anElement, 'Views'), 'MainDiagram');
//#UC END# *57E297C403B4_57D27E6802A5_impl*
end;//TmsmDrawingModel.Create

class function TmsmDrawingModel.Make(const anElement: ImsmModelElement): ImsmDrawingModel;
var
 l_Inst : TmsmDrawingModel;
begin
 l_Inst := Create(anElement);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmDrawingModel.Make

end.
