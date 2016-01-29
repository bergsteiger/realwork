unit vcmFormsUtils;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , vcmEntityForm
;

type
 TvcmSlayedEntityFormsList = class(_l3ObjectPtrList_)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmSlayedEntityFormsList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
