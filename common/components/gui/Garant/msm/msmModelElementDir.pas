unit msmModelElementDir;
 {* Список содержимого элемента в виде директории }

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementDir.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementDir" MUID: (57B1674A02B6)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewOfModelElement
 , msmElementViews
 , msmModelElements
 , l3Interfaces
;

type
 TmsmModelElementDir = class(TmsmViewOfModelElement, ImsmModelElementStringList)
  {* Список содержимого элемента в виде директории }
  private
   f_List: ImsmModelElementList;
   f_Parent: ImsmModelElement;
  protected
   function IsDir: Boolean; virtual;
   function Get_Item(anIndex: Integer): ImsmModelElement;
   function Get_Count: Integer;
   function Get_Owner: ImsmModelElement;
   function Get_Strings(anIndex: Integer): Il3CString;
   function Get_StringsToFind(anIndex: Integer): Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(const anElement: TmsmModelElementView); reintroduce;
   class function Make(const anElement: TmsmModelElementView): ImsmModelElementStringList; reintroduce;
   function IndexOfElementView(const anElement: ImsmModelElement): Integer;
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

constructor TmsmModelElementDir.Create(const anElement: TmsmModelElementView);
//#UC START# *57B1682902FF_57B1674A02B6_var*
//#UC END# *57B1682902FF_57B1674A02B6_var*
begin
//#UC START# *57B1682902FF_57B1674A02B6_impl*
 if (anElement.rElement = nil) then
  f_Parent := nil
 else
  f_Parent := anElement.rElement.Parent;
 if (anElement.rElement = nil) then
  f_List := nil
 else
  f_List := anElement.rElement.MEList[anElement.rListName];
 inherited Create(anElement);
//#UC END# *57B1682902FF_57B1674A02B6_impl*
end;//TmsmModelElementDir.Create

class function TmsmModelElementDir.Make(const anElement: TmsmModelElementView): ImsmModelElementStringList;
var
 l_Inst : TmsmModelElementDir;
begin
 l_Inst := Create(anElement);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmModelElementDir.Make

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
 Result := Element.rElement;
//#UC END# *57AE2E140297_57B1674A02B6get_impl*
end;//TmsmModelElementDir.Get_Owner

function TmsmModelElementDir.Get_Strings(anIndex: Integer): Il3CString;
//#UC START# *57AEBED1018D_57B1674A02B6get_var*
//#UC END# *57AEBED1018D_57B1674A02B6get_var*
begin
//#UC START# *57AEBED1018D_57B1674A02B6get_impl*
 Result := Get_Item(anIndex).StringProp[Element.rTextName];
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

function TmsmModelElementDir.IndexOfElementView(const anElement: ImsmModelElement): Integer;
//#UC START# *57D1327900BC_57B1674A02B6_var*
//#UC END# *57D1327900BC_57B1674A02B6_var*
begin
//#UC START# *57D1327900BC_57B1674A02B6_impl*
 if IsDir then
  if (f_Parent <> nil) then
   if f_Parent.IsSameElementView(anElement) then
   begin
    Result := 0;
    Exit;
   end;//f_Parent.IsSameElement(anElement)
 Result := f_List.IndexOfElementView(anElement);
 if (Result >= 0) then  
  if IsDir then
   if (f_Parent <> nil) then
    Inc(Result);
//#UC END# *57D1327900BC_57B1674A02B6_impl*
end;//TmsmModelElementDir.IndexOfElementView

procedure TmsmModelElementDir.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B1674A02B6_var*
//#UC END# *479731C50290_57B1674A02B6_var*
begin
//#UC START# *479731C50290_57B1674A02B6_impl*
 f_List := nil;
 f_Parent := nil;
 inherited;
//#UC END# *479731C50290_57B1674A02B6_impl*
end;//TmsmModelElementDir.Cleanup

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
 f_List := nil;
 f_Parent := nil;
 inherited;
end;//TmsmModelElementDir.ClearFields

end.
