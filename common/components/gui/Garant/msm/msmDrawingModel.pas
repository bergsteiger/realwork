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
  protected
   procedure CheckUnexisting(const anElement: ImsmModelElement;
    var theNewElement: ImsmModelElement;
    var theElementToSelect: ImsmModelElement); override;
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
 //CreateSubElementList(TmsmModelElementView_C(anElement, 'Views'), 'MainDiagram');
 CreateSubElementList(TmsmModelElementView_C(anElement, 'Views'), 'msm:DiagramByName: main');
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

procedure TmsmDrawingModel.CheckUnexisting(const anElement: ImsmModelElement;
 var theNewElement: ImsmModelElement;
 var theElementToSelect: ImsmModelElement);
//#UC START# *57F79A4F032E_57D27E6802A5_var*
//#UC END# *57F79A4F032E_57D27E6802A5_var*
begin
//#UC START# *57F79A4F032E_57D27E6802A5_impl*
 if (anElement <> nil) then
 begin
  if (theNewElement = nil) then
  begin
   anElement.Call([], 'msm:CheckMainDiagram');
   theNewElement := anElement.ElementProp[f_SubElementName];
   if (theNewElement <> nil) then
   begin
    theElementToSelect := nil;
    Exit;
   end;//theNewElement <> nil
  end;//theNewElement = nil
 end;//anElement <> nil 
 inherited;
//#UC END# *57F79A4F032E_57D27E6802A5_impl*
end;//TmsmDrawingModel.CheckUnexisting

end.
