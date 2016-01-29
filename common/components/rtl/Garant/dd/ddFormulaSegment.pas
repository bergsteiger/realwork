unit ddFormulaSegment;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddFormulaSegment.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddFormulaSegment
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddObjectSegment,
  ddTextSegment
  ;

type
 TddFormulaSegment = class(TddObjectSegment)
 protected
 // realized methods
   function Clone: TddTextSegment; override;
 end;//TddFormulaSegment

implementation

// start class TddFormulaSegment

function TddFormulaSegment.Clone: TddTextSegment;
//#UC START# *54DC46B50110_54D9ACC002E1_var*
//#UC END# *54DC46B50110_54D9ACC002E1_var*
begin
//#UC START# *54DC46B50110_54D9ACC002E1_impl*
 Result := TddFormulaSegment.Create;
 Result.Assign(Self);
//#UC END# *54DC46B50110_54D9ACC002E1_impl*
end;//TddFormulaSegment.Clone

end.