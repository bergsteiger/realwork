unit atCommandLineParametersList;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atCommandLineParametersList.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atCommandLineParameter
 , atStringListWithOwn
;

type
 _NamedParameter_ = TatCommandLineParameter;
 _atNamedParametersList_Parent_ = TObject;
 {$Include atNamedParametersList.imp.pas}
 TatCommandLineParametersList = class(_atNamedParametersList_)
 end;//TatCommandLineParametersList

implementation

uses
 l3ImplUses
 , Classes
;

{$Include atNamedParametersList.imp.pas}

end.
