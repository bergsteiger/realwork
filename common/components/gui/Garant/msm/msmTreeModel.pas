unit msmTreeModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmTreeModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmTreeModel" MUID: (57B31D5A00D2)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmElementViews
 , msmModelElements
 , msmModel
 , l3Interfaces
;

type
 {$Include w:\common\components\gui\Garant\msm\msmTreeModel.imp.pas}
 TmsmTreeModel = class(_msmTreeModel_)
  public
   constructor Create(const anElementView: TmsmModelElementView); reintroduce;
   class function Make(const anElementView: TmsmModelElementView): ImsmTreeModel; reintroduce;
 end;//TmsmTreeModel

implementation

uses
 l3ImplUses
 , msmModelElementTree
 , msmListAndTreeInterfaces
 , msmElementSelection
 , tfwCStringFactory
 //#UC START# *57B31D5A00D2impl_uses*
 //#UC END# *57B31D5A00D2impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmTreeModel.imp.pas}

constructor TmsmTreeModel.Create(const anElementView: TmsmModelElementView);
//#UC START# *57B31E3F034D_57B31D5A00D2_var*
//#UC END# *57B31E3F034D_57B31D5A00D2_var*
begin
//#UC START# *57B31E3F034D_57B31D5A00D2_impl*
 Assert(anElementView.rElement <> nil);
 f_ElementView := anElementView;
 inherited Create;
 f_Tree := TmsmModelElementTree.Make(f_ElementView);
//#UC END# *57B31E3F034D_57B31D5A00D2_impl*
end;//TmsmTreeModel.Create

class function TmsmTreeModel.Make(const anElementView: TmsmModelElementView): ImsmTreeModel;
var
 l_Inst : TmsmTreeModel;
begin
 l_Inst := Create(anElementView);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmTreeModel.Make

end.
