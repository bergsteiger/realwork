unit NOT_COMPLETED_nsDocumentMainMenuNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\NOT_COMPLETED_nsDocumentMainMenuNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentMainMenuNode" MUID: (4ADDF4FA01C8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsMainMenuNode
 , MainMenuDomainInterfaces
 , DocumentUnit
 , l3Tree_TLB
;

type
 TnsDocumentMainMenuNode = class(TnsMainMenuNode, InsDocumentNode)
  private
   f_Document: IDocument;
  protected
   function pm_GetData: IDocument;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aType: Integer;
    const aDocument: IDocument); reintroduce;
   class function Make(aType: Integer;
    const aDocument: IDocument): Il3Node; reintroduce;
 end;//TnsDocumentMainMenuNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDocumentTools
;

constructor TnsDocumentMainMenuNode.Create(aType: Integer;
 const aDocument: IDocument);
//#UC START# *4ADF118F03DB_4ADDF4FA01C8_var*
//#UC END# *4ADF118F03DB_4ADDF4FA01C8_var*
begin
//#UC START# *4ADF118F03DB_4ADDF4FA01C8_impl*
 inherited Create(aType, nsGetDocumentShortName(aDocument), nil);
 f_Document := aDocument;
//#UC END# *4ADF118F03DB_4ADDF4FA01C8_impl*
end;//TnsDocumentMainMenuNode.Create

class function TnsDocumentMainMenuNode.Make(aType: Integer;
 const aDocument: IDocument): Il3Node;
var
 l_Inst : TnsDocumentMainMenuNode;
begin
 l_Inst := Create(aType, aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocumentMainMenuNode.Make

function TnsDocumentMainMenuNode.pm_GetData: IDocument;
//#UC START# *49904BAA013F_4ADDF4FA01C8get_var*
//#UC END# *49904BAA013F_4ADDF4FA01C8get_var*
begin
//#UC START# *49904BAA013F_4ADDF4FA01C8get_impl*
 Result := f_Document;
//#UC END# *49904BAA013F_4ADDF4FA01C8get_impl*
end;//TnsDocumentMainMenuNode.pm_GetData

procedure TnsDocumentMainMenuNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADDF4FA01C8_var*
//#UC END# *479731C50290_4ADDF4FA01C8_var*
begin
//#UC START# *479731C50290_4ADDF4FA01C8_impl*
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_4ADDF4FA01C8_impl*
end;//TnsDocumentMainMenuNode.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
