unit msmLoadedWordsList;

// Модуль: "w:\common\components\gui\Garant\msm\msmLoadedWordsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmLoadedWordsList" MUID: (57E51860015E)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , msmElementViews
 , msmModelElements
 , l3Interfaces
;

type
 TmsmLoadedWordsList = class(Tl3CProtoObject, ImsmModelElementStringList)
  protected
   function Get_Item(anIndex: Integer): ImsmModelElement;
   function Get_Count: Integer;
   function Get_Owner: ImsmModelElement;
   function Get_Strings(anIndex: Integer): Il3CString;
   function Get_StringsToFind(anIndex: Integer): Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: ImsmModelElementStringList; reintroduce;
   function IndexOfElementView(const anElement: ImsmModelElement): Integer;
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
 inherited Create;
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

function TmsmLoadedWordsList.Get_Item(anIndex: Integer): ImsmModelElement;
//#UC START# *57AAD86403AD_57E51860015Eget_var*
//#UC END# *57AAD86403AD_57E51860015Eget_var*
begin
//#UC START# *57AAD86403AD_57E51860015Eget_impl*
 with TmsmWordsByUserNameIndex.Instance do
 begin
  Lock;
  try
   Result := TmsmModelElement.MakeFromWord(Items[anIndex].rValue);
  finally
   Unlock;
  end;//try..finally
 end;//with TmsmWordsByUserNameIndex.Instance
//#UC END# *57AAD86403AD_57E51860015Eget_impl*
end;//TmsmLoadedWordsList.Get_Item

function TmsmLoadedWordsList.Get_Count: Integer;
//#UC START# *57AAD89C0277_57E51860015Eget_var*
//#UC END# *57AAD89C0277_57E51860015Eget_var*
begin
//#UC START# *57AAD89C0277_57E51860015Eget_impl*
 with TmsmWordsByUserNameIndex.Instance do
 begin
  Lock;
  try
   Result := Count;
  finally
   Unlock;
  end;//try..finally
 end;//with TmsmWordsByUserNameIndex.Instance
//#UC END# *57AAD89C0277_57E51860015Eget_impl*
end;//TmsmLoadedWordsList.Get_Count

function TmsmLoadedWordsList.Get_Owner: ImsmModelElement;
//#UC START# *57AE2E140297_57E51860015Eget_var*
//#UC END# *57AE2E140297_57E51860015Eget_var*
begin
//#UC START# *57AE2E140297_57E51860015Eget_impl*
 Result := nil;
//#UC END# *57AE2E140297_57E51860015Eget_impl*
end;//TmsmLoadedWordsList.Get_Owner

function TmsmLoadedWordsList.Get_Strings(anIndex: Integer): Il3CString;
//#UC START# *57AEBED1018D_57E51860015Eget_var*
//#UC END# *57AEBED1018D_57E51860015Eget_var*
begin
//#UC START# *57AEBED1018D_57E51860015Eget_impl*
 Result := Get_Item(anIndex).StringProp['DefaultText'];
//#UC END# *57AEBED1018D_57E51860015Eget_impl*
end;//TmsmLoadedWordsList.Get_Strings

function TmsmLoadedWordsList.Get_StringsToFind(anIndex: Integer): Il3CString;
//#UC START# *57B6C7D40215_57E51860015Eget_var*
//#UC END# *57B6C7D40215_57E51860015Eget_var*
begin
//#UC START# *57B6C7D40215_57E51860015Eget_impl*
 Result := Get_Item(anIndex).StringProp['DefaultSearchText'];
//#UC END# *57B6C7D40215_57E51860015Eget_impl*
end;//TmsmLoadedWordsList.Get_StringsToFind

function TmsmLoadedWordsList.IndexOfElementView(const anElement: ImsmModelElement): Integer;
//#UC START# *57D1327900BC_57E51860015E_var*
var
 l_Index : Integer;
 l_E : ImsmModelElement;
//#UC END# *57D1327900BC_57E51860015E_var*
begin
//#UC START# *57D1327900BC_57E51860015E_impl*
 Result := -1;
 if (anElement <> nil) then
 begin
  for l_Index := 0 to Pred(Get_Count) do
  begin
   l_E := Get_Item(l_Index);
   if l_E.IsSameElement(anElement) then
   begin
    Result := l_Index;
    Exit;
   end;//l_E.IsSameElement(anElement)
  end;//for l_Index
  for l_Index := 0 to Pred(Get_Count) do
  begin
   l_E := Get_Item(l_Index);
   if l_E.IsSameElementView(anElement) then
   begin
    Result := l_Index;
    Exit;
   end;//l_E.IsSameElementView(anElement)
  end;//for l_Index
 end;//anElement <> nil
//#UC END# *57D1327900BC_57E51860015E_impl*
end;//TmsmLoadedWordsList.IndexOfElementView

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
