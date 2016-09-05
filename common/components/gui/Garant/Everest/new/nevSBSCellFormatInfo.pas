unit nevSBSCellFormatInfo;

// ������: "w:\common\components\gui\Garant\Everest\new\nevSBSCellFormatInfo.pas"
// ���������: "SimpleClass"
// ������� ������: "TnevSBSCellFormatInfo" MUID: (4E706504020E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevListFormatInfo
;

type
 _CellFormatInfoCommon_Parent_ = TnevListFormatInfo;
 {$Include w:\common\components\gui\Garant\Everest\new\CellFormatInfoCommon.imp.pas}
 TnevSBSCellFormatInfo = class(_CellFormatInfoCommon_)
  public
   function VerticalAlignmentMargin: Integer; override;
    {* ���������� �������� ��������� �� ������� �������, � ����������� �� ������������� ������������. }
 end;//TnevSBSCellFormatInfo

implementation

uses
 l3ImplUses
 , evdTypes
 , nevBase
 , k2Tags
 //#UC START# *4E706504020Eimpl_uses*
 //#UC END# *4E706504020Eimpl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\new\CellFormatInfoCommon.imp.pas}

function TnevSBSCellFormatInfo.VerticalAlignmentMargin: Integer;
 {* ���������� �������� ��������� �� ������� �������, � ����������� �� ������������� ������������. }
//#UC START# *52021CDE00B2_4E706504020E_var*
//#UC END# *52021CDE00B2_4E706504020E_var*
begin
//#UC START# *52021CDE00B2_4E706504020E_impl*
 Result := GetVerticalAlignmentMargin;
//#UC END# *52021CDE00B2_4E706504020E_impl*
end;//TnevSBSCellFormatInfo.VerticalAlignmentMargin

end.
