unit nsExportToFileEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsExportToFileEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Base Forms::TnsExportToFileEvent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsExportToFileEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument);
 end;//TnsExportToFileEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsExportToFileEvent

class procedure TnsExportToFileEvent.Log(const aDoc: IDocument);
//#UC START# *4B0B99960016_4B0B997901E9_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0B99960016_4B0B997901E9_var*
begin
//#UC START# *4B0B99960016_4B0B997901E9_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_EXPORT_TO_FILE, l_Data);
//#UC END# *4B0B99960016_4B0B997901E9_impl*
end;//TnsExportToFileEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.