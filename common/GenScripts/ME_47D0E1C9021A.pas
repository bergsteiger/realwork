unit vcmFormHandler;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmExternalInterfaces
 , vcmEntityForm
 , Classes
 , Forms
;

type
 TvcmFormHandler = class(Tl3ProtoObject, IvcmFormHandler)
  procedure Create(aForm: TvcmEntityForm;
   aHandler: TNotifyEvent;
   const aHint: IvcmCString);
  function Make(aForm: TvcmEntityForm;
   aHandler: TNotifyEvent;
   const aHint: IvcmCString): IvcmFormHandler;
  function Handler: TNotifyEvent;
   {* Обработчик формы. }
  function Hint: IvcmCString;
   {* Подсказка к обработчику. }
  function Form: TCustomForm;
   {* Форма обработчика. }
  function CanHaveCloseButtonInNavigator: Boolean;
  function CanHaveOwnCloseButtonInNavigator: Boolean;
 end;//TvcmFormHandler
 
implementation

uses
 l3ImplUses
;

end.
