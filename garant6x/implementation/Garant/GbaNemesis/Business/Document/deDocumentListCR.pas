unit deDocumentListCR;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/deDocumentListCR.pas"
// Начат: 09.12.2009 14:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::BaseDocument::TdeDocumentListCR
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
  DynamicDocListUnit,
  DynamicTreeUnit,
  bsTypes,
  deDocumentList,
  PrimListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeDocumentListCR = class(TdeDocumentList, IdeDocumentListCR)
 private
 // private fields
   fType : TlstCRType;
   fCategory : INodeBase;
 protected
 // realized methods
   function pm_GetListType: TlstCRType;
   function pm_GetCategory: INodeBase;
 protected
 // overridden protected methods
   procedure AssignClonned(aClone: TdeDocumentList); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aList: IDynList;
     const aCategory: INodeBase;
     aType: TlstCRType); reintroduce;
   class function Make(const aList: IDynList;
     const aCategory: INodeBase;
     aType: TlstCRType): IdeDocumentListCR; reintroduce;
 end;//TdeDocumentListCR
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeDocumentListCR

constructor TdeDocumentListCR.Create(const aList: IDynList;
  const aCategory: INodeBase;
  aType: TlstCRType);
//#UC START# *4B1F7BB10212_493D4D1A0388_var*
//#UC END# *4B1F7BB10212_493D4D1A0388_var*
begin
//#UC START# *4B1F7BB10212_493D4D1A0388_impl*
 inherited Create(aList, lofNone, true, wdAlwaysOpen, nil, nil, False, True, False);
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
end;

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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 fCategory := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdeDocumentListCR.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.