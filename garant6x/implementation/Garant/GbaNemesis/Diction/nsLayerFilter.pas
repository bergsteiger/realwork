unit nsLayerFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/nsLayerFilter.pas"
// Начат: 2007/03/23 14:18:10 
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Diction::Diction::Diction$Unit::TnsLayerFilter
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
  DynamicTreeUnit,
  l3CacheableBase,
  bsInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsLayerFilter = class(Tl3CacheableBase, InsLayerFilter)
 private
 // private fields
   f_LayerID : TLayerId;
 protected
 // realized methods
   function pm_GetLayerID: TLayerId;
 public
 // public methods
   constructor Create(aLayerID: TLayerId); reintroduce;
   class function Make(aLayerID: TLayerId): InsLayerFilter; reintroduce;
 end;//TnsLayerFilter
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsLayerFilter

constructor TnsLayerFilter.Create(aLayerID: TLayerId);
//#UC START# *49020C630037_49020B8C03BE_var*
//#UC END# *49020C630037_49020B8C03BE_var*
begin
//#UC START# *49020C630037_49020B8C03BE_impl*
 inherited Create;
 f_LayerID := aLayerID;
//#UC END# *49020C630037_49020B8C03BE_impl*
end;//TnsLayerFilter.Create

class function TnsLayerFilter.Make(aLayerID: TLayerId): InsLayerFilter;
var
 l_Inst : TnsLayerFilter;
begin
 l_Inst := Create(aLayerID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsLayerFilter.pm_GetLayerID: TLayerId;
//#UC START# *4902077E028F_49020B8C03BEget_var*
//#UC END# *4902077E028F_49020B8C03BEget_var*
begin
//#UC START# *4902077E028F_49020B8C03BEget_impl*
 Result := f_LayerID;
//#UC END# *4902077E028F_49020B8C03BEget_impl*
end;//TnsLayerFilter.pm_GetLayerID

{$IfEnd} //not Admin AND not Monitorings

end.