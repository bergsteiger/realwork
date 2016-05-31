unit alcuMdpSyncIntf;

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuMdpSyncIntf.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "alcuMdpSyncIntf" MUID: (5745A26E03A8)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
;

const
 cMdpSyncVersion = 5;

type
 TmssOperation = (
  ssoAll
  , ssoNew
  , ssoDel
  , ssoUpd
 );//TmssOperation

 TOperationMap = array [TmssOperation] of AnsiString;

const
 c_mssOperationStr: TOperationMap = ('all', 'new', 'del', 'upd');

implementation

uses
 l3ImplUses
;

end.
