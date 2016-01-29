unit ddRunCommandTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ddRunCommandTaskPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TddRunCommandTaskPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csProcessTask,
  k2Base,
  dt_Types
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddRunCommandTaskPrim = class(TddProcessTask)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // overridden public methods
   constructor Create(aUserID: TUserID); override;
 end;//TddRunCommandTaskPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  evdTaskTypes,
  RunCommandTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TddRunCommandTaskPrim

class function TddRunCommandTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typRunCommandTask;
end;//TddRunCommandTaskPrim.GetTaggedDataType

constructor TddRunCommandTaskPrim.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_53B6A75A024C_var*
//#UC END# *53B3D8A8011F_53B6A75A024C_var*
begin
//#UC START# *53B3D8A8011F_53B6A75A024C_impl*
 inherited;
 //TaskType := cs_ttRunCommand;
//#UC END# *53B3D8A8011F_53B6A75A024C_impl*
end;//TddRunCommandTaskPrim.Create

{$IfEnd} //not Nemesis

end.