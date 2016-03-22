unit m3BranchHandlePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3BranchHandlePrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3BranchHandlePrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3ProtoObject,
  l3SimpleMemoryManager
  ;

type
 Tm3BranchHandlePrimData = record
   Hash : Word;
   Value : PWideChar;
 end;//Tm3BranchHandlePrimData

 Tm3BranchHandlesManager = class(Tl3SimpleMemoryManager)
 public
 // public methods
   constructor Create; reintroduce;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tm3BranchHandlesManager;
    {- возвращает экземпляр синглетона. }
 end;//Tm3BranchHandlesManager

 Tm3BranchHandlePrim = class(Tl3ProtoObject)
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
   class function AllocInstanceMem: TObject; override;
   procedure FreeInstanceMem; override;
 public
 // public fields
   Data : Tm3BranchHandlePrimData;
 end;//Tm3BranchHandlePrim
 Pm3BranchHandlePrim = ^Tm3BranchHandlePrim;


implementation

uses
  l3Base {a},
  m3BranchHandle,
  m3WideStringManager
  ;


// start class Tm3BranchHandlesManager

var g_Tm3BranchHandlesManager : Tm3BranchHandlesManager = nil;

procedure Tm3BranchHandlesManagerFree;
begin
 l3Free(g_Tm3BranchHandlesManager);
end;

class function Tm3BranchHandlesManager.Instance: Tm3BranchHandlesManager;
begin
 if (g_Tm3BranchHandlesManager = nil) then
 begin
  l3System.AddExitProc(Tm3BranchHandlesManagerFree);
  g_Tm3BranchHandlesManager := Create;
 end;
 Result := g_Tm3BranchHandlesManager;
end;


constructor Tm3BranchHandlesManager.Create;
//#UC START# *5453B6CA01AD_5453B699001A_var*
//#UC END# *5453B6CA01AD_5453B699001A_var*
begin
//#UC START# *5453B6CA01AD_5453B699001A_impl*
 inherited Create({64} 1024 * 1024 * Tm3BranchHandle.InstanceSize)
//#UC END# *5453B6CA01AD_5453B699001A_impl*
end;//Tm3BranchHandlesManager.Create

class function Tm3BranchHandlesManager.Exists: Boolean;
 {-}
begin
 Result := g_Tm3BranchHandlesManager <> nil;
end;//Tm3BranchHandlesManager.Exists

procedure Tm3BranchHandlePrim.Cleanup;
//#UC START# *479731C50290_5453AB7202EC_var*
//#UC END# *479731C50290_5453AB7202EC_var*
begin
//#UC START# *479731C50290_5453AB7202EC_impl*
 inherited;
 if Tm3WideStringManager.Exists then
  Tm3WideStringManager.Instance.FreeItem(Data.Value);
//#UC END# *479731C50290_5453AB7202EC_impl*
end;//Tm3BranchHandlePrim.Cleanup

{$If not defined(DesignTimeLibrary)}
class function Tm3BranchHandlePrim.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_5453AB7202EC_var*
//#UC END# *47A6FEE600FC_5453AB7202EC_var*
begin
//#UC START# *47A6FEE600FC_5453AB7202EC_impl*
 Result := false;
 // - т.к. кешируем другими средствами
//#UC END# *47A6FEE600FC_5453AB7202EC_impl*
end;//Tm3BranchHandlePrim.IsCacheable
{$IfEnd} //not DesignTimeLibrary

class function Tm3BranchHandlePrim.AllocInstanceMem: TObject;
//#UC START# *5453AC3702B2_5453AB7202EC_var*
//#UC END# *5453AC3702B2_5453AB7202EC_var*
begin
//#UC START# *5453AC3702B2_5453AB7202EC_impl*
 Tm3BranchHandlesManager.Instance.GetMem(Result, InstanceSize);
 Result := InitInstance(Result);
//#UC END# *5453AC3702B2_5453AB7202EC_impl*
end;//Tm3BranchHandlePrim.AllocInstanceMem

procedure Tm3BranchHandlePrim.FreeInstanceMem;
//#UC START# *5453AC66022A_5453AB7202EC_var*
var
 l_Fake : Pointer;
//#UC END# *5453AC66022A_5453AB7202EC_var*
begin
//#UC START# *5453AC66022A_5453AB7202EC_impl*
 CleanupInstance;
 l_Fake := Self;
 Tm3BranchHandlesManager.Instance.FreeMem(l_Fake);
//#UC END# *5453AC66022A_5453AB7202EC_impl*
end;//Tm3BranchHandlePrim.FreeInstanceMem

end.