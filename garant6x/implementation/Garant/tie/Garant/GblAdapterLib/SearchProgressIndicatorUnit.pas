unit SearchProgressIndicatorUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/SearchProgressIndicatorUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::SearchProgressIndicator
//
// Прогрессиндикаторы для поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  ProgressIndicatorSupportUnit
  ;

type
 ICancelSearch = interface(ICancelLongProcess)
   ['{77C1D94F-084E-4430-8FE6-796A9817D990}']
 end;//ICancelSearch

 IProgressIndicatorForSearch = interface(IProgressIndicator)
   ['{C403A3AE-7807-49A8-807F-B2FEA60F7695}']
   procedure FinishProcess(const aEntity: ISearchEntity); stdcall;
 end;//IProgressIndicatorForSearch

implementation

end.