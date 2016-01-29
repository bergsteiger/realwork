unit nsDocumentStreamWrapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsDocumentStreamWrapper.pas"
// Начат: 2007/03/05 10:50:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::Document::TnsDocumentStreamWrapper
//
// Обертка работы с потоком для узла адаптера
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
  l3SimpleObject,
  bsInterfaces,
  l3Interfaces,
  nevTools
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDocumentStreamWrapper = class(Tl3SimpleObject, IbsDocumentStreamWrapper)
  {* Обертка работы с потоком для узла адаптера }
 private
 // private fields
   f_Document : IDocument;
 protected
 // realized methods
   function pm_GetInternalNumber: Il3CString;
   function pm_GetEVDStream: InevObjectHolder;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aDocument: IDocument); reintroduce;
   class function Make(const aDocument: IDocument): IbsDocumentStreamWrapper; reintroduce;
     {* Фабричный метод }
 end;//TnsDocumentStreamWrapper
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsDocumentTools
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsDocumentToolsNew
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDocumentStreamWrapper

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
var
 l_Inst : TnsDocumentStreamWrapper;
begin
 if (aDocument = nil) then
 begin
  Result := nil;
  Exit;
 end;//aDocument = nil
 l_Inst := Create(aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

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
//#UC START# *479731C50290_47F9D43A03A7_var*
//#UC END# *479731C50290_47F9D43A03A7_var*
begin
//#UC START# *479731C50290_47F9D43A03A7_impl*
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_47F9D43A03A7_impl*
end;//TnsDocumentStreamWrapper.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.