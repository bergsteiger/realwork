unit nsFormCoordinates;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/nsFormCoordinates.pas"
// Начат: 28.09.2009 16:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Основные прецеденты::Folders::View::Folders::TnsFormCoordinates
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Types,
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 InsFormCoordinates = interface(IUnknown)
   ['{19A17133-BBBB-44F6-8763-1D186621B75E}']
   function Get_Rect: TRect;
   property Rect: TRect
     read Get_Rect;
 end;//InsFormCoordinates

 TnsFormCoordinates = class(Tl3ProtoObject, InsFormCoordinates)
 private
 // private fields
   f_Coord : TRect;
 protected
 // realized methods
   function Get_Rect: TRect;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   constructor Create(const aRect: TRect); reintroduce;
   class function Make(const aRect: TRect): InsFormCoordinates; reintroduce;
 end;//TnsFormCoordinates
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsFormCoordinates

constructor TnsFormCoordinates.Create(const aRect: TRect);
//#UC START# *4AC0AC2800FE_4AC0ABB70051_var*
//#UC END# *4AC0AC2800FE_4AC0ABB70051_var*
begin
//#UC START# *4AC0AC2800FE_4AC0ABB70051_impl*
 inherited Create;
 f_Coord := aRect;
//#UC END# *4AC0AC2800FE_4AC0ABB70051_impl*
end;//TnsFormCoordinates.Create

class function TnsFormCoordinates.Make(const aRect: TRect): InsFormCoordinates;
var
 l_Inst : TnsFormCoordinates;
begin
 l_Inst := Create(aRect);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsFormCoordinates.Get_Rect: TRect;
//#UC START# *4AC0AC110099_4AC0ABB70051get_var*
//#UC END# *4AC0AC110099_4AC0ABB70051get_var*
begin
//#UC START# *4AC0AC110099_4AC0ABB70051get_impl*
 Result := f_Coord;
//#UC END# *4AC0AC110099_4AC0ABB70051get_impl*
end;//TnsFormCoordinates.Get_Rect

{$If not defined(DesignTimeLibrary)}
class function TnsFormCoordinates.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4AC0ABB70051_var*
//#UC END# *47A6FEE600FC_4AC0ABB70051_var*
begin
//#UC START# *47A6FEE600FC_4AC0ABB70051_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4AC0ABB70051_impl*
end;//TnsFormCoordinates.IsCacheable
{$IfEnd} //not DesignTimeLibrary

{$IfEnd} //not Admin AND not Monitorings

end.