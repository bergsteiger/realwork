unit nscDocumentHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Components"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Components/nscDocumentHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Components::DocumentHistory::TnscDocumentHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3LongintList,
  l3ProtoObject,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 InscDocumentHistoryListener = interface(IUnknown)
   ['{E3F0140D-3D5B-4963-845C-EAE93184D4DB}']
   procedure NewDocumentInHistory;
 end;//InscDocumentHistoryListener

 _ItemType_ = InscDocumentHistoryListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnscDocumentHistoryListenerList = class(_l3InterfacePtrList_)
 end;//TnscDocumentHistoryListenerList

 TnscDocumentHistory = class(Tl3ProtoObject)
 private
 // private fields
   f_List : Tl3LongintList;
   f_Listeners : TnscDocumentHistoryListenerList;
 private
 // private methods
   procedure NotifyListeners;
     {* Сигнатура метода NotifyListeners }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   procedure AddDocument(aDocId: Integer);
   function HasDocument(aDocId: Integer): Boolean;
   procedure AddListener(const aListener: InscDocumentHistoryListener);
   procedure RemoveListener(const aListener: InscDocumentHistoryListener);
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnscDocumentHistory;
    {- возвращает экземпляр синглетона. }
 end;//TnscDocumentHistory
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnscDocumentHistory

var g_TnscDocumentHistory : TnscDocumentHistory = nil;

procedure TnscDocumentHistoryFree;
begin
 l3Free(g_TnscDocumentHistory);
end;

class function TnscDocumentHistory.Instance: TnscDocumentHistory;
begin
 if (g_TnscDocumentHistory = nil) then
 begin
  l3System.AddExitProc(TnscDocumentHistoryFree);
  g_TnscDocumentHistory := Create;
 end;
 Result := g_TnscDocumentHistory;
end;


procedure TnscDocumentHistory.NotifyListeners;
//#UC START# *55E6CD920105_53D2281F0048_var*
var
 I: Integer;
//#UC END# *55E6CD920105_53D2281F0048_var*
begin
//#UC START# *55E6CD920105_53D2281F0048_impl*
 if Assigned(f_Listeners) then
  for I := 0 to f_Listeners.Count - 1 do
   f_Listeners[I].NewDocumentInHistory;
//#UC END# *55E6CD920105_53D2281F0048_impl*
end;//TnscDocumentHistory.NotifyListeners

procedure TnscDocumentHistory.AddDocument(aDocId: Integer);
//#UC START# *53D229400300_53D2281F0048_var*
//#UC END# *53D229400300_53D2281F0048_var*
begin
//#UC START# *53D229400300_53D2281F0048_impl*
 if not Assigned(f_List) then
  f_List := Tl3LongintList.Create;
 if f_List.IndexOf(aDocId) < 0 then
 begin
  f_List.Add(aDocId);
  NotifyListeners;
 end;
//#UC END# *53D229400300_53D2281F0048_impl*
end;//TnscDocumentHistory.AddDocument

function TnscDocumentHistory.HasDocument(aDocId: Integer): Boolean;
//#UC START# *53D2295603BA_53D2281F0048_var*
//#UC END# *53D2295603BA_53D2281F0048_var*
begin
//#UC START# *53D2295603BA_53D2281F0048_impl*
 Result := Assigned(f_List) and (f_List.IndexOf(aDocId) >= 0);
//#UC END# *53D2295603BA_53D2281F0048_impl*
end;//TnscDocumentHistory.HasDocument

procedure TnscDocumentHistory.AddListener(const aListener: InscDocumentHistoryListener);
//#UC START# *55E6CD570088_53D2281F0048_var*
//#UC END# *55E6CD570088_53D2281F0048_var*
begin
//#UC START# *55E6CD570088_53D2281F0048_impl*
 if not Assigned(f_Listeners) then
  f_Listeners := TnscDocumentHistoryListenerList.Create;
 f_Listeners.Add(aListener);
//#UC END# *55E6CD570088_53D2281F0048_impl*
end;//TnscDocumentHistory.AddListener

procedure TnscDocumentHistory.RemoveListener(const aListener: InscDocumentHistoryListener);
//#UC START# *55E6CD750386_53D2281F0048_var*
//#UC END# *55E6CD750386_53D2281F0048_var*
begin
//#UC START# *55E6CD750386_53D2281F0048_impl*
 if Assigned(f_Listeners) then
  f_Listeners.Remove(aListener);
//#UC END# *55E6CD750386_53D2281F0048_impl*
end;//TnscDocumentHistory.RemoveListener
type _Instance_R_ = TnscDocumentHistoryListenerList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

// start class TnscDocumentHistory

class function TnscDocumentHistory.Exists: Boolean;
 {-}
begin
 Result := g_TnscDocumentHistory <> nil;
end;//TnscDocumentHistory.Exists

procedure TnscDocumentHistory.Cleanup;
//#UC START# *479731C50290_53D2281F0048_var*
//#UC END# *479731C50290_53D2281F0048_var*
begin
//#UC START# *479731C50290_53D2281F0048_impl*
 FreeAndNil(f_Listeners);
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_53D2281F0048_impl*
end;//TnscDocumentHistory.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.