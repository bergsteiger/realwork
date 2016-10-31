unit ddExceptionHandler;

// ������: "w:\common\components\rtl\Garant\dd\ddExceptionHandler.pas"
// ���������: "ServiceImplementation"
// ������� ������: "TddExceptionHandler" MUID: (55893A8B0110)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ExceptionHandler
;

type
 TddExceptionHandler = {final} class(Tl3ProtoObject, Il3ExceptionHandler)
  public
   procedure HandleException(Sender: TObject);
   class function Instance: TddExceptionHandler;
    {* ����� ��������� ���������� ���������� TddExceptionHandler }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TddExceptionHandler

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
 //#UC START# *55893A8B0110impl_uses*
 //#UC END# *55893A8B0110impl_uses*
;

var g_TddExceptionHandler: TddExceptionHandler = nil;
 {* ��������� ���������� TddExceptionHandler }

procedure TddExceptionHandlerFree;
 {* ����� ������������ ���������� ���������� TddExceptionHandler }
begin
 l3Free(g_TddExceptionHandler);
end;//TddExceptionHandlerFree

procedure TddExceptionHandler.HandleException(Sender: TObject);
//#UC START# *558923B00366_55893A8B0110_var*
//#UC END# *558923B00366_55893A8B0110_var*
begin
//#UC START# *558923B00366_55893A8B0110_impl*
 Application.HandleException(Sender);
//#UC END# *558923B00366_55893A8B0110_impl*
end;//TddExceptionHandler.HandleException

class function TddExceptionHandler.Instance: TddExceptionHandler;
 {* ����� ��������� ���������� ���������� TddExceptionHandler }
begin
 if (g_TddExceptionHandler = nil) then
 begin
  l3System.AddExitProc(TddExceptionHandlerFree);
  g_TddExceptionHandler := Create;
 end;
 Result := g_TddExceptionHandler;
end;//TddExceptionHandler.Instance

class function TddExceptionHandler.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TddExceptionHandler <> nil;
end;//TddExceptionHandler.Exists

initialization
 Tl3ExceptionHandler.Instance.Alien := TddExceptionHandler.Instance;
 {* ����������� TddExceptionHandler }

end.
