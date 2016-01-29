unit vcmIEntityList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
;

type
 TvcmIEntityList = class(_l3InterfaceRefList_)
  {* Список ссылок на IvcmEntity }
 end;//TvcmIEntityList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
