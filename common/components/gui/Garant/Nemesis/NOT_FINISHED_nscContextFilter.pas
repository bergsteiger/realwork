unit NOT_FINISHED_nscContextFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// ������: "w:/common/components/gui/Garant/Nemesis/NOT_FINISHED_nscContextFilter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::ContextFilter::TnscContextFilter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscContextFilter = class
 private
 // private fields
   f_OnChange : TNotifyEvent;
    {* ���� ��� �������� OnChange}
   f_OnWrongContext : TNotifyEvent;
    {* ���� ��� �������� OnWrongContext}
 public
 // public properties
   property OnChange: TNotifyEvent
     read f_OnChange
     write f_OnChange;
   property OnWrongContext: TNotifyEvent
     read f_OnWrongContext
     write f_OnWrongContext;
 end;//TnscContextFilter
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  nscContextFilterRes
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}


{$IfEnd} //Nemesis
end.