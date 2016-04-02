unit atStringProvider;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringProvider.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatStringProvider" MUID: (5037CED40333)

interface

uses
 l3IntfUses
;

type
 TatStringProvider = {abstract} class(TObject)
  private
   f_Random: Boolean;
   f_Looped: Boolean;
  public
   function AcquireNext(out theString: AnsiString): Boolean; virtual; abstract;
   procedure Reset; virtual; abstract;
  public
   property Random: Boolean
    read f_Random
    write f_Random;
   property Looped: Boolean
    read f_Looped
    write f_Looped;
 end;//TatStringProvider

implementation

uses
 l3ImplUses
;

end.
