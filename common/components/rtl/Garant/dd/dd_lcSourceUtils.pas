unit dd_lcSourceUtils;
{ ��������������� �������  ��� ������ � ��������� ������� }

{ $Id: dd_lcSourceUtils.pas,v 1.17 2015/05/29 11:10:30 fireton Exp $ }
// $Log: dd_lcSourceUtils.pas,v $
// Revision 1.17  2015/05/29 11:10:30  fireton
// - ������� ������ ������ ������ � ������ ������, ����� �����������
//   ���������� ���������
//
// Revision 1.16  2014/12/26 12:58:13  fireton
// - ����� ����������� ����
//
// Revision 1.15  2014/08/21 12:32:26  fireton
// - ��������� ��������� ��� ������
//
// Revision 1.14  2014/08/04 11:16:16  fireton
// - ��������� ����� �������� �����
//
// Revision 1.13  2013/07/19 06:40:04  fireton
// - ���������� ��� �����-�������� ���
//
// Revision 1.12  2013/04/11 16:46:29  lulin
// - ���������� ��� XE3.
//
// Revision 1.11  2012/05/11 13:04:33  narry
// �� ������������� ��������� ���� (363566409)
//
// Revision 1.10  2012/04/12 10:28:10  narry
// ���������� ����� �����
//
// Revision 1.9  2012/02/28 07:02:31  narry
// ���������� ��� ��������� � ���� (342330845)
//
// Revision 1.8  2012/02/27 10:35:52  narry
// ������ ������� � ������ ���������� ��� ������ ��������� ����������� ����� (341838087)
//
// Revision 1.7  2011/10/21 13:12:39  narry
// ������������ ���������
//
// Revision 1.6  2011/06/17 07:04:34  narry
// ������������ �������� (265388524)
//
// Revision 1.5  2011/06/09 11:56:23  narry
// �������� ���������� ��� ��� ������� �� ������� (268340187)
//
// Revision 1.4  2011/04/11 10:25:01  narry
// �������� ��� ��� (259885290)
//
// Revision 1.3  2011/04/01 12:15:54  narry
// 259885188 ������� ��� ���
//
// Revision 1.2  2011/04/01 11:33:27  narry
// 259885596 ������ ���������� ��� ���
//
// Revision 1.1  2011/04/01 09:07:00  narry
// �259884509.��������� �������
//


interface

uses dt_Const;

type
 Tdd_lcDossierType = (lc_dtAAC, lc_dtVAC, lc_dtFAC, lc_dtFirst);

 Tdd_lcSource = record
  Name: AnsiString;
  Alias: AnsiString;
  Dossier: Tdd_lcDossierType;
  Base: AnsiString;
 end;

function Source2DossierType(const aSource: AnsiString): Tdd_lcDossierType;

function FindSource(const aSource: AnsiString): Integer;

function Source2Alias(const aSource: AnsiString): AnsiString;

function Alias2Source(const Alias: AnsiString): AnsiString;

function Source2Base(const aSource: AnsiString): AnsiString;

function IsFASAlias(const aAlias: AnsiString): Boolean;

const
 // �����! ��������� ����� ������������ ������ �� ��������� �������� ���������, ����������, ����� ������ � �������
 // ������ ������ � ������ ������. ����� "������ ����������� ������������� ���" �� ��������� ������ "�������� ������
 // ����������� ������������� ���"
 lcSources : Array[0..128] of Tdd_lcSource = (
 (Name:'�������� ������ ����������� ������������� ���'; Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLCEO'),
 (Name:'������ ����������� ������������� ���';          Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLVV'),
 (Name:'������ ����������� ������������� ���';          Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLVV'),
 (Name:'������ ����������� ������������� ���';          Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLVSO'),
 (Name:'��������� ����������� ������������� ���';       Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLVSO'),
 (Name:'����� ����������� ������������� ���';           Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLDVO'),
 (Name:'������ ����������� ������������� ���';          Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLDVO'),
 (Name:'������� ����������� ������������� ���';         Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLZPS'),
 (Name:'������� ����������� ������������� ���';         Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLZPS'),
 (Name:'������� ����������� ������������� ���';         Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLMO'),
 (Name:'������� ����������� ������������� ���';         Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLMO'),
 (Name:'������������ ����������� ������������� ���';    Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLPVL'),
 (Name:'����������� ����������� ������������� ���';     Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLPVL'),
 (Name:'����������� ����������� ������������� ���';     Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLSZO'),
 (Name:'������������� ����������� ������������� ���';   Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLSZO'),
 (Name:'����������� ����������� ������������� ���';     Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLSKO'),
 (Name:'������������ ����������� ������������� ���';    Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLSKO'),
 (Name:'����������� ����������� ������������� ���';     Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLURO'),
 (Name:'������������� ����������� ������������� ���';   Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLURO'),
 (Name:'������������� ����������� ������������� ���';   Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLCEO'),
 (Name:'��������� ����������� ������������� ���';       Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLCEO'),

 (Name:'(��� ��)';                                    Alias:ftnDocIDVAS;     Dossier:lc_dtVAC; base:'ARB'),
 (Name:'��������� ��� ������';                        Alias:ftnDocIDVAS;     Dossier:lc_dtVAC; base:'ARB'),
 
 (Name:'(��� �����-�������� ������)';                 Alias:ftnDocIDFAS6;    Dossier:lc_dtFAC; base:'FASVV'),
 (Name:'(��� ��������-���������� ������)';            Alias:ftnDocIDFAS2;    Dossier:lc_dtFAC; base:'FASVSO'),
 (Name:'(��� ���������������� ������)';               Alias:ftnDocIDFAS1;    Dossier:lc_dtFAC; base:'FASDVO'),
 (Name:'(��� �������-���������� ������)';             Alias:ftnDocIDFAS3;    Dossier:lc_dtFAC; base:'FASZPS'),
 (Name:'(��� ����������� ������)';                    Alias:ftnDocIDFAS10;   Dossier:lc_dtFAC; base:'FASMO'),
 (Name:'(��� ����������� ������)';                    Alias:ftnDocIDFAS5;    Dossier:lc_dtFAC; base:'FASPVL'),
 (Name:'(��� ������-��������� ������)';               Alias:ftnDocIDFAS9;    Dossier:lc_dtFAC; base:'FASSZO'),
 (Name:'(��� ������-����������� ������)';             Alias:ftnDocIDFAS8;    Dossier:lc_dtFAC; base:'FASSKO'),
 (Name:'(��� ���������� ������)';                     Alias:ftnDocIDFAS4;    Dossier:lc_dtFAC; base:'FASURO'),
 (Name:'(��� ������������ ������)';                   Alias:ftnDocIDFAS7;    Dossier:lc_dtFAC; base:'FASCEO'),

 (Name:'(�� �����-�������� ������)';                  Alias:ftnDocIDFAS6;    Dossier:lc_dtFAC; base:'FASVV'),
 (Name:'(�� ��������-���������� ������)';             Alias:ftnDocIDFAS2;    Dossier:lc_dtFAC; base:'FASVSO'),
 (Name:'(�� ���������������� ������)';                Alias:ftnDocIDFAS1;    Dossier:lc_dtFAC; base:'FASDVO'),
 (Name:'(�� �������-���������� ������)';              Alias:ftnDocIDFAS3;    Dossier:lc_dtFAC; base:'FASZPS'),
 (Name:'(�� ����������� ������)';                     Alias:ftnDocIDFAS10;   Dossier:lc_dtFAC; base:'FASMO'),
 (Name:'(�� ����������� ������)';                     Alias:ftnDocIDFAS5;    Dossier:lc_dtFAC; base:'FASPVL'),
 (Name:'(�� ������-��������� ������)';                Alias:ftnDocIDFAS9;    Dossier:lc_dtFAC; base:'FASSZO'),
 (Name:'(�� ������-����������� ������)';              Alias:ftnDocIDFAS8;    Dossier:lc_dtFAC; base:'FASSKO'),
 (Name:'(�� ���������� ������)';                      Alias:ftnDocIDFAS4;    Dossier:lc_dtFAC; base:'FASURO'),
 (Name:'(�� ������������ ������)';                    Alias:ftnDocIDFAS7;    Dossier:lc_dtFAC; base:'FASCEO'),

 (Name:'����������� ��� ���������� ����';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �������� �������';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������� �������';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������ �������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������ �������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �������� �������';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������ �������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������� �������';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �.������';                                    Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� ���������� �������';                Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �������������� ����';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������-���������� ����������';             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������������� �������';                     Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� ����';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������-���������� ����������';             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �������������� ����';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������� ����';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������� �������';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �������� �������';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������� �������';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������ �������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������� �������';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������ �������';                              Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������ �������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� ����';                              Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� ����';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �����';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ������������';                     Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ��������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ���������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ��������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ����';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ����� ��';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ��������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ���� (������)';                    Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������� ������ - ������';         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ���������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ����';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �.�����-���������� � ������������� �������';  Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������ �������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������������� ����';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� �������';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �������� �������';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������� �������';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �������� �������';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ����������';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ������������ ����';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �����-����������� ����������� ������ - ����'; Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� ����������';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� �������';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ��������� ���������� - �������';              Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ����������� ������';               Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �����-��������� ����������� ������';          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ����������� �������';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'��� ������������ ���� ��������� ���� � �.���������';          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� �.�����������';                               Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'����������� ��� ���������� ����';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'������������� ��� ���������� ����';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1')
 );

const
 lc_defAlias   = ftnDocIDLawCase;
 lc_defDossier = lc_dtAAC;
 lc_defBase    = 'ARB';

implementation

uses StrUtils, SysUtils, l3Base;

function Source2DossierType(const aSource: AnsiString): Tdd_lcDossierType;
var
 index: Integer;
begin
 index:= FindSource(aSource);
 if index <> -1 then
  Result:= lcSources[index].Dossier
 else
  Result := lc_defDossier;
end;

function FindSource(const aSource: AnsiString): Integer;
var
 i: Integer;
 l_Source: AnsiString;
begin
 Result := -1;
 l_Source:= Trim(aSource);
 for i:= 0 to Length(lcSources)-1 do
  if AnsiEndsText(lcSources[i].Name, l_Source) then
  begin
   Result:= i;
   Break;
  end; // AnsiEndsText(lcSources[i].Name, aSource)
 if Result = -1 then
  l3System.Msg2Log('����������� ���. ����� "%s"', [l_Source]);
end;

function Source2Alias(const aSource: AnsiString): AnsiString;
var
 index: Integer;
begin
 index:= FindSource(aSource);
 if index <> -1 then
  Result:= lcSources[index].Alias
 else
  Result := lc_defAlias;
end;

function Alias2Source(const Alias: AnsiString): AnsiString;
var
 i: Integer;
begin
 Result := '';
 for i:= 0 to Length(lcSources)-1 do
  if AnsiSameText(lcSources[i].Alias, Alias) then
  begin
   Result:= lcSources[i].Name;
   break
  end;
end;

function Source2Base(const aSource: AnsiString): AnsiString;
var
 index: Integer;
begin
 index:= FindSource(aSource);
 if index <> -1 then
  Result:= lcSources[index].Base
 else
  Result := lc_defBase;
end;

function IsFASAlias(const aAlias: AnsiString): Boolean;
begin
 Result := (aAlias = ftnDocIDFAS6) or
           (aAlias = ftnDocIDFAS2) or
           (aAlias = ftnDocIDFAS1) or
           (aAlias = ftnDocIDFAS3) or
           (aAlias = ftnDocIDFAS10) or
           (aAlias = ftnDocIDFAS5) or
           (aAlias = ftnDocIDFAS9) or
           (aAlias = ftnDocIDFAS8) or
           (aAlias = ftnDocIDFAS4) or
           (aAlias = ftnDocIDFAS7);
end;

end.
