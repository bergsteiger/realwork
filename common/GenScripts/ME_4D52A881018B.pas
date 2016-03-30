unit vgComponent;

// Модуль: "w:\common\components\rtl\external\VGScene\vgComponent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgComponent" MUID: (4D52A881018B)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , Classes
 , l3PureMixIns
 //#UC START# *4D52A881018Bintf_uses*
 //#UC END# *4D52A881018Bintf_uses*
;

 {$Define _UnknownIsComponent}

 {$Define l3Unknown_NoIUnknown}

type
 //#UC START# *4D52A881018Bci*
 //#UC END# *4D52A881018Bci*
 _l3Unknown_Parent_ = TComponent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *4D52A881018Bcit*
 //#UC END# *4D52A881018Bcit*
 TvgComponent = class(_l3Unknown_)
  public
   procedure Free(var Dummy: Integer);
    {* Для ловли просто Free }
 //#UC START# *4D52A881018Bpubl*
 protected
   {$I l3DefineCleanup.inc}
 //#UC END# *4D52A881018Bpubl*
 end;//TvgComponent
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
 //#UC START# *4D52A881018Bimpl_uses*
 //#UC END# *4D52A881018Bimpl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvgComponent.Free(var Dummy: Integer);
 {* Для ловли просто Free }
//#UC START# *4D52DB7F0148_4D52A881018B_var*
//#UC END# *4D52DB7F0148_4D52A881018B_var*
begin
//#UC START# *4D52DB7F0148_4D52A881018B_impl*
 Assert(false, 'Используйте FreeAndNil');
//#UC END# *4D52DB7F0148_4D52A881018B_impl*
end;//TvgComponent.Free

//#UC START# *4D52A881018Bimpl*
type
 _Unknown_Child_ = TvgComponent;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *4D52A881018Bimpl*
{$IfEnd} // NOT Defined(NoVGScene)

end.
