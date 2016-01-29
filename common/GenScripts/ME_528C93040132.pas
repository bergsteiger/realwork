unit vcmBaseTypes;

interface

uses
 l3IntfUses
 , l3Types
;

type
 TvcmFormID = object
 end;//TvcmFormID
 
 TvcmZoneType = (
  vcm_ztAny
  , vcm_ztMain
  , vcm_ztNavigator
  , vcm_ztParent
  , vcm_ztChild
  , vcm_ztReminder
  , vcm_ztFloating
  , vcm_ztModal
  , vcm_ztManualModal
  , vcm_ztForToolbarsInfo
  , vcm_ztSimpleFloat
  , vcm_ztMainObjectForm
  , vcm_ztForFocus
 );//TvcmZoneType
 
 TvcmNeedMakeDS = (
  {* Перечислимый тип определяющий необходимость создания БОФ }
  vcm_nmForce
   {* создавать не взирая ни на что }
  , vcm_nmNo
   {* нельзя создавать, например потому, что форма была закрыта пользователем и при обновлении сборки ее создавать не нужно }
  , vcm_nmYes
   {* начальное состояние }
 );//TvcmNeedMakeDS
 
 TvcmIteratorAction = Tl3IteratorAction;
 
implementation

uses
 l3ImplUses
;

end.
