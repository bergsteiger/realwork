unit m3BranchHandlePrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3BranchHandlePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3BranchHandlePrim" MUID: (5453AB7202EC)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3SimpleMemoryManager
;

type
 Pm3BranchHandlePrim = ^Tm3BranchHandlePrim;

 Tm3BranchHandlePrimData = record
  Hash: Word;
  Value: PWideChar;
 end;//Tm3BranchHandlePrimData

 Tm3BranchHandlesManager = class(Tl3SimpleMemoryManager)
  public
   constructor Create; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tm3BranchHandlesManager;
    {* Метод получения экземпляра синглетона Tm3BranchHandlesManager }
 end;//Tm3BranchHandlesManager

 Tm3BranchHandlePrim = class(Tl3ProtoObject)
  public
   Data: Tm3BranchHandlePrimData;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   class function AllocInstanceMem: TObject; override;
   procedure FreeInstanceMem; override;
 end;//Tm3BranchHandlePrim

implementation

uses
 l3ImplUses
 , m3WideStringManager
 , m3BranchHandle
 , SysUtils
 , l3Base
;

var g_Tm3BranchHandlesManager: Tm3BranchHandlesManager = nil;
 {* Экземпляр синглетона Tm3BranchHandlesManager }

procedure Tm3BranchHandlesManagerFree;
 {* Метод освобождения экземпляра синглетона Tm3BranchHandlesManager }
begin
 l3Free(g_Tm3BranchHandlesManager);
end;//Tm3BranchHandlesManagerFree

constructor Tm3BranchHandlesManager.Create;
//#UC START# *5453B6CA01AD_5453B699001A_var*
//#UC END# *5453B6CA01AD_5453B699001A_var*
begin
//#UC START# *5453B6CA01AD_5453B699001A_impl*
 inherited Create({64} 1024 * 1024 * Tm3BranchHandle.InstanceSize)
//#UC END# *5453B6CA01AD_5453B699001A_impl*
end;//Tm3BranchHandlesManager.Create

class function Tm3BranchHandlesManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tm3BranchHandlesManager <> nil;
end;//Tm3BranchHandlesManager.Exists

class function Tm3BranchHandlesManager.Instance: Tm3BranchHandlesManager;
 {* Метод получения экземпляра синглетона Tm3BranchHandlesManager }
begin
 if (g_Tm3BranchHandlesManager = nil) then
 begin
  l3System.AddExitProc(Tm3BranchHandlesManagerFree);
  g_Tm3BranchHandlesManager := Create;
 end;
 Result := g_Tm3BranchHandlesManager;
end;//Tm3BranchHandlesManager.Instance

procedure Tm3BranchHandlePrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5453AB7202EC_var*
//#UC END# *479731C50290_5453AB7202EC_var*
begin
//#UC START# *479731C50290_5453AB7202EC_impl*
 inherited;
 if Tm3WideStringManager.Exists then
  Tm3WideStringManager.Instance.FreeItem(Data.Value);
//#UC END# *479731C50290_5453AB7202EC_impl*
end;//Tm3BranchHandlePrim.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function Tm3BranchHandlePrim.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_5453AB7202EC_var*
//#UC END# *47A6FEE600FC_5453AB7202EC_var*
begin
//#UC START# *47A6FEE600FC_5453AB7202EC_impl*
 Result := false;
 // - т.к. кешируем другими средствами
//#UC END# *47A6FEE600FC_5453AB7202EC_impl*
end;//Tm3BranchHandlePrim.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

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
