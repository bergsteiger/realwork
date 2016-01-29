unit l3Const;
{* ��������� ���������� L3. }

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�.                   }
{ ������: l3Const -                   }
{ �����: 13.04.1998 14:05             }
{ $Id: l3Const.pas,v 1.28 2011/05/18 17:46:00 lulin Exp $ }

// $Log: l3Const.pas,v $
// Revision 1.28  2011/05/18 17:46:00  lulin
// {RequestLink:266409354}.
//
// Revision 1.27  2010/06/02 11:13:59  dinishev
// [$216074494]
//
// Revision 1.26  2010/03/18 14:15:46  lulin
// {RequestLink:197951943}.
//
// Revision 1.25  2009/09/23 13:43:21  dinishev
// [$163068489]. ����� ���������� ������� ���������.
//
// Revision 1.24  2009/09/23 08:09:04  dinishev
// ���� �������������� � ������� ����� ��������.
//
// Revision 1.23  2007/01/22 15:20:13  oman
// - new: ����������� ��������� - l3 (cq24078)
//
// Revision 1.22  2005/05/26 16:01:48  lulin
// - ������� ������� ����� ������ �� ������ � ���������� ��������.
//
// Revision 1.21  2005/05/24 14:50:09  lulin
// - ������� ������ evGraph � �������� � L3.
//
// Revision 1.20  2005/05/24 13:43:34  lulin
// - rename unit: evLineAr -> l3LineArray.
//
// Revision 1.19  2005/05/24 13:21:57  lulin
// - new const: l3Inch.
//
// Revision 1.18  2001/09/26 14:33:48  law
// - cleanup: ������� ���������� l3NilVar.
//
// Revision 1.17  2001/09/26 14:06:59  law
// - cleanup: l3NilObject ������� �� _l3NilOp.
//
// Revision 1.16  2001/09/03 09:27:07  law
// - bug fix.
//
// Revision 1.15  2001/09/03 09:21:12  law
// - bug fix.
//
// Revision 1.14  2001/08/31 12:19:58  law
// - cleanup: ������ ���� � ��������������������.
//
// Revision 1.13  2001/08/29 07:01:10  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.12  2000/12/15 15:19:00  law
// - ��������� ��������� Log.
//

{$I l3Define.inc }

interface

uses
  Windows;

const  
  l3BitInLong = 32;
   {* ����� ��� � �����. }
  l3ParseBufSize = 32{8} * 1024;
  l3NotFound  = -1;
   {* ������� ����������� ���������. }

const
  l3NilLong = High(Longint);
   {* NULL ��� �����. }
  l3Inch = 1440;
   {* ����. }
  l3mmInInch = 254;
    {* - ����� ����������� � �����. }
  l3FontIndexDelta = l3Inch div 16;
   {-}
  l3Epsilon = l3Inch div 120;
    {* - ������ ��������. }
  l3AlingDelta = l3Epsilon * 7;
   { ������� ������������ (�������� ������������ �� ������� �� ������ ������� ��������� �������). }
  l3ShapeNil = Low(Longint) div 2;
   {* - NULL ��� ��������� �������� ��������. }

const
  S_Ok                  = Windows.S_Ok;
   {* �������� ����������. }
  S_False               = Windows.S_False;
   {* ���������� ����������. }
  E_NoInterface         = Windows.E_NoInterface;
   {* ��������� �� ��������������. }
  E_ClassNotAvailable   = Windows.CLASS_E_CLASSNOTAVAILABLE;
   {* ����� ����������. }
  E_Fail = Windows.E_Fail;
   {-}
  {$IfNDef Delphi6}
  E_UNEXPECTED = Windows.E_UNEXPECTED;
   {-}
  E_NOTIMPL = Windows.E_NOTIMPL;
   {-}
  {$EndIf Delphi6}

  {���� ������}
  VK_ALT  = VK_MENU;

resourcestring
  l3ErrSeekPastEOF     = 'Seek past EOF';
  l3ErrSeekError       = 'Seek error';
  l3ErrPutbackOverflow = 'Putback overflow';
  l3ErrInvalidOrigin   = 'Invalid origin in seek method';
  
  l3NULLStr = '<NULL>';

implementation

end.

