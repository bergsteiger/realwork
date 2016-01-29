unit evEvdRd;
{* �������� ����� � ������� evd. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evEvdRd - ��������� ������� � ������� evd }
{ �����: 05.10.1999 13:53 }
{ $Id: evEvdRd.pas,v 1.91 2013/02/18 14:11:51 lulin Exp $ }

// $Log: evEvdRd.pas,v $
// Revision 1.91  2013/02/18 14:11:51  lulin
// - bug fix: ��� ������� �������� ������ ������ �� ������.
//
// Revision 1.90  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.89  2010/06/18 11:41:04  lulin
// {RequestLink:219119831}.
// - ������ ������.
// - ��������� ����.
// - ����� ����� � ���.
// - ��������� �������� �� ������������ ����� �������������� ������.
//
// Revision 1.88  2008/02/19 18:48:14  lulin
// - ������� �������� ������.
//
// Revision 1.87  2008/02/07 19:12:55  lulin
// - ����������� �� ������� ������������� ������� ������� �������.
//
// Revision 1.86  2007/12/04 13:04:55  lulin
// - ���������� ��� �������� � ����������� ��������.
//
// Revision 1.2  2007/08/29 12:22:43  lulin
// - cleanup.
//
// Revision 1.1  2007/08/29 11:10:00  lulin
// - ����� ��������� � ����� �����.
//
// Revision 1.81.4.9  2007/08/09 14:55:19  lulin
// - ����������� �� ��������� ������������� �����������.
//
// Revision 1.81.4.8  2007/08/09 11:19:12  lulin
// - cleanup.
//
// Revision 1.81.4.7  2005/07/21 12:21:24  lulin
// - �������� ������� EVD �������� � ����� EVD.
//
// Revision 1.81.4.6  2005/07/21 11:41:18  lulin
// - ������ ������ �����������.
//
// Revision 1.81.4.5  2005/07/21 11:34:22  lulin
// - �������� ��������� ������ �� ���������� �����.
//
// Revision 1.81.4.4  2005/06/23 13:08:23  lulin
// - ���� � ��������� ������� �������� � ����� EVD.
//
// Revision 1.81.4.3  2005/06/23 12:55:33  lulin
// - ���� � ����������� �������� � ����� EVD.
//
// Revision 1.81.4.2  2005/06/22 17:14:51  lulin
// - cleanup.
//
// Revision 1.81.4.1  2005/05/18 12:42:46  lulin
// - ����� ����� �����.
//
// Revision 1.80.2.2  2005/05/18 12:32:08  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.80.2.1  2005/04/28 09:18:29  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.80.4.1  2005/04/26 16:07:07  lulin
// - ��������� ����� ������ �������.
//
// Revision 1.81  2005/04/28 15:03:37  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.80.4.1  2005/04/26 16:07:07  lulin
// - ��������� ����� ������ �������.
//
// Revision 1.80  2005/03/28 11:32:07  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.79  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.78  2004/10/20 10:40:36  lulin
// - new behavior: ����������� ������� ������������� ���� ��������.
//
// Revision 1.77  2004/10/14 08:54:57  lulin
// - new behavior: ������ ����������� ���������������� ����� ���������� ������.
//
// Revision 1.76  2004/09/27 10:58:21  lulin
// - new behavior: �������� ������������ ����� ����.
//
// Revision 1.75  2004/09/21 12:55:40  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.74  2004/08/03 12:49:30  law
// - bug fix: ����������� ������� �������� � ������������� (CQ OIT5-8367).
//
// Revision 1.73  2004/06/10 13:04:39  law
// - new property: TevCustomEvdStorageWriter.AccessByIndex.
//
// Revision 1.72  2004/06/02 15:12:07  law
// - ������������ Make ���������� � _Tl3PVList �� _Tl3PtrRecList.
//
// Revision 1.71  2004/05/31 10:31:06  law
// - ��� ������� �� define.
//
// Revision 1.70  2004/05/14 17:26:59  law
// - remove unit: evStrGen.
//
// Revision 1.69  2004/05/14 16:22:57  law
// - remove class: TevTextObjectGenerator.
// - remove class: TevTextObjectParser.
//
// Revision 1.68  2004/04/26 14:28:16  law
// - new behavior: Tl3Filer ������ ��� ������ ����������� ��������� ���������.
// - bug fix: � �������� TevMemo.Buffer ������ ��������� ������������� ������ � ���������� Unicode.
//
// Revision 1.67  2004/03/31 17:59:26  law
// - bug fix: ��������� �����/������ Unicode-������ � �������� EVD.
//
// Revision 1.66  2003/12/26 13:38:26  law
// - bug fix: ������ (����� �������� �������) ������� �������� ������ CQ OIT5-4532.
//
// Revision 1.65  2003/12/26 12:49:28  law
// - bug fix: ������� �������� ������ CQ OIT5-4532.
//
// Revision 1.64  2003/12/03 13:16:53  law
// - new method: Tk2TagGenerator.SetTo - ��� ���������� ���������� ����������� � �������.
//
// Revision 1.63  2003/12/01 12:39:10  law
// - new method: _TeeHyperlinkFilter.SetFilter.
// - new method: TevCustomEvdReader.SetReader.
// - new field: TeeAddress.rRevision.
//
// Revision 1.62  2003/11/29 15:36:17  law
// - new class: _TeeHyperlinkFilter.
// - new proc: eeSetHyperlinkFilter.
//
// Revision 1.61  2003/11/17 12:43:32  law
// - new prop: TevCustomEvdReader.NotReadAsText, �� ��������� - false.
//
// Revision 1.60  2003/05/19 15:37:44  law
// - bug fix: ����������� ���������� ��������� � ����������� ������.
//
// Revision 1.59  2003/04/29 16:08:20  law
// - bug fix: �������� �������� ��������� ��� ������ - �������� ������������� �����.
//
// Revision 1.58  2002/12/24 13:02:01  law
// - change: ��������� Int64_Seek c �������� ������.
//
// Revision 1.57.2.1  2002/12/23 15:51:26  law
// - bug fix: �� �������� � ���������� > 2��.
//
// Revision 1.57  2002/09/18 09:52:54  law
// - cleanup: ������ ������� �� ������������� - ��� ��� ���� � ������.
//
// Revision 1.56  2002/09/18 09:33:26  law
// - new behavior: ��� ������ � evd-binary �������� ��� ��������� ���� �� ���������.
//
// Revision 1.55  2002/09/18 09:02:46  law
// - new behavior: ��� ������ � evd-����� �������� ��� ���� ��������� ���� �� ���������.
//
// Revision 1.54  2002/09/18 07:33:21  law
// - cleanup.
//
// Revision 1.53  2002/09/18 07:19:16  law
// - change: ������� ����� �������� ������������� ������� ������� �������.
//
// Revision 1.52  2002/09/18 07:08:02  law
// - new units: k2StackGenerator, _k2Ver.
// - new behavior: Tk2CustomReader ������ ����������� �� Tk2CustomStackGenerator � �������������� ��������� ��� ���������.
//
// Revision 1.51  2002/09/18 06:03:32  law
// - cleanup: ������ �������� IsDefault.
//
// Revision 1.50  2002/07/09 12:02:20  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.49  2002/03/26 16:31:56  law
// - cleanup.
//
// Revision 1.48  2001/10/23 15:22:34  law
// - new behavior: ������� ������ evd �� IStream.
//
// Revision 1.47  2001/10/23 10:30:51  law
// - new behavior: ���������� ��� ������ �� ������������������ ���������.
//
// Revision 1.46  2001/10/23 09:29:10  law
// - bug fix: �� �������� ��������� evd-�����.
//
// Revision 1.45  2001/10/23 08:15:15  law
// - cleanup.
//
// Revision 1.44  2001/10/15 14:59:25  law
// - new behavior: ������� ��������� ��������� endbinary.
//
// Revision 1.43  2001/08/31 08:50:07  law
// - cleanup: ������ ���� � ��������������������.
//
// Revision 1.42  2001/08/30 16:34:02  law
// - new version: ���������� �� Delphi 6.
//
// Revision 1.41  2001/07/05 13:02:56  law
// - bug fix: � ������������ � ������� �593 (��. _TestSet\VerticalMerge\5.evd).
//
// Revision 1.40  2001/05/31 11:55:28  law
// - new behavior: ������ ��� ����� ������� ������� �� ����������� exception.
//
// Revision 1.39  2001/05/31 09:23:40  law
// - cleanup: ������ ������ �� ������ ������� ����� �����.
//
// Revision 1.38  2001/05/30 13:36:34  law
// - new behavior: ������� ��������� ������ ������.
//
// Revision 1.37  2001/05/30 13:09:54  law
// - del: ������ ��������� ������� ���������� �������.
//
// Revision 1.36  2001/05/30 12:55:38  law
// - del unit: ������ ������ evEvdOldReader (������ ��������� ������ ������ ������ �������).
//
// Revision 1.35  2001/05/30 12:17:15  law
// - new behavior: ��������� ������ ��������� � ������ k2Reader.
//
// Revision 1.34  2001/05/30 09:11:18  law
// - new behavior: �������� �������������� ��������� ������ ������ ����������.
//
// Revision 1.33  2001/04/18 13:56:35  law
// - bug fix: AV ��� ������ TevTextObjectParser.
//
// Revision 1.32  2001/04/18 13:25:23  law
// - comments: ��������� ����������� ��� xHelpGen.
//
// Revision 1.31  2001/03/28 11:38:49  law
// - bug fix: ����� ��������� � ����������� ������� ������� ������ ���� ��� ��� ���������.
//
// Revision 1.30  2001/03/28 10:21:08  law
// - bug fix: ���������� ��������� ����������� ������� �������.
//
// Revision 1.29  2001/03/27 13:59:43  law
// - bug fix: ����������� ���������� ������� �������.
//
// Revision 1.28  2001/03/14 13:24:54  law
// - some cleaup and tuning.
//
// Revision 1.27  2001/01/24 14:53:43  law
// - ������� ����� ���������� ���������� ���� ������
//
// Revision 1.26  2000/12/27 09:05:44  law
// - bug fix: ������� ���� k2_tiVisible ��� ������������ � �������������� ������ � NSRC.
//
// Revision 1.25  2000/12/15 15:10:35  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  k2TagGen,

  evdReader,
  
  evTxtRd
  ;

type
  TevCustomEvdReader = class(TevdNativeReader)
   {* �������� ����� � ������� evd. }
    private
    // property fields
      f_TextParser     : TevCustomTxtReader;
    protected
    // internal methods
      procedure ReadText;
        override;
        {-}
    public    
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
    public
    // evdReader properties
      property TextParser: TevCustomTxtReader
        read f_TextParser
        write f_TextParser;
        {-}
  end;//TevCustomEvdReader

  TevEvdReader = class(TevCustomEvdReader)
   {*! �������� ����� � ������� evd (� published ����������). }
    published
      property Filer;
        {-}
      property Generator;
        {-}
      property TextParser;
        {-}
  end;//TevEvdReader

implementation

uses
  Classes,

  l3Base
  ;

// start class TevCustomEvdReader

constructor TevCustomEvdReader.Create(anOwner: Tk2TagGeneratorOwner = nil);
  //override;
  {-}
begin
 inherited;
 NotReadAsText := false;
end;

procedure TevCustomEvdReader.ReadText;
  {-}
  
 procedure ReadTextPrim(TP: TevCustomTxtReader);
 begin//ReadTextPrim
  TP.Filer := Filer;
  try
   TP.Generator := Generator;
   try
    TP.Execute;
   finally
    TP.Generator := nil;
   end;//try..finally
  finally
   TP.Filer := nil;
  end;//try..finally
 end;//ReadTextPrim

var
 TP : TevCustomTxtReader;
begin
 Filer.Seek(0, soBeginning);
 if (TextParser = nil) then
 begin
  TP := TevCustomTxtReader.Create;
  try
   ReadTextPrim(TP);
  finally
   l3Free(TP);
  end;
 end//TextParser = nil
 else
  ReadTextPrim(TextParser);
end;

end.

