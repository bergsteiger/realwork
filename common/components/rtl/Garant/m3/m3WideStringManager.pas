unit m3WideStringManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3WideStringManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3WideStringManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3WideStringManager
  ;

type
 Tm3WideStringManager = class(Tl3WideStringManager)
 private
 // private fields
   f_CanFreeBlocks : Integer;
 protected
 // overridden protected methods
   function CanFreeBlocks: Boolean; override;
 public
 // public methods
   constructor Create; reintroduce;
   procedure LockFree;
     {* Сигнатура метода LockFree }
   procedure UnlockFree;
     {* Сигнатура метода UnlockFree }
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: Tm3WideStringManager;
    {- возвращает экземпляр синглетона. }
 end;//Tm3WideStringManager

implementation

uses
  l3Base {a},
  l3SimpleMM
  ;


// start class Tm3WideStringManager

var g_Tm3WideStringManager : Tm3WideStringManager = nil;

procedure Tm3WideStringManagerFree;
begin
 l3Free(g_Tm3WideStringManager);
end;

class function Tm3WideStringManager.Instance: Tm3WideStringManager;
begin
 if (g_Tm3WideStringManager = nil) then
 begin
  l3System.AddExitProc(Tm3WideStringManagerFree);
  g_Tm3WideStringManager := Create;
 end;
 Result := g_Tm3WideStringManager;
end;


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

function Tm3WideStringManager.CanFreeBlocks: Boolean;
//#UC START# *545A2F6800D6_5459E3FB0365_var*
//#UC END# *545A2F6800D6_5459E3FB0365_var*
begin
//#UC START# *545A2F6800D6_5459E3FB0365_impl*
 Result := (f_CanFreeBlocks <= 0) AND inherited CanFreeBlocks;
//#UC END# *545A2F6800D6_5459E3FB0365_impl*
end;//Tm3WideStringManager.CanFreeBlocks

end.