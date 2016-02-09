unit nevSBSCellFormatInfo;

// ������: "w:\common\components\gui\Garant\Everest\new\nevSBSCellFormatInfo.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevListFormatInfo
;

type
 _CellFormatInfoCommon_Parent_ = TnevListFormatInfo;
 {$Include CellFormatInfoCommon.imp.pas}
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
;

{$Include CellFormatInfoCommon.imp.pas}

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
