unit vcmFormDataSourceRef;

interface

uses
 l3IntfUses
 , vcmControllers
 , l3ProtoObject
 , l3Interfaces
 , vcmBaseTypes
 , vcmInterfaces
;

type
 TvcmFormDataSourceRef = class(Tl3ProtoObject, Il3ItemNotifyRecipient, IvcmFormDataSourceRef)
  {* Реализация ссылки на бизнес объект формы }
  procedure Create(aNeedMake: TvcmNeedMakeDS);
  function Make(aNeedMake: TvcmNeedMakeDS): IvcmFormDataSourceRef;
   {* Фабричный метод }
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* прошла операция. }
  procedure Clear;
   {* сбрасывает ссылку на _DataSource и NeedMake устанавливает как vcm_nmNo }
  procedure SetIfNeedMakeNo(aValue: TvcmNeedMakeDS);
   {* устанавливаем флаг если его значение vcm_nmNo }
  procedure Assign(const aSource: IvcmFormDataSourceRef);
   {* скопировать данные aSource }
  function Referred: IvcmFormDataSource;
   {* Ссылка на контроллер области вывода }
  function NeedMake: TvcmNeedMakeDS;
   {* определяет необходимость создания БОФ }
  function IsEmpty: Boolean;
   {* определяет наличие источника данных. }
  function CanBeClosed: Boolean;
   {* можно ли закрыть }
 end;//TvcmFormDataSourceRef
 
 TvcmViewAreaControllerRef = TvcmFormDataSourceRef;
 
implementation

uses
 l3ImplUses
;

end.
