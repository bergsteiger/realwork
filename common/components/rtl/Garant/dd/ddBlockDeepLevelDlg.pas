//..........................................................................................................................................................................................................................................................
unit ddBlockDeepLevelDlg;
{* Запрос уровня вложенности блоков в документе }

// $Id: ddBlockDeepLevelDlg.pas,v 1.10 2016/06/07 12:19:26 dinishev Exp $

// $Log: ddBlockDeepLevelDlg.pas,v $
// Revision 1.10  2016/06/07 12:19:26  dinishev
// Недокоммител.
//
// Revision 1.9  2012/08/10 09:45:56  dinishev
// {Requestlink:382408648}. Тест.
//
// Revision 1.8  2010/12/10 17:58:18  lulin
// {RequestLink:245761273}.
//
// Revision 1.7  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.6  2003/10/20 12:32:08  narry
// - новая версия автомата разбивки на блоки
//
// Revision 1.5.6.5  2003/09/24 15:29:48  narry
// - update
//
// Revision 1.5.6.3  2003/06/19 15:43:00  narry
// - update: совершенствование настройки дерева блоков документа
//
// Revision 1.5.6.2  2003/06/18 13:58:10  narry
// - update:
//
// Revision 1.5.6.1  2003/06/04 15:40:51  narry
// - not work: съезжают границы блоков, не у всех блоков есть имена
//
// Revision 1.5  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.4  2003/02/14 11:25:25  narry
// - new behavior: отключение выделения сносок в отдельный блок
//
// Revision 1.3  2002/12/20 14:03:31  narry
// - new behavior: подтверждение слияния идущих друг за другом заголовков
//
// Revision 1.2  2002/11/26 16:28:42  narry
// - update
//
// Revision 1.1  2002/10/22 12:44:23  narry
// - new behavior: расстановка блоков на заданный уровень вложенности
//

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, vtForm;

type
  TddBlockDeepLevelDialog = class(TvtForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    comboDeepLevel: TRadioGroup;
    checkConfirmJoin: TCheckBox;
    cbUseFootnotes: TCheckBox;
    cbTuneStructure: TCheckBox;
  private
    { Private declarations }
  protected
   function DefaultCloseAction : TCloseAction; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

function TddBlockDeepLevelDialog.DefaultCloseAction: TCloseAction;
begin
 Result := caHide;
end;

end.
