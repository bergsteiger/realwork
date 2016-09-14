unit vcmBaseCollection;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseCollection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmBaseCollection" MUID: (4FFC4C800030)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , Classes
 , vcmBaseCollectionItem
 , vcmPrimCollectionItem
 , vcmExternalInterfaces
 , l3PureMixIns
 //#UC START# *4FFC4C800030intf_uses*
 //#UC END# *4FFC4C800030intf_uses*
;

type
 RvcmBaseCollection = class of TvcmBaseCollection;

 {$Define _UnknownNeedsQI}

{$If NOT Defined(vcmNeedL3)}
 {$Define _UnknownNotNeedL3}
{$IfEnd} // NOT Defined(vcmNeedL3)

 //#UC START# *4FFC4C800030ci*
 THackCollection = class(TPersistent)
 private
   FItemClass: TCollectionItemClass;
   FItems: TList;
   FUpdateCount: Integer;
 end;//THackCollection
 THackOwnedCollection = class(TCollection)
 private
   FOwner: TPersistent;
 end;//THackOwnedCollection
 //#UC END# *4FFC4C800030ci*
 _l3Unknown_Parent_ = TOwnedCollection;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *4FFC4C800030cit*
 //#UC END# *4FFC4C800030cit*
 TvcmBaseCollection = class(_l3Unknown_)
  private
   f_Sorted: Boolean;
  protected
   f_FoundItem: TvcmPrimCollectionItem;
  protected
   procedure pm_SetSorted(aValue: Boolean);
   function pm_GetItems(anIndex: Integer): TvcmBaseCollectionItem;
   procedure pm_SetItems(anIndex: Integer;
    aValue: TvcmBaseCollectionItem);
   procedure Sort;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure BeforeAddToCache; override;
    {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure Notify(Item: TCollectionItem;
    Action: TCollectionNotification); override;
  public
   function FindItemByName(const aName: AnsiString): TvcmBaseCollectionItem;
   constructor Create(anOwner: TPersistent); reintroduce; virtual;
   class function GetItemClass: TCollectionItemClass; virtual;
   function CheckItemByName(const aName: AnsiString): TvcmBaseCollectionItem;
   function FindItemByCaption(const aName: AnsiString): TvcmBaseCollectionItem;
   function FindItemByID(anID: TvcmControlID): TvcmBaseCollectionItem;
   procedure CaptionChanged(aItem: TvcmBaseCollectionItemPrim);
  public
   property Sorted: Boolean
    read f_Sorted
    write pm_SetSorted;
   property Items[anIndex: Integer]: TvcmBaseCollectionItem
    read pm_GetItems
    write pm_SetItems;
 //#UC START# *4FFC4C800030publ*
 //#UC END# *4FFC4C800030publ*
 end;//TvcmBaseCollection
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3String
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4FFC4C800030impl_uses*
 //#UC END# *4FFC4C800030impl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvcmBaseCollection.pm_SetSorted(aValue: Boolean);
//#UC START# *5607EB150143_4FFC4C800030set_var*
//#UC END# *5607EB150143_4FFC4C800030set_var*
begin
//#UC START# *5607EB150143_4FFC4C800030set_impl*
 if aValue <> f_Sorted then
 begin
  f_Sorted := aValue;
  if f_Sorted then
   Sort;
 end;
//#UC END# *5607EB150143_4FFC4C800030set_impl*
end;//TvcmBaseCollection.pm_SetSorted

function TvcmBaseCollection.pm_GetItems(anIndex: Integer): TvcmBaseCollectionItem;
//#UC START# *5607EB680196_4FFC4C800030get_var*
//#UC END# *5607EB680196_4FFC4C800030get_var*
begin
//#UC START# *5607EB680196_4FFC4C800030get_impl*
 Result := TvcmBaseCollectionItem(inherited GetItem(anIndex));
//#UC END# *5607EB680196_4FFC4C800030get_impl*
end;//TvcmBaseCollection.pm_GetItems

procedure TvcmBaseCollection.pm_SetItems(anIndex: Integer;
 aValue: TvcmBaseCollectionItem);
//#UC START# *5607EB680196_4FFC4C800030set_var*
//#UC END# *5607EB680196_4FFC4C800030set_var*
begin
//#UC START# *5607EB680196_4FFC4C800030set_impl*
 inherited SetItem(anIndex, aValue);
//#UC END# *5607EB680196_4FFC4C800030set_impl*
end;//TvcmBaseCollection.pm_SetItems

function TvcmBaseCollection.FindItemByName(const aName: AnsiString): TvcmBaseCollectionItem;
//#UC START# *5607EE8B03CD_4FFC4C800030_var*
var
 l_Item: TvcmBaseCollectionItem;
 l_Index: Integer;
//#UC END# *5607EE8B03CD_4FFC4C800030_var*
begin
//#UC START# *5607EE8B03CD_4FFC4C800030_impl*
 Result := nil;
 if (f_FoundItem Is TvcmBaseCollectionItem) AND
    ANSISameText(TvcmBaseCollectionItem(f_FoundItem).Name, aName) then
  Result := TvcmBaseCollectionItem(f_FoundItem)
 else
 for l_Index := 0 to Pred(Count) do
 begin
  l_Item := Items[l_Index];
  if ANSISameText(TvcmBaseCollectionItem(l_Item).Name, aName) then
  begin
   Result := TvcmBaseCollectionItem(l_Item);
   f_FoundItem := Result;
   break;
  end;//l_Item Is TevBaseCollectionItem
 end;//for l_Item
//#UC END# *5607EE8B03CD_4FFC4C800030_impl*
end;//TvcmBaseCollection.FindItemByName

procedure TvcmBaseCollection.Sort;
//#UC START# *5607EC4F0276_4FFC4C800030_var*
var
 I, J : Integer;

  function lCompareItems(const aItem1, aItem2 : String) : Integer;
  var
   lItem : TvcmBaseCollectionItem;
  begin
  {$IfDef vcmNeedL3}
   Result := l3Compare(l3PCharLen(aItem1), l3PCharLen(aItem2));
  {$Else vcmNeedL3}
   Result := AnsiCompareStr(aItem1, aItem2);
  {$EndIf vcmNeedL3}
   if (Result < 0) then
   begin
    lItem := Items[I];
    Items[J].Index := I;
    lItem.Index := J;
   end;
  end;
//#UC END# *5607EC4F0276_4FFC4C800030_var*
begin
//#UC START# *5607EC4F0276_4FFC4C800030_impl*
 for I := Pred(Count) downto 0 do
 for J := Pred(Count) downto 0 do
  if lCompareItems(Items[J].Caption, Items[I].Caption) = 0 then
   // Caption одинаковый, сортируем по Name
   lCompareItems(Items[J].Name, Items[I].Name);
//#UC END# *5607EC4F0276_4FFC4C800030_impl*
end;//TvcmBaseCollection.Sort

constructor TvcmBaseCollection.Create(anOwner: TPersistent);
//#UC START# *5607EE5400CB_4FFC4C800030_var*
//#UC END# *5607EE5400CB_4FFC4C800030_var*
begin
//#UC START# *5607EE5400CB_4FFC4C800030_impl*
 inherited Create(anOwner, GetItemClass);
//#UC END# *5607EE5400CB_4FFC4C800030_impl*
end;//TvcmBaseCollection.Create

class function TvcmBaseCollection.GetItemClass: TCollectionItemClass;
//#UC START# *5607EE71032D_4FFC4C800030_var*
//#UC END# *5607EE71032D_4FFC4C800030_var*
begin
//#UC START# *5607EE71032D_4FFC4C800030_impl*
 Result := TvcmBaseCollectionItem;
//#UC END# *5607EE71032D_4FFC4C800030_impl*
end;//TvcmBaseCollection.GetItemClass

function TvcmBaseCollection.CheckItemByName(const aName: AnsiString): TvcmBaseCollectionItem;
//#UC START# *5607EEA50071_4FFC4C800030_var*
//#UC END# *5607EEA50071_4FFC4C800030_var*
begin
//#UC START# *5607EEA50071_4FFC4C800030_impl*
 Result := FindItemByName(aName);
 if (Result = nil) then
 begin
  Result := TvcmBaseCollectionItem(Add);
  Result.Name := aName;
 end;//Result = nil
//#UC END# *5607EEA50071_4FFC4C800030_impl*
end;//TvcmBaseCollection.CheckItemByName

function TvcmBaseCollection.FindItemByCaption(const aName: AnsiString): TvcmBaseCollectionItem;
//#UC START# *5607EEB3007A_4FFC4C800030_var*
var
 l_Item: TvcmBaseCollectionItem;
 l_Index: Integer;
//#UC END# *5607EEB3007A_4FFC4C800030_var*
begin
//#UC START# *5607EEB3007A_4FFC4C800030_impl*
 Result := nil;
 if (f_FoundItem Is TvcmBaseCollectionItem) AND
    ANSISameText(TvcmBaseCollectionItem(f_FoundItem).Caption, aName) then
  Result := TvcmBaseCollectionItem(f_FoundItem)
 else
 for l_Index := 0 to Pred(Count) do
 begin
  l_Item := Items[l_Index];
  if ANSISameText(TvcmBaseCollectionItem(l_Item).Caption, aName) then
  begin
   Result := TvcmBaseCollectionItem(l_Item);
   f_FoundItem := Result;
   break;
  end;//l_Item Is TevBaseCollectionItem
 end;//for l_Item
//#UC END# *5607EEB3007A_4FFC4C800030_impl*
end;//TvcmBaseCollection.FindItemByCaption

function TvcmBaseCollection.FindItemByID(anID: TvcmControlID): TvcmBaseCollectionItem;
//#UC START# *5607EEC401EC_4FFC4C800030_var*
var
 l_Item: TvcmBaseCollectionItem;
 l_Index: Integer;
//#UC END# *5607EEC401EC_4FFC4C800030_var*
begin
//#UC START# *5607EEC401EC_4FFC4C800030_impl*
 Result := nil;
 if (f_FoundItem Is TvcmBaseCollectionItem) AND
    (TvcmBaseCollectionItem(f_FoundItem).GetID = anID) then
  Result := TvcmBaseCollectionItem(f_FoundItem)
 else 
 for l_Index := 0 to Pred(Count) do
 begin
  l_Item := Items[l_Index];
  if (l_Item.GetID = anID) then
  begin
   Result := l_Item;
   f_FoundItem := Result;
   break;
  end;//l_Item Is TevBaseCollectionItem
 end;//for l_Item
//#UC END# *5607EEC401EC_4FFC4C800030_impl*
end;//TvcmBaseCollection.FindItemByID

procedure TvcmBaseCollection.CaptionChanged(aItem: TvcmBaseCollectionItemPrim);
//#UC START# *5607EEDB0193_4FFC4C800030_var*
//#UC END# *5607EEDB0193_4FFC4C800030_var*
begin
//#UC START# *5607EEDB0193_4FFC4C800030_impl*
 if f_Sorted then
  Sort;
//#UC END# *5607EEDB0193_4FFC4C800030_impl*
end;//TvcmBaseCollection.CaptionChanged

procedure TvcmBaseCollection.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FFC4C800030_var*
//#UC END# *479731C50290_4FFC4C800030_var*
begin
//#UC START# *479731C50290_4FFC4C800030_impl*
 f_FoundItem := nil;
 f_Sorted := False;
 inherited;
//#UC END# *479731C50290_4FFC4C800030_impl*
end;//TvcmBaseCollection.Cleanup

procedure TvcmBaseCollection.BeforeAddToCache;
 {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
//#UC START# *479F2B3302C1_4FFC4C800030_var*
//#UC END# *479F2B3302C1_4FFC4C800030_var*
begin
//#UC START# *479F2B3302C1_4FFC4C800030_impl*
 inherited;
 THackCollection(Self).FUpdateCount := 0;
 THackOwnedCollection(Self).FOwner := nil;
//#UC END# *479F2B3302C1_4FFC4C800030_impl*
end;//TvcmBaseCollection.BeforeAddToCache

{$If NOT Defined(DesignTimeLibrary)}
class function TvcmBaseCollection.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4FFC4C800030_var*
//#UC END# *47A6FEE600FC_4FFC4C800030_var*
begin
//#UC START# *47A6FEE600FC_4FFC4C800030_impl*
 {$IfDef XE}
 Result := False;
 {$Else  XE}
 Result := True;
 {$EndIf XE}
//#UC END# *47A6FEE600FC_4FFC4C800030_impl*
end;//TvcmBaseCollection.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvcmBaseCollection.Notify(Item: TCollectionItem;
 Action: TCollectionNotification);
//#UC START# *4F8E7A900279_4FFC4C800030_var*
//#UC END# *4F8E7A900279_4FFC4C800030_var*
begin
//#UC START# *4F8E7A900279_4FFC4C800030_impl*
 if (Action in [cnExtracting, cnDeleting]) AND (Item = f_FoundItem) then
  f_FoundItem := nil;
 inherited;
//#UC END# *4F8E7A900279_4FFC4C800030_impl*
end;//TvcmBaseCollection.Notify

//#UC START# *4FFC4C800030impl*
//#UC END# *4FFC4C800030impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseCollection);
 {* Регистрация TvcmBaseCollection }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
