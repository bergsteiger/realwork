unit VCMSandBoxTestRes;

interface

uses
 l3IntfUses
 , VCMSandBoxRes
;

type
 TvcmApplicationRef = TVCMSandBoxTestRes;
  {* —сылка на приложение дл€ DesignTime редакторов }
 
 TVCMSandBoxTestRes = class(_VCMAppTester_)
  function CalcBatchMode: Boolean;
 end;//TVCMSandBoxTestRes
 
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
