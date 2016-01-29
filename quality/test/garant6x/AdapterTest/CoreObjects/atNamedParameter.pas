unit atNamedParameter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atNamedParameter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatNamedParameter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atParameter
  ;

type
 TatNamedParameter = class(TatParameter)
 private
 // private fields
   f_Name : AnsiString;
    {* Поле для свойства Name}
   f_Description : AnsiString;
    {* Поле для свойства Description}
 public
 // public methods
   constructor Create(const name: AnsiString;
    const description: AnsiString;
    const defaultValue: AnsiString); reintroduce; overload; 
   constructor Create(const name: AnsiString;
    const description: AnsiString); reintroduce; overload; 
   constructor Create(const name: AnsiString); reintroduce; overload; 
 public
 // public properties
   property Name: AnsiString
     read f_Name;
   property Description: AnsiString
     read f_Description;
 end;//TatNamedParameter

implementation

// start class TatNamedParameter

constructor TatNamedParameter.Create(const name: AnsiString;
  const description: AnsiString;
  const defaultValue: AnsiString);
//#UC START# *480890C200C7_480890870368_var*
//#UC END# *480890C200C7_480890870368_var*
begin
//#UC START# *480890C200C7_480890870368_impl*
    inherited Create(defaultValue);
    f_Name := name;
    f_Description := description;
//#UC END# *480890C200C7_480890870368_impl*
end;//TatNamedParameter.Create

constructor TatNamedParameter.Create(const name: AnsiString;
  const description: AnsiString);
//#UC START# *480890DD012B_480890870368_var*
//#UC END# *480890DD012B_480890870368_var*
begin
//#UC START# *480890DD012B_480890870368_impl*
    Create(name);
    f_Description := description;
//#UC END# *480890DD012B_480890870368_impl*
end;//TatNamedParameter.Create

constructor TatNamedParameter.Create(const name: AnsiString);
//#UC START# *480890EF00D2_480890870368_var*
//#UC END# *480890EF00D2_480890870368_var*
begin
//#UC START# *480890EF00D2_480890870368_impl*
    inherited Create;
    f_Name := name;
    f_Description := '';
//#UC END# *480890EF00D2_480890870368_impl*
end;//TatNamedParameter.Create

end.