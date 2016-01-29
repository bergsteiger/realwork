unit evUndoB;
{* ���������� Undo-������. }

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: evUndoB - �������� Undo ������}
{ �����: 05.06.1997 12:07 }
{ $Id: evUndoB.pas,v 1.37 2014/03/25 14:31:45 lulin Exp $ }

// $Log: evUndoB.pas,v $
// Revision 1.37  2014/03/25 14:31:45  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.36  2012/02/03 17:09:11  lulin
// {RequestLink:333548940}
// - ������ ��������� ���� �� ������.
//
// Revision 1.35  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.34  2011/05/18 17:45:16  lulin
// {RequestLink:266409354}.
//
// Revision 1.33  2009/07/23 13:42:11  lulin
// - ��������� ��������� �������� ���� ���� ����.
//
// Revision 1.32  2009/07/23 08:14:39  lulin
// - �������� �������� ������������� ���������� ��������.
//
// Revision 1.31  2008/11/11 09:01:44  lulin
// - <K>: 114459503.
// - F1 �� ����������.
//
// Revision 1.30  2008/11/10 15:42:50  lulin
// - <K>: 114459503. ������ � ������ � ��������� ��������� �������� ������� �������� ��������.
//
// Revision 1.29  2008/08/25 15:14:47  lulin
// - <K>: 100011305.
//
// Revision 1.28  2008/03/21 15:41:37  lulin
// - <K>: 87591144.
//
// Revision 1.27  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.26  2008/03/03 13:20:27  lulin
// - nevTools �������� �� ������. ������ �� �������������.
//
// Revision 1.25  2008/02/12 10:31:18  lulin
// - ����������� �� ��������� ������ �� ������� ������.
//
// Revision 1.24  2008/02/07 09:32:56  lulin
// - ���������������� � �������� ������ ����� �� ������.
//
// Revision 1.23  2008/02/05 09:57:38  lulin
// - �������� ������� ������� � ��������� ����� � ��������� �� �� ������.
//
// Revision 1.22  2007/12/04 12:47:07  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.19.24.10  2007/11/28 13:24:28  dinishev
// ������������� � ����
//
// Revision 1.19.24.9  2007/09/07 12:52:52  lulin
// - ������ �������� ��������.
//
// Revision 1.19.24.8  2007/04/20 11:07:19  lulin
// - ������� �������� ����������������.
//
// Revision 1.19.24.7  2006/01/12 13:16:48  lulin
// - bug fix: �� ��������� �������� � �����, �.�. �� ������ ���� �������� � ���������.
//
// Revision 1.19.24.6  2006/01/12 11:57:41  lulin
// - cleanup.
//
// Revision 1.19.24.5  2005/11/18 13:26:24  lulin
// - � ��������� ����� ����������� ������ ����� �������� ����� ��������.
//
// Revision 1.19.24.4  2005/11/11 22:23:15  lulin
// - ����������� �� ���������� ��������� ������������������ ��������� ����� ������� ���������.
//
// Revision 1.19.24.3  2005/11/11 21:52:13  lulin
// - bug fix: ������ ������ �������� ���������, ��������� � ������������ ��������� Undo-�������.
//
// Revision 1.19.24.2  2005/11/11 18:04:07  lulin
// - ������� ��������� Undo-������.
//
// Revision 1.19.24.1  2005/11/09 15:28:25  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.19  2004/06/01 16:51:19  law
// - ������ ����������� Tl3VList.MakePersistent - ����������� _Tl3ObjectRefList.
//
// Revision 1.18  2003/03/19 10:47:33  law
// - new directives: evForEE, _evNeedDisp, _evNotNeedDisp.
//
// Revision 1.17  2002/12/26 12:58:23  law
// - new dll: ������� pe.dll ��� _evDisp.
//
// Revision 1.16  2001/10/15 15:02:36  law
// - bug fix: ����� ������� ��� ��������.
//
// Revision 1.15  2001/09/26 14:06:59  law
// - cleanup: l3NilObject ������� �� _l3NilOp.
//
// Revision 1.14  2001/06/01 08:41:40  law
// - comments: ��������� ����������� ��� xHepGen.
//
// Revision 1.13  2001/06/01 08:11:07  law
// - cleanup: ������ ������ � ��������� �����������, � ����� �������� ����������� ����� ��������.
//
// Revision 1.12  2001/05/31 11:16:52  law
// - cleanup: ������ ������ � ����������� em_* �� �������������.
//
// Revision 1.11  2000/12/15 15:10:39  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  Classes,
  Messages,

  l3Interfaces,
  l3Base,
  l3Types,
  l3Msg,
  l3Variant,

  k2Prim,
  k2OperationContainerRefList,

  nevTools
  ;

type
  TevCustomUndoBuffer = class(Tk2OperationContainerRefList, Ik2UndoBuffer)
   {* ������� ����� ��� ���������� Undo-������. }
    private
    // internal fields
      f_Active   : Long;
      f_InClear  : Boolean;
      f_Disabled : Boolean;
    protected
    // property methods
      function  pm_GetCanUndo: Bool;
        {-}
      function  pm_GetCanRedo: Bool;
        {-}
      function  Get_Last: TObject;
        {-}
      function Get_Empty: Boolean;
        {-}
      function Get_Disabled: Bool;
        {-}
      procedure Set_Disabled(Value: Bool);
        {-}
    protected
    // internal methods
      procedure DoCanUndoChange;
        {-}
      procedure DoCanRedoChange;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class function Make: Ik2UndoBuffer;
        reintroduce;
        {-}
      procedure Clear;
        override;
        {-}
      function  GetActiveObject(aSucc: Boolean): TObject;
        {-}
      procedure ExecutedOperation(aContainer : TObject);
        {* - ����������� ������ � ����� ����� ��������. }
      function  Undo(const aProcessor: InevProcessor): Boolean;
        {* - �������� ���������� ��������. }
      function  Redo(const aProcessor: InevProcessor): Boolean;
        {* - ������� ���������� ��������. }
    public
    // public properties
      property Active: Long
        read f_Active;
        {* - ������ ������� ��������. }
      property Disabled: Bool
        read Get_Disabled
        write Set_Disabled
        default false;
        {* - ��������� �� ���������� ��������? }
      property CanUndo: Bool
        read pm_GetCanUndo;
        {* - ����� �� �������� ��������? }
      property CanRedo: Bool
        read pm_GetCanRedo;
        {* - ����� �� ������� ��������? }
  end;//TevCustomUndoBuffer

  TevUndoBuffer = class(TevCustomUndoBuffer)
   {*! ����� ��� ���������� Undo-������. }
  end;//TevUndoBuffer

implementation

uses
  l3Const,
  
  k2OperationContainer,
  k2Op,
  k2NilOp

  {$IfDef evUseVisibleCursors}
  ,
  evInternalInterfaces
  {$EndIf evUseVisibleCursors}
  {$IfDef evNeedDisp}
  ,
  evDisp,
  evStandardActions
  {$EndIf evNeedDisp}
  ;

// start class TevUndoBuffer

class function TevCustomUndoBuffer.Make: Ik2UndoBuffer;
  //reintroduce;
  {-}
var
 l_Buf : TevCustomUndoBuffer;
begin
 l_Buf := Create;
 try
  Result := l_Buf;
 finally
  l3Free(l_Buf);
 end;//try..finally
end;

procedure TevCustomUndoBuffer.Cleanup;
  //override;
  {-}
begin
 Clear;
 inherited;
end;

procedure TevCustomUndoBuffer.DoCanUndoChange;
  {-}
begin
 {$IfDef evNeedDisp}
 evOperationDispatcher.OperationEnabled[ev_ccUndo] := CanUndo;
 {$EndIf evNeedDisp}
end;

procedure TevCustomUndoBuffer.DoCanRedoChange;
  {-}
begin
 {$IfDef evNeedDisp}
 evOperationDispatcher.OperationEnabled[ev_ccRedo] := CanRedo;
 {$EndIf evNeedDisp}
end;

function TevCustomUndoBuffer.pm_GetCanUndo: Bool;
  {-}
begin
 Result := ((Self <> nil) AND (Count > 0) AND (f_Active >= 0));
end;

function TevCustomUndoBuffer.pm_GetCanRedo: Bool;
  {-}
begin
 Result := ((Self <> nil) AND (Count > 0) AND (Succ(f_Active) < Count));
end;

function TevCustomUndoBuffer.Get_Last: TObject;
  {-}
begin
 Result := Last;
end;

procedure TevCustomUndoBuffer.Clear;
  {override;}
  {-}
begin
 if not f_InClear then
 begin
  f_InClear := true;
  try
   inherited;
  finally
   f_InClear := false;
  end;//try..finally
 end;//not f_InClear
end;

function TevCustomUndoBuffer.GetActiveObject(aSucc: Boolean): TObject;
  {-}
begin
 if aSucc then
  Result := Items[Succ(Active)]
 else
  Result := Items[Active];
end;

type
  Tk2OperationContainerHack = class(Tk2OperationContainer);

procedure TevCustomUndoBuffer.ExecutedOperation(aContainer : TObject);
  {-}
var
 PC        : Tk2OperationContainer;
 Container : Tk2OperationContainer;

 procedure DoJoin;
 begin//DoJoin
  PC.JoinWith(Container);
  Container.Clear;
  //Changed;
 end;//DoJoin

var
 OCU : Bool;
 OCR : Bool;
 Res : Long;
 I0  : Tk2Op;
 IHi : Tk2Op;
 {$IfDef evUseVisibleCursors}
 l_CursorContext : IevCursorContext;
 {$EndIf evUseVisibleCursors}
begin
 if (Self <> nil) then
 begin
  Container := aContainer As Tk2OperationContainer;
  if Il3OpPack(Container).SaveUndo AND not f_InClear AND not f_Disabled then
  begin
   //Container.Owner := Self;
   // - ��� ���������� �����������������, �.�. ��������� � ���������� ����������
   {$IfDef evUseVisibleCursors}
   if (Container <> nil) AND
      l3IOk(Container.QueryInterface(IevCursorContext, l_CursorContext)) then
    try
     l_CursorContext.StopRecord;
    finally
     l_CursorContext := nil;
    end;//try..finally
   {$EndIf evUseVisibleCursors}
   if not Container.Empty then
   begin
    OCU := CanUndo;
    OCR := CanRedo;
    f_InClear := true;
    try
     while (Succ(f_Active) < Count) do
      Delete(Succ(f_Active));
    finally
     f_InClear := false;
    end;{try..finally}
    if (Count > 0) then
    begin
     PC := Items[f_Active];
     if (Container.Count > 0) then
      I0 := Container.Items[0]
     else
      I0 := nil;
     if (PC.Count > 0) then
      IHi := PC.Items[PC.Hi]
     else
      IHi := nil;
     if (IHi = nil) then
     begin
      if (PC.Code = Container.Code) then
       DoJoin;
     end//IHi = nil
     else
     begin
      try
       Res := IHi.JoinWith(I0, nil);
       if (Res = l3NilLong) then
       begin
        Container.Delete(0);
        PC.Delete(PC.Hi);
        if PC.Empty then
        begin
         Delete(f_Active);
         Dec(f_Active);
         if (f_Active < 0) then
          PC := nil
         else
          PC := Items[f_Active];
        end;{PC.Empty}
        if (PC <> nil) then
         DoJoin;
       end//Res = l3NilLong
       else
       if (Res >= 0) then
       begin
        Container.Delete(0);
        DoJoin;
       end//Res >= 0
       else
       if IHi.CanLinkWith(I0) then
        DoJoin
       else
       if (PC.Code = Container.Code) then
        if not IHi.RestrictJoin AND ((I0 = nil) OR not I0.RestrictJoin) then
         DoJoin;
      except
       on E : El3NewOperation do
       begin
        if (E.Op = Tk2NilOp.Instance) then
         PC.Delete(PC.Hi)
        else
         PC.Items[PC.Hi] := E.Op;
        l3Free(E.Op);
        Container.Delete(0);
        DoJoin;
        if PC.Empty then
        begin
         Delete(f_Active);
         Dec(f_Active);
        end;//PC.Empty
       end;//El3NewOperation
      end;//try..except
     end;//IHi = nil
    end;//Count > 0..
    if not Container.Empty then
     f_Active := Add(Container);
    Tk2OperationContainerHack(Container).DoSetOwner(nil);
    if (OCU <> CanUndo) then
     DoCanUndoChange;
    if (OCR <> CanRedo) then
     DoCanRedoChange;
   end;//not Container.Empty
  end;//Op <> nil..
 end;//Self <> nil
end;

function TevCustomUndoBuffer.Undo(const aProcessor: InevProcessor): Boolean;
  {-}
var
 OCR : Bool;
begin
 if CanUndo then
 begin
  Assert(aProcessor <> nil);
  Result := true;
  OCR := CanRedo;
  Il3OpPack(Tk2OperationContainer(Items[f_Active])).Undo(aProcessor);
  Dec(f_Active);
  if not CanUndo then
   DoCanUndoChange;
  if (OCR <> CanRedo) then
   DoCanRedoChange;
 end//CanUndo
 else
  Result := false;
end;

function TevCustomUndoBuffer.Redo(const aProcessor: InevProcessor): Boolean;
  {-}
var
 OCU : Bool;
begin
 if CanRedo then
 begin
  Assert(aProcessor <> nil);
  Result := true;
  OCU := CanUndo;
  Inc(f_Active);
  Il3OpPack(Tk2OperationContainer(Items[f_Active])).Redo(aProcessor);
  if (OCU <> CanUndo) then
   DoCanUndoChange;
  if not CanRedo then
   DoCanRedoChange;
 end//CanRedo
 else
  Result := false;
end;

function TevCustomUndoBuffer.Get_Empty: Boolean;
  {-}
begin
 Result := Empty;
end;

function TevCustomUndoBuffer.Get_Disabled: Bool;
begin
 Result := f_Disabled;
end;

procedure TevCustomUndoBuffer.Set_Disabled(Value: Bool);
begin
 f_Disabled := Value;
end;

end.

