unit atCommandLineParameter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atCommandLineParameter.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atNamedParameter
 , atParameter
;

type
 TCLPType = (
  {* тип параметра командной строки }
  clptKey
  , clptString
  , clptNumber
 );//TCLPType

 TatCommandLineParameter = class(TatNamedParameter)
  private
   f_ParamType: TCLPType;
    {* Поле для свойства ParamType }
  protected
   function pm_GetIsRequired: Boolean;
  public
   constructor Create(parType: TCLPType;
    const name: AnsiString;
    const description: AnsiString = '';
    const defaultValue: AnsiString = atParameter.INVALID_DEFAULT_VALUE); reintroduce;
  public
   property ParamType: TCLPType
    read f_ParamType;
   property IsRequired: Boolean
    read pm_GetIsRequired;
 end;//TatCommandLineParameter

implementation

uses
 l3ImplUses
;

function TatCommandLineParameter.pm_GetIsRequired: Boolean;
//#UC START# *480893F80392_4808938A0159get_var*
//#UC END# *480893F80392_4808938A0159get_var*
begin
//#UC START# *480893F80392_4808938A0159get_impl*
    Result := NOT IsDefaultSet;
//#UC END# *480893F80392_4808938A0159get_impl*
end;//TatCommandLineParameter.pm_GetIsRequired

constructor TatCommandLineParameter.Create(parType: TCLPType;
 const name: AnsiString;
 const description: AnsiString = '';
 const defaultValue: AnsiString = atParameter.INVALID_DEFAULT_VALUE);
//#UC START# *4808941B0073_4808938A0159_var*
//#UC END# *4808941B0073_4808938A0159_var*
begin
//#UC START# *4808941B0073_4808938A0159_impl*
    inherited Create(name, description, defaultValue);
    //
    f_ParamType := parType;
//#UC END# *4808941B0073_4808938A0159_impl*
end;//TatCommandLineParameter.Create

end.
