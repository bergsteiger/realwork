unit nscCombobox;
{* }

{ $Id: nscComboBox.pas,v 1.3 2015/07/28 13:31:31 lulin Exp $ }

// $Log: nscComboBox.pas,v $
// Revision 1.3  2015/07/28 13:31:31  lulin
// - ����������� ������ � ������.
//
// Revision 1.2  2015/03/12 10:12:54  lulin
// - ������������� �����.
//
// Revision 1.1  2013/08/15 10:28:22  kostitsin
// nscCombobox.pas -> nscComboBox.pas
//
// Revision 1.60  2011/01/29 16:35:00  lulin
// {RequestLink:228688602}.
// - �������� �����.
//
// Revision 1.59  2009/11/09 11:20:55  lulin
// - ������������� ������ ���������� �� ���������� �������� ��� ����������.
//
// Revision 1.58  2009/01/19 11:11:34  oman
// - fix: ������� ������� Alt++ (�-112723164)
//
// Revision 1.57  2009/01/15 11:44:35  oman
// - fix: ����������� �������� "+"/"-" (�-112723164)
//
// Revision 1.56  2008/09/04 11:16:08  lulin
// - <K>: 88080895.
//
// Revision 1.55  2008/08/01 11:28:19  oman
// - fix: ��������� Home/End ��� ������������� ����������� (K-105578687)
//
// Revision 1.54  2008/07/17 07:07:38  oman
// - fix: ����� ��������� �������� ����� (�-103448796)
//
// Revision 1.53  2008/07/08 11:26:23  lulin
// - ��������� �� �������� � ����������� �������� IsList.
// - ������� ����� � ������ �������������.
//
// Revision 1.52  2008/07/07 14:27:03  lulin
// - ���������������� � ��������������.
//
// Revision 1.51  2008/07/02 13:27:31  oman
// - fix: ����������� ������� (�-91848911)
//
// Revision 1.50  2008/07/02 11:41:59  oman
// - fix: �������� ������� � ������������ �� ����� ��������� (�-96474339)
//
// Revision 1.49  2008/07/02 10:56:33  oman
// - new: ����������� �������� ��������� (�-96474339)
//
// Revision 1.48  2008/07/02 09:29:33  oman
// - new: ����� ���������� ����� ����� ��� ������� ������ (�-96474339)
//
// Revision 1.47  2008/07/02 06:24:21  oman
// Cleanup
//
// Revision 1.46  2008/07/01 12:11:13  oman
// - new: ��� ������� �� ��������� ����� � �������� ��������������� (�-96474339)
//
// Revision 1.45  2008/06/26 11:18:35  oman
// - fix: ������� � ��������������� ����� (cq11768)
//
// Revision 1.44  2008/06/26 09:48:15  oman
// - fix: �������� �������� � ���������� OnChange (cq11768)
//
// Revision 1.43  2008/06/26 09:13:48  oman
// - fix: �������� �������� � ���������� OnChange (cq11768)
// - fix: �������� ������ ����� (cq11768)
//
// Revision 1.42  2008/06/26 06:14:46  oman
// - new: �������� ����� ��������� (cq29374)
//
// Revision 1.41  2008/06/26 05:53:25  oman
// - new: ������ ������ (cq29374)
//
// Revision 1.40  2008/06/24 12:29:26  oman
// - new: ��������� ��� ������ ���������� (cq29374)
//
// Revision 1.39  2008/06/17 14:07:38  oman
// - new: ���� ��� ������� ����� (cq29206)
//
// Revision 1.38  2008/05/30 06:26:22  lulin
// - <K>: 92766380.
//
// Revision 1.37  2008/05/30 06:11:23  lulin
// - <K>: 92766363.
//
// Revision 1.36  2008/05/21 17:05:12  lulin
// - <K>: 90441490.
//
// Revision 1.35  2008/05/21 13:51:01  lulin
// - <K>: 90448804.
//
// Revision 1.34  2008/05/15 20:15:17  lulin
// - ��������� ������.
//
// Revision 1.33  2008/05/15 18:53:45  lulin
// - ���������������� � �������� �� ������.
//
// Revision 1.32  2008/05/15 17:31:35  lulin
// - ������ ������������� �������.
// - ������� ����������� ������ ��������������.
//
// Revision 1.31  2008/05/14 19:05:04  lulin
// - <K>: 90446006.
//
// Revision 1.30  2008/05/13 16:24:09  lulin
// - ��������� � ������ <K>: 90441490.
//
// Revision 1.29  2008/04/25 06:48:15  oman
// - fix: �� ����������� ����������� �� ��������� (cq28948)
//
// Revision 1.28  2007/12/07 16:22:37  lulin
// - ��������������� ����, ����� �� ������ � ������ �����������.
//
// Revision 1.27  2007/10/10 12:32:19  oman
// - fix: ����������� �� ��� ��������
//
// Revision 1.26  2007/09/12 09:24:24  oman
// - new: ��������� ������ ���� ��� ��������� ����� ������ (cq26647)
//
// Revision 1.25  2007/09/11 11:34:27  oman
// - fix: ���������� ����� ����� �� �������� � �� (cq26638)
//
// Revision 1.24  2007/07/27 09:02:44  oman
// - fix: ���� ���������� ������ ������, ��������� ���������� ��
//  ��������� (cq26085)
//
// Revision 1.23  2007/07/25 08:55:29  oman
// - fix: ��� ������� �� ��������� �� �������� OnChange
//
// Revision 1.22  2007/07/24 07:15:34  oman
// - fix: ����� ������� �� ��������� �� �������� ����������� (cq26018)
//
// Revision 1.21  2007/07/20 05:50:55  oman
// - fix: ��������� �������� (cq25976)
//
// Revision 1.20  2007/07/19 13:56:08  oman
// - fix: ��������� �������� (cq25976)
//
// Revision 1.19  2007/03/29 15:54:26  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.18  2007/03/28 19:42:49  lulin
// - ����������� �������� ��������� �� ������ � ����������.
//
// Revision 1.17  2007/03/19 14:49:13  lulin
// - ������� ������� ����� ����������.
//
// Revision 1.16  2007/03/14 19:03:41  lulin
// - cleanup.
//
// Revision 1.15  2007/03/06 07:57:43  oman
// - fix: ������� �� ���������� ����������
//
// Revision 1.14  2007/02/14 14:24:05  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.13  2007/01/20 15:31:00  lulin
// - ��������� ��������� �������� ��� ���������� � ��� ������������.
//
// Revision 1.12  2007/01/19 14:38:21  mmorozov
// - new: ���������� ��������� � �������;
//
// Revision 1.11  2007/01/17 17:53:31  lulin
// - ������ ������ ���������� ��� ������������ ��������.
//
// Revision 1.10  2007/01/17 14:02:35  lulin
// - �������� ��������� ��������������� ��������� � ������ ��������.
//
// Revision 1.9  2006/09/29 07:12:13  oman
// - new: _TnscComboBoxQS � ��������� � ������������ ����������� �� ���������
//  ������ - ������������� ������� (cq22776)
//
// Revision 1.8  2006/09/28 15:01:30  oman
// - new: _TnscComboBoxQS � ��������� � ������������ ����������� �� ���������
//  ������ - ����� ������������ ������� (cq22776)
//
// Revision 1.7  2006/09/28 14:05:22  oman
// - new: _TnscComboBoxQS � ��������� � ������������ ����������� �� ���������
//  ������ (cq22776)
//
// Revision 1.6  2006/07/04 10:51:18  oman
// - fix: ���� ������� ��������� ��������, �� �� ������ ���������
//  ������������ ��������������� �������.
//
// Revision 1.5  2006/06/23 10:33:19  oman
// - new beh: ����� ��������� nscComboBoxWithReadOnly
//
// Revision 1.4  2006/06/21 09:09:54  oman
// - fix: ���� ������������ ��������, �� ����� ��������� ������ ��
//  ��������� (cq21215)
//
// Revision 1.3  2006/02/15 09:36:17  mmorozov
// - change: test ��������;
//
// Revision 1.2  2005/11/23 13:18:27  oman
// - new: ��������� TnscComboBoxWithPwdChar
//
// Revision 1.1  2004/12/29 14:59:24  am
// new: ��������� ���������� � ����������� �������� Cut/Copy/Paste/Delete
//

{$Include nscDefine.inc}

interface

uses
  Classes,
  Messages,
  Controls,
  Windows,
  
  l3Interfaces,
  l3Types,
  l3InternalInterfaces,

  vcmExternalInterfaces,

  ctTypes,
  FakeBox,
  nscConst,
  vtComboTree
  ;

type
  TnscComboBox = class(TvtComboTree)
  {* ���������� ������ ����������� ��������. }
  private
    procedure CNKeyDown(var Message: TWMKeyDown);
      message CN_KEYDOWN;
      {-}
  protected
   function TranslateHomeEndToDropDown: Boolean;
     override;
     {-}
  public
   constructor Create(AOwner:TComponent);
     override;
     {-}
  published
    property Anchors;
    property Ctl3D;
    property Hint;
    property TabOrder;
    property ParentFont;
    property OnChange;
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property ShowHint;
    property EmptyHint;
    property EmptyHintColor default cDefaultContextEmptyColor;
    property Font;
  end;//TnscComboBox

  TnscEdit = class(TnscComboBox)
  {* ���������� ������ � �������������� ����� PasswordChar. }
  public
  // public methods
   constructor Create(AOwner:TComponent);
     override;
     {-}
  public
  // public properties
    property ComboStyle
      default ct_cbEdit;
      {-}
  published
  // published properties
    property MaxLength;
  end;//TnscEdit

  TnscEditWithoutPlusMinusShortcut = class(TnscEdit)
  private
   procedure CNKeyDown(var Message: TWMKeyDown);
     message CN_KEYDOWN;
  published
    property OnKeyPress;
  end;

  TnscComboBoxWithFilter = class(TnscEdit)
  private
   f_DroppingData: Boolean;
  private
   procedure pm_SetCaretPos(aPos: Integer);
    {-}
   function pm_GetCaretPos: Integer;
    {-}
  protected
   function DoDoDrop(aFormat       : Tl3ClipboardFormat;
                   const aMedium : Tl3StoragePlace;
                   var dwEffect  : Longint): Boolean;
     override;
     {-}
  public
   procedure SelectTail(aStartPos: Cardinal);
     {-}
  public
   property CaretPos: Integer
    read pm_GetCaretPos
    write pm_SetCaretPos;
     {-}
   property DroppingData: Boolean
    read f_DroppingData;
     {-}
  end;//TnscComboBoxWithFilter

  TnscComboBoxWithPwdChar = class(TnscEdit)
  {* ���������� ������ � �������������� ����� PasswordChar. }
  protected
   function CopyAllowed: Boolean;
     override;
     {-}
   function CutAllowed: Boolean;
     override;
     {-}
  published
  // published properties
    property PasswordChar;
      {-}
  end;//TnscComboBoxWithPwdChar

implementation

uses
  SysUtils,
  DateUtils,
  Forms,

  OvcConst,

  l3Base,
  l3String,

  //vcmDefaultOperations,

  elCustomEdit,

  evOp,
  evEditorWindow,

  EditableBox
  ;

// start class TnscEdit

constructor TnscEdit.Create(AOwner:TComponent);
  //override;
  {-}
begin
 inherited;
 ComboStyle := ct_cbEdit;
end;

{ TnscComboBoxWithPwdChar }

function TnscComboBoxWithPwdChar.CopyAllowed: Boolean;
begin
 if PasswordChar <> '' then
  Result := False
 else
  Result := inherited CopyAllowed;
end;

function TnscComboBoxWithPwdChar.CutAllowed: Boolean;
begin
 if PasswordChar <> '' then
  Result := False
 else
  Result := inherited CutAllowed;
end;

constructor TnscComboBox.Create(AOwner: TComponent);
begin
 inherited Create(aOwner);
 EmptyHintColor := cDefaultContextEmptyColor;
end;

procedure TnscComboBox.CNKeyDown(var Message: TWMKeyDown);
begin
 if Message.CharCode = VK_SUBTRACT then
  Message.CharCode := cMinusKeyCode;
 inherited; 
end;

{ TnscComboBoxWithFilter }

procedure TnscComboBoxWithFilter.SelectTail(aStartPos: Cardinal);
begin
// SelStart := aStartPos;
// SelLength := TextLen - aStartPos;
 CaretX := aStartPos;
 ProcessCommand(ev_ocExtLineEnd, False, 1);
end;

procedure TnscComboBoxWithFilter.pm_SetCaretPos(aPos: Integer);
begin
 CaretX := aPos;
end;

function TnscComboBoxWithFilter.pm_GetCaretPos: Integer;
begin
 Result := CaretX;
end;

function TnscComboBoxWithFilter.DoDoDrop(aFormat: Tl3ClipboardFormat;
  const aMedium: Tl3StoragePlace; var dwEffect: Integer): Boolean;
begin
 f_DroppingData := True;
 try
  Result := inherited DoDoDrop(aFormat, aMedium, dwEffect);
 finally
  f_DroppingData := False;
 end;
end;

function TnscComboBox.TranslateHomeEndToDropDown: Boolean;
begin
 Result := not (ComboStyle in ReadOnlyComboStyles);
end;

{ TnscEditWithoutPlusMinusShortcut }

procedure TnscEditWithoutPlusMinusShortcut.CNKeyDown(
  var Message: TWMKeyDown);
begin
 if (Message.CharCode = VK_SUBTRACT) and (KeyDataToShiftState(Message.KeyData) = []) then
  Message.CharCode := cMinusKeyCode;
 if (Message.CharCode = VK_ADD) and (KeyDataToShiftState(Message.KeyData) = []) then
  Message.CharCode := cPlusKeyCode;
 inherited;
end;

end.
