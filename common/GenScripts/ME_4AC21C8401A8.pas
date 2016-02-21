unit nsPrimeNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\nsPrimeNode.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsWrapperNode
 , PrimeDomainInterfaces
 , PrimeUnit
 , l3Tree_TLB
;

type
 TnsPrimeNode = class(TnsWrapperNode, InsPrimeNode)
  private
   f_Prime: IPrime;
  protected
   function pm_GetData: IPrime;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aPrime: IPrime); reintroduce;
   class function Make(const aPrime: IPrime): Il3Node; reintroduce;
 end;//TnsPrimeNode
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , IOUnit
 , nsTypes
;

constructor TnsPrimeNode.Create(const aPrime: IPrime);
//#UC START# *4ADF2D5D01FC_4AC21C8401A8_var*
var
 l_Name: IString;
//#UC END# *4ADF2D5D01FC_4AC21C8401A8_var*
begin
//#UC START# *4ADF2D5D01FC_4AC21C8401A8_impl*
 inherited Create;
 f_Prime := aPrime;
 f_Prime.GetName(l_Name);
 try
  pm_SetName(nsWStr(l_Name));
 finally
  l_Name := nil;
 end;//try..finally
//#UC END# *4ADF2D5D01FC_4AC21C8401A8_impl*
end;//TnsPrimeNode.Create

class function TnsPrimeNode.Make(const aPrime: IPrime): Il3Node;
var
 l_Inst : TnsPrimeNode;
begin
 l_Inst := Create(aPrime);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsPrimeNode.Make

function TnsPrimeNode.pm_GetData: IPrime;
//#UC START# *499032D40064_4AC21C8401A8get_var*
//#UC END# *499032D40064_4AC21C8401A8get_var*
begin
//#UC START# *499032D40064_4AC21C8401A8get_impl*
 Result := f_Prime;
//#UC END# *499032D40064_4AC21C8401A8get_impl*
end;//TnsPrimeNode.pm_GetData

procedure TnsPrimeNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AC21C8401A8_var*
//#UC END# *479731C50290_4AC21C8401A8_var*
begin
//#UC START# *479731C50290_4AC21C8401A8_impl*
 f_Prime := nil;
 inherited;
//#UC END# *479731C50290_4AC21C8401A8_impl*
end;//TnsPrimeNode.Cleanup
{$IfEnd} // NOT Defined(Admin)

end.
