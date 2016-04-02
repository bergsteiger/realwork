unit atExecutionContext;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atExecutionContext.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatExecutionContext" MUID: (480869EE029E)

interface

uses
 l3IntfUses
 , atUserWorkContext
 , atGblAdapterWorker
;

type
 TatLoginData = record
  Login: AnsiString;
  Password: AnsiString;
 end;//TatLoginData

 TatExecutionContext = class(TObject)
  private
   f_MinDelay: Integer;
   f_MaxDelay: Integer;
   f_UserWorkContext: TatUserWorkContext;
    {* Рабочий контекст пользователя. Текущие документ, список, папка и т.п. вещи. }
  public
   F_LoginData: TatLoginData;
  protected
   function pm_GetGblAdapterWorker: TatGblAdapterWorker; virtual;
  public
   constructor Create; reintroduce;
   destructor Destroy; override;
  public
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
 l3ImplUses
 , SysUtils
;

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
