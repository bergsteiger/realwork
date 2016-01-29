unit vcmFormSetDataSource.imp;

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
 , vcmInterfaces
 , vcmExternalInterfaces
 , l3Interfaces
;

type
 // _SetDataType_
 
 // _SetType_
 
 // _InitDataType_
 
 _vcmFormSetDataSource_ = class(Tl3ProtoObjectWithCOMQI, IvcmFormSetDataSource)
  {* Бизнес объект сборки }
  function DoGetFormSetImageIndex: Integer;
  function DoGetTabCaption: IvcmCString;
  function DoGetTabHint: IvcmCString;
  function DoMakeClone: IvcmFormSetDataSource;
  function MakeWithSetData(const aSetData: _SetDataType_): IvcmFormSetDataSource;
  function GetDataForClone: _InitDataType_;
  function MakeData: _SetDataType_;
   {* Данные сборки. }
  procedure DataExchange;
   {* - вызывается после получения данных инициализации. }
  procedure Create(const aData: _InitDataType_);
  function Make(const aData: _InitDataType_): _SetType_;
  function GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean;
  procedure DoPushFromHistory;
   {* сборка была выгружена из истории }
  procedure ClearRefs;
   {* Очищает ссылки на источники данных }
  procedure ClearAreas;
   {* Очищает ссылки на области ввода }
  procedure BeginRefresh;
   {* вызывается перед началом обновления }
  procedure EndRefresh;
   {* вызывается в конце обновления }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* является ли форма главной в сборке }
  function IsLikeUseCaseController(const aDataSource: IvcmFormSetDataSource): Boolean;
   {* определим нужно ли пересоздавать сборку или все отличие в позиции на данных }
  function IsRefreshing: Boolean;
   {* сборка находится в состоянии обновления }
  procedure PushFromHistory;
   {* сборка была выгружена из истории }
  procedure Refresh(const aParams: IvcmFormSetRefreshDataParams);
   {* обновить представление сборки }
  function FormSet: IvcmFormSet;
  function MainCaption: IvcmCString;
  function MainImageIndex: Integer;
  function InInit: Boolean;
   {* флаг взведен при первом обновлении сборки }
  function DataForSave: IvcmData;
   {* данные необходимые сборки храняться отдельно, потому что состоние сборки может в определенные моменты времени сохраняться }
  function FormSetImageIndex: Integer;
  function TabCaption: IvcmCString;
  function TabHint: IvcmCString;
  function MakeClone: IvcmFormSetDataSource;
  procedure PopToHistory;
 end;//_vcmFormSetDataSource_
 
implementation

uses
 l3ImplUses
 , vcmLocalInterfaces
 , l3Base
 , SysUtils
;

end.
