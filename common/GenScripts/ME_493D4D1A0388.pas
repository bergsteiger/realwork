unit deDocumentListCR;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\deDocumentListCR.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , deDocumentList
 , PrimListInterfaces
 , bsTypes
 , DynamicTreeUnit
 , DynamicDocListUnit
;

type
 TdeDocumentListCR = class(TdeDocumentList, IdeDocumentListCR)
  private
   fType: TlstCRType;
   fCategory: INodeBase;
  protected
   function pm_GetListType: TlstCRType;
   function pm_GetCategory: INodeBase;
   procedure AssignClonned(aClone: TdeDocumentList); override;
   procedure ClearFields; override;
  public
   constructor Create(const aList: IDynList;
    const aCategory: INodeBase;
    aType: TlstCRType); reintroduce;
   class function Make(const aList: IDynList;
    const aCategory: INodeBase;
    aType: TlstCRType): IdeDocumentListCR; reintroduce;
 end;//TdeDocumentListCR
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

constructor TdeDocumentListCR.Create(const aList: IDynList;
 const aCategory: INodeBase;
 aType: TlstCRType);
//#UC START# *4B1F7BB10212_493D4D1A0388_var*
//#UC END# *4B1F7BB10212_493D4D1A0388_var*
begin
//#UC START# *4B1F7BB10212_493D4D1A0388_impl*
 inherited Create(aList, lofNone, true, wdAlwaysOpen, nil, nil, False, True);
 fCategory := aCategory;
 fType := aType;
//#UC END# *4B1F7BB10212_493D4D1A0388_impl*
end;//TdeDocumentListCR.Create

class function TdeDocumentListCR.Make(const aList: IDynList;
 const aCategory: INodeBase;
 aType: TlstCRType): IdeDocumentListCR;
var
 l_Inst : TdeDocumentListCR;
begin
 l_Inst := Create(aList, aCategory, aType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeDocumentListCR.Make

function TdeDocumentListCR.pm_GetListType: TlstCRType;
//#UC START# *4B1D1100018E_493D4D1A0388get_var*
//#UC END# *4B1D1100018E_493D4D1A0388get_var*
begin
//#UC START# *4B1D1100018E_493D4D1A0388get_impl*
 Result := fType;
//#UC END# *4B1D1100018E_493D4D1A0388get_impl*
end;//TdeDocumentListCR.pm_GetListType

function TdeDocumentListCR.pm_GetCategory: INodeBase;
//#UC START# *4B1D1135025F_493D4D1A0388get_var*
//#UC END# *4B1D1135025F_493D4D1A0388get_var*
begin
//#UC START# *4B1D1135025F_493D4D1A0388get_impl*
 Result := fCategory;
//#UC END# *4B1D1135025F_493D4D1A0388get_impl*
end;//TdeDocumentListCR.pm_GetCategory

procedure TdeDocumentListCR.AssignClonned(aClone: TdeDocumentList);
//#UC START# *4B1F7AE80158_493D4D1A0388_var*
//#UC END# *4B1F7AE80158_493D4D1A0388_var*
begin
//#UC START# *4B1F7AE80158_493D4D1A0388_impl*
 inherited;
 if aClone is TdeDocumentListCR then
 begin
  fType := TdeDocumentListCR(aClone).fType;
  fCategory := TdeDocumentListCR(aClone).fCategory;
 end;
//#UC END# *4B1F7AE80158_493D4D1A0388_impl*
end;//TdeDocumentListCR.AssignClonned

procedure TdeDocumentListCR.ClearFields;
begin
 fCategory := nil;
 inherited;
end;//TdeDocumentListCR.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
