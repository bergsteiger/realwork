unit atNotification;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atNotification.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatNotification" MUID: (480781120349)

interface

uses
 l3IntfUses
 , atInterfaces
;

type
 TatNotification = class(TInterfacedObject, IatNotification)
  private
   f_Data: Variant;
  protected
   function GetData: Variant;
  public
   constructor Create(const data: Variant); reintroduce;
   destructor Destroy; override;
 end;//TatNotification

implementation

uses
 l3ImplUses
 //#UC START# *480781120349impl_uses*
 //#UC END# *480781120349impl_uses*
;

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
