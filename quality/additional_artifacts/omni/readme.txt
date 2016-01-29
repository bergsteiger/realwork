ƒанные файлы представл€ют собой исправленные версии исходных файлов 
реализации ORB из дистрибутива omniORB 4. ¬ них добавлена интерсепторы 
дл€ обработки IOP::ServiceContext, используемых в проекте garant pilot 
дл€ осуществлени€ авторизации и проверки прав пользователей.
–асположение файлов в оригинальном дистрибутиве:
<omni>/include/omniORB4/omniInterceptors.h
<omni>/src/lib/omniORB/orbcore/corbaOrb.cc
<omni>/src/lib/omniORB/orbcore/garantInterceptors.cc
<omni>/src/lib/omniORB/orbcore/giopImpl12.cc
<omni>/src/lib/omniORB/orbcore/dir.mk
где <omni> - корнева€ директори€ установки omniORB4.
