unit evdDocumentFilter;
 {* Фильтр отдельных частей документа, основанный на частичной обработке тегов, накопленных в памяти.
      Для использования как предка для собственных фильтров-преобразователей. }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdDocumentFilter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdDocumentFilter" MUID: (4836BA4C03B3)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2DocumentGenerator
 //#UC START# *4836BA4C03B3intf_uses*
 //#UC END# *4836BA4C03B3intf_uses*
;

type
 //#UC START# *4836BA4C03B3ci*
 //#UC END# *4836BA4C03B3ci*
 //#UC START# *4836BA4C03B3cit*
 //#UC END# *4836BA4C03B3cit*
 TevdDocumentFilter = class(Tk2DocumentGenerator)
  {* Фильтр отдельных частей документа, основанный на частичной обработке тегов, накопленных в памяти.
      Для использования как предка для собственных фильтров-преобразователей. }
 //#UC START# *4836BA4C03B3publ*
 public
   property Generator;
 //#UC END# *4836BA4C03B3publ*
 end;//TevdDocumentFilter

implementation

uses
 l3ImplUses
 //#UC START# *4836BA4C03B3impl_uses*
 //#UC END# *4836BA4C03B3impl_uses*
;

//#UC START# *4836BA4C03B3impl*
//#UC END# *4836BA4C03B3impl*

end.
