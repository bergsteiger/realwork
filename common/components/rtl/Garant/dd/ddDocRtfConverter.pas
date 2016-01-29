unit ddDOCRTFConverter;

// $Id: ddDocRtfConverter.pas,v 1.4 2003/04/19 12:30:37 law Exp $ 

// $Log: ddDocRtfConverter.pas,v $
// Revision 1.4  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.3  2002/12/24 13:01:59  law
// - change: ��������� Int64_Seek c �������� ������.
//
// Revision 1.2.6.1  2002/12/24 11:56:42  law
// - new behavior: ���������� 64-������ Seek ������ 32-�������.
//
// Revision 1.2  2001/06/21 15:40:39  law
// - new CVS directives: ID, Log.
//

{$I ddDefine.inc }

interface

Uses
  Classes,
  l3Filer,
  ddDocReader;

Type
  TddDoc2RTFConverter = class(TddDocReader)
  private
    f_OutFiler: Tl3CustomFiler;
  protected

  public
    procedure Read; override;
    property OutFiler: Tl3CustomFiler
      read f_OutFiler write f_OutFiler;
  end;

implementation

Uses
  l3Types, l3Stream;

procedure TddDoc2RTFConverter.Read;
begin
  f_OutFiler.Mode:= l3_fmWrite;
  f_OutFiler.Open;
  Filer.Stream.Seek(0, soBeginning);
  l3CopyStream(Filer.Stream, OutFiler.Stream);
  f_OutFiler.Close;
end;

end.
 