unit VCMAppTester.imp;

interface

uses
 l3IntfUses
;

type
 _VCMAppTester_ = class(_GUIAppTester_, MvcmApplication)
  {* ������� ��� ������������ ����������, ����������� �� VCM }
 end;//_VCMAppTester_
 
implementation

uses
 l3ImplUses
 , Forms
 , KTestRunner
 , l3Base
 , l3ComponentInfoHelper
 , afwAnswer
 , TestFrameWork
 , tfwScriptEngineEX
 , l3BatchService
;

end.
