unit vgCustomGradientPoint;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/vgCustomGradientPoint.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgCustomGradientPoint
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
  vgTypes,
  l3PureMixIns
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
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
 // private fields
   f_IntColor : TvgColor;
    {* Поле для свойства IntColor}
   f_Offset : single;
    {* Поле для свойства Offset}
 protected
 // property methods
   function pm_GetColor: AnsiString;
   procedure pm_SetColor(const aValue: AnsiString);
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // overridden public methods
   procedure Assign(Source: TPersistent); override;
   constructor Create(aCollection: TCollection); override;
 public
 // public properties
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
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  vg_scene
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
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

// start class TvgCustomGradientPoint

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

{$If not defined(DesignTimeLibrary)}
class function TvgCustomGradientPoint.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4D555D3201E9_var*
//#UC END# *47A6FEE600FC_4D555D3201E9_var*
begin
//#UC START# *47A6FEE600FC_4D555D3201E9_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4D555D3201E9_impl*
end;//TvgCustomGradientPoint.IsCacheable
{$IfEnd} //not DesignTimeLibrary

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

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgCustomGradientPoint
 TtfwClassRef.Register(TvgCustomGradientPoint);
{$IfEnd} //not NoScripts AND not NoVGScene

end.