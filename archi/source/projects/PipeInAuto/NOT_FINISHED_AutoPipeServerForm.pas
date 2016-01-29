unit NOT_FINISHED_AutoPipeServerForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/PipeInAuto/NOT_FINISHED_AutoPipeServerForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::AutoPipeServer::TAutoPipeServerForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 TArchiServerForm = class(TForm)
 end;//TArchiServerForm

 TAutoPipeServerForm = class
 end;//TAutoPipeServerForm
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  alcuServer
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}


{$IfEnd} //AppServerSide

initialization
{$If defined(AppServerSide) AND not defined(NoScripts)}
// Регистрация TArchiServerForm
 TtfwClassRef.Register(TArchiServerForm);
{$IfEnd} //AppServerSide AND not NoScripts

end.