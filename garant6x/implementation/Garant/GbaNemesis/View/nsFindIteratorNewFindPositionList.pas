unit nsFindIteratorNewFindPositionList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsFindIteratorNewFindPositionList.pas"
// Начат: 27.10.2010 23:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::ContextSearchInEVDDocument::TnsFindIteratorNewFindPositionList
//
// Фасадная реализация IFindPositionList
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
  DocumentUnit,
  DynamicTreeUnit,
  l3ProtoObjectForTie
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
//#UC START# *4D18F1F2033Aci*
//#UC END# *4D18F1F2033Aci*
//#UC START# *4D18F1F2033Acit*
//#UC END# *4D18F1F2033Acit*
 TnsFindIteratorNewFindPositionList = class(Tl3ProtoObjectForTie, IFindPositionList)
  {* Фасадная реализация IFindPositionList }
 private
 // private fields
   f_GotList : IFragmentList;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aGotList: IFragmentList); reintroduce;
   class function Make(const aGotList: IFragmentList): IFindPositionList; reintroduce;
     {* Сигнатура фабрики TnsFindIteratorNewFindPositionList.Make }
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsFindIteratorNewFindPositionList

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
end;

procedure TnsFindIteratorNewFindPositionList.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_GotList := nil;
 {$IfEnd} //not Admin AND not Monitorings
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

{$IfEnd} //not Admin AND not Monitorings

end.