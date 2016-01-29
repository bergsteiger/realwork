unit NOT_FINISHED_pi;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "MTDOrb"
// ������: "w:/common/components/rtl/external/MTDOrb/src/idl/NOT_FINISHED_pi.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::MTDOrb::idl::pi
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

interface

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  pi_int,
  orb
  ;

type
 TORBInitializer = class
 protected
 // protected methods
   procedure Pre_init(const info: IORBInitInfo); virtual; abstract;
   procedure Post_init(const info: IORBInitInfo); virtual; abstract;
 end;//TORBInitializer

 TInterceptor = class(TLocalORBObject)
 protected
 // protected methods
   procedure _destroy; virtual; abstract;
   function _get_name: ANSIString; virtual; abstract;
 end;//TInterceptor

 TClientRequestInterceptor = class(TInterceptor)
 protected
 // protected methods
   procedure Send_request(const ri: IClientRequestInfo); virtual; abstract;
   procedure Send_poll(const ri: IClientRequestInfo); virtual; abstract;
   procedure Receive_reply(const ri: IClientRequestInfo); virtual; abstract;
   procedure Receive_exception(const ri: IClientRequestInfo); virtual; abstract;
   procedure Receive_other(const ri: IClientRequestInfo); virtual; abstract;
 end;//TClientRequestInterceptor
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

implementation

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
end.