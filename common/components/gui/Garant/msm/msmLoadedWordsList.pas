unit msmLoadedWordsList;

// Модуль: "w:\common\components\gui\Garant\msm\msmLoadedWordsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmLoadedWordsList" MUID: (57E51860015E)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmSomeWordsListPrim
 , msmElementViews
 , msmModelElements
;

type
 TmsmLoadedWordsList = class(TmsmSomeWordsListPrim)
  protected
   function DoGetCount: Integer; override;
   function DoGetItem(anIndex: Integer): ImsmModelElement; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: ImsmModelElementStringList; reintroduce;
 end;//TmsmLoadedWordsList

implementation

uses
 l3ImplUses
 , msmWordsByUserNameIndex
 , msmModelElement
 //#UC START# *57E51860015Eimpl_uses*
 //#UC END# *57E51860015Eimpl_uses*
;

constructor TmsmLoadedWordsList.Create;
//#UC START# *57E51B9E01E1_57E51860015E_var*
//#UC END# *57E51B9E01E1_57E51860015E_var*
begin
//#UC START# *57E51B9E01E1_57E51860015E_impl*
 inherited Create(TmsmModelElementView_C(nil, 'All'));
//#UC END# *57E51B9E01E1_57E51860015E_impl*
end;//TmsmLoadedWordsList.Create

class function TmsmLoadedWordsList.Make: ImsmModelElementStringList;
var
 l_Inst : TmsmLoadedWordsList;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmLoadedWordsList.Make

function TmsmLoadedWordsList.DoGetCount: Integer;
//#UC START# *5811547001A8_57E51860015E_var*
//#UC END# *5811547001A8_57E51860015E_var*
begin
//#UC START# *5811547001A8_57E51860015E_impl*
 with TmsmWordsByUserNameIndex.Instance do
 begin
  Lock;
  try
   Result := Count;
  finally
   Unlock;
  end;//try..finally
 end;//with TmsmWordsByUserNameIndex.Instance
//#UC END# *5811547001A8_57E51860015E_impl*
end;//TmsmLoadedWordsList.DoGetCount

function TmsmLoadedWordsList.DoGetItem(anIndex: Integer): ImsmModelElement;
//#UC START# *581154A203C2_57E51860015E_var*
//#UC END# *581154A203C2_57E51860015E_var*
begin
//#UC START# *581154A203C2_57E51860015E_impl*
 with TmsmWordsByUserNameIndex.Instance do
 begin
  Lock;
  try
   Result := TmsmModelElement.MakeFromWord(Items[anIndex].rValue);
  finally
   Unlock;
  end;//try..finally
 end;//with TmsmWordsByUserNameIndex.Instance
//#UC END# *581154A203C2_57E51860015E_impl*
end;//TmsmLoadedWordsList.DoGetItem

procedure TmsmLoadedWordsList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E51860015E_var*
//#UC END# *479731C50290_57E51860015E_var*
begin
//#UC START# *479731C50290_57E51860015E_impl*
 inherited;
//#UC END# *479731C50290_57E51860015E_impl*
end;//TmsmLoadedWordsList.Cleanup

end.
