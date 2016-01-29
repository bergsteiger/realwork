unit vcmIEntityFormPtrList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
;

type
 TvcmIEntityFormPtrList = class(_l3InterfacePtrList_)
  {* Список указателей на IvcmEntityForm }
 end;//TvcmIEntityFormPtrList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
