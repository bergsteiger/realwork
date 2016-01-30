unit csIdIOHandlerAbstractAdapter;

// Модуль: "w:\common\components\rtl\Garant\cs\csIdIOHandlerAbstractAdapter.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csIdIOHandlerAbstractAdapterPrim
;

type
 TcsIdIOHandlerAbstractAdapter = {abstract} class(TcsIdIOHandlerAbstractAdapterPrim)
  public
   procedure WriteBufferOpen(AThreshhold: Integer); virtual; abstract;
   procedure WriteBufferClose; virtual; abstract;
   procedure WriteBufferClear; virtual; abstract;
   function Connected: Boolean; virtual; abstract;
   procedure WriteFile(const aFile: AnsiString); virtual; abstract;
   procedure InputBufferClear; virtual; abstract;
 end;//TcsIdIOHandlerAbstractAdapter
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
