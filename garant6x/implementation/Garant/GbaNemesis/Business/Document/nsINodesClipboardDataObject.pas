unit nsINodesClipboardDataObject;
 {* Объект данных со скопированными узлами списка. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsINodesClipboardDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsINodesClipboardDataObject" MUID: (47F230A0012C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evEvdDataObject
 , DynamicTreeUnit
 , nevTools
 , nevBase
 , evdInterfaces
;

type
 TnsINodesClipboardDataObject = class(TevEvdDataObject)
  {* Объект данных со скопированными узлами списка. }
  private
   f_Document: INodesClipboard;
   f_OnlyFirstLevel: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
    {* сохраняет поток в G }
  public
   constructor Create(const aData: INodesClipboard;
    aOnlyFirstLevel: Boolean); reintroduce;
   class function Make(const aData: INodesClipboard;
    aOnlyFirstLevel: Boolean = False): InevStorable; reintroduce;
 end;//TnsINodesClipboardDataObject
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , bsConvert
 //#UC START# *47F230A0012Cimpl_uses*
 //#UC END# *47F230A0012Cimpl_uses*
;

constructor TnsINodesClipboardDataObject.Create(const aData: INodesClipboard;
 aOnlyFirstLevel: Boolean);
//#UC START# *48F87FE50381_47F230A0012C_var*
//#UC END# *48F87FE50381_47F230A0012C_var*
begin
//#UC START# *48F87FE50381_47F230A0012C_impl*
 inherited Create(nil);
 f_Document := aData;
 f_OnlyFirstLevel := aOnlyFirstLevel;
//#UC END# *48F87FE50381_47F230A0012C_impl*
end;//TnsINodesClipboardDataObject.Create

class function TnsINodesClipboardDataObject.Make(const aData: INodesClipboard;
 aOnlyFirstLevel: Boolean = False): InevStorable;
var
 l_Inst : TnsINodesClipboardDataObject;
begin
 l_Inst := Create(aData, aOnlyFirstLevel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsINodesClipboardDataObject.Make

procedure TnsINodesClipboardDataObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47F230A0012C_var*
//#UC END# *479731C50290_47F230A0012C_var*
begin
//#UC START# *479731C50290_47F230A0012C_impl*
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_47F230A0012C_impl*
end;//TnsINodesClipboardDataObject.Cleanup

procedure TnsINodesClipboardDataObject.DoStore(const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
 {* сохраняет поток в G }
//#UC START# *48EA34990191_47F230A0012C_var*
//#UC END# *48EA34990191_47F230A0012C_var*
begin
//#UC START# *48EA34990191_47F230A0012C_impl*
 f_Document.AsEvd(bsBusinessToAdapter(f_OnlyFirstLevel), f_Stream);
 try
  inherited;
 finally
  f_Stream := nil;
 end;//try..finally
//#UC END# *48EA34990191_47F230A0012C_impl*
end;//TnsINodesClipboardDataObject.DoStore
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
