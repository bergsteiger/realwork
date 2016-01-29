unit vcmControllers;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/vcmControllers.pas"
// Начат: 30.01.2009 11:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmControllers
//
// Интерфейсы контроллеров
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmBaseTypes
  ;

type
 TvcmNeedMakeDS = vcmBaseTypes.TvcmNeedMakeDS;
  {* Перечислимый тип определяющий необходимость создания БОФ }

 IvcmFormDataSourceRef = interface(IUnknown)
  {* Самоочищаемая ссылка на бизнес объект формы. }
   ['{F5C8B83F-1541-4055-A90B-32A85E5C3969}']
   function pm_GetIsEmpty: Boolean;
   function pm_GetCanBeClosed: Boolean;
   function pm_GetReferred: IvcmFormDataSource;
   procedure pm_SetReferred(const aValue: IvcmFormDataSource);
   function pm_GetNeedMake: TvcmNeedMakeDS;
   procedure pm_SetNeedMake(aValue: TvcmNeedMakeDS);
   procedure Clear;
     {* сбрасывает ссылку на _DataSource и NeedMake устанавливает как vcm_nmNo }
   procedure SetIfNeedMakeNo(aValue: TvcmNeedMakeDS);
     {* устанавливаем флаг если его значение vcm_nmNo }
   procedure Assign(const aSource: IvcmFormDataSourceRef);
     {* скопировать данные aSource }
   property IsEmpty: Boolean
     read pm_GetIsEmpty;
     {* определяет наличие источника данных. }
   property CanBeClosed: Boolean
     read pm_GetCanBeClosed;
     {* можно ли закрыть }
   property Referred: IvcmFormDataSource
     read pm_GetReferred
     write pm_SetReferred;
     {* Ссылка на контроллер области вывода }
   property NeedMake: TvcmNeedMakeDS
     read pm_GetNeedMake
     write pm_SetNeedMake;
     {* определяет необходимость создания БОФ }
 end;//IvcmFormDataSourceRef

 IvcmViewAreaControllerRef = IvcmFormDataSourceRef;

 IvcmViewAreaController = vcmInterfaces.IvcmFormDataSource;
  {* Ссылка на IvcmFormDataSource. Для использования в автоматичексом кода. В ручном коде применять НЕЛЬЗЯ, надо применять IvcmFormDataSource }

 IvcmUseCaseController = vcmInterfaces.IvcmFormSetDataSource;
  {* Ссылка на IvcmFormSetDataSource. Для использования в автоматичексом кода. В ручном коде применять НЕЛЬЗЯ, надо применять IvcmFormSetDataSource }

const
  { Алиасы для значений vcmBaseTypes.TvcmNeedMakeDS }
 vcm_nmForce = vcmBaseTypes.vcm_nmForce;
  { создавать не взирая ни на что }
 vcm_nmNo = vcmBaseTypes.vcm_nmNo;
  { нельзя создавать, например потому, что форма была закрыта пользователем и при обновлении сборки ее создавать не нужно }
 vcm_nmYes = vcmBaseTypes.vcm_nmYes;
  { начальное состояние }
{$IfEnd} //not NoVCM

implementation

end.