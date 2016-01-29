unit vcmUserControls;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , Classes
 , ActnList
;

type
 IvcmBaseObjectDef = interface(IvcmBase)
 end;//IvcmBaseObjectDef
 
 IvcmUserFriendlyControl = interface(IvcmBaseObjectDef)
  {* Базовый интерфейс для объектов имеющих отображение для пользователя }
 end;//IvcmUserFriendlyControl
 
 IvcmIdentifiedUserFriendlyControl = interface(IvcmUserFriendlyControl)
  {* Базовый интерфейс для объектов имеющих отображение для пользователя и идентификатор }
 end;//IvcmIdentifiedUserFriendlyControl
 
 TvcmOperationOption = (
  {* Режим отбражения операции в меню и на панели инструментов. }
  vcm_ooShowInMainToolbar
   {* Операция будет показана на панели
                                  инструментов главной формы }
  , vcm_ooShowInChildToolbar
   {* Операция будет показана на панели
                                  инструментов формы сущности }
  , vcm_ooShowInContextMenu
   {* Операция будет показана в контекстном меню }
  , vcm_ooShowInMainMenu
   {* Операция будет показана в главном меню
                                  главной формы. }
  , vcm_ooShowInChildMenu
   {* Операция будет показана в меню формы
                                  сущности }
 );//TvcmOperationOption
 
 TvcmOperationMode = (
  {* Режим выполнения операции. }
  vcm_omTest
   {* Режим проверки доступности операции }
  , vcm_omExecute
   {* Режим непосредственного выполенения
                      операции }
  , vcm_omAggregateExecute
 );//TvcmOperationMode
 
 TvcmOperationCallType = (
  vcm_octShortCut
  , vcm_octMainMenu
  , vcm_octContextMenu
  , vcm_octToolbar
 );//TvcmOperationCallType
 
 // TvcmUserType
 
 TvcmUserTypes = set of TvcmUserType;
 
 TvcmOperationOptions = set of TvcmOperationOption;
 
 IvcmOperationDef = interface(IvcmIdentifiedUserFriendlyControl)
  {* Описание операции }
 end;//IvcmOperationDef
 
 TvcmToolBarPos = (
  vcm_tbpTop
  , vcm_tbpBottom
  , vcm_tbpLeft
  , vcm_tbpRight
  , vcm_tbpNone
 );//TvcmToolBarPos
 
 TvcmToolBarPoses = set of TvcmToolBarPos;
 
 // TvcmEffectiveToolBarPos
 
 TvcmEffectiveToolBarPoses = set of TvcmEffectiveToolBarPos;
 
 IvcmOperationsDefIterator = interface
  {* Итератор описаний операций }
 end;//IvcmOperationsDefIterator
 
 IvcmOperationalIdentifiedUserFriendlyControl = interface(IvcmIdentifiedUserFriendlyControl)
  {* Базовый интерфейс для объектов имеющих отображение для пользователя и операции }
 end;//IvcmOperationalIdentifiedUserFriendlyControl
 
implementation

uses
 l3ImplUses
;

end.
