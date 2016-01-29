unit evStyleTableTools;
{* ���������� ��� ������ � �������� ������. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evStyleTableTools - }
{ �����: 18.09.2002 17:53 }
{ $Id: evStyleTableTools.pas,v 1.68 2014/04/21 11:45:00 lulin Exp $ }

// $Log: evStyleTableTools.pas,v $
// Revision 1.68  2014/04/21 11:45:00  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.67  2013/10/23 12:25:49  lulin
// - ������������� ������������ ���� ���� ���������� � ������.
//
// Revision 1.66  2013/07/16 15:24:26  lulin
// - ��������� ��������.
//
// Revision 1.65  2013/07/16 15:02:24  kostitsin
// no message
//
// Revision 1.64  2010/02/02 13:50:16  lulin
// {RequestLink:174719086}.
//
// Revision 1.63  2009/06/25 12:57:30  lulin
// - �������� �������� ��������.
//
// Revision 1.62  2009/04/23 13:23:47  lulin
// [$145099347].
//
// Revision 1.61  2009/03/04 13:32:47  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.60  2009/02/03 09:06:09  lulin
// - <K>: 136256119.
//
// Revision 1.59  2008/07/16 10:48:43  lulin
// - bug fix: �� ���������� ���� ���� ����� � ��������.
//
// Revision 1.58  2008/06/20 14:48:51  lulin
// - ���������� �������� ���������.
//
// Revision 1.57  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.56  2007/12/04 12:47:05  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.52.4.10  2007/09/07 12:27:33  lulin
// - cleanup.
//
// Revision 1.52.4.9  2007/08/09 11:19:13  lulin
// - cleanup.
//
// Revision 1.52.4.8  2007/01/12 12:56:56  lulin
// - cleanup.
//
// Revision 1.52.4.7  2007/01/12 12:53:11  lulin
// - bug fix: ������������� ��� ������ ����������.
//
// Revision 1.52.4.6  2006/11/03 11:00:06  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.52.4.5.24.1  2006/10/26 11:24:13  lulin
// - ����������� �� ������ �������������� �����.
//
// Revision 1.52.4.5  2005/05/20 14:58:39  lulin
// - new unit: evStyleInterface.
//
// Revision 1.52.4.4  2005/05/20 13:49:53  lulin
// - new unit: evStyleInterfaceEx.
//
// Revision 1.52.4.3  2005/05/19 12:48:34  lulin
// - new unit: evInterface.
//
// Revision 1.52.4.2  2005/05/19 12:31:10  lulin
// - ��������� ������ � ����� � � ������� ��������� � ������� �����������.
//
// Revision 1.52.4.1  2005/05/18 12:42:47  lulin
// - ����� ����� �����.
//
// Revision 1.49.2.3  2005/05/18 12:32:09  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.49.2.2  2005/04/28 09:18:30  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.49.2.1  2005/04/18 16:43:25  lulin
// - ���������� _Box, � �� _Ik2Tag (���� �������� � ������������������ �� ����).
//
// Revision 1.51.2.1  2005/04/21 14:46:55  lulin
// - ����������� �� ������� ��� ������ - ������ ������� ����������� �������� ���� ��������� ��������� _Ik2Tag.
//
// Revision 1.51  2005/04/20 14:19:44  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.50  2005/04/18 17:18:22  lulin
// - ���������� _Box, � �� _Ik2Tag (���� �������� � ������������������ �� ����).
//
// Revision 1.52  2005/04/28 15:03:38  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.51.2.1  2005/04/21 14:46:55  lulin
// - ����������� �� ������� ��� ������ - ������ ������� ����������� �������� ���� ��������� ��������� _Ik2Tag.
//
// Revision 1.51  2005/04/20 14:19:44  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.50  2005/04/18 17:18:22  lulin
// - ���������� _Box, � �� _Ik2Tag (���� �������� � ������������������ �� ����).
//
// Revision 1.49  2005/03/30 12:14:23  lulin
// - bug fix: ��� ���������� ������� ������ �������� "�������� ���������" (CQ OIT5-13085).
//
// Revision 1.48  2005/03/28 14:29:59  lulin
// - �� ������ ����������� ��������� � ����������.
//
// Revision 1.47  2005/03/28 11:32:08  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.46  2005/03/28 06:37:08  lulin
// - remove object: Tk2AtomW.
//
// Revision 1.45  2005/03/25 17:09:01  lulin
// - ����������� �� ������ Tk2AtomW.sLong.
//
// Revision 1.44  2005/03/24 18:39:21  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.43  2005/03/24 14:10:31  lulin
// - ������� �������� ������.
//
// Revision 1.42  2005/03/21 13:42:58  lulin
// - ������ �������� ������.
//
// Revision 1.41  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.40  2005/03/19 16:39:51  lulin
// - �������� �������� ������.
//
// Revision 1.39  2005/03/19 14:04:11  mmorozov
// change: ��� ��������� ����� �������� aFont.Color = clDefault ���������� � evIntf.Il3Font2Font;
//
// Revision 1.38  2005/03/18 16:11:22  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.37  2005/03/18 13:11:43  mmorozov
// new behaviour: ��������� ��������� ����� ������ �� ���������, �� ������ Name, Size, Color;
//
// Revision 1.36  2005/03/18 08:23:15  mmorozov
// new: ���������� TevFontInterface.AssignFont;
//
// Revision 1.35  2005/03/17 07:26:53  mmorozov
// new: global procedure _evGetStyleFont;
//
// Revision 1.34  2005/03/16 19:21:53  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.33  2005/03/15 12:16:09  lulin
// - remove method: k2TagO.
//
// Revision 1.32  2005/03/11 14:00:02  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.31  2005/03/04 15:49:02  lulin
// - �������� ��������� Tk2Type.New.
//
// Revision 1.30  2005/01/12 16:22:22  lulin
// - ����������� ����� ��������� ��������� � �������� VCM �� ���������� AFW.
//
// Revision 1.29  2005/01/11 16:53:41  lulin
// - ������ Warning'�.
//
// Revision 1.28  2005/01/11 16:49:23  lulin
// - ���������� ��������������.
//
// Revision 1.27  2005/01/11 16:43:38  am
// change: ������ ����������� �����������
//
// Revision 1.26  2004/11/29 16:35:43  lulin
// - ��������� �� TFont � Il3Font - ��� ����� ���������� ��������� ������.
//
// Revision 1.25  2004/09/21 12:55:41  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.24  2004/06/30 11:32:20  law
// - rename proc: _k2Tag(TObject) -> k2TagO.
//
// Revision 1.23  2004/06/29 14:26:41  law
// - ����������� �� ������ Tk2AtomR._Set.
//
// Revision 1.22  2004/06/02 16:42:26  law
// - ������ ����� Tl3VList.
//
// Revision 1.21  2004/06/01 16:51:19  law
// - ������ ����������� Tl3VList.MakePersistent - ����������� _Tl3ObjectRefList.
//
// Revision 1.20  2004/04/20 10:44:17  demon
// - bug fix: AV ��� ������� "�������" ���������� ������������� �������, ������� ��������� �� ������� �����.
//
// Revision 1.19  2004/03/31 14:23:51  migel
// - new: ����� `ChangedEx(aCancel: Boolean)` ��� ����, ����� ����� ���� �������� �����������, ��� ��� �����.
//
// Revision 1.18  2004/03/18 13:39:10  law
// - bug fix: �� ����������� ��������� ����������.
//
// Revision 1.17  2004/02/06 20:02:43  migel
// - change: ��������� ������ ���������� ������ �� ������ (������ ������������� ����� ���������� ������ ���������������, ������� ����� �������� - ������ ��������� ������ ���������������, ������� ����� ���� ���������).
//
// Revision 1.16  2004/02/05 17:59:15  migel
// - add: ��������� ������ � ���� ������ (���� ����������� ������� ����� ����� �� ������ �������� � ������).
//
// Revision 1.15  2004/01/30 17:33:04  migel
// - add: ������������ �������������� �������� ��� ������ �� �������.
// - add: �������������� ���������������� ��� ���������� ������� ������ � �����.
//
// Revision 1.14  2003/11/29 19:16:22  law
// - bug fix: �� ��������� ������ ������� ��� ����������� ������� ������ (����� ������ CQ OIT5-5209).
//
// Revision 1.13  2003/10/20 13:59:25  law
// - new proc: _evGetDefaultFont.
// - new param:  TevStyleInterface.Make - aStyle : Long = _ev_saTxtNormalANSI.
//
// Revision 1.12  2003/10/17 12:48:11  law
// - new methods: TevStyleInterface.Make, IncFontSize, DecFontSize, IncAllFontSize, DecAllFontSize.
//
// Revision 1.11  2002/12/26 16:42:42  law
// - new directive: evNeedDefaultEvdReader, evNeedDefaultEvdWriter.
//
// Revision 1.10  2002/10/25 13:41:17  law
// - cleanup.
//
// Revision 1.9  2002/10/23 14:45:19  law
// - cleanup.
//
// Revision 1.8  2002/10/17 14:52:30  law
// - cleanup.
//
// Revision 1.7  2002/10/17 13:57:07  law
// - cleanup.
//
// Revision 1.6  2002/10/17 11:50:53  law
// - bug fix: ����������� ��������������� ����� � ������������ ��������.
//
// Revision 1.5  2002/09/23 07:30:38  law
// - new behavior: �������� Changing/_Changed � Load.
//
// Revision 1.4  2002/09/23 07:21:22  law
// - new unit: evStyleTableSpy.
// - new interface: IevStyleTableSpy.
// - new behavior: �������� ����������� �� ��������� ������� ������.
//
// Revision 1.3  2002/09/19 13:41:34  law
// - cleanup and comments.
//
// Revision 1.2  2002/09/19 12:52:38  law
// - cleanup.
//
// Revision 1.1  2002/09/18 14:31:36  law
// - change: ������ ������ �� ��������� ����������� �� ��������� ������.
// - new unit: evStyleTableTools.
//

{$Include evDefine.inc }

interface

uses
  Graphics,
  l3Interfaces,
  evDef
  ;

function evGetDefaultZoom(aDefSize : Integer = def_FontSize): Double;
  {-}  
procedure evGetDefaultFont(aFont: TFont);
  {* - �������� ����� ��� ����� �� ��������� (evd_saGUI). }
procedure evGetStyleFont(aFont  : TFont; aStyle : Integer); overload;
  {* - �������� ����� ���������� �����. }
procedure evGetStyleFont(const aFont: Il3Font; aStyle : Integer); overload;
  {* - �������� ����� ���������� �����. }
function evGetStyleBackColor(aStyle : Integer): TColor;
  {* - �������� ���� ���� ���������� �����. }
function evGetStyleFirstIndent(aStyle: Integer): Integer;

implementation

uses
  SysUtils,

  evStyleInterface,

  evdTextStyle_Const,
  TextPara_Const
  ;

procedure evGetDefaultFont(aFont: TFont);
  {* - �������� ����� ��� ����� �� ��������� (evd_saGUI). }
begin
 evGetStyleFont(aFont, evd_saGUI);
end;

function evGetDefaultZoom(aDefSize : Integer = def_FontSize): Double;
  {-}
var
 l_F : TFont;
begin
 l_F := TFont.Create;
 try
  evGetDefaultFont(l_F);
  Assert(aDefSize > 0);
  Result := l_F.Size / aDefSize;
 finally
  FreeAndNil(l_F);
 end;//try..finally
end;

procedure evGetStyleFont(aFont  : TFont;
                         aStyle : Integer);
  {* - �������� ����� ���������� �����. }
begin
 assert(aFont <> nil);
 with TevStyleInterface.Make(k2_typTextPara, aStyle) do
  try
   Font.Assign2Font(aFont);
  finally
   Free;
  end;//try..finally
end;

procedure evGetStyleFont(const aFont: Il3Font; aStyle : Integer);
  {* - �������� ����� ���������� �����. }
begin
 assert(aFont <> nil);
 with TevStyleInterface.Make(k2_typTextPara, aStyle) do
  try
   Font.Assign2Font(aFont);
  finally
   Free;
  end;//try..finally
end;

function  evGetStyleBackColor(aStyle : Integer): TColor;
  {* - �������� ���� ���� ���������� �����. }
begin
 with TevStyleInterface.Make(k2_typTextPara, aStyle) do
  try
   Result := Font.BackColor;
  finally
   Free;
  end;//try..finally
end;

function evGetStyleFirstIndent(aStyle: Integer): Integer;
begin
 with TevStyleInterface.Make(k2_typTextPara, aStyle) do
  try
   Result := FirstIndent;
  finally
   Free;
  end;//try..finally
end;

end.

