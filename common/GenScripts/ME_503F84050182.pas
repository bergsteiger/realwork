unit atFilterHelper;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atFilterHelper.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , DynamicTreeUnit
;

type
 ContextFilterParams = record
  ContextPlace: TContextPlace;
  FindOrder: TFindOrder;
  SearchArea: TSearchArea;
 end;//ContextFilterParams

 TatContextFilter = class
  private
   f_TweakContextOnAssignment: Boolean;
    {* Поле для свойства TweakContextOnAssignment }
   f_Filter: IContextFilter;
    {* Поле для свойства Filter }
  protected
   function pm_GetContext: AnsiString;
   procedure pm_SetContext(const aValue: AnsiString);
   function pm_GetArea: TSearchArea; virtual;
   procedure pm_SetArea(aValue: TSearchArea); virtual;
   function pm_GetOrder: TFindOrder; virtual;
   procedure pm_SetOrder(aValue: TFindOrder); virtual;
   function pm_GetPlace: TContextPlace; virtual;
   procedure pm_SetPlace(aValue: TContextPlace); virtual;
  public
   constructor Create(const aFilter: IContextFilter); reintroduce; overload;
   constructor Create; reintroduce; overload;
  public
   property Context: AnsiString
    read pm_GetContext
    write pm_SetContext;
   property TweakContextOnAssignment: Boolean
    read f_TweakContextOnAssignment
    write f_TweakContextOnAssignment;
    {* Изменяет контекст при присвоении в соответствии с настройками фильтра }
   property Filter: IContextFilter
    read f_Filter;
   property Area: TSearchArea
    read pm_GetArea
    write pm_SetArea;
   property Order: TFindOrder
    read pm_GetOrder
    write pm_SetOrder;
   property Place: TContextPlace
    read pm_GetPlace
    write pm_SetPlace;
 end;//TatContextFilter

 TatFilterHelper = class
 end;//TatFilterHelper

const
 DEFAULT_CONTEXT_FILTER_PARAMS: ContextFilterParams = (ContextPlace: CP_ANY; FindOrder : FO_ANY; SearchArea : SA_ALL_LEVEL);

implementation

uses
 l3ImplUses
 , SysUtils
 , atStringHelper
 , atGblAdapterWorker
 , IOUnit
;

function TatContextFilter.pm_GetContext: AnsiString;
//#UC START# *5040D48103B0_5040D3EE02D5get_var*
  var
    l_Str : IString;
//#UC END# *5040D48103B0_5040D3EE02D5get_var*
begin
//#UC START# *5040D48103B0_5040D3EE02D5get_impl*
  f_Filter.GetContext(l_Str);
  Result := TatStringHelper.AStr2DStr(l_Str);
//#UC END# *5040D48103B0_5040D3EE02D5get_impl*
end;//TatContextFilter.pm_GetContext

procedure TatContextFilter.pm_SetContext(const aValue: AnsiString);
//#UC START# *5040D48103B0_5040D3EE02D5set_var*
  var
    l_Context : String;
//#UC END# *5040D48103B0_5040D3EE02D5set_var*
begin
//#UC START# *5040D48103B0_5040D3EE02D5set_impl*
  l_Context := aValue;
  if f_TweakContextOnAssignment then
  begin
    // преобразуем контекст в стиле TnsFilterableTreeStruct.MakeSearchStr
    l_Context := Trim(StringReplace(l_Context, '*', ' ', [rfReplaceAll]));
    l_Context := StringReplace(l_Context, '  ', ' ', [rfReplaceAll]);
    case Place of
      CP_BEGIN_OF_WORD : l_Context := '* ' + StringReplace(l_Context, ' ', '* ', [rfReplaceAll]) +  '*';
      CP_ANY : l_Context := '* *' + StringReplace(l_Context, ' ', '* *', [rfReplaceAll]) + '*';
      CP_BEGIN_OF_PHRASE : l_Context := StringReplace(l_Context, ' ', '* ', [rfReplaceAll]) +  '*';
    end;
  end;
  f_Filter.SetContext( TatStringHelper.DStr2AStr(l_Context) );
//#UC END# *5040D48103B0_5040D3EE02D5set_impl*
end;//TatContextFilter.pm_SetContext

function TatContextFilter.pm_GetArea: TSearchArea;
//#UC START# *5040D43501FA_5040D3EE02D5get_var*
//#UC END# *5040D43501FA_5040D3EE02D5get_var*
begin
//#UC START# *5040D43501FA_5040D3EE02D5get_impl*
  Result := f_Filter.GetArea;
//#UC END# *5040D43501FA_5040D3EE02D5get_impl*
end;//TatContextFilter.pm_GetArea

procedure TatContextFilter.pm_SetArea(aValue: TSearchArea);
//#UC START# *5040D43501FA_5040D3EE02D5set_var*
//#UC END# *5040D43501FA_5040D3EE02D5set_var*
begin
//#UC START# *5040D43501FA_5040D3EE02D5set_impl*
  f_Filter.SetArea(aValue);
//#UC END# *5040D43501FA_5040D3EE02D5set_impl*
end;//TatContextFilter.pm_SetArea

function TatContextFilter.pm_GetOrder: TFindOrder;
//#UC START# *5040D43E004C_5040D3EE02D5get_var*
//#UC END# *5040D43E004C_5040D3EE02D5get_var*
begin
//#UC START# *5040D43E004C_5040D3EE02D5get_impl*
  Result := f_Filter.GetOrder;
//#UC END# *5040D43E004C_5040D3EE02D5get_impl*
end;//TatContextFilter.pm_GetOrder

procedure TatContextFilter.pm_SetOrder(aValue: TFindOrder);
//#UC START# *5040D43E004C_5040D3EE02D5set_var*
//#UC END# *5040D43E004C_5040D3EE02D5set_var*
begin
//#UC START# *5040D43E004C_5040D3EE02D5set_impl*
  f_Filter.SetOrder(aValue);
//#UC END# *5040D43E004C_5040D3EE02D5set_impl*
end;//TatContextFilter.pm_SetOrder

function TatContextFilter.pm_GetPlace: TContextPlace;
//#UC START# *5040D44600D3_5040D3EE02D5get_var*
//#UC END# *5040D44600D3_5040D3EE02D5get_var*
begin
//#UC START# *5040D44600D3_5040D3EE02D5get_impl*
  Result := f_Filter.GetPlace;
//#UC END# *5040D44600D3_5040D3EE02D5get_impl*
end;//TatContextFilter.pm_GetPlace

procedure TatContextFilter.pm_SetPlace(aValue: TContextPlace);
//#UC START# *5040D44600D3_5040D3EE02D5set_var*
//#UC END# *5040D44600D3_5040D3EE02D5set_var*
begin
//#UC START# *5040D44600D3_5040D3EE02D5set_impl*
  f_Filter.SetPlace(aValue);
//#UC END# *5040D44600D3_5040D3EE02D5set_impl*
end;//TatContextFilter.pm_SetPlace

constructor TatContextFilter.Create(const aFilter: IContextFilter);
//#UC START# *5040D4A501C2_5040D3EE02D5_var*
//#UC END# *5040D4A501C2_5040D3EE02D5_var*
begin
//#UC START# *5040D4A501C2_5040D3EE02D5_impl*
  f_Filter := aFilter;
//#UC END# *5040D4A501C2_5040D3EE02D5_impl*
end;//TatContextFilter.Create

constructor TatContextFilter.Create;
//#UC START# *5040D5BC01FF_5040D3EE02D5_var*
//#UC END# *5040D5BC01FF_5040D3EE02D5_var*
begin
//#UC START# *5040D5BC01FF_5040D3EE02D5_impl*
  inherited;
  f_Filter := TatGblAdapterWorker.Instance.GblAdapterDll.MakeContextFilter;
//#UC END# *5040D5BC01FF_5040D3EE02D5_impl*
end;//TatContextFilter.Create

end.
