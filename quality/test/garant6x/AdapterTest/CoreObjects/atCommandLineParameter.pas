unit atCommandLineParameter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atCommandLineParameter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatCommandLineParameter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atParameter,
  atNamedParameter
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
 // private fields
   f_ParamType : TCLPType;
    {* Поле для свойства ParamType}
 protected
 // property methods
   function pm_GetIsRequired: Boolean;
 public
 // public methods
   constructor Create(parType: TCLPType;
    const name: AnsiString;
    const description: AnsiString = '';
    const defaultValue: AnsiString = INVALID_DEFAULT_VALUE); reintroduce;
 public
 // public properties
   property ParamType: TCLPType
     read f_ParamType;
   property IsRequired: Boolean
     read pm_GetIsRequired;
 end;//TatCommandLineParameter

implementation

// start class TatCommandLineParameter

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
  const defaultValue: AnsiString = INVALID_DEFAULT_VALUE);
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