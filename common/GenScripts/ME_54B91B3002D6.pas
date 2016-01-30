unit l3BoxMemoryManager;

// ������: "w:\common\components\rtl\Garant\L3\l3BoxMemoryManager.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3BoxMemoryManagerPrim
;

type
 Tl3BoxMemoryManager = class(Tl3BoxMemoryManagerPrim)
  public
   constructor Create; reintroduce;
 end;//Tl3BoxMemoryManager

implementation

uses
 l3ImplUses
;

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
