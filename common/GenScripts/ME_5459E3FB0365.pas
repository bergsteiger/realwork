unit m3WideStringManager;

// Модуль: "w:\common\components\rtl\Garant\m3\m3WideStringManager.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3WideStringManager
;

type
 Tm3WideStringManager = class(Tl3WideStringManager)
  private
   f_CanFreeBlocks: Integer;
  protected
   function CanFreeBlocks: Boolean; override;
  public
   constructor Create; reintroduce;
   procedure LockFree;
   procedure UnlockFree;
   class function Exists: Boolean;
   class function Instance: Tm3WideStringManager;
    {* Метод получения экземпляра синглетона Tm3WideStringManager }
 end;//Tm3WideStringManager

implementation

uses
 l3ImplUses
 , l3SimpleMM
 , SysUtils
 , l3Base
;

var g_Tm3WideStringManager: Tm3WideStringManager = nil;
 {* Экземпляр синглетона Tm3WideStringManager }

procedure Tm3WideStringManagerFree;
 {* Метод освобождения экземпляра синглетона Tm3WideStringManager }
begin
 l3Free(g_Tm3WideStringManager);
end;//Tm3WideStringManagerFree

constructor Tm3WideStringManager.Create;
//#UC START# *5459E9360228_5459E3FB0365_var*
//#UC END# *5459E9360228_5459E3FB0365_var*
begin
//#UC START# *5459E9360228_5459E3FB0365_impl*
 f_CanFreeBlocks := 0;
 inherited Create({64} 1024 * 1024 * 8);
//#UC END# *5459E9360228_5459E3FB0365_impl*
end;//Tm3WideStringManager.Create

procedure Tm3WideStringManager.LockFree;
//#UC START# *545A3464034C_5459E3FB0365_var*
//#UC END# *545A3464034C_5459E3FB0365_var*
begin
//#UC START# *545A3464034C_5459E3FB0365_impl*
 Inc(f_CanFreeBlocks);
//#UC END# *545A3464034C_5459E3FB0365_impl*
end;//Tm3WideStringManager.LockFree

procedure Tm3WideStringManager.UnlockFree;
//#UC START# *545A3476006F_5459E3FB0365_var*
//#UC END# *545A3476006F_5459E3FB0365_var*
begin
//#UC START# *545A3476006F_5459E3FB0365_impl*
 Dec(f_CanFreeBlocks);
 Assert(f_CanFreeBlocks >= 0);
 if (f_CanFreeBlocks <= 0) then
  if CanFreeBlocks then
   FreeBlocks;
//#UC END# *545A3476006F_5459E3FB0365_impl*
end;//Tm3WideStringManager.UnlockFree

class function Tm3WideStringManager.Exists: Boolean;
//#UC START# *545A46C20284_5459E3FB0365_var*
//#UC END# *545A46C20284_5459E3FB0365_var*
begin
//#UC START# *545A46C20284_5459E3FB0365_impl*
 Result := (g_Tm3WideStringManager <> nil);
//#UC END# *545A46C20284_5459E3FB0365_impl*
end;//Tm3WideStringManager.Exists

class function Tm3WideStringManager.Instance: Tm3WideStringManager;
 {* Метод получения экземпляра синглетона Tm3WideStringManager }
begin
 if (g_Tm3WideStringManager = nil) then
 begin
  l3System.AddExitProc(Tm3WideStringManagerFree);
  g_Tm3WideStringManager := Create;
 end;
 Result := g_Tm3WideStringManager;
end;//Tm3WideStringManager.Instance

function Tm3WideStringManager.CanFreeBlocks: Boolean;
//#UC START# *545A2F6800D6_5459E3FB0365_var*
//#UC END# *545A2F6800D6_5459E3FB0365_var*
begin
//#UC START# *545A2F6800D6_5459E3FB0365_impl*
 Result := (f_CanFreeBlocks <= 0) AND inherited CanFreeBlocks;
//#UC END# *545A2F6800D6_5459E3FB0365_impl*
end;//Tm3WideStringManager.CanFreeBlocks

end.
