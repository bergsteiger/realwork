unit vcmFormSetFactoryFacade;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , vcmFormSetFactory
;

type
 TvcmFormSetFactoryFacade = class(Tl3ProtoObject, IvcmFormSetSimpleFactory)
  procedure Create(aFactoryClass: RvcmFormSetFactory);
  function Make(aFactoryClass: RvcmFormSetFactory): IvcmFormSetSimpleFactory;
  function MakeFormset(const aDataSource: IvcmFormSetDataSource;
   const aContainer: IvcmContainer;
   aSaveToHistory: Boolean;
   aLockSetFocusToMainObjectForm: Boolean;
   const aFormSetToClone: IvcmFormSet): IvcmFormSet;
 end;//TvcmFormSetFactoryFacade
 
implementation

uses
 l3ImplUses
;

end.
