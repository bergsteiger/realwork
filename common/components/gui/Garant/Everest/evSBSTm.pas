unit evSBSTm;

{ ���������� "�������"  }
{ �����: ����� �.�. �   }
{ ������: evSBSTm - }
{ �����: 31.08.1999 15:26 }
{ $Id: evSBSTm.pas,v 1.20 2014/04/03 17:10:25 lulin Exp $ }

// $Log: evSBSTm.pas,v $
// Revision 1.20  2014/04/03 17:10:25  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.19  2013/10/18 14:11:23  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.18  2009/07/22 07:05:00  lulin
// - ���������� ������������� ���� �����.
//
// Revision 1.17  2009/03/04 13:32:47  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.16  2008/06/20 14:48:51  lulin
// - ���������� �������� ���������.
//
// Revision 1.15  2005/03/28 14:29:59  lulin
// - �� ������ ����������� ��������� � ����������.
//
// Revision 1.14  2002/11/04 08:40:38  law
// - change: ����� �������� �� ��������� �������� SBSCell.VerticalAligment -> ev_valBottom.
//
// Revision 1.13  2002/11/04 06:53:34  law
// - new para types: k2_idSBSRow, k2_idSBSCell.
//
// Revision 1.12  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.11  2002/02/18 16:19:39  law
// - new behavior: ����� SBS-��������� ��������� � ��������� 1:2.
//
// Revision 1.10  2001/04/20 14:03:52  law
// - cleanup: def_cm* => def_inch*, evCm2Pixel -> evCm2Inch.
//
// Revision 1.9  2001/01/19 11:35:39  law
// - ������� ��������� Side By Side ������� ������������ ������ � ����.
//
// Revision 1.8  2000/12/15 15:10:37  law
// - ��������� ��������� Log.
//

{$I evDefine.inc }

interface

uses
  Classes,
  
  l3Base,

  k2Interfaces
  ;

type
 TGenNotifyEvent = procedure (const aGenerator: Ik2TagGenerator) of object;
{ ��������� ������� � ��������� "Side By Side"-�������� ������������� �������: }  
procedure OutSBSEx(const Generator: Ik2TagGenerator; OnOutLeftText, OnOutRightText: TGenNotifyEvent);
  {-� ��������� OnOutLeftText, OnOutRightText - � �������� Sender'� ���������� Generator}
procedure OutSBS(const Generator: Ik2TagGenerator; LeftText, RightText: Tl3CustomString);

implementation

uses
  SysUtils,
  l3Units,
  k2Tags,
  evDef,
  evTypes,
  evdStyles,

  SBS_Const,
  SBSRow_Const,
  SBSCell_Const,
  TextPara_Const
  ;
  
procedure OutSBSEx(const Generator: Ik2TagGenerator; OnOutLeftText, OnOutRightText: TGenNotifyEvent);
begin
 Generator.StartChild(k2_typSBS); {-��������� �������� SBS}
 try
  Generator.AddIntegerAtom(k2_tiWidth, def_inchSBSWidth); {-������ ��������� SBS}
  Generator.StartDefaultChild; {-��������� ������ �������}
  try
   Generator.AddIntegerAtom(k2_tiWidth, def_inchSBSWidth); {-������ ������ �������}
   Generator.StartDefaultChild; {-��������� ������ �������}
   try
    Generator.AddIntegerAtom(k2_tiWidth, 2 * def_inchSBSWidth div 3);
    {-������ ������}
    Generator.AddIntegerAtom(k2_tiLeftIndent, 0);
    {-����� ������ �� ����� �������}
    Generator.StartDefaultChild; {-��������� ��������� ��������}
    try
     Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalSBSLeft);
     OnOutLeftText(Generator);
     {-��������� ����� ������ ���������}
    finally
     Generator.Finish; {-��������� ��������� ��������}
    end;{try..finally}
   finally
    Generator.Finish; {-��������� ������ �������}
   end;{try..finally}

   Generator.StartDefaultChild; {-��������� ������ �������}
   try
    Generator.AddIntegerAtom(k2_tiWidth, def_inchSBSWidth div 3);
    {-������ ������}
    Generator.AddIntegerAtom(k2_tiLeftIndent, def_inchSBSIndent);
    {-������������� ����� ������ ������ ������}
    Generator.AddIntegerAtom(k2_tiRightIndent, 0);
    {-������������� ������ ������ ������ ������}
    Generator.StartDefaultChild; {-��������� ��������� ��������}
    try
     Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalSBSRight);
     OnOutRightText(Generator);
     {-��������� ����� ������� ���������}
    finally
     Generator.Finish; {-��������� ��������� ��������}
    end;{try..finally}
   finally
    Generator.Finish; {-��������� ������ �������}
   end;{try..finally}

  finally
   Generator.Finish; {-��������� ������ �������}
  end;{try..finally}
 finally
  Generator.Finish; {-��������� �������� SBS}
 end;{try..finally}

end;

procedure OutTextStub(Text: Tl3CustomString; const Generator: Ik2TagGenerator); far;
  {-������ ���������� ��������� ����������� ����� �������}
begin
 Generator.AddStringAtom(k2_tiText, Text.AsWStr);
end;

procedure OutSBS(const Generator: Ik2TagGenerator; LeftText, RightText: Tl3CustomString);
var
 M1, M2 : TGenNotifyEvent;
begin
 with TMethod(M1) do begin Code := @OutTextStub; Data := LeftText; end;
 with TMethod(M2) do begin Code := @OutTextStub; Data := RightText; end;
 OutSBSEx(Generator, M1, M2);
end;

end.

