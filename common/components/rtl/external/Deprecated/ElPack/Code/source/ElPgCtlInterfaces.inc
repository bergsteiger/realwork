type
  IelTabSheet = interface(IUnknown)
  {* Интерфейс закладки для взаимодействия со сторонними компонентами. }
  ['{166B4939-C252-4AAB-981D-656C0BAFA4E4}']
  // public methods
    procedure WeightChanged;
      {* - вес компонента был изменен, надо переразместить компоненты. }
  end;//IelTabSheet
