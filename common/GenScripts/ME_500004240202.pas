unit vcmLayout.imp;

interface

uses
 l3IntfUses
 , vcmControllers
 , vcmInterfaces
;

type
 _vcmLayout_ = class
  procedure MakeControls;
  procedure InitEntities;
   {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
  procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
   const aNew: IvcmFormDataSource);
  function GetIsMainObjectForm: Boolean;
  procedure SetControlsResources;
   {* Установить контролам ресурсы для интернационализации }
  procedure EntitiesInited;
   {* Вызывается после того как все операции зарегистрированы }
  procedure InitControls;
   {* Процедура инициализации контролов. Для перекрытия в потомках }
  procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
   const aNew: IvcmViewAreaController);
   {* Изменился источник данных. Для перекрытия в потомках }
 end;//_vcmLayout_
 
implementation

uses
 l3ImplUses
;

end.
