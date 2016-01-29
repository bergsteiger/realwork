unit csServerTaskTypes;

interface

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
 
implementation

uses
 l3ImplUses
;

end.
