unit nevCommentPara;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: nev -           }
{ �����: 08.12.2005 12:03 }
{ $Id: nevCommentPara.pas,v 1.2 2011/09/15 18:32:09 lulin Exp $ }

// $Log: nevCommentPara.pas,v $
// Revision 1.2  2011/09/15 18:32:09  lulin
// {RequestLink:278824896}.
//
// Revision 1.1  2010/04/21 16:52:30  lulin
// {RequestLink:144575972}.
// - ��������� � ���������� ����� ��� ���������� ������.
//
// Revision 1.4  2008/09/17 08:54:19  lulin
// - ��������� TnevPara �� ������.
//
// Revision 1.3  2008/06/20 14:48:51  lulin
// - ���������� �������� ���������.
//
// Revision 1.2  2008/04/24 12:26:19  lulin
// - ��������� � ������ <K>: 89106312.
//
// Revision 1.1  2007/12/04 13:04:56  lulin
// - ���������� ��� �������� � ����������� ��������.
//
// Revision 1.4  2007/10/10 17:40:31  lulin
// - � ����� �������� ������������ ��������� ������ �������� ����� ��������������.
//
// Revision 1.3  2006/01/18 12:31:50  lulin
// - new behavior: ������ ����� ������ ��������� �����������.
//
// Revision 1.2  2005/12/08 10:26:05  lulin
// - new behavior: ������ ��������� ��� ������������� �� ������������������.
//
// Revision 1.1  2005/12/08 09:18:16  lulin
// - new behavior: ������ ����������� ������������ ��� ������������� ������� ������������������ ������������.
//

{$Include nevDefine.inc }

interface

uses
  nevBase,
  nevTools,

  nevDocumentPart
  ;

type
  TnevCommentPara = class(TnevDocumentPart)
    protected
    // interface methods
      function  GetIsHiddenPrim(aMap : TnevFormatInfoPrim;
                             aHiddenStyles : TnevStandardStyles): Boolean;
        override;
        {-}
  end;//TnevCommentPara

implementation

uses
  evdStyles
  ;

// start class TnevCommentPara

function TnevCommentPara.GetIsHiddenPrim(aMap : TnevFormatInfoPrim;
                                      aHiddenStyles : TnevStandardStyles): Boolean;
  //override;
  {-}
begin
 Result := (-ev_saUserComment in aHiddenStyles) OR
           inherited GetIsHiddenPrim(aMap, aHiddenStyles);
end;

end.

