unit evdConst;
 {*  онстанты физического представлени€ формата evd. }

// ћодуль: "w:\common\components\rtl\Garant\EVD\evdConst.pas"
// —тереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
;

const
 unpack_idFill = 0;
  {* заполнитель выравнивани€. }
 unpack_idFinish = 65535;
  {* закрывающа€ скобка тега. }
 unpack_idKey1 = $6525;
  {* признак завершени€ бинарных данных. }
 unpack_idKey2 = $4525;
  {* признак завершени€ бинарных данных. }
 unpack_idKey3 = $6225;
  {* признак начала бинарных данных. }
 unpack_idKey4 = $4225;
  {* признак начала бинарных данных. }
 unpack_idMask = unpack_idFinish - 2;
  {* маска распределени€ пам€ти. }
 unpack_idChildren = unpack_idFinish - 3;
  {* признак начала списка дочерних тегов. }
 unpack_idRollback = unpack_idFinish - 4;
  {* признак отката тега. }
 unpack_idMaskEx = unpack_idFinish - 5;
  {* расширенна€ маска распределени€ пам€ти. }
 unpack_idLink = unpack_idFinish - 6;
  {* ссылка на объект в другом IStorage. }
 unpack_idDefaultChild = unpack_idFinish - 7;
  {* дочерний тег с типом по умолчанию. }
 evd_pack_idFill = 0;
  {* заполнитель выравнивани€. }
 evd_pack_idFinish = 255;
  {* закрывающа€ скобка тега. }
 evd_pack_idPercent = 37;
  {* символ % }
 evd_pack_idSmallE = 101;
  {* символ e }
 evd_pack_idCapitalE = 69;
  {* символ E }
 evd_pack_idSmallB = 98;
  {* символ b }
 evd_pack_idCapitalB = 66;
  {* символ B }
 evd_pack_idSmallP = 112;
  {* символ p }
 evd_pack_idCapitalP = 80;
  {* символ P }
 evd_pack_idChildren = evd_pack_idFinish - 1;
  {* признак начала списка дочерних тегов. }
 evd_pack_idRollback = evd_pack_idFinish - 2;
  {* признак отката тега. }
 evd_pack_idLink = evd_pack_idFinish - 3;
  {* ссылка на объект в другом IStorage. }
 evd_pack_idDefaultChild = evd_pack_idFinish - 4;
  {* дочерний тег с типом по умолчанию. }

type
 TevTypeID = (
  {* “ип данных тега. }
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

implementation

uses
 l3ImplUses
;

end.
