unit evCustomTextFormatter;

interface

uses
 l3IntfUses
 , evCustomTextFormatterModelPart
;

type
 TevCustomTextFormatter = class(TevCustomTextFormatterModelPart)
  {* ������ ��� �������������� ������ �� ������� � ������������� ������ � �������������. }
  function NeedAddSpaces: Boolean;
 end;//TevCustomTextFormatter
 
implementation

uses
 l3ImplUses
;

end.
