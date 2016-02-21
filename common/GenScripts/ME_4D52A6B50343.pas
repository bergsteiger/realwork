unit vgPersistent;

// Модуль: "w:\common\components\rtl\external\VGScene\vgPersistent.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

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
 //#UC START# *4D52A6B50343ci*
 //#UC END# *4D52A6B50343ci*
 _l3Unknown_Parent_ = TPersistent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *4D52A6B50343cit*
 //#UC END# *4D52A6B50343cit*
 TvgPersistent = class(_l3Unknown_)
  public
   procedure Free(var Dummy: Integer);
    {* Для ловли просто Free }
 //#UC START# *4D52A6B50343publ*
 protected
   {$I l3DefineCleanup.inc}
 //#UC END# *4D52A6B50343publ*
 end;//TvgPersistent
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

procedure TvgPersistent.Free(var Dummy: Integer);
 {* Для ловли просто Free }
//#UC START# *4D52DB5D03BF_4D52A6B50343_var*
//#UC END# *4D52DB5D03BF_4D52A6B50343_var*
begin
//#UC START# *4D52DB5D03BF_4D52A6B50343_impl*
 Assert(false, 'Используйте FreeAndNil');
//#UC END# *4D52DB5D03BF_4D52A6B50343_impl*
end;//TvgPersistent.Free

//#UC START# *4D52A6B50343impl*
type
 _Unknown_Child_ = TvgPersistent;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *4D52A6B50343impl*
{$IfEnd} // NOT Defined(NoVGScene)

end.
