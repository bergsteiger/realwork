unit IntegrationProjectUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/IntegrationProjectUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// Пакет для проекта интеграции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit
  ;

type
 TIntegrationType = (
  {* тип объекта }
   IT_LISTENTRYINFO // закладка
 , IT_LIST // список
 , IT_QUERY // запрос
 );//TIntegrationType

 CantCreateObject = class
  {* в базе недостаточно данных для построения объекта }
 end;//CantCreateObject

 IIntegration = interface(IUnknown)
  {* интерфейс для работы с проектом интеграции }
   ['{7D2AE9F6-BB67-44E2-B9AC-705E2293178D}']
   function GetIntegrationEnabled: ByteBool; stdcall;
   procedure GetIntegrationComplectId(out aRet {: IString}); stdcall; // can raise CanNotFindData
     {* возвращает идентификатор комлекта. }
   function GetObjectByXml(aXml: PAnsiChar;
    out aResult: IUnknown): TIntegrationType; stdcall; // can raise CanNotFindData, InvalidXMLType, CantCreateObject
     {* метод возвращает объект по поданному xml-у }
   property integration_enabled: ByteBool
     read GetIntegrationEnabled;
     {* доступны ли в версии возможности для внешних интеграторов }
 end;//IIntegration

implementation

end.