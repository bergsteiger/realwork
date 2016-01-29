unit nsDocumentPrintEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/nsDocumentPrintEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::TnsDocumentPrintEvent
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
  LoggingInterfaces,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDocumentPrintEvent = class(TnsLogEvent, InsDefferedEvent)
 private
 // private fields
   f_Doc : IDocument;
   f_Selection : Boolean;
 protected
 // realized methods
   procedure FireLog;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aDoc: IDocument;
    aSelection: Boolean); reintroduce;
   class function Make(const aDoc: IDocument;
    aSelection: Boolean): InsDefferedEvent; reintroduce;
 end;//TnsDocumentPrintEvent
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

// start class TnsDocumentPrintEvent

constructor TnsDocumentPrintEvent.Create(const aDoc: IDocument;
  aSelection: Boolean);
//#UC START# *4B0FB62D03D7_4B0FB5DC03BD_var*
//#UC END# *4B0FB62D03D7_4B0FB5DC03BD_var*
begin
//#UC START# *4B0FB62D03D7_4B0FB5DC03BD_impl*
 inherited Create;
 f_Doc := aDoc;
 f_Selection := aSelection;
//#UC END# *4B0FB62D03D7_4B0FB5DC03BD_impl*
end;//TnsDocumentPrintEvent.Create

class function TnsDocumentPrintEvent.Make(const aDoc: IDocument;
  aSelection: Boolean): InsDefferedEvent;
var
 l_Inst : TnsDocumentPrintEvent;
begin
 l_Inst := Create(aDoc, aSelection);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsDocumentPrintEvent.FireLog;
//#UC START# *4B0FA5CB0254_4B0FB5DC03BD_var*
var
 l_Data: InsLogEventData;
const
 cMap: array [Boolean] of Cardinal = (0, 1); 
//#UC END# *4B0FA5CB0254_4B0FB5DC03BD_var*
begin
//#UC START# *4B0FA5CB0254_4B0FB5DC03BD_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(f_Doc);
 l_Data.AddULong(cMap[f_Selection]);
 GetLogger.AddEvent(LE_DOCUMENT_PRINT, l_Data);
//#UC END# *4B0FA5CB0254_4B0FB5DC03BD_impl*
end;//TnsDocumentPrintEvent.FireLog

procedure TnsDocumentPrintEvent.Cleanup;
//#UC START# *479731C50290_4B0FB5DC03BD_var*
//#UC END# *479731C50290_4B0FB5DC03BD_var*
begin
//#UC START# *479731C50290_4B0FB5DC03BD_impl*
 f_Doc := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4B0FB5DC03BD_impl*
end;//TnsDocumentPrintEvent.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.