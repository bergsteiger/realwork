unit SearchProgressIndicatorUnit;
 {* Прогрессиндикаторы для поиска }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SearchProgressIndicatorUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "SearchProgressIndicator" MUID: (4A38B397024A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , ProgressIndicatorSupportUnit
;

type
 ICancelSearch = interface(ICancelLongProcess)
  ['{77C1D94F-084E-4430-8FE6-796A9817D990}']
 end;//ICancelSearch

 IProgressIndicatorForSearch = interface(IProgressIndicator)
  ['{C403A3AE-7807-49A8-807F-B2FEA60F7695}']
  procedure FinishProcess(const entity: ISearchEntity); stdcall;
 end;//IProgressIndicatorForSearch

implementation

uses
 l3ImplUses
;

end.
