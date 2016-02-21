unit nsUserFlagsFilter;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserFlagsFilter.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , bsInterfaces
;

type
 TnsUserFlagsFilter = class(Tl3CacheableBase, InsUserFlagsFilter)
  private
   f_Flags: LongWord;
  protected
   function pm_GetUserFlag: LongWord;
  public
   constructor Create(aFlags: LongWord); reintroduce;
   class function Make(aFlags: LongWord): InsUserFlagsFilter; reintroduce;
 end;//TnsUserFlagsFilter

implementation

uses
 l3ImplUses
;

constructor TnsUserFlagsFilter.Create(aFlags: LongWord);
//#UC START# *4901E932025A_4901E8E20154_var*
//#UC END# *4901E932025A_4901E8E20154_var*
begin
//#UC START# *4901E932025A_4901E8E20154_impl*
 inherited Create;
 f_Flags := aFlags; 
//#UC END# *4901E932025A_4901E8E20154_impl*
end;//TnsUserFlagsFilter.Create

class function TnsUserFlagsFilter.Make(aFlags: LongWord): InsUserFlagsFilter;
var
 l_Inst : TnsUserFlagsFilter;
begin
 l_Inst := Create(aFlags);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsUserFlagsFilter.Make

function TnsUserFlagsFilter.pm_GetUserFlag: LongWord;
//#UC START# *4901E65C0092_4901E8E20154get_var*
//#UC END# *4901E65C0092_4901E8E20154get_var*
begin
//#UC START# *4901E65C0092_4901E8E20154get_impl*
 Result := f_Flags;
//#UC END# *4901E65C0092_4901E8E20154get_impl*
end;//TnsUserFlagsFilter.pm_GetUserFlag

end.
