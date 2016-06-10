unit MainMenuNewRes;

// Библиотека : Проект Немезис;
// Название   : MainMenuNewRes;
// Автор      : М. Морозов;
// Назначение : Ресурсы основного меню системы;
// Версия     : $Id: MainMenuNewRes.pas,v 1.3 2016/04/04 09:14:25 morozov Exp $

{-------------------------------------------------------------------------------
  $Log: MainMenuNewRes.pas,v $
  Revision 1.3  2016/04/04 09:14:25  morozov
  Добавил иконы для Миши

  Revision 1.2  2013/09/20 17:51:12  kostitsin
  [$377169452] - MainMenu и InpharmMainMenu

  Revision 1.1  2009/09/14 11:29:21  lulin
  - выводим пути и для незавершённых модулей.

  Revision 1.12  2007/04/25 10:14:30  oman  
  - fix: Вынес константу с фирменным цветом в общее место (cq25145)

  Revision 1.11  2007/03/28 11:04:54  mmorozov
  - "таблица перехода фокуса" перенесена в библиотеку визуальных компонентов проекта Немезис;

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
