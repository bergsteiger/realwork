unit atExecutionContext;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/OperationsFramework/atExecutionContext.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::OperationsFramework::TatExecutionContext
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atUserWorkContext,
  atGblAdapterWorker
  ;

type
 TatLoginData = record
   Login : AnsiString;
   Password : AnsiString;
 end;//TatLoginData

 TatExecutionContext = class(TObject)
 private
 // private fields
   f_MinDelay : Integer;
    {* Поле для свойства MinDelay}
   f_MaxDelay : Integer;
    {* Поле для свойства MaxDelay}
   f_UserWorkContext : TatUserWorkContext;
    {* Поле для свойства UserWorkContext}
 protected
 // property methods
   function pm_GetGblAdapterWorker: TatGblAdapterWorker; virtual;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public fields
   F_LoginData : TatLoginData;
 public
 // public methods
   constructor Create; reintroduce;
 public
 // public properties
   property MinDelay: Integer
     read f_MinDelay
     write f_MinDelay;
   property MaxDelay: Integer
     read f_MaxDelay
     write f_MaxDelay;
   property UserWorkContext: TatUserWorkContext
     read f_UserWorkContext;
     {* Рабочий контекст пользователя. Текущие документ, список, папка и т.п. вещи. }
   property GblAdapterWorker: TatGblAdapterWorker
     read pm_GetGblAdapterWorker;
 end;//TatExecutionContext

implementation

uses
  SysUtils
  ;

// start class TatExecutionContext

function TatExecutionContext.pm_GetGblAdapterWorker: TatGblAdapterWorker;
//#UC START# *483C18680261_480869EE029Eget_var*
//#UC END# *483C18680261_480869EE029Eget_var*
begin
//#UC START# *483C18680261_480869EE029Eget_impl*
 Result := TatGblAdapterWorker.Instance;
//#UC END# *483C18680261_480869EE029Eget_impl*
end;//TatExecutionContext.pm_GetGblAdapterWorker

constructor TatExecutionContext.Create;
//#UC START# *48086AF9022F_480869EE029E_var*
//#UC END# *48086AF9022F_480869EE029E_var*
begin
//#UC START# *48086AF9022F_480869EE029E_impl*
    inherited;
    f_UserWorkContext := TatUserWorkContext.Create;
//#UC END# *48086AF9022F_480869EE029E_impl*
end;//TatExecutionContext.Create

destructor TatExecutionContext.Destroy;
//#UC START# *48077504027E_480869EE029E_var*
//#UC END# *48077504027E_480869EE029E_var*
begin
//#UC START# *48077504027E_480869EE029E_impl*
    FreeAndNil(f_UserWorkContext);
    inherited;
//#UC END# *48077504027E_480869EE029E_impl*
end;//TatExecutionContext.Destroy

end.