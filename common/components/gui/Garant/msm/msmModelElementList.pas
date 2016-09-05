unit msmModelElementList;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementList" MUID: (57AADABA0154)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , msmModelElements
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TmsmModelElementList = class(Tl3CProtoObject, ImsmModelElementList)
  private
   f_List: ItfwValueList;
   f_Parent: TtfwWord;
   f_ListName: AnsiString;
  protected
   function Get_Item(anIndex: Integer): ImsmModelElement;
   function Get_Count: Integer;
   function Get_Owner: ImsmModelElement;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(aParent: TtfwWord;
    const aList: ItfwValueList;
    const aListName: AnsiString); reintroduce;
   class function Make(aParent: TtfwWord;
    const aList: ItfwValueList;
    const aListName: AnsiString): ImsmModelElementList; reintroduce;
 end;//TmsmModelElementList

implementation

uses
 l3ImplUses
 , msmModelElementFactory
 //#UC START# *57AADABA0154impl_uses*
 //#UC END# *57AADABA0154impl_uses*
;

constructor TmsmModelElementList.Create(aParent: TtfwWord;
 const aList: ItfwValueList;
 const aListName: AnsiString);
//#UC START# *57AADC1802AE_57AADABA0154_var*
//#UC END# *57AADC1802AE_57AADABA0154_var*
begin
//#UC START# *57AADC1802AE_57AADABA0154_impl*
 //Assert(aList <> nil);
 inherited Create;
 f_List := aList;
 f_Parent := aParent;
 f_ListName := aListName;
//#UC END# *57AADC1802AE_57AADABA0154_impl*
end;//TmsmModelElementList.Create

class function TmsmModelElementList.Make(aParent: TtfwWord;
 const aList: ItfwValueList;
 const aListName: AnsiString): ImsmModelElementList;
var
 l_Inst : TmsmModelElementList;
begin
 l_Inst := Create(aParent, aList, aListName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmModelElementList.Make

function TmsmModelElementList.Get_Item(anIndex: Integer): ImsmModelElement;
//#UC START# *57AAD86403AD_57AADABA0154get_var*
//#UC END# *57AAD86403AD_57AADABA0154get_var*
begin
//#UC START# *57AAD86403AD_57AADABA0154get_impl*
 if (f_List = nil) then
 begin
  Result := nil;
 end//f_List = nil
 else
  Result := TmsmModelElementFactory.Make(f_List.Items[anIndex].AsObject As TtfwWord);
//#UC END# *57AAD86403AD_57AADABA0154get_impl*
end;//TmsmModelElementList.Get_Item

function TmsmModelElementList.Get_Count: Integer;
//#UC START# *57AAD89C0277_57AADABA0154get_var*
//#UC END# *57AAD89C0277_57AADABA0154get_var*
begin
//#UC START# *57AAD89C0277_57AADABA0154get_impl*
 if (f_List = nil) then
  Result := 0
 else
  Result := f_List.Count;
//#UC END# *57AAD89C0277_57AADABA0154get_impl*
end;//TmsmModelElementList.Get_Count

function TmsmModelElementList.Get_Owner: ImsmModelElement;
//#UC START# *57AE2E140297_57AADABA0154get_var*
//#UC END# *57AE2E140297_57AADABA0154get_var*
begin
//#UC START# *57AE2E140297_57AADABA0154get_impl*
 Result := TmsmModelElementFactory.Make(f_Parent);
//#UC END# *57AE2E140297_57AADABA0154get_impl*
end;//TmsmModelElementList.Get_Owner

procedure TmsmModelElementList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57AADABA0154_var*
//#UC END# *479731C50290_57AADABA0154_var*
begin
//#UC START# *479731C50290_57AADABA0154_impl*
 f_Parent := nil;
 inherited;
//#UC END# *479731C50290_57AADABA0154_impl*
end;//TmsmModelElementList.Cleanup

procedure TmsmModelElementList.ClearFields;
begin
 f_List := nil;
 f_ListName := '';
 inherited;
end;//TmsmModelElementList.ClearFields

end.
