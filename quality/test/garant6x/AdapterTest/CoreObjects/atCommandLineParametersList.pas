unit atCommandLineParametersList;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atCommandLineParametersList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatCommandLineParametersList" MUID: (480895780098)

interface

uses
 l3IntfUses
 , atCommandLineParameter
 , atStringListWithOwn
 , SysUtils
;

type
 _NamedParameter_ = TatCommandLineParameter;
 _atNamedParametersList_Parent_ = TObject;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atNamedParametersList.imp.pas}
 TatCommandLineParametersList = class(_atNamedParametersList_)
 end;//TatCommandLineParametersList

implementation

uses
 l3ImplUses
 , Classes
;

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atNamedParametersList.imp.pas}

end.
