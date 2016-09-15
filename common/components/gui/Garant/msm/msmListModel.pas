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
 , l3Interfaces
;

type
 {$Include w:\common\components\gui\Garant\msm\msmListModel.imp.pas}
 TmsmListModel = class(_msmListModel_)
  public
   constructor CreateDir(const anElementView: TmsmModelElementView); reintroduce;
   constructor Create(const anElementView: TmsmModelElementView;
    aIsDir: Boolean); reintroduce;
   class function MakeDir(const anElementView: TmsmModelElementView): ImsmListModel; reintroduce;
   constructor CreateList(const anElementView: TmsmModelElementView); reintroduce;
   class function MakeList(const anElementView: TmsmModelElementView): ImsmListModel; reintroduce;
 end;//TmsmListModel

implementation

uses
 l3ImplUses
 , msmModelElementDir
 , msmModelElementRelationList
 , msmListAndTreeInterfaces
 , msmElementSelection
 , tfwCStringFactory
 //#UC START# *57B317B00274impl_uses*
 //#UC END# *57B317B00274impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmListModel.imp.pas}

constructor TmsmListModel.CreateDir(const anElementView: TmsmModelElementView);
//#UC START# *57CFF8AB0339_57B317B00274_var*
//#UC END# *57CFF8AB0339_57B317B00274_var*
begin
//#UC START# *57CFF8AB0339_57B317B00274_impl*
 Create(anElementView, true);
//#UC END# *57CFF8AB0339_57B317B00274_impl*
end;//TmsmListModel.CreateDir

constructor TmsmListModel.Create(const anElementView: TmsmModelElementView;
 aIsDir: Boolean);
//#UC START# *57B326FD0285_57B317B00274_var*
//#UC END# *57B326FD0285_57B317B00274_var*
begin
//#UC START# *57B326FD0285_57B317B00274_impl*
 f_ElementView := anElementView;
 f_IsDir := aIsDir;
 inherited Create;
 ShowElementAsList(anElementView.rElement);
//#UC END# *57B326FD0285_57B317B00274_impl*
end;//TmsmListModel.Create

class function TmsmListModel.MakeDir(const anElementView: TmsmModelElementView): ImsmListModel;
var
 l_Inst : TmsmListModel;
begin
 l_Inst := CreateDir(anElementView);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmListModel.MakeDir

constructor TmsmListModel.CreateList(const anElementView: TmsmModelElementView);
//#UC START# *57CFF8D9019D_57B317B00274_var*
//#UC END# *57CFF8D9019D_57B317B00274_var*
begin
//#UC START# *57CFF8D9019D_57B317B00274_impl*
 Create(anElementView, false);
//#UC END# *57CFF8D9019D_57B317B00274_impl*
end;//TmsmListModel.CreateList

class function TmsmListModel.MakeList(const anElementView: TmsmModelElementView): ImsmListModel;
var
 l_Inst : TmsmListModel;
begin
 l_Inst := CreateList(anElementView);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmListModel.MakeList

end.
