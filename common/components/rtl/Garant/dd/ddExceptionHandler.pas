unit ddExceptionHandler;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/ddExceptionHandler.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ServiceImplementation::Class>> Shared Delphi::dd::Misc::TddExceptionHandler
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3ProtoObject,
  l3ExceptionHandler
  ;

type
 TddExceptionHandler = {final} class(Tl3ProtoObject, Il3ExceptionHandler)
 public
 // realized methods
   procedure HandleException(Sender: TObject);
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TddExceptionHandler;
    {- ���������� ��������� ����������. }
 end;//TddExceptionHandler

implementation

uses
  l3Base {a}
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;


// start class TddExceptionHandler

var g_TddExceptionHandler : TddExceptionHandler = nil;

procedure TddExceptionHandlerFree;
begin
 l3Free(g_TddExceptionHandler);
end;

class function TddExceptionHandler.Instance: TddExceptionHandler;
begin
 if (g_TddExceptionHandler = nil) then
 begin
  l3System.AddExitProc(TddExceptionHandlerFree);
  g_TddExceptionHandler := Create;
 end;
 Result := g_TddExceptionHandler;
end;


class function TddExceptionHandler.Exists: Boolean;
 {-}
begin
 Result := g_TddExceptionHandler <> nil;
end;//TddExceptionHandler.Exists

procedure TddExceptionHandler.HandleException(Sender: TObject);
//#UC START# *9B9F43B530B0_55893A8B0110_var*
//#UC END# *9B9F43B530B0_55893A8B0110_var*
begin
//#UC START# *9B9F43B530B0_55893A8B0110_impl*
 Application.HandleException(Sender);
//#UC END# *9B9F43B530B0_55893A8B0110_impl*
end;//TddExceptionHandler.HandleException

initialization
// ����������� TddExceptionHandler
 Tl3ExceptionHandler.Instance.Alien := TddExceptionHandler.Instance;

end.