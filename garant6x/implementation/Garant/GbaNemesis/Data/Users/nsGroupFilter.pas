unit nsGroupFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Users/nsGroupFilter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Users$CommonForAdminAndF1::TnsGroupFilter
//
// Фильтр на группу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3CacheableBase,
  bsInterfaces
  ;

type
 TnsGroupFilter = class(Tl3CacheableBase, InsGroupFilter)
  {* Фильтр на группу }
 private
 // private fields
   f_GroupUID : Integer;
 protected
 // realized methods
   function Get_GroupUID: Integer;
 public
 // public methods
   constructor Create(aGroupUID: Integer); reintroduce;
   class function Make(aGroupUID: Integer): InsGroupFilter; reintroduce;
 end;//TnsGroupFilter

implementation

// start class TnsGroupFilter

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
end;

function TnsGroupFilter.Get_GroupUID: Integer;
//#UC START# *49F015F003D0_49F017390338get_var*
//#UC END# *49F015F003D0_49F017390338get_var*
begin
//#UC START# *49F015F003D0_49F017390338get_impl*
 Result := f_GroupUID;
//#UC END# *49F015F003D0_49F017390338get_impl*
end;//TnsGroupFilter.Get_GroupUID

end.