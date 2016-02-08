unit NOT_FINISHED_pi;

// Модуль: "w:\common\components\rtl\external\MTDOrb\src\idl\NOT_FINISHED_pi.pas"
// Стереотип: "UtilityPack"

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
   procedure pre__init(const info: IORBInitInfo); virtual; abstract;
   procedure post__init(const info: IORBInitInfo); virtual; abstract;
 end;//TORBInitializer

 TInterceptor = class(TLocalORBObject)
  protected
   procedure _destroy; virtual; abstract;
   function _get__name: ANSIString; virtual; abstract;
 end;//TInterceptor

 TClientRequestInterceptor = class(TInterceptor)
  protected
   procedure send__request(const ri: IClientRequestInfo); virtual; abstract;
   procedure send__poll(const ri: IClientRequestInfo); virtual; abstract;
   procedure receive__reply(const ri: IClientRequestInfo); virtual; abstract;
   procedure receive__exception(const ri: IClientRequestInfo); virtual; abstract;
   procedure receive__other(const ri: IClientRequestInfo); virtual; abstract;
 end;//TClientRequestInterceptor
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
