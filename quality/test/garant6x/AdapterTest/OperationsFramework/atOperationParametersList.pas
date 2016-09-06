unit atOperationParametersList;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atOperationParametersList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatOperationParametersList" MUID: (48089BA60088)

interface

uses
 l3IntfUses
 , atOperationParameter
 , atStringListWithOwn
 , SysUtils
;

type
 _NamedParameter_ = TatOperationParameter;
 _atNamedParametersList_Parent_ = TObject;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atNamedParametersList.imp.pas}
 TatOperationParametersList = class(_atNamedParametersList_)
 end;//TatOperationParametersList

implementation

uses
 l3ImplUses
 , Classes
 //#UC START# *48089BA60088impl_uses*
 //#UC END# *48089BA60088impl_uses*
;

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atNamedParametersList.imp.pas}

initialization
{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atNamedParametersList.imp.pas}


end.
