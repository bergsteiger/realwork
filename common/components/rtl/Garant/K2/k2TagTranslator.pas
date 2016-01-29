unit k2TagTranslator;
{* ������, ������� �������� ����������� ��� ���� � ������ ���������. }

{ ���������� "K-2"        }
{ �����: ����� �.�. �     }
{ ������: k2TagTranslator - }
{ �����: 22.10.2004 15:13 }
{ $Id: k2TagTranslator.pas,v 1.17 2014/03/28 06:14:26 dinishev Exp $ }

// $Log: k2TagTranslator.pas,v $
// Revision 1.17  2014/03/28 06:14:26  dinishev
// Bug fix: �� ���������� ������ ������.
//
// Revision 1.16  2014/03/20 12:38:17  lulin
// - ������������� ������ � ������.
//
// Revision 1.15  2014/02/28 14:54:26  lulin
// - ������������� ����������.
//
// Revision 1.14  2013/10/18 15:38:59  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.13  2009/03/04 18:14:18  lulin
// - <K>: 137470629. ����� �������� ���������.
//
// Revision 1.12  2008/05/21 15:07:31  lulin
// - <K>: 90443881.
//
// Revision 1.11  2008/05/20 10:55:38  lulin
// - bug fix: �� �������������� ����������.
// - <K>: 90443881.
//
// Revision 1.10  2007/08/14 14:44:20  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.9  2007/08/10 14:44:46  lulin
// - cleanup.
//
// Revision 1.8  2007/08/09 12:38:17  lulin
// - ������� ������������ ������ � ����������� ������� �����.
//
// Revision 1.7  2007/08/09 12:06:19  lulin
// - cleanup.
//
// Revision 1.6  2006/11/25 16:59:45  lulin
// - bug fix: �� ��������������� ����������.
//
// Revision 1.5  2005/04/04 06:44:07  lulin
// - � ����� � ���������� ��������� ������� � ������ ���������� K-2, ������� ���������� "��������" ��������� � ���������/������������ ������� �����.
//
// Revision 1.4  2005/03/28 11:32:28  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.3  2004/11/26 13:30:27  lulin
// - new unit: k2ForkGenerator.
//
// Revision 1.2  2004/11/04 17:43:46  lulin
// - new interface: _Ik2TypeTable.
//
// Revision 1.1  2004/10/22 12:02:35  lulin
// - new unit: k2TagTranslator.
//

{$Include k2Define.inc }

interface

uses
  l3Types,
  l3Base,
  l3Variant,

  k2Interfaces,
  k2InternalInterfaces,
  k2Types,
  k2TagGen
  ;

type
  Tk2TagTranslator = class(Tk2TagGenerator{, Ik2TypeTableSource})
   {* ������, ������� �������� ����������� ��� ���� � ������ ���������. }
    protected
    // internal methods
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Boolean);
        override;
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      procedure CloseStructure(NeedUndo: Boolean);
        override;
        {-���������� �� ������������� ������}
      procedure AddAtom(AtomIndex: Long; aValue: Tl3Variant);
        override;
        {-}
  end;//Tk2TagTranslator

implementation

uses
  SysUtils,

  Classes,

  l3InterfacesMisc,

  k2Facade,
  k2Base
  ;

// start class Tk2TagTranslator

procedure Tk2TagTranslator.OpenStream;
  {override;}
  {-}
begin
 inherited;
 if (Generator <> nil) then
  Generator.Start;
end;

procedure Tk2TagTranslator.CloseStream(NeedUndo: Boolean);
  {override;}
  {-}
begin
 if (Generator <> nil) then
  Generator.Finish(NeedUndo);
 inherited;
end;

procedure Tk2TagTranslator.StartTag(TagID: Long);
  //override;
  {-}
begin
 inherited;
 if (Generator <> nil) then
  Generator.StartTag(TagID);
end;

procedure Tk2TagTranslator.StartChild(TypeID: Tl3VariantDef);
  //override;
  {-}
begin
 inherited;
 if (Generator <> nil) then
  Generator.StartChild(TypeID);
end;

procedure Tk2TagTranslator.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
begin
 if (Generator <> nil) then
  Generator.AddAtomEx(AtomIndex, Value);
end;

procedure Tk2TagTranslator.AddAtom(AtomIndex: Long; aValue: Tl3Variant);
  {override;}
  {-}
begin
 inherited;
 // - ������� ������ ������ �����, ��� ������ � ���������� ������ (!!!)
 if (AtomIndex >= 0) then
  TranslateAddAtom(AtomIndex, aValue);
end;

procedure Tk2TagTranslator.CloseStructure(NeedUndo: Boolean);
  //override;
  {-���������� �� ������������� ������}
begin
 if (Generator <> nil) then
  Generator.Finish(NeedUndo);
 inherited; 
end;

end.

