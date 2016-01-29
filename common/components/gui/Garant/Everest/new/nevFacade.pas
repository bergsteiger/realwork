unit nevFacade;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: nevFacade -     }
{ �����: 05.04.2005 20:32 }
{ $Id: nevFacade.pas,v 1.21 2015/06/03 14:03:01 lulin Exp $ }

// $Log: nevFacade.pas,v $
// Revision 1.21  2015/06/03 14:03:01  lulin
// - �������� ��������� �����������.
//
// Revision 1.20  2014/04/07 17:57:03  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.19  2010/03/29 10:40:15  lulin
// {RequestLink:198672902}.
//
// Revision 1.18  2010/03/24 20:07:10  lulin
// {RequestLink:198672902}.
// - ��������� ����������� ���������.
//
// Revision 1.17  2010/03/23 09:43:36  lulin
// {RequestLink:149782847}.
//
// Revision 1.16  2010/02/11 13:31:11  lulin
// - ��������������� �����������������, ���������� ��-�� ������� uses.
//
// Revision 1.15  2009/04/17 11:48:55  lulin
// [$142613919]. �15.
//
// Revision 1.14  2009/04/15 07:48:37  lulin
// [$143396720]. ������ �������� ��������� � ��������� �������.
//
// Revision 1.13  2008/09/29 11:59:15  lulin
// - ��������� null-������� � �������.
//
// Revision 1.12  2008/09/29 11:31:35  lulin
// - ������ ����.
//
// Revision 1.11  2008/09/17 10:46:39  lulin
// - ����������� �� �������� ����������.
//
// Revision 1.10  2008/03/18 07:21:29  lulin
// - ���������� ���������.
//
// Revision 1.9  2008/03/17 15:51:01  lulin
// - �������������.
// - ���������� ��������.
//
// Revision 1.8  2008/02/27 17:25:00  lulin
// - ��������� ��� ��� ������.
//
// Revision 1.7  2007/12/21 17:21:27  lulin
// - cleanup.
//
// Revision 1.6  2007/12/04 12:47:51  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.3.4.11  2006/10/02 11:38:39  lulin
// - ���������� � ������ � ������� ������� ���������� �������������� �������� �����.
//
// Revision 1.3.4.10.18.1  2006/09/22 16:31:59  lulin
// - �� ��������� ���������� ������ ��������� �� �������, � �������� ������ ������ ����.
//
// Revision 1.3.4.10  2005/10/25 11:05:51  lulin
// - �� �������� �������� �������������� ����� ������, � �������� �� ����� �����.
//
// Revision 1.3.4.9  2005/10/06 07:31:59  lulin
// - cleanup.
//
// Revision 1.3.4.8  2005/09/23 16:04:04  lulin
// - ������� ������ � ������ ������������.
//
// Revision 1.3.4.7  2005/07/07 13:09:31  lulin
// - ����������� �������� �����������.
//
// Revision 1.3.4.6  2005/06/20 15:42:13  lulin
// - cleanup: ����������� �� ���������� ���������.
//
// Revision 1.3.4.5  2005/06/16 11:24:17  lulin
// - ������ ��������� ��������� ���������� (��� ������ _QI � QT).
//
// Revision 1.3.4.4  2005/06/03 10:37:37  lulin
// - new unit: nevNullParaList.
//
// Revision 1.3.4.3  2005/06/03 10:27:24  lulin
// - new unit: nevNullPara.
//
// Revision 1.3.4.2  2005/05/19 15:54:26  lulin
// - ������ ��� ������ � ���������� ���������� � "����������" �����.
//
// Revision 1.3.4.1  2005/05/18 12:42:59  lulin
// - ����� ����� �����.
//
// Revision 1.1.2.4  2005/04/12 14:14:38  lulin
// - new interface: InevAnchorEx.
//
// Revision 1.1.2.3  2005/04/12 13:47:30  lulin
// - ������ ������������� ������ ����� ��� ���������.
//
// Revision 1.1.2.2  2005/04/12 13:22:31  lulin
// - ��������� ���������� �������� ���������� �� InevAnchor.
//
// Revision 1.1.2.1  2005/04/12 10:18:46  lulin
// - ����� ����� ��������� � ����� �������.
//
// Revision 1.1.2.6  2005/04/11 16:06:15  lulin
// - new type: TnevFrame.
//
// Revision 1.1.2.5  2005/04/11 13:00:16  lulin
// - ���������� ������ ��� ��� ����������� ������ ���������.
//
// Revision 1.1.2.4  2005/04/09 10:34:30  lulin
// - ������ ������ ����������� ����� �������� ��������� �����.
//
// Revision 1.1.2.3  2005/04/08 15:23:12  lulin
// - ��������� ����� ���������� ��������� - ����� ����� ���� ������ �� ���������.
//
// Revision 1.1.2.2  2005/04/08 15:19:49  lulin
// - ����� ����� ���������� ��������� �������� ��������.
//
// Revision 1.1.2.1  2005/04/08 07:29:14  lulin
// - ��� ��������� ��������� �������� ���������� InevParaList �� ������� ���������.
//
// Revision 1.1  2005/04/05 17:03:52  lulin
// - new nethod: InevParaList.IterateParaF.
//

{$Include nevDefine.inc }

interface

{$If defined(k2ForEditor)}
uses
  l3Units,
  
  k2Interfaces,
  k2Facade,

  nevBase,
  nevTools
  ;

type
  Tnev = class
    public
    // public methods
      class function NullParaList: InevParaList;
        {-}
      class function NullPara: InevPara;
        {-}
      class function CrtIC: InevInfocanvas;
        {-}
      class function LineScrollDelta : Tl3Point;
        {-}
  end;//Tnev
  Rnev = class of Tnev;

var
  nev : Rnev = Tnev;

function  nevL2PIA(Action: Pointer): InevParaList_IteratePara_Action;
  {-}
procedure nevFreePIA(var aStub: InevParaList_IteratePara_Action);
  {-}
function  evL2TSA(Action: Pointer): InevRangePrim_Iterate_Action;
  {-}
procedure evFreeTSA(var aStub: InevRangePrim_Iterate_Action);
  {-}
{$IfEnd}  

implementation

{$If defined(k2ForEditor)}
uses
  SysUtils,

  l3Base,
  l3ScreenIC,

  nevNullPara,
  nevNullParaList
  ;

// start class Tnev

class function Tnev.NullParaList: InevParaList;
  {-}
begin
 Result := TnevNullParaList.Make;
end;

class function Tnev.NullPara: InevPara;
  {-}
begin
 Result := TnevNullPara.Make;
end;

class function Tnev.CrtIC: InevInfocanvas;
  //virtual;
  {-}
begin
 Result := l3CrtIC;
end;

var
 l_LineScrollDeltaSet : Boolean = false;
 l_LineScrollDelta    : TnevPoint;

class function Tnev.LineScrollDelta : Tl3Point;
  {-}
begin
 if not l_LineScrollDeltaSet then
 begin
  l_LineScrollDelta := CrtIC.DP2LP(l3SPoint(12, 12));
  l_LineScrollDeltaSet := true;
 end;//not l_LineScrollDeltaSet
 Result := Tl3Point(l_LineScrollDelta);
end;
  
function  nevL2PIA(Action: Pointer): InevParaList_IteratePara_Action;
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

procedure nevFreePIA(var aStub: InevParaList_IteratePara_Action);
  register;
  {-}
asm
          jmp  l3FreeLocalStub
end;{asm}

function  evL2TSA(Action: Pointer): InevRangePrim_Iterate_Action;
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

procedure evFreeTSA(var aStub: InevRangePrim_Iterate_Action);
  register;
  {-}
asm
          jmp  l3FreeLocalStub
end;{asm}
{$IfEnd}

end.

