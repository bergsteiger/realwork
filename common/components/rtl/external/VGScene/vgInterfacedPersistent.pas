unit vgInterfacedPersistent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgInterfacedPersistent.pas"
// Начат: 10.02.2011 19:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::lulin::TvgInterfacedPersistent
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
//#UC START# *4D5413C00089ci*
//#UC END# *4D5413C00089ci*
 _l3Unknown_Parent_ = TInterfacedPersistent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
//#UC START# *4D5413C00089cit*
//#UC END# *4D5413C00089cit*
 TvgInterfacedPersistent = class(_l3Unknown_)
 public
 // public methods
   procedure Free(var Dummy: Integer);
     {* Для ловли Free }
//#UC START# *4D5413C00089publ*
 protected
   {$I l3DefineCleanup.inc}
//#UC END# *4D5413C00089publ*
 end;//TvgInterfacedPersistent
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

// start class TvgInterfacedPersistent

procedure TvgInterfacedPersistent.Free(var Dummy: Integer);
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

{$IfEnd} //not NoVGScene

end.