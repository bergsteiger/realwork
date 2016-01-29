unit D_TxSrch_Intf;

// Интерфейс для диалога поиска

{ $Id: D_TxSrch_Intf.pas,v 1.5 2013/04/19 13:06:19 lulin Exp $}

// $Log: D_TxSrch_Intf.pas,v $
// Revision 1.5  2013/04/19 13:06:19  lulin
// - портируем.
//
// Revision 1.4  2007/12/03 09:47:46  dinishev
// Используем редактор из ветки
//
// Revision 1.3  2005/05/16 11:43:13  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.2  2004/11/30 09:41:06  fireton
// - рефакторинг диалога поиска
//

interface

uses
 nevTools,
 evInternalInterfaces
 ;

type
 ISearchDlgOperations = interface(IUnknown)
 ['{172CEC44-F15A-47DD-8394-27A5F8FAF2E8}']
  function  SubReplaceFunc(const aBlock   : InevRange;
                           aSubNumFormula : AnsiString;
                           aWithConfirm   : Boolean) : ShortInt;
 end;

implementation

end.
