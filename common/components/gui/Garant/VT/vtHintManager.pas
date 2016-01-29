unit vtHintManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/vtHintManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT::Hints::TvtHintManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3ObjectList,
  l3ProtoObject,
  vtMultilineHint
  ;

type
 TvtHintManager = class(Tl3ProtoObject)
 private
 // private fields
   f_Hints : Tl3ObjectList;
 protected
 // property methods
   function pm_GetItem(anIndex: Integer): TvtMultilineHint; virtual;
   function pm_GetCount: Integer; virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   procedure Add(aHint: TvtMultilineHint);
   procedure Remove(aHint: TvtMultilineHint);
   class function Exists: Boolean;
 public
 // public properties
   property Item[anIndex: Integer]: TvtMultilineHint
     read pm_GetItem;
   property Count: Integer
     read pm_GetCount;
 public
 // singleton factory method
   class function Instance: TvtHintManager;
    {- возвращает экземпляр синглетона. }
 end;//TvtHintManager

implementation

uses
  l3Base {a}
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtHintWordsPack
  {$IfEnd} //not NoScripts
  
  ;


// start class TvtHintManager

var g_TvtHintManager : TvtHintManager = nil;

procedure TvtHintManagerFree;
begin
 l3Free(g_TvtHintManager);
end;

class function TvtHintManager.Instance: TvtHintManager;
begin
 if (g_TvtHintManager = nil) then
 begin
  l3System.AddExitProc(TvtHintManagerFree);
  g_TvtHintManager := Create;
 end;
 Result := g_TvtHintManager;
end;


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

procedure TvtHintManager.Cleanup;
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
{$If not defined(NoScripts)}
// Регистрация TvtHintManager
 TtfwClassRef.Register(TvtHintManager);
{$IfEnd} //not NoScripts

end.