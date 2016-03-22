unit NOT_FINISHED_pi;

// Модуль: "w:\common\components\rtl\external\MTDOrb\src\idl\NOT_FINISHED_pi.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "pi" MUID: (4CA0D16702D5)

{$Include w:\common\components\l3Define.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , pi_int
 , orb
;

type
 TORBInitializer = class
  protected
   procedure pre_init(const info: IORBInitInfo); virtual; abstract;
   procedure post_init(const info: IORBInitInfo); virtual; abstract;
 end;//TORBInitializer

 TInterceptor = class(TLocalORBObject)
  protected
   procedure _destroy; virtual; abstract;
   function _get_name: ANSIString; virtual; abstract;
 end;//TInterceptor

 TClientRequestInterceptor = class(TInterceptor)
  protected
   procedure send_request(const ri: IClientRequestInfo); virtual; abstract;
   procedure send_poll(const ri: IClientRequestInfo); virtual; abstract;
   procedure receive_reply(const ri: IClientRequestInfo); virtual; abstract;
   procedure receive_exception(const ri: IClientRequestInfo); virtual; abstract;
   procedure receive_other(const ri: IClientRequestInfo); virtual; abstract;
 end;//TClientRequestInterceptor
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
