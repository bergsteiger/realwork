unit NOT_FINISHED_evCustomTextFormatter;
 {* ������ ��� �������������� ������ �� ������� � ������������� ������ � �������������. }

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCustomTextFormatter.pas"
// ���������: "SimpleClass"
// ������� ������: "TevCustomTextFormatter" MUID: (4836BEB200A2)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomTextFormatterModelPart
;

type
 TevCustomTextFormatter = class(TevCustomTextFormatterModelPart)
  {* ������ ��� �������������� ������ �� ������� � ������������� ������ � �������������. }
  protected
   function NeedAddSpaces: Boolean; virtual;
 end;//TevCustomTextFormatter

implementation

uses
 l3ImplUses
 //#UC START# *4836BEB200A2impl_uses*
 //#UC END# *4836BEB200A2impl_uses*
;

function TevCustomTextFormatter.NeedAddSpaces: Boolean;
//#UC START# *4A116B45039B_4836BEB200A2_var*
//#UC END# *4A116B45039B_4836BEB200A2_var*
begin
//#UC START# *4A116B45039B_4836BEB200A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A116B45039B_4836BEB200A2_impl*
end;//TevCustomTextFormatter.NeedAddSpaces

end.
