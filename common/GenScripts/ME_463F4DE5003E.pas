unit IntegrationProjectUnit;
 {* Пакет для проекта интеграции }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\IntegrationProjectUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

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
  function Get_integration_enabled: Boolean;
  function get_integration_complect_id: IString; { can raise CanNotFindData }
   {* возвращает идентификатор комлекта. }
  function get_object_by_xml(xml: PAnsiChar;
   out result: IUnknown): TIntegrationType; { can raise CanNotFindData, InvalidXMLType, CantCreateObject }
   {* метод возвращает объект по поданному xml-у }
  property integration_enabled: Boolean
   read Get_integration_enabled;
   {* доступны ли в версии возможности для внешних интеграторов }
 end;//IIntegration

class function make: BadFactoryType;
 {* фабрика }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : IIntegration;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
