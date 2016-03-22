unit nsIListDataObject;
 {* - }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsIListDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsIListDataObject" MUID: (47F23C2A0219)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evEvdDataObject
 , DynamicDocListUnit
 , nevTools
 , nevBase
 , evdInterfaces
;

type
 TnsIListDataObject = class(TevEvdDataObject)
  {* - }
  private
   f_Document: IDynList;
   f_OnlyFirstLevel: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
    {* сохраняет поток в G }
  public
   constructor Create(const aData: IDynList;
    aOnlyFirstLevel: Boolean); reintroduce;
   class function Make(const aData: IDynList;
    aOnlyFirstLevel: Boolean = False): InevStorable; reintroduce;
 end;//TnsIListDataObject
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , bsConvert
;

constructor TnsIListDataObject.Create(const aData: IDynList;
 aOnlyFirstLevel: Boolean);
//#UC START# *48F885150025_47F23C2A0219_var*
//#UC END# *48F885150025_47F23C2A0219_var*
begin
//#UC START# *48F885150025_47F23C2A0219_impl*
 inherited Create(nil);
 f_Document := aData;
 f_OnlyFirstLevel := aOnlyFirstLevel;
//#UC END# *48F885150025_47F23C2A0219_impl*
end;//TnsIListDataObject.Create

class function TnsIListDataObject.Make(const aData: IDynList;
 aOnlyFirstLevel: Boolean = False): InevStorable;
var
 l_Inst : TnsIListDataObject;
begin
 l_Inst := Create(aData, aOnlyFirstLevel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsIListDataObject.Make

procedure TnsIListDataObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47F23C2A0219_var*
//#UC END# *479731C50290_47F23C2A0219_var*
begin
//#UC START# *479731C50290_47F23C2A0219_impl*
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_47F23C2A0219_impl*
end;//TnsIListDataObject.Cleanup

procedure TnsIListDataObject.DoStore(const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
 {* сохраняет поток в G }
//#UC START# *48EA34990191_47F23C2A0219_var*
//#UC END# *48EA34990191_47F23C2A0219_var*
begin
//#UC START# *48EA34990191_47F23C2A0219_impl*
 f_Document.AsEvd(bsBusinessToAdapter(f_OnlyFirstLevel), f_Stream);
 try
  inherited;
 finally
  f_Stream := nil;
 end;//try..finally
//#UC END# *48EA34990191_47F23C2A0219_impl*
end;//TnsIListDataObject.DoStore
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
