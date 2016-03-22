unit NOT_FINISHED_evExcept;
 {* описание исключительных ситуаций }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evExcept.pas"
// Стереотип: "Interfaces"
// Элемент модели: "evExcept" MUID: (48452B7D0314)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
