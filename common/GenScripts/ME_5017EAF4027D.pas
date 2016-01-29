unit vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp;

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
 , vcmInterfaces
 , vcmLocalInterfaces
 , vcmExternalInterfaces
 , l3Interfaces
;

type
 // _UseCaseControllerType_
 
 // _FormDataSourceType_
 
 _vcmFormDataSourcePrimWithFlexUseCaseControllerType_ = class(Tl3ProtoObjectWithCOMQI, IvcmFormDataSource, IvcmFormSetDataSourceListener)
  function GetIsDataAvailable: Boolean;
   {* существуют ли данные }
  procedure Create(const aDataSource: _UseCaseControllerType_);
  function Make(const aDataSource: _UseCaseControllerType_): _FormDataSourceType_;
  procedure ClearRefs;
   {* Очищает ссылки на различные представления прецедента }
  procedure FormSetDataChanged;
  function GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean;
  function GetIsSame(const aValue: _FormDataSourceType_): Boolean;
  procedure InitRefs(const aDS: IvcmFormSetDataSource);
   {* Инициализирует ссылки на различные представления прецедента }
  function MakeDisplayName: IvcmCString;
  procedure DataChanged;
   {* данные изменились }
  function IsSame(const aValue: IvcmFormDataSource): Boolean;
   {* проверка на равенство }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* является ли форма главной в сборке }
  function IsLikeViewAreaController(const aDataSource: IvcmFormDataSource): Boolean;
   {* определим нужно ли менять позицию на данные }
  function UseCaseController: IvcmFormSetDataSource;
   {* Контроллер логики прецедента. При изменении полей бизнес объекта, он принимает решение об обновлении данных сборки (Refresh) }
  function CastUCC(const aGUID: TGUID;
   out theObj;
   NeedsException: Boolean): Boolean;
   {* Приводит контроллер прецедента к заданному интерфейсу. Это нужно, чтобы избавится от явного знания о контроллере прецедента. [$122674504] }
  function DisplayName: IvcmCString;
   {* название источинка данных }
  function IsDataAvailable: Boolean;
   {* существуют ли данные в текущих условиях. Например, на текущей базе. }
 end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3InterfacesMisc
 , l3Base
;

end.
