unit vgPersistent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgPersistent.pas"
// Начат: 09.02.2011 17:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::lulin::TvgPersistent
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
 // public methods
   procedure Free(var Dummy: Integer);
     {* Для ловли просто Free }
//#UC START# *4D52A6B50343publ*
 protected
   {$I l3DefineCleanup.inc}
//#UC END# *4D52A6B50343publ*
 end;//TvgPersistent
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

// start class TvgPersistent

procedure TvgPersistent.Free(var Dummy: Integer);
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

{$IfEnd} //not NoVGScene

end.