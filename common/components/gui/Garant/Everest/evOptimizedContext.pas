unit evOptimizedContext;

{ ���������� "�������"         }
{ �����: ����� �.�. �          }
{ ������: evOptimizedContext - }
{ �����: 25.10.2000 17:25      }
{ $Id: evOptimizedContext.pas,v 1.46 2014/04/09 13:12:03 lulin Exp $ }

// $Log: evOptimizedContext.pas,v $
// Revision 1.46  2014/04/09 13:12:03  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.45  2014/04/08 17:13:19  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.44  2014/03/07 14:53:48  lulin
// - ������������� ������ �����.
//
// Revision 1.43  2013/12/27 06:48:45  lulin
// - ���������� ��������.
//
// Revision 1.42  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.41  2011/05/18 17:45:15  lulin
// {RequestLink:266409354}.
//
// Revision 1.40  2010/03/26 14:28:05  lulin
// {RequestLink:200081692}.
//
// Revision 1.39  2010/03/25 15:12:50  lulin
// {RequestLink:199591524}.
// - �� ���������� � Undo-����� �������� ����������.
//
// Revision 1.38  2009/07/23 13:42:11  lulin
// - ��������� ��������� �������� ���� ���� ����.
//
// Revision 1.37  2009/07/23 08:14:39  lulin
// - �������� �������� ������������� ���������� ��������.
//
// Revision 1.36  2008/08/25 16:00:04  lulin
// - ����� ������ �� ������ ��������� �������.
//
// Revision 1.35  2008/08/25 15:14:47  lulin
// - <K>: 100011305.
//
// Revision 1.34  2008/05/08 07:03:13  lulin
// - <K>: 90441963.
//
// Revision 1.33  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.32  2008/03/24 16:16:48  lulin
// - ���������� �������� ������.
//
// Revision 1.31  2008/03/21 15:41:37  lulin
// - <K>: 87591144.
//
// Revision 1.30  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.29  2008/03/19 14:23:34  lulin
// - cleanup.
//
// Revision 1.28  2008/02/19 11:05:47  lulin
// - ����������� ������ ������������ ������ � ������� ��������.
//
// Revision 1.27  2008/02/13 16:03:02  lulin
// - ������ ������� ������ ������ ������.
//
// Revision 1.26  2008/02/12 14:39:37  lulin
// - ������ ��� ������ ������ ��������� �� �������.
//
// Revision 1.25  2008/02/12 10:31:18  lulin
// - ����������� �� ��������� ������ �� ������� ������.
//
// Revision 1.24  2008/02/05 09:57:37  lulin
// - �������� ������� ������� � ��������� ����� � ��������� �� �� ������.
//
// Revision 1.23  2008/02/04 08:51:24  lulin
// - ����� _Tl3InterfaceList ������� � ��������� ������.
//
// Revision 1.22  2008/02/01 15:14:29  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.21  2008/01/31 18:53:27  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.20  2007/12/05 18:15:06  lulin
// - ������ �������� ���.
//
// Revision 1.19  2007/12/05 12:35:06  lulin
// - ������� �������� ���, ������������ ������� ����� � Head'�.
//
// Revision 1.18  2007/12/04 12:47:03  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.16.4.10  2006/11/25 16:35:41  lulin
// - � ���������� ���������� ������� �������� ��� ������.
//
// Revision 1.16.4.9  2006/11/03 11:00:05  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.16.4.8.6.2  2006/10/26 12:03:56  lulin
// - �������� �������� ����.
//
// Revision 1.16.4.8.6.1  2006/10/26 11:24:12  lulin
// - ����������� �� ������ �������������� �����.
//
// Revision 1.16.4.8  2006/08/02 10:51:52  lulin
// - ��������� � ������ � ������� ������� �� �����������.
//
// Revision 1.16.4.7.16.1  2006/07/28 14:11:13  lulin
// - ������ ������� ������������������ ���������.
//
// Revision 1.16.4.7  2005/11/09 15:28:24  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.16.4.6  2005/11/04 11:22:09  lulin
// - cleanup: � ��������� ����� ����� ������������������ - �� �������� ������ �� ����� ����������� �������.
//
// Revision 1.16.4.5  2005/10/18 10:48:26  lulin
// - ���������� ������� Undo-������ ��������/���������� �����, ���������� � ���������� �����.
//
// Revision 1.16.4.4  2005/10/18 10:32:48  lulin
// - ���������� ������� Undo-������, ��������� ������� �����, ���������� � ���������� �����.
//
// Revision 1.16.4.3  2005/10/12 12:00:18  lulin
// - bug fix: ��� ������������� ����� ����������� ��������� _preview (CQ OIT5-16844).
//
// Revision 1.16.4.2  2005/10/12 10:41:59  lulin
// - bug fix: ��� �������� ������ �� ��������������� �������� (CQ OIT5-)16900.
//
// Revision 1.16.4.1  2005/05/18 12:42:47  lulin
// - ����� ����� �����.
//
// Revision 1.15.2.1  2005/04/28 09:18:29  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.15.4.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.15  2005/04/04 07:48:56  lulin
// - cleanup.
//
// Revision 1.14  2005/03/23 12:42:23  lulin
// - ������ ������ ������ ��������� �� ��������.
//
// Revision 1.13  2004/09/21 12:55:41  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.12  2004/06/02 10:20:33  law
// - ������ ����������� Tl3VList.MakeIUnknown - ����������� _Tl3InterfaceList.Make.
//
// Revision 1.11  2004/06/01 16:51:19  law
// - ������ ����������� Tl3VList.MakePersistent - ����������� _Tl3ObjectRefList.
//
// Revision 1.10  2002/02/15 15:51:17  law
// - comments: xHelpGen.
//
// Revision 1.9  2002/01/10 15:23:59  law
// - bug fix: �� ��������������� � ���������� l3ConsoleApp.
//
// Revision 1.8  2001/09/26 14:24:21  law
// - new behavior: ����������� �������� ������ �������� � Tl3OperationContainer._Add, � �� � _Put.
//
// Revision 1.7  2001/09/26 14:06:58  law
// - cleanup: l3NilObject ������� �� _l3NilOp.
//
// Revision 1.6  2001/09/26 13:55:39  law
// - cleanup: �������� �����������.
//
// Revision 1.5  2001/09/26 13:03:05  law
// - optimize: ���������� ������� Undo-������.
//
// Revision 1.4  2001/09/26 12:03:35  law
// - bug fix: �������� � Undo ������. ������ �770. ��. _TestSet\Segments\Hyperlinks\3.evd .
//
// Revision 1.3  2001/05/15 13:11:20  law
// - new unit: �������� ������ evCursorContext - � ���� �������� ����� TevCursorContext.
//
// Revision 1.2  2000/12/15 15:10:36  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,
  l3ObjectRefList1,
  l3ObjectRefList,

  k2SimpleTagList,
  k2Op,
  k2OpRefList,

  nevBase,
  
  evCursorContext
  ;

type
  TevOptimizedContext = class(TevCursorContext)
    private
    // internal fields
      f_ClearSuper       : Tk2SimpleTagList;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      function  GetEmpty: Bool;
        override;
        {-}
      function  DoUndo(const aProcessor: InevProcessor): Long;
        override;
        {-���������� ��� �������� � ���������� �� ����������}
      function  DoRedo(const aProcessor: InevProcessor): Long;
        override;
        {-���������� ��� �������� � ���������� �� ����������}
      procedure ClearSuper;
        {-}
    public
    // public methods
      procedure Clear;
        override;
        {-}
      procedure Add(Item: Tk2Op);
        override;
        {-}
      function  JoinWith(P: k2OpRefList._l3TypedListPrim_): Long;
        override;
        {-}
  end;//TevOptimizedContext

implementation

{$IfNDef k2ForEditor}
  !!! ������: �� ���������� ��������� k2ForEditor.
{$EndIf  k2ForEditor}

uses
  l3Variant,
  
  k2Interfaces,
  k2Base,
  k2Tags,
  k2PropertyOperation,
  
  evSegLst,
  evSegOp,

  nevTools
  ;

procedure TevOptimizedContext.Cleanup;
  //override;
  {-}
begin
 l3Free(f_ClearSuper);
 inherited;
end;

procedure TevOptimizedContext.Clear;
  //override;
  {-}
begin
 l3Free(f_ClearSuper);
 inherited;
end;

procedure TevOptimizedContext.Add(Item: Tk2Op);
  //override;
  {-}
var
 l_Layers : Tl3Variant;
 l_Index  : Long;
begin
 if (TObject(Item) Is Tk2PropOperation) then
 begin
  if ((TObject(Item) Is OevSaveSegmentStart)) then
  begin
   if FindData(Item, l_Index) then
    Exit;
   //(TObject(Item) Is OevSaveSegmentStart
  end
  ;//Tk2PropOperation(Item).Prop.TagIndex = k2_tiFormatted
 end//TObject(Item) Is Tk2PropOperation
 else
 if (TObject(Item) Is OevClearSuper) then
 begin
  l_Layers := OevClearSuper(Item).Para;
  if (l_Layers = nil) then Exit;
  if (f_ClearSuper = nil) then
  begin
   f_ClearSuper := Tk2SimpleTagList.Make;
   f_ClearSuper.Add(l_Layers);
  end//f_ClearSuper = nil
  else
  if (f_ClearSuper.IndexOf(l_Layers) = -1) then
   f_ClearSuper.Add(l_Layers);
  Exit;
 end;//TObject(Item) Is Tk2PropOperation
 inherited Add(Item);
end;

function TevOptimizedContext.JoinWith(P : k2OpRefList._l3TypedListPrim_): Long;
  //override;
  {-}

 function _AddClear(P: Pl3Variant; Index: Long): Bool;
 begin
  if (f_ClearSuper.IndexOf(P^) = -1) then
   f_ClearSuper.Add(P^);
  Result := true;
 end;

begin
 if (P Is TevOptimizedContext) then
 begin
  if (TevOptimizedContext(P).f_ClearSuper <> nil) then
  begin
   if (f_ClearSuper = nil) then
    f_ClearSuper := Tk2SimpleTagList.Make;
   TevOptimizedContext(P).f_ClearSuper.IterateAllF(l3L2IA(@_AddClear));
  end;//(TevOptimizedContext(P).f_ClearSuper <> nil)
 end;//(P Is TevOptimizedContext)
 Result := inherited JoinWith(P);
end;

function TevOptimizedContext.GetEmpty: Bool;
  //override;
  {-}
begin
 Result := f_ClearSuper.Empty AND
           inherited GetEmpty;
end;

function TevOptimizedContext.DoUndo(const aProcessor: InevProcessor): Long;
  //override;
  {-���������� ��� �������� � ���������� �� ����������}
begin
 Result := inherited DoUndo(aProcessor);
 ClearSuper;
end;

function TevOptimizedContext.DoRedo(const aProcessor: InevProcessor): Long;
  //override;
  {-���������� ��� �������� � ���������� �� ����������}
begin
 Result := inherited DoRedo(aProcessor);
 ClearSuper;
end;

procedure TevOptimizedContext.ClearSuper;
  {-}

var
 O : OevClearSuper;

 function _Clear(P: Pl3Variant; Index: Long): Bool;
 begin
  O.Para := P^;
  O.Undo(nil);
  Result := true;
 end;

begin
 if (f_ClearSuper <> nil) then
 begin
  O := OevClearSuper.Create;
  try
   f_ClearSuper.IterateAllF(l3L2IA(@_Clear));
  finally
   l3Free(O);
  end;{try..finally}
 end;//f_ClearSuper <> nil
end;

end.

