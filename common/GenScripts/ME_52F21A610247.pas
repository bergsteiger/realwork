unit GUIAppTester.imp;

interface

uses
 l3IntfUses
 , tfwScriptDebugger
 , GUITestRunner
;

type
 _GUIAppTester_ = class
  {* ������� ������ GUI-���������� }
  function CalcBatchMode: Boolean;
  procedure DoIdle(Sender: TObject;
   var Done: Boolean);
  function IsBatchMode: Boolean;
  procedure ReadyToRun;
   {* ���������� ��������������� ����� �������� ����������, �������� ��� �������������/������� ������ }
 end;//_GUIAppTester_
 
implementation

uses
 l3ImplUses
 , l3Base
 , KTestRunner
 , Forms
 , afwAnswer
 , TestFrameWork
 , l3BatchService
;

end.
