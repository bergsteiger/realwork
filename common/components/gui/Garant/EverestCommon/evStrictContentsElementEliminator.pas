unit evStrictContentsElementEliminator;
 {* ������, ��������� "�������� ����������" (k2_idContentsElement). �� �� �����, � ������� ������ ����������� }

// ������: "w:\common\components\gui\Garant\EverestCommon\evStrictContentsElementEliminator.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
;

type
 TevStrictContentsElementEliminator = class(Tk2TagFilter)
  {* ������, ��������� "�������� ����������" (k2_idContentsElement). �� �� �����, � ������� ������ ����������� }
  protected
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevStrictContentsElementEliminator

implementation

uses
 l3ImplUses
 , ContentsElement_Const
;

function TevStrictContentsElementEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4CA2FFC10275_var*
//#UC END# *4CA3006302BC_4CA2FFC10275_var*
begin
//#UC START# *4CA3006302BC_4CA2FFC10275_impl*
 Result := (CurrentType.ID <> k2_idContentsElement);
//#UC END# *4CA3006302BC_4CA2FFC10275_impl*
end;//TevStrictContentsElementEliminator.NeedTranslateChildToNext

end.
