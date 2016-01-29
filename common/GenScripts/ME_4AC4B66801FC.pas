unit vcmIEntityFormList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
;

type
 TvcmIEntityFormList = class(_l3InterfaceRefList_)
  {* Список IvcmEntityForm }
 end;//TvcmIEntityFormList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
