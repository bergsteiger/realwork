unit SearchProgressIndicatorUnit;
 {* Прогрессиндикаторы для поиска }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SearchProgressIndicatorUnit.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ProgressIndicatorSupportUnit
 , BaseTypesUnit
;

type
 ICancelSearch = interface(ICancelLongProcess)
  ['{77C1D94F-084E-4430-8FE6-796A9817D990}']
 end;//ICancelSearch

 IProgressIndicatorForSearch = interface(IProgressIndicator)
  ['{C403A3AE-7807-49A8-807F-B2FEA60F7695}']
  procedure finish_process(const entity: ISearchEntity);
 end;//IProgressIndicatorForSearch

class function make(const search_manager): BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(const search_manager): BadFactoryType;
var
 l_Inst : ICancelSearch;
begin
 l_Inst := Create(search_manager);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
