unit msmSomeModelElementsListModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmSomeModelElementsListModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSomeModelElementsListModel" MUID: (57E54EB00030)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeModel
 , msmConcreteModels
 , msmElementViews
 , msmModelElements
;

type
 TmsmSomeModelElementsListModel = class(TmsmListLikeModel, ImsmListModel)
  private
   f_List: ImsmModelElementStringList;
  protected
   function DoGetList: ImsmModelElementStringList; override;
   procedure DoShowElementAsList(const anElement: ImsmModelElement); override;
   procedure SetList(const aList: ImsmModelElementStringList);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoGetCaption: AnsiString; override;
   procedure ClearFields; override;
  public
   constructor Create(const aList: ImsmModelElementStringList;
    const aListName: AnsiString); reintroduce;
   class function Make(const aList: ImsmModelElementStringList;
    const aListName: AnsiString): ImsmListModel; reintroduce;
 end;//TmsmSomeModelElementsListModel

implementation

uses
 l3ImplUses
 , msmSomeModelElementsList
 //#UC START# *57E54EB00030impl_uses*
 , msmListAndTreeInterfaces
 //#UC END# *57E54EB00030impl_uses*
;

constructor TmsmSomeModelElementsListModel.Create(const aList: ImsmModelElementStringList;
 const aListName: AnsiString);
//#UC START# *57E54F07016A_57E54EB00030_var*
//#UC END# *57E54F07016A_57E54EB00030_var*
begin
//#UC START# *57E54F07016A_57E54EB00030_impl*
 f_List := aList;
 inherited Create(TmsmModelElementView_C(nil, aListName));
//#UC END# *57E54F07016A_57E54EB00030_impl*
end;//TmsmSomeModelElementsListModel.Create

class function TmsmSomeModelElementsListModel.Make(const aList: ImsmModelElementStringList;
 const aListName: AnsiString): ImsmListModel;
var
 l_Inst : TmsmSomeModelElementsListModel;
begin
 l_Inst := Create(aList, aListName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmSomeModelElementsListModel.Make

function TmsmSomeModelElementsListModel.DoGetList: ImsmModelElementStringList;
//#UC START# *57D271E300C2_57E54EB00030_var*
//#UC END# *57D271E300C2_57E54EB00030_var*
begin
//#UC START# *57D271E300C2_57E54EB00030_impl*
 Result := f_List;
//#UC END# *57D271E300C2_57E54EB00030_impl*
end;//TmsmSomeModelElementsListModel.DoGetList

procedure TmsmSomeModelElementsListModel.DoShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57D2A7D900FE_57E54EB00030_var*
//#UC END# *57D2A7D900FE_57E54EB00030_var*
begin
//#UC START# *57D2A7D900FE_57E54EB00030_impl*
 Assert(false);
//#UC END# *57D2A7D900FE_57E54EB00030_impl*
end;//TmsmSomeModelElementsListModel.DoShowElementAsList

procedure TmsmSomeModelElementsListModel.SetList(const aList: ImsmModelElementStringList);
//#UC START# *57E54FA00289_57E54EB00030_var*
//#UC END# *57E54FA00289_57E54EB00030_var*
begin
//#UC START# *57E54FA00289_57E54EB00030_impl*
 if (aList <> f_List) then
 begin
  f_List := aList;
  Fire(ListChangedEvent.Instance);
 end;//aList <> f_List
//#UC END# *57E54FA00289_57E54EB00030_impl*
end;//TmsmSomeModelElementsListModel.SetList

procedure TmsmSomeModelElementsListModel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E54EB00030_var*
//#UC END# *479731C50290_57E54EB00030_var*
begin
//#UC START# *479731C50290_57E54EB00030_impl*
 f_List := nil;
 inherited;
//#UC END# *479731C50290_57E54EB00030_impl*
end;//TmsmSomeModelElementsListModel.Cleanup

function TmsmSomeModelElementsListModel.DoGetCaption: AnsiString;
//#UC START# *57E331B90378_57E54EB00030_var*
//#UC END# *57E331B90378_57E54EB00030_var*
begin
//#UC START# *57E331B90378_57E54EB00030_impl*
 Result := f_ElementView.rListName;
//#UC END# *57E331B90378_57E54EB00030_impl*
end;//TmsmSomeModelElementsListModel.DoGetCaption

procedure TmsmSomeModelElementsListModel.ClearFields;
begin
 f_List := nil;
 inherited;
end;//TmsmSomeModelElementsListModel.ClearFields

end.
