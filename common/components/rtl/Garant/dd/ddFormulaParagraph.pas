unit ddFormulaParagraph;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddFormulaParagraph.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddFormulaParagraph
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Base,
  ddTextParagraph,
  k2Interfaces,
  ddTypes
  ;

type
 TddFormulaParagraph = class(TddTextParagraph)
 protected
 // property methods
   function pm_GetFormulaText: Tl3String;
 public
 // overridden public methods
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aNeedProcessRow: Boolean;
     LiteVersion: TddLiteVersion); override;
 public
 // public properties
   property FormulaText: Tl3String
     read pm_GetFormulaText;
 end;//TddFormulaParagraph

implementation

uses
  k2Tags,
  ddEVDTypesSupport
  ;

// start class TddFormulaParagraph

function TddFormulaParagraph.pm_GetFormulaText: Tl3String;
//#UC START# *54F835210066_54F834440140get_var*
//#UC END# *54F835210066_54F834440140get_var*
begin
//#UC START# *54F835210066_54F834440140get_impl*
 Result := Text;
//#UC END# *54F835210066_54F834440140get_impl*
end;//TddFormulaParagraph.pm_GetFormulaText

procedure TddFormulaParagraph.Write2Generator(const Generator: Ik2TagGenerator;
  aNeedProcessRow: Boolean;
  LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_54F834440140_var*
//#UC END# *518A504F00F5_54F834440140_var*
begin
//#UC START# *518A504F00F5_54F834440140_impl*
 StartFormulaPara(Generator);
 try
  Generator.AddStringAtom(k2_tiText, FormulaText.AsWStr);
 finally
  Generator.Finish;
 end;
//#UC END# *518A504F00F5_54F834440140_impl*
end;//TddFormulaParagraph.Write2Generator

end.