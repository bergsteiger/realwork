unit msmLoadedWordsListModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmLoadedWordsListModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmLoadedWordsListModel" MUID: (57E51B3002A8)

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
 TmsmLoadedWordsListModel = class(TmsmListLikeModel, ImsmListModel)
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
   constructor Create; reintroduce;
   class function Make: ImsmListModel; reintroduce;
 end;//TmsmLoadedWordsListModel

implementation

uses
 l3ImplUses
 , msmLoadedWordsList
 //#UC START# *57E51B3002A8impl_uses*
 //#UC END# *57E51B3002A8impl_uses*
;

constructor TmsmLoadedWordsListModel.Create;
//#UC START# *57E51BD6031C_57E51B3002A8_var*
//#UC END# *57E51BD6031C_57E51B3002A8_var*
begin
//#UC START# *57E51BD6031C_57E51B3002A8_impl*
 inherited Create(TmsmModelElementView_C(nil, 'All'));
//#UC END# *57E51BD6031C_57E51B3002A8_impl*
end;//TmsmLoadedWordsListModel.Create

class function TmsmLoadedWordsListModel.Make: ImsmListModel;
var
 l_Inst : TmsmLoadedWordsListModel;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmLoadedWordsListModel.Make

function TmsmLoadedWordsListModel.DoGetList: ImsmModelElementStringList;
//#UC START# *57D271E300C2_57E51B3002A8_var*
//#UC END# *57D271E300C2_57E51B3002A8_var*
begin
//#UC START# *57D271E300C2_57E51B3002A8_impl*
 if (f_List = nil) then
  f_List := TmsmLoadedWordsList.Make;
 Result := f_List; 
//#UC END# *57D271E300C2_57E51B3002A8_impl*
end;//TmsmLoadedWordsListModel.DoGetList

procedure TmsmLoadedWordsListModel.DoShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57D2A7D900FE_57E51B3002A8_var*
//#UC END# *57D2A7D900FE_57E51B3002A8_var*
begin
//#UC START# *57D2A7D900FE_57E51B3002A8_impl*
 Assert(false);
//#UC END# *57D2A7D900FE_57E51B3002A8_impl*
end;//TmsmLoadedWordsListModel.DoShowElementAsList

procedure TmsmLoadedWordsListModel.SetList(const aList: ImsmModelElementStringList);
//#UC START# *57E54FA00289_57E51B3002A8_var*
//#UC END# *57E54FA00289_57E51B3002A8_var*
begin
//#UC START# *57E54FA00289_57E51B3002A8_impl*
 Assert(false);
//#UC END# *57E54FA00289_57E51B3002A8_impl*
end;//TmsmLoadedWordsListModel.SetList

procedure TmsmLoadedWordsListModel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E51B3002A8_var*
//#UC END# *479731C50290_57E51B3002A8_var*
begin
//#UC START# *479731C50290_57E51B3002A8_impl*
 f_List := nil;
 inherited;
//#UC END# *479731C50290_57E51B3002A8_impl*
end;//TmsmLoadedWordsListModel.Cleanup

function TmsmLoadedWordsListModel.DoGetCaption: AnsiString;
//#UC START# *57E331B90378_57E51B3002A8_var*
//#UC END# *57E331B90378_57E51B3002A8_var*
begin
//#UC START# *57E331B90378_57E51B3002A8_impl*
 Result := f_ElementView.rListName;
//#UC END# *57E331B90378_57E51B3002A8_impl*
end;//TmsmLoadedWordsListModel.DoGetCaption

procedure TmsmLoadedWordsListModel.ClearFields;
begin
 f_List := nil;
 inherited;
end;//TmsmLoadedWordsListModel.ClearFields

end.
