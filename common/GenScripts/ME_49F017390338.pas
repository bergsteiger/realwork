unit nsGroupFilter;
 {* Фильтр на группу }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsGroupFilter.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , bsInterfaces
;

type
 TnsGroupFilter = class(Tl3CacheableBase, InsGroupFilter)
  {* Фильтр на группу }
  private
   f_GroupUID: Integer;
  protected
   function Get_GroupUID: Integer;
  public
   constructor Create(aGroupUID: Integer); reintroduce;
   class function Make(aGroupUID: Integer): InsGroupFilter; reintroduce;
 end;//TnsGroupFilter

implementation

uses
 l3ImplUses
;

constructor TnsGroupFilter.Create(aGroupUID: Integer);
//#UC START# *49F017D90351_49F017390338_var*
//#UC END# *49F017D90351_49F017390338_var*
begin
//#UC START# *49F017D90351_49F017390338_impl*
 inherited Create;
 f_GroupUID := aGroupUID;
//#UC END# *49F017D90351_49F017390338_impl*
end;//TnsGroupFilter.Create

class function TnsGroupFilter.Make(aGroupUID: Integer): InsGroupFilter;
var
 l_Inst : TnsGroupFilter;
begin
 l_Inst := Create(aGroupUID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsGroupFilter.Make

function TnsGroupFilter.Get_GroupUID: Integer;
//#UC START# *49F015F003D0_49F017390338get_var*
//#UC END# *49F015F003D0_49F017390338get_var*
begin
//#UC START# *49F015F003D0_49F017390338get_impl*
 Result := f_GroupUID;
//#UC END# *49F015F003D0_49F017390338get_impl*
end;//TnsGroupFilter.Get_GroupUID

end.
