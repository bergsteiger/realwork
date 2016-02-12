unit vgInterfacedPersistent;

// Модуль: "w:\common\components\rtl\external\VGScene\vgInterfacedPersistent.pas"
// Стереотип: "SimpleClass"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , Classes
 , l3PureMixIns
;

 {$Define l3Unknown_NoIUnknown}

 {$Define _UnknownForDesign}

type
 //#UC START# *4D5413C00089ci*
 //#UC END# *4D5413C00089ci*
 _l3Unknown_Parent_ = TInterfacedPersistent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *4D5413C00089cit*
 //#UC END# *4D5413C00089cit*
 TvgInterfacedPersistent = class(_l3Unknown_)
  public
   procedure Free(var Dummy: Integer);
    {* Для ловли Free }
 //#UC START# *4D5413C00089publ*
 protected
   {$I l3DefineCleanup.inc}
 //#UC END# *4D5413C00089publ*
 end;//TvgInterfacedPersistent
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvgInterfacedPersistent.Free(var Dummy: Integer);
 {* Для ловли Free }
//#UC START# *4D54144F020F_4D5413C00089_var*
//#UC END# *4D54144F020F_4D5413C00089_var*
begin
//#UC START# *4D54144F020F_4D5413C00089_impl*
 Assert(false, 'Используйте FreeAndNil');
//#UC END# *4D54144F020F_4D5413C00089_impl*
end;//TvgInterfacedPersistent.Free

//#UC START# *4D5413C00089impl*
type
 _Unknown_Child_ = TvgInterfacedPersistent;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *4D5413C00089impl*
{$IfEnd} // NOT Defined(NoVGScene)

end.
