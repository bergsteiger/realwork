unit nsObjectPreview;

// $Id: nsObjectPreview.pas,v 1.1 2010/11/10 18:43:34 lulin Exp $

// $Log: nsObjectPreview.pas,v $
// Revision 1.1  2010/11/10 18:43:34  lulin
// {RequestLink:228689255}.
//
// Revision 1.2  2009/02/10 17:44:56  lulin
// - <K>: 133891247. Выделяем интерфейсы Preview.
//
// Revision 1.1  2008/08/04 12:44:20  oman
// - fix: Запрещаем область печати для встроенных объектов (K-105579231)
//
//

{$Include nsDefine.inc }

interface

uses
  PreviewInterfaces,
  nsDocumentPreview
  ;

type
  TnsObjectPreview = class(TnsDocumentPreview, InsTinyPreview)
  end;//TnsObjectPreview

implementation

end.
