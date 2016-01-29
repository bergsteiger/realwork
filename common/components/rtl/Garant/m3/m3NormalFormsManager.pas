unit m3NormalFormsManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3NormalFormsManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3NormalFormsManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3SizedPoolManager
  ;

type
 Tm3NormalFormsManager = class(Tl3SizedPoolManager)
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
   class function Instance: Tm3NormalFormsManager;
    {- возвращает экземпляр синглетона. }
 end;//Tm3NormalFormsManager

implementation

uses
  l3Base {a},
  l3SimpleMM
  ;


// start class Tm3NormalFormsManager

var g_Tm3NormalFormsManager : Tm3NormalFormsManager = nil;

procedure Tm3NormalFormsManagerFree;
begin
 l3Free(g_Tm3NormalFormsManager);
end;

class function Tm3NormalFormsManager.Instance: Tm3NormalFormsManager;
begin
 if (g_Tm3NormalFormsManager = nil) then
 begin
  l3System.AddExitProc(Tm3NormalFormsManagerFree);
  g_Tm3NormalFormsManager := Create;
 end;
 Result := g_Tm3NormalFormsManager;
end;


constructor Tm3NormalFormsManager.Create;
//#UC START# *545A1BD80041_545A1B76019B_var*
//#UC END# *545A1BD80041_545A1B76019B_var*
begin
//#UC START# *545A1BD80041_545A1B76019B_impl*
 f_CanFreeBlocks := 0;
 inherited Create({64} 1024 * 1024, 4);
//#UC END# *545A1BD80041_545A1B76019B_impl*
end;//Tm3NormalFormsManager.Create

procedure Tm3NormalFormsManager.LockFree;
//#UC START# *545A301E038D_545A1B76019B_var*
//#UC END# *545A301E038D_545A1B76019B_var*
begin
//#UC START# *545A301E038D_545A1B76019B_impl*
 Inc(f_CanFreeBlocks);
//#UC END# *545A301E038D_545A1B76019B_impl*
end;//Tm3NormalFormsManager.LockFree

procedure Tm3NormalFormsManager.UnlockFree;
//#UC START# *545A302902B2_545A1B76019B_var*
//#UC END# *545A302902B2_545A1B76019B_var*
begin
//#UC START# *545A302902B2_545A1B76019B_impl*
 Dec(f_CanFreeBlocks);
 Assert(f_CanFreeBlocks >= 0);
 if (f_CanFreeBlocks <= 0) then
  if CanFreeBlocks then
   FreeBlocks;
//#UC END# *545A302902B2_545A1B76019B_impl*
end;//Tm3NormalFormsManager.UnlockFree

class function Tm3NormalFormsManager.Exists: Boolean;
//#UC START# *545A476801BA_545A1B76019B_var*
//#UC END# *545A476801BA_545A1B76019B_var*
begin
//#UC START# *545A476801BA_545A1B76019B_impl*
 Result := (g_Tm3NormalFormsManager <> nil); 
//#UC END# *545A476801BA_545A1B76019B_impl*
end;//Tm3NormalFormsManager.Exists

function Tm3NormalFormsManager.CanFreeBlocks: Boolean;
//#UC START# *545A2F6800D6_545A1B76019B_var*
//#UC END# *545A2F6800D6_545A1B76019B_var*
begin
//#UC START# *545A2F6800D6_545A1B76019B_impl*
 Result := (f_CanFreeBlocks <= 0) AND inherited CanFreeBlocks;
//#UC END# *545A2F6800D6_545A1B76019B_impl*
end;//Tm3NormalFormsManager.CanFreeBlocks

end.