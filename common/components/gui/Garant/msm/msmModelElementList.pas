unit msmModelElementList;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementList" MUID: (57AADABA0154)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewOfModelElementList
 , msmModelElements
 , msmElementViews
;

type
 TmsmModelElementList = class(TmsmViewOfModelElementList, ImsmModelElementList)
  protected
   function Get_Item(anIndex: Integer): ImsmModelElement;
   function Get_Count: Integer;
   function Get_Owner: ImsmModelElement;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const anElement: TmsmModelElementView); reintroduce;
   class function Make(const anElement: TmsmModelElementView): ImsmModelElementList;
   procedure Reget;
   function IndexOfElementView(const anElement: ImsmModelElement): Integer;
 end;//TmsmModelElementList

implementation

uses
 l3ImplUses
 , msmModelElement
 , msmModelElementListFactory
 , msmModelElementMethodValueCache
 //#UC START# *57AADABA0154impl_uses*
 //#UC END# *57AADABA0154impl_uses*
;

constructor TmsmModelElementList.Create(const anElement: TmsmModelElementView);
//#UC START# *57AADC1802AE_57AADABA0154_var*
//#UC END# *57AADC1802AE_57AADABA0154_var*
begin
//#UC START# *57AADC1802AE_57AADABA0154_impl*
 Assert(anElement.rElement <> nil);
 inherited Create(anElement);
//#UC END# *57AADC1802AE_57AADABA0154_impl*
end;//TmsmModelElementList.Create

class function TmsmModelElementList.Make(const anElement: TmsmModelElementView): ImsmModelElementList;
//#UC START# *57AADC3E007E_57AADABA0154_var*
//#UC END# *57AADC3E007E_57AADABA0154_var*
begin
//#UC START# *57AADC3E007E_57AADABA0154_impl*
 Result := TmsmModelElementListFactory.Make(anElement);
//#UC END# *57AADC3E007E_57AADABA0154_impl*
end;//TmsmModelElementList.Make

procedure TmsmModelElementList.Reget;
//#UC START# *57FE4D3B0255_57AADABA0154_var*
//#UC END# *57FE4D3B0255_57AADABA0154_var*
begin
//#UC START# *57FE4D3B0255_57AADABA0154_impl*
 List := nil;
 Assert(Self.Element.rElement <> nil);
 TmsmModelElementMethodValueCache.Instance.DeleteWordCachedValue(Self.Element.rElement.MainWord, Self.Element.rListName);
 List;
//#UC END# *57FE4D3B0255_57AADABA0154_impl*
end;//TmsmModelElementList.Reget

function TmsmModelElementList.Get_Item(anIndex: Integer): ImsmModelElement;
//#UC START# *57AAD86403AD_57AADABA0154get_var*
//#UC END# *57AAD86403AD_57AADABA0154get_var*
begin
//#UC START# *57AAD86403AD_57AADABA0154get_impl*
 if (List = nil) then
  Result := nil
 else
  Result := TmsmModelElement.MakeFromValue(List.Items[anIndex]);
//#UC END# *57AAD86403AD_57AADABA0154get_impl*
end;//TmsmModelElementList.Get_Item

function TmsmModelElementList.Get_Count: Integer;
//#UC START# *57AAD89C0277_57AADABA0154get_var*
//#UC END# *57AAD89C0277_57AADABA0154get_var*
begin
//#UC START# *57AAD89C0277_57AADABA0154get_impl*
 if (List = nil) then
  Result := 0
 else
  Result := List.Count;
//#UC END# *57AAD89C0277_57AADABA0154get_impl*
end;//TmsmModelElementList.Get_Count

function TmsmModelElementList.Get_Owner: ImsmModelElement;
//#UC START# *57AE2E140297_57AADABA0154get_var*
//#UC END# *57AE2E140297_57AADABA0154get_var*
begin
//#UC START# *57AE2E140297_57AADABA0154get_impl*
 Result := Self.Element.rElement;
//#UC END# *57AE2E140297_57AADABA0154get_impl*
end;//TmsmModelElementList.Get_Owner

function TmsmModelElementList.IndexOfElementView(const anElement: ImsmModelElement): Integer;
//#UC START# *57D1327900BC_57AADABA0154_var*
var
 l_Index : Integer;
 l_E : ImsmModelElement;
//#UC END# *57D1327900BC_57AADABA0154_var*
begin
//#UC START# *57D1327900BC_57AADABA0154_impl*
 Result := -1;
 if (anElement <> nil) then
 begin
  for l_Index := 0 to Pred(Get_Count) do
  begin
   l_E := Get_Item(l_Index);
   if (l_E <> nil) AND l_E.IsSameElement(anElement) then
   begin
    Result := l_Index;
    Exit;
   end;//l_E.IsSameElement(anElement)
  end;//for l_Index
  for l_Index := 0 to Pred(Get_Count) do
  begin
   l_E := Get_Item(l_Index);
   if (l_E <> nil) AND l_E.IsSameElementView(anElement) then
   begin
    Result := l_Index;
    Exit;
   end;//l_E.IsSameElementView(anElement)
  end;//for l_Index
 end;//anElement <> nil
//#UC END# *57D1327900BC_57AADABA0154_impl*
end;//TmsmModelElementList.IndexOfElementView

procedure TmsmModelElementList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57AADABA0154_var*
//#UC END# *479731C50290_57AADABA0154_var*
begin
//#UC START# *479731C50290_57AADABA0154_impl*
 inherited;
//#UC END# *479731C50290_57AADABA0154_impl*
end;//TmsmModelElementList.Cleanup

end.
