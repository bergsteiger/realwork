unit nsDataResetTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsDataResetTreeStruct.pas"
// Начат: 2005/11/22 18:54:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::TnsDataResetTreeStruct
//
// Дерево, которое умеет обновляться при смене данных
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DynamicTreeUnit,
  nsFilterableTreeStruct,
  nsTypes,
  afwInterfaces,
  l3TreeInterfaces
  ;

type
 _afwApplicationDataUpdate_Parent_ = TnsFilterableTreeStruct;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsDataResetTreeStruct = {abstract} class(_afwApplicationDataUpdate_)
  {* Дерево, которое умеет обновляться при смене данных }
 private
 // private fields
   f_InGetRoot : Boolean;
   f_BeenReseted : TnsResetTreeStatus;
    {* Поле для свойства BeenReseted}
 private
 // private methods
   procedure NotifyUpdated;
     {* уведомляет об обновлении данных дерева }
   procedure MakeResettedSimpleRoot;
 protected
 // overridden property methods
   function pm_GetRoot: Il3SimpleRootNode; override;
   procedure pm_SetRoot(const aValue: Il3SimpleRootNode); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   procedure ResetChildrenCountPrim; override;
   function DoMakeFiltered(const aFilters: Il3TreeFilters;
    const aCurrentNode: Il3SimpleNode;
    out aSyncIndex: Integer;
    aAutoOpen: Boolean;
    CalcPartialContext: Boolean): Il3SimpleTree; override;
 protected
 // protected methods
   function ReAqurieUnfilteredRootForMakeResettedSimpleRoot: INodeBase; virtual;
     {* ^^^ http://mdp.garant.ru/pages/viewpage.action?pageId=324570732&focusedCommentId=327818238#comment-327818238 }
   procedure BeforeReset; virtual;
   function ReAqurieUnfilteredRoot: INodeBase; virtual; abstract;
 protected
 // protected properties
   property BeenReseted: TnsResetTreeStatus
     read f_BeenReseted
     write f_BeenReseted;
 end;//TnsDataResetTreeStruct

implementation

uses
  bsInterfaces,
  SysUtils,
  BaseTypesUnit,
  l3Types,
  l3Base,
  afwFacade
  ;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TnsDataResetTreeStruct

function TnsDataResetTreeStruct.ReAqurieUnfilteredRootForMakeResettedSimpleRoot: INodeBase;
//#UC START# *4F1D334C0371_468361010204_var*
//#UC END# *4F1D334C0371_468361010204_var*
begin
//#UC START# *4F1D334C0371_468361010204_impl*
 Result := ReAqurieUnfilteredRoot;
//#UC END# *4F1D334C0371_468361010204_impl*
end;//TnsDataResetTreeStruct.ReAqurieUnfilteredRootForMakeResettedSimpleRoot

procedure TnsDataResetTreeStruct.BeforeReset;
//#UC START# *48FF64E700E5_468361010204_var*
//#UC END# *48FF64E700E5_468361010204_var*
begin
//#UC START# *48FF64E700E5_468361010204_impl*
 if f_Root <> nil then
  f_BeenReseted := rtsRoot
 else
  f_BeenReseted := rtsNone;
 Filters.SetContext(nil);  
 RequestClearAndTurnOff;
//#UC END# *48FF64E700E5_468361010204_impl*
end;//TnsDataResetTreeStruct.BeforeReset

procedure TnsDataResetTreeStruct.NotifyUpdated;
//#UC START# *48FF667E00CF_468361010204_var*
var
 l_Index    : Integer;
 l_Listener : InsTreeDataListener;
 l_Item     : IUnknown;
//#UC END# *48FF667E00CF_468361010204_var*
begin
//#UC START# *48FF667E00CF_468361010204_impl*
 if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
  for l_Index := 0 to Pred(NotifiedObjList.Count) do
  begin
   l_Item := NotifiedObjList.Items[l_Index];
   if Supports(l_Item, InsTreeDataListener, l_Listener) and
     (l_Item = l_Listener) then
    l_Listener.Updated;
  end;//for l_Index := 0
//#UC END# *48FF667E00CF_468361010204_impl*
end;//TnsDataResetTreeStruct.NotifyUpdated

procedure TnsDataResetTreeStruct.MakeResettedSimpleRoot;
//#UC START# *48FF66900153_468361010204_var*
var
 l_NewRoot: INodeBase;
 l_Sync: Integer;
//#UC END# *48FF66900153_468361010204_var*
begin
//#UC START# *48FF66900153_468361010204_impl*
  f_InGetRoot := True;
  Changing;
  try
   try
    //l_NewRoot := ReAqurieUnfilteredRoot;
    l_NewRoot := ReAqurieUnfilteredRootForMakeResettedSimpleRoot;
    //  ^^^ http://mdp.garant.ru/pages/viewpage.action?pageId=324570732&focusedCommentId=327818238#comment-327818238

    l_NewRoot := GetFilteredRoot(l_NewRoot, Filters, nil, l_Sync, True, False, False);
    if Assigned(l_NewRoot) then
     MakeRootNode(l_NewRoot);
   except
    on ECannotFindData do
     // - сюда попадаем например когда толковый словарь пропал
     Root := nil;
   end;//try..except
  finally
   f_InGetRoot := False;
   f_BeenReseted := rtsNone;
   try
    Changed;
   except
    // - сюда попадаем например когда толковый словарь пропал
    on EDoChangedAlreadyDone do
     raise;
    on E : Exception do
    begin
     l3System.Exception2Log(E);
    end;//on E : Exception
    else
     ; 
   end;//try..except
  end;//try..finally
//#UC END# *48FF66900153_468361010204_impl*
end;//TnsDataResetTreeStruct.MakeResettedSimpleRoot

procedure TnsDataResetTreeStruct.Cleanup;
//#UC START# *479731C50290_468361010204_var*
//#UC END# *479731C50290_468361010204_var*
begin
//#UC START# *479731C50290_468361010204_impl*
 f_BeenReseted := rtsNone;
 f_InGetRoot := False;
 inherited;
//#UC END# *479731C50290_468361010204_impl*
end;//TnsDataResetTreeStruct.Cleanup

procedure TnsDataResetTreeStruct.FinishDataUpdate;
//#UC START# *47EA4E9002C6_468361010204_var*
//#UC END# *47EA4E9002C6_468361010204_var*
begin
//#UC START# *47EA4E9002C6_468361010204_impl*
 inherited;
 Changing;
 try
  if (f_Root <> nil) then
  begin
   BeforeReset;
   Root := nil;
  end;//f_Root <> nil
 finally
  Changed;
 end;//try..finally
 NotifyUpdated;
//#UC END# *47EA4E9002C6_468361010204_impl*
end;//TnsDataResetTreeStruct.FinishDataUpdate

procedure TnsDataResetTreeStruct.ResetChildrenCountPrim;
//#UC START# *48FDA14302AE_468361010204_var*
//#UC END# *48FDA14302AE_468361010204_var*
begin
//#UC START# *48FDA14302AE_468361010204_impl*
 FinishDataUpdate;
 inherited;
//#UC END# *48FDA14302AE_468361010204_impl*
end;//TnsDataResetTreeStruct.ResetChildrenCountPrim

function TnsDataResetTreeStruct.pm_GetRoot: Il3SimpleRootNode;
//#UC START# *48FDD9D901BB_468361010204get_var*
//#UC END# *48FDD9D901BB_468361010204get_var*
begin
//#UC START# *48FDD9D901BB_468361010204get_impl*
 if f_InGetRoot then
 begin
  Result := nil;
  exit;
 end;//f_InGetRoot
 if (f_BeenReseted <> rtsNone) and
    (f_Root = nil) then
 begin
  MakeResettedSimpleRoot;
  Result := inherited pm_GetRoot;
 end//f_BeenReseted <> rtsNone
 else
  Result := inherited pm_GetRoot;
//#UC END# *48FDD9D901BB_468361010204get_impl*
end;//TnsDataResetTreeStruct.pm_GetRoot

procedure TnsDataResetTreeStruct.pm_SetRoot(const aValue: Il3SimpleRootNode);
//#UC START# *48FDD9D901BB_468361010204set_var*
//#UC END# *48FDD9D901BB_468361010204set_var*
begin
//#UC START# *48FDD9D901BB_468361010204set_impl*
 inherited;
//#UC END# *48FDD9D901BB_468361010204set_impl*
end;//TnsDataResetTreeStruct.pm_SetRoot

function TnsDataResetTreeStruct.DoMakeFiltered(const aFilters: Il3TreeFilters;
  const aCurrentNode: Il3SimpleNode;
  out aSyncIndex: Integer;
  aAutoOpen: Boolean;
  CalcPartialContext: Boolean): Il3SimpleTree;
//#UC START# *48FF5A9002CC_468361010204_var*
//#UC END# *48FF5A9002CC_468361010204_var*
begin
//#UC START# *48FF5A9002CC_468361010204_impl*
 if (f_BeenReseted <> rtsNone) and
    (f_Root = nil) then
  MakeResettedSimpleRoot;
 Result := inherited DoMakeFiltered(aFilters, aCurrentNode, aSyncIndex, aAutoOpen, CalcPartialContext);
//#UC END# *48FF5A9002CC_468361010204_impl*
end;//TnsDataResetTreeStruct.DoMakeFiltered

end.