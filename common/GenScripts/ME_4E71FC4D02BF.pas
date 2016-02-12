unit nevStringCache;

// Модуль: "w:\common\components\gui\Garant\Everest\nevStringCache.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevBase
 , l3CustomString
;

type
 _nevStringCache_Parent_ = Tl3CProtoObject;
 {$Include w:\common\components\gui\Garant\Everest\nevStringCache.imp.pas}
 TnevStringCache = class(_nevStringCache_, InevStringCache)
  public
   constructor Create; reintroduce;
   class function Make: InevStringCache; reintroduce;
 end;//TnevStringCache

implementation

uses
 l3ImplUses
 , evParaString
 , SysUtils
;

{$Include w:\common\components\gui\Garant\Everest\nevStringCache.imp.pas}

constructor TnevStringCache.Create;
//#UC START# *4E71FCAE00EE_4E71FC4D02BF_var*
//#UC END# *4E71FCAE00EE_4E71FC4D02BF_var*
begin
//#UC START# *4E71FCAE00EE_4E71FC4D02BF_impl*
 inherited Create;
//#UC END# *4E71FCAE00EE_4E71FC4D02BF_impl*
end;//TnevStringCache.Create

class function TnevStringCache.Make: InevStringCache;
var
 l_Inst : TnevStringCache;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevStringCache.Make

end.
