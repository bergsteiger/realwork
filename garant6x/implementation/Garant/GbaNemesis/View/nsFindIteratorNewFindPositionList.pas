unit nsFindIteratorNewFindPositionList;
 {* Фасадная реализация IFindPositionList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindIteratorNewFindPositionList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFindIteratorNewFindPositionList" MUID: (4D18F1F2033A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObjectForTie
 , DynamicTreeUnit
 , DocumentUnit
 //#UC START# *4D18F1F2033Aintf_uses*
 //#UC END# *4D18F1F2033Aintf_uses*
;

type
 //#UC START# *4D18F1F2033Aci*
 //#UC END# *4D18F1F2033Aci*
 //#UC START# *4D18F1F2033Acit*
 //#UC END# *4D18F1F2033Acit*
 TnsFindIteratorNewFindPositionList = class(Tl3ProtoObjectForTie, IFindPositionList)
  {* Фасадная реализация IFindPositionList }
  private
   f_GotList: IFragmentList;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aGotList: IFragmentList); reintroduce;
   class function Make(const aGotList: IFragmentList): IFindPositionList; reintroduce;
 //#UC START# *4D18F1F2033Apubl*
 private
   // IFindPositionList
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    procedure  pm_GetItem(anIndex: Integer; out aRet: TFindPosition); stdcall;
      {-}
    procedure pm_SetItem(anIndex: Integer; const anItem: TFindPosition); stdcall;
      {-}
    function  Add(const anItem: TFindPosition): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TFindPosition); stdcall;
      {* - вставляет элемент Item по индексу Index. }
 //#UC END# *4D18F1F2033Apubl*
 end;//TnsFindIteratorNewFindPositionList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4D18F1F2033Aimpl_uses*
 //#UC END# *4D18F1F2033Aimpl_uses*
;

constructor TnsFindIteratorNewFindPositionList.Create(const aGotList: IFragmentList);
//#UC START# *4D18F2830080_4D18F1F2033A_var*
//#UC END# *4D18F2830080_4D18F1F2033A_var*
begin
//#UC START# *4D18F2830080_4D18F1F2033A_impl*
 inherited Create;
 f_GotList := aGotList;
//#UC END# *4D18F2830080_4D18F1F2033A_impl*
end;//TnsFindIteratorNewFindPositionList.Create

class function TnsFindIteratorNewFindPositionList.Make(const aGotList: IFragmentList): IFindPositionList;
var
 l_Inst : TnsFindIteratorNewFindPositionList;
begin
 l_Inst := Create(aGotList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFindIteratorNewFindPositionList.Make

procedure TnsFindIteratorNewFindPositionList.ClearFields;
begin
 Finalize(f_GotList);
 inherited;
end;//TnsFindIteratorNewFindPositionList.ClearFields

//#UC START# *4D18F1F2033Aimpl*
function  TnsFindIteratorNewFindPositionList.pm_GetCount: Integer;
begin
 Assert(f_GotList <> nil);
 Result := f_GotList.Count;
end;

procedure TnsFindIteratorNewFindPositionList.pm_SetCount(aValue: Integer);
begin
 Assert(false);
end;

procedure TnsFindIteratorNewFindPositionList.Clear;
begin
 Assert(false);
end;

procedure TnsFindIteratorNewFindPositionList.Delete(anIndex: Integer);
begin
 Assert(false);
end;

procedure TnsFindIteratorNewFindPositionList.pm_GetItem(anIndex: Integer; out aRet: TFindPosition);
var
 l_E : TContext;
begin
 Assert(f_GotList <> nil);
 Assert((anIndex >= 0) AND (anIndex < pm_GetCount));
 f_GotList.pm_GetItem(anIndex, l_E);
 aRet.rNode := l_E.rPath;
 aRet.rBegin := l_E.rStart;
 aRet.rEnd := l_E.rFinish;
end;

procedure TnsFindIteratorNewFindPositionList.pm_SetItem(anIndex: Integer; const anItem: TFindPosition);
begin
 Assert(false);
end;

function TnsFindIteratorNewFindPositionList.Add(const anItem: TFindPosition): Integer;
begin
 Assert(false);
 Result := -1;
end;

procedure TnsFindIteratorNewFindPositionList.Insert(anIndex: Integer; const anItem: TFindPosition);
begin
 Assert(false);
end;
//#UC END# *4D18F1F2033Aimpl*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
