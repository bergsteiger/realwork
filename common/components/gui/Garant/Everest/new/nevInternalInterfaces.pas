unit nevInternalInterfaces;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: nevInternalInterfaces - }
{ �����: 13.07.2005 20:13 }
{ $Id: nevInternalInterfaces.pas,v 1.10 2014/04/21 14:37:57 lulin Exp $ }

// $Log: nevInternalInterfaces.pas,v $
// Revision 1.10  2014/04/21 14:37:57  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.9  2008/11/13 13:09:04  dinishev
// <K> : 121156019
//
// Revision 1.8  2008/11/10 14:17:24  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=114459503&focusedCommentId=122672040#comment-122672040
//
// Revision 1.7  2008/10/28 09:50:10  dinishev
// <K> : 121156019
//
// Revision 1.6  2008/06/20 14:49:04  lulin
// - ���������� �������� ���������.
//
// Revision 1.5  2008/04/02 17:03:26  lulin
// - <K>: 88641704.
//
// Revision 1.4  2008/04/02 14:22:07  lulin
// - cleanup.
//
// Revision 1.3  2008/03/31 12:16:18  lulin
// - ������ ��������� ���������.
//
// Revision 1.2  2007/12/04 12:47:51  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.1.2.42  2007/11/28 15:52:13  dinishev
// ������������� � ����
//
// Revision 1.1.2.41  2006/12/12 09:54:35  oman
// - fix: ������� HiddenStyles c DocumentContainer �� ��������.
//   ��������� ��������/���������/d'n'd (cq12564)
//
// Revision 1.1.2.40  2006/12/11 09:55:29  oman
// - new: HiddenStyles ���������� � DocumentContainer �� �������� (cq12564)
// - new: �������� ����� ����������� ������ �� DocumentContainer
//
// Revision 1.1.2.39  2006/06/23 13:16:28  lulin
// - bg fix: �� ���� �������������� ������ ��������/�������� ������ � ������/����� ���������� �������� - � ���������� � ��������� ������ ���������� �������� ������� (CQ OIT5-19445).
//
// Revision 1.1.2.38  2006/03/01 11:28:38  lulin
// - cleanup: ����������� �� ����������� ����������.
//
// Revision 1.1.2.37  2005/12/05 09:06:22  lulin
// - ��������� ��������� ��������� ��������� ��������� � TextSource �� DocumentContainer.
//
// Revision 1.1.2.36  2005/12/03 19:44:00  lulin
// - ������ ������ �������� �������� �� �����. ������ ��� �������� ����� Waiter'��.
//
// Revision 1.1.2.35  2005/12/03 15:58:48  lulin
// - bug fix: ��������� ������� �� �����.
// - ������ ��������� ��������� ���������� ����������.
//
// Revision 1.1.2.34  2005/12/03 14:46:56  lulin
// - ����������� �� �������������� ������� TextSource � ���������� ���������.
//
// Revision 1.1.2.33  2005/12/02 22:56:26  lulin
// - ��������� ����������� �������� ����������.
//
// Revision 1.1.2.32  2005/12/02 22:50:30  lulin
// - �������� �������� ����������� TextSource �������� - ����������� ����� ������ ���������.
//
// Revision 1.1.2.31  2005/12/02 22:38:10  lulin
// - ����������� � ���������� ���������� � �������� �������� ������ ���������� ����� ���������, � �� ����� ����������� ���������.
//
// Revision 1.1.2.30  2005/12/02 18:23:33  lulin
// - �������� ������������ �� ��������/���������� ��������� ����������� ��������� ���������� �� ���������.
//
// Revision 1.1.2.29  2005/12/01 09:42:36  lulin
// - ������� ������, ��������� �� ������ ���������� ��������������.
//
// Revision 1.1.2.28  2005/12/01 08:02:40  lulin
// - cleanup: ������ ��������� ����������� ����� (� ��������� ������������ ����������) ���������� � TextSource �� DocumentContainer.
//
// Revision 1.1.2.27  2005/12/01 06:10:40  lulin
// - ��������� _preview ��������� � ����� ����� ����������.
//
// Revision 1.1.2.26  2005/12/01 05:59:24  lulin
// - cleanup: ����������� �� ��������� �������� HiddenStyles �� ��������� � ����������� � �������.
//
// Revision 1.1.2.25  2005/12/01 05:27:45  lulin
// - ����������� �� ��������� �������� ���� ��������� �� ������� Processor -> DocumentContainer -> TextSource.
//
// Revision 1.1.2.24  2005/11/15 13:50:11  lulin
// - cleanup: ���������� ������ Reader ����� - �� ����������� ��� ���� Pool. ���������� ������ �������������� ������.
//
// Revision 1.1.2.23  2005/11/15 09:44:04  lulin
// - ����� ������ ��������.
//
// Revision 1.1.2.22  2005/11/15 09:36:45  lulin
// - �� ���������� ��������� � �����������.
//
// Revision 1.1.2.21  2005/11/15 08:02:42  lulin
// - ������/������ ��������� ����������� ���������� ���������� � TextSource �� ��������� ���������.
//
// Revision 1.1.2.20  2005/11/15 05:17:31  lulin
// - ������������� ��������� Writer'� � TextSource.
//
// Revision 1.1.2.19  2005/11/14 19:05:49  lulin
// - bug fix: �� ���������������.
//
// Revision 1.1.2.18  2005/11/14 18:37:05  lulin
// - ������ ��� ������ � ����� ������ � ���� �������� ��������� ���������, � �� TextSource - ������ �������� ������ CQ OIT5-17870.
//
// Revision 1.1.2.17  2005/11/09 15:28:33  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.1.2.16  2005/10/18 07:19:43  lulin
// - new behavior: ������ ������ ������� � ���������� �������� ����� ����� ��������� ����������� ����.
//
// Revision 1.1.2.15  2005/10/10 11:43:22  lulin
// - cleanup: ���������� ���������� �� ���������� ����������.
//
// Revision 1.1.2.14  2005/10/07 09:22:16  lulin
// - bug fix: ��� ��������� ��������� ���������� ��������� �������� ����� ��������� � Sub'��.
//
// Revision 1.1.2.13  2005/09/23 16:04:04  lulin
// - ������� ������ � ������ ������������.
//
// Revision 1.1.2.12  2005/07/27 11:17:25  lulin
// - ��� ���������� ������ �������� ����������� ������ � ����������� ���������� ���������, � �� � ��� �����������.
//
// Revision 1.1.2.11  2005/07/25 18:09:20  lulin
// - ������ TextSource �� ����� ��� ���������� ���������� ���������, � ������ ��� ��� ���������.
//
// Revision 1.1.2.10  2005/07/18 10:26:15  lulin
// - ������ �������� ��������� ����.
//
// Revision 1.1.2.9  2005/07/15 12:42:01  lulin
// - ������ ��������� �������� ����� �� ��� ��������� Owner'�, � ��� ������ ���������� DocumentContainer.
//
// Revision 1.1.2.8  2005/07/15 09:30:45  lulin
// - ������ ��������� ����� ��� DocumentContainer, DocumentContainer ����� ��� TextSource, � TextSource - ����� ��� ���������.
//
// Revision 1.1.2.7  2005/07/15 09:05:36  lulin
// - new interface: InevDocumentContainer.
//
// Revision 1.1.2.6  2005/07/15 08:51:34  lulin
// - new behavior: ������ ���� � ��� �� �������� ����� ������������ � ������ ����� - ��� �������� ����� � ������������� ������������� ����� ����.
//
// Revision 1.1.2.5  2005/07/14 14:17:38  lulin
// - new behavior: ������ ���� �������� ����� ���� �������� � ���������� TextSource - �.�. ���� � �� �� ����� ��������� ����� ���� �������� � ������ ����� ����������, ������������� �� ������ ������.
//
// Revision 1.1.2.4  2005/07/14 11:20:37  lulin
// - new interface: InevTextSourcePool.
//
// Revision 1.1.2.3  2005/07/14 10:41:52  lulin
// - cleanup.
//
// Revision 1.1.2.2  2005/07/14 10:24:30  lulin
// - ���������� ���������� IevSubList ������� � TextSource, �� DocumentContainer.
//
// Revision 1.1.2.1  2005/07/14 09:07:51  lulin
// - new interface: InevTextSource.
// - new behavior: DocumentContainer ������ �� ����� �������� � TextSource, � ������ ����� ��������� InevTextSource - ��� ����� �� ����� ������ ��������� � ���������� �����.
//

{$Include nevDefine.inc }

interface

uses
  l3Types,
  l3Interfaces,
  l3Variant,
  l3Tree_TLB,
  l3InternalInterfaces,
  l3Filer,

  k2Types,
  k2Interfaces,
  k2TagGen,
  k2Reader,
  k2DocumentGenerator,

  evdStyles,
  evInternalInterfaces,

  nevBase,
  nevTools
  ;

type
  TnevFilerEvents = record
    rInd : TObject;
  end;//TnevFilerEvents

  InevTextSourceInternal = interface(InevTextSource)
    ['{44A1934F-5893-47D4-AB47-8AD1465D18EF}']
    // property methods
      function  pm_GetProgress: Il3Progress;
        {-}
    // public methods
      procedure LinkDocumentContainer(const aContainer: InevDocumentContainer);
        {-}
      procedure CheckReader(aFormat       : TnevFormat;
                            anInternal    : Boolean;
                            var theReader : Tk2CustomReader);
        {-}
      procedure CheckWriter(aFormat       : TnevFormat;
                            anInternal    : Boolean;
                            var theWriter : Tk2TagGenerator;
                            aCodePage     : Integer = CP_DefaultValue);
        {-}
      function  CheckCloseWindow: Boolean;
        {-}
      function  HandleAbortLoad: Boolean;
        {* - ������������ ���������� �������� ���������. }
      procedure Events2Filer(aFiler        : Tl3CustomFiler;
                             var theEvents : TnevFilerEvents);
        {-}
      procedure RestoreEvents(aFiler        : Tl3CustomFiler;
                              var theEvents : TnevFilerEvents);
        {-}
      procedure SetFlag(aFlag: TevUpdateWindowFlag);
        {* - ���������� ���� aFlag. }
    // public properties
      property Progress: Il3Progress
        read pm_GetProgress;
        {-}
  end;//InevTextSourceInternal

  InevTextSourcePool = interface(InevTextSourceInternal)
    ['{C6DB2F03-6977-4695-9E3E-F0BA42E82E27}']
    // public methods
      procedure LinkTextSource(const aTextSource: InevTextSourceInternal);
        {-}
      procedure UnlinkTextSource(const aTextSource: InevTextSourceInternal);
        {-}
  end;//InevTextSourcePool

  Tk2CustomReader = k2Reader.Tk2CustomReader;
  Tk2TagGenerator = k2TagGen.Tk2TagGenerator;

  InevDocumentContainerInternal = interface(InevBase)
    ['{4FA49A5A-21E1-48BB-8B8F-6B8BF8894C1F}']
    // property methods
      function  Get_InternalDocument: Tl3Tag;
        {-}
    // public methods
      procedure GetReader(aFormat        : TnevFormat;
                          const aPool    : IStream;
                          out theReader  : Tk2CustomReader;
                          anInternal     : Boolean = true;
                          aCodePage      : Integer = CP_DefaultValue;
                          const aBlock   : IUnknown = nil);
        {-}
      procedure GetWriter(aFormat             : TnevFormat;
                          anInternal          : Boolean;
                          out theWriter       : Tk2TagGenerator;
                          const aFilters      : Ik2TagGenerator;
                          aCodePage           : Integer = CP_DefaultValue);
        {-}
    // public properties
      property Document: Tl3Tag
        read Get_InternalDocument;
        {* - ��������. }
  end;//InevDocumentContainerInternal

implementation

end.

