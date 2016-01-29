unit l3BoxMemoryManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3BoxMemoryManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::MemoryManagers::Tl3BoxMemoryManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3BoxMemoryManagerPrim
  ;

type
 Tl3BoxMemoryManager = class(Tl3BoxMemoryManagerPrim)
 public
 // public methods
   constructor Create; reintroduce;
 end;//Tl3BoxMemoryManager

implementation

// start class Tl3BoxMemoryManager

constructor Tl3BoxMemoryManager.Create;
//#UC START# *54B91B4101BF_54B91B3002D6_var*
const
 cSize = {$IfDef Nemesis}
         1
         {$Else  Nemesis}
         3
         {$EndIf Nemesis}
         * 1024 * 1024;
//#UC END# *54B91B4101BF_54B91B3002D6_var*
begin
//#UC START# *54B91B4101BF_54B91B3002D6_impl*
 inherited Create(cSize, 64);
//#UC END# *54B91B4101BF_54B91B3002D6_impl*
end;//Tl3BoxMemoryManager.Create

end.