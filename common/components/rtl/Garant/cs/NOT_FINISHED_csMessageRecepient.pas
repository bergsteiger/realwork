unit NOT_FINISHED_csMessageRecepient;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csMessageRecepient.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsMessageRecepient
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  ddClientMessageSortableList
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsMessageRecepient = class(Tl3ProtoObject)
 private
 // private fields
   f_Messages : TddClientMessageSortableList;
    {* ���� ��� �������� Messages}
 public
 // public properties
   property Messages: TddClientMessageSortableList
     read f_Messages;
 end;//TcsMessageRecepient
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.