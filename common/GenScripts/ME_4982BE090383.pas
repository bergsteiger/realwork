unit vcmControllers;

interface

uses
 l3IntfUses
 , vcmBaseTypes
 , vcmInterfaces
;

type
 TvcmNeedMakeDS = vcmBaseTypes.TvcmNeedMakeDS;
  {* ѕеречислимый тип определ€ющий необходимость создани€ Ѕќ‘ }
 
 IvcmFormDataSourceRef = interface
  {* —амоочищаема€ ссылка на бизнес объект формы. }
  procedure Clear;
   {* сбрасывает ссылку на _DataSource и NeedMake устанавливает как vcm_nmNo }
  procedure SetIfNeedMakeNo(aValue: TvcmNeedMakeDS);
   {* устанавливаем флаг если его значение vcm_nmNo }
  procedure Assign(const aSource: IvcmFormDataSourceRef);
   {* скопировать данные aSource }
 end;//IvcmFormDataSourceRef
 
 IvcmViewAreaControllerRef = IvcmFormDataSourceRef;
 
 IvcmViewAreaController = IvcmFormDataSource;
  {* —сылка на IvcmFormDataSource. ƒл€ использовани€ в автоматичексом кода. ¬ ручном коде примен€ть Ќ≈Ћ№«я, надо примен€ть IvcmFormDataSource }
 
 IvcmUseCaseController = IvcmFormSetDataSource;
  {* —сылка на IvcmFormSetDataSource. ƒл€ использовани€ в автоматичексом кода. ¬ ручном коде примен€ть Ќ≈Ћ№«я, надо примен€ть IvcmFormSetDataSource }
 
implementation

uses
 l3ImplUses
;

end.
