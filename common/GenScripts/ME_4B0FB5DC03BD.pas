unit nsDocumentPrintEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentPrintEvent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentPrintEvent" MUID: (4B0FB5DC03BD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsLogEvent
 , LoggingInterfaces
 , DocumentUnit
;

type
 TnsDocumentPrintEvent = class(TnsLogEvent, InsDefferedEvent)
  private
   f_Doc: IDocument;
   f_Selection: Boolean;
  protected
   procedure FireLog;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDoc: IDocument;
    aSelection: Boolean); reintroduce;
   class function Make(const aDoc: IDocument;
    aSelection: Boolean): InsDefferedEvent; reintroduce;
 end;//TnsDocumentPrintEvent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , LoggingUnit
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
;

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
end;//TnsDocumentPrintEvent.Make

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B0FB5DC03BD_var*
//#UC END# *479731C50290_4B0FB5DC03BD_var*
begin
//#UC START# *479731C50290_4B0FB5DC03BD_impl*
 f_Doc := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4B0FB5DC03BD_impl*
end;//TnsDocumentPrintEvent.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
