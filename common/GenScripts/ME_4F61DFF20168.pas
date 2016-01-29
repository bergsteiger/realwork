unit npNavigatorListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vtNavigator
;

type
 TnpNavigatorListPrim = class(_l3ObjectPtrList_)
  {* список навигаторов созданных в приложении. Список используется для рассылки сообщений }
  procedure Reg(aNavigator: TvtNavigatorPrim);
   {* зарегистрировать навигатор }
  procedure UnReg(aNavigator: TvtNavigatorPrim);
   {* дерегистрировать навигатор }
 end;//TnpNavigatorListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
