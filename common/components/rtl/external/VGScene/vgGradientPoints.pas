unit vgGradientPoints;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/vgGradientPoints.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgGradientPoints
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
  vgGradientPoint,
  l3PureMixIns
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
 {$Define _UnknownForDesign}

 {$Define l3Unknown_NoIUnknown}

type
//#UC START# *4D55623200CEci*
//#UC END# *4D55623200CEci*
 _l3Unknown_Parent_ = TCollection;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
//#UC START# *4D55623200CEcit*
//#UC END# *4D55623200CEcit*
 TvgGradientPoints = class(_l3Unknown_)
 protected
 // property methods
   function pm_GetPoints(anIndex: Integer): TvgGradientPoint;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public properties
   property Points[anIndex: Integer]: TvgGradientPoint
     read pm_GetPoints;
     default;
//#UC START# *4D55623200CEpubl*
 protected
   {$I l3DefineCleanup.inc}
//#UC END# *4D55623200CEpubl*
 end;//TvgGradientPoints
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

// start class TvgGradientPoints

function TvgGradientPoints.pm_GetPoints(anIndex: Integer): TvgGradientPoint;
//#UC START# *4D55624903C3_4D55623200CEget_var*
//#UC END# *4D55624903C3_4D55623200CEget_var*
begin
//#UC START# *4D55624903C3_4D55623200CEget_impl*
 Result := TvgGradientPoint(Items[anIndex]);
//#UC END# *4D55624903C3_4D55623200CEget_impl*
end;//TvgGradientPoints.pm_GetPoints

{$If not defined(DesignTimeLibrary)}
class function TvgGradientPoints.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4D55623200CE_var*
//#UC END# *47A6FEE600FC_4D55623200CE_var*
begin
//#UC START# *47A6FEE600FC_4D55623200CE_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4D55623200CE_impl*
end;//TvgGradientPoints.IsCacheable
{$IfEnd} //not DesignTimeLibrary

//#UC START# *4D55623200CEimpl*
type
 _Unknown_Child_ = TvgGradientPoints;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *4D55623200CEimpl*

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgGradientPoints
 TtfwClassRef.Register(TvgGradientPoints);
{$IfEnd} //not NoScripts AND not NoVGScene

end.