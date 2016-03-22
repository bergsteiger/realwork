unit NOT_FINISHED_csServerTaskTypes;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csServerTaskTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csServerTaskTypes" MUID: (52FA591401FA)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csDictEditQueryPrim
 , csDeleteDocsQueryPrim
 , csRemoteDictEditQueryPrim
 , csUserEditQueryPrim
 , ddRunCommandTaskPrim
;

type
 TDictEditQuery = class(TcsDictEditQueryPrim)
 end;//TDictEditQuery

 TGetDictEditQuery = class(TDictEditQuery)
 end;//TGetDictEditQuery

 TDeleteDocsQuery = class(TcsDeleteDocsQueryPrim)
 end;//TDeleteDocsQuery

 TRemoteDictEditQuery = class(TcsRemoteDictEditQueryPrim)
 end;//TRemoteDictEditQuery

 TUserEditQuery = class(TcsUserEditQueryPrim)
 end;//TUserEditQuery

 TddRunCommandTask = class(TddRunCommandTaskPrim)
 end;//TddRunCommandTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
