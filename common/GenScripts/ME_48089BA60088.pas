unit atOperationParametersList;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atOperationParametersList.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationParameter
 , atStringListWithOwn
;

type
 _NamedParameter_ = TatOperationParameter;
 _atNamedParametersList_Parent_ = TObject;
 {$Include atNamedParametersList.imp.pas}
 TatOperationParametersList = class(_atNamedParametersList_)
 end;//TatOperationParametersList

implementation

uses
 l3ImplUses
 , Classes
;

{$Include atNamedParametersList.imp.pas}

end.
