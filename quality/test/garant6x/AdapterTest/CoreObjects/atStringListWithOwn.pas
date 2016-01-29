unit atStringListWithOwn;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atStringListWithOwn.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatStringListWithOwn
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  Classes
  ;

type
 TatStringListWithOwn = class(TStringList)
 private
 // private fields
   f_OwnsObjects : Boolean;
    {* Поле для свойства OwnsObjects}
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   constructor Create(ownsObjects: Boolean); reintroduce;
 public
 // public properties
   property OwnsObjects: Boolean
     read f_OwnsObjects
     write f_OwnsObjects;
 end;//TatStringListWithOwn

implementation

// start class TatStringListWithOwn

constructor TatStringListWithOwn.Create(ownsObjects: Boolean);
//#UC START# *480775BA0035_4807752C025A_var*
//#UC END# *480775BA0035_4807752C025A_var*
begin
//#UC START# *480775BA0035_4807752C025A_impl*
    inherited Create;  {???????????}
    f_OwnsObjects := ownsObjects;
//#UC END# *480775BA0035_4807752C025A_impl*
end;//TatStringListWithOwn.Create

destructor TatStringListWithOwn.Destroy;
//#UC START# *48077504027E_4807752C025A_var*
    var
      i : integer;
//#UC END# *48077504027E_4807752C025A_var*
begin
//#UC START# *48077504027E_4807752C025A_impl*
    if f_OwnsObjects then
      for i := 0 to Count-1 do
        Objects[i].Free;
    inherited;
//#UC END# *48077504027E_4807752C025A_impl*
end;//TatStringListWithOwn.Destroy

end.