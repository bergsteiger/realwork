// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit event_int;

interface

uses
  orb_int,code_int;

type

  ISupplierAdmin = interface;
  IConsumerAdmin = interface;
  IProxyPushConsumer = interface;
  IProxyPullConsumer = interface;
  IProxyPushSupplier = interface;
  IProxyPullSupplier = interface;

  IEventChannel = interface(IORBObject)
  ['{AF662CA2-4D2E-11d4-9D27-204C4F4F5020}']
     function for_suppliers (): ISupplierAdmin;
     function for_consumers (): IConsumerAdmin;
     procedure _destroy();
  end;

  IEventChannelFactory = interface(IORBObject)
  ['{AF662CA3-4D2E-11d4-9D27-204C4F4F5020}']
    function create_eventchannel(): IEventChannel;
  end;

  ISupplierAdmin = interface(IORBObject)
  ['{AF662CA4-4D2E-11d4-9D27-204C4F4F5020}']
    function obtain_push_consumer():IProxyPushConsumer;
    function obtain_pull_consumer():IProxyPullConsumer;
  end;

  IConsumerAdmin = interface(IORBObject)
  ['{AF662CA5-4D2E-11d4-9D27-204C4F4F5020}']
    function obtain_push_supplier():IProxyPushSupplier;
    function obtain_pull_supplier():IProxyPullSupplier;
  end;

  IPushConsumer = interface(IORBObject)
  ['{AF662CA6-4D2E-11d4-9D27-204C4F4F5020}']
     procedure push(const data: IAny);
     procedure disconnect_push_consumer();
  end;

  IPushSupplier = interface(IORBObject)
  ['{AF662CA7-4D2E-11d4-9D27-204C4F4F5020}']
    procedure disconnect_push_supplier();
  end;

  IPullConsumer = interface(IORBObject)
  ['{AF662CA8-4D2E-11d4-9D27-204C4F4F5020}']
    procedure disconnect_pull_consumer();
  end;

  IPullSupplier = interface(IORBObject)
  ['{AF662CA9-4D2E-11d4-9D27-204C4F4F5020}']
    function pull(): IAny;
    function try_pull(out has_event: Boolean): IAny;
    procedure disconnect_pull_supplier();
  end;

  IProxyPushConsumer = interface(IPushConsumer)
  ['{AF662CAA-4D2E-11d4-9D27-204C4F4F5020}']
    procedure connect_push_supplier(const sup: IPushSupplier);
  end;

  IProxyPushSupplier = interface(IPushSupplier)
  ['{AF662CAB-4D2E-11d4-9D27-204C4F4F5020}']
    procedure connect_push_consumer(const cons: IPushConsumer);
  end;

  IProxyPullConsumer = interface(IPullConsumer)
  ['{AF662CAC-4D2E-11d4-9D27-204C4F4F5020}']
    procedure connect_pull_supplier(const cons: IPullSupplier);
  end;

  IProxyPullSupplier = interface(IPullSupplier)
  ['{AF662CAE-4D2E-11d4-9D27-204C4F4F5020}']
    procedure connect_pull_consumer(const cons: IPullConsumer);
  end;

implementation

end.
