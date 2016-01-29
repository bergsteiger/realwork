unit deFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "List"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/List/deFilter.pas"
// Начат: 08.12.2009 16:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::List::SimpleList::TdeFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  FiltersUnit,
  SearchUnit,
  l3TreeInterfaces,
  SimpleListInterfaces,
  l3ProtoObject
  ;

type
 TdeFilter = class(Tl3ProtoObject, IdeFilter)
 private
 // private fields
   f_Filter : IFilterFromQuery;
   f_Query : IQuery;
 protected
 // realized methods
   function pm_GetQuery: IQuery;
   function pm_GetFilter: IFilterFromQuery;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aFilter: IFilterFromQuery); reintroduce; overload; 
   constructor Create(const aQuery: IQuery); overload; 
   class function Make(const aFilter: IFilterFromQuery): IdeFilter; reintroduce; overload; 
   class function Make(const aQuery: IQuery): IdeFilter; reintroduce; overload; 
   class function Make(const aNode: Il3SimpleNode): IdeFilter; overload; 
 end;//TdeFilter

implementation

uses
  SysUtils,
  BaseTypesUnit
  ;

// start class TdeFilter

constructor TdeFilter.Create(const aFilter: IFilterFromQuery);
//#UC START# *4B1E59B3005A_4923ECA602AE_var*
var
 l_Entity: IEntityBase;
//#UC END# *4B1E59B3005A_4923ECA602AE_var*
begin
//#UC START# *4B1E59B3005A_4923ECA602AE_impl*
 Assert(aFilter <> nil);
 inherited Create;
 f_Filter := aFilter;
 aFilter.GetQuery(l_Entity);
 Supports(l_Entity, IQuery, f_Query)
//#UC END# *4B1E59B3005A_4923ECA602AE_impl*
end;//TdeFilter.Create

constructor TdeFilter.Create(const aQuery: IQuery);
//#UC START# *4B1E59CA009A_4923ECA602AE_var*
//#UC END# *4B1E59CA009A_4923ECA602AE_var*
begin
//#UC START# *4B1E59CA009A_4923ECA602AE_impl*
 Assert(aQuery <> nil);
 inherited Create;
 f_Filter := nil;
 f_Query := aQuery;             
//#UC END# *4B1E59CA009A_4923ECA602AE_impl*
end;//TdeFilter.Create

class function TdeFilter.Make(const aFilter: IFilterFromQuery): IdeFilter;
var
 l_Inst : TdeFilter;
begin
 l_Inst := Create(aFilter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TdeFilter.Make(const aQuery: IQuery): IdeFilter;
var
 l_Inst : TdeFilter;
begin
 l_Inst := Create(aQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TdeFilter.Make(const aNode: Il3SimpleNode): IdeFilter;
//#UC START# *4B1E5A280341_4923ECA602AE_var*
var
 l_Filter : IFilterFromQuery;
//#UC END# *4B1E5A280341_4923ECA602AE_var*
begin
//#UC START# *4B1E5A280341_4923ECA602AE_impl*
 if Supports(aNode, IFilterFromQuery, l_Filter) then
  try
   Result := Make(l_Filter);
  finally
   l_Filter := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *4B1E5A280341_4923ECA602AE_impl*
end;//TdeFilter.Make

function TdeFilter.pm_GetQuery: IQuery;
//#UC START# *4B1D15D203DC_4923ECA602AEget_var*
//#UC END# *4B1D15D203DC_4923ECA602AEget_var*
begin
//#UC START# *4B1D15D203DC_4923ECA602AEget_impl*
 Result := f_Query;
//#UC END# *4B1D15D203DC_4923ECA602AEget_impl*
end;//TdeFilter.pm_GetQuery

function TdeFilter.pm_GetFilter: IFilterFromQuery;
//#UC START# *4B1D160B00AC_4923ECA602AEget_var*
//#UC END# *4B1D160B00AC_4923ECA602AEget_var*
begin
//#UC START# *4B1D160B00AC_4923ECA602AEget_impl*
 Result := f_Filter;
//#UC END# *4B1D160B00AC_4923ECA602AEget_impl*
end;//TdeFilter.pm_GetFilter

procedure TdeFilter.ClearFields;
 {-}
begin
 f_Filter := nil;
 f_Query := nil;
 inherited;
end;//TdeFilter.ClearFields

end.