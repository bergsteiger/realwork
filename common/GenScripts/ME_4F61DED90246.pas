unit npControls;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , Controls
 , vtNavigator
;

type
 TnpControls = class(_l3ObjectPtrList_)
  {* указывает от какого навигатора на форме был отстыкован компонент }
  function DeleteControl(aControl: TControl): Boolean;
  procedure Create(aNavigator: TvtNavigatorPrim);
 end;//TnpControls
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
