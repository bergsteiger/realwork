unit nsDocumentStreamWrapper;
 {* Обертка работы с потоком для узла адаптера }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentStreamWrapper.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , bsInterfaces
 , DocumentUnit
 , l3Interfaces
 , nevTools
;

type
 TnsDocumentStreamWrapper = class(Tl3SimpleObject, IbsDocumentStreamWrapper)
  {* Обертка работы с потоком для узла адаптера }
  private
   f_Document: IDocument;
  protected
   function pm_GetInternalNumber: Il3CString;
   function pm_GetEVDStream: InevObjectHolder;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDocument: IDocument); reintroduce;
   class function Make(const aDocument: IDocument): IbsDocumentStreamWrapper; reintroduce;
    {* Фабричный метод }
 end;//TnsDocumentStreamWrapper
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsDocumentTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsDocumentToolsNew
;

constructor TnsDocumentStreamWrapper.Create(const aDocument: IDocument);
//#UC START# *4953865E0377_47F9D43A03A7_var*
//#UC END# *4953865E0377_47F9D43A03A7_var*
begin
//#UC START# *4953865E0377_47F9D43A03A7_impl*
 inherited Create;
 f_Document := aDocument;
//#UC END# *4953865E0377_47F9D43A03A7_impl*
end;//TnsDocumentStreamWrapper.Create

class function TnsDocumentStreamWrapper.Make(const aDocument: IDocument): IbsDocumentStreamWrapper;
 {* Фабричный метод }
var
 l_Inst : TnsDocumentStreamWrapper;
begin
 l_Inst := Create(aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocumentStreamWrapper.Make

function TnsDocumentStreamWrapper.pm_GetInternalNumber: Il3CString;
//#UC START# *495276050302_47F9D43A03A7get_var*
//#UC END# *495276050302_47F9D43A03A7get_var*
begin
//#UC START# *495276050302_47F9D43A03A7get_impl*
 Result := vcmFmt(str_TopicHeader, [f_Document.GetInternalId]);
//#UC END# *495276050302_47F9D43A03A7get_impl*
end;//TnsDocumentStreamWrapper.pm_GetInternalNumber

function TnsDocumentStreamWrapper.pm_GetEVDStream: InevObjectHolder;
//#UC START# *49527634025F_47F9D43A03A7get_var*
//#UC END# *49527634025F_47F9D43A03A7get_var*
begin
//#UC START# *49527634025F_47F9D43A03A7get_impl*
 nsGetText(f_Document, Result);
//#UC END# *49527634025F_47F9D43A03A7get_impl*
end;//TnsDocumentStreamWrapper.pm_GetEVDStream

procedure TnsDocumentStreamWrapper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47F9D43A03A7_var*
//#UC END# *479731C50290_47F9D43A03A7_var*
begin
//#UC START# *479731C50290_47F9D43A03A7_impl*
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_47F9D43A03A7_impl*
end;//TnsDocumentStreamWrapper.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
