unit nscTabFont;

// Библиотека : "Визуальные компоненты проекта Немезис"
// Автор      : М. Морозов
// Начат      : 07.12.2006
// Назначение : Шрифты используемые в компоненте с вкладками
// Версия     : $Id: nscTabFont.pas,v 1.1 2006/12/07 14:23:11 mmorozov Exp $

// $Log: nscTabFont.pas,v $
// Revision 1.1  2006/12/07 14:23:11  mmorozov
// - new: используем единые настройки для компонента с вкладками (CQ: OIT5-23819);
//

interface

uses
  afwFont
  ;

type
  TnscTabFont = class(TafwFont)
  {* Базовый шрифт компонента с вкладками. }
  public
  //  public methods
    constructor Create;
      override;
      {-}
  end;//TnscTabFont

  TnscActivePageFont = class(TnscTabFont)
  public
  //  public methods
    constructor Create;
      override;
      {-}
  end;//TnscActivePageFont

  TnscHotTrackFont = class(TnscTabFont)
  public
  //  public methods
    constructor Create;
      override;
      {-}
  end;//TnscHotTrackFont

implementation

uses
  Graphics
  ;

const
 c_HighlightColor = clBlue;

{ TnscTabFont }

constructor TnscTabFont.Create;
begin
 inherited;
 Name := 'Arial';
 Size := 8;
end;//Create

{ TnscActivePageFont }

constructor TnscActivePageFont.Create;
begin
 inherited;
 Color := c_HighlightColor;
end;//Create

{ TnscHotTrackFont }

constructor TnscHotTrackFont.Create;
begin
 inherited;
 Color := c_HighlightColor;
 Style := [fsUnderline];
end;

end.