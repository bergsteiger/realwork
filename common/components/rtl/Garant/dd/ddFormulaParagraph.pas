unit ddFormulaParagraph;

// Модуль: "w:\common\components\rtl\Garant\dd\ddFormulaParagraph.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddFormulaParagraph" MUID: (54F834440140)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddTextParagraph
 , l3Base
 , k2Interfaces
 , ddTypes
;

type
 TddFormulaParagraph = class(TddTextParagraph)
  protected
   function pm_GetFormulaText: Tl3String;
  public
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
  public
   property FormulaText: Tl3String
    read pm_GetFormulaText;
 end;//TddFormulaParagraph

implementation

uses
 l3ImplUses
 , k2Tags
 , ddEVDTypesSupport
;

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
