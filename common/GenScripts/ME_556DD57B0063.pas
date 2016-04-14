library stg32;
 {* Библиотека поддержки плагина для FAR }

// Модуль: "w:\common\components\stg32\stg32.dpr"
// Стереотип: "AdapterTarget"
// Элемент модели: "stg32" MUID: (556DD57B0063)

{$Include w:\common\components\l3Define.inc}

uses
 l3IntfUses
 , l3ImplUses
;

exports
//#UC START# *556DD57B0063exports*
  m3PluginSupport._CoCreateInstance index $000d name 'CoCreateInstance',
  m3PluginSupport._CoInitialize     index $002d name 'CoInitialize',
  m3PluginSupport._CoTaskMemFree    index $004f name 'CoTaskMemFree',
  m3PluginSupport._CoUninitialize   index $0053 name 'CoUninitialize',
  m3PluginSupport._StgOpenStorage   index $0108 name 'StgOpenStorage'
//#UC END# *556DD57B0063exports*
;

end.
