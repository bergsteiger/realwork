unit nsSearchWindowManager;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsSearchWindowManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSearchWindowManager" MUID: (56163B0902D7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , BaseSearchInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsSearchWindow;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsSearchWindowList = class(_l3InterfacePtrList_)
 end;//TnsSearchWindowList

 TnsSearchWindowManager = class(Tl3ProtoDataContainer)
  private
   f_List: TnsSearchWindowList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Subscribe(const aListener: InsSearchWindow);
   procedure Unsubscribe(const aListener: InsSearchWindow);
   procedure CheckFindEnabled;
   class function Instance: TnsSearchWindowManager;
    {* Метод получения экземпляра синглетона TnsSearchWindowManager }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsSearchWindowManager
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
 //#UC START# *56163B0902D7impl_uses*
 //#UC END# *56163B0902D7impl_uses*
;

var g_TnsSearchWindowManager: TnsSearchWindowManager = nil;
 {* Экземпляр синглетона TnsSearchWindowManager }

procedure TnsSearchWindowManagerFree;
 {* Метод освобождения экземпляра синглетона TnsSearchWindowManager }
begin
 l3Free(g_TnsSearchWindowManager);
end;//TnsSearchWindowManagerFree

type _Instance_R_ = TnsSearchWindowList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

procedure TnsSearchWindowManager.Subscribe(const aListener: InsSearchWindow);
//#UC START# *56163C39024C_56163B0902D7_var*
//#UC END# *56163C39024C_56163B0902D7_var*
begin
//#UC START# *56163C39024C_56163B0902D7_impl*
 if not Assigned(f_List) then
  f_List := TnsSearchWindowList.Create;
 f_List.Add(aListener);
//#UC END# *56163C39024C_56163B0902D7_impl*
end;//TnsSearchWindowManager.Subscribe

procedure TnsSearchWindowManager.Unsubscribe(const aListener: InsSearchWindow);
//#UC START# *56163C5903DB_56163B0902D7_var*
//#UC END# *56163C5903DB_56163B0902D7_var*
begin
//#UC START# *56163C5903DB_56163B0902D7_impl*
 if Assigned(f_List) then
  f_List.Remove(aListener);
//#UC END# *56163C5903DB_56163B0902D7_impl*
end;//TnsSearchWindowManager.Unsubscribe

procedure TnsSearchWindowManager.CheckFindEnabled;
//#UC START# *56163C8A0267_56163B0902D7_var*
var
 I: Integer;
//#UC END# *56163C8A0267_56163B0902D7_var*
begin
//#UC START# *56163C8A0267_56163B0902D7_impl*
 if Assigned(f_List) then
  for I := 0 to f_List.Count - 1 do
   f_List[I].CheckFindEnabled;
//#UC END# *56163C8A0267_56163B0902D7_impl*
end;//TnsSearchWindowManager.CheckFindEnabled

class function TnsSearchWindowManager.Instance: TnsSearchWindowManager;
 {* Метод получения экземпляра синглетона TnsSearchWindowManager }
begin
 if (g_TnsSearchWindowManager = nil) then
 begin
  l3System.AddExitProc(TnsSearchWindowManagerFree);
  g_TnsSearchWindowManager := Create;
 end;
 Result := g_TnsSearchWindowManager;
end;//TnsSearchWindowManager.Instance

class function TnsSearchWindowManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsSearchWindowManager <> nil;
end;//TnsSearchWindowManager.Exists

procedure TnsSearchWindowManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56163B0902D7_var*
//#UC END# *479731C50290_56163B0902D7_var*
begin
//#UC START# *479731C50290_56163B0902D7_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_56163B0902D7_impl*
end;//TnsSearchWindowManager.Cleanup
{$IfEnd} // NOT Defined(Admin)

end.
