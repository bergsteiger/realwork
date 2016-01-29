unit evDocumentsCache;
{* ��� ����������. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evDocumentsCache - }
{ �����: 28.09.2004 15:39 }
{ $Id: evDocumentsCache.pas,v 1.15 2015/03/16 16:40:00 lulin Exp $ }

// $Log: evDocumentsCache.pas,v $
// Revision 1.15  2015/03/16 16:40:00  lulin
// - ������ ���������� Service � ServiceImplementation.
//
// Revision 1.14  2015/03/12 15:32:45  lulin
// - ������������� �����.
//
// Revision 1.13  2014/04/30 11:23:54  lulin
// - ���������� �����������.
//
// Revision 1.12  2014/04/21 12:22:18  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.11  2014/04/04 17:53:38  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.10  2014/03/26 17:05:46  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.9  2014/03/26 15:51:58  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.8  2014/03/25 11:53:29  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.7  2014/03/04 13:16:53  lulin
// - ��������� �������������� Sub'�� � ��������� �� ���������� Enum'�.
//
// Revision 1.6  2014/02/13 16:13:13  lulin
// - ���������� �������� ������.
//
// Revision 1.5  2011/05/17 14:54:34  lulin
// {RequestLink:266409354}.
//
// Revision 1.4  2011/05/11 15:40:45  lulin
// {RequestLink:263293374}.
//
// Revision 1.3  2011/01/14 15:53:13  lulin
// {RequestLink:248195582}.
// - �������� ���������� ����������.
//
// Revision 1.2  2011/01/13 14:22:04  lulin
// {RequestLink:248195582}.
// - �������������� �������������� ��� ������������� ������ ��������.
//
// Revision 1.1  2009/09/14 11:28:04  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.57  2009/07/24 08:38:08  lulin
// {RequestLink:157910236}.
//
// Revision 1.56  2009/06/25 12:57:30  lulin
// - �������� �������� ��������.
//
// Revision 1.55  2009/04/07 16:09:41  lulin
// [$140837386]. �13.
//
// Revision 1.54  2008/08/27 14:26:10  lulin
// - ������� http://mdp.garant.ru/pages/viewpage.action?pageId=110986079&focusedCommentId=110986847#comment-110986847.
//
// Revision 1.53  2008/06/09 11:45:47  lulin
// - <K>: 93264011.
//
// Revision 1.52  2008/04/14 07:03:22  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.51  2008/04/02 17:03:24  lulin
// - <K>: 88641704.
//
// Revision 1.50  2008/03/26 14:44:21  lulin
// - <K>: 88080898.
//
// Revision 1.49  2008/03/26 11:36:55  lulin
// - �������� � ������ <K>: 88080898.
//
// Revision 1.48  2008/03/26 11:13:09  lulin
// - �������� � ������ <K>: 88080898.
//
// Revision 1.47  2008/03/20 13:22:22  lulin
// - <K>: 87590261.
//
// Revision 1.46  2008/03/19 14:23:33  lulin
// - cleanup.
//
// Revision 1.45  2008/02/06 09:55:21  lulin
// - ���������� ������� ������� ��������������� ���������.
//
// Revision 1.44  2008/02/05 09:57:37  lulin
// - �������� ������� ������� � ��������� ����� � ��������� �� �� ������.
//
// Revision 1.43  2008/02/04 08:51:23  lulin
// - ����� _Tl3InterfaceList ������� � ��������� ������.
//
// Revision 1.42  2007/12/25 15:18:46  mmorozov
// - change: ��� �������� �� ������������ � DesignTime (� ������ CQ: OIT5-27823);
//
// Revision 1.41  2007/12/19 10:55:21  mmorozov
// - ���������� ������ ���������� (CQ: OIT5-27823);
//
// Revision 1.40  2007/12/04 12:47:01  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.38.4.21  2007/09/14 13:26:05  lulin
// - ��������� � ������ B_Tag_Clean.
//
// Revision 1.38.4.20.2.2  2007/09/12 16:14:07  lulin
// - ����� �������� �������� ��-���������.
//
// Revision 1.38.4.20.2.1  2007/09/12 15:23:00  lulin
// - ����������� �� ������, ������������ ���������������� ��������� ��������.
//
// Revision 1.38.4.20  2007/02/09 14:51:12  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.38.4.19  2006/11/03 11:00:04  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.38.4.18.6.1  2006/10/13 11:15:43  lulin
// - ��������� � ������������ ��������� ������� ��-�����������.
//
// Revision 1.38.4.18  2006/08/02 10:51:52  lulin
// - ��������� � ������ � ������� ������� �� �����������.
//
// Revision 1.38.4.17.4.1  2006/07/26 11:07:14  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.38.4.17  2006/03/30 11:49:21  lulin
// - cleanup: �������� ��� ��� �������������� ������������ �� � ���� ������.
//
// Revision 1.38.4.16  2005/12/21 14:27:01  lulin
// - new behavior: ������� ������������� �������������� ������������ � ��������� ������ ������.
//
// Revision 1.38.4.15  2005/11/30 19:59:36  lulin
// - �������� ������������ ������ ���������������� ����� ������� View. ������������� ����� ��� - ���������, �.�. ������������ � ��������� � AV.
//
// Revision 1.38.4.14  2005/11/21 11:51:16  lulin
// - ������ ����� �� ������������� ������� ������������ � ������� �������� ����������.
//
// Revision 1.38.4.13  2005/09/23 16:03:54  lulin
// - ������� ������ � ������ ������������.
//
// Revision 1.38.4.12  2005/09/23 11:22:56  lulin
// - bug fix: ��-�� ������������ �������� �� ���������� ����������� ��������������� ��������� �����������.
//
// Revision 1.38.4.11  2005/09/07 11:09:22  lulin
// - new method: _InevAnchorModify._AssignAnchor.
//
// Revision 1.38.4.10  2005/07/27 12:31:17  lulin
// - ��� ���������� ������ ���������� ������ ������������, � �� ��������� ������.
//
// Revision 1.38.4.9  2005/07/27 11:53:15  lulin
// - ��� ���������� ������ ��������� ��������� �� ��������� ���������� � ������ �� ����� ��� ��� ����������.
//
// Revision 1.38.4.8  2005/07/27 11:17:22  lulin
// - ��� ���������� ������ �������� ����������� ������ � ����������� ���������� ���������, � �� � ��� �����������.
//
// Revision 1.38.4.7  2005/07/21 08:58:43  lulin
// - ��� ���������� ����������� �������� ��������� �� ����������.
//
// Revision 1.38.4.6  2005/07/19 12:50:06  lulin
// - ����� ������� ����������� ��������� � ������ nevTools.
//
// Revision 1.38.4.5  2005/07/07 13:09:27  lulin
// - ����������� �������� �����������.
//
// Revision 1.38.4.4  2005/06/06 15:36:08  lulin
// - ���������� �������� �� ������� � ������� ���������� ��������.
//
// Revision 1.38.4.3  2005/06/02 12:33:07  lulin
// - ������ ������� ������ �������� ����� ��������� �� ��� ��������� �� �������.
//
// Revision 1.38.4.2  2005/06/01 16:22:24  lulin
// - remove unit: evIntf.
//
// Revision 1.38.4.1  2005/05/18 12:42:46  lulin
// - ����� ����� �����.
//
// Revision 1.36.2.2  2005/05/18 12:32:08  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.36.2.1  2005/04/28 09:18:28  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.37.2.2  2005/04/26 14:30:38  lulin
// - �������� l3Free � _l3Use.
//
// Revision 1.37.2.1  2005/04/23 16:07:24  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.37  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.38  2005/04/28 15:03:37  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.37.2.2  2005/04/26 14:30:38  lulin
// - �������� l3Free � _l3Use.
//
// Revision 1.37.2.1  2005/04/23 16:07:24  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.37  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.36  2005/04/04 06:43:57  lulin
// - � ����� � ���������� ��������� ������� � ������ ���������� K-2, ������� ���������� "��������" ��������� � ���������/������������ ������� �����.
//
// Revision 1.35  2005/03/28 11:32:07  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.34  2005/03/19 16:39:51  lulin
// - �������� �������� ������.
//
// Revision 1.33  2005/03/11 15:48:57  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.32  2005/02/03 12:51:11  lulin
// - bug fix: �� �������������� ����������.
//
// Revision 1.31  2005/01/27 10:00:50  lulin
// - new behavior: ��� ����������� � ���������� Sub'� ������������� ParaID = 0 ��� ������ ��������� (CQ OIT5-11120).
//
// Revision 1.30  2005/01/26 12:33:28  lulin
// - � ����������� � ���������� Sub'� ��������� ��������� ������.
//
// Revision 1.29  2004/10/14 08:54:57  lulin
// - new behavior: ������ ����������� ���������������� ����� ���������� ������.
//
// Revision 1.28  2004/10/13 16:43:06  lulin
// - new method: TevDocumentContainer.AddUserComment (���� ������ �� ������). _TevDocumentsCache.NotifyUserCommentAdded ������ �������� ���.
//
// Revision 1.27  2004/10/13 16:22:33  lulin
// - new method: _TevDocumentsCache.NotifyUserCommentAdded - ���� ������ �� ������.
//
// Revision 1.26  2004/10/12 17:48:53  lulin
// - new method: TevDocumentContainer.DeleteUserComment.
//
// Revision 1.25  2004/10/12 17:45:38  lulin
// - ����������-�������� ��� _TevDocumentsCache.NotifyUserCommentDeleted.
//
// Revision 1.24  2004/10/12 17:44:43  lulin
// - ����������-�������� ��� _TevDocumentsCache.NotifyUserCommentDeleted.
//
// Revision 1.23  2004/10/12 17:39:33  lulin
// - new param: � ����� _TevDocumentsCache.NotifyUserCommentDeleted ������ �������� ���������.
//
// Revision 1.22  2004/10/12 17:31:53  lulin
// - �������� �����������.
//
// Revision 1.21  2004/10/12 17:29:27  lulin
// - new method version: _TevDocumentsCache._NotifySubDeleted.
//
// Revision 1.20  2004/10/12 17:22:51  lulin
// - new method version: _TevDocumentsCache._NotifySubAdded(
// const aTextSource : IUnknown;
// const aParaID     : Integer;
// const aSubID      : Integer;
// aLayerID          : Long;
// aSubName          : PChar) (CQOIT5-10222).
//
// Revision 1.19  2004/10/11 16:28:55  lulin
// - new method: _TevDocumentsCache.NotifyUserCommentDeleted - ���� ������ �� ������, ������ ����������.
//
// Revision 1.18  2004/10/11 10:42:48  lulin
// - cleanup.
//
// Revision 1.17  2004/10/11 10:22:11  lulin
// - new behavior: ������� ������������� �������� �������� �� ��������� � ������ �����.
//
// Revision 1.16  2004/10/11 09:29:05  lulin
// - new behavior: ������� ������������� ��������� �������� �� �������� � ������ �����.
//
// Revision 1.15  2004/10/11 08:14:25  lulin
// - new class: _TevDocumentsCache.
//
// Revision 1.14  2004/10/11 07:34:10  lulin
// - new proc: evIterateDocumentsCacheF.
//
// Revision 1.13  2004/10/08 13:28:10  lulin
// - new behavior: �������� ��������� �� ���� �� ����.
//
// Revision 1.12  2004/10/08 11:30:20  lulin
// - new var: _g_evDocumentsCacheLimit.
//
// Revision 1.11  2004/10/04 16:27:55  lulin
// - ������ ���������� �������� �� ������������ ������ (TextSource).
// - bug fix: "�������" ���������� � ������� ��� ������� �������� �� ������ ����������.
//
// Revision 1.10  2004/10/04 15:27:27  lulin
// - ����� ����������� �������.
//
// Revision 1.8  2004/10/01 12:24:59  lulin
// - bug fix: ������������� ��������� �������� � ��� - � ���������� ����� ���������� "�����" �������. ������ ����� ��������� ��������� �� ���� (9995).
//
// Revision 1.7  2004/09/30 09:19:13  lulin
// - ������� ������� ���� ���������� �� ��������.
//
// Revision 1.6  2004/09/29 12:50:50  lulin
// - new var: g_evDocumentsCacheEnabled.
//
// Revision 1.5  2004/09/29 12:37:44  lulin
// - new behavior: ������ � ���� ���������� ������� ���������� ���������� � ����.
//
// Revision 1.4  2004/09/29 10:49:12  lulin
// - new behavior: ���� ���������� �������� ������������ �������� �� ����, �� �������� ��� ���������� (�� ��������� � �������).
//
// Revision 1.3  2004/09/29 09:48:16  lulin
// - bug fix: ��� ���������� DocumentContainer := nil ������ ���������� �������� � ������ � �������������� ��� ���������� ������ DocumentContainer'� ��� �� ����������������. � ���������� ����� �����, ������� ����������� � ��� ������������ �������� �� �������������.
//
// Revision 1.2  2004/09/28 17:21:56  lulin
// - � ������ ����������� ������ ��� ����������. ���� ��� ��������� ���������� �� ����.
//
// Revision 1.1  2004/09/28 12:30:35  lulin
// - new unit: evDocumentsCache.
//

{$Include evDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3Types,
  l3Base,
  l3Variant,

  afwInterfaces,

  k2Interfaces,

  nevBase,
  nevTools,
  nevDocumentContainerList,
  evDocumentsCachePrim
  ;

type
  TevDocumentsCache = class(TevDocumentsCachePrim)
   {* ��� ����������. }
    public
    // public methods
      class procedure AddDocument(const aContainer: InevDocumentContainer);
        {-}
      class procedure RemoveDocument(const aContainer: InevDocumentContainer);
        {-}
      class function  GetDocumentLike(const aContainer : InevDocumentContainer): InevDocumentContainer;
        {-}
      class procedure IterateF(anAction: Tl3IteratorAction);
        {-}
      class function  Count: Long;
        {-}
      class procedure Clear;
        reintroduce;
        {-}
      class procedure NotifySubAdded(const aContainer : InevDocumentContainer;
                                     aPara      : Tl3Variant;
                                     aSub       : Tl3Variant;
                                     aLayerID         : Long);
        overload;
        {-}
      class procedure NotifySubAdded(const aTextSource : IUnknown;
                                     aParaID           : Integer;
                                     aSubID            : Integer;
                                     aLayerID          : Integer;
                                     const aSubName    : Tl3WString;
                                     aFlags            : Integer);
        overload;
        {* - ��� ������������� ���� �� �������� ����������� ����������. �������� - �������. }
      class procedure NotifySubDeleted(const aContainer : InevDocumentContainer;
                                       const aSub       : IevSub);
        overload;
        {-}
      class procedure NotifySubDeleted(const aTextSource : IUnknown;
                                       aSubID            : Integer;
                                       aLayerID          : Integer);
        overload;
        {* - ��� ������������� ���� �� �������� ����������� ����������. �������� - �������. }
  end;//TevDocumentsCache

var
 g_evDocumentsCacheEnabled : Boolean = true;
 g_evDocumentsCacheLimit : Integer = High(Integer);

implementation

uses
  SysUtils,
  
  l3String,
  l3InterfacesMisc,
  l3Memory,

  afwFacade,
  
  k2Facade,
  k2Tags,
  k2Const,

  evdTypes,
  evdStyles,

  evParaTools
  ;


// start class TevDocumentsCache

class procedure TevDocumentsCache.Clear;
begin
 if TnevDocumentContainerList.Exists then
  TnevDocumentContainerList.Instance.Clear;
end;

var
 g_InNotifyAdded : Boolean = false;

class procedure TevDocumentsCache.NotifySubAdded(const aContainer : InevDocumentContainer;
                                                 aPara      : Tl3Variant;
                                                 aSub       : Tl3Variant;
                                                 aLayerID         : Long);
  {-}

var
 l_ParaID : Long;

 function DoContainer(aDoc: PIUnknown; anIndex: Integer): Boolean;
 begin//DoContainer
  Result := true;
  if (not l3IEQ(InevDocumentContainer(aDoc^), aContainer)) AND
     InevDocumentContainer(aDoc^).IsSameText(aContainer) then
  begin
   // - ��� "��� �� ����� �����" - ���� � � ���� �������� ���������
   if InevDocumentContainer(aDoc^).HasDocument then
    InevDocumentContainer(aDoc^).NotifySubAdded(l_ParaID,
                                                aSub.IntA[k2_tiHandle],
                                                aLayerID,
                                                aSub.PCharLenA[k2_tiShortName],
                                                aSub.IntA[k2_tiFlags])
   else
    RemoveDocument(InevDocumentContainer(aDoc^));
  end;//aDoc^ <> aContainer
 end;//DoContainer

begin
 if (aLayerID = Ord(ev_sbtMark)) then
  Exit;
  // - ��� ����� �� ������� "������" � ����������, �.� ����������� ���������������� ����
 if not g_InNotifyAdded then
 begin
  g_InNotifyAdded := true;
  try
   l_ParaID := aPara.IntA[k2_tiHandle];
   if (l_ParaID = 0) then
    Exit;
   IterateF(l3L2IA(@DoContainer));
  finally
   g_InNotifyAdded := false;
  end;//try..finally
 end;//not g_InNotifyAdded
end;

class procedure TevDocumentsCache.NotifySubAdded(const aTextSource : IUnknown;
                                                 aParaID           : Integer;
                                                 aSubID            : Integer;
                                                 aLayerID          : Integer;
                                                 const aSubName    : Tl3WString;
                                                 aFlags            : Integer);
  //overload;
  {-}

 function DoContainer(aDoc: PIUnknown; anIndex: Integer): Boolean;
 var
  l_Document : InevParaList;
  l_Para     : InevObject;
 begin//DoContainer
  Result := true;
  if InevDocumentContainer(aDoc^).IsSameText(aTextSource) then
  begin
   // - ��� "��� �� ����� �����" - ���� � � ���� �������� ���������
   if InevDocumentContainer(aDoc^).HasDocument then
    InevDocumentContainer(aDoc^).NotifySubAdded(aParaID, aSubID, aLayerID, aSubName, aFlags)
   else
    RemoveDocument(InevDocumentContainer(aDoc^));
  end;//aDoc^ <> aContainer
 end;//DoContainer

begin
 if (aLayerID = Ord(ev_sbtMark)) then
  Exit;
  // - ��� ����� �� ������� "������" � ����������, �.� ����������� ���������������� ����
 if (aParaID >= 0) AND not g_InNotifyAdded then
 begin
  g_InNotifyAdded := true;
  try
   IterateF(l3L2IA(@DoContainer));
  finally
   g_InNotifyAdded := false;
  end;//try..finally
 end;//not g_InNotifyAdded
end;

var
 g_InNotifyDeleted : Boolean = false;

class procedure TevDocumentsCache.NotifySubDeleted(const aContainer : InevDocumentContainer;
                                                   const aSub       : IevSub);
  {-}

 function DoContainer(aDoc: PIUnknown; anIndex: Integer): Boolean;
 begin//DoContainer
  Result := true;
  if (not l3IEQ(InevDocumentContainer(aDoc^), aContainer)) AND
     InevDocumentContainer(aDoc^).IsSameText(aContainer) then
  begin
   // - ��� "��� �� ����� �����" - ���� � �� ���� �������� �������
   if InevDocumentContainer(aDoc^).HasDocument then
    InevDocumentContainer(aDoc^).SubList.SubEx[aSub.ID, aSub.LayerID].Delete(nil)
   else
    RemoveDocument(InevDocumentContainer(aDoc^));
  end;//aDoc^ <> aContainer
 end;//DoContainer
     
begin
 if (aSub.LayerID = Ord(ev_sbtMark)) then
  Exit;
  // - �.� ����������� ���������������� ����
 if not g_InNotifyDeleted AND
    not g_InNotifyAdded
    // - � �������� ���������� Sub'� ��� ����� ��������� - �� ���� ��������������
    //   �� ����.
    then
 begin
  g_InNotifyDeleted := true;
  try
   IterateF(l3L2IA(@DoContainer));
  finally
   g_InNotifyDeleted := false;
  end;//try..finally
 end;//not g_InNotifyDeleted
end;

class procedure TevDocumentsCache.NotifySubDeleted(const aTextSource : IUnknown;
                                                   aSubID            : Integer;
                                                   aLayerID          : Integer);
  //overload;
  {-}

 function DoContainer(aDoc: PIUnknown; anIndex: Integer): Boolean;
 var
  l_Sub  : IevSub;
  l_Para : InevObject;
  l_ST   : Tl3Variant;
 begin//DoContainer
  Result := true;
  if InevDocumentContainer(aDoc^).IsSameText(aTextSource) then
  begin
   // - ��� "��� �� ����� �����" - ���� � �� ���� �������� �������
   if InevDocumentContainer(aDoc^).HasDocument then
   begin
    l_Sub := InevDocumentContainer(aDoc^).SubList.SubEx[aSubID, aLayerID];
    if not l_Sub.Exists then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=263293374
    begin
     if (aSubID = 0) AND (aLayerID = Ord(ev_sbtBookmark)) then
     // http://mdp.garant.ru/pages/viewpage.action?pageId=263293374
     begin
      if not InevDocumentContainer(aDoc^).FindObjByID(0, l_Para) then
       Exit;
      if (l_Para.AsObject.IntA[k2_tiStyle] = ev_saTechComment) then
      begin
       l_Para := evFindNumberedPara(l_Para, true);
       if (l_Para = nil) then
        Exit;
      end;//aParaID = 0
      l_ST := l_Para.AsObject.rAtomEx([k2_tiSubs,
                              k2_tiChildren, k2_tiHandle, aLayerID,
                              k2_tiChildren, k2_tiByIndex, 0]);
      if l_ST.IsValid then
      begin
       l_Sub := InevDocumentContainer(aDoc^).SubList.SubEx[l_ST.IntA[k2_tiHandle], aLayerID];
       l_Sub.Delete(nil);
      end;//l_ST.IsValid
     end;//aSubID = 0
    end//not l_Sub.Exists
    else
     l_Sub.Delete(nil);
   end//InevDocumentContainer(aDoc^).HasDocument
   else
    RemoveDocument(InevDocumentContainer(aDoc^));
  end;//aDoc^ <> aContainer
 end;//DoContainer
     
begin
 if (aLayerID = Ord(ev_sbtMark)) then
  Exit;
  // - �.� ����������� ���������������� ����
 if not g_InNotifyDeleted AND
    not g_InNotifyAdded
    // - � �������� ���������� Sub'� ��� ����� ��������� - �� ���� ��������������
    //   �� ����.
    then
 begin
  g_InNotifyDeleted := true;
  try
   IterateF(l3L2IA(@DoContainer));
  finally
   g_InNotifyDeleted := false;
  end;//try..finally
 end;//not g_InNotifyDeleted
end;

class procedure TevDocumentsCache.AddDocument(const aContainer: InevDocumentContainer);
  {-}
var
 l_Index         : Integer;
 l_DocumentsList : TnevDocumentContainerList;
begin
 if g_evDocumentsCacheEnabled then
 begin
  l_DocumentsList := TnevDocumentContainerList.Instance;
  if (l_DocumentsList <> nil) then
   if (l_DocumentsList.IndexOf(aContainer) < 0) then
   begin
    l_DocumentsList.Add(aContainer);
    l_Index := 0;
    while (l_DocumentsList.Count - l_Index > g_evDocumentsCacheLimit) do
     l_DocumentsList.Delete(l_Index);
   end;//l_DocumentsList.IndexOf(aContainer) < 0
 end;//g_evDocumentsCacheEnabled
end;

class procedure TevDocumentsCache.RemoveDocument(const aContainer: InevDocumentContainer);
  {-}
begin
 if TnevDocumentContainerList.Exists then
  TnevDocumentContainerList.Instance.Remove(aContainer);
end;

class function TevDocumentsCache.GetDocumentLike(const aContainer : InevDocumentContainer): InevDocumentContainer;
  {-}

 function CheckDocument(aDoc: PIUnknown; anIndex: Integer): Boolean;
 begin
  if aContainer.IsSame(InevDocumentContainer(aDoc^)) then
  begin
   GetDocumentLike := InevDocumentContainer(aDoc^);
   // - �����
   Result := false;
   // - �������
  end//aContainer.IsSame(InevDocumentContainer(aDoc^))
  else
   Result := true;
 end;

begin
 Result := nil;
 if g_evDocumentsCacheEnabled AND (aContainer <> nil) then
  IterateF(l3L2IA(@CheckDocument));
end;

class procedure TevDocumentsCache.IterateF(anAction: Tl3IteratorAction);
  {-}
begin
 try
  if TnevDocumentContainerList.Exists then
   TnevDocumentContainerList.Instance.IterateAll(anAction);
 finally
  l3FreeIA(anAction);
 end;//try..finally
end;

class function TevDocumentsCache.Count: Long;
  {-}
var
 l_DocumentsList : TnevDocumentContainerList;
begin
 if TnevDocumentContainerList.Exists then
  Result := TnevDocumentContainerList.Instance.Count
 else
  Result := 0;
end;

end.

