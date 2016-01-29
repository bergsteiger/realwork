unit atNotification;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atNotification.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatNotification
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atInterfaces
  ;

type
 TatNotification = class(TInterfacedObject, IatNotification)
 private
 // private fields
   f_Data : Variant;
 protected
 // realized methods
   function GetData: Variant;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   constructor Create(const data: Variant); reintroduce;
 end;//TatNotification

implementation

// start class TatNotification

constructor TatNotification.Create(const data: Variant);
//#UC START# *48078161002A_480781120349_var*
//#UC END# *48078161002A_480781120349_var*
begin
//#UC START# *48078161002A_480781120349_impl*
    inherited Create;
    //
    f_Data := data;
//#UC END# *48078161002A_480781120349_impl*
end;//TatNotification.Create

function TatNotification.GetData: Variant;
//#UC START# *48077ED302B8_480781120349_var*
//#UC END# *48077ED302B8_480781120349_var*
begin
//#UC START# *48077ED302B8_480781120349_impl*
    Result := f_Data;
//#UC END# *48077ED302B8_480781120349_impl*
end;//TatNotification.GetData

destructor TatNotification.Destroy;
//#UC START# *48077504027E_480781120349_var*
//#UC END# *48077504027E_480781120349_var*
begin
//#UC START# *48077504027E_480781120349_impl*
    VarClear(f_Data);
    inherited;
//#UC END# *48077504027E_480781120349_impl*
end;//TatNotification.Destroy

end.