unit nsNewsLineSubscribersList;

// $Id: nsNewsLineSubscribersList.pas,v 1.4 2013/07/15 09:56:40 kostitsin Exp $

// $Log: nsNewsLineSubscribersList.pas,v $
// Revision 1.4  2013/07/15 09:56:40  kostitsin
// [$469808158]
//
// Revision 1.3  2011/05/18 17:45:01  lulin
// {RequestLink:266409354}.
//
// Revision 1.2  2009/02/10 14:43:25  lulin
// - <K>: 133891247. Переносим интерфейсы Прайма.
//
// Revision 1.1  2008/04/03 08:06:38  oman
// - fix: Неверная огранизация слушанья нотификации о переключении баз (cq28766)
//
//

{$Include nsDefine.inc }

interface

// <no_string>

uses
  l3Interfaces,
  l3Base,
  l3SimpleDataContainer,
  l3Types,
  l3Core,
  l3Memory,

  PrimeInterfaces
  ;

type
  {$Define l3Items_IsProto}
  _ItemType_ = InsNewsLineNotifier;
  _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
  {$Include l3InterfacePtrList.imp.pas}
  TnsNewsLineSubscribersList = class(_l3InterfacePtrList_);

implementation

uses
  SysUtils,
  Classes,
  RTLConsts,

  l3Except,
  l3MinMax
  ;

type _l3InterfacePtrList_R_ = TnsNewsLineSubscribersList;
 _Instance_R_ = TnsNewsLineSubscribersList;
{$Include l3InterfacePtrList.imp.pas}

end.
