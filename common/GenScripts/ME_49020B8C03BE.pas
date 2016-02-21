unit nsLayerFilter;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsLayerFilter.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3CacheableBase
 , bsInterfaces
 , DynamicTreeUnit
;

type
 TnsLayerFilter = class(Tl3CacheableBase, InsLayerFilter)
  private
   f_LayerID: TLayerId;
  protected
   function pm_GetLayerID: TLayerId;
  public
   constructor Create(aLayerID: TLayerId); reintroduce;
   class function Make(aLayerID: TLayerId): InsLayerFilter; reintroduce;
 end;//TnsLayerFilter
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

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
end;//TnsLayerFilter.Make

function TnsLayerFilter.pm_GetLayerID: TLayerId;
//#UC START# *4902077E028F_49020B8C03BEget_var*
//#UC END# *4902077E028F_49020B8C03BEget_var*
begin
//#UC START# *4902077E028F_49020B8C03BEget_impl*
 Result := f_LayerID;
//#UC END# *4902077E028F_49020B8C03BEget_impl*
end;//TnsLayerFilter.pm_GetLayerID
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
