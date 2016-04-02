unit atStringListWithOwn;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringListWithOwn.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatStringListWithOwn" MUID: (4807752C025A)

interface

uses
 l3IntfUses
 , Classes
;

type
 TatStringListWithOwn = class(TStringList)
  private
   f_OwnsObjects: Boolean;
  public
   constructor Create(ownsObjects: Boolean); reintroduce;
   destructor Destroy; override;
  public
   property OwnsObjects: Boolean
    read f_OwnsObjects
    write f_OwnsObjects;
 end;//TatStringListWithOwn

implementation

uses
 l3ImplUses
;

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
