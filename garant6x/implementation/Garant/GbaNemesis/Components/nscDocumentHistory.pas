unit nscDocumentHistory;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Components\nscDocumentHistory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscDocumentHistory" MUID: (53D2281F0048)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3LongintList
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 InscDocumentHistoryListener = interface
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
   f_List: Tl3LongintList;
   f_Listeners: TnscDocumentHistoryListenerList;
  private
   procedure NotifyListeners;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddDocument(aDocId: Integer);
   function HasDocument(aDocId: Integer): Boolean;
   procedure AddListener(const aListener: InscDocumentHistoryListener);
   procedure RemoveListener(const aListener: InscDocumentHistoryListener);
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnscDocumentHistory;
    {* Метод получения экземпляра синглетона TnscDocumentHistory }
 end;//TnscDocumentHistory
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

var g_TnscDocumentHistory: TnscDocumentHistory = nil;
 {* Экземпляр синглетона TnscDocumentHistory }

procedure TnscDocumentHistoryFree;
 {* Метод освобождения экземпляра синглетона TnscDocumentHistory }
begin
 l3Free(g_TnscDocumentHistory);
end;//TnscDocumentHistoryFree

type _Instance_R_ = TnscDocumentHistoryListenerList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

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

class function TnscDocumentHistory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnscDocumentHistory <> nil;
end;//TnscDocumentHistory.Exists

class function TnscDocumentHistory.Instance: TnscDocumentHistory;
 {* Метод получения экземпляра синглетона TnscDocumentHistory }
begin
 if (g_TnscDocumentHistory = nil) then
 begin
  l3System.AddExitProc(TnscDocumentHistoryFree);
  g_TnscDocumentHistory := Create;
 end;
 Result := g_TnscDocumentHistory;
end;//TnscDocumentHistory.Instance

procedure TnscDocumentHistory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53D2281F0048_var*
//#UC END# *479731C50290_53D2281F0048_var*
begin
//#UC START# *479731C50290_53D2281F0048_impl*
 FreeAndNil(f_Listeners);
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_53D2281F0048_impl*
end;//TnscDocumentHistory.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
