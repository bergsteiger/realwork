unit nsFiltersUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Filters"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Filters/nsFiltersUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::Filters::Impl::nsFiltersUtils
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
  FiltersUnit,
  l3ProtoObject,
  nsFiltersInterfaces
  ;

type
 TnsFiltersEnumerator = class(Tl3ProtoObject, InsFiltersEnumerator)
 private
 // private fields
   f_CurrentIndex : Integer;
   f_Filters : IFiltersFromQuery;
 protected
 // realized methods
   procedure Reset;
   function MoveNext: Boolean;
   function Get_Current: IFilterFromQuery;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aFilters: IFiltersFromQuery); overload; 
   class function Make(const aFilters: IFiltersFromQuery): InsFiltersEnumerator; reintroduce; overload; 
     {* Сигнатура фабрики TnsFiltersEnumerator.Make$1 }
   constructor Create(const aFirstFilters: IFiltersFromQuery;
     const aSecondFilters: IFiltersFromQuery); overload; 
   class function Make(const aFirstFilters: IFiltersFromQuery;
     const aSecondFilters: IFiltersFromQuery): InsFiltersEnumerator; reintroduce; overload; 
     {* Сигнатура фабрики TnsFiltersEnumerator.Make$2 }
 end;//TnsFiltersEnumerator
function HasFilter(const aFilters: IFiltersFromQuery;
  const aFilter: IFilterFromQuery): Boolean;
function CatFilters(const aFirstFilterList: IFiltersFromQuery;
  const aSecondFilterList: IFiltersFromQuery): IFiltersFromQuery;
procedure RemoveFilter(const aFilters: IFiltersFromQuery;
  const aFilterToRemove: IFilterFromQuery);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter
  ;

// start class TnsFiltersEnumerator

constructor TnsFiltersEnumerator.Create(const aFilters: IFiltersFromQuery);
//#UC START# *56443E9B03A4_56443E71039A_var*
//#UC END# *56443E9B03A4_56443E71039A_var*
begin
//#UC START# *56443E9B03A4_56443E71039A_impl*
 inherited Create;
 f_Filters := aFilters;
 Reset;
//#UC END# *56443E9B03A4_56443E71039A_impl*
end;//TnsFiltersEnumerator.Create

class function TnsFiltersEnumerator.Make(const aFilters: IFiltersFromQuery): InsFiltersEnumerator;
var
 l_Inst : TnsFiltersEnumerator;
begin
 l_Inst := Create(aFilters);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TnsFiltersEnumerator.Create(const aFirstFilters: IFiltersFromQuery;
  const aSecondFilters: IFiltersFromQuery);
//#UC START# *56444038035E_56443E71039A_var*
//#UC END# *56444038035E_56443E71039A_var*
begin
//#UC START# *56444038035E_56443E71039A_impl*
 Create(CatFilters(aFirstFilters, aSecondFilters));
//#UC END# *56444038035E_56443E71039A_impl*
end;//TnsFiltersEnumerator.Create

class function TnsFiltersEnumerator.Make(const aFirstFilters: IFiltersFromQuery;
  const aSecondFilters: IFiltersFromQuery): InsFiltersEnumerator;
var
 l_Inst : TnsFiltersEnumerator;
begin
 l_Inst := Create(aFirstFilters, aSecondFilters);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsFiltersEnumerator.Reset;
//#UC START# *56443DDB0195_56443E71039A_var*
//#UC END# *56443DDB0195_56443E71039A_var*
begin
//#UC START# *56443DDB0195_56443E71039A_impl*
 f_CurrentIndex := -1;
//#UC END# *56443DDB0195_56443E71039A_impl*
end;//TnsFiltersEnumerator.Reset

function TnsFiltersEnumerator.MoveNext: Boolean;
//#UC START# *56443DE2025A_56443E71039A_var*
//#UC END# *56443DE2025A_56443E71039A_var*
begin
//#UC START# *56443DE2025A_56443E71039A_impl*
 Result := (f_Filters <> nil) and (f_CurrentIndex < Pred(f_Filters.Count));
 if Result then
  Inc(f_CurrentIndex);
//#UC END# *56443DE2025A_56443E71039A_impl*
end;//TnsFiltersEnumerator.MoveNext

function TnsFiltersEnumerator.Get_Current: IFilterFromQuery;
//#UC START# *56443E470148_56443E71039Aget_var*
//#UC END# *56443E470148_56443E71039Aget_var*
begin
//#UC START# *56443E470148_56443E71039Aget_impl*
 Result := nil;
 if (f_Filters <> nil) then
  f_Filters.pm_GetItem(f_CurrentIndex, Result);
//#UC END# *56443E470148_56443E71039Aget_impl*
end;//TnsFiltersEnumerator.Get_Current

procedure TnsFiltersEnumerator.Cleanup;
//#UC START# *479731C50290_56443E71039A_var*
//#UC END# *479731C50290_56443E71039A_var*
begin
//#UC START# *479731C50290_56443E71039A_impl*
 f_Filters := nil;
 inherited;
//#UC END# *479731C50290_56443E71039A_impl*
end;//TnsFiltersEnumerator.Cleanup

function HasFilter(const aFilters: IFiltersFromQuery;
  const aFilter: IFilterFromQuery): Boolean;
//#UC START# *564441680148_56443D8E031A_var*
var
 l_Enum: InsFiltersEnumerator;
//#UC END# *564441680148_56443D8E031A_var*
begin
//#UC START# *564441680148_56443D8E031A_impl*
 Result := False;
 l_Enum := TnsFiltersEnumerator.Make(aFilters);
 try
  while l_Enum.MoveNext do
   if (l_Enum.Current.IsSame(aFilter)) then
   begin
    Result := True;
    Exit;
   end;
 finally
  l_Enum := nil;
 end;
//#UC END# *564441680148_56443D8E031A_impl*
end;//HasFilter

function CatFilters(const aFirstFilterList: IFiltersFromQuery;
  const aSecondFilterList: IFiltersFromQuery): IFiltersFromQuery;
//#UC START# *5644419601AD_56443D8E031A_var*

 procedure lp_AddFilters(const aFilters: IFiltersFromQuery);
 var
  l_Enum: InsFiltersEnumerator;
 begin
  l_Enum := TnsFiltersEnumerator.Make(aFilters);
  try
   while l_Enum.MoveNext do
    Result.Add(l_Enum.Current);
  finally
   l_Enum := nil;
  end;
 end;//lp_AddFilters

//#UC END# *5644419601AD_56443D8E031A_var*
begin
//#UC START# *5644419601AD_56443D8E031A_impl*
 Result := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;
 lp_AddFilters(aFirstFilterList);
 lp_AddFilters(aSecondFilterList);
//#UC END# *5644419601AD_56443D8E031A_impl*
end;//CatFilters

procedure RemoveFilter(const aFilters: IFiltersFromQuery;
  const aFilterToRemove: IFilterFromQuery);
//#UC START# *5644424602DA_56443D8E031A_var*
var
 l_Index: Integer;
 l_Filter: IFilterFromQuery;
//#UC END# *5644424602DA_56443D8E031A_var*
begin
//#UC START# *5644424602DA_56443D8E031A_impl*
 l_Index := 0;
 while l_Index < aFilters.Count do
 begin
  aFilters.pm_GetItem(l_Index, l_Filter);
  if l_Filter.IsSame(aFilterToRemove) then
   aFilters.Delete(l_Index)
  else
   Inc(l_Index);
 end;//while l_Index < f_ActiveFilters.Count
//#UC END# *5644424602DA_56443D8E031A_impl*
end;//RemoveFilter
{$IfEnd} //not Admin AND not Monitorings

end.