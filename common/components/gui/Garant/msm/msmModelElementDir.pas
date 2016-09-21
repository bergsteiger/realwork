unit msmModelElementDir;
 {* Список содержимого элемента в виде директории }

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementDir.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementDir" MUID: (57B1674A02B6)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmElementViews
 , msmModelElements
 , l3Interfaces
;

type
 TmsmModelElementDir = class(Tl3ProtoObject, ImsmModelElementStringList)
  {* Список содержимого элемента в виде директории }
  private
   f_TextName: AnsiString;
   f_List: ImsmModelElementList;
   f_Parent: ImsmModelElement;
  protected
   function IsDir: Boolean; virtual;
   function Get_Item(anIndex: Integer): ImsmModelElement;
   function Get_Count: Integer;
   function Get_Owner: ImsmModelElement;
   function Get_Strings(anIndex: Integer): Il3CString;
   function Get_StringsToFind(anIndex: Integer): Il3CString;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(const aList: ImsmModelElementList;
    const aTextName: AnsiString); reintroduce; overload;
   class function Make(const aList: ImsmModelElementList;
    const aTextName: AnsiString): ImsmModelElementStringList; reintroduce;
   constructor Create(const aParent: ImsmModelElement;
    const aList: ImsmModelElementList;
    const aTextName: AnsiString); reintroduce; overload;
   function IndexOf(const anElement: ImsmModelElement): Integer;
 end;//TmsmModelElementDir

implementation

uses
 l3ImplUses
 , tfwCStringFactory
 //#UC START# *57B1674A02B6impl_uses*
 , StrUtils
 , l3String
 , l3Base
 //#UC END# *57B1674A02B6impl_uses*
;

constructor TmsmModelElementDir.Create(const aList: ImsmModelElementList;
 const aTextName: AnsiString);
//#UC START# *57B1682902FF_57B1674A02B6_var*
//#UC END# *57B1682902FF_57B1674A02B6_var*
begin
//#UC START# *57B1682902FF_57B1674A02B6_impl*
 Assert(aList <> nil);
 Assert(aTextName <> '');
 Create(aList.Owner.Parent, aList, aTextName);
//#UC END# *57B1682902FF_57B1674A02B6_impl*
end;//TmsmModelElementDir.Create

class function TmsmModelElementDir.Make(const aList: ImsmModelElementList;
 const aTextName: AnsiString): ImsmModelElementStringList;
var
 l_Inst : TmsmModelElementDir;
begin
 l_Inst := Create(aList, aTextName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmModelElementDir.Make

constructor TmsmModelElementDir.Create(const aParent: ImsmModelElement;
 const aList: ImsmModelElementList;
 const aTextName: AnsiString);
//#UC START# *57B33A9E00C7_57B1674A02B6_var*
//#UC END# *57B33A9E00C7_57B1674A02B6_var*
begin
//#UC START# *57B33A9E00C7_57B1674A02B6_impl*
 Assert(aList <> nil);
 Assert(aTextName <> '');
 f_Parent := aParent;
 f_List := aList;
 f_TextName := aTextName;
 inherited Create;
//#UC END# *57B33A9E00C7_57B1674A02B6_impl*
end;//TmsmModelElementDir.Create

function TmsmModelElementDir.IsDir: Boolean;
//#UC START# *57B57DE500CF_57B1674A02B6_var*
//#UC END# *57B57DE500CF_57B1674A02B6_var*
begin
//#UC START# *57B57DE500CF_57B1674A02B6_impl*
 Result := true;
//#UC END# *57B57DE500CF_57B1674A02B6_impl*
end;//TmsmModelElementDir.IsDir

function TmsmModelElementDir.Get_Item(anIndex: Integer): ImsmModelElement;
//#UC START# *57AAD86403AD_57B1674A02B6get_var*
//#UC END# *57AAD86403AD_57B1674A02B6get_var*
begin
//#UC START# *57AAD86403AD_57B1674A02B6get_impl*
 if (anIndex < 0) then
  Result := nil
 else
 begin
  if IsDir then
   if (f_Parent <> nil) then
   begin
    if (anIndex = 0) then
    begin
     Result := f_Parent;
     Exit;
    end;//anIndex = 0
    Dec(anIndex);
   end;//f_Parent <> nil
  Result := f_List[anIndex];
 end;//anIndex < 0
//#UC END# *57AAD86403AD_57B1674A02B6get_impl*
end;//TmsmModelElementDir.Get_Item

function TmsmModelElementDir.Get_Count: Integer;
//#UC START# *57AAD89C0277_57B1674A02B6get_var*
//#UC END# *57AAD89C0277_57B1674A02B6get_var*
begin
//#UC START# *57AAD89C0277_57B1674A02B6get_impl*
 Result := f_List.Count;
 if IsDir then
  if (f_Parent <> nil) then
   Inc(Result);
//#UC END# *57AAD89C0277_57B1674A02B6get_impl*
end;//TmsmModelElementDir.Get_Count

function TmsmModelElementDir.Get_Owner: ImsmModelElement;
//#UC START# *57AE2E140297_57B1674A02B6get_var*
//#UC END# *57AE2E140297_57B1674A02B6get_var*
begin
//#UC START# *57AE2E140297_57B1674A02B6get_impl*
 Result := f_List.Owner;
//#UC END# *57AE2E140297_57B1674A02B6get_impl*
end;//TmsmModelElementDir.Get_Owner

function TmsmModelElementDir.Get_Strings(anIndex: Integer): Il3CString;
//#UC START# *57AEBED1018D_57B1674A02B6get_var*
//#UC END# *57AEBED1018D_57B1674A02B6get_var*
begin
//#UC START# *57AEBED1018D_57B1674A02B6get_impl*
 Result := Get_Item(anIndex).StringProp[f_TextName];
 if IsDir then
  if (anIndex = 0) AND (f_Parent <> nil) then
  begin
   if IsDir then
    Result := TtfwCStringFactory.Cat(TtfwCStringFactory.C('.. '), Result);
  end;//(anIndex = 0) AND (f_Parent <> nil)
//#UC END# *57AEBED1018D_57B1674A02B6get_impl*
end;//TmsmModelElementDir.Get_Strings

function TmsmModelElementDir.Get_StringsToFind(anIndex: Integer): Il3CString;
//#UC START# *57B6C7D40215_57B1674A02B6get_var*
//#UC END# *57B6C7D40215_57B1674A02B6get_var*
begin
//#UC START# *57B6C7D40215_57B1674A02B6get_impl*
 Result := Get_Item(anIndex).StringProp['DefaultSearchText'];
//#UC END# *57B6C7D40215_57B1674A02B6get_impl*
end;//TmsmModelElementDir.Get_StringsToFind

function TmsmModelElementDir.IndexOf(const anElement: ImsmModelElement): Integer;
//#UC START# *57D1327900BC_57B1674A02B6_var*
//#UC END# *57D1327900BC_57B1674A02B6_var*
begin
//#UC START# *57D1327900BC_57B1674A02B6_impl*
 if IsDir then
  if (f_Parent <> nil) then
   if f_Parent.IsSameElement(anElement) then
   begin
    Result := 0;
    Exit;
   end;//f_Parent.IsSameElement(anElement)
 Result := f_List.IndexOf(anElement);
 if (Result >= 0) then  
  if IsDir then
   if (f_Parent <> nil) then
    Inc(Result);
//#UC END# *57D1327900BC_57B1674A02B6_impl*
end;//TmsmModelElementDir.IndexOf

{$If NOT Defined(DesignTimeLibrary)}
class function TmsmModelElementDir.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_57B1674A02B6_var*
//#UC END# *47A6FEE600FC_57B1674A02B6_var*
begin
//#UC START# *47A6FEE600FC_57B1674A02B6_impl*
 Result := true;
//#UC END# *47A6FEE600FC_57B1674A02B6_impl*
end;//TmsmModelElementDir.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TmsmModelElementDir.ClearFields;
begin
 f_TextName := '';
 f_List := nil;
 f_Parent := nil;
 inherited;
end;//TmsmModelElementDir.ClearFields

end.
