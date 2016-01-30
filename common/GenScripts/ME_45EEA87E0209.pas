unit MonitoringUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\MonitoringUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DynamicDocListUnit
 , DocumentUnit
 , FiltersUnit
 , DynamicTreeUnit
 , IOUnit
 , SearchProgressIndicatorUnit
;

type
 IMonitoringList = interface(ISearchEntity)
  {* Интерфейс-врапер, для того что бы отдать Документ с мониторингом ввиде Списка из опроеации поиска. Сразу после получения MonitoringList необхождимо преобразовать его к документу, через метод summary }
  ['{F6B6B6C2-1E10-41B3-8251-B37665DE05BB}']
  function Get_summary: IDocument;
  function As_IDynList: IDynList;
   {* Метод приведения нашего интерфейса к IDynList }
  property summary: IDocument
   read Get_summary;
 end;//IMonitoringList

 IMonitoring = interface
  ['{FD231406-37D4-4C3C-A82F-592343031D3B}']
  function Get_news_line_root: INodeBase;
  function is_news_line_defined: Boolean;
  function is_exist: Boolean;
  property news_line_root: INodeBase
   read Get_news_line_root;
 end;//IMonitoring

class function make(server_list;
 document_count: Cardinal): IDynList;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(server_list;
 document_count: Cardinal): IDynList;
var
 l_Inst : IMonitoringList;
begin
 l_Inst := Create(server_list, document_count);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IMonitoring;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
