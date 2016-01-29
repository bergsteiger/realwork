unit vcmEntityFormsIterable;

interface

uses
 l3IntfUses
 , vcmIEntityFormPtrList
 , vcmInterfaces
 , vcmBaseTypes
;

type
 TvcmEntityFormsIterable = class(TvcmIEntityFormPtrList, IvcmEntityFormsIterable)
  procedure Make;
  function FormsCount: Integer;
  procedure IterateFormsF(anAction: TvcmIteratorAction);
  procedure AddForm(const aForm: IvcmEntityForm);
 end;//TvcmEntityFormsIterable
 
implementation

uses
 l3ImplUses
;

end.
