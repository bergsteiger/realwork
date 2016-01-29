unit nsSearchWindowManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsSearchWindowManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::BaseSearchUtils::TnsSearchWindowManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3ProtoDataContainer,
  BaseSearchInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _ItemType_ = InsSearchWindow;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsSearchWindowList = class(_l3InterfacePtrList_)
 end;//TnsSearchWindowList

 TnsSearchWindowManager = class(Tl3ProtoDataContainer)
 private
 // private fields
   f_List : TnsSearchWindowList;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   procedure Subscribe(const aListener: InsSearchWindow);
   procedure Unsubscribe(const aListener: InsSearchWindow);
   procedure CheckFindEnabled;
     {* Сигнатура метода CheckFindEnabled }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsSearchWindowManager;
    {- возвращает экземпляр синглетона. }
 end;//TnsSearchWindowManager
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


// start class TnsSearchWindowManager

var g_TnsSearchWindowManager : TnsSearchWindowManager = nil;

procedure TnsSearchWindowManagerFree;
begin
 l3Free(g_TnsSearchWindowManager);
end;

class function TnsSearchWindowManager.Instance: TnsSearchWindowManager;
begin
 if (g_TnsSearchWindowManager = nil) then
 begin
  l3System.AddExitProc(TnsSearchWindowManagerFree);
  g_TnsSearchWindowManager := Create;
 end;
 Result := g_TnsSearchWindowManager;
end;


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
type _Instance_R_ = TnsSearchWindowList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

// start class TnsSearchWindowManager

class function TnsSearchWindowManager.Exists: Boolean;
 {-}
begin
 Result := g_TnsSearchWindowManager <> nil;
end;//TnsSearchWindowManager.Exists

procedure TnsSearchWindowManager.Cleanup;
//#UC START# *479731C50290_56163B0902D7_var*
//#UC END# *479731C50290_56163B0902D7_var*
begin
//#UC START# *479731C50290_56163B0902D7_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_56163B0902D7_impl*
end;//TnsSearchWindowManager.Cleanup

{$IfEnd} //not Admin

end.