unit vcmXMLWriter;
{* ��������� XML. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmXMLWriter -  }
{ �����: 02.03.2005 13:37 }
{ $Id: vcmXMLWriter.pas,v 1.10 2013/07/05 09:10:33 lulin Exp $ }

// $Log: vcmXMLWriter.pas,v $
// Revision 1.10  2013/07/05 09:10:33  lulin
// - ������ ���.
//
// Revision 1.9  2013/04/05 12:02:33  lulin
// - ���������.
//
// Revision 1.8  2009/02/20 13:44:16  lulin
// - <K>: 136941122.
//
// Revision 1.7  2009/02/19 14:03:31  lulin
// - <K>: 136941122. �������� ���������� ���������.
//
// Revision 1.6  2007/02/13 08:35:18  lulin
// - ����� ������������ � ������������ � ��� ����������������.
//
// Revision 1.5  2006/11/25 15:22:33  lulin
// - ������ ������ ������.
//
// Revision 1.4  2006/11/21 12:52:54  lulin
// - �������� XML �������� � ������� ����������.
//
// Revision 1.3  2006/03/09 18:43:24  lulin
// - �������� ���������.
// - ���������� ��� ��������.
//
// Revision 1.2  2006/03/09 17:58:03  lulin
// - ��� ��� ������� ���������.
//
// Revision 1.1  2005/03/02 11:28:38  lulin
// - new unit: vcmXMLWriter (������� �� vcmMainForm).
//

{$Include vcmDefine.inc }

interface

{$IfDef vcmNeedL3}
uses
  ActiveX,

  l3XMLWriter,

  vcmUserControls,
  vcmInterfaces,
  vcmWritersInterfaces,

  vcmExportConst
  ;

type
  TvcmXMLWriter = class(Tl3XMLWriter, IvcmXMLWriter)
   {* ��������� XML. }
    protected
    // interface methods
      // IvcmXMLWriter
      procedure SaveUF(const aString : AnsiString;
                       const anUF    : IvcmUserFriendlyControl;
                       aNeedClose    : Boolean = true);
        overload;
        {* - ��������� ������ � �����. }
      procedure SaveUF(const aString : AnsiString;
                       const anUF    : IvcmUserFriendlyControl;
                       const aSuffix : AnsiString;
                       aNeedClose    : Boolean = true);
        overload;
        {* - ��������� ������ � �����. }
    public
    // public methods
      class function Make(const aFileName: AnsiString): IvcmXMLWriter;
        reintroduce;
        overload;
        {* - ������� ���������, ��� ������ XML � ����. }
      class function Make(const aStream: IStream): IvcmXMLWriter;
        reintroduce;
        overload;
        {* - ������� ���������, ��� ������ XML � �����. }
  end;//TvcmXMLWriter
{$EndIf vcmNeedL3}

implementation

{$IfDef vcmNeedL3}

uses
  SysUtils,

  l3String
  ;

// start class TvcmXMLWriter

class function TvcmXMLWriter.Make(const aFileName: AnsiString): IvcmXMLWriter;
  //reintroduce;
  //overload;
  {* - ������� ���������, ��� ������ XML � ����. }
begin
 Result := inherited Make(aFileName) As IvcmXMLWriter;
end;

class function TvcmXMLWriter.Make(const aStream: IStream): IvcmXMLWriter;
  //reintroduce;
  //overload;
  {* - ������� ���������, ��� ������ XML � �����. }
begin
 Result := inherited Make(aStream) As IvcmXMLWriter;
end;

procedure TvcmXMLWriter.SaveUF(const aString : AnsiString;
                               const anUF    : IvcmUserFriendlyControl;
                               aNeedClose    : Boolean = true);
  //overload;
  {* - ��������� ������ � �����. }
begin
 SaveUF(aString, anUF, '', aNeedClose);
end;

procedure TvcmXMLWriter.SaveUF(const aString : AnsiString;
                               const anUF    : IvcmUserFriendlyControl;
                               const aSuffix : AnsiString;
                               aNeedClose    : Boolean = true);
  //overload;
  {* - ��������� ������ � �����. }
var
 l_Suffix : AnsiString;
begin
 l_Suffix := Format(cTitID + ' hint="%s" longhint="%s" description="%s"',
                   [CS(anUF.Caption), CS(anUF.Name),
                    CS(anUF.Hint), CS(anUF.LongHint),
                    CS(anUF.LongHint)]);
 if (anUF.ImageIndex > 0) then
  l3CatSuff(l_Suffix, Format('icon="%d.bmp"', [anUF.ImageIndex]));
 l3CatSuff(l_Suffix, aSuffix);
 OpenLevel(aString, l_Suffix);
 if aNeedClose then
  CloseLevel;
end;

{$EndIf vcmNeedL3}

end.

