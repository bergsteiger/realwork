unit l3SimpleMemoryManagerPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3SimpleMemoryManagerPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3SimpleMemoryManagerPrim" MUID: (54B67EB9023D)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , Refcounted
 , SyncObjs
;

type
 _l3CriticalSectionHolderPrim_Parent_ = TRefcounted;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolderPrim.imp.pas}
 Tl3SimpleMemoryManagerPrim = {abstract} class(_l3CriticalSectionHolderPrim_)
  protected
   procedure Release; override;
  public
   constructor Create; reintroduce;
 end;//Tl3SimpleMemoryManagerPrim

implementation

uses
 l3ImplUses
 , SysUtils
;

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolderPrim.imp.pas}

constructor Tl3SimpleMemoryManagerPrim.Create;
//#UC START# *54B68024012F_54B67EB9023D_var*
//#UC END# *54B68024012F_54B67EB9023D_var*
begin
//#UC START# *54B68024012F_54B67EB9023D_impl*
 CreateCS;
 inherited Create;
//#UC END# *54B68024012F_54B67EB9023D_impl*
end;//Tl3SimpleMemoryManagerPrim.Create

procedure Tl3SimpleMemoryManagerPrim.Release;
//#UC START# *479F2AFB0397_54B67EB9023D_var*
//#UC END# *479F2AFB0397_54B67EB9023D_var*
begin
//#UC START# *479F2AFB0397_54B67EB9023D_impl*
 inherited;
 FreeCS;
//#UC END# *479F2AFB0397_54B67EB9023D_impl*
end;//Tl3SimpleMemoryManagerPrim.Release

end.
