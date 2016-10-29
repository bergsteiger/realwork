unit msmListModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmListModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListModel" MUID: (57B317B00274)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListModelPrim
 , msmConcreteModels
 , msmElementViews
;

type
 TmsmListModel = class(TmsmListModelPrim)
  public
   constructor CreateDir(const anElementView: TmsmModelElementView); reintroduce;
   constructor Create(const anElementView: TmsmModelElementView;
    aIsDir: Boolean;
    const aSubElementName: AnsiString); reintroduce;
   class function MakeDir(const anElementView: TmsmModelElementView): ImsmListModel; reintroduce;
   constructor CreateList(const anElementView: TmsmModelElementView); reintroduce;
   class function MakeList(const anElementView: TmsmModelElementView): ImsmListModel; reintroduce;
   constructor CreateSubElementList(const anElementView: TmsmModelElementView;
    const aSubElementName: AnsiString); reintroduce;
   constructor CreateListForViewed(const anElementView: TmsmModelElementView); reintroduce;
   class function MakeListForViewed(const anElementView: TmsmModelElementView): ImsmListModel; reintroduce;
 end;//TmsmListModel

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *57B317B00274impl_uses*
 //#UC END# *57B317B00274impl_uses*
;

constructor TmsmListModel.CreateDir(const anElementView: TmsmModelElementView);
//#UC START# *57CFF8AB0339_57B317B00274_var*
//#UC END# *57CFF8AB0339_57B317B00274_var*
begin
//#UC START# *57CFF8AB0339_57B317B00274_impl*
 Create(anElementView, true, '');
//#UC END# *57CFF8AB0339_57B317B00274_impl*
end;//TmsmListModel.CreateDir

constructor TmsmListModel.Create(const anElementView: TmsmModelElementView;
 aIsDir: Boolean;
 const aSubElementName: AnsiString);
//#UC START# *57B326FD0285_57B317B00274_var*
//#UC END# *57B326FD0285_57B317B00274_var*
begin
//#UC START# *57B326FD0285_57B317B00274_impl*
 f_ElementView := anElementView.ChangeIsDir(aIsDir);
 f_SubElementName := aSubElementName;
 inherited Create(f_ElementView);
 ShowElementAsList(f_ElementView.rElement);
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
 Create(anElementView, false, '');
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

constructor TmsmListModel.CreateSubElementList(const anElementView: TmsmModelElementView;
 const aSubElementName: AnsiString);
//#UC START# *57E2977401C7_57B317B00274_var*
//#UC END# *57E2977401C7_57B317B00274_var*
begin
//#UC START# *57E2977401C7_57B317B00274_impl*
 Create(anElementView, false, aSubElementName);
//#UC END# *57E2977401C7_57B317B00274_impl*
end;//TmsmListModel.CreateSubElementList

constructor TmsmListModel.CreateListForViewed(const anElementView: TmsmModelElementView);
//#UC START# *57FF6E0E01D9_57B317B00274_var*
//#UC END# *57FF6E0E01D9_57B317B00274_var*
begin
//#UC START# *57FF6E0E01D9_57B317B00274_impl*
 CreateSubElementList(anElementView, 'Viewed');
//#UC END# *57FF6E0E01D9_57B317B00274_impl*
end;//TmsmListModel.CreateListForViewed

class function TmsmListModel.MakeListForViewed(const anElementView: TmsmModelElementView): ImsmListModel;
var
 l_Inst : TmsmListModel;
begin
 l_Inst := CreateListForViewed(anElementView);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmListModel.MakeListForViewed

end.
