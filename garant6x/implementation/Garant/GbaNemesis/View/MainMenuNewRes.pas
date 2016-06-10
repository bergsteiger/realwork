unit MainMenuNewRes;

// ���������� : ������ �������;
// ��������   : MainMenuNewRes;
// �����      : �. �������;
// ���������� : ������� ��������� ���� �������;
// ������     : $Id: MainMenuNewRes.pas,v 1.3 2016/04/04 09:14:25 morozov Exp $

{-------------------------------------------------------------------------------
  $Log: MainMenuNewRes.pas,v $
  Revision 1.3  2016/04/04 09:14:25  morozov
  ������� ����� ��� ����

  Revision 1.2  2013/09/20 17:51:12  kostitsin
  [$377169452] - MainMenu � InpharmMainMenu

  Revision 1.1  2009/09/14 11:29:21  lulin
  - ������� ���� � ��� ������������� �������.

  Revision 1.12  2007/04/25 10:14:30  oman  
  - fix: ����� ��������� � ��������� ������ � ����� ����� (cq25145)

  Revision 1.11  2007/03/28 11:04:54  mmorozov
  - "������� �������� ������" ���������� � ���������� ���������� ����������� ������� �������;

  Revision 1.10  2007/01/15 06:28:46  mmorozov
  - add log;

-------------------------------------------------------------------------------}

interface

uses
  SysUtils, Classes, ImgList, Controls, Graphics, vtPngImgList;

const

  /// Large icons //////////////////////////////////////////////////////////////

  cimgLawfulNavigator = 0;
  cimgInfo            = 1;
  cimgLastDocs        = 2;
  cimgSearch          = 3;
  cimgSituation       = 4;
  cimgPublish         = 5;
  cimgDiction         = 6;
  cimgPrime           = 7;
  cimgReview          = 8;
  cimgLawSupport      = 9;     

  /// Small icons //////////////////////////////////////////////////////////////

  cimgShow            = 0;
  cimgHide            = 1;

  //////////////////////////////////////////////////////////////////////////////

type
  TdmMainMenuNew = class(TDataModule)
    ilMainMenuNew: TvtPngImageList;
    ilSmallIcons: TvtPngImageList;
	   ilButtons: TvtNonFixedPngImageList;
    ilButtonsNew: TvtNonFixedPngImageList;
  end;

var
  dmMainMenuNew   : TdmMainMenuNew;

implementation

{$R *.dfm}

end.
