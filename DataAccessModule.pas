unit DataAccessModule;

interface

uses
  System.SysUtils, System.Classes, Data.Bind.Components, Data.Bind.ObjectScope,
  Fmx.Bind.GenData, Data.Bind.GenData;

type
  TdmDataAccess = class(TDataModule)
    PrototypeBindSource1: TPrototypeBindSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDataAccess: TdmDataAccess;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
