unit msmSomeWordsListPrim;

// Модуль: "w:\common\components\gui\Garant\msm\msmSomeWordsListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSomeWordsListPrim" MUID: (58114D530021)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewOfModelElement
 , msmElementViews
 , msmModelElements
 , l3Interfaces
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , msmEvents
 , ImsmEventsSubscriberList
;

type
 _msmEventsPublisher_Parent_ = TmsmViewOfModelElement;
 {$Include w:\common\components\gui\Garant\msm\msmEventsPublisher.imp.pas}
 TmsmSomeWordsListPrim = class(_msmEventsPublisher_, ImsmModelElementStringList, ImsmEventsPublisher)
  protected
   function DoGetCount: Integer; virtual; abstract;
   function DoGetItem(anIndex: Integer): ImsmModelElement; virtual; abstract;
   function As_ImsmEventsPublisher: ImsmEventsPublisher;
    {* Метод приведения нашего интерфейса к ImsmEventsPublisher }
   function Get_Item(anIndex: Integer): ImsmModelElement;
   function Get_Count: Integer;
   function Get_Owner: ImsmModelElement;
   function Get_Strings(anIndex: Integer): Il3CString;
   function Get_StringsToFind(anIndex: Integer): Il3CString;
  public
   constructor Create(const anElement: TmsmModelElementView); reintroduce;
   function IndexOfElementView(const anElement: ImsmModelElement): Integer;
   procedure Add(anItem: TtfwWord);
 end;//TmsmSomeWordsListPrim

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *58114D530021impl_uses*
 //#UC END# *58114D530021impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmEventsPublisher.imp.pas}

constructor TmsmSomeWordsListPrim.Create(const anElement: TmsmModelElementView);
//#UC START# *58115104021E_58114D530021_var*
//#UC END# *58115104021E_58114D530021_var*
begin
//#UC START# *58115104021E_58114D530021_impl*
 Assert(anElement.rElement = nil);
 inherited Create(anElement);
//#UC END# *58115104021E_58114D530021_impl*
end;//TmsmSomeWordsListPrim.Create

function TmsmSomeWordsListPrim.As_ImsmEventsPublisher: ImsmEventsPublisher;
 {* Метод приведения нашего интерфейса к ImsmEventsPublisher }
begin
 Result := Self;
end;//TmsmSomeWordsListPrim.As_ImsmEventsPublisher

function TmsmSomeWordsListPrim.Get_Item(anIndex: Integer): ImsmModelElement;
//#UC START# *57AAD86403AD_58114D530021get_var*
//#UC END# *57AAD86403AD_58114D530021get_var*
begin
//#UC START# *57AAD86403AD_58114D530021get_impl*
 Result := DoGetItem(anIndex);
//#UC END# *57AAD86403AD_58114D530021get_impl*
end;//TmsmSomeWordsListPrim.Get_Item

function TmsmSomeWordsListPrim.Get_Count: Integer;
//#UC START# *57AAD89C0277_58114D530021get_var*
//#UC END# *57AAD89C0277_58114D530021get_var*
begin
//#UC START# *57AAD89C0277_58114D530021get_impl*
 Result := DoGetCount;
//#UC END# *57AAD89C0277_58114D530021get_impl*
end;//TmsmSomeWordsListPrim.Get_Count

function TmsmSomeWordsListPrim.Get_Owner: ImsmModelElement;
//#UC START# *57AE2E140297_58114D530021get_var*
//#UC END# *57AE2E140297_58114D530021get_var*
begin
//#UC START# *57AE2E140297_58114D530021get_impl*
 Result := nil;
//#UC END# *57AE2E140297_58114D530021get_impl*
end;//TmsmSomeWordsListPrim.Get_Owner

function TmsmSomeWordsListPrim.Get_Strings(anIndex: Integer): Il3CString;
//#UC START# *57AEBED1018D_58114D530021get_var*
//#UC END# *57AEBED1018D_58114D530021get_var*
begin
//#UC START# *57AEBED1018D_58114D530021get_impl*
 if (Get_Item(anIndex) = nil) then
  Result := TtfwCStringFactory.C('(unexisting)')
 else
  Result := Get_Item(anIndex).StringProp[Self.Element.rTextName];
//#UC END# *57AEBED1018D_58114D530021get_impl*
end;//TmsmSomeWordsListPrim.Get_Strings

function TmsmSomeWordsListPrim.Get_StringsToFind(anIndex: Integer): Il3CString;
//#UC START# *57B6C7D40215_58114D530021get_var*
//#UC END# *57B6C7D40215_58114D530021get_var*
begin
//#UC START# *57B6C7D40215_58114D530021get_impl*
 if (Get_Item(anIndex) = nil) then
  Result := TtfwCStringFactory.C('(unexisting)')
 else
  Result := Get_Item(anIndex).StringProp['DefaultSearchText'];
//#UC END# *57B6C7D40215_58114D530021get_impl*
end;//TmsmSomeWordsListPrim.Get_StringsToFind

function TmsmSomeWordsListPrim.IndexOfElementView(const anElement: ImsmModelElement): Integer;
//#UC START# *57D1327900BC_58114D530021_var*
var
 l_Index : Integer;
 l_E : ImsmModelElement;
//#UC END# *57D1327900BC_58114D530021_var*
begin
//#UC START# *57D1327900BC_58114D530021_impl*
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
//#UC END# *57D1327900BC_58114D530021_impl*
end;//TmsmSomeWordsListPrim.IndexOfElementView

procedure TmsmSomeWordsListPrim.Add(anItem: TtfwWord);
//#UC START# *58094B920194_58114D530021_var*
//#UC END# *58094B920194_58114D530021_var*
begin
//#UC START# *58094B920194_58114D530021_impl*
 Assert(false);
//#UC END# *58094B920194_58114D530021_impl*
end;//TmsmSomeWordsListPrim.Add

end.
