unit nsContentsListForFiltering;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsContentsListForFiltering.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsContentsListForFiltering" MUID: (4D4011460346)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObjectForTie
 , DynamicTreeUnit
 , DocumentAndListInterfaces
 , IOUnit
;

type
 TnsContentsListForFiltering = class(Tl3ProtoObjectForTie, IListForFiltering)
  private
   f_Contents: IdsBaseContents;
   f_Type: TnsContentsListType;
  protected
   function item(index: Cardinal): IString;
   function Get_count: Cardinal;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(aType: TnsContentsListType;
    const aContents: IdsBaseContents); reintroduce;
   class function Make(aType: TnsContentsListType;
    const aContents: IdsBaseContents): IListForFiltering; reintroduce;
 end;//TnsContentsListForFiltering
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , DocumentUnit
 , l3Interfaces
 , nsTypes
;

constructor TnsContentsListForFiltering.Create(aType: TnsContentsListType;
 const aContents: IdsBaseContents);
//#UC START# *4D4011EF02C2_4D4011460346_var*
//#UC END# *4D4011EF02C2_4D4011460346_var*
begin
//#UC START# *4D4011EF02C2_4D4011460346_impl*
 inherited Create;
 f_Contents := aContents;
 f_Type := aType;
//#UC END# *4D4011EF02C2_4D4011460346_impl*
end;//TnsContentsListForFiltering.Create

class function TnsContentsListForFiltering.Make(aType: TnsContentsListType;
 const aContents: IdsBaseContents): IListForFiltering;
var
 l_Inst : TnsContentsListForFiltering;
begin
 l_Inst := Create(aType, aContents);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsContentsListForFiltering.Make

function TnsContentsListForFiltering.item(index: Cardinal): IString;
//#UC START# *4D3D26DC0123_4D4011460346_var*

 function DoGet: IString;
 begin
  Result := nsIStr(f_Contents.ContentsListItem[TnsContentsListIndex_C(f_Type, aIndex)]);
 end;

var
 l_I : Integer;
//#UC END# *4D3D26DC0123_4D4011460346_var*
begin
//#UC START# *4D3D26DC0123_4D4011460346_impl*
 if (f_Contents = nil) then
  IString(aRet) := nil
 else
 begin
  IString(aRet) := DoGet;
  //l_I := IString(aRet)._AddRef;
 end;//f_Contents = nil
//#UC END# *4D3D26DC0123_4D4011460346_impl*
end;//TnsContentsListForFiltering.item

function TnsContentsListForFiltering.Get_count: Cardinal;
//#UC START# *4D3D272402AE_4D4011460346get_var*
//#UC END# *4D3D272402AE_4D4011460346get_var*
begin
//#UC START# *4D3D272402AE_4D4011460346get_impl*
 if (f_Contents = nil) then
  Result := 0
 else
  Result := f_Contents.ContentsListCount[f_Type];
//#UC END# *4D3D272402AE_4D4011460346get_impl*
end;//TnsContentsListForFiltering.Get_count

{$If NOT Defined(DesignTimeLibrary)}
class function TnsContentsListForFiltering.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4D4011460346_var*
//#UC END# *47A6FEE600FC_4D4011460346_var*
begin
//#UC START# *47A6FEE600FC_4D4011460346_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4D4011460346_impl*
end;//TnsContentsListForFiltering.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TnsContentsListForFiltering.ClearFields;
begin
 f_Contents := nil;
 inherited;
end;//TnsContentsListForFiltering.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
