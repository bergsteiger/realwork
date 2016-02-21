unit nsFragmentListForSearchViaEverestOwnSearcher;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsFragmentListForSearchViaEverestOwnSearcher.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObjectForTie
 , DocumentUnit
 , nevTools
 , nevBase
;

type
 //#UC START# *4D8A35D7008Bci*
 //#UC END# *4D8A35D7008Bci*
 //#UC START# *4D8A35D7008Bcit*
 //#UC END# *4D8A35D7008Bcit*
 TnsFragmentListForSearchViaEverestOwnSearcher = class(Tl3ProtoObjectForTie, IFragmentList)
  private
   f_Range: InevRange;
   f_Doc: InevObjectPrim;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aDoc: InevObjectPrim;
    const aRange: InevRange); reintroduce;
   class function Make(const aDoc: InevObjectPrim;
    const aRange: InevRange): IFragmentList; reintroduce;
 //#UC START# *4D8A35D7008Bpubl*
 private
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    procedure  pm_GetItem(anIndex: Integer; out aRet: TContext); stdcall;
    procedure pm_SetItem(anIndex: Integer; const anItem: TContext); stdcall;
      {-}
    function  Add(const anItem: TContext): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TContext); stdcall;
      {* - вставляет элемент Item по индексу Index. }
 //#UC END# *4D8A35D7008Bpubl*
 end;//TnsFragmentListForSearchViaEverestOwnSearcher
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
;

constructor TnsFragmentListForSearchViaEverestOwnSearcher.Create(const aDoc: InevObjectPrim;
 const aRange: InevRange);
//#UC START# *4D8A369602D6_4D8A35D7008B_var*
//#UC END# *4D8A369602D6_4D8A35D7008B_var*
begin
//#UC START# *4D8A369602D6_4D8A35D7008B_impl*
 inherited Create;
 f_Doc := aDoc;
 f_Range := aRange;
//#UC END# *4D8A369602D6_4D8A35D7008B_impl*
end;//TnsFragmentListForSearchViaEverestOwnSearcher.Create

class function TnsFragmentListForSearchViaEverestOwnSearcher.Make(const aDoc: InevObjectPrim;
 const aRange: InevRange): IFragmentList;
var
 l_Inst : TnsFragmentListForSearchViaEverestOwnSearcher;
begin
 l_Inst := Create(aDoc, aRange);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFragmentListForSearchViaEverestOwnSearcher.Make

procedure TnsFragmentListForSearchViaEverestOwnSearcher.ClearFields;
begin
 f_Range := nil;
 f_Doc := nil;
 inherited;
end;//TnsFragmentListForSearchViaEverestOwnSearcher.ClearFields

//#UC START# *4D8A35D7008Bimpl*
function TnsFragmentListForSearchViaEverestOwnSearcher.pm_GetCount: Integer;
begin
 Result := 1;
end;

procedure TnsFragmentListForSearchViaEverestOwnSearcher.pm_SetCount(aValue: Integer);
begin
 Assert(false);
end;

procedure TnsFragmentListForSearchViaEverestOwnSearcher.Clear;
begin
 Assert(false);
end;

procedure TnsFragmentListForSearchViaEverestOwnSearcher.Delete(anIndex: Integer);
begin
 Assert(false);
end;

procedure TnsFragmentListForSearchViaEverestOwnSearcher.pm_GetItem(anIndex: Integer; out aRet: TContext);
var
 l_S  : InevBasePoint;
 l_F  : InevBasePoint;
 l_Si : InevBasePoint;
 l_Fi : InevBasePoint;
begin
 Assert(anIndex = 0);
 f_Range.GetBorderPoints(l_S, l_F);
(* l_S := l_S.PointToParentByLevel(MaxInt);
 l_F := l_F.PointToParentByLevel(MaxInt);*)
 l_S := l_S.PointToParent(f_Doc);
 l_F := l_F.PointToParent(f_Doc);
 Assert(l_S <> nil);
 Assert(l_F <> nil);
 l_Si := l_S.MostInner;
 l_Fi := l_F.MostInner;
 Assert(l_Si.Obj.AsObject.IsSame(l_Fi.Obj^.AsObject));
 aRet.rStart := l_Si.Position;
 aRet.rFinish := l_Fi.Position;
 aRet.rPath := DefDataAdapter.NativeAdapter.MakeNodeIndexPath;
 while (l_S <> nil) AND (l_S <> l_Si) do
 begin
  Assert(l_S.Position > 0);
  aRet.rPath.Add(l_S.Position - 1);
  l_S := l_S.Inner;
 end;//while (l_S <> nil)
end;

procedure TnsFragmentListForSearchViaEverestOwnSearcher.pm_SetItem(anIndex: Integer; const anItem: TContext);
begin
 Assert(false);
end;

function TnsFragmentListForSearchViaEverestOwnSearcher.Add(const anItem: TContext): Integer;
begin
 Result := -1;
 Assert(false);
end;

procedure TnsFragmentListForSearchViaEverestOwnSearcher.Insert(anIndex: Integer; const anItem: TContext);
begin
 Assert(false);
end;

//#UC END# *4D8A35D7008Bimpl*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
