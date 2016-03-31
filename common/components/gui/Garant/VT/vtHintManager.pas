unit vtHintManager;

// Модуль: "w:\common\components\gui\Garant\VT\vtHintManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvtHintManager" MUID: (50C6241B0355)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ObjectList
 , vtMultilineHint
;

type
 TvtHintManager = class(Tl3ProtoObject)
  private
   f_Hints: Tl3ObjectList;
  protected
   function pm_GetItem(anIndex: Integer): TvtMultilineHint; virtual;
   function pm_GetCount: Integer; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Add(aHint: TvtMultilineHint);
   procedure Remove(aHint: TvtMultilineHint);
   class function Exists: Boolean;
   class function Instance: TvtHintManager;
    {* Метод получения экземпляра синглетона TvtHintManager }
  public
   property Item[anIndex: Integer]: TvtMultilineHint
    read pm_GetItem;
   property Count: Integer
    read pm_GetCount;
 end;//TvtHintManager

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , vtHintWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

var g_TvtHintManager: TvtHintManager = nil;
 {* Экземпляр синглетона TvtHintManager }

procedure TvtHintManagerFree;
 {* Метод освобождения экземпляра синглетона TvtHintManager }
begin
 l3Free(g_TvtHintManager);
end;//TvtHintManagerFree

function TvtHintManager.pm_GetItem(anIndex: Integer): TvtMultilineHint;
//#UC START# *50C734B60190_50C6241B0355get_var*
//#UC END# *50C734B60190_50C6241B0355get_var*
begin
//#UC START# *50C734B60190_50C6241B0355get_impl*
 Assert(Assigned(f_Hints));
 Result := TvtMultilineHint(f_Hints[anIndex]);
//#UC END# *50C734B60190_50C6241B0355get_impl*
end;//TvtHintManager.pm_GetItem

function TvtHintManager.pm_GetCount: Integer;
//#UC START# *50C7352402AD_50C6241B0355get_var*
//#UC END# *50C7352402AD_50C6241B0355get_var*
begin
//#UC START# *50C7352402AD_50C6241B0355get_impl*
 Assert(Assigned(f_Hints));
 if Assigned(f_Hints)
  then Result := f_Hints.Count
  else Result := 0;           
//#UC END# *50C7352402AD_50C6241B0355get_impl*
end;//TvtHintManager.pm_GetCount

procedure TvtHintManager.Add(aHint: TvtMultilineHint);
//#UC START# *50C624A002CF_50C6241B0355_var*
//#UC END# *50C624A002CF_50C6241B0355_var*
begin
//#UC START# *50C624A002CF_50C6241B0355_impl*
 f_Hints.Add(aHint);
//#UC END# *50C624A002CF_50C6241B0355_impl*
end;//TvtHintManager.Add

procedure TvtHintManager.Remove(aHint: TvtMultilineHint);
//#UC START# *50C624D30325_50C6241B0355_var*
//#UC END# *50C624D30325_50C6241B0355_var*
begin
//#UC START# *50C624D30325_50C6241B0355_impl*
 f_Hints.Remove(aHint);
//#UC END# *50C624D30325_50C6241B0355_impl*
end;//TvtHintManager.Remove

class function TvtHintManager.Exists: Boolean;
//#UC START# *52F9C53B0374_50C6241B0355_var*
//#UC END# *52F9C53B0374_50C6241B0355_var*
begin
//#UC START# *52F9C53B0374_50C6241B0355_impl*
 Result := g_TvtHintManager <> nil;
//#UC END# *52F9C53B0374_50C6241B0355_impl*
end;//TvtHintManager.Exists

class function TvtHintManager.Instance: TvtHintManager;
 {* Метод получения экземпляра синглетона TvtHintManager }
begin
 if (g_TvtHintManager = nil) then
 begin
  l3System.AddExitProc(TvtHintManagerFree);
  g_TvtHintManager := Create;
 end;
 Result := g_TvtHintManager;
end;//TvtHintManager.Instance

procedure TvtHintManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_50C6241B0355_var*
//#UC END# *479731C50290_50C6241B0355_var*
begin
//#UC START# *479731C50290_50C6241B0355_impl*
 l3Free(f_Hints);
 inherited;
//#UC END# *479731C50290_50C6241B0355_impl*
end;//TvtHintManager.Cleanup

procedure TvtHintManager.InitFields;
//#UC START# *47A042E100E2_50C6241B0355_var*
//#UC END# *47A042E100E2_50C6241B0355_var*
begin
//#UC START# *47A042E100E2_50C6241B0355_impl*
 inherited;
 f_Hints := Tl3ObjectList.Create;
//#UC END# *47A042E100E2_50C6241B0355_impl*
end;//TvtHintManager.InitFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtHintManager);
 {* Регистрация TvtHintManager }
{$IfEnd} // NOT Defined(NoScripts)

end.
