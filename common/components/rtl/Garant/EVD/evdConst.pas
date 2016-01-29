unit evdConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdConst.pas"
// Начат: 09.11.1999 15:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::EVD::Const
//
// Константы физического представления формата evd.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

type
 TevTypeID = (
  {* Тип данных тега. }
   ev_idChild
 , ev_idAtom
 , ev_idLong
 , ev_idString32
 , ev_idComponent
 , ev_idSInt8
 , ev_idUInt8
 , ev_idSInt16
 , ev_idUInt16
 , ev_idSInt32
 , ev_idUInt32
 , ev_idSInt64
 , ev_idUInt64
 , ev_idString8
 , ev_idString16
 , ev_idStream
 , ev_idTransparent
 , ev_idCodePage
 , ev_idFontName
 , ev_idFontID
 , ev_idShortCodePage
 );//TevTypeID

const
  { UnpackedEVD }
 unpack_idFill = 0;
  { заполнитель выравнивания. }
 unpack_idFinish = 65535;
  { закрывающая скобка тега. }
 unpack_idKey1 = $6525;
  { признак завершения бинарных данных. }
 unpack_idKey2 = $4525;
  { признак завершения бинарных данных. }
 unpack_idKey3 = $6225;
  { признак начала бинарных данных. }
 unpack_idKey4 = $4225;
  { признак начала бинарных данных. }
 unpack_idMask = unpack_idFinish - 2;
  { маска распределения памяти. }
 unpack_idChildren = unpack_idFinish - 3;
  { признак начала списка дочерних тегов. }
 unpack_idRollback = unpack_idFinish - 4;
  { признак отката тега. }
 unpack_idMaskEx = unpack_idFinish - 5;
  { расширенная маска распределения памяти. }
 unpack_idLink = unpack_idFinish - 6;
  { ссылка на объект в другом IStorage. }
 unpack_idDefaultChild = unpack_idFinish - 7;
  { дочерний тег с типом по умолчанию. }
  { PackedEVD }
 evd_pack_idFill = 0;
  { заполнитель выравнивания. }
 evd_pack_idFinish = 255;
  { закрывающая скобка тега. }
 evd_pack_idPercent = 37;
  { символ % }
 evd_pack_idSmallE = 101;
  { символ e }
 evd_pack_idCapitalE = 69;
  { символ E }
 evd_pack_idSmallB = 98;
  { символ b }
 evd_pack_idCapitalB = 66;
  { символ B }
 evd_pack_idSmallP = 112;
  { символ p }
 evd_pack_idCapitalP = 80;
  { символ P }
 evd_pack_idChildren = evd_pack_idFinish - 1;
  { признак начала списка дочерних тегов. }
 evd_pack_idRollback = evd_pack_idFinish - 2;
  { признак отката тега. }
 evd_pack_idLink = evd_pack_idFinish - 3;
  { ссылка на объект в другом IStorage. }
 evd_pack_idDefaultChild = evd_pack_idFinish - 4;
  { дочерний тег с типом по умолчанию. }

implementation

end.