program Vendas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {MENUORINCIPAL},
  uDTMConexao in 'uDTMConexao.pas' {DTMPrincipal: TDataModule},
  uTelaHeranca in 'heranca\uTelaHeranca.pas' {frmTelaHerenca},
  uCadCategoria in 'Cadastros\uCadCategoria.pas' {frmCadCategoria},
  Enter in 'terceiros\Enter.pas',
  uEnum in 'heranca\uEnum.pas',
  cCadCategoria in 'classes\cCadCategoria.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMENUORINCIPAL, MENUORINCIPAL);
  Application.Run;
end.
