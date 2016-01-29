unit afwAnswer;

interface

uses
 l3IntfUses
 , l3AFWExceptions
 , l3ProtoObject
 , l3BatchService
 , l3ProtoIntegerList
 , SysUtils
;

type
 EafwTryEnterModalState = El3TryEnterModalState;
 
 TafwBatchService = class(Tl3ProtoObject, Il3BatchService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure PushAnswer(aValue: Integer);
  function CheckWasDialog: Boolean;
  procedure SignalWasDialog;
  procedure ClearAnswers;
  procedure EnterBatchMode;
  function IsBatchMode: Boolean;
  function PopAnswer: Integer;
  procedure LeaveBatchMode;
 end;//TafwBatchService
 
 TafwAnswers = class(Tl3ProtoIntegerList)
  function GetAnswer: Integer;
  procedure SetAnswer(anAnswer: Integer);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TafwAnswers
 
 EkwWaitBracketsBalance = class(Exception)
 end;//EkwWaitBracketsBalance
 
implementation

uses
 l3ImplUses
 , Controls
;

end.
