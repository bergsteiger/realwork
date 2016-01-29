unit k2Op;
{* ���������� �������� � ����� ��������. }

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. �                 }
{ ������: l3Op -                      }
{ �����: 07.12.1999 19:05             }
{ $Id: k2Op.pas,v 1.22 2014/02/18 16:31:25 lulin Exp $ }

// $Log: k2Op.pas,v $
// Revision 1.22  2014/02/18 16:31:25  lulin
// - ���������������� � ��������� ��������.
//
// Revision 1.21  2013/12/27 06:48:49  lulin
// - ���������� ��������.
//
// Revision 1.20  2012/10/26 19:41:55  lulin
// - �������� ��������� ����� ���������.
//
// Revision 1.19  2011/06/14 16:11:43  lulin
// {RequestLink:269066487}.
//
// Revision 1.18  2011/05/19 13:33:25  lulin
// {RequestLink:266409354}.
//
// Revision 1.17  2011/05/19 12:23:39  lulin
// {RequestLink:266409354}.
//
// Revision 1.16  2011/05/19 10:36:01  lulin
// {RequestLink:266409354}.
//
// Revision 1.15  2011/05/18 17:45:49  lulin
// {RequestLink:266409354}.
//
// Revision 1.14  2010/11/24 20:16:32  lulin
// {RequestLink:238945411}.
//
// Revision 1.13  2010/03/18 14:15:38  lulin
// {RequestLink:197951943}.
//
// Revision 1.12  2009/07/23 13:42:34  lulin
// - ��������� ��������� �������� ���� ���� ����.
//
// Revision 1.80  2009/07/21 15:10:18  lulin
// - bug fix: �� ��������� � �� ������� ���������� � �����.
//
// Revision 1.79  2009/07/20 11:22:19  lulin
// - ���������� �������� F1 ����� - {RequestLink:141264340}. �7, 32, 33.
//
// Revision 1.78  2008/03/21 15:41:42  lulin
// - <K>: 87591144.
//
// Revision 1.77  2008/02/21 18:37:23  lulin
// - ������� �������� ��������.
//
// Revision 1.76  2008/02/21 18:13:28  lulin
// - ����������� �� �������� �����.
//
// Revision 1.75  2008/02/14 17:09:15  lulin
// - cleanup.
//
// Revision 1.74  2008/02/12 10:31:25  lulin
// - ����������� �� ��������� ������ �� ������� ������.
//
// Revision 1.73  2008/02/05 09:58:12  lulin
// - �������� ������� ������� � ��������� ����� � ��������� �� �� ������.
//
// Revision 1.72  2008/02/01 15:14:54  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.71  2007/12/24 15:25:32  lulin
// - ������� �������� �����.
//
// Revision 1.70  2007/09/07 14:47:45  lulin
// - ��������� �������� ���������� �������� ������.
//
// Revision 1.69  2007/02/12 18:06:19  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.68  2007/02/12 16:40:36  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.67  2007/01/22 15:20:13  oman
// - new: ����������� ��������� - l3 (cq24078)
//
// Revision 1.66  2006/11/17 14:23:09  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.65.12.1  2006/11/17 14:16:12  oman
// warning fix - ������� �� ���������� ���������
//
// Revision 1.65  2006/05/18 08:08:16  lulin
// - cleanup.
//
// Revision 1.64  2006/01/12 13:16:51  lulin
// - bug fix: �� ��������� �������� � �����, �.�. �� ������ ���� �������� � ���������.
//
// Revision 1.63  2005/12/26 13:26:57  lulin
// - bug fix: �� ������ ������������ ��������� ������������ (CQ OIT5-18865).
//
// Revision 1.62  2005/12/09 14:12:51  lulin
// - bug fix: �� ���������� ����������� �� ��������� ����������� ����������.
//
// Revision 1.61  2005/12/07 07:46:25  lulin
// - bug fix: ����������� ���������� ��������� �������� ����� Undo - � ���������� ��� AV ��� ������� ������������ ��� ������� ��������� (CQ OIT5-18513).
//
// Revision 1.60  2005/12/05 04:46:46  lulin
// - cleanup.
//
// Revision 1.59  2005/12/03 14:46:59  lulin
// - ����������� �� �������������� ������� TextSource � ���������� ���������.
//
// Revision 1.58  2005/12/02 18:23:38  lulin
// - �������� ������������ �� ��������/���������� ��������� ����������� ��������� ���������� �� ���������.
//
// Revision 1.57  2005/11/18 15:13:36  lulin
// - �������� ���������� ������������.
//
// Revision 1.56  2005/11/11 22:23:23  lulin
// - ����������� �� ���������� ��������� ������������������ ��������� ����� ������� ���������.
//
// Revision 1.55  2005/11/11 21:52:19  lulin
// - bug fix: ������ ������ �������� ���������, ��������� � ������������ ��������� Undo-�������.
//
// Revision 1.54  2005/11/09 12:56:46  lulin
// - ������� ���������� ���������.
//
// Revision 1.53  2005/04/28 15:04:11  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.52.2.2  2005/04/26 14:30:57  lulin
// - �������� l3Free � _l3Use.
//
// Revision 1.52.2.1  2005/04/26 08:10:05  lulin
// - ��������� ���������� ������� QueryInterface.
//
// Revision 1.52  2005/04/19 16:26:00  lulin
// - cleanup.
//
// Revision 1.51  2005/04/01 08:35:32  lulin
// - remove proc: evDir_InsertPara (����������� ������������ InevParaList).
//
// Revision 1.50  2005/02/03 15:25:36  lulin
// - Undo-������ ������� �����������.
//
// Revision 1.49  2005/02/03 15:05:58  lulin
// - bug fix: ������� ������ �� �������� ������ ������������������.
//
// Revision 1.48  2005/02/03 14:33:45  lulin
// - ��� Undo-������� ���������� ��������� ������ ToUndo, ������ �������������.
//
// Revision 1.47  2005/02/03 13:29:15  lulin
// - new interface: _Il3OpPackInternal.
//
// Revision 1.46  2005/02/03 13:10:41  lulin
// - new method: _Tl3Op._Put.
//
// Revision 1.45  2005/02/03 08:30:21  lulin
// - bug fix: ����� �������� �� ������ _Unknow_ �� ��� �������� �������� � ����� Undo.
//
// Revision 1.44  2005/02/02 18:24:44  lulin
// - ����� _Tl3_CBase ��������� �� ������ _Unknown_.
//
// Revision 1.43  2004/10/15 12:40:47  lulin
// - bug fix: �� ����������� �����������, �.�. ����� �� ������� ��� ����������������.
//
// Revision 1.42  2004/09/20 12:42:58  lulin
// - ����������� - ����� ����������� ����� �������� � ���, ����� �������� �� (�� ������ ����������) ��������� � 3.5 ��� �� 2.6 ���.
//
// Revision 1.41  2004/06/02 16:42:39  law
// - ������ ����� Tl3VList.
//
// Revision 1.40  2003/02/13 18:25:55  law
// - change: ������� _Lock/Unlock ���������� �������� � ����� �������� (�114).
//
// Revision 1.39  2003/02/13 13:08:56  law
// - cleanup.
//
// Revision 1.38  2003/01/24 16:12:53  law
// - new interface: Il3OpPackMode.
// - new methods: Il3OpPack.Undo, Redo, Clear.
//
// Revision 1.37  2002/10/07 11:19:23  law
// - cleanup.
//
// Revision 1.36  2002/07/18 12:32:15  law
// - comments.
//
// Revision 1.35  2002/07/18 11:59:15  law
// - new unit: l3Message.
//
// Revision 1.34  2002/06/04 16:34:56  narry
// - bug fix: �� ��������� ������ �� _l3NilOp.
//
// Revision 1.33  2002/05/14 08:37:32  law
// - new methods: Tl3VList: LoadFromStream, LoadFromFile, SaveToStream, SaveToFile.
//
// Revision 1.32  2001/11/20 10:21:18  law
// - comments: xHelpGen.
//
// Revision 1.31  2001/09/26 14:24:22  law
// - new behavior: ����������� �������� ������ �������� � _Tl3OperationContainer._Add, � �� � _Put.
//
// Revision 1.30  2001/09/26 14:06:59  law
// - cleanup: l3NilObject ������� �� _l3NilOp.
//
// Revision 1.29  2001/09/26 13:03:05  law
// - optimize: ���������� ������� Undo-������.
//
// Revision 1.28  2001/06/18 14:32:50  law
// - cleanup.
//
// Revision 1.27  2001/05/31 11:16:52  law
// - cleanup: ������ ������ � ����������� em_* �� �������������.
//
// Revision 1.26  2001/03/23 17:45:22  law
// - ���������� Il3OpPack ��������� �������� Processor.
//
// Revision 1.25  2001/03/13 18:44:34  law
// - some cleaning, tuning & comments.
//
// Revision 1.24  2001/01/31 10:37:32  law
// - �������������� ������������� QueryInterface.
//
// Revision 1.23  2000/12/15 15:19:01  law
// - ��������� ��������� Log.
//

{$Include l3Define.inc }

interface

uses
  Messages,
  Classes,

  l3Types,
  l3Interfaces,
  l3Base,
  l3InternalInterfaces,
  l3Msg,
  l3Except,
  l3CacheableBase,
  l3CProtoObject,

  k2Prim
  ;

type
  Tk2Op = class(Tl3CProtoObject)
   {* ������� ����� ��� ���������� ��������. }
    protected
    {internal methods}
      procedure DoUndo(const Container: Ik2Op);
        virtual;
        {* - �������� ��������. ��� ���������� � ��������. }
      procedure DoRedo(const Container: Ik2Op);
        virtual;
        {* -��������� ��������. ��� ���������� � ��������. }
      function CanJoinWith(anOperation: Tk2Op): Bool;
        virtual;
        {* - ����� �� ���������� � ������ ���������? ��� ���������� � ��������. }
      function DoJoin(anOperation: Tk2Op): Tk2Op;
        virtual;
        {* - ��������� ��� �������� � ����������:
             |<br>
             |<b>nil</b>  - ���������� ��������.<br>
             |<b>Self</b> - ���������� ������ � ��� ����������� � ������ ������.<br>
             |<b>New</b>  - ������������ ����� ��������.<br>
             |<b>l3NilOp</b> - �������� �������������. }
    protected
    // property methods
      function pm_GetFlags: Tl3OperationFlags;
        virtual;
        {* - ����� ��� ������ �������� Flags. ��� ���������� � ��������. }
    public
    // public methods
      class procedure ToUndo(const anOpPack : Ik2Op);
        {-}
      procedure Put(const anOpPack : Ik2Op;
                    Modify         : Boolean = false);
        {-}
      function Undo(const Container: Ik2Op): Bool;
        {* - �������� ��������. }
      function Redo(const Container: Ik2Op): Bool;
        {* - ��������� ��������. }
      function CanLinkWith(anOperation: Tk2Op): Bool;
        virtual;
        {* - ����� �� ������� � ������ ���������? ��� ���������� � ��������. }
      function JoinWith(P: Tk2Op; const Container: Ik2Op = nil): Long;
        virtual;
        {* - ��������� Self � P � ���������� 0 ���� ��� ��������
          ����� - ���������� -1. ����� ��������� El3NewOperation, ���� ������� ����� ��������. }
      function  CompareWith(anOp: Tk2Op): Integer;
        virtual;
        {-}
      function  RestrictJoin: Boolean;
        virtual;
        {-}  
    public
    // public properties
      property Flags: Tl3OperationFlags
        read pm_GetFlags;
        {* - ����� ��������. }
  end;//Tk2Op

  El3NewOperation = class(El3Warning)
   {* �������������� ��������, ��������������� � �������� ����� ��������. }
    public
    // public fields
      Op : Tk2Op;
        {* - ����� ��������� ��������. }
  end;//El3NewOperation

implementation

uses
  SysUtils,

  l3Const,
  l3Message,
  l3InterfacesMisc,
  l3IntegerValueMapManager,
  l3String,

  k2NilOp,
  k2OperationContainer
  ;

// start class Tk2Op 

procedure Tk2Op.DoUndo(const Container: Ik2Op);
  {virtual;}
  {-�������� ��������}
begin
end;

procedure Tk2Op.DoRedo(const Container: Ik2Op);
  {virtual;}
  {-��������� ��������}
begin
end;

function Tk2Op.CanJoinWith(anOperation: Tk2Op): Bool;
  {virtual;}
  {-}
begin
 Result := false;
end;

function Tk2Op.DoJoin(anOperation: Tk2Op): Tk2Op;
  {virtual;}
  {-��������� ��� �������� � ����������:
    nil  - ���������� ��������
    Self - ���������� ������ � ��� ����������� � ������ ������
    New  - ������������ ����� �������� }
  {-}
begin
 Result := nil;
end;

function Tk2Op.pm_GetFlags: Tl3OperationFlags;
  {virtual;}
  {-}
begin
 Result := [ofCanUndo, ofCanRedo];
end;

class procedure Tk2Op.ToUndo(const anOpPack : Ik2Op);
  {-}
var
 l_Op : Tk2Op;
begin
 if (anOpPack <> nil) then
 begin
  l_Op := Create;
  try
   l_Op.Put(anOpPack);
  finally
   l3Free(l_Op);
  end;//try..finally
 end;//anOpPack <> nil
end;

procedure Tk2Op.Put(const anOpPack : Ik2Op;
                    Modify         : Boolean = false);
  {-}
var
 l_Op : Ik2OpPackInternal;
begin
 if (anOpPack <> nil) then
  if Supports(anOpPack, Ik2OpPackInternal, l_Op) then
   try
    l_Op.Put(Self, Modify);
   finally
    l_Op := nil;
   end;//try..finally
end;
  
function Tk2Op.Undo(const Container: Ik2Op): Bool;
  {-�������� ��������}
begin
 Result := true;
 if (ofCanUndo in Flags) then
  DoUndo(Container)
 else
  Result := false;
end;

function Tk2Op.Redo(const Container: Ik2Op): Bool;
  {-��������� ��������}
begin
 Result := true;
 if (ofCanRedo in Flags) then
  DoRedo(Container)
 else
  Result := false;
end;

function Tk2Op.CanLinkWith(anOperation: Tk2Op): Bool;
  {virtual;}
  {-}
begin
 Result := (anOperation Is ClassType);
end;

function Tk2Op.JoinWith(P: Tk2Op; const Container: Ik2Op = nil): Long;
  {override;}
  {-��������� Self � anOperation � ���������� true ���� ��� ��������
    ����� - ���������� false}
var
 Res : Tk2Op;
 E   : El3NewOperation;
begin
 if CanJoinWith(P) then
 begin
  Res := DoJoin(P);
  if (Res = nil) then
   Result := -1
  else
  if (Res = Self) then
   Result := 0
  else
  begin
   if (Res = Tk2NilOp.Instance) then
   begin
    E := El3NewOperation.Create('');
    E.Op := Res.Use;
   end//Res = Tk2NilOp.Instance
   else
   begin
    E := El3NewOperation.CreateFmt(l3_MesNewUndoOperation, [Res.ClassName]);
    E.Op := Res;
   end;//Res = Tk2NilOp.Instance
   raise E;
  end;//Res = Self
 end//CanJoinWith(P)
 else
  Result := -1;
end;

function Tk2Op.CompareWith(anOp: Tk2Op): Integer;
  //override;
  {-}
begin
 Result := Integer(Self) - Integer(anOp);
 //Assert(false, '����� �������� �����������?');
 // - � ��� ����� - http://mdp.garant.ru/pages/viewpage.action?pageId=269066487
 //   �� �����������, � ������.
end;

function Tk2Op.RestrictJoin: Boolean;
  //virtual;
  {-}
begin
 Result := false;
end;

end.

