unit vcmUserTypesCollectionItem;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcm -           }
{ �����: 25.07.2003 14:49 }
{ $Id: vcmUserTypesCollectionItem.pas,v 1.28 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmUserTypesCollectionItem.pas,v $
// Revision 1.28  2015/06/03 12:26:27  lulin
// - �������� ��������� �����������.
//
// Revision 1.27  2012/07/17 11:12:09  lulin
// {RequestLink:378541134}
//
// Revision 1.26  2010/06/01 18:52:04  lulin
// {RequestLink:215549303}.
// - �������� �������� ���.
//
// Revision 1.25  2010/05/31 18:16:09  lulin
// {RequestLink:215549303}.
// - �������� ������ ����������� ������.
//
// Revision 1.24  2010/05/25 10:02:41  lulin
// {RequestLink:215548392}.
//
// Revision 1.23  2010/05/24 14:55:36  lulin
// {RequestLink:215548392}.
//
// Revision 1.22  2010/04/27 18:02:24  lulin
// {RequestLink:159352361}.
// - ������� ����������� �������� ����� ��������� �� ������.
//
// Revision 1.21  2008/05/29 12:26:54  mmorozov
// - new: ����������� ���������� �� ������ ���� ������������ ������ ������������ (CQ: OIT5-28281).
//
// Revision 1.20  2006/11/03 11:00:32  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.19.6.2  2006/10/19 08:53:09  lulin
// - ���������� ����� ���������������� ����� ��� ������� ���������.
//
// Revision 1.19.6.1  2006/10/18 08:00:31  lulin
// - ��������� ��� �������� �������� ����� ��������.
//
// Revision 1.19  2006/03/15 13:10:03  lulin
// - bug fix: �������� ������� �������� UserType'��.
//
// Revision 1.18  2006/03/15 12:34:39  lulin
// - bug fix: �� ������ ��������� ���������� ��������� UserType'�.
//
// Revision 1.17  2006/03/15 12:27:21  lulin
// - cleanup.
//
// Revision 1.16  2006/03/14 13:55:52  lulin
// - ���������� �������� UserType'�� �� StdRes'�.
//
// Revision 1.15  2006/03/14 13:04:52  lulin
// - ��������� UserType'� � ����������� � � ������.
//
// Revision 1.14  2006/02/07 15:47:25  mmorozov
// - new: ��� UserType-� ����� ����� �������� ����������� � Run-Time-� ��� ������������� ����� ������������� � PageControl-�;
// - ����������� ElPgCtl: �������� ��������� �������� ���������� �� PC; ���������� ����������, � ��������� ���� ����� IelpcNotifyPageChanged;
// - new: ��������� ����������� ��� ���������� ������ ��������� ���� ����;
//
// Revision 1.13  2004/09/13 08:56:10  lulin
// - new behavior: TvcmPrimCollectionItem ������ ����� ������������ � �������������� � ���� ��������.
//
// Revision 1.12  2004/08/27 07:32:53  am
// new: ����� �������� � �������� - _LongCaption - ������������ � ������� ��������� ��������
//
// Revision 1.11  2004/08/26 08:42:25  am
// new: � usertype'� ����� ��������: _VisibleToUser - ���������� �� ��� � ������� ��������� ��������
//
// Revision 1.10  2004/04/19 09:14:34  mmorozov
// - ��������� ���������� � ������ interface;
//
// Revision 1.9  2004/04/16 08:50:31  mmorozov
// new: TvcmQueryType;
// new: hints ��� ������� OnQuery;
//
// Revision 1.8  2003/12/25 12:02:30  mmorozov
// new: published property TvcmUserTypesCollectionItem.OnQueryOpen;
//
// Revision 1.7  2003/12/15 19:27:36  mmorozov
// + ������� TvcmUserTypesCollectionItem.OnQueryMaximized;
//
// Revision 1.6  2003/12/01 11:01:38  law
// - bug fix: ���������� ��������� UserType'��.
// - bug fix: �������� Weigth ������������� � _Weight.
//
// Revision 1.5  2003/10/17 13:14:57  mmorozov
// - ��� �������� _CanClose ��������� default;
//
// Revision 1.4  2003/10/16 15:04:13  mmorozov
// + �������� TvcmUserTypesCollectionItem._CanClose;
// + �������� TvcmUserTypesCollectionItem.OnQueryClose;
//
// Revision 1.3  2003/10/15 10:31:11  mmorozov
// + �������� TvcmUserTypesCollectionItem.Weigth;
//
// Revision 1.2  2003/10/09 12:50:13  law
// - new prop: TvcmUserTypesCollectionItem.ImageIndex.
//
// Revision 1.1  2003/07/25 11:03:42  law
// - new units: vcmUserTypesCollection, vcmUserTypesCollectionItem.
//

{$Include vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,

  ImgList,

  vcmBaseCollectionItem,
  vcmInterfaces,
  vcmBaseUserTypesCollectionItem
  ;

type
  TvcmUserTypesCollectionItem = class(TvcmBaseUserTypesCollectionItem)
//    protected
    // property methods
      {$IfNDef DesignTimeLibrary}
(*      function  GetItem: TvcmBaseCollectionItem;
        {-}*)
(*      function  pm_GetCaption: String;
        override;
        {-}
      function  pm_GetSettingsCaption: String;
        override;
        {-}
      procedure pm_SetCaption(const aName: String);
        override;
        {-}*)
      {$EndIf  DesignTimeLibrary}
  end;//TvcmUserTypesCollectionItem
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
{$IfNDef DesignTimeLibrary}
uses
  vcmBaseMenuManager,
  vcmEntityForm
  ;
{$EndIf  DesignTimeLibrary}

// start class TvcmUserTypesCollectionItem

{$IfNDef DesignTimeLibrary}
(*function TvcmUserTypesCollectionItem.GetItem: TvcmBaseCollectionItem;
  {-}
var
 l_Name : String;
begin
 if (g_MenuManager <> nil) AND (Collection <> nil) AND (Collection.Owner <> nil) then
 begin
  if (Collection.Owner Is TvcmEntityForm) then
   l_Name := TvcmEntityForm(Collection.Owner).FormID.rName
  else
   l_Name := (Collection.Owner As TComponent).Name;
  Result := g_MenuManager.ObjectByType(vcm_objUserType, l_Name, Name);
 end//g_MenuManager <> nil
 else
  Result := nil;
end;*)

//function TvcmUserTypesCollectionItem.pm_GetCaption: String;
  //override;
  {-}
(*var
 l_Item : TvcmBaseCollectionItem;*)
//begin
(* l_Item := GetItem;
 if (l_Item <> nil) then
 begin
  Result := l_Item.Caption;
  if (Result <> '') then
   Exit;
 end;//l_Item <> nil*)
// Result := inherited pm_GetCaption;
//end;

//function TvcmUserTypesCollectionItem.pm_GetSettingsCaption: String;
  //override;
  {-}
(*var
 l_Item : TvcmBaseCollectionItem;*)
//begin
(* l_Item := GetItem;
 if (l_Item <> nil) then
 begin
  Result := (l_Item As TvcmBaseUserTypesCollectionItem).SettingsCaption;
  if (Result <> '') then
   Exit;
 end;//l_Item <> nil*)
// Result := inherited pm_GetSettingsCaption;
(* if (Result = '') then
  Result := Caption;*)
//end;
{$EndIf  DesignTimeLibrary}

{$IfNDef DesignTimeLibrary}
//procedure TvcmUserTypesCollectionItem.pm_SetCaption(const aName: String);
  //override;
  {-}
(*var
 l_Cap : String;*)
//begin
(* l_Cap := Caption;
 if (Caption = '') then
  DoSetCaption(aName)
 else
 if (l_Cap <> aName) then
  ChangeCaption(l_Cap, aName)
 else
 if (SettingsCaption = '') OR (SettingsCaption = l_Cap) OR (SettingsCaption = Name) then
  SettingsCaption := aName;*)
// inherited;
//end;
{$EndIf  DesignTimeLibrary}
{$IfEnd}

end.

