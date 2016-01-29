unit bsChatDispatcher;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Chat"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/bsChatDispatcher.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Chat::Chat::ChatImpl::TbsChatDispatcher
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  ChatInterfaces,
  bsChatDispatcherPrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsChatDispatcher = class(TbsChatDispatcherPrim)
 public
 // public methods
   class function Make: IbsChatDispatcher; reintroduce;
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TbsChatDispatcher
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TbsChatDispatcher

var g_TbsChatDispatcher : Pointer = nil;

procedure TbsChatDispatcherFree;
begin
 IUnknown(g_TbsChatDispatcher) := nil;
end;


class function TbsChatDispatcher.Make: IbsChatDispatcher;
begin
 if (g_TbsChatDispatcher = nil) then
 begin
  l3System.AddExitProc(TbsChatDispatcherFree);
  IbsChatDispatcher(g_TbsChatDispatcher) := inherited Make;
 end;
 Result := IbsChatDispatcher(g_TbsChatDispatcher);
end;

class function TbsChatDispatcher.Exists: Boolean;
 {-}
begin
 Result := g_TbsChatDispatcher <> nil;
end;//TbsChatDispatcher.Exists

{$IfEnd} //not Admin AND not Monitorings

end.