unit nsCountryFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsCountryFilter.pas"
// Начат: 2008/04/07 11:18:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic$Unit::TnsCountryFilter
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
  l3CacheableBase,
  l3TreeInterfaces,
  bsInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsCountryFilter = class(Tl3CacheableBase, InsCountryFilter)
 private
 // private fields
   f_Country : Il3SimpleNode;
 protected
 // realized methods
   function pm_GetCountry: Il3SimpleNode;
   procedure pm_SetCountry(const aValue: Il3SimpleNode);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aNode: Il3SimpleNode): InsCountryFilter; reintroduce;
 end;//TnsCountryFilter
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsCountryFilter

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
end;

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
//#UC START# *479731C50290_4901F13D034E_var*
//#UC END# *479731C50290_4901F13D034E_var*
begin
//#UC START# *479731C50290_4901F13D034E_impl*
 f_Country := nil;
 inherited;
//#UC END# *479731C50290_4901F13D034E_impl*
end;//TnsCountryFilter.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.