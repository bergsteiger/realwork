unit vcmBaseUserTypesCollectionItem;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmBaseUserTypesCollectionItem - }
{ �����: 25.07.2003 14:49 }
{ $Id: vcmBaseUserTypesCollectionItem.pas,v 1.23 2015/08/16 16:03:24 kostitsin Exp $ }

// $Log: vcmBaseUserTypesCollectionItem.pas,v $
// Revision 1.23  2015/08/16 16:03:24  kostitsin
// {requestlink: 605157327 }
//
// Revision 1.22  2015/06/03 12:26:27  lulin
// - �������� ��������� �����������.
//
// Revision 1.21  2015/03/18 06:49:52  lulin
// - ������������� �����������.
//
// Revision 1.20  2013/07/05 14:34:52  lulin
// - ������������ �������� ��� ����������� �������������� ������� � ������� ��������� ������ ������� ���������� �������������� �������� �� ���������� ������.
//
// Revision 1.19  2013/07/05 09:38:40  morozov
// {RequestLink:466760570}
//
// Revision 1.18  2013/04/25 14:22:38  lulin
// - ���������.
//
// Revision 1.17  2012/07/18 13:18:04  lulin
// {RequestLink:378550793}
//
// Revision 1.16  2012/07/17 11:12:09  lulin
// {RequestLink:378541134}
//
// Revision 1.15  2012/07/10 09:32:50  lulin
// {RequestLink:237994598}
//
// Revision 1.14  2010/05/24 15:10:55  lulin
// {RequestLink:215548392}.
// - �� ���� �������� �������� ���������.
//
// Revision 1.13  2010/04/29 13:48:03  lulin
// {RequestLink:159352361}.
// - ��������� �������������� ���� �� ������.
//
// Revision 1.12  2010/04/27 18:02:24  lulin
// {RequestLink:159352361}.
// - ������� ����������� �������� ����� ��������� �� ������.
//
// Revision 1.11  2010/04/27 12:11:10  lulin
// {RequestLink:159352361}.
//
// Revision 1.10  2010/04/26 13:51:39  lulin
// {RequestLink:159352361}.
// - ������ �������� �����������.
//
// Revision 1.9  2008/06/17 11:49:44  mmorozov
// bugfix: ���������� ������ � ���������� ������ ��� ����� (CQ: OIT5-29349, 29354);
//
// Revision 1.8  2008/05/29 12:26:54  mmorozov
// - new: ����������� ���������� �� ������ ���� ������������ ������ ������������ (CQ: OIT5-28281).
//
// Revision 1.7  2007/01/18 13:54:18  oman
// - new: ����������� ��������� - vcm - ����������� �� �������� ��
//  ��������� - ����� ����������� ������� (cq24078)
//
// Revision 1.6  2007/01/18 13:33:53  oman
// - new: ����������� ��������� - vcm - ����������� �� �������� ��
//  ��������� (cq24078)
//
// Revision 1.5  2007/01/18 11:47:36  oman
// - new: ����������� ��������� - vcm (cq24078)
//
// Revision 1.4  2006/11/03 11:00:32  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.3.6.2  2006/10/19 08:53:09  lulin
// - ���������� ����� ���������������� ����� ��� ������� ���������.
//
// Revision 1.3.6.1  2006/10/18 08:00:31  lulin
// - ��������� ��� �������� �������� ����� ��������.
//
// Revision 1.3  2006/03/15 13:10:03  lulin
// - bug fix: �������� ������� �������� UserType'��.
//
// Revision 1.2  2006/03/15 12:27:21  lulin
// - cleanup.
//
// Revision 1.1  2006/03/14 13:04:52  lulin
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
// new: published property TvcmBaseUserTypesCollectionItem.OnQueryOpen;
//
// Revision 1.7  2003/12/15 19:27:36  mmorozov
// + ������� TvcmBaseUserTypesCollectionItem.OnQueryMaximized;
//
// Revision 1.6  2003/12/01 11:01:38  law
// - bug fix: ���������� ��������� UserType'��.
// - bug fix: �������� Weigth ������������� � _Weight.
//
// Revision 1.5  2003/10/17 13:14:57  mmorozov
// - ��� �������� _CanClose ��������� default;
//
// Revision 1.4  2003/10/16 15:04:13  mmorozov
// + �������� TvcmBaseUserTypesCollectionItem._CanClose;
// + �������� TvcmBaseUserTypesCollectionItem.OnQueryClose;
//
// Revision 1.3  2003/10/15 10:31:11  mmorozov
// + �������� TvcmBaseUserTypesCollectionItem.Weigth;
//
// Revision 1.2  2003/10/09 12:50:13  law
// - new prop: TvcmBaseUserTypesCollectionItem.ImageIndex.
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
  vcmUserTypesCollectionItemPrim
  ;

type
  TvcmQueryType = (qtClose, qtMaximized, qtOpen);

  TvcmBaseUserTypesCollectionItem = class(TvcmUserTypesCollectionItemPrim)
  {* ��������� ��� �����. }
  private
    // property fields
    f_Weight               : Integer;
    f_CanClose             : TvcmCanClose;
    f_ImageIndex           : TImageIndex;
    f_OnQueryClose         : TNotifyEvent;
    f_OnQueryMaximized     : TNotifyEvent;
    f_OnQueryOpen          : TNotifyEvent;
    f_AllowCustomizeToolbars        : Boolean;
    f_LongCaption          : AnsiString;
    f_OnWeightChanged      : TNotifyEvent;
    f_UseToolbarOfUserTypeName : AnsiString;
  private
  // property methods
    procedure pm_SetWeight(const aValue: Integer);
      {-}
    function pm_GetUseToolbarOfUserType: TvcmBaseUserTypesCollectionItem;
      {-}
    function pm_GetAllowCustomizeToolbars: Boolean;
      {-}
  protected
  // protected methods
    function  pm_GetSettingsCaption: AnsiString;
      //virtual;
      {-}
      procedure ChangeCaption(const anOld, aNew: AnsiString);
        override;
        {-}
      function GetCaptionStored: Boolean;
        override;
        {-}
      procedure BeforeAddToCache;
        override;
        {-}
  public
  // public methods
    constructor Create(Collection: TCollection);
      override;
      {-}
    procedure Assign(P: TPersistent);
      override;
      {-}
    function GetQueryEvent(const aType : TvcmQueryType) : TNotifyEvent;
      {-}
  public
  // public properties
    property OnWeightChanged: TNotifyEvent
      read f_OnWeightChanged
      write f_OnWeightChanged;
      {* - ���������� ��� ��������� ����. }
    property UseToolbarOfUserType: TvcmBaseUserTypesCollectionItem
      read pm_GetUseToolbarOfUserType;
      {* - ��� ����� ������������ ��� ������ �������� �� ��������. }
    property OnQueryMaximized: TNotifyEvent
      read f_OnQueryMaximized
      write f_OnQueryMaximized;
      {-}
    property OnQueryOpen: TNotifyEvent
      read f_OnQueryOpen
      write f_OnQueryOpen;
      {-}
    property OnQueryClose: TNotifyEvent
      read f_OnQueryClose
      write f_OnQueryClose;
      {-}
    property CanClose: TvcmCanClose
      read f_CanClose
      write f_CanClose
      default vcm_ccNone;
      {-}
  published
  // published properties
    property ImageIndex: TImageIndex
      read f_ImageIndex
      write f_ImageIndex
      default -1;
      {* - ������ ��������, ��������� � ���������. }
    property Weight: Integer
      read f_Weight
      write pm_SetWeight
      default cNullWeight;
      {* - ���. }
    // �� ���������� ������ - AllowCustomizeToolbars ������ True
    // http://mdp.garant.ru/pages/viewpage.action?pageId=466760570
    property AllowCustomizeToolbars: Boolean
      read (*f_AllowCustomizeToolbars*) pm_GetAllowCustomizeToolbars
      write f_AllowCustomizeToolbars
      stored false
      default True;
      {* - ��������� ������������ � ������� ��������� ��������}
    property SettingsCaption: AnsiString
      read pm_GetSettingsCaption
      write f_LongCaption
      stored false{IsStoredLongCaption};
      {-}
    property UseToolbarOfUserTypeName: AnsiString
      read f_UseToolbarOfUserTypeName
      write f_UseToolbarOfUserTypeName
      stored false;
      {* - ������������ ��������� ��� ����. }
  end;//TvcmBaseUserTypesCollectionItem
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
uses
  vcmBaseCollection,
  vcmEntityForm,
  afwFacade;

// start class TvcmBaseUserTypesCollectionItem

constructor TvcmBaseUserTypesCollectionItem.Create(Collection: TCollection);
  //override;
  {-}
begin
 inherited;
 f_Weight        := cNullWeight;
 f_ImageIndex    := -1;
 f_AllowCustomizeToolbars := True;
end;

procedure TvcmBaseUserTypesCollectionItem.BeforeAddToCache;
  //override;
  {-}
begin
 inherited;
 f_CanClose := Low(TvcmCanClose);
 f_OnQueryClose := nil;
 f_OnQueryMaximized := nil;
 f_OnQueryOpen := nil;
 f_LongCaption := '';
 f_UseToolbarOfUserTypeName := '';
end;

procedure TvcmBaseUserTypesCollectionItem.Assign(P: TPersistent);
  //override;
  {-}
var
 l_UserType : TvcmBaseUserTypesCollectionItem;
begin
 inherited;
 if (P Is TvcmBaseUserTypesCollectionItem) then
 begin
  l_UserType               := TvcmBaseUserTypesCollectionItem(P);
  SettingsCaption          := l_UserType.SettingsCaption;
  CanClose                 := l_UserType.CanClose;
  ImageIndex               := l_UserType.ImageIndex;
  OnQueryClose             := l_UserType.OnQueryClose;
  OnQueryMaximized         := l_UserType.OnQueryMaximized;
  OnQueryOpen              := l_UserType.OnQueryOpen;
  Weight                   := l_UserType.Weight;
  UseToolbarOfUserTypeName := l_UserType.UseToolbarOfUserTypeName;
 end;//P Is TvcmBaseUserTypesCollectionItem
end;

function TvcmBaseUserTypesCollectionItem.GetQueryEvent(const aType : TvcmQueryType): TNotifyEvent;
begin
 Result := nil;
 case aType of
  qtClose:
   Result := f_OnQueryClose;
  qtOpen:
   Result := f_OnQueryOpen;
  qtMaximized:
   Result := f_OnQueryMaximized;
 end;
end;

procedure TvcmBaseUserTypesCollectionItem.pm_SetWeight(const aValue: Integer);
  {-}
begin
 if f_Weight <> aValue then
 begin
  f_Weight := aValue;
  if Assigned(f_OnWeightChanged) then
   f_OnWeightChanged(Self);
 end;//if f_Weight <> aValue then
end;//pm_SetWeight

function TvcmBaseUserTypesCollectionItem.pm_GetSettingsCaption: AnsiString;
  //virtual;
  {-}
begin
 Result := f_LongCaption;
end;

procedure TvcmBaseUserTypesCollectionItem.ChangeCaption(const anOld, aNew: AnsiString);
begin
 inherited;
 if (anOld = SettingsCaption) then
  SettingsCaption := aNew;
end;

function TvcmBaseUserTypesCollectionItem.GetCaptionStored: Boolean;
  //override;
  {-}
begin
 Result := false;
end;

function TvcmBaseUserTypesCollectionItem.pm_GetUseToolbarOfUserType: TvcmBaseUserTypesCollectionItem;
begin
 Assert((Name = '') or ((Name <> '') and (Name <> UseToolbarOfUserTypeName)));
  // - �� �������� ���� ��� ������� ������� � �������� ������������ �����.
 if UseToolbarOfUserTypeName = '' then
  Result := Self
 else
 begin
  Assert(Collection is TvcmBaseCollection);
  // ������ ������������ ���:
  Result := TvcmBaseUserTypesCollectionItem(TvcmBaseCollection(Collection).
   FindItemByName(UseToolbarOfUserTypeName));
  // ��� �� ������, ���������� ����:
  if Result = nil then
   Result := Self
  // ���������� � ���������� ���� ���������, �.�. � ���� ���� ����� ���� ������
  // ��� ��� ������ ��������:
  else
   Result := Result.UseToolbarOfUserType;
 end;//if UseToolbarOfUserTypeName = '' then
end;//pm_GetUseToolbarOfUserType

function TvcmBaseUserTypesCollectionItem.pm_GetAllowCustomizeToolbars: Boolean;
begin
  // http://mdp.garant.ru/pages/viewpage.action?pageId=466760570
  Result := f_AllowCustomizeToolbars {or afw.Application._IsInternal};
                                    //^ ��������� � TvcmUserTypeInfo.AllowCustomizeToolbars
end;
{$IfEnd}

end.

