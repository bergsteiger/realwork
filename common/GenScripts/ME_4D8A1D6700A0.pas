unit nsContextListForSearchViaEverestOwnSearcher;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsContextListForSearchViaEverestOwnSearcher.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsContextListForSearchViaEverestOwnSearcher" MUID: (4D8A1D6700A0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObjectForTie
 , DocumentUnit
 , nevRangeList
 , nevBase
 //#UC START# *4D8A1D6700A0intf_uses*
 //#UC END# *4D8A1D6700A0intf_uses*
;

type
 //#UC START# *4D8A1D6700A0ci*
 //#UC END# *4D8A1D6700A0ci*
 //#UC START# *4D8A1D6700A0cit*
 //#UC END# *4D8A1D6700A0cit*
 TnsContextListForSearchViaEverestOwnSearcher = class(Tl3ProtoObjectForTie, IContextList)
  private
   f_List: TnevRangeList;
   f_Doc: InevObjectPrim;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aDoc: InevObjectPrim;
    aList: TnevRangeList); reintroduce;
   class function Make(const aDoc: InevObjectPrim;
    aList: TnevRangeList): IContextList; reintroduce;
 //#UC START# *4D8A1D6700A0publ*
 private
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    procedure  pm_GetItem(anIndex: Integer; out aRet: IFragmentList); stdcall;
    procedure pm_SetItem(anIndex: Integer; const anItem: IFragmentList); stdcall;
      {-}
    function  Add(const anItem: IFragmentList): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IFragmentList); stdcall;
      {* - вставляет элемент Item по индексу Index. }
 //#UC END# *4D8A1D6700A0publ*
 end;//TnsContextListForSearchViaEverestOwnSearcher
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , nsFragmentListForSearchViaEverestOwnSearcher
 , l3Base
 //#UC START# *4D8A1D6700A0impl_uses*
 //#UC END# *4D8A1D6700A0impl_uses*
;

constructor TnsContextListForSearchViaEverestOwnSearcher.Create(const aDoc: InevObjectPrim;
 aList: TnevRangeList);
//#UC START# *4D8A33A50117_4D8A1D6700A0_var*
//#UC END# *4D8A33A50117_4D8A1D6700A0_var*
begin
//#UC START# *4D8A33A50117_4D8A1D6700A0_impl*
 inherited Create;
 f_Doc := aDoc;
 l3Set(f_List, aList);
//#UC END# *4D8A33A50117_4D8A1D6700A0_impl*
end;//TnsContextListForSearchViaEverestOwnSearcher.Create

class function TnsContextListForSearchViaEverestOwnSearcher.Make(const aDoc: InevObjectPrim;
 aList: TnevRangeList): IContextList;
var
 l_Inst : TnsContextListForSearchViaEverestOwnSearcher;
begin
 l_Inst := Create(aDoc, aList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsContextListForSearchViaEverestOwnSearcher.Make

procedure TnsContextListForSearchViaEverestOwnSearcher.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4D8A1D6700A0_var*
//#UC END# *479731C50290_4D8A1D6700A0_var*
begin
//#UC START# *479731C50290_4D8A1D6700A0_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_4D8A1D6700A0_impl*
end;//TnsContextListForSearchViaEverestOwnSearcher.Cleanup

procedure TnsContextListForSearchViaEverestOwnSearcher.ClearFields;
begin
 f_Doc := nil;
 inherited;
end;//TnsContextListForSearchViaEverestOwnSearcher.ClearFields

//#UC START# *4D8A1D6700A0impl*
function TnsContextListForSearchViaEverestOwnSearcher.pm_GetCount: Integer;
begin
 Result := f_List.Count;
end;

procedure TnsContextListForSearchViaEverestOwnSearcher.pm_SetCount(aValue: Integer);
begin
 Assert(false);
end;

procedure TnsContextListForSearchViaEverestOwnSearcher.Clear;
begin
 Assert(false);
end;

procedure TnsContextListForSearchViaEverestOwnSearcher.Delete(anIndex: Integer);
begin
 Assert(false);
end;

procedure TnsContextListForSearchViaEverestOwnSearcher.pm_GetItem(anIndex: Integer; out aRet: IFragmentList);
begin
 aRet := TnsFragmentListForSearchViaEverestOwnSearcher.Make(f_Doc, f_List[anIndex]);
end;

procedure TnsContextListForSearchViaEverestOwnSearcher.pm_SetItem(anIndex: Integer; const anItem: IFragmentList);
begin
 Assert(false);
end;

function TnsContextListForSearchViaEverestOwnSearcher.Add(const anItem: IFragmentList): Integer;
begin
 Result := -1;
 Assert(false);
end;

procedure TnsContextListForSearchViaEverestOwnSearcher.Insert(anIndex: Integer; const anItem: IFragmentList);
begin
 Assert(false);
end;

//#UC END# *4D8A1D6700A0impl*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
