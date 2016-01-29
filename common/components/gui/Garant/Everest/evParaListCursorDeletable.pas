unit evParaListCursorDeletable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evParaListCursorDeletable.pas"
// Начат: 18.06.2009 17:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Cursors::TevParaListCursorDeletable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  nevTools,
  evParaListCursorInsertable,
  nevBase
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevParaListCursorDeletable = class(TevParaListCursorInsertable, IevOpDeletePara)
 protected
 // realized methods
   function DoIt(const anOpPack: InevOp;
     aFlags: TevDeleteParaFlags = [ev_dpfAtEnd]): Boolean;
 end;//TevParaListCursorDeletable
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  evParaListCursorPrim,
  evOp,
  evCursorConst
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  ,
  l3Base,
  k2Facade,
  k2Interfaces,
  SysUtils,
  l3Variant
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevParaListCursorDeletable

function TevParaListCursorDeletable.DoIt(const anOpPack: InevOp;
  aFlags: TevDeleteParaFlags = [ev_dpfAtEnd]): Boolean;
//#UC START# *48D0C21201B1_4A3A43F6003A_var*
var
 PID : Integer;

 function _ModifyCursor1(PLC: PevParaListCursor; Index: Integer): Boolean; 
 begin//_ModifyCursor1
  Result := true;
  if (PLC^.Position = PID) then
  begin
   (* - курсор стоит на удаляемом параграфе - надо что-то делать,
     а то куда же ему потом показывать *)
   if ev_dpfInternal in aFlags then
    PLC^.Move(nil, ev_ocPrevParaBottomRightInThisBlock, anOpPack)
   else
    if ev_dpfInMerge in aFlags then
    begin
     if not PLC^.Move(nil, ev_ocPrevParaBottomRight, anOpPack) then
      PLC^.SetEntryPoint(ev_cpNull, anOpPack as IevCursorContext)
    end
    else
    begin
     if not PLC^.Move(nil, ev_ocNextParaTopLeft, anOpPack) then
      // - не смогли сместиться на следующий параграф
      if not PLC^.Move(nil, ev_ocPrevParaBottomRight, anOpPack) then
       // - не смогли сместиться на предыдущий параграф
       PLC^.SetEntryPoint(ev_cpNull, anOpPack As IevCursorContext);
       // - надо что то делать !!!
    end;//Internal
  end;//PLC^.Position = PID
 end;//_ModifyCursor1

 function _ModifyCursor2(PLC: PevParaListCursor; Index: Integer): Boolean; 
 begin//_ModifyCursor2
  Result := true;
  if (PLC^.Position > PID) then
   PLC^.OffsetPID(-1, anOpPack);
 end;//_ModifyCursor2

var
 l_AsUsual     : Boolean;
 l_DeletedPara : Il3TagRef;
 l_Parent      : InevParaList;
//#UC END# *48D0C21201B1_4A3A43F6003A_var*
begin
//#UC START# *48D0C21201B1_4A3A43F6003A_impl*
 Result := true;
 //CheckProcessor(anOpPack);
 l_Parent := ParaX;
 PID := Position;
 if (ev_dpfAtEnd in aFlags) then Inc(PID);
 l_AsUsual := not (ev_dpfForce in aFlags);
 if l_AsUsual then
 begin
  evIterateCursorsF(l_Parent.AsObject, l3L2IA(@_ModifyCursor1));
  k2.SignalEvent(Self, k2_eidChildrenDeleted, l_Parent.AsObject, anOpPack, Pred(PID), 1, l_Parent.ParaCount);
 end; // if not (ev_dpfForce in aFlags) then
 l_Parent.AsObject.DeleteChild(Pred(PID), anOpPack, l_DeletedPara);
 l_DeletedPara := nil;
 if l_AsUsual then
  evIterateCursorsF(l_Parent.AsObject, l3L2IA(@_ModifyCursor2));
//#UC END# *48D0C21201B1_4A3A43F6003A_impl*
end;//TevParaListCursorDeletable.DoIt

{$IfEnd} //evUseVisibleCursors

end.