unit nevSBSCellFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevSBSCellFormatInfo.pas"
// �����: 14.09.2011 12:26
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevSBSCellFormatInfo
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevListFormatInfo
  ;

type
 _CellFormatInfoCommon_Parent_ = TnevListFormatInfo;
 {$Include ..\new\CellFormatInfoCommon.imp.pas}
 TnevSBSCellFormatInfo = class(_CellFormatInfoCommon_)
 public
 // overridden public methods
   function VerticalAlignmentMargin: Integer; override;
     {* ���������� �������� ��������� �� ������� �������, � ����������� �� ������������� ������������. }
 end;//TnevSBSCellFormatInfo

implementation

uses
  evdTypes,
  nevBase,
  k2Tags
  ;

{$Include ..\new\CellFormatInfoCommon.imp.pas}

// start class TnevSBSCellFormatInfo

function TnevSBSCellFormatInfo.VerticalAlignmentMargin: Integer;
//#UC START# *52021CDE00B2_4E706504020E_var*
//#UC END# *52021CDE00B2_4E706504020E_var*
begin
//#UC START# *52021CDE00B2_4E706504020E_impl*
 Result := GetVerticalAlignmentMargin;
//#UC END# *52021CDE00B2_4E706504020E_impl*
end;//TnevSBSCellFormatInfo.VerticalAlignmentMargin

end.