unit NOT_FINISHED_dd_lcBaseFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_dd_lcBaseFilter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::Filters::dd_lcBaseFilter
//
// Базовые фильтры
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2TagFilter,
  ddHeaderFilter
  ;

type
 Tdd_lcParaFilter = class(TevdLeafParaFilter)
 end;//Tdd_lcParaFilter

 Tdd_lcBaseFilter = class(Tk2TagFilter)
 end;//Tdd_lcBaseFilter

 Tdd_lcSynoFilter = class(Tdd_lcBaseFilter)
 end;//Tdd_lcSynoFilter

 Tdd_lcBaseHeaderFilter = class(TddHeaderFilter)
 end;//Tdd_lcBaseHeaderFilter

implementation

end.