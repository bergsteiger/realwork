unit l3ProcessMessagesManager;

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3LongintList
 , Windows
;

type
 Tl3ProcessMessagesManager = class(Tl3SimpleObject)
  {* ������ ����, ������� ���� ������������ ��������� � ������� ���������.
������������ � �������, ����� afw.ProcessMessages �������� � ���������. }
  procedure Subscribe(aHandle: THandle);
  procedure Unsubscribe(aHandle: THandle);
  procedure ProcessMessages(wMsgFilterMin: LongWord;
   wMsgFilterMax: LongWord;
   wRemoveMsg: LongWord);
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tl3ProcessMessagesManager
 
implementation

uses
 l3ImplUses
 , Forms
;

end.
