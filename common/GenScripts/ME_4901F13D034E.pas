unit nsCountryFilter;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsCountryFilter.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3CacheableBase
 , bsInterfaces
 , l3TreeInterfaces
;

type
 TnsCountryFilter = class(Tl3CacheableBase, InsCountryFilter)
  private
   f_Country: Il3SimpleNode;
  protected
   function pm_GetCountry: Il3SimpleNode;
   procedure pm_SetCountry(const aValue: Il3SimpleNode);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aNode: Il3SimpleNode): InsCountryFilter; reintroduce;
 end;//TnsCountryFilter
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

constructor TnsCountryFilter.Create(const aNode: Il3SimpleNode);
//#UC START# *4901F1B5030B_4901F13D034E_var*
//#UC END# *4901F1B5030B_4901F13D034E_var*
begin
//#UC START# *4901F1B5030B_4901F13D034E_impl*
 inherited Create;
 f_Country := aNode;
//#UC END# *4901F1B5030B_4901F13D034E_impl*
end;//TnsCountryFilter.Create

class function TnsCountryFilter.Make(const aNode: Il3SimpleNode): InsCountryFilter;
var
 l_Inst : TnsCountryFilter;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsCountryFilter.Make

function TnsCountryFilter.pm_GetCountry: Il3SimpleNode;
//#UC START# *4901EE910334_4901F13D034Eget_var*
//#UC END# *4901EE910334_4901F13D034Eget_var*
begin
//#UC START# *4901EE910334_4901F13D034Eget_impl*
 Result := f_Country;
//#UC END# *4901EE910334_4901F13D034Eget_impl*
end;//TnsCountryFilter.pm_GetCountry

procedure TnsCountryFilter.pm_SetCountry(const aValue: Il3SimpleNode);
//#UC START# *4901EE910334_4901F13D034Eset_var*
//#UC END# *4901EE910334_4901F13D034Eset_var*
begin
//#UC START# *4901EE910334_4901F13D034Eset_impl*
 f_Country := aValue;
//#UC END# *4901EE910334_4901F13D034Eset_impl*
end;//TnsCountryFilter.pm_SetCountry

procedure TnsCountryFilter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4901F13D034E_var*
//#UC END# *479731C50290_4901F13D034E_var*
begin
//#UC START# *479731C50290_4901F13D034E_impl*
 f_Country := nil;
 inherited;
//#UC END# *479731C50290_4901F13D034E_impl*
end;//TnsCountryFilter.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
