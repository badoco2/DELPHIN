unit uDTMConexao;

interface

uses
  System.SysUtils, System.Classes, ZAbstractConnection, ZConnection;

type
  TDTMPrincipal = class(TDataModule)
    ConexaoDB: TZConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DTMPrincipal: TDTMPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
