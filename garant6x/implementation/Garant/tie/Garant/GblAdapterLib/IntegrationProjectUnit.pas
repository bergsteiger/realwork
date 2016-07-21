unit IntegrationProjectUnit;
 {* Пакет для проекта интеграции }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\IntegrationProjectUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "IntegrationProject" MUID: (463F4DE5003E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
;

type
 TIntegrationType = (
  {* тип объекта }
  IT_LISTENTRYINFO
   {* закладка }
  , IT_LIST
   {* список }
  , IT_QUERY
   {* запрос }
 );//TIntegrationType

 CantCreateObject = class
  {* в базе недостаточно данных для построения объекта }
 end;//CantCreateObject

 IIntegration = interface
  {* интерфейс для работы с проектом интеграции }
  ['{7D2AE9F6-BB67-44E2-B9AC-705E2293178D}']
  function GetIntegrationEnabled: ByteBool; stdcall;
  procedure GetIntegrationComplectId(out aRet
   {* IString }); stdcall; { can raise CanNotFindData }
   {* возвращает идентификатор комлекта. }
  function GetObjectByXml(xml: PAnsiChar;
   out result: IUnknown): TIntegrationType; stdcall; { can raise CanNotFindData, InvalidXMLType, CantCreateObject }
   {* метод возвращает объект по поданному xml-у }
  property IntegrationEnabled: ByteBool
   read GetIntegrationEnabled;
   {* доступны ли в версии возможности для внешних интеграторов }
 end;//IIntegration

implementation

uses
 l3ImplUses
;

end.
