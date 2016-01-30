unit NOT_FINISHED_evExcept;
 {* описание исключительных ситуаций }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evExcept.pas"
// Стереотип: "Interfaces"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
;

type
 EevLimitReached = class
 end;//EevLimitReached

 EevReadOnly = class
 end;//EevReadOnly

 EevSearchFailed = class
 end;//EevSearchFailed

 EevInvalidPrintMargins = class
 end;//EevInvalidPrintMargins

 EevNothingToPrint = class
 end;//EevNothingToPrint

 EevException = class
 end;//EevException

 EevTooLargeColumnWidth = class
 end;//EevTooLargeColumnWidth

implementation

uses
 l3ImplUses
;

end.
