unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter;

type
  TMENUORINCIPAL = class(TForm)
    Menu: TMainMenu;
    C1: TMenuItem;
    MOVIMENTAO1: TMenuItem;
    RELATORIO1: TMenuItem;
    CLIENTE1: TMenuItem;
    N1: TMenuItem;
    PRODUTO1: TMenuItem;
    N2: TMenuItem;
    FECHAR1: TMenuItem;
    N3: TMenuItem;
    procedure FECHAR1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    TeclaEnter: TMREnter;
  public
    { Public declarations }
  end;

var
  MENUORINCIPAL: TMENUORINCIPAL;

implementation

{$R *.dfm}

uses uCadCategoria;

procedure TMENUORINCIPAL.FECHAR1Click(Sender: TObject);
begin
        close;
        FreeAndNil(TeclaEnter);
        FreeAndNil(DTMPrincipal);
end;

procedure TMENUORINCIPAL.FormCreate(Sender: TObject);
begin
  {
  DTMPrincipal := TDTMPrincipal.Create(self);
  DTMPrincipal.ConexaoDB.SQLHourGlass:=True;
  DTMPrincipal.ConexaoDB.Protocol := 'mssql';
  DTMPrincipal.ConexaoDB.LibraryLocation := 'C:\Users\alexa\Documents\Delphin\VendasSistema\ntwdblib.dll';
  DTMPrincipal.ConexaoDB.HostName := '.\SERVECURSO';
  DTMPrincipal.ConexaoDB.Port := 1433;
  DTMPrincipal.ConexaoDB.Database := 'VENDAS';
  DTMPrincipal.ConexaoDB.User := 'sa';
  DTMPrincipal.ConexaoDB.Password := 'aeade';
  DTMPrincipal.ConexaoDB.Connected:= true;
  }

  DTMPrincipal := TDTMPrincipal.Create(self);
  with DTMPrincipal.ConexaoDB do begin
    SQLHourGlass:=True;
    Protocol := 'mssql';
    LibraryLocation := 'C:\Users\alexa\Documents\Delphin\VendasSistema\ntwdblib.dll';
    HostName := '.\SERVECURSO';
    Port := 1433;
    Database := 'VENDAS';
    User := 'sa';
    Password := 'aeade';
    Connected:= true;
  end;

  TeclaEnter := TMREnter.Create(self);
  TeclaEnter.FocusEnabled:=true;
  TeclaEnter.FocusColor:=clinfoBk
end;

procedure TMENUORINCIPAL.N1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;

end;

end.
