unit l3AsyncTask;

// Модуль: "w:\common\components\rtl\Garant\L3\l3AsyncTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3AsyncTask" MUID: (549BC5C50174)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3AsyncTask = class(Tl3ProtoObject)
  public
   procedure Exec; virtual; abstract;
 end;//Tl3AsyncTask

implementation

uses
 l3ImplUses
;

end.
