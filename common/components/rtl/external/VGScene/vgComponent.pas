unit vgComponent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgComponent.pas"
// Начат: 09.02.2011 17:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::lulin::TvgComponent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  Classes,
  l3PureMixIns
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
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
 // public methods
   procedure Free(var Dummy: Integer);
     {* Для ловли просто Free }
//#UC START# *4D52A881018Bpubl*
 protected
   {$I l3DefineCleanup.inc}
//#UC END# *4D52A881018Bpubl*
 end;//TvgComponent
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

// start class TvgComponent

procedure TvgComponent.Free(var Dummy: Integer);
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

{$IfEnd} //not NoVGScene

end.