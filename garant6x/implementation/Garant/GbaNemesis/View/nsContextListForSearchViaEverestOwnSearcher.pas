unit nsContextListForSearchViaEverestOwnSearcher;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsContextListForSearchViaEverestOwnSearcher.pas"
// Начат: 23.03.2011 19:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::ContextSearchInEVDDocument::TnsContextListForSearchViaEverestOwnSearcher
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
  nevBase,
  nevRangeList,
  l3ProtoObjectForTie
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
//#UC START# *4D8A1D6700A0ci*
//#UC END# *4D8A1D6700A0ci*
//#UC START# *4D8A1D6700A0cit*
//#UC END# *4D8A1D6700A0cit*
 TnsContextListForSearchViaEverestOwnSearcher = class(Tl3ProtoObjectForTie, IContextList)
 private
 // private fields
   f_List : TnevRangeList;
   f_Doc : InevObjectPrim;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aDoc: InevObjectPrim;
     aList: TnevRangeList); reintroduce;
   class function Make(const aDoc: InevObjectPrim;
     aList: TnevRangeList): IContextList; reintroduce;
     {* Сигнатура фабрики TnsContextListForSearchViaEverestOwnSearcher.Make }
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  SysUtils,
  nsFragmentListForSearchViaEverestOwnSearcher
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsContextListForSearchViaEverestOwnSearcher

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
end;

procedure TnsContextListForSearchViaEverestOwnSearcher.Cleanup;
//#UC START# *479731C50290_4D8A1D6700A0_var*
//#UC END# *479731C50290_4D8A1D6700A0_var*
begin
//#UC START# *479731C50290_4D8A1D6700A0_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_4D8A1D6700A0_impl*
end;//TnsContextListForSearchViaEverestOwnSearcher.Cleanup

procedure TnsContextListForSearchViaEverestOwnSearcher.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Doc := nil;
 {$IfEnd} //not Admin AND not Monitorings
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

{$IfEnd} //not Admin AND not Monitorings

end.