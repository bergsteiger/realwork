unit vtNavigatorForm;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmExternalInterfaces
;

type
 TvtNavigatorForm = class(Tl3ProtoObject)
  {* Элемент списка  форм навигатора. }
  procedure Create(const aCloseHandler: IvcmFormHandler);
   {* Конструктор класса. }
 end;//TvtNavigatorForm
 
implementation

uses
 l3ImplUses
;

end.
