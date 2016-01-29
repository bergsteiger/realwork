unit vtCustomCommonPanel;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: vtCustomCommonPanel - }
{ Начат: 17.09.2003 21:21 }
{ $Id: vtCustomCommonPanel.pas,v 1.2 2013/01/22 15:51:48 kostitsin Exp $ }

// $Log: vtCustomCommonPanel.pas,v $
// Revision 1.2  2013/01/22 15:51:48  kostitsin
// [$424399029]
//
// Revision 1.1  2009/08/06 16:08:21  lulin
// {RequestLink:159352843}.
//
// Revision 1.1  2005/10/06 10:51:05  lulin
// - класс панелей переехал в более правильное место.
//
// Revision 1.3.18.2  2005/10/06 09:17:50  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.3.18.1  2005/05/27 14:42:21  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.3  2004/10/07 14:42:50  am
// bugfix: не хватало модуля в Uses
//
// Revision 1.2  2003/09/17 18:22:23  law
// - bug fix: синхронизируем TvtCustomPanel и TCustomPanel (не доделано).
//
// Revision 1.1  2003/09/17 18:02:47  law
// - эксперименты с основным меню и ssPanelTree.
//

{$Include vtDefine.inc }

interface

uses
  Graphics,
  
  vtPanel
  ;

type
  TvtCustomCommonPanel = class(TvtCustomPanel)
    protected
    // property methods
      function pm_GetCanvas: TCanvas;
        {-}
    protected
    // internal methods
      procedure Paint;
        reintroduce;
        virtual;
        {-}
    protected
    // internal properties
      property Canvas: TCanvas
        read pm_GetCanvas;
        {-}  
  end;//TvtCustomCommonPanel

implementation

// start class TvtCustomCommonPanel

procedure TvtCustomCommonPanel.Paint;
  //reintroduce;
  //virtual;
  {-}
begin
 inherited Paint(inherited Canvas);
end;

function TvtCustomCommonPanel.pm_GetCanvas: TCanvas;
  {-}
begin
 Result := inherited Canvas.Canvas; 
end;

end.
