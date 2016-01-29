unit nsFoundRangeCollector;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsFoundRangeCollector.pas"
// �����: 23.03.2011 20:32
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::ContextSearchInEVDDocument::TnsFoundRangeCollector
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nevRangeList,
  evSearch,
  nevBase,
  nevTools
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsFoundRangeCollector = class(TevBaseReplacer)
 private
 // private fields
   f_FoundRanges : TnevRangeList;
    {* ���� ��� �������� FoundRanges}
 protected
 // realized methods
   function ReplaceFunc(const aView: InevView;
     const Container: InevOp;
     const aBlock: InevRange): Boolean; override;
     {* ����������� ������� ��� ������ ����� Block �� ���-�� ���.
             ���������� - ������ ����������� ������ ������� }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public properties
   property FoundRanges: TnevRangeList
     read f_FoundRanges
     write f_FoundRanges;
 end;//TnsFoundRangeCollector
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsFoundRangeCollector

function TnsFoundRangeCollector.ReplaceFunc(const aView: InevView;
  const Container: InevOp;
  const aBlock: InevRange): Boolean;
//#UC START# *4D553AC103A3_4D8A2C1700FD_var*
//#UC END# *4D553AC103A3_4D8A2C1700FD_var*
begin
//#UC START# *4D553AC103A3_4D8A2C1700FD_impl*
 Result := true;
 if (f_FoundRanges = nil) then
  f_FoundRanges := TnevRangeList.Create;
 f_FoundRanges.Add(aBlock); 
//#UC END# *4D553AC103A3_4D8A2C1700FD_impl*
end;//TnsFoundRangeCollector.ReplaceFunc

procedure TnsFoundRangeCollector.Cleanup;
//#UC START# *479731C50290_4D8A2C1700FD_var*
//#UC END# *479731C50290_4D8A2C1700FD_var*
begin
//#UC START# *479731C50290_4D8A2C1700FD_impl*
 FreeAndNil(f_FoundRanges);
 inherited;
//#UC END# *479731C50290_4D8A2C1700FD_impl*
end;//TnsFoundRangeCollector.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.