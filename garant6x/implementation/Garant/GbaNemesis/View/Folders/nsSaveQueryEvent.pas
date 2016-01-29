unit nsSaveQueryEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/nsSaveQueryEvent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 �������� ����������::Folders::View::Folders::TnsSaveQueryEvent
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
  SearchUnit,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSaveQueryEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aQuery: IQuery);
 end;//TnsSaveQueryEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsLogEventData,
  nsLogManager,
  LoggingUnit,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSaveQueryEvent

class procedure TnsSaveQueryEvent.Log(const aQuery: IQuery);
//#UC START# *51BEFAF401A3_51BEFA6F00E3_var*
var
 l_Data: InsLogEventData;
//#UC END# *51BEFAF401A3_51BEFA6F00E3_var*
begin
//#UC START# *51BEFAF401A3_51BEFA6F00E3_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aQuery);
 GetLogger.AddEvent(LE_SAVE_QUERY, l_Data);
//#UC END# *51BEFAF401A3_51BEFA6F00E3_impl*
end;//TnsSaveQueryEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.