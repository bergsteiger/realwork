unit vcmUserTypeDef;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmUserTypeDef - }
{ �����: 09.02.2004 20:07 }
{ $Id: vcmUserTypeDef.pas,v 1.19 2013/07/05 14:34:50 lulin Exp $ }

// $Log: vcmUserTypeDef.pas,v $
// Revision 1.19  2013/07/05 14:34:50  lulin
// - ������������ �������� ��� ����������� �������������� ������� � ������� ��������� ������ ������� ���������� �������������� �������� �� ���������� ������.
//
// Revision 1.18  2013/04/05 12:02:33  lulin
// - ���������.
//
// Revision 1.17  2012/07/17 11:52:44  lulin
// {RequestLink:378541134}
//
// Revision 1.16  2012/07/17 11:12:07  lulin
// {RequestLink:378541134}
//
// Revision 1.15  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.14  2009/02/20 13:07:04  lulin
// - <K>: 136941122.
//
// Revision 1.13  2009/02/16 12:59:41  lulin
// - <K>: 135604584.
//
// Revision 1.12  2008/06/25 09:24:10  mmorozov
// - new: ����������� ������� ������������ ---|> � ������ ��������� ���� ���������� ������ ������������ ������ ������������ + ����������� + ������ ���� ������� ��� �������������� ��������� ��� ������ �������� (CQ: OIT5-28281);
//
// Revision 1.11  2007/04/10 14:06:20  lulin
// - ���������� ������ � ����������.
//
// Revision 1.10  2006/11/03 11:00:29  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.9.30.1  2006/10/18 08:00:29  lulin
// - ��������� ��� �������� �������� ����� ��������.
//
// Revision 1.9  2005/06/02 07:32:17  mmorozov
// new: � ���������� ������� Create, Make � TvcmUserTypeDef �������� �� ������������ �������� aUserVisibleOpCount;
//
// Revision 1.8  2004/09/10 12:23:49  lulin
// - ����������� - ������� ���������� ���������� � UserType'��� � VisibleOpCount. � ����� ��������� ���������� ��������� �������.
//
// Revision 1.7  2004/08/27 07:32:50  am
// new: ����� �������� � �������� - _LongCaption - ������������ � ������� ��������� ��������
//
// Revision 1.6  2004/08/26 08:42:21  am
// new: � usertype'� ����� ��������: _VisibleToUser - ���������� �� ��� � ������� ��������� ��������
//
// Revision 1.5  2004/08/19 14:14:41  am
// new: OperationDef._VisibleToUser - �������� �� �������� ������������ � ��������� ��������
// new: UserTypeDef._UserVisibleOpCount - ���������� ��������� ������������ ��������
//
// Revision 1.4  2004/02/10 15:35:17  law
// - new prop: IvcmUserTypeDef.FormClass.
//
// Revision 1.3  2004/02/10 15:28:51  law
// - new prop: IvcmUserTypeDef.ID.
//
// Revision 1.2  2004/02/10 12:59:47  law
// - change: IvcmUserTypesIterator ������ ���������� IvcmUserTypeDef.
//
// Revision 1.1  2004/02/09 17:14:03  law
// - new unit: vcmUserTypeDef
//

{$I vcmDefine.inc }

interface

uses
  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmBaseObjectDef,

  vcmBase
  ;

type
  TvcmUserTypeDef = class(TvcmBaseObjectDef, IvcmUserTypeDef)
    private
    // property fields
      f_VisOpCount                : Integer;
      f_ID                        : TvcmUserType;
      f_FormClass                 : TClass;
      f_AllowCustomizeToolbars             : Boolean;
      f_LongCaption               : AnsiString;
      f_UseToolbarAnotherUserType : Boolean;
    private
    // interface methods
      // IvcmUserTypeDef
      function Get_ID: Integer;
        {-}
      function Get_FormClass: TClass;
        {-}
      function Get_UserVisibleOpCount: Integer;
        {-}
      function Get_AllowCustomizeToolbars: Boolean;
        {-}
      function Get_SettingsCaption: AnsiString;
        {-}
      function Get_UseToolbarAnotherUserType: Boolean;
        {-}
    public
    // public methods
      constructor Create(const aName                : AnsiString;
                         const aCaption             : IvcmCString;
                         anID                       : TvcmUserType;
                         aFormClass                 : TClass;
                         aVisibleToUser             : Boolean;
                         aLongCaption               : AnsiString;
                         aUseToolbarAnotherUserType : Boolean;
                         aUserVisibleOpCount        : Integer = -1);
        reintroduce;
        {-}
      class function Make(const aName                : AnsiString;
                          const aCaption             : IvcmCString;
                          anID                       : TvcmUserType;
                          aFormClass                 : TClass;
                          aVisibleToUser             : Boolean;
                          aLongCaption               : AnsiString;
                          aUseToolbarAnotherUserType : Boolean;
                          aUserVisibleOpCount        : Integer = -1) : IvcmUserTypeDef;
        reintroduce;
        {-}
  end;//TvcmUserTypeDef

implementation

uses
  vcmBaseMenuManager,
  vcmEntityForm
  ;

// start class TvcmUserTypeDef

constructor TvcmUserTypeDef.Create(const aName                : AnsiString;
                                   const aCaption             : IvcmCString;
                                   anID                       : TvcmUserType;
                                   aFormClass                 : TClass;
                                   aVisibleToUser             : Boolean;
                                   aLongCaption               : AnsiString;
                                   aUseToolbarAnotherUserType : Boolean;
                                   aUserVisibleOpCount        : Integer = -1);
  //reintroduce;
  {-}
begin
 inherited Create(aName, aCaption);
 f_VisOpCount := aUserVisibleOpCount;
 f_ID := anID;
 f_FormClass := aFormClass;
 f_AllowCustomizeToolbars := aVisibleToUser;
 f_LongCaption := aLongCaption;
 f_UseToolbarAnotherUserType := aUseToolbarAnotherUserType;
end;

class function TvcmUserTypeDef.Make(const aName                : AnsiString;
                                    const aCaption             : IvcmCString;
                                    anID                       : TvcmUserType;
                                    aFormClass                 : TClass;
                                    aVisibleToUser             : Boolean;
                                    aLongCaption               : AnsiString;
                                    aUseToolbarAnotherUserType : Boolean;
                                    aUserVisibleOpCount        : Integer = -1) : IvcmUserTypeDef;
  //reintroduce;
  {-}
var
 l_UserTypeDef : TvcmUserTypeDef;
begin
 l_UserTypeDef := Create(aName,
                         aCaption,
                         anID,
                         aFormClass,
                         aVisibleToUser,
                         aLongCaption,
                         aUseToolbarAnotherUserType,
                         aUserVisibleOpCount);
 try
  Result := l_UserTypeDef;
 finally
  vcmFree(l_UserTypeDef);
 end;//try..finally
end;

function TvcmUserTypeDef.Get_ID: Integer;
  {-}
begin
 Result := f_ID;
end;

function TvcmUserTypeDef.Get_FormClass: TClass;
  {-}
begin
 Result := f_FormClass;
end;

function TvcmUserTypeDef.Get_UserVisibleOpCount: Integer;
  {-}
var
 l_Form      : TvcmEntityForm;
 l_NeedClose : Boolean;
begin
 if (f_VisOpCount = -1) then
 begin
  l_Form := g_MenuManager.BuildVirtualForm(RvcmEntityForm(f_FormClass), l_NeedClose, f_ID);
  try
   f_VisOpCount := l_Form.GetUserVisibleOperationsCount(f_ID);
  finally
   if l_NeedClose then
    l_Form.SafeClose;
  end;//try..finally
 end;//f_VisOpCount = -1
 Result := f_VisOpCount;
end;

function TvcmUserTypeDef.Get_AllowCustomizeToolbars: Boolean;
begin
 Result := f_AllowCustomizeToolbars;
end;

function TvcmUserTypeDef.Get_SettingsCaption: AnsiString;
begin
 Result := f_LongCaption;
end;

function TvcmUserTypeDef.Get_UseToolbarAnotherUserType: Boolean;
begin
 Result := f_UseToolbarAnotherUserType;
end;

end.

