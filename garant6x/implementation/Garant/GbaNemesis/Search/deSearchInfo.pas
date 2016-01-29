unit deSearchInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/deSearchInfo.pas"
// Начат: 08.12.2009 17:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TdeSearchInfo
//
// Информация о запросе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  DynamicDocListUnit,
  l3Interfaces,
  l3ProtoObject,
  PrimPrimListInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TdeSearchInfo = class(Tl3ProtoObject, IdeSearchInfo)
  {* Информация о запросе }
 private
 // private fields
   f_NeedApplyPermanentFilters : Boolean;
   f_QueryInfo : Il3CString;
 protected
 // realized methods
   function pm_GetNeedApplyPermanentFilters: Boolean;
   function pm_GetQueryInfo: Il3CString;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aList: IDynList;
     aNeedApplyPermanentFilters: Boolean); reintroduce;
   class function Make(const aList: IDynList;
     aNeedApplyPermanentFilters: Boolean): IdeSearchInfo; reintroduce;
     {* Сигнатура фабрики TdeSearchInfo.Make }
 end;//TdeSearchInfo
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  bsUtils
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TdeSearchInfo

constructor TdeSearchInfo.Create(const aList: IDynList;
  aNeedApplyPermanentFilters: Boolean);
//#UC START# *4B1E67780224_491D718A00A9_var*
//#UC END# *4B1E67780224_491D718A00A9_var*
begin
//#UC START# *4B1E67780224_491D718A00A9_impl*
 inherited Create;
 f_QueryInfo := bsListName(aList);
 f_NeedApplyPermanentFilters := aNeedApplyPermanentFilters;
//#UC END# *4B1E67780224_491D718A00A9_impl*
end;//TdeSearchInfo.Create

class function TdeSearchInfo.Make(const aList: IDynList;
  aNeedApplyPermanentFilters: Boolean): IdeSearchInfo;
var
 l_Inst : TdeSearchInfo;
begin
 l_Inst := Create(aList, aNeedApplyPermanentFilters);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdeSearchInfo.pm_GetNeedApplyPermanentFilters: Boolean;
//#UC START# *4B1D0ED601F5_491D718A00A9get_var*
//#UC END# *4B1D0ED601F5_491D718A00A9get_var*
begin
//#UC START# *4B1D0ED601F5_491D718A00A9get_impl*
 Result := f_NeedApplyPermanentFilters;
//#UC END# *4B1D0ED601F5_491D718A00A9get_impl*
end;//TdeSearchInfo.pm_GetNeedApplyPermanentFilters

function TdeSearchInfo.pm_GetQueryInfo: Il3CString;
//#UC START# *4B1D0F290136_491D718A00A9get_var*
//#UC END# *4B1D0F290136_491D718A00A9get_var*
begin
//#UC START# *4B1D0F290136_491D718A00A9get_impl*
 Result := f_QueryInfo;
//#UC END# *4B1D0F290136_491D718A00A9get_impl*
end;//TdeSearchInfo.pm_GetQueryInfo

procedure TdeSearchInfo.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_QueryInfo := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TdeSearchInfo.ClearFields

{$IfEnd} //not Admin

end.