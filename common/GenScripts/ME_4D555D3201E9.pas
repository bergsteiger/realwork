unit vgCustomGradientPoint;

// Модуль: "w:\common\components\rtl\external\VGScene\vgCustomGradientPoint.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgCustomGradientPoint" MUID: (4D555D3201E9)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , Classes
 , vgTypes
 , l3PureMixIns
;

 {$Define _UnknownForDesign}

 {$Define l3Unknown_NoIUnknown}

type
 //#UC START# *4D555D3201E9ci*
 //#UC END# *4D555D3201E9ci*
 _l3Unknown_Parent_ = TCollectionItem;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *4D555D3201E9cit*
 //#UC END# *4D555D3201E9cit*
 TvgCustomGradientPoint = class(_l3Unknown_)
  private
   f_IntColor: TvgColor;
    {* Поле для свойства IntColor }
   f_Offset: single;
    {* Поле для свойства Offset }
  protected
   function pm_GetColor: AnsiString;
   procedure pm_SetColor(const aValue: AnsiString);
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   procedure Assign(Source: TPersistent); override;
   constructor Create(aCollection: TCollection); override;
  public
   property IntColor: TvgColor
    read f_IntColor
    write f_IntColor;
   property Offset: single
    read f_Offset
    write f_Offset;
   property Color: AnsiString
    read pm_GetColor
    write pm_SetColor;
 //#UC START# *4D555D3201E9publ*
 protected
   {$I l3DefineCleanup.inc}
 //#UC END# *4D555D3201E9publ*
 end;//TvgCustomGradientPoint
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , vg_scene
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

function TvgCustomGradientPoint.pm_GetColor: AnsiString;
//#UC START# *4D555E930177_4D555D3201E9get_var*
//#UC END# *4D555E930177_4D555D3201E9get_var*
begin
//#UC START# *4D555E930177_4D555D3201E9get_impl*
 Result := vgColorToStr(f_IntColor);
//#UC END# *4D555E930177_4D555D3201E9get_impl*
end;//TvgCustomGradientPoint.pm_GetColor

procedure TvgCustomGradientPoint.pm_SetColor(const aValue: AnsiString);
//#UC START# *4D555E930177_4D555D3201E9set_var*
//#UC END# *4D555E930177_4D555D3201E9set_var*
begin
//#UC START# *4D555E930177_4D555D3201E9set_impl*
 f_IntColor := vgStrToColor(aValue);
//#UC END# *4D555E930177_4D555D3201E9set_impl*
end;//TvgCustomGradientPoint.pm_SetColor

procedure TvgCustomGradientPoint.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_4D555D3201E9_var*
//#UC END# *478CF34E02CE_4D555D3201E9_var*
begin
//#UC START# *478CF34E02CE_4D555D3201E9_impl*
 if (Source is TvgCustomGradientPoint) then
 begin
  F_IntColor := TvgCustomGradientPoint(Source).F_IntColor;
  F_Offset := TvgCustomGradientPoint(Source).F_Offset;
 end//Source is TvgCustomGradientPoint
 else
  inherited;
//#UC END# *478CF34E02CE_4D555D3201E9_impl*
end;//TvgCustomGradientPoint.Assign

{$If NOT Defined(DesignTimeLibrary)}
class function TvgCustomGradientPoint.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4D555D3201E9_var*
//#UC END# *47A6FEE600FC_4D555D3201E9_var*
begin
//#UC START# *47A6FEE600FC_4D555D3201E9_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4D555D3201E9_impl*
end;//TvgCustomGradientPoint.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

constructor TvgCustomGradientPoint.Create(aCollection: TCollection);
//#UC START# *4D555CF50027_4D555D3201E9_var*
//#UC END# *4D555CF50027_4D555D3201E9_var*
begin
//#UC START# *4D555CF50027_4D555D3201E9_impl*
 inherited;
 f_IntColor := 0;
 F_Offset := 0;
//#UC END# *4D555CF50027_4D555D3201E9_impl*
end;//TvgCustomGradientPoint.Create

//#UC START# *4D555D3201E9impl*
type
 _Unknown_Child_ = TvgCustomGradientPoint;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *4D555D3201E9impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgCustomGradientPoint);
 {* Регистрация TvgCustomGradientPoint }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
