unit spHelpNotifyManager;

// Модуль: "w:\common\components\gui\Garant\AFW\spHelpNotifyManager.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3SimpleDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 IspHelpNotifyListener = interface
  ['{8BA8A002-A9CD-406C-BB04-02C173974511}']
  procedure HelpShown;
 end;//IspHelpNotifyListener

 _ItemType_ = IspHelpNotifyListener;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TspHelpNotifyListenerList = class(_l3InterfacePtrList_)
 end;//TspHelpNotifyListenerList

 TspHelpNotifyManager = class(Tl3ProtoObject)
  private
   f_Listeners: TspHelpNotifyListenerList;
  private
   class function Exists: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class procedure AddListener(const aListener: IspHelpNotifyListener);
   class procedure RemoveListener(const aListener: IspHelpNotifyListener);
   class procedure HelpShown;
   class function Instance: TspHelpNotifyManager;
    {* Метод получения экземпляра синглетона TspHelpNotifyManager }
 end;//TspHelpNotifyManager

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

var g_TspHelpNotifyManager: TspHelpNotifyManager = nil;
 {* Экземпляр синглетона TspHelpNotifyManager }

procedure TspHelpNotifyManagerFree;
 {* Метод освобождения экземпляра синглетона TspHelpNotifyManager }
begin
 l3Free(g_TspHelpNotifyManager);
end;//TspHelpNotifyManagerFree

type _Instance_R_ = TspHelpNotifyListenerList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

class procedure TspHelpNotifyManager.AddListener(const aListener: IspHelpNotifyListener);
//#UC START# *53760C6703AB_53760B2701DD_var*
//#UC END# *53760C6703AB_53760B2701DD_var*
begin
//#UC START# *53760C6703AB_53760B2701DD_impl*
 if Instance.f_Listeners.IndexOf(aListener) = -1 then
  Instance.f_Listeners.Add(aListener);
//#UC END# *53760C6703AB_53760B2701DD_impl*
end;//TspHelpNotifyManager.AddListener

class procedure TspHelpNotifyManager.RemoveListener(const aListener: IspHelpNotifyListener);
//#UC START# *53760C9201F9_53760B2701DD_var*
//#UC END# *53760C9201F9_53760B2701DD_var*
begin
//#UC START# *53760C9201F9_53760B2701DD_impl*
 if Exists then
  Instance.f_Listeners.Remove(aListener);
//#UC END# *53760C9201F9_53760B2701DD_impl*
end;//TspHelpNotifyManager.RemoveListener

class procedure TspHelpNotifyManager.HelpShown;
//#UC START# *53760DE9006D_53760B2701DD_var*
var
 I: Integer;
//#UC END# *53760DE9006D_53760B2701DD_var*
begin
//#UC START# *53760DE9006D_53760B2701DD_impl*
 if Exists then
  for I := 0 to Instance.f_Listeners.Count - 1 do
   Instance.f_Listeners[I].HelpShown;
//#UC END# *53760DE9006D_53760B2701DD_impl*
end;//TspHelpNotifyManager.HelpShown

class function TspHelpNotifyManager.Exists: Boolean;
//#UC START# *53763D88015E_53760B2701DD_var*
//#UC END# *53763D88015E_53760B2701DD_var*
begin
//#UC START# *53763D88015E_53760B2701DD_impl*
 Result := Assigned(g_TspHelpNotifyManager);
//#UC END# *53763D88015E_53760B2701DD_impl*
end;//TspHelpNotifyManager.Exists

class function TspHelpNotifyManager.Instance: TspHelpNotifyManager;
 {* Метод получения экземпляра синглетона TspHelpNotifyManager }
begin
 if (g_TspHelpNotifyManager = nil) then
 begin
  l3System.AddExitProc(TspHelpNotifyManagerFree);
  g_TspHelpNotifyManager := Create;
 end;
 Result := g_TspHelpNotifyManager;
end;//TspHelpNotifyManager.Instance

procedure TspHelpNotifyManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53760B2701DD_var*
//#UC END# *479731C50290_53760B2701DD_var*
begin
//#UC START# *479731C50290_53760B2701DD_impl*
 FreeAndNil(f_Listeners);
 inherited;
//#UC END# *479731C50290_53760B2701DD_impl*
end;//TspHelpNotifyManager.Cleanup

procedure TspHelpNotifyManager.InitFields;
//#UC START# *47A042E100E2_53760B2701DD_var*
//#UC END# *47A042E100E2_53760B2701DD_var*
begin
//#UC START# *47A042E100E2_53760B2701DD_impl*
 inherited;
 f_Listeners := TspHelpNotifyListenerList.Create;
//#UC END# *47A042E100E2_53760B2701DD_impl*
end;//TspHelpNotifyManager.InitFields

end.
