unit msmSomeModelElementsList;

// Модуль: "w:\common\components\gui\Garant\msm\msmSomeModelElementsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSomeModelElementsList" MUID: (57E54DCD0141)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , msmElementViews
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , msmModelElements
 , l3Interfaces
;

type
 TmsmSomeModelElementsList = class(Tl3CProtoObject, ImsmModelElementStringList)
  private
   f_List: ItfwValueList;
  protected
   function Get_Item(anIndex: Integer): ImsmModelElement;
   function Get_Count: Integer;
   function Get_Owner: ImsmModelElement;
   function Get_Strings(anIndex: Integer): Il3CString;
   function Get_StringsToFind(anIndex: Integer): Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aList: ItfwValueList); reintroduce;
   class function Make(const aList: ItfwValueList): ImsmModelElementStringList; reintroduce;
   function IndexOfElementView(const anElement: ImsmModelElement): Integer;
 end;//TmsmSomeModelElementsList

implementation

uses
 l3ImplUses
 , msmModelElement
 //#UC START# *57E54DCD0141impl_uses*
 //#UC END# *57E54DCD0141impl_uses*
;

constructor TmsmSomeModelElementsList.Create(const aList: ItfwValueList);
//#UC START# *57E54E69027B_57E54DCD0141_var*
//#UC END# *57E54E69027B_57E54DCD0141_var*
begin
//#UC START# *57E54E69027B_57E54DCD0141_impl*
 Assert(aList <> nil);
 f_List := aList;
 inherited Create;
//#UC END# *57E54E69027B_57E54DCD0141_impl*
end;//TmsmSomeModelElementsList.Create

class function TmsmSomeModelElementsList.Make(const aList: ItfwValueList): ImsmModelElementStringList;
var
 l_Inst : TmsmSomeModelElementsList;
begin
 l_Inst := Create(aList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmSomeModelElementsList.Make

function TmsmSomeModelElementsList.Get_Item(anIndex: Integer): ImsmModelElement;
//#UC START# *57AAD86403AD_57E54DCD0141get_var*
//#UC END# *57AAD86403AD_57E54DCD0141get_var*
begin
//#UC START# *57AAD86403AD_57E54DCD0141get_impl*
 if (f_List = nil) then
  Result := nil
 else
  Result := TmsmModelElement.MakeFromValue(f_List[anIndex]); 
//#UC END# *57AAD86403AD_57E54DCD0141get_impl*
end;//TmsmSomeModelElementsList.Get_Item

function TmsmSomeModelElementsList.Get_Count: Integer;
//#UC START# *57AAD89C0277_57E54DCD0141get_var*
//#UC END# *57AAD89C0277_57E54DCD0141get_var*
begin
//#UC START# *57AAD89C0277_57E54DCD0141get_impl*
 if (f_List = nil) then
  Result := 0
 else
  Result := f_List.Count;
//#UC END# *57AAD89C0277_57E54DCD0141get_impl*
end;//TmsmSomeModelElementsList.Get_Count

function TmsmSomeModelElementsList.Get_Owner: ImsmModelElement;
//#UC START# *57AE2E140297_57E54DCD0141get_var*
//#UC END# *57AE2E140297_57E54DCD0141get_var*
begin
//#UC START# *57AE2E140297_57E54DCD0141get_impl*
 Result := nil;
//#UC END# *57AE2E140297_57E54DCD0141get_impl*
end;//TmsmSomeModelElementsList.Get_Owner

function TmsmSomeModelElementsList.Get_Strings(anIndex: Integer): Il3CString;
//#UC START# *57AEBED1018D_57E54DCD0141get_var*
var
 l_E : ImsmModelElement;
//#UC END# *57AEBED1018D_57E54DCD0141get_var*
begin
//#UC START# *57AEBED1018D_57E54DCD0141get_impl*
 l_E := Get_Item(anIndex);
 if (l_E = nil) then
  Result := TtfwCStringFactory.C('(unexisting)')
 else
  Result := l_E.StringProp['DefaultText'];
//#UC END# *57AEBED1018D_57E54DCD0141get_impl*
end;//TmsmSomeModelElementsList.Get_Strings

function TmsmSomeModelElementsList.Get_StringsToFind(anIndex: Integer): Il3CString;
//#UC START# *57B6C7D40215_57E54DCD0141get_var*
var
 l_E : ImsmModelElement;
//#UC END# *57B6C7D40215_57E54DCD0141get_var*
begin
//#UC START# *57B6C7D40215_57E54DCD0141get_impl*
 l_E := Get_Item(anIndex);
 if (l_E = nil) then
  Result := TtfwCStringFactory.C('(unexisting)')
 else
  Result := l_E.StringProp['DefaultSearchText'];
//#UC END# *57B6C7D40215_57E54DCD0141get_impl*
end;//TmsmSomeModelElementsList.Get_StringsToFind

function TmsmSomeModelElementsList.IndexOfElementView(const anElement: ImsmModelElement): Integer;
//#UC START# *57D1327900BC_57E54DCD0141_var*
var
 l_Index : Integer;
 l_E : ImsmModelElement;
//#UC END# *57D1327900BC_57E54DCD0141_var*
begin
//#UC START# *57D1327900BC_57E54DCD0141_impl*
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
//#UC END# *57D1327900BC_57E54DCD0141_impl*
end;//TmsmSomeModelElementsList.IndexOfElementView

procedure TmsmSomeModelElementsList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E54DCD0141_var*
//#UC END# *479731C50290_57E54DCD0141_var*
begin
//#UC START# *479731C50290_57E54DCD0141_impl*
 f_List := nil;
 inherited;
//#UC END# *479731C50290_57E54DCD0141_impl*
end;//TmsmSomeModelElementsList.Cleanup

procedure TmsmSomeModelElementsList.ClearFields;
begin
 f_List := nil;
 inherited;
end;//TmsmSomeModelElementsList.ClearFields

end.
