unit evSubNode;

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evSubNode -     }
{ �����: 04.05.2000 10:18 }
{ $Id: evSubNode.pas,v 1.13 2015/01/28 12:06:46 kostitsin Exp $ }

// $Log: evSubNode.pas,v $
// Revision 1.13  2015/01/28 12:06:46  kostitsin
// ������ Tl3PrimNode
//
// Revision 1.12  2015/01/19 18:36:38  lulin
// {RequestLink:580710025}
//
// Revision 1.11  2014/04/21 12:56:51  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.10  2014/04/07 17:57:03  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.9  2014/04/04 17:53:38  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.8  2014/04/03 17:10:26  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.7  2014/03/28 12:15:27  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.6  2014/03/18 15:57:02  lulin
// - ������������� ������ � ������.
//
// Revision 1.5  2014/03/04 13:16:53  lulin
// - ��������� �������������� Sub'�� � ��������� �� ���������� Enum'�.
//
// Revision 1.4  2013/10/21 15:43:02  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.3  2013/10/21 10:30:46  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.2  2010/03/02 13:34:40  lulin
// {RequestLink:193823544}.
//
// Revision 1.1  2009/09/14 11:28:04  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.48  2009/07/23 08:14:39  lulin
// - �������� �������� ������������� ���������� ��������.
//
// Revision 1.47  2009/06/25 12:57:30  lulin
// - �������� �������� ��������.
//
// Revision 1.46  2009/06/02 11:23:06  lulin
// - ����������� �� ������������� ������.
//
// Revision 1.45  2009/04/16 15:55:28  lulin
// [$143396720]. �5. ������� ������ � ��������� ��������.
//
// Revision 1.44  2009/04/07 16:09:41  lulin
// [$140837386]. �13.
//
// Revision 1.43  2009/03/04 13:32:47  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.42  2008/12/12 19:19:14  lulin
// - <K>: 129762414.
//
// Revision 1.41  2008/10/09 13:37:34  lulin
// - <K>: 121145547.
//
// Revision 1.40  2008/06/09 11:45:47  lulin
// - <K>: 93264011.
//
// Revision 1.39  2008/04/14 07:03:22  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.38  2008/04/01 17:07:05  lulin
// - ��������� ��������� ��������� �� ������.
//
// Revision 1.37  2008/02/05 18:55:07  lulin
// - ��������� �������� ������������� ����� ������.
//
// Revision 1.36  2008/02/05 18:20:34  lulin
// - ������� �������� �������� �����.
//
// Revision 1.35  2008/02/05 12:49:10  lulin
// - �������� ������� �������.
//
// Revision 1.34  2007/12/13 14:31:30  lulin
// - ������� �������� ����.
//
// Revision 1.33  2007/12/05 16:00:14  lulin
// - cleanup.
//
// Revision 1.32  2007/12/04 12:47:05  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.27.4.14  2007/09/14 13:26:06  lulin
// - ��������� � ������ B_Tag_Clean.
//
// Revision 1.27.4.13.2.1  2007/09/12 15:23:02  lulin
// - ����������� �� ������, ������������ ���������������� ��������� ��������.
//
// Revision 1.27.4.13  2007/02/28 17:00:07  lulin
// - ���������� ������������ ���������� ��������� �����.
//
// Revision 1.27.4.12  2007/01/30 15:24:12  lulin
// - ����� ���� - ������ ����� �������� ����.
//
// Revision 1.27.4.11  2007/01/24 10:21:42  oman
// - new: ����������� ��������� - ev (cq24078)
//
// Revision 1.27.4.10  2006/12/25 10:20:25  lulin
// - ��������� ������ ������ �������� ����� �������, � �� �����.
//
// Revision 1.27.4.9  2006/04/20 14:31:24  lulin
// - ����������� �����.
// - ������ ����� ��������� �������������� �������.
//
// Revision 1.27.4.8  2006/02/07 10:50:47  lulin
// - bug fix: �� ������ ����� ����������������� � ����������� (CQ OIT5-19497).
//
// Revision 1.27.4.7  2005/11/09 15:28:25  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.27.4.6  2005/09/06 13:25:47  lulin
// - bug fix: �� ���������� �� ��������� �� ����������.
//
// Revision 1.27.4.5  2005/07/21 17:15:27  lulin
// - bug fix: ����� assert - �.�. �� ��� �� ����� - ��������� �������� ����� �� ����, ���� �������� ������� �� ������.
//
// Revision 1.27.4.4  2005/07/20 11:49:52  lulin
// - bug fix: ��� AV ��� ������� ��������� � Sub'� ����, ������� ��� ������� �� ���������.
//
// Revision 1.27.4.3  2005/07/19 17:23:47  lulin
// - ����� ��������� ������ � ������ Sub'�� ��������� - ������ �� ���������� ��������������� �� ���������.
//
// Revision 1.27.4.2  2005/07/19 12:50:06  lulin
// - ����� ������� ����������� ��������� � ������ nevTools.
//
// Revision 1.27.4.1  2005/05/18 12:42:47  lulin
// - ����� ����� �����.
//
// Revision 1.23.2.5  2005/05/18 12:32:10  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.23.2.4  2005/04/28 09:18:30  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.23.2.3  2005/04/15 12:11:48  lulin
// - bug fix: �� ��������������� � ��������.
//
// Revision 1.23.2.2  2005/04/15 07:35:28  lulin
// - ������ ������ �� _Box, � �� �� ��� ���.
//
// Revision 1.23.2.1  2005/04/11 13:55:48  lulin
// - ���� � HEAD.
//
// Revision 1.24  2005/04/11 13:50:38  fireton
// - bug fix: �� ������������ ����� ������ ����
//
// Revision 1.26.2.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� _Ik2Tag.
//
// Revision 1.26  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.25  2005/04/15 08:59:52  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.24  2005/04/11 13:50:38  fireton
// - bug fix: �� ������������ ����� ������ ����
//
// Revision 1.27  2005/04/28 15:03:38  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.26.2.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� _Ik2Tag.
//
// Revision 1.26  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.25  2005/04/15 08:59:52  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.24  2005/04/11 13:50:38  fireton
// - bug fix: �� ������������ ����� ������ ����
//
// Revision 1.23  2005/03/28 11:32:08  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.22  2005/03/23 11:23:16  lulin
// - bug fix: �� ���������������.
//
// Revision 1.21  2005/03/23 11:16:29  lulin
// - ������� �������� ����������.
//
// Revision 1.20  2005/03/22 07:54:49  lulin
// - remove method: Tk2AtomR.AsIUnknown.
//
// Revision 1.19  2005/03/19 16:39:51  lulin
// - �������� �������� ������.
//
// Revision 1.18  2005/03/11 14:21:23  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.17  2005/01/20 17:49:17  lulin
// - bug fix: ��������� �� ��������� ����, ��� �� �������� � ����������.
//
// Revision 1.16  2004/11/11 17:35:22  lulin
// - new behavior: ��� ����� � ������������ ������� ���������� ���������� � ��������� ���������� �� �����.
//
// Revision 1.15  2004/09/20 12:42:50  lulin
// - ����������� - ����� ����������� ����� �������� � ���, ����� �������� �� (�� ������ ����������) ��������� � 3.5 ��� �� 2.6 ���.
//
// Revision 1.14  2004/09/09 12:14:56  lulin
// - ������� ���������������� ���������� ���������� (�� ���� �� �����).
//
// Revision 1.13  2004/08/09 14:03:02  law
// - bug fix: �������� ������������ �� ������� "����������" (CQ OIT5-8642).
//
// Revision 1.12  2004/08/05 16:58:17  law
// - new behavior: ��� �������� � ���������� ������ ����� ��������� ������� "����������" (CQ OIT5-8572).
// - ��������� �� ���� Warning'�� � Hint'��.
//
// Revision 1.11  2004/07/01 11:00:59  law
// - bug fix: ��������� ��� ������� ����������� (CQ OIT5-6505).
//
// Revision 1.10  2003/11/05 16:57:36  law
// - new behavior: ��������� �������� � ���������� (������ ��� ���� ����, � ����� ���� ������ ���������� ��� ���������� �� ��������).
//
// Revision 1.9  2003/09/09 12:43:38  law
// - new method: _TevNode.Make, _TevSubNode.Make.
//
// Revision 1.8  2002/09/02 12:59:49  law
// - new behavior: �������� �����/����� �� Del �� �������� ����.
//
// Revision 1.7  2002/07/29 12:11:53  law
// - new param: anOpProc.
//
// Revision 1.6  2001/09/20 12:37:22  law
// - new behavior: ������� ����������� ���� ������, � ����� ��������� ��� �� ��������/��������.
//
// Revision 1.5  2001/02/28 13:16:27  law
// - ����������� ������������ Il3Node.Text ��� _TevNode.
//
// Revision 1.4  2001/02/22 16:16:57  law
// - ������� ���������� ������ Sub'�� � �� ������.
//
// Revision 1.3  2000/12/15 15:10:38  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3IID,
  l3Types,
  l3Tree_TLB,
  l3Base,
  l3Variant,

  k2Interfaces,
  k2InternalInterfaces,
  
  evNode
  ;

type
  TevNodePrim = class(TevCustomNode)
    protected
    // internal methods
      function  pm_GetName: Tl3PrimString;
        virtual;
        {-}
      function  GetAsPCharLen: Tl3PCharLenPrim;
        override;
        {-}
      procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
        override;
        {-}
      function  GetLayerID: Long;
        virtual;
        {-}
    public
    // public methods
      procedure DoDelete;
        override;
        {-}
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
  end;//TevNodePrim

  TevNode = class(TevNodePrim)
  end;//TevNode

  TevSubNode = class(TevNode)
    private
    // internal fields
      f_Para    : Tl3Tag;
      f_LayerID : Long;
    protected
    // internal methods
      function  pm_GetName: Tl3PrimString;
        override;
        {-}
      function  pm_GetDocument: Tl3Variant;
        override;
        {-}
    protected
    // property methods
      procedure Cleanup;
        override;
        {-}
      function  GetLayerID: Long;
        override;
        {-}
    public
    // public methods
      constructor Create(aTagWrap : Tl3Variant;
                         aPara    : Tl3Variant;
                         aLayerID       : Long);
        reintroduce;
        {-}
      class function Make(aTagWrap : Tl3Variant;
                          aPara    : Tl3Variant;
                          aLayerID       : Long): Il3Node;
        reintroduce;
        {-}
    public
    // public properties
      property Para: Tl3Tag
        read f_Para{
        write f_Para};
        {-}
  end;//TevSubNode

implementation

uses
  SysUtils,
  
  l3Const,
  l3String,

  evdTypes,
  
  k2Except,
  k2Tags,

  evInternalInterfaces,
  evDocumentPart,

  nevTools,
  nevInterfaces,

  Block_Const,
  Sub_Const,
  Document_Const
  ;

// start class TevNodePrim 

function TevNodePrim.pm_GetName: Tl3PrimString;
  {override;}
  {-}
var
 l_Obj : Tl3Variant;
begin
 l_Obj := Tag;
 if (l_Obj = nil) then
  Result := nil
 else
  Result := evGetBlockName(l_Obj);
end;

function TevNodePrim.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 Result := pm_GetName.AsWStr;
end;

procedure TevNodePrim.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
var
 l_Sub : IevSub;
begin
 if l3IOk(QueryInterface(IevSub, l_Sub)) then
  try
   l_Sub.Name := Value;
  finally
   l_Sub := nil;
  end;//try..finally
end;

function TevNodePrim.GetLayerID: Long;
  //virtual;
  {-}
begin
 with Tag do
  if IsKindOf(k2_typBlock) then
   Result := rLong(k2_tiLayerID, Ord(ev_sbtSub))
  else
   Result := Ord(ev_sbtSub);
end;

function TevNodePrim.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  {override;}
  {-}
var
 l_Tag      : Tl3Variant;
 l_Document : InevPara;
 l_SubList  : InevSubList;
 l_Sub      : IevSub;
begin
 Result.SetNoInterface;
 if IID.EQ(IevSub) then
 begin
  l_Tag := Tag;
  if l_Tag.IsKindOf(k2_typBlock) then
  begin
   if Document.QT(InevPara, l_Document) then
   begin
    if (l_Document <> nil) then
    begin
     l_SubList := l_Document.MainSubList;
     if (l_SubList <> nil) then
      try
       with l_Tag.Attr[k2_tiHandle] do
        if IsValid then begin
         IevSub(Obj) := l_SubList.BlockEx[AsLong, GetLayerID];
         if (IevSub(Obj) <> nil) then begin
          Result.SetOk;
          Exit;
         end;{IevSub(Obj) <> nil}
        end;{IsValid}
      finally
       l_SubList := nil;
      end;{try..finally}
    end;//l_Document <> nil
   end
   else
    Result.SetNoInterface;
  end//..k2_idBlock..
  else
  if l_Tag.IsKindOf(k2_typSub) then
  begin
   if Document.QT(InevPara, l_Document) then
   begin
    if (l_Document <> nil) then
    begin
     l_SubList := l_Document.MainSubList;
     if (l_SubList <> nil) then
      try
       with l_Tag.Attr[k2_tiHandle] do
        if IsValid then begin
         IevSub(Obj) := l_SubList.SubEx[AsLong, GetLayerID];
         if (IevSub(Obj) <> nil) then
         begin
          Result.SetOk;
          Exit;
         end;{IevSub(Obj) <> nil}
        end;{IsValid}
      finally
       l_SubList := nil;
      end;{try..finally}
    end;//l_Document <> nil
   end
   else
    Result.SetNoInterface; 
  end;//..k2_idSub..
 end//..IevSub..
 else
 if IID.EQ(IevDocumentPart) then
 begin
  if l3IOk(QueryInterface(IevSub, l_Sub)) then
   try
    Result := Tl3HResult_C(l_Sub.QueryInterface(IevDocumentPart, Obj));
    Exit;
   finally
    l_Sub := nil;
   end;{try..finally}
  {IevDocumentPart}
 end;
 Result := inherited COMQueryInterface(IID, Obj);
end;

procedure TevNodePrim.DoDelete;
  //override;
  {-}
var
 l_Sub : IevSub;
begin
 if l3IOk(QueryInterface(IevSub, l_Sub)) then
  try
   l_Sub.Delete(nil);
  finally
   l_Sub := nil;
  end;//try..finally
 inherited DoDelete;
end;

{ start class TevSubNode }

constructor TevSubNode.Create(aTagWrap : Tl3Variant;
                              aPara    : Tl3Variant;
                              aLayerID       : Long);
  {reintroduce;}
  {-}
begin
 inherited Create(aTagWrap);
 aPara.SetRef(f_Para);
 f_LayerID := aLayerID;
end;

class function TevSubNode.Make(aTagWrap : Tl3Variant;
                               aPara    : Tl3Variant;
                               aLayerID       : Long): Il3Node;
  {-}
var
 l_Node : TevSubNode;
begin
 l_Node := Create(aTagWrap, aPara, aLayerID);
 try
  Result := l_Node;
 finally
  l3Free(l_Node);
 end;//try..finally
end;

procedure TevSubNode.Cleanup;
  {override;}
  {-}
begin
 FreeAndNil(f_Para);
 inherited;
end;

function TevSubNode.GetLayerID: Long;
  //override;
  {-}
begin
 Result := f_LayerID;
end;

function TevSubNode.pm_GetName: Tl3PrimString;
  {override;}
  {-}
begin
 Result := inherited pm_GetName;
 if (Result = nil) AND (f_Para <> nil) then
 begin
  with f_Para.Attr[k2_tiText] do
   if IsValid then
    Result := AsObject As Tl3CustomString;
 end;//Result = nil
end;

function TevSubNode.pm_GetDocument: Tl3Variant;
  //override;
  {-}
var  
 l_Tag : Tl3Variant;
begin
 Result := inherited pm_GetDocument;
 if not Result.IsValid then
 begin
  l_Tag := Para;
  while l_Tag.IsValid do
  begin
   if l_Tag.IsKindOf(k2_typDocument) then
   begin
    Result := l_Tag.Box;
    Exit;
   end;//..k2_idDocument..
   l_Tag := l_Tag.Owner;
  end;//while l_Tag.IsValid
 end;//Result = nil
end;

end.

