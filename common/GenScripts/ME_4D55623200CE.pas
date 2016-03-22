unit vgGradientPoints;

// Модуль: "w:\common\components\rtl\external\VGScene\vgGradientPoints.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgGradientPoints" MUID: (4D55623200CE)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , Classes
 , vgGradientPoint
 , l3PureMixIns
;

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
   function pm_GetPoints(anIndex: Integer): TvgGradientPoint;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   property Points[anIndex: Integer]: TvgGradientPoint
    read pm_GetPoints;
    default;
 //#UC START# *4D55623200CEpubl*
 protected
   {$I l3DefineCleanup.inc}
 //#UC END# *4D55623200CEpubl*
 end;//TvgGradientPoints
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

function TvgGradientPoints.pm_GetPoints(anIndex: Integer): TvgGradientPoint;
//#UC START# *4D55624903C3_4D55623200CEget_var*
//#UC END# *4D55624903C3_4D55623200CEget_var*
begin
//#UC START# *4D55624903C3_4D55623200CEget_impl*
 Result := TvgGradientPoint(Items[anIndex]);
//#UC END# *4D55624903C3_4D55623200CEget_impl*
end;//TvgGradientPoints.pm_GetPoints

{$If NOT Defined(DesignTimeLibrary)}
class function TvgGradientPoints.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4D55623200CE_var*
//#UC END# *47A6FEE600FC_4D55623200CE_var*
begin
//#UC START# *47A6FEE600FC_4D55623200CE_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4D55623200CE_impl*
end;//TvgGradientPoints.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

//#UC START# *4D55623200CEimpl*
type
 _Unknown_Child_ = TvgGradientPoints;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *4D55623200CEimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgGradientPoints);
 {* Регистрация TvgGradientPoints }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
