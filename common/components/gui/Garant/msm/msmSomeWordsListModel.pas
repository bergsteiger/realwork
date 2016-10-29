unit msmSomeWordsListModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmSomeWordsListModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSomeWordsListModel" MUID: (57E51B3002A8)

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
 TmsmSomeWordsListModel = class(TmsmListLikeModel, ImsmListModel)
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
   constructor Create(const aListName: AnsiString); reintroduce;
   class function Make(const aListName: AnsiString): ImsmListModel; reintroduce;
 end;//TmsmSomeWordsListModel

implementation

uses
 l3ImplUses
 , msmLoadedWordsList
 , msmSomeWordsList
 //#UC START# *57E51B3002A8impl_uses*
 //#UC END# *57E51B3002A8impl_uses*
;

constructor TmsmSomeWordsListModel.Create(const aListName: AnsiString);
//#UC START# *5811DDFD0037_57E51B3002A8_var*
//#UC END# *5811DDFD0037_57E51B3002A8_var*
begin
//#UC START# *5811DDFD0037_57E51B3002A8_impl*
 inherited Create(TmsmModelElementView_C(nil, aListName));
//#UC END# *5811DDFD0037_57E51B3002A8_impl*
end;//TmsmSomeWordsListModel.Create

class function TmsmSomeWordsListModel.Make(const aListName: AnsiString): ImsmListModel;
var
 l_Inst : TmsmSomeWordsListModel;
begin
 l_Inst := Create(aListName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmSomeWordsListModel.Make

function TmsmSomeWordsListModel.DoGetList: ImsmModelElementStringList;
//#UC START# *57D271E300C2_57E51B3002A8_var*
//#UC END# *57D271E300C2_57E51B3002A8_var*
begin
//#UC START# *57D271E300C2_57E51B3002A8_impl*
 if (f_List = nil) then
 begin
  if (f_ElementView.rListName = 'All') then
   f_List := TmsmLoadedWordsList.Make
  else 
   f_List := TmsmSomeWordsList.Make(f_ElementView);
 end;//f_List = nil
 Result := f_List; 
//#UC END# *57D271E300C2_57E51B3002A8_impl*
end;//TmsmSomeWordsListModel.DoGetList

procedure TmsmSomeWordsListModel.DoShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57D2A7D900FE_57E51B3002A8_var*
//#UC END# *57D2A7D900FE_57E51B3002A8_var*
begin
//#UC START# *57D2A7D900FE_57E51B3002A8_impl*
 Assert(false);
//#UC END# *57D2A7D900FE_57E51B3002A8_impl*
end;//TmsmSomeWordsListModel.DoShowElementAsList

procedure TmsmSomeWordsListModel.SetList(const aList: ImsmModelElementStringList);
//#UC START# *57E54FA00289_57E51B3002A8_var*
//#UC END# *57E54FA00289_57E51B3002A8_var*
begin
//#UC START# *57E54FA00289_57E51B3002A8_impl*
 Assert(false);
//#UC END# *57E54FA00289_57E51B3002A8_impl*
end;//TmsmSomeWordsListModel.SetList

procedure TmsmSomeWordsListModel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E51B3002A8_var*
//#UC END# *479731C50290_57E51B3002A8_var*
begin
//#UC START# *479731C50290_57E51B3002A8_impl*
 f_List := nil;
 inherited;
//#UC END# *479731C50290_57E51B3002A8_impl*
end;//TmsmSomeWordsListModel.Cleanup

function TmsmSomeWordsListModel.DoGetCaption: AnsiString;
//#UC START# *57E331B90378_57E51B3002A8_var*
//#UC END# *57E331B90378_57E51B3002A8_var*
begin
//#UC START# *57E331B90378_57E51B3002A8_impl*
 Result := f_ElementView.rListName;
//#UC END# *57E331B90378_57E51B3002A8_impl*
end;//TmsmSomeWordsListModel.DoGetCaption

procedure TmsmSomeWordsListModel.ClearFields;
begin
 f_List := nil;
 inherited;
end;//TmsmSomeWordsListModel.ClearFields

end.
