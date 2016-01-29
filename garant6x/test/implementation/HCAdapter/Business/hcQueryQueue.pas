unit hcQueryQueue;

// ���������� : ������� �������������� ��������;
// �����      : �. �������;
// ������     : $Id: hcQueryQueue.pas,v 1.3 2008/02/20 06:47:56 oman Exp $

{-------------------------------------------------------------------------------
  $Log: hcQueryQueue.pas,v $
  Revision 1.3  2008/02/20 06:47:56  oman
  �� ����������

  Revision 1.2  2008/02/06 09:04:21  oman
  �� ����������

  Revision 1.1  2007/09/04 08:07:39  mmorozov
  - new: ����������� ��������������� �������� ����� ��������� ������\����������� (CQ: OIT5-24653);

-------------------------------------------------------------------------------}

interface

{$Include hcDefine.inc}

uses
  l3Base,
  l3ObjectRefList,

  hcInterfaces
  ;

type
  ThcQueryQueueItem = class(Tl3Base)
  private
  // fields
    f_Answer : ThcAnswerType;
    f_Id     : ThcConsultationId;
    f_Time   : TDateTime;
  public
  // methods
    constructor Create(const aAnswer : ThcAnswerType;
                       const aId     : ThcConsultationId);
      reintroduce;
      {-}
  public
  // properties
    property Answer: ThcAnswerType
      read f_Answer;
      {-}
    property Id: ThcConsultationId
      read f_Id;
      {-}
    property Time: TDateTime
      read f_Time;
      {-}
  end;//ThcQueryQueueItem

  ThcQueryQueue = class(Tl3ObjectRefList)
  public
  // methods
    procedure Pop(const aAnswer : ThcAnswerType;
                  const aId     : ThcConsultationId);
      {* - �������� ������ � �������. }
    function Push(const aDelay: Integer): ThcQueryQueueItem;
      {* - ��������� ������ ����������� �������, ���� � ������� ��� ���������
           ������ ����� aDelay � �������������. }
  end;//ThcQueryQueue

implementation

uses
  SysUtils,
  DateUtils;

{ ThcQueryQueueItem }

constructor ThcQueryQueueItem.Create(const aAnswer : ThcAnswerType;
                                     const aId     : ThcConsultationId);
begin
 inherited Create;
 f_Answer := aAnswer;
 f_Id := aId;
 f_Time := Now;
end;//Create

{ ThcQueryQueue }

procedure ThcQueryQueue.Pop(const aAnswer : ThcAnswerType;
                            const aId     : ThcConsultationId);
var
 l_Class: ThcQueryQueueItem;
begin
 l_Class := ThcQueryQueueItem.Create(aAnswer, aId);
 try
  Add(l_Class);
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;//Pop

function ThcQueryQueue.Push(const aDelay: Integer): ThcQueryQueueItem;
begin
 if (Count > 0) and
  (MilliSecondsBetween(Now, ThcQueryQueueItem(Items[0]).Time) >= aDelay) then
 begin
  ThcQueryQueueItem(Items[0]).Use;
  Result := ThcQueryQueueItem(Items[0]);
  Delete(0);
 end//if (Count > 0) and
 else
  Result := nil;
end;//Push

end.
