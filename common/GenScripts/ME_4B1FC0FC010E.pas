unit nsIDocumentDataObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsIDocumentDataObject.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evHolderDataObject
 , DocumentUnit
 , nevTools
 , nevBase
 , evdInterfaces
;

type
 TnsIDocumentDataObject = class(TevHolderDataObject)
  private
   f_Document: IDocument;
  protected
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
    {* сохраняет поток в G }
   procedure ClearFields; override;
  public
   constructor Create(const aData: IDocument); reintroduce;
   class function Make(const aData: IDocument): InevStorable; reintroduce;
 end;//TnsIDocumentDataObject
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDocumentToolsNew
;

constructor TnsIDocumentDataObject.Create(const aData: IDocument);
//#UC START# *4D3ED5BF0202_4B1FC0FC010E_var*
//#UC END# *4D3ED5BF0202_4B1FC0FC010E_var*
begin
//#UC START# *4D3ED5BF0202_4B1FC0FC010E_impl*
 inherited Create(nil);
 f_Document := aData;
//#UC END# *4D3ED5BF0202_4B1FC0FC010E_impl*
end;//TnsIDocumentDataObject.Create

class function TnsIDocumentDataObject.Make(const aData: IDocument): InevStorable;
var
 l_Inst : TnsIDocumentDataObject;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsIDocumentDataObject.Make

procedure TnsIDocumentDataObject.DoStore(const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
 {* сохраняет поток в G }
//#UC START# *48EA34990191_4B1FC0FC010E_var*
//#UC END# *48EA34990191_4B1FC0FC010E_var*
begin
//#UC START# *48EA34990191_4B1FC0FC010E_impl*
 nsGetText(f_Document, f_Holder);
 try
  inherited;
 finally
  f_Holder := nil;
 end;//try..finally
//#UC END# *48EA34990191_4B1FC0FC010E_impl*
end;//TnsIDocumentDataObject.DoStore

procedure TnsIDocumentDataObject.ClearFields;
begin
 f_Document := nil;
 inherited;
end;//TnsIDocumentDataObject.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
